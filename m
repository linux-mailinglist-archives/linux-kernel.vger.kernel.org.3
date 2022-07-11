Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A256FF11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiGKKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGKKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:36:54 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD524AAB10;
        Mon, 11 Jul 2022 02:47:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4FD5CE008C;
        Mon, 11 Jul 2022 02:46:34 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WZ3W3IKfRroK; Mon, 11 Jul 2022 02:46:33 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657532793; bh=SIVg2R/dN6S1hh+ase98JVSdxk9pJlViqrkTdBueOtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buz6fZx3y+cLK55HEj14phepTYXyAj71aD+cyoybxAxfN7gRYhvT8ypeXwmDkriNh
         bIqJ09oVJLi0BqNoIf/2pY0HBM4ABWN6YASayJISkCT7gg0k548ZWKlmhWxVD5Kp4o
         J1QH4YL2r/Adxzl8mxoewup2TymDC7CAKCadBKLAqd/7f2SjwAW+LNj38FVs+S7xLd
         tlNRuUC3EvdhaBKx6mpIFXIzfHvUO9n39QydkXGjfgRKDdzUSNk1sYC6K9fUVc3QQZ
         N2Bp4PQjOw8qnA24GmKCy3rIzAeDscdhL877ElJij6Sw3xKAVTFVmcy+rz82zDlj4r
         sON2J1NjvORHQ==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 3/3] arm64: dts: imx8mq-librem5: set pd power-supply-needs-irq when needed
Date:   Mon, 11 Jul 2022 11:45:49 +0200
Message-Id: <20220711094549.3445566-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the pgc power-supply nodes on the librem5 board, interrupts are
always needed for them to work as they are regulators controlled via
i2c.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 9eec8a7eecfc..1b445cbfdc78 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1159,14 +1159,17 @@ mipi_dsi_out: endpoint {
 
 &pgc_gpu {
 	power-supply = <&buck3_reg>;
+	power-supply-needs-irq;
 };
 
 &pgc_mipi {
 	power-supply = <&ldo5_reg>;
+	power-supply-needs-irq;
 };
 
 &pgc_vpu {
 	power-supply = <&buck4_reg>;
+	power-supply-needs-irq;
 };
 
 &pwm1 {
-- 
2.30.2

