Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D18484121
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiADLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiADLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:45:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2D0DB811B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD736C36AEB;
        Tue,  4 Jan 2022 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641296723;
        bh=OjmCtQawcctQiZ21IWoYsN9cVaxw1/uhtFEXeDAA0nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5bxcUvuHpyud9T+bvWlCkQgUrrK8zwuMlNdBsK55QBQickhdjvYNRw8z8CYGGKB3
         C1l9REJQSyJdRIt2WWsdP4n/ncFId4/v1+vF8ZiQkdTkQ8TDJLzPmtAc+kaP16muIA
         8yaesxWnqF66dsF5z3DFtxb2rdgIT+Lwc+Ny4rys=
Date:   Tue, 4 Jan 2022 12:45:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     ogabbay@kernel.org, arnd@arndb.de, ynudelman@habana.ai,
        obitton@habana.ai, osharabi@habana.ai, chi.minghao@zte.com.cn,
        fkassabri@habana.ai, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH misc-next] drivers/misc: remove redundant rc variable
Message-ID: <YdQzUPW5FI0yIi0P@kroah.com>
References: <20220104113411.602094-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104113411.602094-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:34:11AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ocxl_context_attach() directly instead
> of taking this in another redundant variable.

Why?  Does this change the compiler output?

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/misc/ocxl/file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index e70525eedaae..d881f5e40ad9 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -74,7 +74,6 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>  {
>  	struct ocxl_ioctl_attach arg;
>  	u64 amr = 0;
> -	int rc;
>  
>  	pr_debug("%s for context %d\n", __func__, ctx->pasid);
>  
> @@ -86,8 +85,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>  		return -EINVAL;
>  
>  	amr = arg.amr & mfspr(SPRN_UAMOR);
> -	rc = ocxl_context_attach(ctx, amr, current->mm);
> -	return rc;
> +	return ocxl_context_attach(ctx, amr, current->mm);
>  }
>  
>  static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> -- 
> 2.25.1
> 

How did you test this change?

thanks,

greg k-h
