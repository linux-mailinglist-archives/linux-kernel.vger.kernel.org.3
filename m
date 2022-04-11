Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3F4FBACB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiDKLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiDKLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:23:53 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FB4338F;
        Mon, 11 Apr 2022 04:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649676063; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FYR1ljHw9ZleGd6VEvYY5zwbU+JgG4fLt3a2rwmS4wVlnaOl9s2j1HOI0SSXKQ6A+OyZBAnGhe45k+byVXyfC7zH/i5thZnjMfpPDWFCS8CNw2OnTGcSIxnfoViN50bdVrne8aP5+oFxupsAqFo8Nzw8RWZDQAN4fbGYrYKoUA4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649676063; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=s4xzLoNpe1+7AuZ01StDxH9nnUVROAsjJ2iNHkOD0DU=; 
        b=oKfNTWkk4QyWgfmc4PKiKA3Ynqjmax8qhZTvK266DXBSy5f9LujDG9UsRwnksOB2161zsbCsxfkxMrQmnJdZvPNzA8jWjJABhEE7Nl6NT8s8zhVHq2RzjW4VI0kQPVFijdOjNZeFz4VNwCGnSyMMy3AMbS9xSk6MpSYTvC1OIjE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649676063;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=s4xzLoNpe1+7AuZ01StDxH9nnUVROAsjJ2iNHkOD0DU=;
        b=WJF6fzUvoRQgTBFtax5JnWNJsc7hJbZ3dZX2/HeUGB1SfRYXJUt+x5VouQMl1Tg/
        i7FEnf0Vxfc9+FuiZ4ErEWtDeeFH8Pbcz9D/24Yc+a1rchkZ2anAcB8TWHT/wV2QhPZ
        +FVt1FY1D+gfUfvVwmckgEKi2aZiHE4yO5oZapjs=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649676061982713.5477889360059; Mon, 11 Apr 2022 04:21:01 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mips: dts: ralink: mt7621: mux phy4 to gmac1 for GB-PC1
Date:   Mon, 11 Apr 2022 14:20:48 +0300
Message-Id: <20220411112049.18001-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411112049.18001-1-arinc.unal@arinc9.com>
References: <20220411112049.18001-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
v2: add "ralink:" to the commit summary

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

