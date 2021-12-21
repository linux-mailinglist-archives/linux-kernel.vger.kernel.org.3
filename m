Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE247C8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhLUV6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhLUV6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B50C061574;
        Tue, 21 Dec 2021 13:58:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so584949edd.8;
        Tue, 21 Dec 2021 13:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=D3cH2a/F3ZXGZdR1M/H1Ojzh7MgHqM8RSPtcPnS1IV3pX152Q5RDqn51wqjtYbyprh
         yEKfw7JfJhURocZJWeyJnLBqsknBC/QbSN3OguCGEX2TNivxUu+stBpGk6rZ/+1xqXUZ
         IOT3mxBduqo5/BTp/VEG5Z8eHVulR0kpi7nS7U/08mFIQnVClmG8+gzAHYxp1dV0QnpU
         PkKBfqPtxhBtOXiYBjFuepJV04r79tzF6mFVhM4n+qYfg18UjE3CWFpdAfVzsOYiQcDR
         B3z7pMZBDwb3mflHKU8BzveIfyfL/Xb7xyAz0UHuUc6SLF8T+UO2TMVBOl1X0hW/yRiQ
         +5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=DlksHtOrQyZmsU7bPvY1m5kI5oD2xjdDByhRiWVnEt3lTivQMhXtjMV5XhxjrucgYm
         +J4W9mvh8YUFDh8DB0j2Pd2DmhnPI5S0LFKFMWD0pZMLvQGgHkknvLKX7jh/FsvgRTHv
         ip/unJv8M/PSwKqd8KkSObz/LyULiFwV3mjvl9oC5RCFXf64/KkejRO26uN9MJU2GWZl
         hE/oswgOgFqxRrCe7txs8bDWGnCbcZyoN00NwBm4W/kXwBQPA4FjvgllMKEXCFUC5OxZ
         wfLLqJifPkSn56DfBm2a9UNDZbgmvshVeE7NUPtEgktBASzhrV0eSfq5LqF9fmlum+xu
         9jxg==
X-Gm-Message-State: AOAM531GCFIUHXi3LJhB314+/S8ghse6JVOODpGSGex4UQjO28wi9W4G
        KGPA2TyBD3V5eD/ZhfZeYmrRywFu4Bg=
X-Google-Smtp-Source: ABdhPJyqIIGze+tn1O3atyvBtE+uNQ42OU2fX45sIyTt9XrDZUXmAIRIejMOC/g0A0TkD1o4JFe6lw==
X-Received: by 2002:a17:906:ae45:: with SMTP id lf5mr218735ejb.45.1640123925017;
        Tue, 21 Dec 2021 13:58:45 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:44 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] hwmon: (adt7x10) Add device managed action for restoring config
Date:   Tue, 21 Dec 2021 23:58:36 +0200
Message-Id: <20211221215841.2641417-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221215841.2641417-1-demonsingur@gmail.com>
References: <20211221215841.2641417-1-demonsingur@gmail.com>
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

