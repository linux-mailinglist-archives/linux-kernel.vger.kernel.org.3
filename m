Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB15ADEED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiIFFVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIFFVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:21:07 -0400
Received: from out29-2.mail.aliyun.com (out29-2.mail.aliyun.com [115.124.29.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573B6B159
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:21:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1114191|-1;BR=01201311R101S37rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0674279-0.0371924-0.89538;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.P9-0NMl_1662441660;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.P9-0NMl_1662441660)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 13:21:01 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     maxime@cerno.tech, daniel.lezcano@linaro.org, tglx@linutronix.de,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [RESEND] clocksource: sun4i: add definition of clear interrupt
Date:   Tue,  6 Sep 2022 13:20:56 +0800
Message-Id: <20220906052056.43404-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
index 94dc6e42e983..e5a70aa1deb4 100644
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
@@ -123,7 +124,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
 
 static void sun4i_timer_clear_interrupt(void __iomem *base)
 {
-	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
+	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
 }
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
-- 
2.29.0

