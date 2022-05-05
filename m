Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920A451B567
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiEEB4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiEEB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:56:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7B4CD55
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FE18B82A87
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCCCC385A5;
        Thu,  5 May 2022 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651715543;
        bh=Tfsndcbz9HCQly7xAIajbFZwqIJDWAUDHWuaqf3Ln9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwn2LKlDIXcC8/ChZihDtUZY+ptwYG1888cPCX30xtPru1iwFHJRfgES8dVeL1Ol6
         SWuchznLdPHH6n0fIBvV39otOUiNaqUAWRQjfYdhN1/kdf5phYXTsLqfy/mg+qBl4b
         P9WLAcqYm7YYvsjpOdCswXoctODiMV1+LBcaPdykzsiwrHtEYGhsPjAeOye5SHmORw
         YfWakldBTrzUlLdiJ9UN3RArQmH0jFjBNXRKsg+/6UjQMHr9lnYRRdl4/WdcbtegT7
         vGLjyTuz854ZU4x3OGcYi+Iwf3qKtg6Vf86D1MeXu0fvbgsO9yXXQdven2pxLV2fxo
         FdE1yu1Xwsm8Q==
Date:   Thu, 5 May 2022 09:52:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        alistair23@gmail.com
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable RDNIS by default
Message-ID: <20220505015215.GG14615@dragon>
References: <20220420122728.510802-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420122728.510802-1-alistair@alistair23.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:27:28PM +1000, Alistair Francis wrote:
> Supporting Ethernet over USB is very useful for debugging. This allows
> debugging systems where the other networking (WiFi or Ethernet) doesn't come
> up, while still allowing SSH access.
> 
> This is extreamly useful on the reMarkable 2 as it doesn't have UART RX
> or a physical ethernet port. If WiFi doesn't work this is the next best
> method to access the device.

This should be probably left to users to configure per their needs.  And
configfs might be the best default option.

Shawn

> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index f7498df08dfe..f9ddaba1aad2 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -349,12 +349,16 @@ CONFIG_USB_CONFIGFS_F_UVC=y
>  CONFIG_USB_CONFIGFS_F_PRINTER=y
>  CONFIG_USB_ZERO=m
>  CONFIG_USB_AUDIO=m
> -CONFIG_USB_ETH=m
> +CONFIG_USB_ETH=y
>  CONFIG_USB_G_NCM=m
> -CONFIG_USB_GADGETFS=m
> -CONFIG_USB_FUNCTIONFS=m
> +CONFIG_USB_GADGETFS=y
> +CONFIG_USB_FUNCTIONFS=y
> +CONFIG_USB_FUNCTIONFS_ETH=y
> +CONFIG_USB_FUNCTIONFS_RNDIS=y
> +CONFIG_USB_FUNCTIONFS_GENERIC=y
>  CONFIG_USB_MASS_STORAGE=m
>  CONFIG_USB_G_SERIAL=m
> +CONFIG_USB_CDC_COMPOSITE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
> -- 
> 2.35.1
> 
