Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E6511D72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiD0QzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbiD0QzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:55:05 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD3480C92;
        Wed, 27 Apr 2022 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=qPV3GAutYS1USEKN2DLYVcHIf/3CMspob9f64O94K9s=; b=tYsy3EBGWgOHTFK2epLpskbkim
        NoLL0yo6mR70L1KzhaQ3sM3DHIifX2jjI56LneTbkuYwPZUYrn7bIWLQ9UA2prF5NPNxANy3QK4dN
        IZ2WXIaJfOrzQ/FqFc0ziPv3iInuIn1I3BIgR2KppRk4tCywZWla/Mb3lxeqs14PhddwQ88fJ0UST
        Q85sKcJKFFY727t1MxzB0XKn5DaoDV2LF0y2sQXfzpptFEFj+63y3edwfw4fe0eZjm/ORTXQZxFQV
        eB/Q3I9W0DiZXP4ogozcnYUZ1kGbDaCyP5Fc1QSAiQkESqy9CJpiRGXSD3BIwVWtMJaeO6pBJcVey
        Yv/BJnbw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1njkDE-000K8u-Lb; Wed, 27 Apr 2022 10:08:21 -0600
Message-ID: <7db3cc87-c491-1ba4-d778-1c7dbbf34c47@deltatee.com>
Date:   Wed, 27 Apr 2022 10:08:20 -0600
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
 <20220420195425.34911-3-logang@deltatee.com>
 <eb1d70f6-0cfc-20e9-8fb3-84e3076025f7@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <eb1d70f6-0cfc-20e9-8fb3-84e3076025f7@linux.dev>
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
Subject: Re: [PATCH v2 02/12] md/raid5: Refactor raid5_make_request loop
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-26 19:32, Guoqing Jiang wrote:
> 
> 
> On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
>> Break immediately if raid5_get_active_stripe() returns NULL and deindent
>> the rest of the loop. Annotate this check with an unlikely().
>>
>> This makes the code easier to read and reduces the indentation level.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
>> ---
>>   drivers/md/raid5.c | 109 +++++++++++++++++++++++----------------------
>>   1 file changed, 55 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 97b23c18402b..cda6857e6207 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -5906,68 +5906,69 @@ static bool raid5_make_request(struct mddev
>> *mddev, struct bio * bi)
> 
> ...
> 
>> +        if (unlikely(!sh)) {
>> +            /* cannot get stripe, just give-up */
>> +            bi->bi_status = BLK_STS_IOERR;
>> +            break;
>> +        }
> 
> 
> Nit, I would suggest to keep below original comment.

But the original comment was plainly wrong...

Logan
