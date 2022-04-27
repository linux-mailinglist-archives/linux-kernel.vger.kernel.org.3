Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9145511F87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiD0QRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiD0QPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:15:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7345AAB8;
        Wed, 27 Apr 2022 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=gRRhOj8clhoH6+uFPZPq6FKVuwIU2733V3ei3eBIRbg=; b=Oq819TCDeE6yL49nBZVyUsKifS
        aA4DAOIzEvh8tNIfGAThXAwWn/6NCXpzPFH0BJmHsXT+RGIxV3R+Zz2kSyG9kcTM+nYg/9cAtBQnQ
        Iyb8GTTxHJlwDqLO8fxgTawTJJc1fFttGgX8QV+eWVsDsy+SbClTkmOzd064qMqG9x4ZFpa1IW/GS
        Y8CoOz9ZhU0CfLLmHVQyk0cvs42TjS7vM0k0Lm/66hxsj3rTiCsSzExqiME1LCJGDNuw7x5awL5hQ
        e8B6Y8NAdGV/XB+Rd/C1bmLwAIUQCd8ia9/R8JGeMM5uxEStuolnpIHBlpm6kCro5ceJ6WnJ+1lZo
        YnQzoXmQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1njkG2-000KCB-1s; Wed, 27 Apr 2022 10:11:14 -0600
Message-ID: <78b4b92f-ae89-2e54-f96f-21d338ca042b@deltatee.com>
Date:   Wed, 27 Apr 2022 10:11:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-12-logang@deltatee.com>
 <7f61aacd-d378-092c-1291-f2aaf42a5537@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <7f61aacd-d378-092c-1291-f2aaf42a5537@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 11/12] md/raid5: Check all disks in a stripe_head for
 reshape progress
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-26 19:53, Guoqing Jiang wrote:
>> +static bool stripe_ahead_of_reshape(struct mddev *mddev, struct
>> r5conf *conf,
>> +                    struct stripe_head *sh)
>> +{
>> +    sector_t max_sector = 0, min_sector = MaxSector;
>> +    bool ret = false;
>> +    int dd_idx;
>> +
>> +    for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
>> +        if (dd_idx == sh->pd_idx)
>> +            continue;
>> +
>> +        min_sector = min(min_sector, sh->dev[dd_idx].sector);
>> +        max_sector = min(max_sector, sh->dev[dd_idx].sector);
>> +    }
>> +
>> +    spin_lock_irq(&conf->device_lock);
>> +
>> +    if (!range_ahead_of_reshape(mddev, min_sector, max_sector,
>> +                     conf->reshape_progress))
>> +        /* mismatch, need to try again */
>> +        ret = true;
> 
> I think we can just open code range_ahead_of_reshape.

I think this way is much easier to read. GCC is much

> And seems the above is not same as below original checking which compare
> logical_sector with reshape_progress. Is it intentional or am I miss
> something?

Yes, this was intentional, the change is necessary for the next patch to
ensure that all pages in a stripe are ahead of the reshape. This was not
intended as just a cleanup patch.

Logan
