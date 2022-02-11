Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3744B2E80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbiBKUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:36:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352004AbiBKUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:36:02 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105FDCF2;
        Fri, 11 Feb 2022 12:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VtlQGULht92YsYdE9lX3WxpCltrMBfZKtbq5yoFFj7A=; b=csAz+aIYYS33qL4959nBEUfukt
        NbgyFWApRZHQ+AWznxY6onui2+jAqU3NSIHp9R1inEj/Eu9wrfozFkTOnDmSFO2R+/lWSu/ATHK7W
        /AJrgW9OTxqIlAFTFOQ+tswh1s1fBwwtFoZzsIVMyHVviRkV6ICVQ/708X9e/2zYxLOc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55274 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIce3-0005vF-BK; Fri, 11 Feb 2022 15:35:55 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:35:15 -0500
Message-Id: <20220211203520.3902374-10-hugo@hugovil.com>
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
Subject: [PATCH 09/14] rtc: pcf2127: set PWRMNG value for PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Default PWRMNG[2:0] bits are set to 000b for PCF2127/29, but to
111b for PCF2131.

Set these bits to 000b to select same mode as PCF2127/29.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index ee1e9d8285bb..09b3d0ef4eff 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -53,6 +53,7 @@
 #define PCF2127_BIT_CTRL3_BLF			BIT(2)
 #define PCF2127_BIT_CTRL3_BF			BIT(3)
 #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
+#define PCF2127_CTRL3_PWRMNG_MASK		GENMASK(7, 5)
 /* Control register 4 */
 #define PCF2131_REG_CTRL4		0x03
 #define PCF2131_BIT_CTRL4_TSF4			BIT(4)
@@ -1128,6 +1129,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
 
+	/* Make sure PWRMNG[2:0] is set to 000b. This is the default for
+	 * PCF2127/29, but not for PCF2131 (default of 111b).
+	 *
+	 * PWRMNG[2:0]  = 000b:
+	 *   battery switch-over function is enabled in standard mode;
+	 *   battery low detection function is enabled
+	 */
+	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
+				PCF2127_CTRL3_PWRMNG_MASK);
+	if (ret < 0) {
+		dev_err(dev, "PWRMNG config failed\n");
+		return ret;
+	}
+
 	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

