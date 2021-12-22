Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0347CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbhLVGK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbhLVGKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:10:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D8C06173F;
        Tue, 21 Dec 2021 22:10:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB91261862;
        Wed, 22 Dec 2021 06:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69D7C36AE5;
        Wed, 22 Dec 2021 06:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640153449;
        bh=PRueReowiqN/glmJ/igdfzlq6ZtCOukzZLZI+1fvlK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDImUZXPVtH54GwI2E27kxhwJ/V8B4JXrtkWT8/7SDL2CXlqrlVJb4mbSh+N+pf+9
         UoXrDkf0eZM02Q4twUtaqyUjkzGFzkB4nUas32xL0iGQdSaaK7Ii8KDEJBc6GhDSF1
         MFtNSRToXv619JdkHgTgCxH4n0KYT+24q/z5L004=
Date:   Wed, 22 Dec 2021 07:10:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] usb: renesas_usbhs: Fix unused variable warning
Message-ID: <YcLBZBwIZkhhKxGD@kroah.com>
References: <20211221171532.29881-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221171532.29881-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:15:32PM +0000, Lad Prabhakar wrote:
> This patch fixes the below warning:
> 
> drivers/usb/renesas_usbhs/mod.c: In function 'usbhs_status_get_each_irq':
> drivers/usb/renesas_usbhs/mod.c:195:13: warning: variable 'intenb0'
> set but not used [-Wunused-but-set-variable]
>   195 |         u16 intenb0, intenb1;
>       |
> 
> Fixes: 33e4245ee919 ("usb: renesas_usbhs: Use platform_get_irq() to get the interrupt")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/usb/renesas_usbhs/mod.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
> index f2ea3e1412d2..3919e350b487 100644
> --- a/drivers/usb/renesas_usbhs/mod.c
> +++ b/drivers/usb/renesas_usbhs/mod.c
> @@ -192,13 +192,12 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
>  				     struct usbhs_irq_state *state)
>  {
>  	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> -	u16 intenb0, intenb1;
>  	unsigned long flags;
> +	u16 intenb1;
>  
>  	/********************  spin lock ********************/
>  	usbhs_lock(priv, flags);
>  	state->intsts0 = usbhs_read(priv, INTSTS0);
> -	intenb0 = usbhs_read(priv, INTENB0);

Did you just break the hardware?  Reading is often times needed and
clang has no idea about hardware issues.  We need proof in the changlog
that this really is safe to do.

How did you test your change?

thanks,

greg k-h
