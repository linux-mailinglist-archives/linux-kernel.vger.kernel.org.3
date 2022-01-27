Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA93D49DCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiA0Igi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiA0Igd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:36:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD75C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r59so2219445pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cB6BQlkH3tVpBvxYH7RGzF//Mdgv4SIiThB1PpNT8c=;
        b=hWpvbgR85SykG0uPKlggJxreC7FZWygPtTwswJ0WGv89ZwzqKkEcQF08a0WAnJ4HuO
         6LUrPJw3x7lb2ZYUbNS+pdWaOT96fk7j6hlnz8Q+HzzpEVJiusMNHoLtpB4BoZDpNBMY
         qA9G83KpyFFP8MVYrxuDqTtQZnEVEyDrh0Fq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cB6BQlkH3tVpBvxYH7RGzF//Mdgv4SIiThB1PpNT8c=;
        b=k+aY6hY1K3/Ag42qqCnlnVvwrDopZZFPXARRKCycpIWVW25TCmjX1ZeWbPgy/OmhWU
         AE3oFU+7sHoaydHIngPsIxF1EngsNnQhNYrrETrNShVcu661u+btjYD8A/ueRqF/0nvu
         7GWLcLqvGJR44KLvOq+6O1+xELJYAfWydTA6Kr7rdjLSS9VNdMatW2X/aZzf7X3c+akO
         usMqY6YdrrT0Q5h1O9/G4zHtmn0AXHgo6hWVzdeW4idgBNC1Wd8zROBi5I5/ECgA1o4z
         j37SRaDJ5tF9Qdy0rPCphWiEiwNWL3N7d/vOyY04+Z9/p8A9FLK7IuPB/vlYGoiOiPAl
         gUsA==
X-Gm-Message-State: AOAM532plfuOXfl+ob8N3r9mzmYEhgYml3L3SwuWDmVz8TXpa/Yqg31e
        XcdKer2BXVaD0O9Zl6N2eNioFvLn3E9X2A==
X-Google-Smtp-Source: ABdhPJwdt0MnHkgPn5sEM05523pP62A+RnVLw4nwtBmbPb6w+6/eL+m4tVJMPBe1VPuuEvt2zGN8KQ==
X-Received: by 2002:a17:90b:1a85:: with SMTP id ng5mr13089576pjb.53.1643272592406;
        Thu, 27 Jan 2022 00:36:32 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:f81:dff7:4d7c:382])
        by smtp.gmail.com with UTF8SMTPSA id l17sm4666614pfu.61.2022.01.27.00.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:36:32 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, evanbenn@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
Date:   Thu, 27 Jan 2022 19:35:45 +1100
Message-Id: <20220127083545.1020423-3-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127083545.1020423-1-skyostil@chromium.org>
References: <20220127083545.1020423-1-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an ioctl operation for sending and receiving data from
the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
userspace programs to perform a combined read/write I2C transaction
through a single syscall.

The I2C wire protocol for the device is documented at:

https://chromium.googlesource.com/chromiumos/platform/hps-firmware/+/
refs/heads/main/docs/host_device_i2c_protocol.md

Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
---

 MAINTAINERS              |  1 +
 drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/hps.h | 20 ++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 include/uapi/linux/hps.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dea4b8c2ab5..d5fc066fdbc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8803,6 +8803,7 @@ M:	Sami Kyöstilä <skyostil@chromium.org>
 R:	Evan Benn <evanbenn@chromium.org>
 S:	Maintained
 F:	drivers/misc/hps-i2c.c
+F:	include/uapi/linux/hps.h
 
 HSI SUBSYSTEM
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
index fe9f073b0352..748ead49d678 100644
--- a/drivers/misc/hps-i2c.c
+++ b/drivers/misc/hps-i2c.c
@@ -17,9 +17,11 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <uapi/linux/hps.h>
 
 #define HPS_ACPI_ID		"GOOG0020"
 #define HPS_MAX_DEVICES		1
+#define HPS_MAX_MSG_SIZE	8192
 
 struct hps_drvdata {
 	struct i2c_client *client;
@@ -60,6 +62,8 @@ static int hps_open(struct inode *inode, struct file *file)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		goto pm_get_fail;
+
+	file->private_data = hps->client;
 	return 0;
 
 pm_get_fail:
@@ -84,10 +88,87 @@ static int hps_release(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static int hps_do_ioctl_transfer(struct i2c_client *client,
+				 struct hps_transfer_ioctl_data *args)
+{
+	int ret;
+	int nmsg = 0;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+		},
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+		},
+	};
+
+	if (args->isize) {
+		msgs[nmsg].len = args->isize;
+		msgs[nmsg].buf = memdup_user(args->ibuf, args->isize);
+		if (IS_ERR(msgs[nmsg].buf)) {
+			ret = PTR_ERR(msgs[nmsg].buf);
+			goto memdup_fail;
+		}
+		nmsg++;
+	}
+
+	if (args->osize) {
+		msgs[nmsg].len = args->osize;
+		msgs[nmsg].buf = memdup_user(args->obuf, args->osize);
+		msgs[nmsg].flags |= I2C_M_RD;
+		if (IS_ERR(msgs[nmsg].buf)) {
+			ret = PTR_ERR(msgs[nmsg].buf);
+			goto memdup_fail;
+		}
+		nmsg++;
+	}
+
+	ret = i2c_transfer(client->adapter, &msgs[0], nmsg);
+	if (ret > 0 && args->osize) {
+		if (copy_to_user(args->obuf, msgs[nmsg - 1].buf, ret))
+			ret = -EFAULT;
+	}
+
+memdup_fail:
+	while (nmsg > 0)
+		kfree(msgs[--nmsg].buf);
+	return ret;
+}
+
+static long hps_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = file->private_data;
+
+	switch (cmd) {
+	case HPS_IOC_TRANSFER: {
+		struct hps_transfer_ioctl_data args;
+
+		if (copy_from_user(&args,
+				   (struct hps_transfer_ioctl_data __user *)arg,
+				   sizeof(args))) {
+			return -EFAULT;
+		}
+
+		if (!args.isize && !args.osize)
+			return -EINVAL;
+		if (args.isize > HPS_MAX_MSG_SIZE || args.osize > HPS_MAX_MSG_SIZE)
+			return -EINVAL;
+
+		return hps_do_ioctl_transfer(client, &args);
+	}
+	default:
+		return -EFAULT;
+	}
+}
+
+
 const struct file_operations hps_fops = {
 	.owner = THIS_MODULE,
 	.open = hps_open,
 	.release = hps_release,
+	.unlocked_ioctl = hps_ioctl,
 };
 
 static int hps_i2c_probe(struct i2c_client *client)
diff --git a/include/uapi/linux/hps.h b/include/uapi/linux/hps.h
new file mode 100644
index 000000000000..2c1bd174cd02
--- /dev/null
+++ b/include/uapi/linux/hps.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ *  Copyright 2022 Google LLC.
+ */
+
+#ifndef _UAPI_HPS_H
+#define _UAPI_HPS_H
+
+#include <linux/types.h>
+
+#define HPS_IOC_TRANSFER	_IOWR('h', 0x01, struct hps_transfer_ioctl_data)
+
+struct hps_transfer_ioctl_data {
+	__u32 isize;			/* Number of bytes to send */
+	unsigned char __user *ibuf;	/* Input buffer */
+	__u32 osize;			/* Number of bytes to receive */
+	unsigned char __user *obuf;	/* Output buffer */
+};
+
+#endif /* _UAPI_HPS_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

