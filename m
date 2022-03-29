Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E14EAF22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiC2OUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiC2OUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE37260C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E363AB816FB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC5C340ED;
        Tue, 29 Mar 2022 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648563504;
        bh=lf9NWkAyWC0EVdJrjgHsBG3yJqg4WHrv+l72W6YK8G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3gvAA3jAxASAndEQg62IkyejbfpGnC8uxXWcI250maIoBPWCYCMJnSinJGM0Q1jb
         ZRwI1TxPvcWS5NPSPcvwuDAXdwHKrXCKY5s1iwSXDlebYewTar92VOklJME8eiMPtn
         PUeYN0reCLR+wJ1sqqUiZ2TherHoClVtyh0N6+dI=
Date:   Tue, 29 Mar 2022 16:18:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] phy: PHY_FSL_LYNX_28G should depend on ARCH_LAYERSCAPE
Message-ID: <YkMVLNHo+iMLHZRg@kroah.com>
References: <20220329125631.2915388-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329125631.2915388-1-geert@linux-m68k.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:56:31PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Freescale Layerscape Lynx 28G SerDes PHYs are only present on
> Freescale/NXP Layerscape SoCs.
> 
> Move PHY_FSL_LYNX_28G outside the block for ARCH_MXC, as the latter
> is meant for i.MX8 SoCs, which is a different family than Layerscape.
> Add a dependency on ARCH_LAYERSCAPE, to prevent asking the user about
> this driver when configuring a kernel without Layerscape SoC support.

Why the artificial ARCH dependency?  What happens when people want to
build kernels for multiple arches at the same time?  We shouldn't put
these restrictions on just to have to go back later and remove them.


> 
> Fixes: 02e2af20f4f9f2aa ("Merge tag 'char-misc-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")
> Fixes: 8f73b37cf3fbda67 ("phy: add support for the Layerscape SerDes 28G")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/phy/freescale/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 8d945211c7b40727..f9c54cd02036285b 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -26,14 +26,15 @@ config PHY_FSL_IMX8M_PCIE
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
>  
> +endif
> +
>  config PHY_FSL_LYNX_28G
>  	tristate "Freescale Layerscape Lynx 28G SerDes PHY support"
>  	depends on OF
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
>  	  Enable this to add support for the Lynx SerDes 28G PHY as
>  	  found on NXP's Layerscape platforms such as LX2160A.
>  	  Used to change the protocol running on SerDes lanes at runtime.
>  	  Only useful for a restricted set of Ethernet protocols.
> -
> -endif

The movement of the #endif is fine, how about just sending that change
as that is the merge issue here.

thanks,

greg k-h
