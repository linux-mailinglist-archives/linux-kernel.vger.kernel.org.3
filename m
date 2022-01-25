Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127AD49BCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiAYUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:01:04 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53790 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiAYUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tcutbrh+x8Kuv/Erx5ZcMwPmXTKRo6JhYLVxwWOpTIs=; b=nj6vg5uyvzE9O2EufBA9n2ZcFW
        ghIHNRFkLk+7W+qaWiV/qYmGTa07Bzq8B/OtiGMmBd6+P7vPPyonCtLp0JFEqmB72bME4liu3DDF2
        /cY8xpfnmVF+naT6yOHP8jyqFAwh3edyvzQjNg6LFluUt8KOpHdvAWHuoPggnKLLE4w8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzR-0007fC-2t; Tue, 25 Jan 2022 15:00:30 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:07 -0500
Message-Id: <20220125200009.900660-9-hugo@hugovil.com>
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
Subject: [PATCH 08/10] rtc: pcf2127: add support for PCF2131 alarm interrupt on outputs INT_A/B
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
two, named INT_A and INT_B. The alarm interrupt can be routed to
either one or both of them.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index fdce31e169a6..a75deab47284 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -191,6 +191,7 @@ struct pcf21xx_config {
 	int max_register;
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
+	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
 	u8 regs_td_base; /* Time/data base registers. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
@@ -511,6 +512,39 @@ static int pcf2127_rtc_alarm_irq_enable(struct device *dev, u32 enable)
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcf2127->cfg->has_int_a_b) {
+		/*
+		 * The PCF2131 supports two interrupt outputs, INT_A and INT_B.
+		 * The alarm interrupt can be routed to either one or both of
+		 * them. Make sure that at least one output pin is requested.
+		 */
+		if (enable &&
+		    !device_property_read_bool(dev, "alarm-output-a") &&
+		    !device_property_read_bool(dev, "alarm-output-b")) {
+			dev_warn(dev, "no alarm interrupt output pin selected, alarm function will not work\n");
+			return -EINVAL;
+		}
+
+		if (device_property_read_bool(dev, "alarm-output-a")) {
+			ret = regmap_update_bits(pcf2127->regmap,
+						 PCF2131_REG_INT_A_MASK1,
+						 PCF2131_BIT_INT_AIE,
+						 enable ? PCF2131_BIT_INT_AIE : 0);
+			if (ret)
+				return ret;
+		}
+
+		if (device_property_read_bool(dev, "alarm-output-b")) {
+			ret = regmap_update_bits(pcf2127->regmap,
+						 PCF2131_REG_INT_B_MASK1,
+						 PCF2131_BIT_INT_AIE,
+						 enable ? PCF2131_BIT_INT_AIE : 0);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Enable alarm interrupt. */
 	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
 				 PCF2127_BIT_CTRL2_AIE,
 				 enable ? PCF2127_BIT_CTRL2_AIE : 0);
@@ -878,6 +912,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
+		.has_int_a_b = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -901,6 +936,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.has_int_a_b = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -924,6 +960,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x36,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.has_int_a_b = 1,
 		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2131_REG_WD_CTL,
-- 
2.30.2

