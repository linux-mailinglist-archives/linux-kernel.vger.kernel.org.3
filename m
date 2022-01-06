Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A298C4863AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiAFLXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiAFLXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:23:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE8C061245;
        Thu,  6 Jan 2022 03:23:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so2848866pjw.2;
        Thu, 06 Jan 2022 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8FX0A5Kbtc/SDjrZH5+V6SgTQIDB1WRtKLBXqBVTtUc=;
        b=GZBZi5rk3OlCgYpSq7FsQoQDSsN14AOJc+eQKL8IdMiz3kNtGMobKJnl/7UnskJEib
         SXbjbP5TCDhG+2UsCJirhdlHgCvKxLBtG3kg+Y9SR9tM3TXrDyGqPtrnpukXJwrqCVA5
         FMSwZdEWxmZdtZjX9yJnSFgBUaQpyWuXT4OKI6FeU9faWsu19/J2tcgHyiEzyT4Z4+sK
         eLrPYkiiQKRc3w7DsuFUNxXkhGZrbT92dAHXrqXrW0rjQ688ITR0mUkOScYStqq6YZW7
         nDXGUELQi9RXyV883Ue8swOrDYECDuRXrzx6vUbnznmMd1Be4iJSot29Lh9faW96/oMD
         1MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8FX0A5Kbtc/SDjrZH5+V6SgTQIDB1WRtKLBXqBVTtUc=;
        b=uC7TEHckgTCtRk+w45UuNSzQfJC97pVF2T8V0J+A2Qis9tsh5s6WNM8z1qZUHgp6vE
         KmVyrcQinSfDSg//sRspOIlBz4TxtsrJKezDWiNknrkiF/1cec7RShFAXQ0tTdcN9S7e
         y8bDq+DrsXktYVvBj2o6KjaKG5uHg1bn1xdnCzNA9LyW2fij5bjYFsQKYW57HOXQxU+H
         ULDUCpv4mM/0da8pMGrrsZkbM65RffOf0oZ1Z2m0uVkTqb+DP3zl1UfqPpDGhE55AVQm
         SArOBso77Ls7Sa6KuYT7AgIDJF9B9MokFaEGpdzyj/Us1+ecaz/vHaC6y+vSra9KsPTy
         +Gqg==
X-Gm-Message-State: AOAM5306XxmBT88mkm3S98kO0NsylqBZC8PkjRqXlAWSQRZjpKrKl4wD
        n2fphq6eVNgg3LKvUpl3tSt20u+VMVz2G4xV
X-Google-Smtp-Source: ABdhPJyg5v4WJc6YsBawDBHbjsHdrrbFy0oIR/D6LZggwbw8tAMMz3z8qgE/37xlfi4N/4zdsC78Xg==
X-Received: by 2002:a17:90b:314e:: with SMTP id ip14mr9512736pjb.171.1641468196794;
        Thu, 06 Jan 2022 03:23:16 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l11sm2342117pfu.115.2022.01.06.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:23:16 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     adi.reus@gmail.com, ardeleanalex@gmail.com, gwendal@chromium.org,
        jic23@kernel.org, lars@metafoo.de, linmq006@gmail.com,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephan@gerhold.net
Subject: [PATCH v2] iio: Fix error handling for PM
Date:   Thu,  6 Jan 2022 11:23:09 +0000
Message-Id: <20220106112309.16879-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YdWjHWowWXy01zaE@smile.fi.intel.com>
References: <YdWjHWowWXy01zaE@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable(). In the PM Runtime docs:
    Drivers in ->remove() callback should undo the runtime PM changes done
    in ->probe(). Usually this means calling pm_runtime_disable(),
    pm_runtime_dont_use_autosuspend() etc.
We should do this in error handling.

Fix this problem for the following drivers: bmc150, bmg160, kmx61,
kxcj-1013, mma9551, mma9553.

Fixes: 7d0ead5c3f00 ("iio: Reconcile operation order between iio_register/unregister and pm functions")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- fix the fixes tag
- fix similar problems introduced by the same commit
---
 drivers/iio/accel/bmc150-accel-core.c  | 5 ++++-
 drivers/iio/accel/kxcjk-1013.c         | 5 ++++-
 drivers/iio/accel/mma9551.c            | 5 ++++-
 drivers/iio/accel/mma9553.c            | 5 ++++-
 drivers/iio/gyro/bmg160_core.c         | 5 ++++-
 drivers/iio/imu/kmx61.c                | 5 ++++-
 drivers/iio/magnetometer/bmc150_magn.c | 5 +++--
 7 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index b0678c351e82..c3a2b4c0b3b2 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1783,11 +1783,14 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "Unable to register iio device\n");
-		goto err_trigger_unregister;
+		goto err_pm_cleanup;
 	}
 
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
 err_trigger_unregister:
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 err_buffer_cleanup:
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 24c9387c2968..ba6c8ca488b1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1589,11 +1589,14 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_pm_cleanup;
 	}
 
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(&client->dev);
+	pm_runtime_disable(&client->dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..c53a3398b14c 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -495,11 +495,14 @@ static int mma9551_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to register iio device\n");
-		goto out_poweroff;
+		goto err_pm_cleanup;
 	}
 
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(&client->dev);
+	pm_runtime_disable(&client->dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
 
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ba3ecb3b57dc..1599b75724d4 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1134,12 +1134,15 @@ static int mma9553_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to register iio device\n");
-		goto out_poweroff;
+		goto err_pm_cleanup;
 	}
 
 	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(&client->dev);
+	pm_runtime_disable(&client->dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
 	return ret;
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 17b939a367ad..81a6d09788bd 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1188,11 +1188,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_pm_cleanup;
 	}
 
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 1dabfd615dab..f89724481df9 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1385,7 +1385,7 @@ static int kmx61_probe(struct i2c_client *client,
 	ret = iio_device_register(data->acc_indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register acc iio device\n");
-		goto err_buffer_cleanup_mag;
+		goto err_pm_cleanup;
 	}
 
 	ret = iio_device_register(data->mag_indio_dev);
@@ -1398,6 +1398,9 @@ static int kmx61_probe(struct i2c_client *client,
 
 err_iio_unregister_acc:
 	iio_device_unregister(data->acc_indio_dev);
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(&client->dev);
+	pm_runtime_disable(&client->dev);
 err_buffer_cleanup_mag:
 	if (client->irq > 0)
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index f96f53175349..3d4d21f979fa 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -962,13 +962,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "unable to register iio device\n");
-		goto err_disable_runtime_pm;
+		goto err_pm_cleanup;
 	}
 
 	dev_dbg(dev, "Registered device %s\n", name);
 	return 0;
 
-err_disable_runtime_pm:
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-- 
2.17.1

