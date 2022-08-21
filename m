Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E059B590
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiHURKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:10:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BD21E07;
        Sun, 21 Aug 2022 10:10:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so12373258lfr.2;
        Sun, 21 Aug 2022 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gkDywoHZRPVGe0t/An1sAO7svRm9ofbrcAxnP8XLUW4=;
        b=dQQa5eSRkyVKEs/v/BaAk2ipgZ2JYLpG9VeAKF8odPdpWwhlWD7pbdjqxvkguSt0Im
         5NoepCadkFN8PwoHCJ8NqqhD02PcQPc4gP93VDc+7Kd+b5hchCE9CFznLAVsI0j00sjO
         Qt3q1xTYVFyF4d4DUdP5KktfCZqqi1Hv3DcRBdE4PkjrOYjn+Oln1IubLUC922Ad7fmB
         7cZ1STK/BPJtJ68fRdbRWsQquAdFy/UTZG3OlBom+SkBCACpJ5f+S5rNXTuM/ZiUGDCg
         r6wICF9fR0iQ3O6hDn6oGsJPaH5cB1KVnhwpdGlXjQGJVp8uc0PnOFrXmJEaX0okYXg7
         Ghdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gkDywoHZRPVGe0t/An1sAO7svRm9ofbrcAxnP8XLUW4=;
        b=QmemyI/dU9ihvbG8STITLMuVi9Met4VOc9dByUyg3rSsiKpv0wmn09chfhQfw7FRtS
         II38VYRhhS33hQcwVLBIsfR615AlzxZOZLVAkRWSnnkQL/0RO63o6xVeOsCvLkLkMDEs
         HIFFbPa7kW+SPQKoRiDYQLqo5Viem1744Fm0AfLpVOj6KghR4wBGoOl81Zk67TlFBcfd
         YHAM77Zjm/sdJ+CvxLgCdPpbqacvj+8KuWZHl18c1dwwIYH21cHHdYJJ7M3AhL4cksM8
         GDjDsXywHxsL2y5gA1AFZ4vQrvNSIRI24XEooRAGON80oVEk8649fQAfEhmpRnZValI7
         v3XA==
X-Gm-Message-State: ACgBeo3/Cr7HV7hB/5Fbz4n4PtZSSivb0mz8IEqX5dIXRzAHxeC5r1d5
        C56JsP8hWLK4KbQlUF3HZJ9ZSjop5U4=
X-Google-Smtp-Source: AA6agR5DyV3vrdphglQVGqlJ7BeORB96GXGVGqPPFAVbIFaavJqL+W2fiC5uyAjn2PMi7NXWc1WWlA==
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id w1-20020a0565120b0100b0048ba0652a8bmr5566241lfu.401.1661101833499;
        Sun, 21 Aug 2022 10:10:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y15-20020a19640f000000b0048a9603399csm1555076lfb.116.2022.08.21.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:10:32 -0700 (PDT)
Date:   Sun, 21 Aug 2022 20:10:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B &
 LS1C Ethernet PHY
Message-ID: <20220821171030.wc343w6zmrtcz5to@mobilestation>
References: <20220818050019.1924408-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vggqndsialimfdn"
Content-Disposition: inline
In-Reply-To: <20220818050019.1924408-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vggqndsialimfdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Keguang

On Thu, Aug 18, 2022 at 01:00:19PM +0800, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
> using phylink_generic_validate() instead of stmmac_validate().
> Moreover the driver assumes the PHY interface mode
> passed in platform data is always supported.
> 
> stmmaceth stmmaceth.0 eth0: validation of gmii with support 00000000,00000000,000062cf and advertisement 00000000,00000000,000062cf failed: -EINVAL
> stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (error: -22)
> 
> This patch sets phy_interface field of platform data.

I've got a similar fix in my repo, though didn't have a chance to test
it out due to lacking any loongson hardware. I've discovered the
issues on my still going way of the STMMAC driver refactoring. Anyway
IMO the problem is a bit different than you describe and should be
fixed in a bit different way. Please see a patch attached to this
email. Could you test it out on your hw? If it fixes the problem you
can resend it as v2 patch.

-Sergey

> 
> Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_validate()")
> Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  arch/mips/loongson32/common/platform.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> index 794c96c2a4cd..741aace80b80 100644
> --- a/arch/mips/loongson32/common/platform.c
> +++ b/arch/mips/loongson32/common/platform.c
> @@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
>  	.phy_addr		= -1,
>  #if defined(CONFIG_LOONGSON1_LS1B)
>  	.interface		= PHY_INTERFACE_MODE_MII,
> +	.phy_interface		= PHY_INTERFACE_MODE_MII,
>  #elif defined(CONFIG_LOONGSON1_LS1C)
>  	.interface		= PHY_INTERFACE_MODE_RMII,
> +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
>  #endif
>  	.mdio_bus_data		= &ls1x_mdio_bus_data,
>  	.dma_cfg		= &ls1x_eth_dma_cfg,
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.34.1
> 

--5vggqndsialimfdn
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-MIPS-Loongson32-Fix-PHY-mode-being-left-unspecified.patch"

From 37a0bdea8d67ef28f55878b494ddcbaab632888c Mon Sep 17 00:00:00 2001
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date: Fri, 24 Sep 2021 17:33:19 +0300
Subject: [PATCH] MIPS: Loongson32: Fix PHY-mode being left unspecified

commit 0060c8783330 ("net: stmmac: implement support for passive mode
converters via dt") has changed the plat->interface field semantics from
containing the PHY-mode to specifying the MAC-PCS interface mode. Due to
that the loongson32 platform code will leave the phylink interface
uninitialized with the PHY-mode intended by the means of the actual
platform setup. The commit-author most likely has just missed the
arch-specific code to fix. Let's mend the Loongson32 platform code then by
assigning the PHY-mode to the phy_interface field of the STMMAC platform
data.

Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode converters via dt")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note I don't have a Loongson32 hardware at hand to test it out. But the
bug in here seems to be more than probable. Thus I've taken a liberty to
post the fix. Should you not find a bug presented in there, just ignore
the patch.
---
 arch/mips/loongson32/common/platform.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 794c96c2a4cd..311dc1580bbd 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -98,7 +98,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 	if (plat_dat->bus_id) {
 		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
 			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
-		switch (plat_dat->interface) {
+		switch (plat_dat->phy_interface) {
 		case PHY_INTERFACE_MODE_RGMII:
 			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
 			break;
@@ -107,12 +107,12 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 			break;
 		default:
 			pr_err("unsupported mii mode %d\n",
-			       plat_dat->interface);
+			       plat_dat->phy_interface);
 			return -ENOTSUPP;
 		}
 		val &= ~GMAC1_SHUT;
 	} else {
-		switch (plat_dat->interface) {
+		switch (plat_dat->phy_interface) {
 		case PHY_INTERFACE_MODE_RGMII:
 			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
 			break;
@@ -121,7 +121,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 			break;
 		default:
 			pr_err("unsupported mii mode %d\n",
-			       plat_dat->interface);
+			       plat_dat->phy_interface);
 			return -ENOTSUPP;
 		}
 		val &= ~GMAC0_SHUT;
@@ -131,7 +131,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 	plat_dat = dev_get_platdata(&pdev->dev);
 
 	val &= ~PHY_INTF_SELI;
-	if (plat_dat->interface == PHY_INTERFACE_MODE_RMII)
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
 		val |= 0x4 << PHY_INTF_SELI_SHIFT;
 	__raw_writel(val, LS1X_MUX_CTRL1);
 
@@ -146,9 +146,9 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.bus_id			= 0,
 	.phy_addr		= -1,
 #if defined(CONFIG_LOONGSON1_LS1B)
-	.interface		= PHY_INTERFACE_MODE_MII,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
 #elif defined(CONFIG_LOONGSON1_LS1C)
-	.interface		= PHY_INTERFACE_MODE_RMII,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 #endif
 	.mdio_bus_data		= &ls1x_mdio_bus_data,
 	.dma_cfg		= &ls1x_eth_dma_cfg,
@@ -186,7 +186,7 @@ struct platform_device ls1x_eth0_pdev = {
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.bus_id			= 1,
 	.phy_addr		= -1,
-	.interface		= PHY_INTERFACE_MODE_MII,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
 	.mdio_bus_data		= &ls1x_mdio_bus_data,
 	.dma_cfg		= &ls1x_eth_dma_cfg,
 	.has_gmac		= 1,
-- 
2.35.1


--5vggqndsialimfdn--
