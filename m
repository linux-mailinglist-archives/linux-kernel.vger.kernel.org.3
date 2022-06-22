Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A75551CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359540AbiFVQzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377351AbiFVQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:53:45 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD134161B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:52:06 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LSq3L32bczMqwg4;
        Wed, 22 Jun 2022 18:44:14 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LSq3J1hSjzlqV0V;
        Wed, 22 Jun 2022 18:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1655916254;
        bh=16ktisfcvBgIYLREi0tcTzW4w4C5ndQSyEJGx6PC66Q=;
        h=From:To:Cc:Subject:Date:From;
        b=vLCYOSQp/JhOUYEuL2eekc5smKl3lsAvjtBe8HdlSycjBnvJI0SvWlE4KLQ/6Chum
         B9jAJMyb9WO04DPm1g/yk/i3Dxuv6mAkzRRLSC6Hgd0KE8FsuNo+5+uQqQ6hFeMpPi
         qVwwL5zo3byiZpNN5/1tlB/pjHA3HWmNI0+ZNnoY=
From:   Philippe Schenker <dev@pschenker.ch>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8m{m,p}-verdin: use IT temperatures
Date:   Wed, 22 Jun 2022 18:44:10 +0200
Message-Id: <20220622164410.457249-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Use IT temperature threshold for critical/passive trip point
on Verdin iMX8M Plus and Mini.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index eafa88d980b3..a819ed43e727 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -154,6 +154,14 @@ &A53_3 {
 	cpu-supply = <&reg_vdd_arm>;
 };
 
+&cpu_alert0 {
+	temperature = <95000>;
+};
+
+&cpu_crit0 {
+	temperature = <105000>;
+};
+
 &ddrc {
 	operating-points-v2 = <&ddrc_opp_table>;
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index fb17e329cd37..7d8d8df569c5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -146,6 +146,14 @@ reserved-memory {
 	};
 };
 
+&cpu_alert0 {
+	temperature = <95000>;
+};
+
+&cpu_crit0 {
+	temperature = <105000>;
+};
+
 /* Verdin SPI_1 */
 &ecspi1 {
 	#address-cells = <1>;
-- 
2.36.1

