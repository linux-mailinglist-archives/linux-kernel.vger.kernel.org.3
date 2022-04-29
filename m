Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CC515199
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiD2RYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiD2RY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:24:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD64C790;
        Fri, 29 Apr 2022 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651252840;
        bh=KjOTaewkXeg9gD63/HWGEfLtPHd2o/Nc1ZX9pL1ItJU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fFKo+3FN3UNC4U+2YAFSv/d5O/JNFoCcTVYmlaK5MK5v6vvEtXWx+xJ38FybQNk8n
         pi7K5syL1mamdZl4Quns2rgkcxH/0y8KCi2IDGmQNgsP/ej60Q8cfRcViOv821f9jL
         sxrpMltzCuNOk0DtF+db46Fi/H6Uw+OtcMHlwi1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1o2ZLN1Vx3-00rFqR; Fri, 29
 Apr 2022 19:20:40 +0200
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
Subject: [PATCH v2 2/7] clocksource: timer-npcm7xx: Enable timer 1 clock before use
Date:   Fri, 29 Apr 2022 19:20:25 +0200
Message-Id: <20220429172030.398011-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429172030.398011-1-j.neuschaefer@gmx.net>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F0+IFMLwve1L01E5CbdzpXZxEC0gnGkE9a9+pZhDgs7EwhdNaGh
 E1hluldQg3kkl+1INd3E7S8dTQgQ9HPZR2BbRTxEokRuS3BFevdFBa13+ypjpPS6lKM/EdL
 9piJW4rKikAiJZwMwKGIvJRj5ZQm7HdNQIF8NQe/EoGdcJN7Q0Hdu6h72LC1KRLn6/d4LtK
 NaXntm46PxSIKEGKff71A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9zb9H0jIH8=:GjPNtl7S/40sSf5720RMYP
 eT78eAyQB5ybkGXAP74BN0IdHf19AmQk16ZrbNCkPBc2jgUofVhI1gNCaQwLcZWmOqajQ02HP
 UDe+R7Om/NRe2Y93Q3j/NblA4AfQBgZg8pB2kn7CKcAWtOOpRsX+1WW/SQIcUgtRN3TCD6QkW
 RPQKtSdMbTxDVObbBakJP4yk2F8YjnZABQyF9YiY3c29GDlavTTPJT4U/BstLYVL7R3U9XCaj
 75vW5TCFDZ3rjrkOweqwRR1X9Xu3X2TeZCDJM3JMy7JCsQCt7tRwqTtS1OLMBR7A1c9olYhXB
 WAHawMIrSiFnSAOa4eaXHOu4pv7GS6TZnwv1sht5Y2HCvncPKntmVjRiNqCyf/elrRDIchywb
 1wKSbNNpYQtm5PYHNzX0m/eZjRd1wbYm2EbHrh+ZHge0GpjdC1OygAKqb77fg6oyTijkNvi8S
 xC6tsmbAHllH/S6gik7zOgUBtcrYDpSjtiS8fhARU6WWMztEBn1EQE8dmHEn+TT1qgK6U9TSw
 5pydtrW1BQqaDJgOnfr7A0DkdsCk2P+gghsIm+sk3CKV2L2SEcrF5GC5O0ArLirb0KJNdE7s/
 I736sLwQkscHcbEW4/+B1clyyzE6Hrk0GTWsKdf6sc28aXtoKcSmvcKmR6iq1nUvWZdpmQkDR
 PEFg79afpMOhljpt54QccOqjlan26P04dJpTlhTntnKnagUKhDz8xUuIuDoQPbdmKS+Y+RX3q
 y1ws/xCjVfZWebyd+lIKpxl0ewn0K3+snNQJPwVMdOjyOCa/UgbSGXokLHd/T0cs+7BUJrxiG
 t3WLwkn/Gd4H6T8djfPLqyV4PGtXoZf652RXJopHcNAg9WWMLaq7XRufq1uEGqplzgN8h57ul
 TAllRufMmrbelvcTHnZjORlg7IceaI2cRqZ60FYPnV+sk4cUHzisPGnhk9zLETMUqnj0JfPMM
 G4XnEsJ2ZMA9gGdGBKTNvniirSfL7Bx2udvV3uDLI1jZ//OsHn00n9H35Io+8B5bPr3U/2Xt0
 OHIu9uEs5az8CG91t82K15C3Dkj1RP8IT+lStp9MZAfk9WTvzy6fU5xIftBdSmJFFPukL4ouS
 KuhLYz+pwn4q94=
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

v2:
- Provide context in pr_warn message

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-3-j.neuschaefer@gmx.n=
et/
=2D--
 drivers/clocksource/timer-npcm7xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/tim=
er-npcm7xx.c
index a00520cbb660a..9af30af5f989a 100644
=2D-- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -188,6 +188,7 @@ static void __init npcm7xx_clocksource_init(void)

 static int __init npcm7xx_timer_init(struct device_node *np)
 {
+	struct clk *clk;
 	int ret;

 	ret =3D timer_of_init(np, &npcm7xx_to);
@@ -199,6 +200,15 @@ static int __init npcm7xx_timer_init(struct device_no=
de *np)
 	npcm7xx_to.of_clk.rate =3D npcm7xx_to.of_clk.rate /
 		(NPCM7XX_Tx_MIN_PRESCALE + 1);

+	/* Enable the clock for timer1, if it exists */
+	clk =3D of_clk_get(np, 1);
+	if (clk) {
+		if (!IS_ERR(clk))
+			clk_prepare_enable(clk);
+		else
+			pr_warn("%pOF: Failed to get clock for timer1: %pe", np, clk);
+	}
+
 	npcm7xx_clocksource_init();
 	npcm7xx_clockevents_init();

=2D-
2.35.1

