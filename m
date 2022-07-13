Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48991572F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiGMHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiGMHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:43 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13EE5DCA;
        Wed, 13 Jul 2022 00:47:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9098C01D7;
        Wed, 13 Jul 2022 09:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698105; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=bMoDlt4I17xyhnkDM2IHsZUlSwj4C71IEBwpW5llE1Q=;
        b=BMhd2/g5T2iLcsP/VxrscWVak0FeYeTJapSqjgOzE1BZU4bdbVgTJyXbS6GPQsjcnNVaOw
        dR0vYRypqJy6ify3kDaxDvHOXQSPvraGsyyKCW8lig4HUT8bQt6VYRKQ5C0HqnNokMKFUh
        gcShAQ2r0KmGK/ULqbp9+CB3/YnvF9H0UksPQMhHs3JXdPk0xGkucDfl0ICjHKjS/Ft6TZ
        hEcfEKkedRTiJPtytQpXFE/EORVgojlC52FUj8lF5MClYnKPQBjjAv58gkqsBkGWq7HJHq
        Dq2ZHbFsS/XXaKcBoZsYYIyU8mm/TLa+mLBAOi0JYr7fe0FXWapjxXmViTUf6A==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 3/6] arm64: dts: imx8mm-kontron: Remove low DDRC operating point
Date:   Wed, 13 Jul 2022 09:41:14 +0200
Message-Id: <20220713074118.14733-4-frieder@fris.de>
In-Reply-To: <20220713074118.14733-1-frieder@fris.de>
References: <20220713074118.14733-1-frieder@fris.de>
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
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 77c074b491a6..2d0661cce89b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
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
2.37.0

