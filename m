Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6854A8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiFNFif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbiFNFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:38:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA0D2B26C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8750BB81649
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09168C3411B;
        Tue, 14 Jun 2022 05:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655185107;
        bh=TUhaPG/zxoBGFQdav+4Zj5v/KaSlZdbKvwElcae+ekM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRRynFCKlFafYnFV+FXpS5mPmjmy9RbNBZIUudNs33AxblZJIL3y/AITp9ILp48mS
         h+gQHIe1pnbh6so8jxUOGl+g2NLM32vBs8Abet1BoL/7FebxtRtxs31XcYKznjzbUn
         MVC/LOgyDSEKZXlSvDySRxmj58gTLtMWugNCXjEcoDTl6+zxwyWbWiZc7PUJjNHysi
         ZNXPAcJPUIjO3vANraA3A4bExaGTvuUXDbjOXeXBI7Yv3v2NVRJ9LTJyV/8jLxgkBh
         14UjGCW8T5dGbC/czXUGtUV9ygaqQ4sm9a0w7/97E9FQT6R68r1ybSrSavHuRB23L1
         8FlXJP2qnIr8Q==
Date:   Mon, 13 Jun 2022 22:38:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH] f2fs: handle decompress only post processing in softirq
Message-ID: <Yqge0XS7jbSnNWvq@sol.localdomain>
References: <20220613155612.402297-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613155612.402297-1-daeho43@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Nathan Huckleberry who is looking into a similar problem in dm-verity]

On Mon, Jun 13, 2022 at 08:56:12AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now decompression is being handled in workqueue and it makes read I/O
> latency non-deterministic, because of the non-deterministic scheduling
> nature of workqueues. So, I made it handled in softirq context only if
> possible.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/compress.c | 145 +++++++++++++++++++++++++--------------------
>  fs/f2fs/data.c     |  50 ++++++++++------
>  fs/f2fs/f2fs.h     |  10 ++--
>  3 files changed, 119 insertions(+), 86 deletions(-)
[...]
>  static void f2fs_read_end_io(struct bio *bio)
> @@ -281,16 +283,28 @@ static void f2fs_read_end_io(struct bio *bio)
>  	}
>  
>  	if (bio->bi_status) {
> -		f2fs_finish_read_bio(bio);
> +		f2fs_finish_read_bio(bio, true);
>  		return;
>  	}
>  
> -	if (ctx && (ctx->enabled_steps & (STEP_DECRYPT | STEP_DECOMPRESS))) {
> -		INIT_WORK(&ctx->work, f2fs_post_read_work);
> -		queue_work(ctx->sbi->post_read_wq, &ctx->work);
> -	} else {
> -		f2fs_verify_and_finish_bio(bio);
> +	if (ctx) {
> +		unsigned int enabled_steps = ctx->enabled_steps &
> +					(STEP_DECRYPT | STEP_DECOMPRESS);
> +
> +		/*
> +		 * If we have only decompression step between decompression and
> +		 * decrypt, we don't need post processing for this.
> +		 */
> +		if (enabled_steps == STEP_DECOMPRESS) {
> +			f2fs_handle_step_decompress(ctx, true);

One question: is this (the bio endio callback) actually guaranteed to be
executed from a softirq?  If you look at dm-crypt's support for workqueue-less
decryption, for example, it explicitly checks 'in_hardirq() || irqs_disabled()'
and schedules a tasklet if either of those is the case.

- Eric
