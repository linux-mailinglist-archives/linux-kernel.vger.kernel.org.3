Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7154247C81B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhLUULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhLUUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16C6C06173F;
        Tue, 21 Dec 2021 12:11:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z29so56386907edl.7;
        Tue, 21 Dec 2021 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=KD9YPs0vn5CRpbMzX23WzwSZW9pwp1o+e5tCJWGTnr0Z23o499M1S6CGKXGcymzYO8
         Sq4+HZSSZDfQQVVw+hC8xpnVxAen+Z02nhZ7TKziTBox8nuUKttyyCftaZCIVI4S1QyD
         uDi5DKWnX1P+feIICgVTC7wdOatJe/YTMkjIemYuuM+4++roVPh51oELiAyt3b+AC/Yi
         qw51Ksupq/hdOPRkgGwH0bq32YH2DMYR+P8GAFdIoId0s07+/YwXAObx0V0xnvf0u3kD
         KkXjBR+5Pn34mMbMyMz6uwmSg4YeatDJYBHsPIH4uvCL6+HMN7ms5RIOnmFaA9RgLG2H
         8fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJbcpdnDDMMTdDCFrmCCsQpcL+qTK/8WeB+Pk+8w5E4=;
        b=QOO/uvB8iT5vxXQTtVxBpheKJUCmvvmJhYD0MBcPfnDcW4pc0RKcd1sH/LsZw1rze0
         IlnNBEQrLrUFX+T+xfQk4LKJByK8cWD98KY+1b96OmN4sDRnC1MXMzDc2BS7FHIh2LsZ
         hauIeZH0/CRQJIztw35ITUMNi7ZL8V8T6yIN/oa5MTI8HLbB3sYyfP5XyFSqm90QEJn8
         z4K5FV1XYRGuOkPBC7DfysYOi/VbMBsPSWGRa/yevgopRqXxJq9Tm/BkoT+IjGEQzoTV
         nYED2xvGen8QHo2f/EPL0n8839C+fPKKdlYyCSbMj2FwueyD8sCuLdkmrU/aVhTgOq9K
         9bfA==
X-Gm-Message-State: AOAM532icozctm1Z3DvsJpcBMnaEAvXQz4R+crChTBJDwlO2MMipLzW4
        VEdebPhW60OmEOM8e+g2dCo=
X-Google-Smtp-Source: ABdhPJxnsjb0s7EdEpBiQWUMRjRxqnwWdLFR5/GgF/cvO4lCZVutWZJsOYloxYw4vY3mjWuLro07lg==
X-Received: by 2002:a17:907:7f8f:: with SMTP id qk15mr4180352ejc.455.1640117487563;
        Tue, 21 Dec 2021 12:11:27 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:27 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/8] hwmon: (adt7x10) Add device managed action for restoring config
Date:   Tue, 21 Dec 2021 22:11:08 +0200
Message-Id: <20211221201113.752827-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221201113.752827-1-demonsingur@gmail.com>
References: <20211221201113.752827-1-demonsingur@gmail.com>
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

