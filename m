Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFF49BCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiAYUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:00:46 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53748 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAYUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eATl0qgN7ci/PWi9awRfY3je1TXi6NanvAhX5ozDB/k=; b=Vq/hR9hxJ3vJo7Ih+OfMA2tpb6
        0VFOPNK+1ihCEA6lOCL898dxwqItkm/YHez8uTJIZqiTkSk7YVoT+daWSPpGyEjthtiAyCj9iXvdV
        Dcx1VPPEcbfShkxI35M55cRAC5C8UVn3lYfqr5/77nX/OrI0GvMzLSGSFHCdgvjH6oBU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzG-0007fC-CR; Tue, 25 Jan 2022 15:00:19 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:02 -0500
Message-Id: <20220125200009.900660-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125200009.900660-1-hugo@hugovil.com>
References: <20220125200009.900660-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 03/10] rtc: pcf2127: adapt for alarm registers at any offset
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
index 144b4da8d7f1..7a13a34eb21b 100644
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
@@ -401,18 +405,18 @@ static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
@@ -446,14 +450,14 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
 
@@ -658,12 +662,14 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
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

