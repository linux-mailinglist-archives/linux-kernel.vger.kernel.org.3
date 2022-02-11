Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747934B2E88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353335AbiBKUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:36:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353293AbiBKUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:36:04 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51639CE9;
        Fri, 11 Feb 2022 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K2AaiHeuAPOhUIx+banJClIWKx7DCqmxRbmOpC7PYoY=; b=TttlfvumnwWnAE597s4Fm//C6s
        J60XnWZvWKUQjnbhZijREdOqjvUxnpDTsmhYF1qIJfv3GBHLtU7QIVWRNReXt2LupNtQCWdYotdA3
        Lr63dh53E6MkylZ1Kgw7ytOKwBoKedKI1vCqvaXDjMtO/pB633nPclVLf1LSgYCB/6Ik=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55274 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIce6-0005vF-GP; Fri, 11 Feb 2022 15:35:59 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:35:18 -0500
Message-Id: <20220211203520.3902374-13-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211203520.3902374-1-hugo@hugovil.com>
References: <20220211203520.3902374-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/14] rtc: pcf2127: support generic watchdog timing configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Introduce in the configuration structure two new values to hold the
watchdog clock source and the min_hw_heartbeat_ms value.

The minimum and maximum timeout values are automatically computed from
the watchdog clock source value for each variant.

The PCF2131 has no 1Hz watchdog clock source, as is the case for
PCF2127/29.

The next best choice is using a 1/4Hz clock, giving a watchdog timeout
range between 4 and 1016s. By using the same register configuration as
for the PCF2127/29, the 1/4Hz clock source is selected.

Note: the PCF2127 datasheet gives a min/max range between 1 and 255s,
but it should be between 2 and 254s, because the watchdog is triggered
when the timer value reaches 1, not 0.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 56 +++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 84ec7d5fda59..7733122ac971 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -157,9 +157,29 @@
 
 /* Watchdog timer value constants */
 #define PCF2127_WD_VAL_STOP		0
-#define PCF2127_WD_VAL_MIN		2
-#define PCF2127_WD_VAL_MAX		255
-#define PCF2127_WD_VAL_DEFAULT		60
+#define PCF2127_WD_VAL_DEFAULT		60 /* In seconds. */
+/* PCF2127/29 watchdog timer value constants */
+#define PCF2127_WD_CLOCK_HZ_X1000	1000 /* 1Hz */
+#define PCF2127_WD_MIN_HW_HEARTBEAT_MS	500
+/* PCF2131 watchdog timer value constants */
+#define PCF2131_WD_CLOCK_HZ_X1000	250  /* 1/4Hz */
+#define PCF2131_WD_MIN_HW_HEARTBEAT_MS	4000
+/*
+ * Compute watchdog period, t, in seconds, from the WATCHDG_TIM_VAL register
+ * value, n, and the clock frequency, f, in Hz.
+ *
+ * The PCF2127/29 datasheet gives t as:
+ *   t = n / f
+ * The PCF2131 datasheet gives t as:
+ *   t = (n - 1) / f
+ * For both variants, the watchdog is triggered when the WATCHDG_TIM_VAL reaches
+ * the value 1, and not zero. Consequently, the equation from the PCF2131
+ * datasheet seems to be the correct one for both variants.
+ */
+#define WD_PERIOD_S(_n_, _f1000_) ((1000 * ((_n_) - 1)) / (_f1000_))
+
+/* Compute value of WATCHDG_TIM_VAL to obtain period t, in seconds. */
+#define WD_COUNTER(_t_, _f1000_) ((((_t_) * (_f1000_)) / 1000) + 1)
 
 /* Mask for currently enabled interrupts */
 #define PCF2127_CTRL1_IRQ_MASK (PCF2127_BIT_CTRL1_TSF1)
@@ -202,6 +222,11 @@ struct pcf21xx_config {
 	u8 reg_wd_val; /* Watchdog value register. */
 	u8 reg_clkout; /* Clkout register. */
 	u8 reg_reset;  /* Reset register if available. */
+
+	/* Watchdog configuration. */
+	int wdd_clock_hz_x1000; /* Value in Hz multiplicated by 1000 */
+	int wdd_min_hw_heartbeat_ms;
+
 	unsigned int ts_count;
 	struct pcf21xx_ts_config ts[4];
 	struct attribute_group attribute_group;
@@ -496,10 +521,19 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	pcf2127->wdd.parent = dev;
 	pcf2127->wdd.info = &pcf2127_wdt_info;
 	pcf2127->wdd.ops = &pcf2127_watchdog_ops;
-	pcf2127->wdd.min_timeout = PCF2127_WD_VAL_MIN;
-	pcf2127->wdd.max_timeout = PCF2127_WD_VAL_MAX;
-	pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
-	pcf2127->wdd.min_hw_heartbeat_ms = 500;
+
+	pcf2127->wdd.min_timeout =
+		WD_PERIOD_S(2, pcf2127->cfg->wdd_clock_hz_x1000);
+	pcf2127->wdd.max_timeout =
+		WD_PERIOD_S(255, pcf2127->cfg->wdd_clock_hz_x1000);
+	pcf2127->wdd.timeout = WD_COUNTER(PCF2127_WD_VAL_DEFAULT,
+					  pcf2127->cfg->wdd_clock_hz_x1000);
+
+	dev_dbg(dev, "%s min = %ds\n", __func__, pcf2127->wdd.min_timeout);
+	dev_dbg(dev, "%s max = %ds\n", __func__, pcf2127->wdd.max_timeout);
+	dev_dbg(dev, "%s def = %d\n", __func__, pcf2127->wdd.timeout);
+
+	pcf2127->wdd.min_hw_heartbeat_ms = pcf2127->cfg->wdd_min_hw_heartbeat_ms;
 	pcf2127->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
 	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
@@ -926,6 +960,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 1,
 		.ts[0] = {
 			.regs_base = PCF2127_REG_TS1_BASE,
@@ -951,6 +987,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 1,
 		.ts[0] = {
 			.regs_base = PCF2127_REG_TS1_BASE,
@@ -977,6 +1015,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_val = PCF2131_REG_WD_VAL,
 		.reg_clkout = PCF2131_REG_CLKOUT,
 		.reg_reset  = PCF2131_REG_SR_RESET,
+		.wdd_clock_hz_x1000 = PCF2131_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2131_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 4,
 		.ts[0] = {
 			.regs_base = PCF2131_REG_TS1_BASE,
@@ -1214,7 +1254,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 	/*
 	 * Watchdog timer enabled and reset pin /RST activated when timed out.
-	 * Select 1Hz clock source for watchdog timer.
+	 * Select 1Hz clock source for watchdog timer (1/4Hz for PCF2131).
 	 * Note: Countdown timer disabled and not available.
 	 * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
 	 * of register watchdg_tim_ctl. The bit[6] is labeled
-- 
2.30.2

