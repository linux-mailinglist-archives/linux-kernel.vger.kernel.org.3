Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101E47C89D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhLUVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLUVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A89C061574;
        Tue, 21 Dec 2021 13:04:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so51204edd.13;
        Tue, 21 Dec 2021 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=mSiUnTv5w8enX0b6/8PFH7o2UKqfd/ZnuYkWlWm2rTNcqT2nP63+87lcDFw89xn8t0
         fofeZCh77i//ggBh5SiSRyPOvYAPilwof2iW1RkqZUuRWfVb5Qch4+3V+FescsgZGa5Y
         +Ro2B8b7O7MuG4rLliCsgPcJZR+FSRUFtxDYParJnCfanU5nYevGkAzPoY3v/6OWYrep
         iYCGaJ3LmzAVIQsHuv3aD5E1iNNbJ7VGmzquMlu/EGzmGGc4qLUCI7HmjorFTq3qCTXe
         uiIvlyitqD+aNiJIVMF4/kTm1pOEHdt/yxrNVyFPeA9QEHk/OEDAeRTuRY7BB08WLS3V
         wh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=VXzXuJ548CjRkjmmQNgtpyl9rXY7/tQ41SzrMdU8+fQ1CRcUeF60QPRzMAwN3IvAhf
         X7db5zDymfcOgiTGI3zicAruG+DG8M4Gkha+O3w9uPMopRngTqv0sbAV1jR3wUSbTpyj
         QiJA9yuwAp0zASh0Cf7FrRbxYRJDw1AyIzfU+Ro/HduMfg8qsSQlvmV4Nie78oSUhqLH
         N8QCUNGSZ3cU1BLnsAj+fEDtZugDAgRjOKgB+fZ8sJ61TVwNync1K9+k19GgZVR0slEE
         Ir5LY3nW8D7Jep22Hdkfq9uH03XnZP0Fc7kPtrgKr0G87O0LTtN5EekFUIIDTryJFLCA
         Q9yg==
X-Gm-Message-State: AOAM533nojMQFMg9xtlJTRUbetM8GsJnyn6PR5aV9q5jKZeVCeVQQJNd
        YdUJijVsQ3luSpPA/f9WMbg=
X-Google-Smtp-Source: ABdhPJyitlYUpvhWvCVjI1iSiy0RIei5/ke1CSbDRQOK2r9PgLzKBzV+blp3rzf6lSBwHtnXGlVA6w==
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr118876edc.44.1640120698122;
        Tue, 21 Dec 2021 13:04:58 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:57 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] hwmon: (adt7x10) Remove empty driver removal callback
Date:   Tue, 21 Dec 2021 23:04:36 +0200
Message-Id: <20211221210438.2637430-7-demonsingur@gmail.com>
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

