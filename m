Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13794F4700
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384273AbiDEUzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457564AbiDEQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4687B75;
        Tue,  5 Apr 2022 09:08:50 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 262BB2224F;
        Tue,  5 Apr 2022 18:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649174927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTjJ/DlqGlB4KU5V2+oNHmLmbkHl/GSxV7xd7CiwzNc=;
        b=RgJsiwfILuKJCsY8+3oJcObhGC2VBqBDyUB6M8+CfWkJQgWGbuJvyW5qd+dDnKbq660TMy
        Ekr/aod0aiZfAEG2qnPNnBEkz89LGT0L6lu4wyNVEeZ4Lh5mun/LB7lIJN4Y5Z82oQ9PmH
        hDperpebx6swNwQ3e1wfw8DIpe+5mZA=
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
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 3/7] ARM: dts: lan966x: add missing uart DMA channel
Date:   Tue,  5 Apr 2022 18:08:33 +0200
Message-Id: <20220405160837.4093563-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405160837.4093563-1-michael@walle.cc>
References: <20220405160837.4093563-1-michael@walle.cc>
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

The usart node of the flexcom3 block is missing the DMA channels. Add
it.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 4c7beebbd1ef..e9d6c16d04cf 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -144,6 +144,9 @@ usart3: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
 				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(9)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
 				clocks = <&nic_clk>;
 				clock-names = "usart";
 				atmel,fifo-size = <32>;
-- 
2.30.2

