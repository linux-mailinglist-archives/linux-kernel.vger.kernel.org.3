Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4538651F0CD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiEHTsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiEHTsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF80B87B;
        Sun,  8 May 2022 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039027;
        bh=XVfOBublJT697s4b334rAe6W/GabYUlUTBRHBuTBhbk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Tbtd0oOdkMsDXF1n3Ux0ph2RxJiqyYb0tDY6P++BmhN/e+iznGvekhTOLxOzVjlT4
         igmUWjro1WUZHg1O3GobuQXl0BpDFZpHh+RzHq+mWs93r8mllPLNSgLuc78oVS0MTA
         GoHI1D2jI1TjKTaS1G6BElFwn6Rtoo0LjwXgEf2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1nu3cK3CBq-015oXV; Sun, 08
 May 2022 21:43:46 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 3/7] watchdog: npcm: Enable clock if provided
Date:   Sun,  8 May 2022 21:43:28 +0200
Message-Id: <20220508194333.2170161-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vzkFSMPPiFMDmjP7Vq0zkUC7L1qOOrUXx77prPxKxM5JG7X5Bw1
 6failCDgS4gKXyhQaublZGP7D3tqW6fJyFX+9hLCjc4rpt4Yr9g0gzqZfWifABWCas2Wndz
 sjZOvqDUULn6wEzEb12IPa41+sDFls2w5G8n4cfH2kYLUF2O5u7/oj7N3wEijQ9tGuI0Bgj
 2hgBVc30Qr2xnLxdevVRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zl9at1OVUvw=:DHCHsKZqeDHrG2eeIxE8MF
 4qykzY0abfuq0Nkh5diTE0IlRkrYeqRBk4630PBA6ruBHDa+Ezxa+ot4w4lgE33zPIyNnzJ3D
 dTgHMGKzj/TNLRLTx1B+IJvHoh1sY1RCogaNWJ/Pgi3y5Wd4Iffv/9mUGLb3pW4RK81+q6YTK
 YY9iPL5F3pX7DQrO/xJkWme/oUAwJP049gm74EBn4LKnV1rP54dBRhQTj0stCHXbZ8aCY8gYc
 v+89X6RltU5Ptb2Wplvt99sdnEyb85zS3lw57Hl5Z2hkAxRKmy/tBpt72WWGmtjZRWT/fkAPM
 TZtomYXwpNTdtRl94Pyv0/HmkIMSA4L4jyNGsB3drYBol3oyyJ/4niEfLXlFgKHT4lzeO1MHM
 j9qk1YSMlEx2v7KgVvluc/x3vyoj/pcbLHdkL0xkoEunfPrfyWsxwQU5C87K9H2Y9GoE/Hhcj
 Gepabk1f5e1dxVFrAvHpxwyCV1/0G4NxjvOSqZqXN//P+uEm3SLlnOmldfKNOtdlLakHrghc1
 H8hnJS1BAOhZwpnAEer3KlxPQqHkY6zAHs4Fldia/ANUy9viBMrqaclFJsRNO7fzEoyX6N73f
 af9xtZdr4ZbMf4WwzO9q2VGJg5h+Im0ILjUqgYgoA/JbzQBSire9ErIEo9J7TVxWa4hEuqVxF
 wrmhCChpMAMlbRqg9XbsID3FQoGPSZIBWgbBt0PrE8ntkr6yGlcyC9ezBxoIG6XowiLHivzG3
 0KxC2DBXJ2pGwWLjXjwafwGCF/d3S4bfVe8f5XuLIZ0p2tFyC32Bgt5ZlpU3CmvcNg4gitiB9
 r3nVhoqycmtQ0bs7fgyryAZUAxNw5dmJ4Bp9hl196irU/Fdy6a1zwH8JfUPB4XQ4OHCVG8YQw
 05NoycP93i789V7ZzsaZiS5o5SBXCfx6OFBF0sIgNwJqKxxDyQo7RY0sRcOf8TzSNEEURmlw4
 oXiH8aqVL4yvLfIYhfclXD1zZzjV2YMiM5dd77brc30OBr09C7oe/iYeOP6eV6tFHMa/29MCp
 mrXYnCy+yaAY4f49g9PWbpiQ5E6c55GInx41N2637GQAekCA81AeHcb8d4lUb6X0574Gg1DeH
 hm/fEOJSKndp18=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
clocks are individually gated and ungated. Therefore, the watchdog
driver must be able to ungate the watchdog clock.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- Add enable/disable calls to npcm_wdt_restart handler
- Not applied due to the above change:  Acked-by: Guenter Roeck <linux@roe=
ck-us.net>

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-4-j.neuschaefer@gmx.n=
et/
- Add clk_disable_unprepare call, suggested by Guenter Roeck

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gmx.n=
et/
=2D--
 drivers/watchdog/npcm_wdt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 28a24caa2627c..a1240a906ef2a 100644
=2D-- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2018 IBM Corp.

 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -43,6 +44,7 @@
 struct npcm_wdt {
 	struct watchdog_device  wdd;
 	void __iomem		*reg;
+	struct clk		*clk;
 };

 static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
@@ -66,6 +68,9 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
 	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
 	u32 val;

+	if (wdt->clk)
+		clk_prepare_enable(wdt->clk);
+
 	if (wdd->timeout < 2)
 		val =3D 0x800;
 	else if (wdd->timeout < 3)
@@ -100,6 +105,9 @@ static int npcm_wdt_stop(struct watchdog_device *wdd)

 	writel(0, wdt->reg);

+	if (wdt->clk)
+		clk_disable_unprepare(wdt->clk);
+
 	return 0;
 }

@@ -147,9 +155,15 @@ static int npcm_wdt_restart(struct watchdog_device *w=
dd,
 {
 	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);

+	if (wdt->clk)
+		clk_prepare_enable(wdt->clk);
+
 	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
 	udelay(1000);

+	if (wdt->clk)
+		clk_disable_unprepare(wdt->clk);
+
 	return 0;
 }

@@ -191,6 +205,10 @@ static int npcm_wdt_probe(struct platform_device *pde=
v)
 	if (IS_ERR(wdt->reg))
 		return PTR_ERR(wdt->reg);

+	wdt->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk))
+		return PTR_ERR(wdt->clk);
+
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
=2D-
2.35.1

