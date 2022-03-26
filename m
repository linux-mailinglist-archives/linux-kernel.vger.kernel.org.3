Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D04E7FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiCZHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiCZHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:52:59 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2001:41d0:d:357f:aaaa::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE71544AE;
        Sat, 26 Mar 2022 00:51:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC36F33EE9;
        Sat, 26 Mar 2022 07:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648281081; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=2zutAK5IyrmEYXJesAiAG/QGzAOVj6jiOeg39kr9PHM=;
        b=WOCGB16/EuN01Uq92kXi9yNwwNdHk54bKstwjHM8cmY749WF+lhncuEzuwzxG3PKmoK8Mn
        yoUct+LwFEFwIGrp/Fc0p6PWz8ae22KsU4ZdbrnIvhfVVfp0Y7kU9WeZQ44kBvZui0IWkr
        rPJruhQyaVM/01YzvJ4MBwenSaCEmje56cIahbjpgVtlfrFw4sJb1uUG3HY2oBy91LvlTy
        NptGI1CA82jKAwwKSpaKrV7moo6k4Tu3kHy1E0IB3P7JeuUa3kDtLXdobK+ZH0OuKuDrS/
        nU50jCl/HK8Ha4Tdw2SaVNT6GS0iKkvj5T2MpDJGbbfqwsqtIWy/vNmYmd7KnA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: meson: update SDIO voltage in dts for JetHub D1
Date:   Sat, 26 Mar 2022 10:51:09 +0300
Message-Id: <20220326075110.1462301-4-adeep@lexina.in>
In-Reply-To: <20220326075110.1462301-1-adeep@lexina.in>
References: <20220326075110.1462301-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the dts to match board's reference design:
- update vddio_boot regulator to 3.3v (Wi-Fi SDIO module)
- add vccq_1v8 regulator with 1.8v for eMMC SDIO

In the first revision of JetHub D1 the vccq_1v8 regulator was 3.3v.
All installed eMMC modules were tested to work in HS200 mode at 3.3v
supply voltage. In the next revisions of the board eMMC will be
powered with 1.8v according to the standard.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 .../dts/amlogic/meson-axg-jethome-jethub-j100.dts     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index 66c1eeba8f48..e52abffdf8cf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -81,6 +81,15 @@ vddio_ao18: regulator-vddio_ao18 {
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vccq_1v8: regulator-vccq_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCQ_1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vddao_3v3>;
@@ -282,7 +291,7 @@ &sd_emmc_c {
 	mmc-pwrseq = <&emmc_pwrseq>;
 
 	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vddio_boot>;
+	vqmmc-supply = <&vccq_1v8>;
 };
 
 /* UART Bluetooth */
-- 
2.30.2

