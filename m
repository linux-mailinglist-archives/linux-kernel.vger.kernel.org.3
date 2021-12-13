Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64847264A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhLMJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbhLMJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248CC08EB28
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id k4so14069700pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGGrd+sQWogr+s0RnXQ1NKuB1EhCPzQoRxC06aRdn1o=;
        b=LovcL8e6QW8MfLCzvHL0IxVDTARNT+pKOlty2CdVyr95+QPxLKyRpDJ2WFUAVcJD2f
         63a2HM6Kk8w+u7ZNSpMJGdqYJDrvRdXIU3J2T3IMSQ81GdtEPV1r7jO7E6LPIn/C/YNx
         mjw/EwBIILqw9AoWLGcMGEKw3vF3hufaiFEWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGGrd+sQWogr+s0RnXQ1NKuB1EhCPzQoRxC06aRdn1o=;
        b=UulchtRn8sUHpPVnEF7wJ1srDZ6RO1mcNvId8k8V5A5wlN0cgGAvmAvhijzcGxpkx7
         uo9VA2e//YTPvWlEz3tt3hAZZImxEeCuVP2kFh+ojjlqZvowaEBJjTMYg91tswt6HmFg
         8lcyf17rkVIVEW98VlvYvypSIYldy2gZaYoIWr//LUhSfEN1tA+LYp9RBQM6KlEg/YSF
         OUDD1IDvRE/hXJE9F9traYnRy90389fsZ7162xpjswIEigK8RhbypsJSjAoaYi6k2C7H
         dlONnf6nbhjKIHukZ66YMDSLwL3ozTWj2ao/BykU/pOUNeS5khpj436vY1gqlL3N76Vb
         6lIQ==
X-Gm-Message-State: AOAM530wmmmsbT2fCx3WO3HCL6jPLr3K/HnKCKrDqAp4Pj7eR6RdhF2y
        deWhs0rNdkXpPN22UyN4mqAkVYlW6utzkw==
X-Google-Smtp-Source: ABdhPJwV70/KPMEFPfxqDaG78GYpI38uVZbeqA7EsHc7m7Jt4TNbgjVg3OgkZKKCSf3csAwDXOeTNA==
X-Received: by 2002:a63:8bca:: with SMTP id j193mr14213083pge.458.1639388458459;
        Mon, 13 Dec 2021 01:40:58 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d195sm10237609pga.41.2021.12.13.01.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:40:58 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v3 4/5] gpio: msc313: Add support for SSD201 and SSD202D
Date:   Mon, 13 Dec 2021 18:40:35 +0900
Message-Id: <20211213094036.1787950-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213094036.1787950-1-daniel@0x0f.com>
References: <20211213094036.1787950-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds GPIO support for the SSD201 and SSD202D chips.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-msc313.c | 261 +++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index a894bafbd4c3..b2c90bdd39d0 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -221,6 +221,263 @@ static const unsigned int msc313_offsets[] = {
 };
 
 MSC313_GPIO_CHIPDATA(msc313);
+
+/*
+ * Unlike the msc313(e) the ssd20xd have a bunch of pins
+ * that are actually called gpio probably because they
+ * have no dedicated function.
+ */
+#define SSD20XD_PINNAME_GPIO0		"gpio0"
+#define SSD20XD_PINNAME_GPIO1		"gpio1"
+#define SSD20XD_PINNAME_GPIO2		"gpio2"
+#define SSD20XD_PINNAME_GPIO3		"gpio3"
+#define SSD20XD_PINNAME_GPIO4		"gpio4"
+#define SSD20XD_PINNAME_GPIO5		"gpio5"
+#define SSD20XD_PINNAME_GPIO6		"gpio6"
+#define SSD20XD_PINNAME_GPIO7		"gpio7"
+#define SSD20XD_PINNAME_GPIO10		"gpio10"
+#define SSD20XD_PINNAME_GPIO11		"gpio11"
+#define SSD20XD_PINNAME_GPIO12		"gpio12"
+#define SSD20XD_PINNAME_GPIO13		"gpio13"
+#define SSD20XD_PINNAME_GPIO14		"gpio14"
+#define SSD20XD_PINNAME_GPIO85		"gpio85"
+#define SSD20XD_PINNAME_GPIO86		"gpio86"
+#define SSD20XD_PINNAME_GPIO90		"gpio90"
+
+#define SSD20XD_GPIO_NAMES SSD20XD_PINNAME_GPIO0,  \
+			   SSD20XD_PINNAME_GPIO1,  \
+			   SSD20XD_PINNAME_GPIO2,  \
+			   SSD20XD_PINNAME_GPIO3,  \
+			   SSD20XD_PINNAME_GPIO4,  \
+			   SSD20XD_PINNAME_GPIO5,  \
+			   SSD20XD_PINNAME_GPIO6,  \
+			   SSD20XD_PINNAME_GPIO7,  \
+			   SSD20XD_PINNAME_GPIO10, \
+			   SSD20XD_PINNAME_GPIO11, \
+			   SSD20XD_PINNAME_GPIO12, \
+			   SSD20XD_PINNAME_GPIO13, \
+			   SSD20XD_PINNAME_GPIO14, \
+			   SSD20XD_PINNAME_GPIO85, \
+			   SSD20XD_PINNAME_GPIO86, \
+			   SSD20XD_PINNAME_GPIO90
+
+#define SSD20XD_GPIO_OFF_GPIO0 0x0
+#define SSD20XD_GPIO_OFF_GPIO1 0x4
+#define SSD20XD_GPIO_OFF_GPIO2 0x8
+#define SSD20XD_GPIO_OFF_GPIO3 0xc
+#define SSD20XD_GPIO_OFF_GPIO4 0x10
+#define SSD20XD_GPIO_OFF_GPIO5 0x14
+#define SSD20XD_GPIO_OFF_GPIO6 0x18
+#define SSD20XD_GPIO_OFF_GPIO7 0x1c
+#define SSD20XD_GPIO_OFF_GPIO10 0x28
+#define SSD20XD_GPIO_OFF_GPIO11 0x2c
+#define SSD20XD_GPIO_OFF_GPIO12 0x30
+#define SSD20XD_GPIO_OFF_GPIO13 0x34
+#define SSD20XD_GPIO_OFF_GPIO14 0x38
+#define SSD20XD_GPIO_OFF_GPIO85 0x100
+#define SSD20XD_GPIO_OFF_GPIO86 0x104
+#define SSD20XD_GPIO_OFF_GPIO90 0x114
+
+#define SSD20XD_GPIO_OFFSETS SSD20XD_GPIO_OFF_GPIO0,  \
+			     SSD20XD_GPIO_OFF_GPIO1,  \
+			     SSD20XD_GPIO_OFF_GPIO2,  \
+			     SSD20XD_GPIO_OFF_GPIO3,  \
+			     SSD20XD_GPIO_OFF_GPIO4,  \
+			     SSD20XD_GPIO_OFF_GPIO5,  \
+			     SSD20XD_GPIO_OFF_GPIO6,  \
+			     SSD20XD_GPIO_OFF_GPIO7,  \
+			     SSD20XD_GPIO_OFF_GPIO10, \
+			     SSD20XD_GPIO_OFF_GPIO11, \
+			     SSD20XD_GPIO_OFF_GPIO12, \
+			     SSD20XD_GPIO_OFF_GPIO13, \
+			     SSD20XD_GPIO_OFF_GPIO14, \
+			     SSD20XD_GPIO_OFF_GPIO85, \
+			     SSD20XD_GPIO_OFF_GPIO86, \
+			     SSD20XD_GPIO_OFF_GPIO90
+
+/* "ttl" pins lcd interface pins */
+#define SSD20XD_PINNAME_TTL0	"ttl0"
+#define SSD20XD_PINNAME_TTL1	"ttl1"
+#define SSD20XD_PINNAME_TTL2	"ttl2"
+#define SSD20XD_PINNAME_TTL3	"ttl3"
+#define SSD20XD_PINNAME_TTL4	"ttl4"
+#define SSD20XD_PINNAME_TTL5	"ttl5"
+#define SSD20XD_PINNAME_TTL6	"ttl6"
+#define SSD20XD_PINNAME_TTL7	"ttl7"
+#define SSD20XD_PINNAME_TTL8	"ttl8"
+#define SSD20XD_PINNAME_TTL9	"ttl9"
+#define SSD20XD_PINNAME_TTL10	"ttl10"
+#define SSD20XD_PINNAME_TTL11	"ttl11"
+#define SSD20XD_PINNAME_TTL12	"ttl12"
+#define SSD20XD_PINNAME_TTL13	"ttl13"
+#define SSD20XD_PINNAME_TTL14	"ttl14"
+#define SSD20XD_PINNAME_TTL15	"ttl15"
+#define SSD20XD_PINNAME_TTL16	"ttl16"
+#define SSD20XD_PINNAME_TTL17	"ttl17"
+#define SSD20XD_PINNAME_TTL18	"ttl18"
+#define SSD20XD_PINNAME_TTL19	"ttl19"
+#define SSD20XD_PINNAME_TTL20	"ttl20"
+#define SSD20XD_PINNAME_TTL21	"ttl21"
+#define SSD20XD_PINNAME_TTL22	"ttl22"
+#define SSD20XD_PINNAME_TTL23	"ttl23"
+#define SSD20XD_PINNAME_TTL24	"ttl24"
+#define SSD20XD_PINNAME_TTL25	"ttl25"
+#define SSD20XD_PINNAME_TTL26	"ttl26"
+#define SSD20XD_PINNAME_TTL27	"ttl27"
+
+#define SSD20XD_TTL_PINNAMES SSD20XD_PINNAME_TTL0,  \
+			     SSD20XD_PINNAME_TTL1,  \
+			     SSD20XD_PINNAME_TTL2,  \
+			     SSD20XD_PINNAME_TTL3,  \
+			     SSD20XD_PINNAME_TTL4,  \
+			     SSD20XD_PINNAME_TTL5,  \
+			     SSD20XD_PINNAME_TTL6,  \
+			     SSD20XD_PINNAME_TTL7,  \
+			     SSD20XD_PINNAME_TTL8,  \
+			     SSD20XD_PINNAME_TTL9,  \
+			     SSD20XD_PINNAME_TTL10, \
+			     SSD20XD_PINNAME_TTL11, \
+			     SSD20XD_PINNAME_TTL12, \
+			     SSD20XD_PINNAME_TTL13, \
+			     SSD20XD_PINNAME_TTL14, \
+			     SSD20XD_PINNAME_TTL15, \
+			     SSD20XD_PINNAME_TTL16, \
+			     SSD20XD_PINNAME_TTL17, \
+			     SSD20XD_PINNAME_TTL18, \
+			     SSD20XD_PINNAME_TTL19, \
+			     SSD20XD_PINNAME_TTL20, \
+			     SSD20XD_PINNAME_TTL21, \
+			     SSD20XD_PINNAME_TTL22, \
+			     SSD20XD_PINNAME_TTL23, \
+			     SSD20XD_PINNAME_TTL24, \
+			     SSD20XD_PINNAME_TTL25, \
+			     SSD20XD_PINNAME_TTL26, \
+			     SSD20XD_PINNAME_TTL27
+
+#define SSD20XD_TTL_OFFSET_TTL0		0x80
+#define SSD20XD_TTL_OFFSET_TTL1		0x84
+#define SSD20XD_TTL_OFFSET_TTL2		0x88
+#define SSD20XD_TTL_OFFSET_TTL3		0x8c
+#define SSD20XD_TTL_OFFSET_TTL4		0x90
+#define SSD20XD_TTL_OFFSET_TTL5		0x94
+#define SSD20XD_TTL_OFFSET_TTL6		0x98
+#define SSD20XD_TTL_OFFSET_TTL7		0x9c
+#define SSD20XD_TTL_OFFSET_TTL8		0xa0
+#define SSD20XD_TTL_OFFSET_TTL9		0xa4
+#define SSD20XD_TTL_OFFSET_TTL10	0xa8
+#define SSD20XD_TTL_OFFSET_TTL11	0xac
+#define SSD20XD_TTL_OFFSET_TTL12	0xb0
+#define SSD20XD_TTL_OFFSET_TTL13	0xb4
+#define SSD20XD_TTL_OFFSET_TTL14	0xb8
+#define SSD20XD_TTL_OFFSET_TTL15	0xbc
+#define SSD20XD_TTL_OFFSET_TTL16	0xc0
+#define SSD20XD_TTL_OFFSET_TTL17	0xc4
+#define SSD20XD_TTL_OFFSET_TTL18	0xc8
+#define SSD20XD_TTL_OFFSET_TTL19	0xcc
+#define SSD20XD_TTL_OFFSET_TTL20	0xd0
+#define SSD20XD_TTL_OFFSET_TTL21	0xd4
+#define SSD20XD_TTL_OFFSET_TTL22	0xd8
+#define SSD20XD_TTL_OFFSET_TTL23	0xdc
+#define SSD20XD_TTL_OFFSET_TTL24	0xe0
+#define SSD20XD_TTL_OFFSET_TTL25	0xe4
+#define SSD20XD_TTL_OFFSET_TTL26	0xe8
+#define SSD20XD_TTL_OFFSET_TTL27	0xec
+
+#define SSD20XD_TTL_OFFSETS SSD20XD_TTL_OFFSET_TTL0,  \
+			    SSD20XD_TTL_OFFSET_TTL1,  \
+			    SSD20XD_TTL_OFFSET_TTL2,  \
+			    SSD20XD_TTL_OFFSET_TTL3,  \
+			    SSD20XD_TTL_OFFSET_TTL4,  \
+			    SSD20XD_TTL_OFFSET_TTL5,  \
+			    SSD20XD_TTL_OFFSET_TTL6,  \
+			    SSD20XD_TTL_OFFSET_TTL7,  \
+			    SSD20XD_TTL_OFFSET_TTL8,  \
+			    SSD20XD_TTL_OFFSET_TTL9,  \
+			    SSD20XD_TTL_OFFSET_TTL10, \
+			    SSD20XD_TTL_OFFSET_TTL11, \
+			    SSD20XD_TTL_OFFSET_TTL12, \
+			    SSD20XD_TTL_OFFSET_TTL13, \
+			    SSD20XD_TTL_OFFSET_TTL14, \
+			    SSD20XD_TTL_OFFSET_TTL15, \
+			    SSD20XD_TTL_OFFSET_TTL16, \
+			    SSD20XD_TTL_OFFSET_TTL17, \
+			    SSD20XD_TTL_OFFSET_TTL18, \
+			    SSD20XD_TTL_OFFSET_TTL19, \
+			    SSD20XD_TTL_OFFSET_TTL20, \
+			    SSD20XD_TTL_OFFSET_TTL21, \
+			    SSD20XD_TTL_OFFSET_TTL22, \
+			    SSD20XD_TTL_OFFSET_TTL23, \
+			    SSD20XD_TTL_OFFSET_TTL24, \
+			    SSD20XD_TTL_OFFSET_TTL25, \
+			    SSD20XD_TTL_OFFSET_TTL26, \
+			    SSD20XD_TTL_OFFSET_TTL27
+
+/* On the ssd20xd the two normal uarts have dedicated pins */
+#define SSD20XD_PINNAME_UART0_RX	"uart0_rx"
+#define SSD20XD_PINNAME_UART0_TX	"uart0_tx"
+
+#define SSD20XD_UART0_NAMES	  \
+	SSD20XD_PINNAME_UART0_RX, \
+	SSD20XD_PINNAME_UART0_TX
+
+#define SSD20XD_PINNAME_UART1_RX	"uart1_rx"
+#define SSD20XD_PINNAME_UART1_TX	"uart1_tx"
+
+#define SSD20XD_UART1_NAMES	  \
+	SSD20XD_PINNAME_UART1_RX, \
+	SSD20XD_PINNAME_UART1_TX
+
+#define SSD20XD_OFF_UART0_RX	0x60
+#define SSD20XD_OFF_UART0_TX	0x64
+
+#define SSD20XD_UART0_OFFSETS \
+	SSD20XD_OFF_UART0_RX, \
+	SSD20XD_OFF_UART0_TX
+
+#define SSD20XD_OFF_UART1_RX	0x68
+#define SSD20XD_OFF_UART1_TX	0x6c
+
+#define SSD20XD_UART1_OFFSETS \
+	SSD20XD_OFF_UART1_RX, \
+	SSD20XD_OFF_UART1_TX
+
+/*
+ * ssd20x has the same pin names but different ordering
+ * of the registers that control the gpio.
+ */
+#define SSD20XD_OFF_SD_D0	0x140
+#define SSD20XD_OFF_SD_D1	0x144
+#define SSD20XD_OFF_SD_D2	0x148
+#define SSD20XD_OFF_SD_D3	0x14c
+#define SSD20XD_OFF_SD_CMD	0x150
+#define SSD20XD_OFF_SD_CLK	0x154
+
+#define SSD20XD_SD_OFFSETS	SSD20XD_OFF_SD_CLK, \
+				SSD20XD_OFF_SD_CMD, \
+				SSD20XD_OFF_SD_D0,  \
+				SSD20XD_OFF_SD_D1,  \
+				SSD20XD_OFF_SD_D2,  \
+				SSD20XD_OFF_SD_D3
+
+static const char * const ssd20xd_names[] = {
+	FUART_NAMES,
+	SD_NAMES,
+	SSD20XD_UART0_NAMES,
+	SSD20XD_UART1_NAMES,
+	SSD20XD_TTL_PINNAMES,
+	SSD20XD_GPIO_NAMES,
+};
+
+static const unsigned int ssd20xd_offsets[] = {
+	FUART_OFFSETS,
+	SSD20XD_SD_OFFSETS,
+	SSD20XD_UART0_OFFSETS,
+	SSD20XD_UART1_OFFSETS,
+	SSD20XD_TTL_OFFSETS,
+	SSD20XD_GPIO_OFFSETS,
+};
+
+MSC313_GPIO_CHIPDATA(ssd20xd);
 #endif
 
 struct msc313_gpio {
@@ -412,6 +669,10 @@ static const struct of_device_id msc313_gpio_of_match[] = {
 		.compatible = "mstar,msc313-gpio",
 		.data = &msc313_data,
 	},
+	{
+		.compatible = "sstar,ssd20xd-gpio",
+		.data = &ssd20xd_data,
+	},
 #endif
 	{ }
 };
-- 
2.34.1

