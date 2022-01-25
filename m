Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEE49BCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiAYUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:00:48 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53750 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiAYUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kOyG1sWwu18aKLEFaQlC6p9QjGmhcuHzXFfNWf87nfs=; b=SLN9emv9Sz8pGjHasxCICiAFbl
        rw+PSwPEFbFCshWdsOEuzPBEjhx1kTxouQDiaWKub+wLUhc6y0Wj/taJKbnapMMRgAotP8qqHu4ft
        NP9AQc1MTp3ykhn6t2TB+LjqBGcGtWE2raBVXWfR9mpqC44b8zZz8uI7TK/aJGrAGaEk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzH-0007fC-Rd; Tue, 25 Jan 2022 15:00:20 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:03 -0500
Message-Id: <20220125200009.900660-5-hugo@hugovil.com>
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
Subject: [PATCH 04/10] rtc: pcf2127: adapt for WD registers at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 7a13a34eb21b..82e4af999c29 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -114,6 +114,8 @@ struct pcf21xx_config {
 	unsigned int has_bit_wd_ctl_cd0:1;
 	u8 regs_td_base; /* Time/data base registers. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
+	u8 reg_wd_ctl; /* Watchdog control register. */
+	u8 reg_wd_val; /* Watchdog value register. */
 };
 
 struct pcf2127 {
@@ -297,7 +299,7 @@ static int pcf2127_wdt_ping(struct watchdog_device *wdd)
 {
 	struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
 
-	return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL, wdd->timeout);
+	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val, wdd->timeout);
 }
 
 /*
@@ -331,7 +333,7 @@ static int pcf2127_wdt_stop(struct watchdog_device *wdd)
 {
 	struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
 
-	return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL,
+	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val,
 			    PCF2127_WD_VAL_STOP);
 }
 
@@ -380,7 +382,7 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
 
 	/* Test if watchdog timer is started by bootloader */
-	ret = regmap_read(pcf2127->regmap, PCF2127_REG_WD_VAL, &wdd_timeout);
+	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val, &wdd_timeout);
 	if (ret)
 		return ret;
 
@@ -663,6 +665,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 1,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
@@ -670,6 +674,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 };
 
@@ -759,7 +765,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 * as T. Bits labeled as T must always be written with
 	 * logic 0.
 	 */
-	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_WD_CTL,
+	ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_wd_ctl,
 				 PCF2127_BIT_WD_CTL_CD1 |
 				 PCF2127_BIT_WD_CTL_CD0 |
 				 PCF2127_BIT_WD_CTL_TF1 |
-- 
2.30.2

