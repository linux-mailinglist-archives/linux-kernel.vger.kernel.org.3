Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE44CBA59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiCCJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCCJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:34:31 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AE1D35DDF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:33:44 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADHzfF1iyBiJm8gAg--.15704S2;
        Thu, 03 Mar 2022 17:33:42 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     sre@kernel.org
Cc:     patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] power: supply: Handle error for wm8350_register_irq
Date:   Thu,  3 Mar 2022 17:33:39 +0800
Message-Id: <20220303093339.317966-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHzfF1iyBiJm8gAg--.15704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5KF47urWfWr18Jw48tFb_yoW7XrWkp3
        yIkry7CFyUKrWrXFyruryDZr4DJF47tr9F9ry8Cr1xXa43C3Z5tr4UZFnFqr1rJFW0qwnr
        trW3Kw4ru3WrJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
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
Also, use 'free_' in order to avoid same code.

Fixes: 14431aa0c5a4 ("power_supply: Add support for WM8350 PMU")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/power/supply/wm8350_power.c | 96 ++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index e05cee457471..e1d39e96e656 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -408,44 +408,112 @@ static const struct power_supply_desc wm8350_usb_desc = {
  *		Initialisation
  *********************************************************************/
 
-static void wm8350_init_charger(struct wm8350 *wm8350)
+static int wm8350_init_charger(struct wm8350 *wm8350)
 {
+	int ret;
+
 	/* register our interest in charger events */
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT,
 			    wm8350_charger_handler, 0, "Battery hot", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD,
+	if (ret)
+		goto err;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD,
 			    wm8350_charger_handler, 0, "Battery cold", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
+	if (ret)
+		goto free_CHG_BAT_HOT;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
 			    wm8350_charger_handler, 0, "Battery fail", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
+	if (ret)
+		goto free_CHG_BAT_COLD;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
 			    wm8350_charger_handler, 0,
 			    "Charger timeout", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
+	if (ret)
+		goto free_CHG_BAT_FAIL;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
 			    wm8350_charger_handler, 0,
 			    "Charge end", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
+	if (ret)
+		goto free_CHG_TO;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
 			    wm8350_charger_handler, 0,
 			    "Charge start", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
+	if (ret)
+		goto free_CHG_END;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
 			    wm8350_charger_handler, 0,
 			    "Fast charge ready", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
+	if (ret)
+		goto free_CHG_START;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.9V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
+	if (ret)
+		goto free_CHG_FAST_RDY;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.1V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
+	if (ret)
+		goto free_CHG_VBATT_LT_3P9;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
 			    wm8350_charger_handler, 0,
 			    "Battery <2.85V", wm8350);
+	if (ret)
+		goto free_CHG_VBATT_LT_3P1;
 
 	/* and supply change events */
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
 			    wm8350_charger_handler, 0, "USB", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
+	if (ret)
+		goto free_CHG_VBATT_LT_2P85;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
 			    wm8350_charger_handler, 0, "Wall", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
+	if (ret)
+		goto free_EXT_USB_FB;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
 			    wm8350_charger_handler, 0, "Battery", wm8350);
+	if (ret)
+		goto free_EXT_WALL_FB;
+
+	return 0;
+
+free_EXT_WALL_FB:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_WALL_FB, wm8350);
+free_EXT_USB_FB:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_USB_FB, wm8350);
+free_CHG_VBATT_LT_2P85:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85, wm8350);
+free_CHG_VBATT_LT_3P1:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1, wm8350);
+free_CHG_VBATT_LT_3P9:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9, wm8350);
+free_CHG_FAST_RDY:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY, wm8350);
+free_CHG_START:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_START, wm8350);
+free_CHG_END:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_END, wm8350);
+free_CHG_TO:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_TO, wm8350);
+free_CHG_BAT_FAIL:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL, wm8350);
+free_CHG_BAT_COLD:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD, wm8350);
+free_CHG_BAT_HOT:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT, wm8350);
+err:
+	return ret;
 }
 
 static void free_charger_irq(struct wm8350 *wm8350)
-- 
2.25.1

