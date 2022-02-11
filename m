Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2CD4B2E97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353317AbiBKUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:36:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiBKUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:35:59 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C5CF1;
        Fri, 11 Feb 2022 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wv4FHJN/eexiTb373COf63qSzuJufwmU8rnNAU+bfGY=; b=DYsvLqIW9WnTWiLsN4RYb+3lrG
        0ic3hMxOF8TbBt2GP5HkK1eDVcITCd11wOxWBW8udJiXQn6KS6EXziZg7L6usUaUbtigH8MZRRFev
        jLcs4Ah7NCwo5hffzWLUI3L+qBBTFBnMScHzetKOqYrLJnnRMlK2BvhrJbC4niebA+cQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55274 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIce2-0005vF-8H; Fri, 11 Feb 2022 15:35:54 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:35:14 -0500
Message-Id: <20220211203520.3902374-9-hugo@hugovil.com>
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
Subject: [PATCH 08/14] rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
two, named INT_A and INT_B. The hardware support that any interrupt
source can be routed to either one or both of them.

Force all interrupt sources to go to the INT A pin.

Support to route any interrupt source to INT A/B pins is not supported
by this driver at the moment.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index a52af7465d69..ee1e9d8285bb 100644
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
@@ -879,6 +880,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
+		.has_int_a_b = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -902,6 +904,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.has_int_a_b = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -925,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x36,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.has_int_a_b = 1,
 		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
 		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2131_REG_WD_CTL,
@@ -1017,6 +1021,28 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
 	return ret;
 }
 
+/* Route all interrupt sources to INT A pin. */
+static int pcf2127_configure_interrupt_pins(struct device *dev)
+{
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+	int ret;
+
+	/* Mask bits need to be cleared to enable corresponding
+	 * interrupt source.
+	 */
+	ret = regmap_write(pcf2127->regmap,
+			   PCF2131_REG_INT_A_MASK1, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(pcf2127->regmap,
+			   PCF2131_REG_INT_A_MASK2, 0);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
 {
@@ -1075,6 +1101,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 	}
 
+	if (pcf2127->cfg->has_int_a_b) {
+		/* Configure int A/B pins, independently of alarm_irq. */
+		ret = pcf2127_configure_interrupt_pins(dev);
+		if (ret) {
+			dev_err(dev, "failed to configure interrupt pins\n");
+			return ret;
+		}
+	}
+
 	if (pcf2127->cfg->has_nvmem) {
 		struct nvmem_config nvmem_cfg = {
 			.priv = pcf2127,
-- 
2.30.2

