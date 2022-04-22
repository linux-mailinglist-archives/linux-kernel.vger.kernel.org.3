Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C050C3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiDVWna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiDVWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:43:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1661773D8;
        Fri, 22 Apr 2022 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650663731;
        bh=XAbU/WwnBQTi9/OidcyFLjRJfgJl6FaI1cL4Ta59NpE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F2yNof3X8y8hvi/Y8+FiTX2CnlA5T8zdkgbIAfDQXmoXufJ1VUZ41pI81mlXiMINO
         4flm5ao9FuutFjMtZIDCH5n37U0YdMUGXRuI44iyVJFpJjwgQMTU3WlkAmf1ecp2mV
         w9OV7B5Bl8yNmQaJmg3FrKvwvt+Xi3dV6OGkjmGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1o6V013bxO-00zIaz; Fri, 22
 Apr 2022 20:31:47 +0200
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
Subject: [PATCH 2/7] clocksource: timer-npcm7xx: Enable timer 1 clock before use
Date:   Fri, 22 Apr 2022 20:30:07 +0200
Message-Id: <20220422183012.444674-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uovlBSQszsD4TcZ6IjORpDv2zAitS8WCPXKi91TdybsXvyz7lqO
 rC2FC41F/kJUCpFHd1VviHlqQLLBrFbdETf+eE8nbVimOfnWkBZ30HFJmtlAYF1Jwirim+1
 uMWQPfc4mPu19lplwt6TaEE58ze9BYNz5EI1+XTE1tlzCw3t9XOIahvNn5e/tYf/l/wShmM
 vpo+JqSHVFco1wj+MDB2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0eDA97AGZw=:Ng7MfKtb6I8godEPVk0G2X
 seOnAGfWoJs+65+HIlee2xyPeWz5f0C50jvK+jtsUd0ANNNqPIYae7byOZJzrhw/P55iv2A2F
 P1Hr9je1/eAaBX1VPuCOTBA1kzRjTRs72oX2yTHFZYzEl2VFPkCCGuvkcqtfdcjF9sD/PyVl6
 VvoxtkiaRH1IoBCthl603M32eWHgl3urURApkzqdAtLde37y6fFrqEdxaDtgRZsjrP64FxZ5M
 fCepuoUdV1cuZgByc3FjkUXUkRVMjVgz38GbOtizIt7txRL7aaw9bFo7I/xNNYgulEK97c6tT
 11B13KqDQwIQmsSRuaVXMUkgcL2rY/W+gjpy5Dy8GQRhpkqbirxyCGMJMWn0Cs1lvOfXrznoX
 f0RhFAE2ak78U9ga48bwQNGQB9tPzDzj74AC18tLfB5DHqZgHUBpyyef+ru96vlSVbDtErzkb
 cuYvmDj7KLnj2QcaAEZKIQcLw8dg9/227oGn/S/ReCCUBYEh9G3fFLWVxKx5Os4wAsu3AKdt2
 HGnX3Md10TYRJ/pujlic6Fvq2nRjbaY2kdA/u3WGTT3489sd3vUcfXN2Uy9A0r1FJCbmPan+a
 P0cfQNBhbmTzNUzR40OjhhK45J50yU5ZsWV0efr8kNJjM9ITixrcrIviNHwRaWCUTBPJuCReX
 Yz3oZ/O5Pt/ujDvI0qRz58POYsPx1rH12opNEPq+txF1b7ufi116464AFhaVHsv/3FpCmw1jf
 Y3tU5O9FkcXEpfWuA1KqGT/dXKNo0+IHzFfCOWtY4CnRHKA9RMaXfbghDs8j6hZcDzvsahLFD
 7PM4V244nG7aLR5akwg+rkGBxz9NcKCyt0+OyOqz/fSAj/hsA5IYqm9INJTQNBm9waKiDPsmn
 wvxXdyKCDt8Y4V+d51d1L4qQLPjUeSiibWIiYEMK2RoLqr6Vfk0hmXzCldxIhNISVwUhYRKEg
 9euzmV1wP09AFhbQTGmvGoozwj4u+nPxezt28YhzIDvcp/mnFifVrWaiHAcll7tQgIS7aKgyQ
 D3PvycgMCJDuUa3fejgAUbFyqOxDH9nYkKw6GlvpbbP+PziKq4+xNS3NhGbo+3gSQt7I1GaAk
 PxEk+FY3lJ//Mw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the WPCM450 SoC, the clocks for each timer can be gated individually.
To prevent the timer 1 clock from being gated, enable it explicitly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clocksource/timer-npcm7xx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/tim=
er-npcm7xx.c
index a00520cbb660a..974269b6b0c36 100644
=2D-- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -188,17 +188,29 @@ static void __init npcm7xx_clocksource_init(void)

 static int __init npcm7xx_timer_init(struct device_node *np)
 {
+	struct clk *clk;
 	int ret;

 	ret =3D timer_of_init(np, &npcm7xx_to);
-	if (ret)
+	if (ret) {
+		pr_warn("timer_of_init failed: %d\n", ret);
 		return ret;
+	}

 	/* Clock input is divided by PRESCALE + 1 before it is fed */
 	/* to the counter */
 	npcm7xx_to.of_clk.rate =3D npcm7xx_to.of_clk.rate /
 		(NPCM7XX_Tx_MIN_PRESCALE + 1);

+	/* Enable the clock for timer1, if it exists */
+	clk =3D of_clk_get(np, 1);
+	if (clk) {
+		if (!IS_ERR(clk))
+			clk_prepare_enable(clk);
+		else
+			pr_warn("Failed to get clock for timer1: %pe", clk);
+	}
+
 	npcm7xx_clocksource_init();
 	npcm7xx_clockevents_init();

=2D-
2.35.1

