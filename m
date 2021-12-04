Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5E4687C4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 22:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379621AbhLDVyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 16:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379169AbhLDVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 16:54:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DDC061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 13:50:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j3so13726059wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEb8bBQagJewWHBtqfwwcwV4cYSi0vIEBAgk0xJn/s0=;
        b=tWU1iRILCon2IGsJZ+QOcUsVjfIGiIo7+PBAd75TTPQNflZjQJBMsANrbGwO3jiWnx
         7/0/J0ntrduakW0bi1UAwu3jrGQauAfgFRttbYeDJQLOC1aOEk6OT806r7FBKo3jWbV9
         RVB7NVMcn5gEjYX0H16ppaaZLdG+gIKbewuo07DLYtG4oeRVkA0/KyO2N0f+62UGGfu5
         hVYnsiQGZU5eD+F/eOy0lngTKlmK/8+segq7mkbAK/1SgcC+/Yy7XBOgj5ez+NKNaad4
         z+FIHuM3oN1TG9R/v3QqXhUL97N6ApouL87Edua3A6rH37Bb4ZZEHpvr8DaSWVVfXjoZ
         yVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEb8bBQagJewWHBtqfwwcwV4cYSi0vIEBAgk0xJn/s0=;
        b=KoMXQ72fpKT6FjuxTWbQIcze5uMv0l8+BT6UQBS732BaIf0s59D3E/6RTSKBkUTbgp
         nai3txLilhcQ0687NVRPiczfe7Ey7aIktMtRrIKHDZmcVJ/KS6SBqgyUMHKh0RA/QQWS
         FXdRdMUfnq6lbDa0YbXi0ZPaoNAHtlm5yRwR/z89/HYj8f4dnmzHjjjCxCrfw8uT1su0
         7xZhN05KDu3f6uUPGgEH1hotxPkesW2mWn/e1nXaq1FNQbtUl+Ay8pp/wa7HaFC1S+Na
         sj/lQa1958yFJ0F6JXPxH3Ddex6EAHh6zykOOLfbSLB4kECVXk6ANxo620VBL0GC5K+B
         sWWw==
X-Gm-Message-State: AOAM530WLlba7E7DnsnLSaYaezKn1BRnbqSMkzmZzvLdV6iXXu2zx5Rx
        VUvQnMuDtEoYN1Z4gM2Ajk+osg==
X-Google-Smtp-Source: ABdhPJwxgArL5m9gzkY+cj69KGRBE7XH+2IKR5k0FGlqqnSEoH59ulCYdN13TPwl2feuzOZXqTzj9Q==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr30816892wrj.478.1638654640492;
        Sat, 04 Dec 2021 13:50:40 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p19sm7164342wmq.4.2021.12.04.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 13:50:40 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 4/8] i2c: exynos5: Add support for ExynosAutoV9 SoC
Date:   Sat,  4 Dec 2021 23:50:29 +0200
Message-Id: <20211204215033.5134-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204215033.5134-1-semen.protsenko@linaro.org>
References: <20211204215033.5134-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaewon Kim <jaewon02.kim@samsung.com>

ExynosAutoV9 functioning logic mostly follows I2C_TYPE_EXYNOS7, but
timing calculation and configuration procedure is changed: e.g. only
timing_s3 has to be set now.

Another change of HSI2C controller in ExynosAutoV9 SoC is that it's now
a part of USIv2 IP-core. No changes is needed for I2C driver though, as
all USI related configuration is done in USI driver.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
Changes in v2:
  - Added R-b tag by Krzysztof Kozlowski

 drivers/i2c/busses/i2c-exynos5.c | 62 +++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c2e4bab11366..5198e71e8dab 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -169,6 +169,7 @@
 enum i2c_type_exynos {
 	I2C_TYPE_EXYNOS5,
 	I2C_TYPE_EXYNOS7,
+	I2C_TYPE_EXYNOSAUTOV9,
 };
 
 struct exynos5_i2c {
@@ -230,6 +231,11 @@ static const struct exynos_hsi2c_variant exynos7_hsi2c_data = {
 	.hw		= I2C_TYPE_EXYNOS7,
 };
 
+static const struct exynos_hsi2c_variant exynosautov9_hsi2c_data = {
+	.fifo_depth	= 64,
+	.hw		= I2C_TYPE_EXYNOSAUTOV9,
+};
+
 static const struct of_device_id exynos5_i2c_match[] = {
 	{
 		.compatible = "samsung,exynos5-hsi2c",
@@ -243,6 +249,9 @@ static const struct of_device_id exynos5_i2c_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-hsi2c",
 		.data = &exynos7_hsi2c_data
+	}, {
+		.compatible = "samsung,exynosautov9-hsi2c",
+		.data = &exynosautov9_hsi2c_data
 	}, {},
 };
 MODULE_DEVICE_TABLE(of, exynos5_i2c_match);
@@ -281,6 +290,31 @@ static int exynos5_i2c_set_timing(struct exynos5_i2c *i2c, bool hs_timings)
 		i2c->op_clock;
 	int div, clk_cycle, temp;
 
+	/*
+	 * In case of HSI2C controllers in ExynosAutoV9:
+	 *
+	 * FSCL = IPCLK / ((CLK_DIV + 1) * 16)
+	 * T_SCL_LOW = IPCLK * (CLK_DIV + 1) * (N + M)
+	 *   [N : number of 0's in the TSCL_H_HS]
+	 *   [M : number of 0's in the TSCL_L_HS]
+	 * T_SCL_HIGH = IPCLK * (CLK_DIV + 1) * (N + M)
+	 *   [N : number of 1's in the TSCL_H_HS]
+	 *   [M : number of 1's in the TSCL_L_HS]
+	 *
+	 * Result of (N + M) is always 8.
+	 * In general case, we don't need to control timing_s1 and timing_s2.
+	 */
+	if (i2c->variant->hw == I2C_TYPE_EXYNOSAUTOV9) {
+		div = ((clkin / (16 * i2c->op_clock)) - 1);
+		i2c_timing_s3 = div << 16;
+		if (hs_timings)
+			writel(i2c_timing_s3, i2c->regs + HSI2C_TIMING_HS3);
+		else
+			writel(i2c_timing_s3, i2c->regs + HSI2C_TIMING_FS3);
+
+		return 0;
+	}
+
 	/*
 	 * In case of HSI2C controller in Exynos5 series
 	 * FPCLK / FI2C =
@@ -422,7 +456,10 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
 
 	/* handle interrupt related to the transfer status */
-	if (i2c->variant->hw == I2C_TYPE_EXYNOS7) {
+	switch (i2c->variant->hw) {
+	case I2C_TYPE_EXYNOSAUTOV9:
+		fallthrough;
+	case I2C_TYPE_EXYNOS7:
 		if (int_status & HSI2C_INT_TRANS_DONE) {
 			i2c->trans_done = 1;
 			i2c->state = 0;
@@ -443,7 +480,12 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 			i2c->state = -ETIMEDOUT;
 			goto stop;
 		}
-	} else if (int_status & HSI2C_INT_I2C) {
+
+		break;
+	case I2C_TYPE_EXYNOS5:
+		if (!(int_status & HSI2C_INT_I2C))
+			break;
+
 		trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 		if (trans_status & HSI2C_NO_DEV_ACK) {
 			dev_dbg(i2c->dev, "No ACK from device\n");
@@ -465,6 +507,8 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 			i2c->trans_done = 1;
 			i2c->state = 0;
 		}
+
+		break;
 	}
 
 	if ((i2c->msg->flags & I2C_M_RD) && (int_status &
@@ -569,13 +613,13 @@ static void exynos5_i2c_bus_check(struct exynos5_i2c *i2c)
 {
 	unsigned long timeout;
 
-	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS5)
 		return;
 
 	/*
-	 * HSI2C_MASTER_ST_LOSE state in EXYNOS7 variant before transaction
-	 * indicates that bus is stuck (SDA is low). In such case bus recovery
-	 * can be performed.
+	 * HSI2C_MASTER_ST_LOSE state (in Exynos7 and ExynosAutoV9 variants)
+	 * before transaction indicates that bus is stuck (SDA is low).
+	 * In such case bus recovery can be performed.
 	 */
 	timeout = jiffies + msecs_to_jiffies(100);
 	for (;;) {
@@ -611,10 +655,10 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	unsigned long flags;
 	unsigned short trig_lvl;
 
-	if (i2c->variant->hw == I2C_TYPE_EXYNOS7)
-		int_en |= HSI2C_INT_I2C_TRANS;
-	else
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS5)
 		int_en |= HSI2C_INT_I2C;
+	else
+		int_en |= HSI2C_INT_I2C_TRANS;
 
 	i2c_ctl = readl(i2c->regs + HSI2C_CTL);
 	i2c_ctl &= ~(HSI2C_TXCHON | HSI2C_RXCHON);
-- 
2.30.2

