Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B64A8360
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbiBCLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbiBCLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:54:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AAC061748
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:54:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i30so2019129pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y24EP6xKeEvQOAjkdyxZutWXu4m6B4k+YDqTIaEEINs=;
        b=bzyKo9LHZxuywZ/Lpjaf+94nxTw259Cln/iVI82pP+PjBcxhKdD8DexmKafK+gizYv
         uARgrFIK04qrjpwyvnYXazPXOjeOJHy43FfOC4Bfi/1lcNls/5j7g1zs+4DpTCP5wDhb
         QtbHk/4RQQuRx2HQx0vPulkcoVyIfq8tKiLjXV4XREQ/rrPS6HqIXCArBuQ4WdS1oko/
         oCa5nUnENvmUrV+kZ21wuIMIuNfppLYVdwrK848DccuRcOsZh+0IvrfDh5HjhDXXDmru
         ilhBR4JnSFXIE46L+No+vigF+0dbkXxD3Qem/NmmLGxGxy+ctMxEl4gk7bNrHoQ/u3Oz
         yPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y24EP6xKeEvQOAjkdyxZutWXu4m6B4k+YDqTIaEEINs=;
        b=5135HT8jwb6Um/6ZbRjU/jNPpZQ6GWNzEyhZHGZHsgafzldstb0sdKktFXxinSSwSU
         DzmHITKboRlWSjN0fiVWewc8HOZbGdsMmhjuQUdJWKFO3S0Zt9yYaUk2LzoGBDyIDLlh
         Q7ykVw8TzFH5E1yQH+A/zv35asfcJwr58Um5tKno8d5zMOko+MX3KP5d7BZCjXBbuciF
         QX9AmuFUxy/bwJ7IN5JqPpf6OaMoienJfhYPuGdhNpSS6w5TYJlEhUq6+Bf7TBVDcdeM
         fXUTZQ32kSOdRhXrOH4lO0LLNCUfUP6HZfhp8EABiDyHMi2EfCYlw4NxwIYFDAKlNa5H
         m9lA==
X-Gm-Message-State: AOAM53138IX9IZRqRgUMpaEdM3LPgDal0nm9Sw9uJH3yoVTsl9g96sIw
        WENBKoI2ehQkjYkrDsvQskU=
X-Google-Smtp-Source: ABdhPJwtY9ZHwe8+DA5oX4k6u3MXHenJR9U4RjnvG/Nbl5tLA8d1Q7wrRjYWEupqZ5sEJdkknt7Smw==
X-Received: by 2002:a65:4bc9:: with SMTP id p9mr27620862pgr.168.1643889243359;
        Thu, 03 Feb 2022 03:54:03 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id mp22sm9586389pjb.28.2022.02.03.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:54:02 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 2/3] ARM: aspeed: Add secure boot controller support
Date:   Thu,  3 Feb 2022 22:23:43 +1030
Message-Id: <20220203115344.267159-3-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203115344.267159-1-joel@jms.id.au>
References: <20220203115344.267159-1-joel@jms.id.au>
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
---
v2:
   - Rewrite to new bootinfo api
   - Get rid of unused return values
---
 drivers/soc/aspeed/aspeed-socinfo.c | 46 ++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..dc4dfd3df55f 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/firmware_bootinfo.h>
 
 static struct {
 	const char *name;
@@ -74,6 +75,47 @@ static const char *siliconid_to_rev(u32 siliconid)
 	return "??";
 }
 
+/* Secure Boot Controller register */
+#define SEC_STATUS		0x14
+#define ABR_IMAGE_SOURCE	BIT(13)
+#define OTP_PROTECTED		BIT(8)
+#define LOW_SEC_KEY		BIT(7)
+#define SECURE_BOOT		BIT(6)
+#define UART_BOOT		BIT(5)
+
+static void __init aspeed_bootinfo_init(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+	struct bootinfo bootinfo = {};
+	u32 reg;
+
+	/* AST2600 only */
+	np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
+	if (!of_device_is_available(np))
+		return;
+
+	base = of_iomap(np, 0);
+	if (!base)
+		of_node_put(np);
+
+	reg = readl(base + SEC_STATUS);
+
+	iounmap(base);
+	of_node_put(np);
+
+	BOOTINFO_SET(bootinfo, abr_image,        reg & ABR_IMAGE_SOURCE);
+	BOOTINFO_SET(bootinfo, low_security_key, reg & LOW_SEC_KEY);
+	BOOTINFO_SET(bootinfo, otp_protected,    reg & OTP_PROTECTED);
+	BOOTINFO_SET(bootinfo, secure_boot,      reg & SECURE_BOOT);
+	/* Invert the bit; as 1 is boot from SPI/eMMC */
+	BOOTINFO_SET(bootinfo, uart_boot,        !(reg & UART_BOOT));
+
+	firmware_bootinfo_init(&bootinfo);
+
+	pr_info("AST2600 secure boot %s\n", (reg & SECURE_BOOT) ? "enabled" : "disabled");
+}
+
 static int __init aspeed_socinfo_init(void)
 {
 	struct soc_device_attribute *attrs;
@@ -148,6 +190,8 @@ static int __init aspeed_socinfo_init(void)
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

