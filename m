Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98054865BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiAFOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbiAFOBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:01:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F339DC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 06:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E37A61C3D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B99C36AE3;
        Thu,  6 Jan 2022 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641477708;
        bh=LnhcNm2woC798UYuUxRQnM+UQkBAfsqI/F0kZU392K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLzUFTW3qiEI4/gtlhZxkE3ALcpStfnFvDFyLab7sjbb77kWohSZ3VqifA28Ztfkm
         jKkdVAOI6zNuFwASw/6NbmrGGlO9rAy+95kFzISKA3FDxe5j2gecx99Z8w4/RKlXmA
         kNtYk3dPxr/lH07D7DWHOqv88f+9w39M2sJ1iwl8=
Date:   Thu, 6 Jan 2022 15:01:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     knv418@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: kpc2000_spi: Check for null pointer
 after calling devm_ioremap
Message-ID: <Ydb2SLUZ25skxLZd@kroah.com>
References: <20220106092257.2738018-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106092257.2738018-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:22:57PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, the devm_ioremap() may return
> NULL pointer.
> Then the kpspi->base is assigned to cs->base in kp_spi_setup() and used
> in kp_spi_read_reg() and kp_spi_write_reg().
> Therefore, it should be better to add the sanity check and return error
> in order to avoid the dereference of the NULL pointer.
> 
> Fixes: 677b993a5749 ("staging: kpc2000: kpc_spi: use devm_* API to manage mapped I/O space")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 16ca18b8aa15..ead4aa0c988c 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -466,6 +466,10 @@ kp_spi_probe(struct platform_device *pldev)
>  
>  	kpspi->base = devm_ioremap(&pldev->dev, r->start,
>  				   resource_size(r));
> +	if (!kpspi->base) {
> +		status = -ENOMEM;
> +		goto free_master;
> +	}
>  
>  	status = spi_register_master(master);
>  	if (status < 0) {
> -- 
> 2.25.1
> 
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
