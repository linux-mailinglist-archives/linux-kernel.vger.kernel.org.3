Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A108510EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357115AbiD0CRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357110AbiD0CRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:17:01 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910A473B7;
        Tue, 26 Apr 2022 19:13:50 -0700 (PDT)
Subject: Re: [PATCH v2 07/12] md/raid5: Move read_seqcount_begin() into
 make_stripe_request()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651025629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2xxD/UOrCwcfRcymrANttST8OfMS/lxc0RTJxuLv7U=;
        b=q8rl6r5keh8Ll98PxBzf/J9kDfoWOpKZu/P1ao1Cj8QMtSR0KYZlLJlyeu6Uc5k+1Glm0h
        ay5GUedLr1sUWQeMccoHDbRzFbL9U0SBpksbI5JwuMnjKxBbbGbrad2WkketH/pOx9IJJT
        5ZTU2w2T/AlGL5LmdnR8buOz5XeEsN8=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-8-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <3c8cc5d5-140e-3d9b-ea70-e1a3ce8513e4@linux.dev>
Date:   Wed, 27 Apr 2022 10:13:43 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
> Now that prepare_to_wait() isn't in the way, move read_sequcount_begin()
> into make_stripe_request().
>
> No functional changes intended.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index b9f618356446..1bce9075e165 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5804,13 +5804,15 @@ struct stripe_request_ctx {
>   
>   static enum stripe_result make_stripe_request(struct mddev *mddev,
>   		struct r5conf *conf, struct stripe_request_ctx *ctx,
> -		sector_t logical_sector, struct bio *bi, int seq)
> +		sector_t logical_sector, struct bio *bi)
>   {
>   	const int rw = bio_data_dir(bi);
>   	struct stripe_head *sh;
>   	sector_t new_sector;
>   	int previous = 0;
> -	int dd_idx;
> +	int seq, dd_idx;
> +
> +	seq = read_seqcount_begin(&conf->gen_lock);
>   
>   	if (unlikely(conf->reshape_progress != MaxSector)) {
>   		/* spinlock is needed as reshape_progress may be
> @@ -5970,13 +5972,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   	md_account_bio(mddev, &bi);
>   	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
>   	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
> -		int seq;
> -
>   	retry:
> -		seq = read_seqcount_begin(&conf->gen_lock);
> -
>   		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
> -					  bi, seq);
> +					  bi);
>   		if (res == STRIPE_FAIL) {
>   			break;
>   		} else if (res == STRIPE_RETRY) {

Reviewed-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
