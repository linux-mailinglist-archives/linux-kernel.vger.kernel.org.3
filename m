Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75764592DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHOLDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiHOLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:02:56 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B2524BD4;
        Mon, 15 Aug 2022 04:02:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68F40C012C;
        Mon, 15 Aug 2022 13:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660561374; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=DWFAWhIpY/WASigIlLwyV1sUn/XN9i+sYTmP//PqvJw=;
        b=GIDHld7b3PkUVctagQq6RR3YYAi9hURpSos+yGCzn99q1i44z2MvdXteXzFeIJeVNFl+GP
        7vyqsXHFak8t2kbt39Ir1HVRIbbDBKhJi6tM765KDZzGJtoXxDJcKDcoDVhZdBEXCCYU+M
        XH2Qq9GSzkcRUa5737RezavCvm0UiyZBsOO+PA8Drfs2GZUvfNRPcOugI8rD27nzL3XYYN
        J5uleI5jvxMPwOMdZZIAD5F6WWTHXYJ+QEQUXROQWw9HZOuf2jjgHNSKnYYDl/ff7mY0vH
        PqYpqB46KP4oGpeuXHb9oS/Fjz/tfnhPPTV5oSZ2F7OjTLqhT8wLeXWbL/GKYw==
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
Subject: [PATCH v3 5/8] arm64: dts: imx8mm-kontron: Remove low DDRC operating point
Date:   Mon, 15 Aug 2022 13:01:28 +0200
Message-Id: <20220815110134.49683-6-frieder@fris.de>
In-Reply-To: <20220815110134.49683-1-frieder@fris.de>
References: <20220815110134.49683-1-frieder@fris.de>
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
2.37.1

