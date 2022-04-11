Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A644FB906
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbiDKKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiDKKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:08:37 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672312229E;
        Mon, 11 Apr 2022 03:06:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8191520000C;
        Mon, 11 Apr 2022 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649671572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUVyrpdb9S8/uhuD169w7kcW369lFxrHB2jY1Y7pK1c=;
        b=eWsCo/Us7q7FEskR2pOfGJJOrnI6iRsXcCLmtBQBzBhBsRxwVAPA7vnTAXtOTeBFOiWoib
        LFXgH3oO5JYWI0c3riv9PHk8gr+qYuDKm3NA9hEap8FeKV8My9GonikOu8N6Fi6YDMnsiJ
        UiUCLV52XGdB/CGBl+9G6v31Ez1vjwHz1GBDyxDgBX5Mg8k+TuYXXT/9WK3+SVomZxSFRx
        x458g6ZrNZLvSo+yLyv9WJS+teWNqea5OkLDk5SjLysPxvqrqGMlcPJsnaZnQOtdwXae1f
        jO7ikOmnE0VON0neEJBLn++rBaEksPCDhBICZY/8cdrpn4jjbmWXsdYtUlNRdw==
Date:   Mon, 11 Apr 2022 12:06:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     krzk@kernel.org, tony@atomide.com, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] memory: omap-gpmc: Make OMAP_GPMC config visible
 and selectable
Message-ID: <20220411120610.2f0c3504@xps13>
In-Reply-To: <20220411095516.24754-2-rogerq@kernel.org>
References: <20220411095516.24754-1-rogerq@kernel.org>
        <20220411095516.24754-2-rogerq@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Mon, 11 Apr 2022 12:55:15 +0300:

> So far for armv7 TI platforms, GPMC was being selected by
> arch/arm/mach-* architecture Kconfig files.
>=20
> For K3 platforms, GPMC is no longer required for basic boot
> and cannot be always enabled by default by mach- Kconfig.
>=20
> We need a way for user (or board defconfig) to enable
> it if required so ake OMAP_GPMC Kconfig option always visible.

                    make

Otherwise,
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 30bff6cb1b8d..da2af9c38fe3 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -103,8 +103,8 @@ config TI_EMIF
>  	  temperature changes
> =20
>  config OMAP_GPMC
> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
> -	depends on OF_ADDRESS
> +	bool "Texas Instruments OMAP SoC GPMC driver"
> +	depends on OF_ADDRESS || COMPILE_TEST
>  	select GPIOLIB
>  	help
>  	  This driver is for the General Purpose Memory Controller (GPMC)


Thanks,
Miqu=C3=A8l
