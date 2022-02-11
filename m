Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9E4B2EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353530AbiBKUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:51:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353508AbiBKUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:51:15 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C8D81;
        Fri, 11 Feb 2022 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=szliCvhlN5Z9BaTB8NpXRzmfXL5JLtC0U/5WIBQHRGk=; b=ekCZc4yQpiC+JEB49fs1dM/ub9
        tsoZJNGmRWN7YATnaGVHCsq+bjCXt8c38hEdUqHrf+8ej47Ynp/m4xEv5BZld7BUacKY3t9EmCJUj
        SxdOx3qtztHYVteEn/F7NhVwP72RUgSOWlBdw8sA7XSkCSVM9WJO725+asuD7wWKmMNw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55280 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcse-00067w-3k; Fri, 11 Feb 2022 15:51:00 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:50:25 -0500
Message-Id: <20220211205029.3940756-11-hugo@hugovil.com>
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
Subject: [PATCH v2 10/14] rtc: pcf2127: read and validate PCF2131 device signature
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make sure the device we are probing is really the device we are
interested in.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 09b3d0ef4eff..8f3b34efff7f 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -193,11 +193,13 @@ struct pcf21xx_config {
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
 	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
+	unsigned int has_reset_reg:1; /* If variant has a reset register. */
 	u8 regs_td_base; /* Time/data base registers. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
 	u8 reg_clkout; /* Clkout register. */
+	u8 reg_reset;  /* Reset register if available. */
 	unsigned int ts_count;
 	struct pcf21xx_ts_config ts[4];
 	struct attribute_group attribute_group;
@@ -882,6 +884,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
 		.has_int_a_b = 0,
+		.has_reset_reg = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -906,6 +909,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.has_int_a_b = 0,
+		.has_reset_reg = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -930,11 +934,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.has_int_a_b = 1,
+		.has_reset_reg = 1,
 		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2131_REG_WD_CTL,
 		.reg_wd_val = PCF2131_REG_WD_VAL,
 		.reg_clkout = PCF2131_REG_CLKOUT,
+		.reg_reset  = PCF2131_REG_SR_RESET,
 		.ts_count = 4,
 		.ts[0] = {
 			.regs_base = PCF2131_REG_TS1_BASE,
@@ -1074,6 +1080,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	pcf2127->rtc->uie_unsupported = 1;
 	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 
+	/* Read device signature if available. */
+	if (pcf2127->cfg->has_reset_reg) {
+		ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_reset, &val);
+		if (ret < 0) {
+			dev_err(dev, "reading RESET register failed\n");
+			return ret;
+		}
+
+		if (val != PCF2131_SR_RESET_READ_PATTERN) {
+			dev_err(dev, "invalid device signature: $%02X\n", (u8)val);
+			return -ENODEV;
+		}
+	}
+
 	if (alarm_irq > 0) {
 		unsigned long flags;
 
-- 
2.30.2

