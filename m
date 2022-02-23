Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4A4C1A78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiBWSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243747AbiBWSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:00:45 -0500
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D64248C;
        Wed, 23 Feb 2022 10:00:17 -0800 (PST)
Received: from [77.244.183.192] (port=62116 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nMvvz-00039p-AE; Wed, 23 Feb 2022 19:00:15 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 8/8] rtc: max77686: add MAX77714 support
Date:   Wed, 23 Feb 2022 18:59:08 +0100
Message-Id: <20220223175908.191618-9-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223175908.191618-1-luca@lucaceresoli.net>
References: <20220223175908.191618-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC included in the MAX77714 PMIC is very similar to the one in the
MAX77686. Reuse the rtc-max77686.c driver with the minimum required changes
for the MAX77714 RTC.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

Changes in v6: none

Changes in v5: none

Changes in v4: none

Changes in v3: none

Changes in v2: none
---
 drivers/rtc/Kconfig        |  2 +-
 drivers/rtc/rtc-max77686.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d85a3c31347c..f6d6d4c26361 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -375,7 +375,7 @@ config RTC_DRV_MAX8997
 
 config RTC_DRV_MAX77686
 	tristate "Maxim MAX77686"
-	depends on MFD_MAX77686 || MFD_MAX77620 || COMPILE_TEST
+	depends on MFD_MAX77686 || MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the
 	  RTC of Maxim MAX77686/MAX77620/MAX77802 PMIC.
diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 5c64d08c0732..b0250d91fb00 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -19,6 +19,7 @@
 
 #define MAX77686_I2C_ADDR_RTC		(0x0C >> 1)
 #define MAX77620_I2C_ADDR_RTC		0x68
+#define MAX77714_I2C_ADDR_RTC		0x48
 #define MAX77686_INVALID_I2C_ADDR	(-1)
 
 /* Define non existing register */
@@ -200,6 +201,28 @@ static const struct max77686_rtc_driver_data max77686_drv_data = {
 	.regmap_config = &max77686_rtc_regmap_config,
 };
 
+static const struct regmap_irq_chip max77714_rtc_irq_chip = {
+	.name		= "max77714-rtc",
+	.status_base	= MAX77686_RTC_INT,
+	.mask_base	= MAX77686_RTC_INTM,
+	.num_regs	= 1,
+	.irqs		= max77686_rtc_irqs,
+	.num_irqs	= ARRAY_SIZE(max77686_rtc_irqs) - 1, /* no WTSR on 77714 */
+};
+
+static const struct max77686_rtc_driver_data max77714_drv_data = {
+	.delay = 16000,
+	.mask  = 0x7f,
+	.map   = max77686_map,
+	.alarm_enable_reg = false,
+	.rtc_irq_from_platform = false,
+	/* On MAX77714 RTCA1 is BIT 1 of RTCINT (0x00). Not supported by this driver. */
+	.alarm_pending_status_reg = MAX77686_INVALID_REG,
+	.rtc_i2c_addr = MAX77714_I2C_ADDR_RTC,
+	.rtc_irq_chip = &max77714_rtc_irq_chip,
+	.regmap_config = &max77686_rtc_regmap_config,
+};
+
 static const struct regmap_config max77620_rtc_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -843,6 +866,7 @@ static const struct platform_device_id rtc_id[] = {
 	{ "max77686-rtc", .driver_data = (kernel_ulong_t)&max77686_drv_data, },
 	{ "max77802-rtc", .driver_data = (kernel_ulong_t)&max77802_drv_data, },
 	{ "max77620-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
+	{ "max77714-rtc", .driver_data = (kernel_ulong_t)&max77714_drv_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, rtc_id);
-- 
2.25.1

