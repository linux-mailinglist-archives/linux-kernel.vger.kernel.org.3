Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83724E83C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiCZTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCZTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:30:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CC03205A;
        Sat, 26 Mar 2022 12:29:04 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 00D0E22246;
        Sat, 26 Mar 2022 20:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648322939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yhR0Er0uGusNkVWCyp4EBbtkVI2n39kRoata71cOiSw=;
        b=DvKK/6P5DVIzrokmgNoJVVpyYkFCEm14No6lK8SuIU6b5xzE0QAg6/yEe/TAyYz30ulkTr
        e2kmEOE/90ipONmWQrl+rQK+QdPFyQroSi6stknv/FXqlb5RoWRjl/UnTQoNs7hn+e2pb4
        k7hkjHt9V4cp/ngbk9DqQnCF+z+9EJs=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 1/2] pinctrl: ocelot: add pwm output option for LAN966x
Date:   Sat, 26 Mar 2022 20:28:47 +0100
Message-Id: <20220326192848.2944519-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the reference manual, you can mux the PWM output on GPIO27
and GPIO51. This was missing in the pinmux table. Add it.

Tested on a LAN9668 on GPIO51.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 51261f1231cc..3f998a8fad8b 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -138,6 +138,8 @@ enum {
 	FUNC_PTPSYNC_6,
 	FUNC_PTPSYNC_7,
 	FUNC_PWM,
+	FUNC_PWM_a,
+	FUNC_PWM_b,
 	FUNC_QSPI1,
 	FUNC_QSPI2,
 	FUNC_R,
@@ -261,6 +263,8 @@ static const char *const ocelot_function_names[] = {
 	[FUNC_PTPSYNC_6]	= "ptpsync_6",
 	[FUNC_PTPSYNC_7]	= "ptpsync_7",
 	[FUNC_PWM]		= "pwm",
+	[FUNC_PWM_a]		= "pwm_a",
+	[FUNC_PWM_b]		= "pwm_b",
 	[FUNC_QSPI1]		= "qspi1",
 	[FUNC_QSPI2]		= "qspi2",
 	[FUNC_R]		= "reserved",
@@ -976,7 +980,7 @@ LAN966X_P(23,   GPIO,    NONE,     NONE,      NONE, OB_TRG_a,     NONE,      NON
 LAN966X_P(24,   GPIO,   FC0_b, IB_TRG_a,   USB_H_c, OB_TRG_a, IRQ_IN_c,   TACHO_a,        R);
 LAN966X_P(25,   GPIO,   FC0_b, IB_TRG_a,   USB_H_c, OB_TRG_a, IRQ_OUT_c,   SFP_SD,        R);
 LAN966X_P(26,   GPIO,   FC0_b, IB_TRG_a,   USB_S_c, OB_TRG_a,   CAN0_a,    SFP_SD,        R);
-LAN966X_P(27,   GPIO,    NONE,     NONE,      NONE, OB_TRG_a,   CAN0_a,      NONE,        R);
+LAN966X_P(27,   GPIO,    NONE,     NONE,      NONE, OB_TRG_a,   CAN0_a,     PWM_a,        R);
 LAN966X_P(28,   GPIO,  MIIM_a,     NONE,      NONE, OB_TRG_a, IRQ_OUT_c,   SFP_SD,        R);
 LAN966X_P(29,   GPIO,  MIIM_a,     NONE,      NONE, OB_TRG_a,     NONE,      NONE,        R);
 LAN966X_P(30,   GPIO,   FC3_c,     CAN1,      NONE,   OB_TRG,   RECO_b,      NONE,        R);
@@ -1000,7 +1004,7 @@ LAN966X_P(47,   GPIO,   FC1_c,   OB_TRG_b, IB_TRG_b, IRQ_OUT_a, FC_SHRD5, IRQ_IN
 LAN966X_P(48,   GPIO,   FC1_c,   OB_TRG_b, IB_TRG_b, IRQ_OUT_a, FC_SHRD6, IRQ_IN_a,       R);
 LAN966X_P(49,   GPIO, FC_SHRD7,  OB_TRG_b, IB_TRG_b, IRQ_OUT_a, TWI_SLC_GATE, IRQ_IN_a,   R);
 LAN966X_P(50,   GPIO, FC_SHRD16, OB_TRG_b, IB_TRG_b, IRQ_OUT_a, TWI_SLC_GATE, NONE,       R);
-LAN966X_P(51,   GPIO,   FC3_b,   OB_TRG_b, IB_TRG_c, IRQ_OUT_b,    NONE,  IRQ_IN_b,       R);
+LAN966X_P(51,   GPIO,   FC3_b,   OB_TRG_b, IB_TRG_c, IRQ_OUT_b,   PWM_b,  IRQ_IN_b,       R);
 LAN966X_P(52,   GPIO,   FC3_b,   OB_TRG_b, IB_TRG_c, IRQ_OUT_b, TACHO_b,  IRQ_IN_b,       R);
 LAN966X_P(53,   GPIO,   FC3_b,   OB_TRG_b, IB_TRG_c, IRQ_OUT_b,    NONE,  IRQ_IN_b,       R);
 LAN966X_P(54,   GPIO, FC_SHRD8,  OB_TRG_b, IB_TRG_c, IRQ_OUT_b, TWI_SLC_GATE, IRQ_IN_b,   R);
-- 
2.30.2

