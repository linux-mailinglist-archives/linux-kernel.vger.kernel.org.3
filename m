Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32664B2E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353274AbiBKUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:35:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbiBKUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:35:52 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33DCEF;
        Fri, 11 Feb 2022 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8CdyIHSXKPv3TDN98TzS/C5SoJwYhyk3U3q/EcXPZ/Q=; b=t/T8IqZmu3OgriJx2oM4MrnQ9u
        pv6O69qn19RdcXn7Qw36dlgh55ib3fxehz5YcEhek+A/hnNnX61eNHA3HWc/r8gGRRnan3v6Ct56L
        M81T+j/EwHZgyBipn9Tuz90V03vB24wYRhfl5qqQEGKehRDloeCA6jVAlcFF7j8fF7fo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55274 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcdw-0005vF-C0; Fri, 11 Feb 2022 15:35:48 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:35:11 -0500
Message-Id: <20220211203520.3902374-6-hugo@hugovil.com>
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
Subject: [PATCH 05/14] rtc: pcf2127: adapt for CLKOUT register at any offset
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
index 2c5cda04e21b..c73574b59c9d 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -116,6 +116,7 @@ struct pcf21xx_config {
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
+	u8 reg_clkout; /* Clkout register. */
 };
 
 struct pcf2127 {
@@ -668,6 +669,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
@@ -677,6 +679,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 };
 
@@ -755,12 +758,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
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

