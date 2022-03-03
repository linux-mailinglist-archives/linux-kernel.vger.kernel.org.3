Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9461E4CB99A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiCCIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiCCIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:51:28 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78997175867
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:50:42 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADHzsJXgSBi1y6qAQ--.4443S2;
        Thu, 03 Mar 2022 16:50:32 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     patches@opensource.cirrus.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] rtc: rtc-wm8350: Handle error for wm8350_register_irq
Date:   Thu,  3 Mar 2022 16:50:30 +0800
Message-Id: <20220303085030.291793-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHzsJXgSBi1y6qAQ--.4443S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFW8tF43Xry3Gw4fXF4DXFb_yoW8JrWUpF
        42kry7CryFg3yru3WF9ry7Jrs8Ga1xtrW0grWjkws2vFyfArn5Jr4DZFyjqr1UGFWrta4q
        vw43Kr4rur18ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjxR65UUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the wm8350_register_irq(),
it should be better to check it and return error if fails.
Also, it need not free 'wm_rtc->rtc' since it will be freed
automatically.

Fixes: 077eaf5b40ec ("rtc: rtc-wm8350: add support for WM8350 RTC")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/rtc/rtc-wm8350.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index 2018614f258f..6eaa9321c074 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -432,14 +432,21 @@ static int wm8350_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	wm8350_register_irq(wm8350, WM8350_IRQ_RTC_SEC,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_RTC_SEC,
 			    wm8350_rtc_update_handler, 0,
 			    "RTC Seconds", wm8350);
+	if (ret)
+		return ret;
+
 	wm8350_mask_irq(wm8350, WM8350_IRQ_RTC_SEC);
 
-	wm8350_register_irq(wm8350, WM8350_IRQ_RTC_ALM,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_RTC_ALM,
 			    wm8350_rtc_alarm_handler, 0,
 			    "RTC Alarm", wm8350);
+	if (ret) {
+		wm8350_free_irq(wm8350, WM8350_IRQ_RTC_SEC, wm8350);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.25.1

