Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600914A947D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351281AbiBDHWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351130AbiBDHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:22:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:22:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d5so4708305pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1QEEzychUMCoe5U0DSfc5Oq8DaKAXk74KjekRt/xBk=;
        b=W6qp7cTDZMWu2cumGId9gyog0wkFPZ6VWS/JnKyjaYHYoz5ep33RmlhmkdZHhrqMxf
         Rh037CyhguO34+KYPjPfU4Dhr8q1DIF1zY8bSTqPfX1WqonPbzPUALZIcz6s/Fo4T1b5
         uejYahCQDjJ3kM2AfbMQkz1EW9pfzWz6cAt9P2XxhN/yDP9TymzKVCUvSc0Xq7aPQP/b
         Lf+oVCL/yWqKIb68vmDsFf6o2jEsjqxGQGh8qrDAnEW2NLSYv9R7w0cH+ngm1UNv0GUL
         YLLEuCvEJFgTrwEHJ8KJmLCnatwRzc9QhqifvLGkXoUP/YUkk+6kdkCj7rSFkePZtxOP
         T1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r1QEEzychUMCoe5U0DSfc5Oq8DaKAXk74KjekRt/xBk=;
        b=Bl9uHufLTzXpgk8/CSP63Wmo5Ci0aUGV//BmlTsOd3ftWhnYJNHZqYCipqDziirgMH
         7bD7rj1fQ+4hGqV+H7I93/6WXGzOYSLu4dIEKMHuj4OOggmw2AImel+qGQWGBZUUe8kf
         2W59JpSb386ruj8DrpUs/sPl3Ud8r48KkDxPcxPKs/F8+oWFTsPAuJpNjvjftrPKKcjH
         12vLyC+ky0OKa2Ru2Hl+aDub19X6XCINiMjZo+S9ujrrym93yy9p2bY6zAImDE7YH+ZG
         +2dFT3BDd+7vQNHcRTNRfDXm8/WFWHLUX7wcjwGiJNC5d2s/fEUUWHpey9vtlzovHdIk
         iQCQ==
X-Gm-Message-State: AOAM531lSzhzSwHmbzjokT9prKKUfDvO2QzC1PO43PxQ2ZGQIPO1E+XA
        n8kd3coHvU1N7+aOdtq66MU=
X-Google-Smtp-Source: ABdhPJzv/S6WjXTCMee8NeOApFsHfvQNWaNzQQYEDOSomwHAyzQX+uirIatWiFPa/UeV9TWHfDvo/g==
X-Received: by 2002:a17:90b:4c4a:: with SMTP id np10mr1694513pjb.164.1643959371345;
        Thu, 03 Feb 2022 23:22:51 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id t14sm11665328pjd.6.2022.02.03.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:22:50 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 2/3] ARM: aspeed: Add secure boot controller support
Date:   Fri,  4 Feb 2022 17:52:33 +1030
Message-Id: <20220204072234.304543-3-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204072234.304543-1-joel@jms.id.au>
References: <20220204072234.304543-1-joel@jms.id.au>
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
v3:
   - Drop uart_boot
---
 drivers/soc/aspeed/aspeed-socinfo.c | 44 ++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..e5ced9bebfa2 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/firmware_bootinfo.h>
 
 static struct {
 	const char *name;
@@ -74,6 +75,45 @@ static const char *siliconid_to_rev(u32 siliconid)
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
+
+	firmware_bootinfo_init(&bootinfo);
+
+	pr_info("AST2600 secure boot %s\n", (reg & SECURE_BOOT) ? "enabled" : "disabled");
+}
+
 static int __init aspeed_socinfo_init(void)
 {
 	struct soc_device_attribute *attrs;
@@ -148,6 +188,8 @@ static int __init aspeed_socinfo_init(void)
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

