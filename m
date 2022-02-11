Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30D4B2ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353448AbiBKUu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353418AbiBKUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:50:54 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7AD41;
        Fri, 11 Feb 2022 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SlZVZNfID4SmiU/kFH3QpzW+/WWEj5iMn2pgnUjkjTU=; b=RNalE+oqfU84duty87bTw/JboR
        m8xsolEaAI9+Dt5Ir7YzIkX7N70isiKhESN7+NAQxxLj65Q78wAECqDknbYqsNzREeYygdexbos9N
        9/fNGRVltZdpNbIVhyqPZD8C1MhY1kdXfm4nOH30e9OeReBauknhTL++tSGvG9I72Kbg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55280 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcsT-00067w-7s; Fri, 11 Feb 2022 15:50:50 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:50:18 -0500
Message-Id: <20220211205029.3940756-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211205029.3940756-1-hugo@hugovil.com>
References: <20220211205029.3940756-1-hugo@hugovil.com>
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
Subject: [PATCH v2 03/14] rtc: pcf2127: adapt for alarm registers at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index dcc0f22586fc..d89bcb17e12a 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -56,11 +56,14 @@
 /* Time and date registers bits */
 #define PCF2127_BIT_SC_OSF			BIT(7)
 /* Alarm registers */
-#define PCF2127_REG_ALARM_SC		0x0A
-#define PCF2127_REG_ALARM_MN		0x0B
-#define PCF2127_REG_ALARM_HR		0x0C
-#define PCF2127_REG_ALARM_DM		0x0D
-#define PCF2127_REG_ALARM_DW		0x0E
+#define PCF2127_REG_ALARM_BASE		0x0A
+/* Alarm registers offsets (starting from base register) */
+#define PCF2127_OFFSET_ALARM_SC		0
+#define PCF2127_OFFSET_ALARM_MN		1
+#define PCF2127_OFFSET_ALARM_HR		2
+#define PCF2127_OFFSET_ALARM_DM		3
+#define PCF2127_OFFSET_ALARM_DW		4
+/* Alarm bits */
 #define PCF2127_BIT_ALARM_AE			BIT(7)
 /* CLKOUT control register */
 #define PCF2127_REG_CLKOUT		0x0f
@@ -110,6 +113,7 @@ struct pcf21xx_config {
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
 	u8 regs_td_base; /* Time/data base registers. */
+	u8 regs_alarm_base; /* Alarm function base registers. */
 };
 
 struct pcf2127 {
@@ -402,18 +406,18 @@ static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
-			       sizeof(buf));
+	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
+			       buf, sizeof(buf));
 	if (ret)
 		return ret;
 
 	alrm->enabled = ctrl2 & PCF2127_BIT_CTRL2_AIE;
 	alrm->pending = ctrl2 & PCF2127_BIT_CTRL2_AF;
 
-	alrm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
-	alrm->time.tm_min = bcd2bin(buf[1] & 0x7F);
-	alrm->time.tm_hour = bcd2bin(buf[2] & 0x3F);
-	alrm->time.tm_mday = bcd2bin(buf[3] & 0x3F);
+	alrm->time.tm_sec = bcd2bin(buf[PCF2127_OFFSET_ALARM_SC] & 0x7F);
+	alrm->time.tm_min = bcd2bin(buf[PCF2127_OFFSET_ALARM_MN] & 0x7F);
+	alrm->time.tm_hour = bcd2bin(buf[PCF2127_OFFSET_ALARM_HR] & 0x3F);
+	alrm->time.tm_mday = bcd2bin(buf[PCF2127_OFFSET_ALARM_DM] & 0x3F);
 
 	return 0;
 }
@@ -447,14 +451,14 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	buf[0] = bin2bcd(alrm->time.tm_sec);
-	buf[1] = bin2bcd(alrm->time.tm_min);
-	buf[2] = bin2bcd(alrm->time.tm_hour);
-	buf[3] = bin2bcd(alrm->time.tm_mday);
-	buf[4] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
+	buf[PCF2127_OFFSET_ALARM_SC] = bin2bcd(alrm->time.tm_sec);
+	buf[PCF2127_OFFSET_ALARM_MN] = bin2bcd(alrm->time.tm_min);
+	buf[PCF2127_OFFSET_ALARM_HR] = bin2bcd(alrm->time.tm_hour);
+	buf[PCF2127_OFFSET_ALARM_DM] = bin2bcd(alrm->time.tm_mday);
+	buf[PCF2127_OFFSET_ALARM_DW] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
 
-	ret = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
-				sizeof(buf));
+	ret = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
+				buf, sizeof(buf));
 	if (ret)
 		return ret;
 
@@ -659,12 +663,14 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
+		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
+		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 	},
 };
 
-- 
2.30.2

