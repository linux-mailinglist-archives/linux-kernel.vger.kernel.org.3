Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900954B7109
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiBOPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:48:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiBOPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:47:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C91D10A3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:46:36 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8A7B1223E9;
        Tue, 15 Feb 2022 16:46:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644939995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JafapACZQ0xV3t8b2ikKuTXebHcc7tuIEPCWjXrUmY=;
        b=qr/FaWq9vKnj3QVdb4/Tr+O5NLtk376V8VX0JC3FCmiwZoQIDfdGgSq7s9yNaRSUXz9Qqo
        Xql3RQd9eHq5qsNEpzCnBLqEqXhX+DmE65RnGCTfF1Rx9jYpvujpmuKVYtYDThBpjJ1or6
        7lE4TJ9JO89peU69HsRmd5nafv/w81s=
From:   Michael Walle <michael@walle.cc>
To:     kavyasree.kotagiri@microchip.com
Cc:     alexandre.belloni@bootlin.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] ARM: at91: debug: add lan966 support
Date:   Tue, 15 Feb 2022 16:46:25 +0100
Message-Id: <20220215154625.826450-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209084139.29901-1-kavyasree.kotagiri@microchip.com>
References: <20220209084139.29901-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Add support for low-level debugging on FLEXCOM3 USART of
> LAN966 SoC.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/Kconfig.debug | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 976315dea958..7989d0633188 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -210,6 +210,14 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on the FLEXCOM3 port of SAMA7G5.
>  
> +        config DEBUG_AT91_LAN966_FLEXCOM3

Can we use DEBUG_AT91_LAN966_FLEXCOM here and provide a table with
all the different offsets for all flexcoms, and maybe default to flexcom0
(or flexcom3, I'm not sure).

> +                bool "Kernel low-level debugging on LAN966 FLEXCOM3 USART"
> +                select DEBUG_AT91_UART
> +                depends on SOC_LAN966
> +                help
> +                  Say Y here if you want kernel low-level debugging support
> +                  on the FLEXCOM3 port of LAN966.
> +
>  	config DEBUG_BCM2835
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
>  		depends on ARCH_BCM2835 && ARCH_MULTI_V6
> @@ -1685,6 +1693,7 @@ config DEBUG_UART_PHYS
>  	default 0xd4017000 if DEBUG_MMP_UART2
>  	default 0xd4018000 if DEBUG_MMP_UART3
>  	default 0xe0000000 if DEBUG_SPEAR13XX
> +	default 0xe0040200 if DEBUG_AT91_LAN966_FLEXCOM3

This is the base address of the flexcom0 uart, not flexcom3.

-michael
