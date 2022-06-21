Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA25553330
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbiFUNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiFUNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:14:33 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF70E19C26;
        Tue, 21 Jun 2022 06:14:31 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id C824A1C81167;
        Tue, 21 Jun 2022 21:14:28 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 21
 Jun 2022 21:14:28 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 21 Jun
 2022 21:14:28 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Tue, 21 Jun 2022 21:14:28 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 207F462E6B; Tue, 21 Jun 2022 16:14:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 02/18] clocksource: timer-npcm7xx: Add NPCM845 timer support
Date:   Tue, 21 Jun 2022 16:14:08 +0300
Message-ID: <20220621131424.162355-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220621131424.162355-1-tmaimon77@gmail.com>
References: <20220621131424.162355-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM845 timer support, The NPCM845 uses the same timer
controller as the NPCM750.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/clocksource/timer-npcm7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index a00520cbb660..1630daad4df5 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -210,4 +210,5 @@ static int __init npcm7xx_timer_init(struct device_node *np)
 
 TIMER_OF_DECLARE(wpcm450, "nuvoton,wpcm450-timer", npcm7xx_timer_init);
 TIMER_OF_DECLARE(npcm7xx, "nuvoton,npcm750-timer", npcm7xx_timer_init);
+TIMER_OF_DECLARE(npcm8xx, "nuvoton,npcm845-timer", npcm7xx_timer_init);
 
-- 
2.33.0

