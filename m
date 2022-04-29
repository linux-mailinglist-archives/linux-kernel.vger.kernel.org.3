Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07A51519E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376602AbiD2RYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiD2RYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:24:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693BA527F6;
        Fri, 29 Apr 2022 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651252841;
        bh=IhOdbQHhR5x4m2YHZI3GQ3kZqNDq8I52f2wlB/H7xmQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dA4cH0SDbhY7UYk9O9kn3Rwqm7xs44n0nL1OVpQtvTcXxiTqsuo/Rt4fI+B50M47A
         wW1hMSQlxpQ23uE0N53bUuxqy8jqu9v8ru5Pvd000/ow5s96FsuLOxWsvPMSIqnA9M
         I3URDEZpJhETZjK9I2rjEI3H07pf1C4z4vkSGG7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1oP1uk2O5D-00egWU; Fri, 29
 Apr 2022 19:20:41 +0200
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
Subject: [PATCH v2 3/7] watchdog: npcm: Enable clock if provided
Date:   Fri, 29 Apr 2022 19:20:26 +0200
Message-Id: <20220429172030.398011-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429172030.398011-1-j.neuschaefer@gmx.net>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66AxyOQT8oGkP067LNEqWrXN+/37a9u2A+gPdM7rlN8B6lFXd0C
 8Vk9WD1HaD188zOsZF0JP1gnmOLarpkqZk6LLlwxgzV14Q4++88f76f2rp3T2edEAr6ldgm
 hw8mK0il9mfN4zu/KWIv2bu2HmDhQlbZa5yx/RW0B++GLzdq3+Bo/FtEbvOBlBAQddX6EKl
 Sm0ciC2AUtqmRWUgYx9Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XW/wXwxEP5U=:79Z8+UWKUEfRNtNA52vATW
 wJFlpXQJKhon4qx2TxrMMafIyL42sVkPIPJc2rskAGgzgC/FOeO11fz/QefenLXsMdT2VELUZ
 44RvnWRl9TPWPXFuNifEoW5suiHjvuY/oylL5uONKdU1IKO7S/05YD2iHDLQdJhosyUlszwca
 Ml7tmlixRU25mCTiCL74raMH9tMvSHlCe5iOvP6su/sorGLf8Wl0zthZY7d7afFMdaOkuJIBm
 g3TisDJASG5vMTJzvfDx2RLUS/WrRF0xtWuyyTuNgWVqN7tIPCuVaJY+w8kos6lSVqonJ0AIw
 K+DvAbjynU5mDgi57yL06M1vA0Zh/81frCfu3tr4x+ybQFFyY+8jmwzurKQkbzh+zK129HKMy
 Piqzc4u2jIhptvRb4wt2349hNO2QKXhEWFWvVE4nG+tO6AGA5qYjB9RyVLnrDY0m5ZrAO55VX
 4HrmdaQFZkE1H+WuASdeVgkQ4/XSi92Nss09TT/whzE+coMujv1LjXxzu873DfEuM/JdV1dve
 /6BjlVdcZik3FxrfVEW8v3Y7Frb8aPbBGlu6kN+NUENulhgMQnPE69UtdeWeKh/wPGmyVy3Yo
 QnpdzhUU2eREX/6u+oxsrbQoWXUe7hEFJzRAoiJ7hV5DvtTNLCUbqvIu47Sw2bG7g2JGbMNQ3
 xg1sseJbybmGgPZ6iB8EgHeoavAparMN3E5ZZYefvjp8WF0g/xbmKUdnh1v7mXrtYgLIfH7q7
 kX0+uL/DGFayDSWpid6Oee0WV9Z4FJQlDKBaqXH8kf3vGfK0lnDBropu5VhG6NUxoKld8TEjx
 kxYHUnGvYf1yKfbaW8nepoWjH/MB8+ulZuMJCfBQNb9kVoHCQG/leKLHp2KNz549Xgu6pj3WZ
 1/tmhHj3EwYY9IYDuizRfGxbGxXfS1Q4JsTbidV/g2km8iWaRf52h5uJ8j6e139mOg1Mnu9Cg
 doffYObyOKXwiMY3u7o9xeJ2627y0zmhgTrd5htadJt8Epe46DJt2NEnHSey+N4IGp5BKScFk
 cjxH7sV41R9R0XXihvJ9ZuF6liBUblweYxIhR7O/3sA9V4SSCMeabkEOwV2Y0kzARsDmkzMdp
 y3SNDVoqkCNZpY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v2:
- Add clk_disable_unprepare call, suggested by Guenter Roeck

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gmx.n=
et/
=2D--
 drivers/watchdog/npcm_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 28a24caa2627c..ee08d9805f966 100644
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

@@ -191,6 +199,10 @@ static int npcm_wdt_probe(struct platform_device *pde=
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

