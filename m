Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F314CC228
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiCCQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiCCQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:04:25 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B74163D59;
        Thu,  3 Mar 2022 08:03:39 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EAAFE223E9;
        Thu,  3 Mar 2022 17:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646323418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpTJKXWZQSGDCvb32VYZNxFrjbOmnNCTM6KsdzDE4L0=;
        b=aYDtGY41X1vLw4qW5IZTzEe0IDAUfxB8pvYtJLKcWDGNcSm/iXUqnRGPYxqrJwGjFC4/zX
        Iy7uQGLne4W+xMjrMPdsw3boz1fnoULmKPSTnTbCEVLANWlDwVjgiSLyrZ/E0lAxdTnGaq
        q/a4LETaAHt0yDVBHq5wlWXY5WPT5Cw=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 1/6] ARM: dts: lan966x: swap dma channels for crypto node
Date:   Thu,  3 Mar 2022 17:03:18 +0100
Message-Id: <20220303160323.3316317-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303160323.3316317-1-michael@walle.cc>
References: <20220303160323.3316317-1-michael@walle.cc>
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

The YAML binding (crypto/atmel,at91sam9g46-aes.yaml) mandates the order
of the channels. Swap them to pass devicetree validation.

Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board pcb8291")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 7d2869648050..5e9cbc8cdcbc 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -114,9 +114,9 @@ aes: crypto@e004c000 {
 			compatible = "atmel,at91sam9g46-aes";
 			reg = <0xe004c000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
-			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
-			dma-names = "rx", "tx";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(12)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(13)>;
+			dma-names = "tx", "rx";
 			clocks = <&nic_clk>;
 			clock-names = "aes_clk";
 		};
-- 
2.30.2

