Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A256597D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiGDPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGDPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:09:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2811829;
        Mon,  4 Jul 2022 08:08:17 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0AF7922175;
        Mon,  4 Jul 2022 17:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656947295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jEiYFjiGJRpd7Nt2gXQg7KVowP0EtL6VyOE2GTOzp1M=;
        b=bPXFqHpxppnthK3zUNLL990q8DF+cXWviEqPZtqLu0epI5BS5ur7KQt3uyqBRjil5J47Uw
        nlKzUqp19OfD9QeQ5b4tbOpfvpYY4Rp1/kIKxtgH6HEFdw+t5ixqmX6moVxMXIhPe3SkKu
        qdrEB+mTcOp8qOsrtT5PChXlF6NUp6o=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ARM: dts: kswitch-d10: use open drain mode for coma-mode pins
Date:   Mon,  4 Jul 2022 17:08:08 +0200
Message-Id: <20220704150808.1104295-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

The driver use the coma-mode pins as open-drain. Flag them in the device
tree accordingly. This avoids the following error:
[   14.114180] gpio-2007 (coma-mode): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Fixes: 46a9556d977e ("ARM: dts: kswitch-d10: enable networking")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 949d49944a37..5a6c5f7c371a 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -87,22 +87,22 @@ &mdio0 {
 
 	phy4: ethernet-phy@5 {
 		reg = <5>;
-		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy5: ethernet-phy@6 {
 		reg = <6>;
-		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy6: ethernet-phy@7 {
 		reg = <7>;
-		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy7: ethernet-phy@8 {
 		reg = <8>;
-		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 };
 
-- 
2.30.2

