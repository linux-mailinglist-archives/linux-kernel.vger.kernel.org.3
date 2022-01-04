Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80607483BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiADGWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiADGWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E97C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:22:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so18171704pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SANnKmmJDM4V0xG/YqXU9hEr6097MRlo3+jmVxZzn54=;
        b=GLjmf+BlsK1SKFfdW+0Q8lhUzgb2dtFor7ki1hvavjJ9qlDL2oLZAmwLK15zmplwLe
         x1a03KdQ/lbGiySyKXqinOaYArYNQKDt/7wAxB3DgLYXg3u0ri/uAM1BpwjYxzvJJf07
         egkGB4F9aaxh19UcnMORqFH2mmcURr84Xofww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SANnKmmJDM4V0xG/YqXU9hEr6097MRlo3+jmVxZzn54=;
        b=b3IFZHHG/QTnElx5AGcEz38o9FKoDZor1i00+KVuwDGvZlXtA1qWoaVLCSLlX1q5QN
         RhpO7QrwnV3FTv/8BEyRyaDDXNKqgm55XVxAEXMpY9UB0GmEmUtw8Cz+BNI9uIsPfViA
         PEDL2vmCWNJ6dc5YID+Jtv3PfQfxpO0hNERVk9cIjvJIO2Q+6zdrl/2OwDB7wxxS+wlZ
         u0dzK9fNCZuoLDeDp4JbjVwyGBydZJzXi6z9LoXx1hS/L18n0Lba8ODokedMUYSCaP5g
         adL0QpTntnrBwWo0gx+sSMP0/3PEBdgVTa+9Ua0QlbvmDfx3fbh7XTW+d95Dd9oqyKat
         mGQg==
X-Gm-Message-State: AOAM533U/p7+FrLmAmLraTvCMIzmSadDD4folzrTSAZnvRnqWP49Z0OH
        M2laEDb7FwY0m4/lOJJdazzN5A==
X-Google-Smtp-Source: ABdhPJx9USMKeDdBbF/7dLHBuTS6o4gWeC6aQsi3O6uHRuzpUKjKFK4fk+7IAaOk4uPdAnYNa79KxA==
X-Received: by 2002:a17:90b:1e45:: with SMTP id pi5mr58502144pjb.64.1641277340002;
        Mon, 03 Jan 2022 22:22:20 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6f47:183c:871a:2a1a])
        by smtp.gmail.com with UTF8SMTPSA id k6sm39779334pfu.96.2022.01.03.22.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:22:19 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/3] plaform/chrome: Remove SIMPLE_DEV_PM_OPS
Date:   Mon,  3 Jan 2022 22:22:12 -0800
Message-Id: <20220104062213.2365356-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104062213.2365356-1-gwendal@chromium.org>
References: <20220104062213.2365356-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 296282fca791 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
replaces SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.

Use sed and a cocci script to replace the macro and remove
__maybe_unused:
@ Replacement @
identifier operation;
identifier suspend, resume;
@@

gg_type operation = gg_arg(suspend, resume);

@@
identifier Replacement.suspend;
identifier dev;
@@

- __maybe_unused
suspend(struct device* dev ) { ... }

@@
identifier Replacement.resume;
identifier dev;
@@

- __maybe_unused
resume(struct device* dev ) { ... }

@@
identifier Replacement.operation;
@@

- &operation
+ pm_sleep_ptr(&operation)

find drivers/platform/chrome -type f -name \*.c \
-exec sed -i 's/static SIMPLE_DEV_PM_OPS(\(.*\), */gg_type \1 = gg_arg(/' {} \+
spatch -sp_file no_SIMPLE_DEV_PM_OPS.cocci -dir drivers/platform/chrome | \
patch -p 1 -d drivers/platform/chrome/
sed -i 's/gg_type \(.*\) = gg_arg(/DEFINE_SIMPLE_DEV_PM_OPS(\1, /' $(git diff --name-only)

Remove #ifdef CONFIG_PM_SLEEP when not needed anymore.
Test with make allmodconfig, with CONFIG_PM_SLEEP set to 'y' and 'n'.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/chromeos_tbmc.c     | 6 +++---
 drivers/platform/chrome/cros_ec_debugfs.c   | 8 ++++----
 drivers/platform/chrome/cros_ec_ishtp.c     | 8 ++++----
 drivers/platform/chrome/cros_ec_lightbar.c  | 8 ++++----
 drivers/platform/chrome/cros_ec_rpmsg.c     | 6 ++----
 drivers/platform/chrome/cros_ec_sensorhub.c | 6 ++----
 drivers/platform/chrome/cros_ec_spi.c       | 6 ++----
 drivers/platform/chrome/cros_usbpd_logger.c | 8 ++++----
 8 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index d1cf8f3463ce3b..c10f39b3eb53be 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -38,7 +38,7 @@ static int chromeos_tbmc_query_switch(struct acpi_device *adev,
 	return 0;
 }
 
-static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
+static int chromeos_tbmc_resume(struct device *dev)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
 
@@ -101,7 +101,7 @@ static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
 
-static SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
+DEFINE_SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
 		chromeos_tbmc_resume);
 
 static struct acpi_driver chromeos_tbmc_driver = {
@@ -112,7 +112,7 @@ static struct acpi_driver chromeos_tbmc_driver = {
 		.add = chromeos_tbmc_add,
 		.notify = chromeos_tbmc_notify,
 	},
-	.drv.pm = &chromeos_tbmc_pm_ops,
+	.drv.pm = pm_sleep_ptr(&chromeos_tbmc_pm_ops),
 };
 
 module_acpi_driver(chromeos_tbmc_driver);
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 272c89837d745a..c72c13ad7943fc 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -491,7 +491,7 @@ static int cros_ec_debugfs_remove(struct platform_device *pd)
 	return 0;
 }
 
-static int __maybe_unused cros_ec_debugfs_suspend(struct device *dev)
+static int cros_ec_debugfs_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
@@ -501,7 +501,7 @@ static int __maybe_unused cros_ec_debugfs_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
+static int cros_ec_debugfs_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
@@ -511,13 +511,13 @@ static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cros_ec_debugfs_pm_ops,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_debugfs_pm_ops,
 			 cros_ec_debugfs_suspend, cros_ec_debugfs_resume);
 
 static struct platform_driver cros_ec_debugfs_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &cros_ec_debugfs_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_debugfs_pm_ops),
 	},
 	.probe = cros_ec_debugfs_probe,
 	.remove = cros_ec_debugfs_remove,
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 4020b8354bae90..0f14f5782bee25 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -739,7 +739,7 @@ static int cros_ec_ishtp_reset(struct ishtp_cl_device *cl_device)
  *
  * Return: 0 for success, negative error code for failure.
  */
-static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
+static int cros_ec_ishtp_suspend(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
@@ -754,7 +754,7 @@ static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
  *
  * Return: 0 for success, negative error code for failure.
  */
-static int __maybe_unused cros_ec_ishtp_resume(struct device *device)
+static int cros_ec_ishtp_resume(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
@@ -763,7 +763,7 @@ static int __maybe_unused cros_ec_ishtp_resume(struct device *device)
 	return cros_ec_resume(client_data->ec_dev);
 }
 
-static SIMPLE_DEV_PM_OPS(cros_ec_ishtp_pm_ops, cros_ec_ishtp_suspend,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_ishtp_pm_ops, cros_ec_ishtp_suspend,
 			 cros_ec_ishtp_resume);
 
 static struct ishtp_cl_driver	cros_ec_ishtp_driver = {
@@ -773,7 +773,7 @@ static struct ishtp_cl_driver	cros_ec_ishtp_driver = {
 	.remove = cros_ec_ishtp_remove,
 	.reset = cros_ec_ishtp_reset,
 	.driver = {
-		.pm = &cros_ec_ishtp_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_ishtp_pm_ops),
 	},
 };
 
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 469dfc7a4a0302..52647d6804fc30 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -574,7 +574,7 @@ static int cros_ec_lightbar_remove(struct platform_device *pd)
 	return 0;
 }
 
-static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
+static int cros_ec_lightbar_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
@@ -584,7 +584,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
 }
 
-static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
+static int cros_ec_lightbar_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
@@ -594,13 +594,13 @@ static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
 }
 
-static SIMPLE_DEV_PM_OPS(cros_ec_lightbar_pm_ops,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_lightbar_pm_ops,
 			 cros_ec_lightbar_suspend, cros_ec_lightbar_resume);
 
 static struct platform_driver cros_ec_lightbar_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &cros_ec_lightbar_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_lightbar_pm_ops),
 	},
 	.probe = cros_ec_lightbar_probe,
 	.remove = cros_ec_lightbar_remove,
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index d96d15b8ca946d..c8afb152673070 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -266,7 +266,6 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
 	cancel_work_sync(&ec_rpmsg->host_event_work);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cros_ec_rpmsg_suspend(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
@@ -280,9 +279,8 @@ static int cros_ec_rpmsg_resume(struct device *dev)
 
 	return cros_ec_resume(ec_dev);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
 			 cros_ec_rpmsg_resume);
 
 static const struct of_device_id cros_ec_rpmsg_of_match[] = {
@@ -295,7 +293,7 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
 	.drv = {
 		.name   = "cros-ec-rpmsg",
 		.of_match_table = cros_ec_rpmsg_of_match,
-		.pm	= &cros_ec_rpmsg_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_rpmsg_pm_ops),
 	},
 	.probe		= cros_ec_rpmsg_probe,
 	.remove		= cros_ec_rpmsg_remove,
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 31fb8bdaad5a35..5e05ca6cdc2841 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -216,7 +216,6 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * When the EC is suspending, we must stop sending interrupt,
  * we may use the same interrupt line for waking up the device.
@@ -241,16 +240,15 @@ static int cros_ec_sensorhub_resume(struct device *dev)
 		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_pm_ops,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_pm_ops,
 		cros_ec_sensorhub_suspend,
 		cros_ec_sensorhub_resume);
 
 static struct platform_driver cros_ec_sensorhub_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &cros_ec_sensorhub_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_sensorhub_pm_ops),
 	},
 	.probe = cros_ec_sensorhub_probe,
 };
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d52..51db572c8166af 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -793,7 +793,6 @@ static int cros_ec_spi_remove(struct spi_device *spi)
 	return cros_ec_unregister(ec_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cros_ec_spi_suspend(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
@@ -807,9 +806,8 @@ static int cros_ec_spi_resume(struct device *dev)
 
 	return cros_ec_resume(ec_dev);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cros_ec_spi_pm_ops, cros_ec_spi_suspend,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_spi_pm_ops, cros_ec_spi_suspend,
 			 cros_ec_spi_resume);
 
 static const struct of_device_id cros_ec_spi_of_match[] = {
@@ -828,7 +826,7 @@ static struct spi_driver cros_ec_driver_spi = {
 	.driver	= {
 		.name	= "cros-ec-spi",
 		.of_match_table = cros_ec_spi_of_match,
-		.pm	= &cros_ec_spi_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_spi_pm_ops),
 	},
 	.probe		= cros_ec_spi_probe,
 	.remove		= cros_ec_spi_remove,
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index d16931203d8216..9df5a146df2fc0 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -229,7 +229,7 @@ static int cros_usbpd_logger_remove(struct platform_device *pd)
 	return 0;
 }
 
-static int __maybe_unused cros_usbpd_logger_resume(struct device *dev)
+static int cros_usbpd_logger_resume(struct device *dev)
 {
 	struct logger_data *logger = dev_get_drvdata(dev);
 
@@ -239,7 +239,7 @@ static int __maybe_unused cros_usbpd_logger_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cros_usbpd_logger_suspend(struct device *dev)
+static int cros_usbpd_logger_suspend(struct device *dev)
 {
 	struct logger_data *logger = dev_get_drvdata(dev);
 
@@ -248,13 +248,13 @@ static int __maybe_unused cros_usbpd_logger_suspend(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cros_usbpd_logger_pm_ops, cros_usbpd_logger_suspend,
+DEFINE_SIMPLE_DEV_PM_OPS(cros_usbpd_logger_pm_ops, cros_usbpd_logger_suspend,
 			 cros_usbpd_logger_resume);
 
 static struct platform_driver cros_usbpd_logger_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &cros_usbpd_logger_pm_ops,
+		.pm = pm_sleep_ptr(&cros_usbpd_logger_pm_ops),
 	},
 	.probe = cros_usbpd_logger_probe,
 	.remove = cros_usbpd_logger_remove,
-- 
2.34.1.448.ga2b2bfdf31-goog

