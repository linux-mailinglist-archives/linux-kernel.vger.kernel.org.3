Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6F4FB026
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiDJUeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiDJUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:34:34 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059B12ACD;
        Sun, 10 Apr 2022 13:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649622729; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GEQjRguIJZYHBHb1etQ4PriBmnya+eD7hSHE4mtsUSoj/AC+g2WgUYB5vmChbmJO1KqjiPZ4xmNQJeZJMULWDNHAltgSKTkfne3bsqXTK/MbZn1529kND4GcEblYIQtzh9nShoDHI4qIb6Dkix3s/P9Hog8HvauakmhgKBm8ywk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649622729; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XK2YqT7nlytvRR0jjgieJSJ0MKgXSnwQ6QlocLMC3Yg=; 
        b=agFnNEWp7AeMpce2wS6R5M0CSwLzTeimeR5JIRInnIXlwZBuf/KDI/1H+m0RD3C3O/G6JUxm0w7Sainl14DEK9KggZ7zuOqBy+WfvkAoNVgP8R3zpgZO+oYNxYRkXVYfGJ02x5wsQKmN7McrZNdbpAApXdyTvSyLs9yKG+K7Xzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649622729;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=XK2YqT7nlytvRR0jjgieJSJ0MKgXSnwQ6QlocLMC3Yg=;
        b=JfnbIWgD67HPe2UUlSbDAHUl6AiTVDLpixgd+RjFuozcX6EWtN/0NtCeA7ymmRQG
        7tKd/M/kLdFsVkE9360EffYBZvG6pfgYFIdcQIT2jk9CcegJ+7aOxLj6IKU753oLEoG
        jlGTKSZw8AnKxjHvVFvQBVV9umWWJ4MC2dzolCm8=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649622727528283.822930182718; Sun, 10 Apr 2022 13:32:07 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH 2/3] mips: dts: mt7621: mux phy4 to gmac1 for GB-PC1
Date:   Sun, 10 Apr 2022 23:31:37 +0300
Message-Id: <20220410203138.22513-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410203138.22513-1-arinc.unal@arinc9.com>
References: <20220410203138.22513-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mux the MT7530 switch's phy4 to the SoC's gmac1 on the GB-PC1 devicetree.
This achieves 2 Gbps total bandwidth to the CPU using the second RGMII.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 5892bcf71595..75f3b0425487 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -103,14 +103,21 @@ &pinctrl {
 
 	state_default: state-default {
 		gpio-pinmux {
-			groups = "rgmii2", "uart3", "wdt";
+			groups = "uart3", "wdt";
 			function = "gpio";
 		};
 	};
 };
 
-&ethernet {
-	pinctrl-0 = <&mdio_pins>, <&rgmii1_pins>;
+&gmac1 {
+	status = "okay";
+	phy-handle = <&ethphy4>;
+};
+
+&mdio {
+	ethphy4: ethernet-phy@4 {
+		reg = <4>;
+	};
 };
 
 &switch0 {
@@ -119,10 +126,5 @@ port@0 {
 			status = "okay";
 			label = "ethblack";
 		};
-
-		port@4 {
-			status = "okay";
-			label = "ethblue";
-		};
 	};
 };
-- 
2.25.1

