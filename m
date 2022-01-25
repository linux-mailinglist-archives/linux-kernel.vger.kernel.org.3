Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2049BCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiAYUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:00:49 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53754 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiAYUA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B/QRpNaY7DD+V2iXZi4QDtoMInzkvFDuDrQw73KYfBg=; b=bRxQiCetg16RZMY//pIlMJussf
        WGCQj3RbsCgUxM/0CV9BtLwnLa8VNz62arrf9Z2vCNoqCsViwvDdWWZgPQL48qmzqZAymJGV4ggXv
        8SgVweEhMFVvZDJNaFgN0b84r3pO9mdJvhVH/pH6Cyd/9rpxfwLvHfzy2zdA1zrV11Ug=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzJ-0007fC-3K; Tue, 25 Jan 2022 15:00:21 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:04 -0500
Message-Id: <20220125200009.900660-6-hugo@hugovil.com>
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
Subject: [PATCH 05/10] rtc: pcf2127: adapt for CLKOUT register at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 82e4af999c29..13a7f95f52c5 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -116,6 +116,7 @@ struct pcf21xx_config {
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
+	u8 reg_clkout; /* Clkout register. */
 };
 
 struct pcf2127 {
@@ -667,6 +668,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
@@ -676,6 +678,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 };
 
@@ -743,12 +746,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
 
-	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
+	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
 	if (ret < 0)
 		return ret;
 
 	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
-		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
+		ret = regmap_set_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
 				      PCF2127_BIT_CLKOUT_OTPR);
 		if (ret < 0)
 			return ret;
-- 
2.30.2

