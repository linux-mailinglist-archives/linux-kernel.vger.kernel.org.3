Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1B59BAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiHVIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiHVIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:04:57 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D08DEB1;
        Mon, 22 Aug 2022 01:04:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6208FBFAFA;
        Mon, 22 Aug 2022 10:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155463; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=/guGV0ra07b3IlhGeOCuArN7ww+4egM5anvKI+999M8=;
        b=emWqcRmwo9IrbCEkslamJSpc8U6z3yS4KNDatFfVM6IHN9Lwaxf33qkLAh2X51vxe48UHu
        zZaUDl4z6Enb5UJLDFqErDstG0kdIbKBwM/kq4vi4MyaYml3qtiSfkpQdJlJt2o9/nQXWc
        B7kZgEoGs69u49C8KC0hPg9FaHFC3AQsOZe7zdMzBTmgBBke8oqrRCmIsG5fdu87DEtPHt
        hqMcJvAQgz4m5qM3AgjyQWqR4zfytLqvNVKp8C+q5M9MZNtEgVmlWjP6+vLnyI8qAeMfj7
        9j+isAaChX19oDyjKz/k6+MYLLbEufb5Tx5DSGu8Uk2uP0APR5pJjWi3YiuhhA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 5/8] arm64: dts: imx8mm-kontron: Remove low DDRC operating point
Date:   Mon, 22 Aug 2022 10:03:51 +0200
Message-Id: <20220822080357.24478-6-frieder@fris.de>
In-Reply-To: <20220822080357.24478-1-frieder@fris.de>
References: <20220822080357.24478-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

For some reason there is a problem with finding a DDR configuration
that works on all operating points and all LPDDR4 types used on the
SoM. Therefore the bootloader currently doesn't configure the lowest
of the three operating points. Let's also skip this in the kernel
devicetree to make sure it isn't used.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v4:
* none

Changes in v3:
* rebase on v6.0-rc1

Changes in v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 33179157f619..96ecdce67059 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -46,10 +46,6 @@ &ddrc {
 	ddrc_opp_table: opp-table {
 		compatible = "operating-points-v2";
 
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
 		opp-100M {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-- 
2.37.2

