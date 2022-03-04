Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662E4CCB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiCDB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiCDB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:58:54 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FAE731DDC;
        Thu,  3 Mar 2022 17:58:05 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACnrfkhciFi_nwxAg--.40389S2;
        Fri, 04 Mar 2022 09:57:55 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ckeepax@opensource.cirrus.com
Cc:     sre@kernel.org, patches@opensource.cirrus.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] power: supply: Handle error for wm8350_register_irq
Date:   Fri,  4 Mar 2022 09:57:51 +0800
Message-Id: <20220304015751.367280-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnrfkhciFi_nwxAg--.40389S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWUCFWfAw45GrykKF4rXwb_yoW7Xw4Up3
        yIkry7CFyUKFW5XF1F9r1DZr4DJF42qrZF9ry8Cr1xXa42k3Z5tr4UZFnFqr1UJFW0qwnx
        trW3tw4ru3WrJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
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
Changelog:

v1 -> v2

* Change 1. Change to non-caps labels.
---
 drivers/power/supply/wm8350_power.c | 96 ++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index e05cee457471..9c46c48dccb1 100644
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
+		goto free_chg_bat_hot;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
 			    wm8350_charger_handler, 0, "Battery fail", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
+	if (ret)
+		goto free_chg_bat_cold;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
 			    wm8350_charger_handler, 0,
 			    "Charger timeout", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
+	if (ret)
+		goto free_chg_bat_fail;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
 			    wm8350_charger_handler, 0,
 			    "Charge end", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
+	if (ret)
+		goto free_chg_to;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
 			    wm8350_charger_handler, 0,
 			    "Charge start", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
+	if (ret)
+		goto free_chg_end;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
 			    wm8350_charger_handler, 0,
 			    "Fast charge ready", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
+	if (ret)
+		goto free_chg_start;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.9V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
+	if (ret)
+		goto free_chg_fast_rdy;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.1V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
+	if (ret)
+		goto free_chg_vbatt_lt_3p9;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
 			    wm8350_charger_handler, 0,
 			    "Battery <2.85V", wm8350);
+	if (ret)
+		goto free_chg_vbatt_lt_3p1;
 
 	/* and supply change events */
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
 			    wm8350_charger_handler, 0, "USB", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
+	if (ret)
+		goto free_chg_vbatt_lt_2p85;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
 			    wm8350_charger_handler, 0, "Wall", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
+	if (ret)
+		goto free_ext_usb_fb;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
 			    wm8350_charger_handler, 0, "Battery", wm8350);
+	if (ret)
+		goto free_ext_wall_fb;
+
+	return 0;
+
+free_ext_wall_fb:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_WALL_FB, wm8350);
+free_ext_usb_fb:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_USB_FB, wm8350);
+free_chg_vbatt_lt_2p85:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85, wm8350);
+free_chg_vbatt_lt_3p1:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1, wm8350);
+free_chg_vbatt_lt_3p9:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9, wm8350);
+free_chg_fast_rdy:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY, wm8350);
+free_chg_start:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_START, wm8350);
+free_chg_end:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_END, wm8350);
+free_chg_to:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_TO, wm8350);
+free_chg_bat_fail:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL, wm8350);
+free_chg_bat_cold:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD, wm8350);
+free_chg_bat_hot:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT, wm8350);
+err:
+	return ret;
 }
 
 static void free_charger_irq(struct wm8350 *wm8350)
-- 
2.25.1

