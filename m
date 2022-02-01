Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B554A5606
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiBAFFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiBAFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:05:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A22AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l13so5785233plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HhN0Mo5AAEuJ7GLyfzVMfqoylDTPvGZrezMx4WuD1Y=;
        b=pQcqzwBzTMUt9lhcStTT9fwKTd+uM9KFGW/Xynp4UnrxScTW2VG33Teyi7PCL+v98j
         6POqQnKQFswISlLtU1hDylQGsrJ0qYsaq8Fp6JhEs66Of+MKNRPSZneIImArPfuYgUn+
         zdaF5/zKLPBZ77KtJF6uiTeUHGew/VLxlM3EFtTaz4Z926PX9SiXhaXButFkPqlVyWng
         3eNlSiowJnArQTA46mnNNUkJtYWdXFQmJmkDIVTUrr7omZAivB/M4amoSlDdUx1iVUPa
         yAv9WWxSRi3tnMczSWHJyHkwcEhuIRWpBwSaoSDhBHx8pXgsfZK97aGdfPRMhVKs1Ect
         RQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8HhN0Mo5AAEuJ7GLyfzVMfqoylDTPvGZrezMx4WuD1Y=;
        b=0giSZGWZfDv3EWxKae8gS4us0Bk/JvvPE1OLnKEy8tABVDfm0kXfbnogUHd2rUDFbS
         4sYK99clW1GEfHxF48xRvL62C88ylCzGD5uumgZqj/bPnIbTtaTeY1TXmwH/PV4b0PH/
         dmPxG68bOh1HXbJnI1AGiyVB2wLx6dMXmUIoChAqHTRAU5CtHpBfMk4wljS2LAK5OFT7
         6U8mSlrW3oL7y36BnfqzolmjAirtY6whTcy+CnbQtmX11Fscv6TSHRq7JrKPHGu8ex74
         iIf5cCbmQPLlKsnVDdWrSTNUl8HGYB3YHdvPYfB4h7AaEB1z50+bQx4uat+DnqW4XqWO
         s3Uw==
X-Gm-Message-State: AOAM532S14LHXN34uCaJs+T7oax5X/14ANh3c6WRT4xaM1BLuongQbwm
        RSToN27f2ujYnMITvy0+qKU=
X-Google-Smtp-Source: ABdhPJz5avUIU4+X4vd3nMCzoEWBcmSaRvczxUqWfR52EfwhLQGqxyCpeHdGLQIZDWK9NzHJ6jgwxQ==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr350977pjb.75.1643691913680;
        Mon, 31 Jan 2022 21:05:13 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id u37sm6181991pga.2.2022.01.31.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:05:13 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 1/2] firmware: Add boot information sysfs
Date:   Tue,  1 Feb 2022 15:35:00 +1030
Message-Id: <20220201050501.182961-2-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201050501.182961-1-joel@jms.id.au>
References: <20220201050501.182961-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machines often have firmware that perform some action before Linux is
loaded. It's useful to know how this firmware is configured, so create a
sysfs directory and some example properties that a system can choose to
expose to describe how the system was started.

Currently the intended use describes five files, relating to hardware
root of trust configuration.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++++++++++++
 drivers/base/firmware.c                       | 14 ++++++
 include/linux/firmware_bootinfo.h             |  8 ++++
 3 files changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
new file mode 100644
index 000000000000..cd6c42316345
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
@@ -0,0 +1,43 @@
+What:		/sys/firmware/bootinfo/*
+Date:		Jan 2022
+Description:
+		A system can expose information about how it was started in
+		this directory.
+
+		This information is agnostic as to the firmware implementation.
+
+		A system may expose a subset of these properties as applicable.
+
+
+What:		/sys/firmware/bootinfo/secure_boot
+Date:		Jan 2022
+Description:
+		Indicates the system was started with secure boot enabled in
+		the firmware.
+
+
+What:		/sys/firmware/bootinfo/abr_image
+Date:		Jan 2022
+Description:
+		Indicates the system was started from the alternate image
+		loaded from an Alternate Boot Region. Often this is a result of
+		the primary firmware image failing to start the system.
+
+
+What:		/sys/firmware/bootinfo/low_security_key
+Date:		Jan 2022
+Description:
+		Indicates the system's secure boot was verified with a low
+		security or development key.
+
+What:		/sys/firmware/bootinfo/otp_protected
+Date:		Jan 2022
+Description:
+		Indicates the system's boot configuration region is write
+		protected and cannot be modified.
+
+What:		/sys/firmware/bootinfo/uart_boot
+Date:		Jan 2022
+Description:
+		Indicates the system firmware was loaded from a UART instead of
+		an internal boot device.
diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
index 8dff940e0db9..2a6478aa178d 100644
--- a/drivers/base/firmware.c
+++ b/drivers/base/firmware.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/firmware_bootinfo.h>
 
 #include "base.h"
 
@@ -24,3 +25,16 @@ int __init firmware_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+/*
+ * Exposes attributes documented in Documentation/ABI/testing/sysfs-firmware-bootinfo
+ */
+int __init firmware_bootinfo_init(const struct attribute_group *attr_group)
+{
+	struct kobject *kobj= kobject_create_and_add("bootinfo", firmware_kobj);
+	if (!kobj)
+		return -ENOMEM;
+
+	return sysfs_create_group(kobj, attr_group);
+}
+EXPORT_SYMBOL_GPL(firmware_bootinfo_init);
diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
new file mode 100644
index 000000000000..581b68508ec8
--- /dev/null
+++ b/include/linux/firmware_bootinfo.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 IBM Corp
+
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+int __init firmware_bootinfo_init(const struct attribute_group *attr_group);
+
-- 
2.34.1

