Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6810850C371
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiDVWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiDVWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:43:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4B1765EC;
        Fri, 22 Apr 2022 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650663703;
        bh=8RE6J/48SaezMLYOSRQdb+dos/63a0S80cGWNaaY89M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bXqN0HxN/QQTsPVdZP4VwcyzjGY8iA92O8TmXTtJqtf628Jb9RnNaDSWWlVJSamfu
         LVrCT6xfdBwD0xHIJEtlOP+Jv7Ydwi4wxzEv/Ky+/7G3hfhkjTD4AnuF7vo6+Y4nSz
         pw514YWPfkzdRJHC9a/hcVUqM5zCjTCqXE6GfHq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1nNDlI3YKj-00WIp0; Fri, 22
 Apr 2022 20:31:49 +0200
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
Subject: [PATCH 3/7] watchdog: npcm: Enable clock if provided
Date:   Fri, 22 Apr 2022 20:30:08 +0200
Message-Id: <20220422183012.444674-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DzdlIpOpxoHVmzoWSwK/nL5QieYQdzPf0cfyielup2/bHsKDAwQ
 N2kbPBEm068bJ2qlsUpy1PuMDBxL0Al4q+6mC29jVCwWJ/ZDGDodyr0gOx42IbCkPI7CSfx
 IoV+Hxjssgj5OQwTO2pN9A2e91iagZFyoIx2I3C0VnPPyceNuz2gFz1TMWf3aXtkNj8+Rde
 HcSt22thU4XWdRXPBq43A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CBOfWkKmFVM=:FRw7nNLWbQ3bNBPv90sVik
 qODJZKuinuG5QGsuYOs/jvHQDVAwkxAhbrVKGyHAfejM02F1o6pXo6Y53EgqoqL+f20r/hEBO
 VHTj8XfmXgX0C1S8IleVp2m2obNr9mee52dRf6O88DoMm2X7FBtOo0Pbcjimat1k92swzUkZX
 nMRDluyneiJgxhQ2oHIpStiY8+Y8+T0JA3Hp9QNpwkrlilL9Eb1k2H6GvOslXWCtsa0Ywha6E
 oeBd2tfshMcuis970o4dXC6i1DSaLkmVy7b4NfUqok0BRcKmBZ4G1dLqHITq3EnmlKT4hKcOe
 xuSfm2VI5SKq6uJuWVMNXymlkbfSCf85jtPqgCgpyJcYZ8nGGBfcwzscooefR9lXFD3X4ia/t
 IXdiwBDm0SsHb8N7E1LLRHyQb8RxgfhwsRAinHUVfskP/AtdwOO2/cUqE9JdbEHVz3JioBkul
 Vu9x2vN/THEL2RPnVTgm/ZhxBtuI7kcRsL7BAmeL0fstcrpTqhSHrQa3YdPts2oJM7YHaah0O
 vqCYCffcjZtKuJvTcAlqOEhRBXvMSAdx9Ls/THjGaLt8uvKCAVk6tnJaILFfYmk52RxJUW26U
 sZ2hopESgei/M5uelSeRHdEx2nxxed56Mo5JNT0EdX3HogPkRJ+64+1ZmfbcjNBm3TTCtJ1pk
 zwSCtgn0dhhD4GEKUNiv1ruTHBAEIaS3JJYdhTHb85UYpg/CKck+bLvS1FZaZzHzEWnL78sGp
 XamLpO/CUQMLD4lUf71TWCNinLhqAqxRuUa2evW3aiXBlMhIuKmSXcsceXDhUzHCdCWmDQYJs
 5Z8i1m+r+M0wPWu8yaRSyJ2G25MzlyuWozFVNwAVgOs7KR37f+ElSo9McLk7Z0rlbIJYB4qRh
 lK6tFnJS9P/S6q2p9q1vDnx2P2qwU7ijdI7Kb3ibOf5YFr6pc6EwTm6inHkK5RxgxOPfyybaP
 M78QedtmEKiLOJQdYwr58JVKfKkuu1kC+xgjXbjq6ZJRNg/TeMfo/O8i9o5EJ1ckbkb74RYaO
 RElyBVxbk3HOApjbdJHAVPnB28rD6nTZDNl5mmiFTCAFu/0R/1Y4G+teLqb8r0FJWOIoJQFoh
 CvWx+XXBm1Xaw0=
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
 drivers/watchdog/npcm_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 28a24caa2627c..6d27f0e16188e 100644
=2D-- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2018 IBM Corp.

 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -180,6 +181,7 @@ static int npcm_wdt_probe(struct platform_device *pdev=
)
 {
 	struct device *dev =3D &pdev->dev;
 	struct npcm_wdt *wdt;
+	struct clk *clk;
 	int irq;
 	int ret;

@@ -191,6 +193,13 @@ static int npcm_wdt_probe(struct platform_device *pde=
v)
 	if (IS_ERR(wdt->reg))
 		return PTR_ERR(wdt->reg);

+	clk =3D devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk)
+		clk_prepare_enable(clk);
+
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
=2D-
2.35.1

