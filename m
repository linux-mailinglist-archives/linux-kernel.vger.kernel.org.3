Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF65AA3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiIAXug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:50:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D882E68B;
        Thu,  1 Sep 2022 16:50:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r69so535012pgr.2;
        Thu, 01 Sep 2022 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=w+DshR9yepFpBry9u7KXIFJ4eQkMqSk2K4thHoZXeSA=;
        b=HkDAkuUjMRW1B5jk9Q3aOy8RCiHru8chEuvGCT1GQGJ5zK+KfUdVLWhAagu3uEKvWS
         F5WHRk9jooOw8E2wmKCu4QyqfzEqkTVSLbvbnwOzDuO4sjxDucuWnQkRDZfQfTCpBONj
         SbLDuRgfY2cc7+mLIS8gBvnzZP9hJO4x2+OBUzb6lmut+6FmfvvHZFWPRs8/88S2hH2w
         TSgkYWfHy3A/NDfBJk3cG8DhLTzWw9BvaEtCFsEeuKG4nYc0MtGwz/YZDCfKuyQg9b2e
         DIL7pe4I4mX3umqxFqQr4W4X5jPeQj359ZrYwxUUUkpHVkDytuHLEyDL1xUtkFsMRVs7
         8w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=w+DshR9yepFpBry9u7KXIFJ4eQkMqSk2K4thHoZXeSA=;
        b=aTRj/oq/nBwc/LuQcu3P5ObWsrDSzqogBSLzolOVYpRT8cBSyW8iE15qwnDTxziU+t
         tPWNxxgERfBAjS1hXGWlY9Xh2PtMbEgVT/Qq8wRYUWC2dIE1dmVsN9LH8WEY9r550Thb
         1uawXPtDIdEJ2T3TuB5aWIAfiU927AEcLFwAna4XOr6/IPLufkA/qaaAw01vtnbrQIO/
         HuOE3gkUmwZqdU7XdY4fc5Xbp7SqzNYido+q1uQ810nKkJfIHXyVeK7XtvpyU9yeR+xZ
         U9QuqFt4iokTCULt94YKwOXtlW6m9aZG33qIAt0WGe7QvM2J+XKFGkZsUHR4HcyA9doU
         qmHg==
X-Gm-Message-State: ACgBeo2jDDArJZc5YKecWK3DyGPqjvtstedNG6FiXLft6mlVwdHF3rBZ
        E4bNXF7FAA1y6YAHgaCqR18V9oxNzOngLg==
X-Google-Smtp-Source: AA6agR4v91E9yc7a0UFqbDHnV7G/N2Zl5iQfl+SmbVZipNO7GfMpD1RqIHt2tThkG6+ceMCXHD8VPg==
X-Received: by 2002:aa7:8393:0:b0:537:701d:e7f3 with SMTP id u19-20020aa78393000000b00537701de7f3mr33847297pfm.50.1662076229425;
        Thu, 01 Sep 2022 16:50:29 -0700 (PDT)
Received: from harry-home.bne.opengear.com (193-116-109-190.tpgi.com.au. [193.116.109.190])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm169986pfm.159.2022.09.01.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 16:50:29 -0700 (PDT)
From:   Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To:     andy.shevchenko@gmail.com
Cc:     qingtao.cao.au@gmail.com, nathan@nathanrossi.com,
        Qingtao Cao <qingtao.cao@digi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/1] gpio: exar: access MPIO registers on slave chips
Date:   Fri,  2 Sep 2022 09:50:03 +1000
Message-Id: <20220901235003.20520-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
(part of the Device Configuration Registers) of the slave chips, an offset
needs to be applied based on the number of master chip's UART channels.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/gpio/gpio-exar.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index d37de78247a6..d2ed2897fabb 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -21,6 +21,12 @@
 #define EXAR_OFFSET_MPIOLVL_HI 0x96
 #define EXAR_OFFSET_MPIOSEL_HI 0x99
 
+/*
+ * The Device Configuration and UART Configuration Registers
+ * for each UART channel take 1KB of memory address space.
+ */
+#define EXAR_UART_CHANNEL_SIZE 0x400
+
 #define DRIVER_NAME "gpio_exar"
 
 static DEFINE_IDA(ida_index);
@@ -31,26 +37,39 @@ struct exar_gpio_chip {
 	int index;
 	char name[20];
 	unsigned int first_pin;
+	/*
+	 * The offset to the slave device's (if existing)
+	 * Device Configuration Registers.
+	 */
+	unsigned int slave_offset;
 };
 
 static unsigned int
 exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
-						   : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+	unsigned int slave = offset / 16;
+	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+
+	return addr + (slave ? exar_gpio->slave_offset : 0);
 }
 
 static unsigned int
 exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
-						   : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+	unsigned int slave = offset / 16;
+	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+
+	return addr + (slave ? exar_gpio->slave_offset : 0);
 }
 
 static unsigned int
 exar_offset_to_bit(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) % 8;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+
+	return pin % 8;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -153,6 +172,17 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!exar_gpio)
 		return -ENOMEM;
 
+	/*
+	 * If cascaded, xr17v354 or xr17v358 slaves have the same amount
+	 * of MPIOs as their masters and the last 4 bits of the master's
+	 * PCI Device ID is the number of its UART channels.
+	 */
+	if (pcidev->device & GENMASK(15, 12)) {
+		ngpios += ngpios;
+		exar_gpio->slave_offset = (pcidev->device & GENMASK(3, 0)) *
+				EXAR_UART_CHANNEL_SIZE;
+	}
+
 	/*
 	 * We don't need to check the return values of mmio regmap operations (unless
 	 * the regmap has a clock attached which is not the case here).
-- 
2.34.1

