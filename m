Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951447C820
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhLUULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhLUULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C1C061574;
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so27962158edd.8;
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=eYx0at8HNSAAuVnTdvx4KhFG0+3h2Gahlmw1DGbdUf9o1MPoEdK2OHsB+fr3Y01LgD
         vFWr6q97pdJwwl9+uAioOupL8/qt7WeyOrNS2io2HEw8VFsFbAGWPw/teXMxQdnvXW9X
         87nmcLe+XXpbjwpJ43NEmoYaFuDPe+MCCgmkskW95Cxw45QZ+8sHQgf8IQ2dIDPL5V8f
         41j1TS9p5WGCyb1ih6ZwpuQ0W/+bA8jDJ9mX7LuHg9EBkcDVtPph5w+L7/fXrf/AOsoQ
         fy8FzQqtpCKA+5ZKjIQCT964zm7Y/+JgCvvicerP0cH6rUWu+55PK+ZxlfOrKFI+93/0
         Gk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA+v3goAVRURICMHVlSY017b1rgwX+hSP8YzYWtBDZY=;
        b=G9umAMawYex90hpJg92/13M3i3DPANsXSpnqYx1uWzLVt+stXEeVTh6xWmr4QDHM5V
         8YC9RCwzMeWNDROlZYz8dknq9QXRdUdTE3PwoW6kvBsptbdh7eN3Ly7+OlgvicVXgTgY
         IhZbL2ilhUCf2E5pkWI/N38QiBHNsRpZNyjNpkaRbJ6u6kRYf6nBnCqpfTQ5BmJ0vShv
         D4Ub0A9p/h7jLF72T5Hc52QmmFNELxaUupuVVl5KQId91ioprF51SSMRNP9TWu5+nO7Q
         69lQOE9yMFxHDqWsii7+vNM6fJHVSOVUJVcgBwU4EmW3Xm4do4wZWHXZaaaO/9kFo+oS
         SxMQ==
X-Gm-Message-State: AOAM533A4K9wQAkR1eb2r9C7fBWFgRn1PSk0GcRajKULOYVFmDzhTkl0
        7PMv0OY3w5VOUcNwOz7vES0=
X-Google-Smtp-Source: ABdhPJxoQTWDPiGl6u8xtB5wrijgR5K+mMDwmuzyTC3ohCw6pCzL0AdN9r9lmCB9Wk1Ki+L9mHVGxA==
X-Received: by 2002:a17:906:d554:: with SMTP id cr20mr3952464ejc.356.1640117490633;
        Tue, 21 Dec 2021 12:11:30 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:30 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] hwmon: (adt7x10) Remove empty driver removal callback
Date:   Tue, 21 Dec 2021 22:11:11 +0200
Message-Id: <20211221201113.752827-6-demonsingur@gmail.com>
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

