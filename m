Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172B57FB74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiGYIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiGYIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:35:57 -0400
Received: from out29-77.mail.aliyun.com (out29-77.mail.aliyun.com [115.124.29.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8714005
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:35:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1172205|-1;BR=01201311R981S45rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0659521-0.0364658-0.897582;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Od487NL_1658738132;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.Od487NL_1658738132)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 16:35:43 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH 2/2] clocksource: sun4i: add definition of clear interrupt
Date:   Mon, 25 Jul 2022 16:35:22 +0800
Message-Id: <20220725083522.82931-2-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220725083522.82931-1-victor@allwinnertech.com>
References: <20220725083522.82931-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent misunderstanding, use TIMER_IRQ_CLEAR instead of TIMER_IRQ_EN
in function sun4i_timer_clear_interrupt.

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 drivers/clocksource/timer-sun4i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index afc26de963af..dd74405a2666 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -26,6 +26,7 @@
 #define TIMER_IRQ_EN_REG	0x00
 #define TIMER_IRQ_EN(val)		BIT(val)
 #define TIMER_IRQ_ST_REG	0x04
+#define TIMER_IRQ_CLEAR(val)		BIT(val)
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
 #define TIMER_CTL_ENABLE		BIT(0)
 #define TIMER_CTL_RELOAD		BIT(1)
@@ -167,7 +168,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
 
 static void sun4i_timer_clear_interrupt(void __iomem *base)
 {
-	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
+	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
 }
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
-- 
2.29.0

