Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C450A4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390346AbiDUP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390336AbiDUP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:57:18 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6983D47392;
        Thu, 21 Apr 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=hkyKr8j3OxoBTrWwgPc9PNlCF0d6AYPRaEfu+FOjftE=; b=MxidANs+F8ZM87gae7J2FlSgNz
        toNb4BaJOpSIR3tZFT+xC1oEd/EUUR+yK+aXWaA1WGGuq4zTdwS0AIdiKn0O0DsThCLmTbE+nFMFE
        Xi1lFdCOuq6GPZN421PH28ueyFgv924JEE5k7xHrwWU9WMV3sAd+fX+EFO7vOnG25U1Ncj4T8ZORD
        RCvaGgFMaID4kWKIetXn6MwollYxbUAeymnKxDjTFEHWJmCWVhXifu0fd1hUDRthhuHGZylFRoLPQ
        KyfDEIiua8v3we7KGrPIx+bdid2CZD0K0tDaWi27RBPiv3fEsNuKa3dMIPPgOZuew1PVuIUMBWOUw
        iDoe2QUw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nhZ8U-00DB5J-L7; Thu, 21 Apr 2022 09:54:27 -0600
Message-ID: <d49e2bb9-c7ae-8192-dbca-5c0a0e18359c@deltatee.com>
Date:   Thu, 21 Apr 2022 09:54:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-13-logang@deltatee.com>
 <YmD9KBJtOjV+J5We@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YmD9KBJtOjV+J5We@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 12/12] md/raid5: Pivot raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-21 00:43, Christoph Hellwig wrote:
> On Wed, Apr 20, 2022 at 01:54:25PM -0600, Logan Gunthorpe wrote:
>>  struct stripe_request_ctx {
>>  	bool do_flush;
>>  	struct stripe_head *batch_last;
>> +	sector_t disk_sector_done;
>> +	sector_t start_disk_sector;
> 
> Very nitpicky, but why use two different naming styles for the sectors
> here?
> 
>> +	bool first_wrap;
>> +	sector_t last_sector;
> 
> And especially with the last_sector here a few comments explaining
> what each of the sector values mean might be useful.
> 
> I'd also keep the two bool variables together for a better structure
> layout.

Yeah, this logic has been very tricky to figure out. Thus explaining it
was quite difficult. It was a consistent source of bugs for a me for a
while until I figured out this little state machine. I'll follow your
rough template and rework the comments and try to make a large example
comment or something to explain this, and maybe factor it into a helper
function.

>> +	 * if new_sector is less than the starting sector. Clear the
>> +	 * boolean once the start sector is hit for the second time.
>> +	 * When first_wrap is set, ignore the disk_sector_done.
>> +	 */
>> +	if (ctx->start_disk_sector == MaxSector) {
>> +		ctx->start_disk_sector = new_sector;
>> +	} else if (new_sector < ctx->start_disk_sector) {
>> +		ctx->first_wrap = true;
>> +	} else if (new_sector == ctx->start_disk_sector) {
>> +		ctx->first_wrap = false;
>> +		ctx->start_disk_sector = 0;
>> +		return STRIPE_SUCCESS;
>> +	} else if (!ctx->first_wrap && new_sector <= ctx->disk_sector_done) {
>> +		return STRIPE_SUCCESS;
>> +	}
>> +
> 
> I find this a bit confusing to read.  While trying to mentally untangle
> it I came up with this version instead, but it could really use some
> good comments explaining each of the checks as I found your big comment
> to not quite match the logic easily.
> 
> 	if (ctx->start_disk_sector == MaxSector) {
> 		/*
> 		 * First loop iteration, start our state machine.
> 		 * 
> 		ctx->start_disk_sector = new_sector;
> 	} else {
> 		/*
> 		 * We are done if we wrapped around to the same sector.
> 		 * (???)
> 		 */
> 		if (new_sector == ctx->start_disk_sector) {
> 			ctx->first_wrap = false;
> 			ctx->start_disk_sector = 0;
> 			return STRIPE_SUCCESS;
> 		}
> 
> 		/*
> 		 * Sector before the start sector?  Keep going and wrap
> 		 * around.
> 		 */
> 		if (new_sector < ctx->start_disk_sector) {
> 			ctx->first_wrap = true;
> 		} else {
> 			// ???

This is actually the common most important branch that says if we've
already done this disk sector to stop and move on. So I'll probably
rework it some so that it is not so deeply nested.

> 			if (new_sector <= ctx->disk_sector_done &&
> 			   !ctx->first_wrap)
> 				return STRIPE_SUCCESS;
> 		}
> 	}

No problem cleaning up your other nits. I'll send a v3 in due course.

Thanks,

Logan
