Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F34B2EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353453AbiBKUvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:51:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353425AbiBKUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:50:55 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E9CEC;
        Fri, 11 Feb 2022 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HmmltoINHI01K88EtWHY5eRcs24eb/8vx1n0+e8dIH4=; b=TJm8KgfwXpWMRnhCSp0JlwdilE
        xpGwf3SemlGElC9/fOS4SCMeC5W5P5dCixQKmd1SEq4lIJQFlCmEpnJCfSmDuJccjstlRZ3DP1fzg
        HjdT63urroBwci0BZxBd7/cWOz9R1rsH0Cq6z2Ppuq4huyaHRAIwrHOou0rklM2OBwms=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55280 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcsU-00067w-Ik; Fri, 11 Feb 2022 15:50:51 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:50:19 -0500
Message-Id: <20220211205029.3940756-5-hugo@hugovil.com>
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
Subject: [PATCH v2 04/14] rtc: pcf2127: adapt for WD registers at any offset
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
index d89bcb17e12a..2c5cda04e21b 100644
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
 
@@ -664,6 +666,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 1,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
@@ -671,6 +675,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 };
 
@@ -771,7 +777,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
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

