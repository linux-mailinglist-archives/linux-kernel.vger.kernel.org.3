Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A695A931E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiIAJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiIAJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:29:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D884F12FDE2;
        Thu,  1 Sep 2022 02:29:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f12so16375808plb.11;
        Thu, 01 Sep 2022 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3Wz1KflW1ILG3Pq+DP9aZDEh0r6i7cgP45ZCq1Y8CGg=;
        b=Hra04quTE6sUhn5Xr24EZxLwfH6GYmGsYSbr/mz4XmwAoPHjlFDBktkDeWfQREKUJu
         qnEZBfAXinuimJIqeMDH/PbWTfRTEFqe+O1/vH0oUdP8RsD1zy2RRpUE2gx2JsauiNIY
         9EnbcX+KreJ/zxVilb766L0sW4BcFoQZmnq4fwH5lXid4UE3CjLAe13FTzb4I3kCZ+/s
         s7q6DRs2w9WGPeqtiWMpzJStbPuKVJegEqhimn697eIGuwFkZymso5aJ5feE9kYOVSTk
         PvjC+FgYzIGFSmIQ+l3ZaVYtkJ+o2jBivVVFjkKtDX4rlkF6RxmRTk10uo+fDwpKvDH9
         N3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3Wz1KflW1ILG3Pq+DP9aZDEh0r6i7cgP45ZCq1Y8CGg=;
        b=lG4QqMbvi+sywWjxQc/HdU73k8/VU3OtAsu/+I2yu6Oj8ERp/OTkryjAEER/Y0TVYf
         BwqF9iGWWvF5JDyZd2HGncy5U4UYlT1BRX9GQfYEOUgA2O43Yj4BaEax6S+312h+DpCL
         PsSdG2LinvuSCMQr/JmQv7DcmVQfML8kFTk837v3GFxfp3dl7XkkpBbWgezfeNct9GdU
         AFfNCZjI/fiZg1Qxd7LlbKcG6siWud8WUwUAhVLf92qARv/h1aseVciECLxh4v/mxvai
         E48crmciqOsT617QPjmxrgbZJ9J6JBy69Pgjqtxn8feuA9eu/aIa41he/wbOH3YFDp8Q
         0y5A==
X-Gm-Message-State: ACgBeo3+fOhvHsvJKlp+T5aJxq8nlxuqvVOW9KdnNB12k4TOR2R1I7H2
        Of5fgyZQuoNHTDTJBbRWsiY=
X-Google-Smtp-Source: AA6agR5OXOMQCTWaZK2LXhyS/PxMY0gQAYq6ou0xC+YzIGeHi24Y3Dpz7zqzMjpxEA9BjiZ8PTfnrQ==
X-Received: by 2002:a17:903:110e:b0:171:3afa:e68c with SMTP id n14-20020a170903110e00b001713afae68cmr29439655plh.12.1662024581136;
        Thu, 01 Sep 2022 02:29:41 -0700 (PDT)
Received: from harry-home.bne.opengear.com (193-116-86-5.tpgi.com.au. [193.116.86.5])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090a2a0f00b001fddb3a5481sm2820350pjd.49.2022.09.01.02.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:29:40 -0700 (PDT)
From:   Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     qingtao.cao.au@gmail.com, nathan@nathanrossi.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] gpio: exar: access MPIO registers on slave chips
Date:   Thu,  1 Sep 2022 19:29:21 +1000
Message-Id: <20220901092922.1024311-1-qingtao.cao.au@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
(part of the Device Configuration Registers) of the slave chips, an offset
needs to be applied based on the number of master chip's UART channels.

Signed-off-by: Qingtao Cao <qingtao.cao.au@gmail.com>
---
 drivers/gpio/gpio-exar.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index d37de78247a6..1110c8f92c58 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -20,6 +20,7 @@
 #define EXAR_OFFSET_MPIOSEL_LO 0x93
 #define EXAR_OFFSET_MPIOLVL_HI 0x96
 #define EXAR_OFFSET_MPIOSEL_HI 0x99
+#define EXAR_UART_CHANNEL_SIZE 0x400
 
 #define DRIVER_NAME "gpio_exar"
 
@@ -31,26 +32,37 @@ struct exar_gpio_chip {
 	int index;
 	char name[20];
 	unsigned int first_pin;
+	/*
+	 * The offset to the slave device's (if existing)
+	 * Device Configuration Registers
+	 */
+	unsigned int slave_offset;
 };
 
 static unsigned int
 exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
-						   : EXAR_OFFSET_MPIOSEL_LO;
+	int addr;
+
+	addr = (offset % 16 + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
+							: EXAR_OFFSET_MPIOSEL_LO;
+	return offset / 16 ? addr + exar_gpio->slave_offset : addr;
 }
 
 static unsigned int
 exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
-						   : EXAR_OFFSET_MPIOLVL_LO;
+	int addr;
+
+	addr = (offset % 16 + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
+							: EXAR_OFFSET_MPIOLVL_LO;
+	return offset / 16 ? addr + exar_gpio->slave_offset : addr;
 }
 
 static unsigned int
 exar_offset_to_bit(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) % 8;
+	return (offset % 16 + exar_gpio->first_pin) % 8;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -153,6 +165,21 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!exar_gpio)
 		return -ENOMEM;
 
+	if (pcidev->device & 0xf000) {
+		/*
+		 * xr17v354 or xr17v358 slaves have the same amount of
+		 * MPIOs as the master
+		 */
+		ngpios += ngpios;
+
+		/*
+		 * The last 4 bits of the master's PCI Device ID is
+		 * the number of its UART channels
+		 */
+		exar_gpio->slave_offset = (pcidev->device & 0xf) *
+				EXAR_UART_CHANNEL_SIZE;
+	}
+
 	/*
 	 * We don't need to check the return values of mmio regmap operations (unless
 	 * the regmap has a clock attached which is not the case here).
-- 
2.17.1

