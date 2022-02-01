Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2D4A5607
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiBAFFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiBAFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:05:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j10so14295557pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXZhXqP+hJTCEG0KLlnHSrSIKRsgu3yP6iR8K2/utRA=;
        b=cRTGOvUdVQ3VIpJHalZf12OyJMEycgkXop8Rx0kknHVuzOdzJ2MXCo9u3nKKw2GrGc
         PEZn8o0Xmseg8Zi1sphhHK9O1fd2s2IUN7UO/nY3Y6bqDFX6NtEZmqZqdGHdp9N9jKP6
         i+Ls2/GRKXaFoYQvFXD5B/7aDkp7c4HzJh9a6tgunLySRbuB/xpwoXxxxCHaR4MUiktY
         7dWUuETtJHy4bRiu1RRvaKHfEohjO18GsM2onAPSIa61wk0j7+GRgNzUcHVB/W2Wqd+i
         dSfoGiGC/iL8duI2rEPqjZyAV6AZMhm6L5zSoTyi5zdY0koHTXepGDEhtdQTUsrnsfxo
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KXZhXqP+hJTCEG0KLlnHSrSIKRsgu3yP6iR8K2/utRA=;
        b=IOVfSoS9K1Eek+yg1Jcpn6BwwbxS0wFop6N2pRoz5qhkHdxbJVlbT5xq505bFF0yPr
         WKWg/GybvB2K9rLB5P9WSjmhNPr4E8oMmSrh3LyTT9CxlW9Q50xUL2cyYnXaBTNSmXo2
         McRdAmacdceWhb+jEpTOncy7pyAJpiD6a0AQsv7zDTJ4jCPwIvWX/KxPQO0pLGBOt3FW
         BJakw6bxPaLwflPVy06dAoPkqVB4oDnrcX7MthugSf+sGeTUSVfLx2naD+xJdvz/Tjrb
         YYulY6homJ/ysM9/pYbnuDjFQY/0Wqktov8ku3/tRP0uUc0erE9G5R+FJl8OIPMM8PcQ
         pOoQ==
X-Gm-Message-State: AOAM532hCctRXC/vKd/EtMzsqDevrl9lbp/UolSBfJn9WN9XBO7gJjLa
        foisgmc28jYsE5Au9chTpj/B1hpPZF2vHA==
X-Google-Smtp-Source: ABdhPJyyiAnlj0jVqXEFutCAzEC/wZnZT8ZEHQEjaUAnr+6+PlrOSxgyRqfRvqoQBuDLXDpcscM7Lw==
X-Received: by 2002:aa7:88c9:: with SMTP id k9mr23203828pff.58.1643691917941;
        Mon, 31 Jan 2022 21:05:17 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id u37sm6181991pga.2.2022.01.31.21.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:05:17 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 2/2] ARM: aspeed: Add secure boot controller support
Date:   Tue,  1 Feb 2022 15:35:01 +1030
Message-Id: <20220201050501.182961-3-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201050501.182961-1-joel@jms.id.au>
References: <20220201050501.182961-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reads out the status of the secure boot controller and exposes it
in sysfs using the bootinfo sysfs api.

An example on a AST2600A3 QEMU model:

 # grep -r . /sys/firmware/bootinfo/*
 /sys/firmware/bootinfo/abr_image:0
 /sys/firmware/bootinfo/low_security_key:0
 /sys/firmware/bootinfo/otp_protected:0
 /sys/firmware/bootinfo/secure_boot:1
 /sys/firmware/bootinfo/uart_boot:0

On boot the state of the system according to the secure boot controller
will be printed:

 [    0.037634] AST2600 secure boot enabled

or

 [    0.037935] AST2600 secure boot disabled

The initialisation is changed from early_initcall to subsys_initcall
because we need the firmware_kobj to be initialised, and because there's
no requirement to print this information early.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 84 ++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..fe77b31e4d1d 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -8,6 +8,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/firmware_bootinfo.h>
+
+static u32 security_status;
 
 static struct {
 	const char *name;
@@ -74,6 +77,83 @@ static const char *siliconid_to_rev(u32 siliconid)
 	return "??";
 }
 
+#define SEC_STATUS		0x14
+#define ABR_IMAGE_SOURCE	BIT(13)
+#define OTP_PROTECTED		BIT(8)
+#define LOW_SEC_KEY		BIT(7)
+#define SECURE_BOOT		BIT(6)
+#define UART_BOOT		BIT(5)
+
+static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(security_status & ABR_IMAGE_SOURCE));
+}
+static DEVICE_ATTR_RO(abr_image);
+
+static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(security_status & LOW_SEC_KEY));
+}
+static DEVICE_ATTR_RO(low_security_key);
+
+static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(security_status & OTP_PROTECTED));
+}
+static DEVICE_ATTR_RO(otp_protected);
+
+static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(security_status & SECURE_BOOT));
+}
+static DEVICE_ATTR_RO(secure_boot);
+
+static ssize_t uart_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	/* Invert the bit, as 1 is boot from SPI/eMMC */
+	return sprintf(buf, "%d\n", !(security_status & UART_BOOT));
+}
+static DEVICE_ATTR_RO(uart_boot);
+
+static struct attribute *aspeed_attrs[] = {
+	&dev_attr_abr_image.attr,
+	&dev_attr_low_security_key.attr,
+	&dev_attr_otp_protected.attr,
+	&dev_attr_secure_boot.attr,
+	&dev_attr_uart_boot.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(aspeed);
+
+static int __init aspeed_bootinfo_init(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	/* AST2600 only */
+	np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	security_status = readl(base + SEC_STATUS);
+
+	iounmap(base);
+	of_node_put(np);
+
+	firmware_bootinfo_init(aspeed_groups[0]);
+
+	pr_info("AST2600 secure boot %s\n",
+		(security_status & SECURE_BOOT) ? "enabled" : "disabled");
+
+	return 0;
+}
+
 static int __init aspeed_socinfo_init(void)
 {
 	struct soc_device_attribute *attrs;
@@ -148,6 +228,8 @@ static int __init aspeed_socinfo_init(void)
 			attrs->revision,
 			attrs->soc_id);
 
+	aspeed_bootinfo_init();
+
 	return 0;
 }
-early_initcall(aspeed_socinfo_init);
+subsys_initcall(aspeed_socinfo_init);
-- 
2.34.1

