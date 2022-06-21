Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D755345C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbiFUOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiFUOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:19:36 -0400
X-Greylist: delayed 966 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 07:19:32 PDT
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E31F2FD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=B9lL9OqSXc2eVWzkrNe9zxYlTNTyMllYa44sGFVBFnM=;
        b=RODBEiWX5dtF8x+goNia8bLTbClkx28ml6ZqLOtfb6b5jNhYKKBlu0kzzpJzI3PKlDnh1iEhLLcMl
         EtsDQCR4H7jTZkEWtQfOVEjUqYDiHF5EkFkJBHsTg5asxOZ+49q45Eo5UYW4J2hbHMae8hthpLbBZE
         bBSFum1bXO3jD0UbhwdzKPMvpWWRRPrI26gyUoCTC9Xcq02awdYWTPIFs0/Lb0afJYOlB5t127UnlZ
         GyZDDO4gRo57YrryMXh3ITlGvASLK7HSCrgrxiFvC14zEVK1Gz+zQ6ObtBtTnjMm03/A/3+spNyQTT
         hGnyxWAo/9Ti5/cWUxpk8ugDUx5zyTA==
X-MSG-ID: ea2d0624-f16a-11ec-8a45-0050569d11ae
From:   Robin van der Gracht <robin@protonic.nl>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH] ARM: dts: imx6qdl-prti6q.dtsi: Add applicable properties to usdhc3
Date:   Tue, 21 Jun 2022 16:03:34 +0200
Message-Id: <20220621140334.568446-1-robin@protonic.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usdhc3 interface is connected to a soldered eMMC chip on all boards
that import this dtsi. Adding these properties speeds up the device probe
during boot.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
index 19578f660b09..f0db0d4471f4 100644
--- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
@@ -94,6 +94,9 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	bus-width = <8>;
 	non-removable;
+	no-1-8-v;
+	no-sd;
+	no-sdio;
 	status = "okay";
 };
 
-- 
2.34.1

