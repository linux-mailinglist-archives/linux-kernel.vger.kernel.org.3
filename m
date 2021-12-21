Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD18447C895
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhLUVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLUVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF6C061574;
        Tue, 21 Dec 2021 13:04:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o6so200841edc.4;
        Tue, 21 Dec 2021 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=ahXmpG1e/FJAPO0+XmSPXXwt38Y+SOz9yvH7JUZmK/RgXPRiaAx1O+a/dLqNTvtvU6
         0YNl2xTv51nmPyflVpKQTv5v1tNzAP4i2+fCaWNghVJsn8F1aRwvVh0oK4XVD7krEzXp
         Wd5GxBlKw22EZYq/myzz8EGSoO61QZhV46z29exB+OwsmHxLia/Vbs9mkvCI2Wty8HBV
         EGJaG2A0Yu9WlkOdZk3i2rg1vxK8e9nJXNFi6I7JKNA/gzYJrcmeeoF9G+hcEzUgAkKO
         W9eCgQYGPcbWK3cR7w+AI8LSpr3xo/hNJZUV0sWsdZ9GLL95MQzKr/4iBzh9n8aGg7Td
         YYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=09EhqJgo9BuHAB//aN8FZKx2Gr7v/1a03Wn73BXSLJ++8m40prGP2ZIGSjIcxfP/NG
         p4L62/aOKCZ4yKAdNi+wZhEWpLsgY0dCMfo6Xn+wQwHmbZul/nIJ8FGpFY7F1JDvETRw
         YZKt8jfoI1ps/oGkilWqmmfPajo66utD5FyQs/O/hTKnZcB8eo6y4R/qmTqobgNZPMV0
         5JvDw1UOXdzH/prNtm9lavNsj+U04b8IrtsNlR0V7grxGe62HmQ7TrWbPgV6t/cN4nRp
         bZ9p6U6ojheUpMXeS6ogvESGWyTeblp4LeUttLDu5wgshSSY8yeJ4RgNm5G0qnMylBOC
         jBPg==
X-Gm-Message-State: AOAM530FYj7JbEzwQFuvnaR8FaNlavPx5APkcQsn5pLRn+jd9boI/ywl
        VQ/HgqTk7GX+KO9ZcMCdw3g=
X-Google-Smtp-Source: ABdhPJyukoCDTR66KhUgA4WN9oCzhbkGVhBrNVa0NA9NSfBNWJpS2AvVsUrcMTGnvHmxQ7WzKLMkpw==
X-Received: by 2002:a05:6402:4302:: with SMTP id m2mr69541edc.349.1640120695134;
        Tue, 21 Dec 2021 13:04:55 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:54 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] hwmon: (adt7x10) Add device managed action for restoring config
Date:   Tue, 21 Dec 2021 23:04:33 +0200
Message-Id: <20211221210438.2637430-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221210438.2637430-1-demonsingur@gmail.com>
References: <20211221210438.2637430-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

To simplify the core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2439da9b64e6..e8a6c541a590 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -357,6 +357,17 @@ static const struct attribute_group adt7x10_group = {
 	.attrs = adt7x10_attributes,
 };
 
+static void adt7x10_restore_config(void *private)
+{
+	struct adt7x10_data *data = private;
+	struct device *dev = data->bus_dev;
+
+	if (data->oldconfig == data->config)
+		return;
+
+	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
+}
+
 int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
@@ -397,14 +408,18 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	}
 	dev_dbg(dev, "Config %02x\n", data->config);
 
+	ret = devm_add_action_or_reset(dev, adt7x10_restore_config, data);
+	if (ret)
+		return ret;
+
 	ret = adt7x10_fill_cache(dev);
 	if (ret)
-		goto exit_restore;
+		return ret;
 
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
 	if (ret)
-		goto exit_restore;
+		return ret;
 
 	/*
 	 * The I2C device will already have it's own 'name' attribute, but for
@@ -440,8 +455,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		device_remove_file(dev, &dev_attr_name);
 exit_remove:
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
-exit_restore:
-	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adt7x10_probe);
@@ -457,8 +470,6 @@ void adt7x10_remove(struct device *dev, int irq)
 	if (data->name)
 		device_remove_file(dev, &dev_attr_name);
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
-	if (data->oldconfig != data->config)
-		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 }
 EXPORT_SYMBOL_GPL(adt7x10_remove);
 
-- 
2.34.1

