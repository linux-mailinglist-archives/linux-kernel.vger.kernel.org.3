Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D434E83CB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiCZTas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiCZTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:30:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42B329BB;
        Sat, 26 Mar 2022 12:29:08 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 56B56223EA;
        Sat, 26 Mar 2022 20:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648322943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U94WA8eKsXInUB3TJN954cA6WVXXv7tn5AqxFp37h28=;
        b=QqCCw5dN3veUi4VkeuGsKoMGWWqqi/ZcU/7WgYJhTKFNzAPpICY4OKUiGAjK7qaG1u60Y6
        hovy2Dr6kjLBX3N3Aytn5TXNANT+WGEl5sxhDxY20bmgiSL89tvdjLx8mETbRADOWrifUO
        z8Diao0MF1bQ1bV/HsF/KXPLvfkM+yk=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 2/2] pinctrl: ocelot: add clock monitor option for LAN966x
Date:   Sat, 26 Mar 2022 20:28:48 +0100
Message-Id: <20220326192848.2944519-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220326192848.2944519-1-michael@walle.cc>
References: <20220326192848.2944519-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC supports a debug clock output of its internal clocks. Depending
on the clk_sel input (GPIO_31) clk_mon (GPIO_30) will output either
cpu_clk/64 or sys_clk/64. This is very useful for debugging and is
missing in the pinmux table. Add it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 3f998a8fad8b..b25eb04e4e1d 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -61,6 +61,7 @@ enum {
 	FUNC_CAN0_a,
 	FUNC_CAN0_b,
 	FUNC_CAN1,
+	FUNC_CLKMON,
 	FUNC_NONE,
 	FUNC_FC0_a,
 	FUNC_FC0_b,
@@ -186,6 +187,7 @@ static const char *const ocelot_function_names[] = {
 	[FUNC_CAN0_a]		= "can0_a",
 	[FUNC_CAN0_b]		= "can0_b",
 	[FUNC_CAN1]		= "can1",
+	[FUNC_CLKMON]		= "clkmon",
 	[FUNC_NONE]		= "none",
 	[FUNC_FC0_a]		= "fc0_a",
 	[FUNC_FC0_b]		= "fc0_b",
@@ -983,8 +985,8 @@ LAN966X_P(26,   GPIO,   FC0_b, IB_TRG_a,   USB_S_c, OB_TRG_a,   CAN0_a,    SFP_S
 LAN966X_P(27,   GPIO,    NONE,     NONE,      NONE, OB_TRG_a,   CAN0_a,     PWM_a,        R);
 LAN966X_P(28,   GPIO,  MIIM_a,     NONE,      NONE, OB_TRG_a, IRQ_OUT_c,   SFP_SD,        R);
 LAN966X_P(29,   GPIO,  MIIM_a,     NONE,      NONE, OB_TRG_a,     NONE,      NONE,        R);
-LAN966X_P(30,   GPIO,   FC3_c,     CAN1,      NONE,   OB_TRG,   RECO_b,      NONE,        R);
-LAN966X_P(31,   GPIO,   FC3_c,     CAN1,      NONE,   OB_TRG,   RECO_b,      NONE,        R);
+LAN966X_P(30,   GPIO,   FC3_c,     CAN1,    CLKMON,   OB_TRG,   RECO_b,      NONE,        R);
+LAN966X_P(31,   GPIO,   FC3_c,     CAN1,    CLKMON,   OB_TRG,   RECO_b,      NONE,        R);
 LAN966X_P(32,   GPIO,   FC3_c,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,      NONE,        R);
 LAN966X_P(33,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,    MIIM_b,        R);
 LAN966X_P(34,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,    MIIM_b,        R);
-- 
2.30.2

