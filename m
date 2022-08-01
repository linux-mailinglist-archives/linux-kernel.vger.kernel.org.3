Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4C586BB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiHANQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiHANQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:19 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B02CC8B;
        Mon,  1 Aug 2022 06:16:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FEB4C01C2;
        Mon,  1 Aug 2022 15:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359771; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=1Vq+dWeAn9HBzxJo1vPF2gxJMteCwjIli7Ab5hcGzkE=;
        b=T5yYgTmwz6ia7FHp8jnxg6j4aHaDhIshr6oTHEAg3+1gigsnTkcxVH+fhGzUKUO7NdzWhI
        6dtULpYHtjnFdfxzP4cdIeqR3Pzruq4ZbqzH1J64J30jj1gzIRLDjuHd6bBpBr/3uDbg8B
        2JeUlUaDg2sw/jjA6VauOhJkjR7DsSZbbXc8a92mDK2zEyw2V2M6f2Zxa1n2xZS1ck/l+D
        YEDtadJSw7pddiQ+AOFc9tMiX+xb2fOip29EKlsK6DZ729qwk+P5Xc0a+RhybOqoNstSpq
        E9LZkblqphXIio8INDplrqpmS6ZGbXlSw7JU4rSG37AVyHvyV+iE3aYF5cfaoA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 5/8] arm64: dts: imx8mm-kontron: Remove low DDRC operating point
Date:   Mon,  1 Aug 2022 15:15:49 +0200
Message-Id: <20220801131554.116795-6-frieder@fris.de>
In-Reply-To: <20220801131554.116795-1-frieder@fris.de>
References: <20220801131554.116795-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* none
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
2.37.1

