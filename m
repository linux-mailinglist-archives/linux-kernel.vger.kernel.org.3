Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954C5A786C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiHaIDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiHaIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:03:40 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC8B9F9A;
        Wed, 31 Aug 2022 01:03:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C1DD2DF774;
        Wed, 31 Aug 2022 01:03:36 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pTixk_d-HRmK; Wed, 31 Aug 2022 01:03:36 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933016; bh=vrU6a0X2Tj3PoMyyepXVXDWrv/gf3VSv27chaSDREEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zlc4XckiQK5J46QGyxGbDyudSTjq6MD1FOYfaFyZup0y3G9fJXJrN/NBLCXg/UQYm
         EVgqr0gSsBWCSVuesLPYWT7u0KdSzflAr/cniilRb2upr87cA1t0llyPNBdVICpKnN
         au9msbW4Kll1KcqZ9nC97riuuxjK9QOAN101NgrPwaPbHRSinNG7wvRpl805NjF1kG
         SQcbYG0s8it7TSy3t2ROQiADRqI4MU6/oNpZdaIhsO3Vb8zxQvLgQyZpyBWOyO9Idh
         pyg/732XoqX7WKIv7h0rtXlHGU8LJ9Mr9VjCv5cP9nqDPn3WCZ9/8XjvmCOaDzqkVK
         ZW8hQizGoEeoQ==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH v1 3/5] arm64: dts: imx8mq-librem5: Add bq25895 as max17055's power supply
Date:   Wed, 31 Aug 2022 10:02:59 +0200
Message-Id: <20220831080301.1092737-4-martin.kepplinger@puri.sm>
In-Reply-To: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
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
index bbf49e419b498..996930d72d209 100644
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

