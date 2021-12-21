Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61547C8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhLUV65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhLUV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BCC06173F;
        Tue, 21 Dec 2021 13:58:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j6so520460edw.12;
        Tue, 21 Dec 2021 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=qOR8cKxnS3ZJJz3OxqRS3itG7sanLjdILZWuTHo09csws4f4eFsGVX1pzrKpACL375
         BIaUzK5aUDNDol2+pbW2sQI9AZA3bDcAH0yJ3WgHX2h3PlSmX9xJu0YJu77hbX2Zgp3m
         I+RFc34f7ieVSpI196swXqsYgO/1XhquxxfMNtHsqj1BxYEM2qkLo3ZfDBAihX6V4IOv
         O/i3XXtiLrwFvc/FcCgxtIDzfwKNBrpeNqWdUTNQ6PazvzQru2s3UO2/8c9sJfug2Yfg
         IetXODEQCwTMuqPJL+ByNE9AtmK9LVSzx2S6Hw8FGW0mdc2oidg4YvZTwI7aV/hDtBkz
         Qxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=Ks8IQO1kS+duxzq4ALUN0WOkWuNYyiyYJTEoUWohOP3XP7UTqQ5Tk94gMclVRPC33V
         DVzDP05tDJbLBc1P9IMROxfpgPscSPGZfnMCabvT2lLP4uRv6qZnTIRI7bsHc32oqt8m
         DT3qOxGXLNwJS3yM605cSRdoDGBPdeSox2sme8t+FQ4nz501hfxvLNS5QEwH/zeRjLJH
         THRmWpAvAUXC67fbQ5IneuZa1mQuhz9gGKmDfEYp4Q1R3jpVyZqPObCPSA3SiBr3TGA1
         +UOnnA8ulIui2c35PJZ+A2t92uQ+zKdMxh1P7a9LHjBiAfPQkl+DbQu+kJ7n4g/GpM1I
         Tdww==
X-Gm-Message-State: AOAM531fY2n8aXHQ+TWKUNN4AvpHWBcGK4FjMGaZTfVSE340YuOw26b3
        gqD9/KgqSFphLmRe6m6Uc9vVxearg38=
X-Google-Smtp-Source: ABdhPJzjx0M0kbQ8GokJoi0CRdhwYdurHNLq0F3uCkAm3peN6cBjtiC0G1C0TC1htpBKWxEGPguE9g==
X-Received: by 2002:a17:907:da8:: with SMTP id go40mr247976ejc.78.1640123927790;
        Tue, 21 Dec 2021 13:58:47 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:47 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] hwmon: (adt7x10) Remove empty driver removal callback
Date:   Tue, 21 Dec 2021 23:58:39 +0200
Message-Id: <20211221215841.2641417-6-demonsingur@gmail.com>
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

Not used to do anything anymore.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7310.c | 7 -------
 drivers/hwmon/adt7410.c | 7 -------
 drivers/hwmon/adt7x10.c | 5 -----
 drivers/hwmon/adt7x10.h | 1 -
 4 files changed, 20 deletions(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index c40cac16af68..4a69b394525b 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -88,12 +88,6 @@ static int adt7310_spi_probe(struct spi_device *spi)
 			&adt7310_spi_ops);
 }
 
-static int adt7310_spi_remove(struct spi_device *spi)
-{
-	adt7x10_remove(&spi->dev, spi->irq);
-	return 0;
-}
-
 static const struct spi_device_id adt7310_id[] = {
 	{ "adt7310", 0 },
 	{ "adt7320", 0 },
@@ -107,7 +101,6 @@ static struct spi_driver adt7310_driver = {
 		.pm	= ADT7X10_DEV_PM_OPS,
 	},
 	.probe		= adt7310_spi_probe,
-	.remove		= adt7310_spi_remove,
 	.id_table	= adt7310_id,
 };
 module_spi_driver(adt7310_driver);
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index ef4b5af865e9..2ad79533a384 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -48,12 +48,6 @@ static int adt7410_i2c_probe(struct i2c_client *client)
 	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
 }
 
-static int adt7410_i2c_remove(struct i2c_client *client)
-{
-	adt7x10_remove(&client->dev, client->irq);
-	return 0;
-}
-
 static const struct i2c_device_id adt7410_ids[] = {
 	{ "adt7410", 0 },
 	{ "adt7420", 0 },
@@ -68,7 +62,6 @@ static struct i2c_driver adt7410_driver = {
 		.pm	= ADT7X10_DEV_PM_OPS,
 	},
 	.probe_new	= adt7410_i2c_probe,
-	.remove		= adt7410_i2c_remove,
 	.id_table	= adt7410_ids,
 	.address_list	= I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
 };
diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 84e8879d4ca7..72d3a5de359e 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -463,11 +463,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 }
 EXPORT_SYMBOL_GPL(adt7x10_probe);
 
-void adt7x10_remove(struct device *dev, int irq)
-{
-}
-EXPORT_SYMBOL_GPL(adt7x10_remove);
-
 #ifdef CONFIG_PM_SLEEP
 
 static int adt7x10_suspend(struct device *dev)
diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
index a1ae682eb32e..bde674e24ca0 100644
--- a/drivers/hwmon/adt7x10.h
+++ b/drivers/hwmon/adt7x10.h
@@ -26,7 +26,6 @@ struct adt7x10_ops {
 
 int adt7x10_probe(struct device *dev, const char *name, int irq,
 	const struct adt7x10_ops *ops);
-void adt7x10_remove(struct device *dev, int irq);
 
 #ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops adt7x10_dev_pm_ops;
-- 
2.34.1

