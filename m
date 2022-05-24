Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21580532DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiEXP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiEXPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:55:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BD98096;
        Tue, 24 May 2022 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=qMEBoG8lqFJvGve+K5m+z9fgN9hILK6ZisKxqQim1eM=; b=XFlcW/TpHW8e5ACmg+/YYTcud5
        kFsXafcr7Cytf6qeJfc86HtV/G4yR5wGWRknuahG3h9Cx3mrMXB2ncbMui7tvMx+kliUcfOIQMtGI
        ICGsOv6+XQyTAltzLG9aU+SDiIK83MgM6wdqtVo9hC1dnhncrRZF5Vr3QAiLVtU3kyeDbbRebGkQo
        BBvxRnls9jKK7VVfkPrVuwZbgT5poxyEkZ5cx7ZQZY3IPMsuVVd43VAnSk+bqIr2sjcA72ZoQGpAb
        3YBFrW/iRUAccGkbMIDLQkrx+kkEqVFGXnUtuvSPzopL3VddTeq99Cq7eI8Z+bdaiY74HxQfME4c3
        tbepAB8w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ntWsy-006R7q-R4; Tue, 24 May 2022 09:55:54 -0600
Message-ID: <c22de8df-0599-0a86-146a-267f576f5500@deltatee.com>
Date:   Tue, 24 May 2022 09:55:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Donald Buczek <buczek@molgen.mpg.de>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-13-logang@deltatee.com>
 <571344e2-6e43-a72f-bd12-04d650e669fd@molgen.mpg.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <571344e2-6e43-a72f-bd12-04d650e669fd@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: buczek@molgen.mpg.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log
 accesses
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-22 01:32, Donald Buczek wrote:
>>   /*
>> @@ -703,7 +720,7 @@ static void r5c_disable_writeback_async(struct work_struct *work)
>>   
>>   	/* wait superblock change before suspend */
>>   	wait_event(mddev->sb_wait,
>> -		   conf->log == NULL ||
>> +		   rcu_access_pointer(conf->log) ||
> 
> Reversed condition?
> 
> I think, some examples in Documentation/RCU/Design/Requirements/Requirements.rst are reversed, too.

Oops. Nice Catch!

Thanks,

Logan
