Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D534545D37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346774AbiFJHXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346722AbiFJHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:22:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CC2252D;
        Fri, 10 Jun 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654845720;
        bh=j3UY4Dc5ZucxvZOdMQ7G7i2RlA13OGQcUuT05UZhmlk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lrCxQu9gPZP3aTtP+UdnRHWcryV1DB5W2tdNllB/hHoADU5AIO68QL4iVdWEPrdkN
         uhkduHL2Xr+UBH+N56b/a9IAxSGQa9tMpOh+daXNdh9Amk+1OwaRi8REfB/xke2xRB
         NlcaB0jBp1x1pR/OrJLhBaUFTQNO5sjxuz6XcS20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1nHOWl3D28-00iBNh; Fri, 10
 Jun 2022 09:21:59 +0200
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
Subject: [PATCH v4 2/6] watchdog: npcm: Enable clock if provided
Date:   Fri, 10 Jun 2022 09:21:37 +0200
Message-Id: <20220610072141.347795-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610072141.347795-1-j.neuschaefer@gmx.net>
References: <20220610072141.347795-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2PiAR+PAhe6XaqU2LmLRzu4DoKNpDPyrJc4JH5huBAJPKh+QUNk
 GEOzDpM+bZrgsa1BmNgoDOQ9r66cVZRKjcB3alQsW8GAJNY5NTAIFTyua7z/2ENIPnoKfBR
 BQ6JrUUmfgyglEnddnaRGGdiltOocyvmmNIeOACq9Jy9kcSLBtCwaTme7HPgmzagYVKKsg+
 mHOzIFNgctCPazzIs/Esw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9zi4Na8zUY=:55BG0Xozf1f51tRz3AJXiU
 ZJOA8AbZhrjhSU9ZfCSIhITEd6u7YHNKiXNiuEuKOWWJ9jwkiNNdBibHFNTyYJWmoQQRmjO3a
 I0PIU6SV/2KbtdDQzO9+ABPcQ70vgZUtAKGQL+DMKrwqNYRzkIlTTqusqbKFEXHcvuO3E9x7l
 W8j8fAw+ogjXTujng5Unmmecd2yfeniwRt/2lBtrZNPgo0oAziP8O/Cu3n7NsSJhF7EQ8V9wF
 bqQovlPWTPdroQ+zbmpMMSv0JFpINjk7kNbV7IA1JDrdKFrIGy8QoT67cC6B8sqagok0+Cnwo
 Yj3GMi1dHWJrtyv8eapck4/pF8iTqA1zY+KKuSv5JLej+o/uOcgG8slLw6VsXdkBlR7CX+uyo
 a6+1+gn0u2MLcdTpHBdx1xtxE3lEjH6fC8uU0Ji0zKI+9Je+BC95+wf45UpZ/eon9MXJxJVEb
 uF82Z+fWMVmHZQLDRHhEVYCyA+b/izxpCREc3Zedx76FlPjpH0FCHhZyRPjzfj2dKTWkojcJd
 fhlndhVuJRdQUm0WIG6A7/XaursXc7hoKJLltyP+1TFPUBbctoGzlyBAHet9JHCETbJfoVAUP
 Prz8+Tdw2csBL+pwj9oN7xN2YY37b8KIwrfIk33NS+f5kWsSMaQ+sBD5OM6FvRFj0fGuIId00
 Y6cJB6PLmBMc5Gjk9n9U7VJH3A+ZwF+q6NVuaZ+iPtHDGiObJJjueDP4LBPNUau0VuuaaAStP
 xlNahj37Ym13uG5ECZe87uDB0+uqp1NzImp4x1R8BRn/yiopZvA9X1DIftmMxEKPEYXtVsndm
 1pdF6m35qjjV17DRN9O4hc+qE+JBTcLPD+/+8iUqt0eF8K9tkHAUMk56FfcKyVf7wODhPOeQ7
 T0H54ZAPDlylAxeYTmjnkvJS+yqhxQQm9hIKzXvgcOHzlphzi9hsFwmavftBWUE57AWcOaRLK
 JheqBkeOer37bDkx94pCawOd8EOiVPKMqCLydSChrvVf5hHt/doNkVDQzpf6ab+ndGihtphix
 80ZKWQhJLaRvAlz0Xfc8RicvePFT6R0XKPTcAB9xkrsLOUJ6hC+9mS677sIrwAiTTfYP2dTo0
 3Tl3ZvxHzu0Mo1RhTCb5fBTxmHO/7RduiljXXG3hy07PHaj8E88uqhDzA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

v4:
- Don't disable clock in npcm_wdt_restart function

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-4-j.neuschaefer@gmx.=
net/
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
 drivers/watchdog/npcm_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 28a24caa2627c..a5dd1c2301374 100644
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

@@ -147,6 +155,10 @@ static int npcm_wdt_restart(struct watchdog_device *w=
dd,
 {
 	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);

+	/* For reset, we start the WDT clock and leave it running. */
+	if (wdt->clk)
+		clk_prepare_enable(wdt->clk);
+
 	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
 	udelay(1000);

@@ -191,6 +203,10 @@ static int npcm_wdt_probe(struct platform_device *pde=
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

