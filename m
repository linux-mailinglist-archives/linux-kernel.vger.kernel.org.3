Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F6952C656
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiERWff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiERWfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009341FD876
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89DAC6167D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6802C385A5;
        Wed, 18 May 2022 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652913331;
        bh=JsNUGeYCd9jl73VaIgc6JuqYsiBSisQYXVe0o/Ol3wg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KRV9qLcS8wCMGeqf4/VCUWDoXMQvZqsQNGFoU8yhXC7DAs7tO5jVMRSwU3X24XB3m
         viK843eqIrxzcULosTdfEHqYfFuPDc8SnE6eP8q0A/STIAuq5l9VpWLKpAPrUDzTbX
         jH/QIdoL31KWjFbEfmJp5TUUyz5MoHOx06bJEIUoRbBLs+9RgQAnxw/ylkL2qbTa7k
         umDIundqGtIhM+IoO6gFT7CdZIkLqaarONAMVYdrt9R/tHAOJiv+j3Nb91XjTZtNSU
         TipO4kOkEyBi4+8ExPY2+A+20jbb39HUbezHHDazLgw4JVz0GQFeieoGmJTJ6LVwxc
         pyXk4SvcilYzw==
Date:   Wed, 18 May 2022 15:35:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: decompress data without workqueue
Message-ID: <YoV0sm9W+2A644PZ@google.com>
References: <20220518175547.3284875-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518175547.3284875-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please hold any test, since this patch has a bug.

On 05/18, Jaegeuk Kim wrote:
> Let's decompress data under the same context to avoid workqueue delay.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 54a7a8ad994d..37aa7ac5d463 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -285,10 +285,12 @@ static void f2fs_read_end_io(struct bio *bio)
>  		return;
>  	}
>  
> -	if (ctx && (ctx->enabled_steps & (STEP_DECRYPT | STEP_DECOMPRESS))) {
> +	if (ctx && (ctx->enabled_steps & STEP_DECRYPT)) {
>  		INIT_WORK(&ctx->work, f2fs_post_read_work);
>  		queue_work(ctx->sbi->post_read_wq, &ctx->work);
>  	} else {
> +		if (ctx && (ctx->enabled_steps & STEP_DECOMPRESS))
> +			f2fs_handle_step_decompress(ctx);
>  		f2fs_verify_and_finish_bio(bio);
>  	}
>  }
> -- 
> 2.36.1.124.g0e6072fb45-goog
