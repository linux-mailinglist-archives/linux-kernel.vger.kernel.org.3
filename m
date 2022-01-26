Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805C49D672
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiAZX6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiAZX6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:58:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D03AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:58:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w15-20020a17090aea0f00b001b53b829d6bso656472pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=okrQu2VSlzKkLZmDYcnmzL0C8aPu3r9sPHmlPe5ENII=;
        b=Mt8LOMhIs1dO4iJ8XfSrZOam3/YWQbcEFBfKm6JvixzqsAeChMqG2N0u2zPKpVRJBB
         DpTTta8O8spSNnZwCB+PAycUj3qpfr6xP6aoo2sHQN1g7sLocm/W6gtP8akRWCSS7NlT
         TdsE8145oQssomt3rUzLuP4IgOxONlw/S20ksU+xHSuONEQ5z0vxzAGYK4lwfR6zCRWQ
         7SY1qFF8Y8Dtk1Zna0ZFj7xWDx9zjqDT6ae/Tu/W785s6pif+AjFOWYVnBUdDatWAcMH
         IJ6XixGMTMYX6PQzcMYlBhgOG0qUBXSoJMKB+s+kiiTV4so+MtmqnzDCSRqS3Q0UvKfN
         b+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=okrQu2VSlzKkLZmDYcnmzL0C8aPu3r9sPHmlPe5ENII=;
        b=5BgauU3Nj5LqA0yeXF/jthZyMu8o0qgetjML651xrQJMNhbBwoahzSt3uVAuqzrrN0
         3LBUllOI2UP/X7/4hpYq+ZhL17Fh322d7W9gxk1w5dYaH96jV5dDAdpJzHJXoQ0u6ADP
         vwG1NtTVrY/kzEg4mqDpFgegjABdnyotqDVyJkNFXDfY01cKk20ROZwrM4MAFkieGdKY
         5t22QW5b8q8EAYtclIuB0pNZKV0SsTcv+XpBu2bFs9Nur11fH4aVxgdBXwT8KfAA/hq+
         olnZoq5khUCT/TyDlfz37L9fq4eMSAuHQ2oDrX1jbEhCRqSPKRam/jEnN2zgQZr9WT0w
         8w1A==
X-Gm-Message-State: AOAM532S3YaghR9+t6XtH83IWiW/jTbE/aChwEnNFK5Ez/rDwJSVcj1y
        EQLRD+75iZn/NCTyPA/1nAvvkF8G1zfviA==
X-Google-Smtp-Source: ABdhPJzUAryUJdlCf6CchFAhgLHT/3EeL7pC2SF8tvOaQvVpONSgmaVYy4N3LRnXp0to4bDTgcgXH2jCM5doLA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a05:6a00:b82:: with SMTP id
 g2mr1128038pfj.33.1643241491582; Wed, 26 Jan 2022 15:58:11 -0800 (PST)
Date:   Wed, 26 Jan 2022 23:58:07 +0000
Message-Id: <20220126235807.3164317-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACPI table includes _PLD fields for a device, create a new file
(pld) in sysfs to share _PLD fields.

Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/acpi/device_sysfs.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d5d6403ba07b..8d4df5fb1c45 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
+static ssize_t pld_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	acpi_status status;
+	struct acpi_pld_info *pld;
+
+	status = acpi_get_physical_device_location(acpi_dev->handle, &pld);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return sprintf(buf, "GROUP_TOKEN=%u\n"
+		"GROUP_POSITION=%u\n"
+		"USER_VISIBLE=%u\n"
+		"DOCK=%u\n"
+		"BAY=%u\n"
+		"LID=%u\n"
+		"PANEL=%u\n"
+		"HORIZONTAL_POSITION=%u\n"
+		"VERTICAL_POSITION=%u\n"
+		"SHAPE=%u\n",
+		pld->group_token,
+		pld->group_position,
+		pld->user_visible,
+		pld->dock,
+		pld->bay,
+		pld->lid,
+		pld->panel,
+		pld->horizontal_position,
+		pld->vertical_position,
+		pld->shape);
+}
+static DEVICE_ATTR_RO(pld);
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -595,6 +629,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
 
+	if (acpi_has_method(dev->handle, "_PLD")) {
+		result = device_create_file(&dev->dev, &dev_attr_pld);
+		if (result)
+			goto end;
+	}
+
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 
 end:
@@ -645,4 +685,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+	if (acpi_has_method(dev->handle, "_PLD"))
+		device_remove_file(&dev->dev, &dev_attr_pld);
 }
-- 
2.35.0.rc0.227.g00780c9af4-goog

