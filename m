Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99594A9ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359263AbiBDOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiBDOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E3C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A97CEB83065
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE70C340E9;
        Fri,  4 Feb 2022 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643984616;
        bh=lfy7vJioDybXdR7wJftnkVwV2ISJao8GP2gpwcbuuDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+mGhZ9+A2O8dRNg9jsF7KdtrrKZQJpW1woDpMdTJwOSJNYJpwQeixtCCsXpuSt3e
         K4QKJK0UMWNkB1GxozNwMBMIucRnzCj+jUXx/iPv42DRksA0+GtLpgDh0FJ/0Qr2qQ
         vAOpOvvjpq9AxePyU/lNgd+cdpnvMQHJhpndPPPo=
Date:   Fri, 4 Feb 2022 15:23:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Paul Bolle <pebolle@tiscali.nl>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insop.song@gainspeed.com,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: gs_fpgaboot: revert removed board specific code
Message-ID: <Yf025dphJw2rUVR5@kroah.com>
References: <20220204054028.3123858-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204054028.3123858-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:40:27PM -0800, Tong Zhang wrote:
> gs_fpgaboot is currently useless since the board specific code is
> removed in 06a3fab941da.

Nit, commits should be printed out like this:
06a3fab941da ("staging: gs_fpgaboot: remove checks for CONFIG_B4860G100")

> Loading the driver will always fail since
> xl_init_io() always returns -1. This driver is broken since 2014 and I
> doubt anyone is actually using it, we could either remove it or revert
> to the previous working version.

Let's just remove it obviously no one is using it.

Or do you want to use it for your hardware?  if so, let's fix it for
that platform.

> 
> $ modprobe gs_fpga
> GPIO INIT FAIL!!
> 
> This patch reverts previously removed code and adds a Kconfig to make
> this board selectable for PPC_85xx processors.
> 
> Fixes: 06a3fab941da ("staging: gs_fpgaboot: remove checks for CONFIG_B4860G100")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/staging/gs_fpgaboot/Kconfig |  14 ++-
>  drivers/staging/gs_fpgaboot/io.c    | 173 ++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gs_fpgaboot/Kconfig b/drivers/staging/gs_fpgaboot/Kconfig
> index 968a153c4ab6..0b4144450123 100644
> --- a/drivers/staging/gs_fpgaboot/Kconfig
> +++ b/drivers/staging/gs_fpgaboot/Kconfig
> @@ -5,4 +5,16 @@
>  config GS_FPGABOOT
>  	tristate "Xilinx FPGA firmware download module"
>  	help
> -	  Xilinx FPGA firmware download module
> +	  Xilinx FPGA firmware download module.
> +
> +choice
> +	prompt "Support Board"
> +	depends on GS_FPGABOOT

That's an odd config option, what will that show?  Shouldn't the prompt
have something to do with the board name?

Anyway, no new config options please, either lets remove it or fix it
for your hardware.

thanks,

greg k-h
