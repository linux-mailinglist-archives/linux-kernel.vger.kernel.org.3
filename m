Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39005AAA63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiIBIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiIBInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:07 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03367ABD4D;
        Fri,  2 Sep 2022 01:43:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C9FFBDFE53;
        Fri,  2 Sep 2022 01:42:36 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GKgNz54uSPJW; Fri,  2 Sep 2022 01:42:36 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108156; bh=KUxiFlsvpcd+F5TUJQ2y/X50YrcqnyZ008WHXZXuiUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ep+tjQXP1ddXX5tsKpXiburC+cb0chbIauIEUqek9UVqh2FrMbc7BHNcrL40plePt
         3OpHkzaGEzOy75w9UVYjGYNh843PYqEkO3Igq69mhrIaZ2N2C4E3JI/BBhKoiiODxF
         A3L+WU6WVG17h8PyJYtIbOG7sQK3Lw8Lw4zl7ES8cvmc3k2zgFS/b+cE/VXT+eh1q3
         kynz+s1JBaCBcdbhAxwb7KbEcFQmkBSdyICw2mq7QiQUAEhOqJn8RvCvarXIm2i6mS
         Aq8LvqhXW476jRbtZCcb4h2O8vucT077cUzvTmD2EHu19SfwhmQpL3Glzsse+V6hpU
         WK+z0orkXom6w==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH v2 3/6] arm64: dts: imx8mq-librem5: Add bq25895 as max17055's power supply
Date:   Fri,  2 Sep 2022 10:42:13 +0200
Message-Id: <20220902084216.1259202-4-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
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

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

This allows the userspace to notice that there's not enough
current provided to charge the battery, and also fixes issues
with 0% SOC values being considered invalid.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 8da7b87c1aa1f..7e6c4ad438092 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1109,6 +1109,7 @@ bat: fuel-gauge@36 {
 		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gauge>;
+		power-supplies = <&bq25895>;
 		maxim,over-heat-temp = <700>;
 		maxim,over-volt = <4500>;
 		maxim,rsns-microohm = <5000>;
-- 
2.30.2

