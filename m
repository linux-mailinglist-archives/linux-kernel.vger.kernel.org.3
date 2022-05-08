Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3851F0D9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiEHTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEHTsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1760BC23;
        Sun,  8 May 2022 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039025;
        bh=n76/hLRRaMIrLkiSBCnvLg8F9/bppo8blXTP7lMhyu8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JsMF/b6z2Skbt7dmEjaQFgi6n9aqnm+yZEXi1SShVosusMlDmprqtCk7KYMW+xJGh
         Kzzk9IFiSm7haSLwph0ncQnntmtHe5hKRPQh+fH6h58KpHinu+tm6JFvzfa+G0M5us
         Vf7GANO/ublwGjiAzpZccFqkGZMm1bd0N7eyaHJI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1nH8hM1DHl-00XIKc; Sun, 08
 May 2022 21:43:45 +0200
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
Subject: [PATCH v3 2/7] clocksource: timer-npcm7xx: Enable timer 1 clock before use
Date:   Sun,  8 May 2022 21:43:27 +0200
Message-Id: <20220508194333.2170161-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWq1JPNigWSSaZHAqUAune7+HNV0oDFRi3ixapHifQJW0Vw3bl/
 ZoyJWWix1P1YxeKAny6kOHF4FsWecJhiDo5Op2QjeFM+JDOeeYyzhycm3Hw/owLu+uB7wj/
 VLvVbzMZeQ9vIrhVFIlFCv/3JfTOULSFwDy3qoDCRrYVsVipPTVfSv+YfbSTYkNyvE0TRd3
 UzseGXZwNwnHRnzeqk74Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9SqJwJa9skw=:TtwrXU+6EBNvKZjWzfmS89
 Op3XOyAcftg/gHGbODC7HSllJCQpDC4Q6PGOTYQsPRxJXHQakAPqqg1f0SD1KV+oePCXNTgYf
 L2CsSSYunb75A1sOVWh287HuaW8PsMNscNn5caV/yZ2Yvs8c9zUth8DWjfk+3v4guVXxkw9Ht
 H37inUOmOpm5ryEzdTiaFbSk2EtggvmfDAXi2m2kzxYjW54dXAF2dd0ly+MYezDoST4aVEMjj
 0Rg4/8lp4FlmvVL1GtmGW9dIcAAAxO1Zn4hXmKKwsmkq9+R8FOAUlyPVu0wLJ/XHENWR4q4t0
 bmzvxRE78a47zxKMe7qZMUGl8mS+wmPExe4HqCfL9Bq4Y/i1JdaQB1n58fahr0p90AdIyUsAh
 6AUc8ZlTc9c82fexYbiigJpo+IB+m5pnGPK2pUP+Z8xNC7Yixminpqm3ZKTHDL9B6Z04yRuxF
 eqoPCuxO17cKZ8k2D5g7gXiqz9DrlfhQEeWzjRRwEJZXbHcu994oU8zlaffRRYCDZUwZPgMHp
 PIi8g6IfWxMHqHjhSAbn4dYEEasd4DlIkfqCsWEKbYj/Ts65v2q3xAAHeo41XiBPflBCWO1+d
 f8sfLZqyTi8K0WhsiDmRlIcWGyi1U4BqL+UuwlIpZMGiEQ6bT2a99QU8smbictQWGntTrWYDM
 vyhk4/T02WVt69YxD7GtcaDqzAbEsQFdz+Lvi/Lufkkn+qLfa44pysndmuGhGcQ9CEHuUqtkq
 34ybixg9Mb7U9OiKBrODAltqZ2nJhxr1ZzMWgUBJgNfsj9WsfIuD2VhSO2/nFdSQe+MnvWTh8
 YD8cFADF+QJnsS+rPo7h4bBFdmPQh3X8uC5j43xasIZawB/Sx5bXpLiucqjgZVs4ij8JSpR7M
 YaNfTJi9hKV2/CeFnRj43RUsRZ7DvNV/KR7PxTE1lHSJ22nS8fLyp2HdMUv34wBo7Wyo9ri3B
 mT2Mag489GvzYFH4uOrKxK/y9W5KAVd6pSBKia123ORKtbX0b1rzdEMrRST9gIFr2c2xdqo3+
 hYPbmoy/Ptem282D/WFggiKkkgtaLs3B+4Lil3tRlwsDyvd0K4qofFScheSdTXvj9+OsXnVsG
 4NGl0QfWIdGqXA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the WPCM450 SoC, the clocks for each timer can be gated individually.
To prevent the timer 1 clock from being gated, enable it explicitly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- no changes

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

