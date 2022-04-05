Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ECE4F4DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583016AbiDEXuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348947AbiDEJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323EA5E84
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:38:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so18429628wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDQpY3c16JMV/jnTjMb+uHPqUg2ziPK08NP7ftGP+Bg=;
        b=GnJ5ccsU8yM52MY2dEtsITaa5H4dJ9cMEwh198EEPjheoMARjNFyADd/6dS78OVzGu
         AZwIJ1MuGn7tVuXhNvRlaID+FgWbOOK858AsaU1V3cFGb4D8Jlw4JFGmQtLKwdPxhIYK
         4NeJRTtYYTRPD1TApLxhqLtNJdi8rQHHe2nMWPvl0mvNdpoHAPk60UznJ+UlUeZNlwE3
         PjajDZH0G1qHhJYdCBx9yelx1XJPdqx5DqvQwcnTNLEIH2aKKZp7l2lDPIRXkm0PQaSA
         usVBu+B+Yj6+EIC2DDYr4165/qNI6X+ZFZq9FX/AQxW6rTT8NAmbC8UUcq5ldljQzULt
         OydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDQpY3c16JMV/jnTjMb+uHPqUg2ziPK08NP7ftGP+Bg=;
        b=qTH1ouyHRwIVbztG7OfUr2/SWyH8b0bHwRRkmnr0qxa1EmT/8m+lVGQKv7nCrAWsaT
         W+/n6PDs/Dd9UgdumVk7sjsZ3FWJp7XBQeOZECD6qWqXnPv4Pr0S22WWqsR05Sb6tBYu
         ZT8PUGykKCS5pmoNQPQN2xuQc0YMCzVN1kQbetNmfLF9YwDszYvDxZNpJU3hWrQK6Gzm
         tTDYX5rjrAfVv4kGNHSaofxk4UbXZYtkefBHKHxHJuIsOXa3aKGZS/BU5TCHfbbRmtXH
         BijkZg5zt1nvmkBUNPGrjQlkYUDPZLdPwBoq2u3JHazsNNuE/vd9DbB06zr8Wru1tL78
         Sw5Q==
X-Gm-Message-State: AOAM531Fkk2lYSU5KHw+dpBG9w41ZGb9TfDWc6OWtZUGPR7lSdLbInLb
        wqxxGU1Xd1P6wIqXG5m0z0aX7Q==
X-Google-Smtp-Source: ABdhPJwvNLAXuiwz//DhXAexU6iWu8RMaTontHrUC9haKp9k1m6EKR+Sd1sCAs0RfRTiq+r12YiG1w==
X-Received: by 2002:a5d:6905:0:b0:205:d510:c73a with SMTP id t5-20020a5d6905000000b00205d510c73amr2001129wru.275.1649151484085;
        Tue, 05 Apr 2022 02:38:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm4426805wra.96.2022.04.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:38:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 165501FFBA;
        Tue,  5 Apr 2022 10:38:00 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH  v2 2/4] char: rpmb: provide a user space interface
Date:   Tue,  5 Apr 2022 10:37:57 +0100
Message-Id: <20220405093759.1126835-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405093759.1126835-1-alex.bennee@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user space API is achieved via a number of synchronous IOCTLs.

  * RPMB_IOC_VER_CMD - simple versioning API
  * RPMB_IOC_CAP_CMD - query of underlying capabilities
  * RPMB_IOC_PKEY_CMD - one time programming of access key
  * RPMB_IOC_COUNTER_CMD - query the write counter
  * RPMB_IOC_WBLOCKS_CMD - write blocks to device
  * RPMB_IOC_RBLOCKS_CMD - read blocks from device

The operations which require authenticated frames or will respond with
MAC hashes of nonce filled frames that userspace will need to verify
share a common command frame format. The other operations can be
considered generic and allow for common handling.

[AJB: here the are key difference is the avoiding a single ioctl where
all the frame data is put together by user space. User space is still
the only place where certain operations can be verified due to the
need of a secret key]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus  Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Avri Altman <avri.altman@sandisk.com>

---
v2
  - drop the key api stuff
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/rpmb/Kconfig                          |   7 +
 drivers/rpmb/Makefile                         |   1 +
 drivers/rpmb/cdev.c                           | 309 ++++++++++++++++++
 drivers/rpmb/core.c                           |   7 +-
 drivers/rpmb/rpmb-cdev.h                      |  17 +
 include/linux/rpmb.h                          |  10 +
 include/uapi/linux/rpmb.h                     |  99 ++++++
 9 files changed, 451 insertions(+), 1 deletion(-)
 create mode 100644 drivers/rpmb/cdev.c
 create mode 100644 drivers/rpmb/rpmb-cdev.h
 create mode 100644 include/uapi/linux/rpmb.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e6fce2cbd99e..874d01f11caf 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -355,6 +355,7 @@ Code  Seq#    Include File                                           Comments
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
+0xB8  80-8F  uapi/linux/rpmb.h                                       <mailto:linux-mmc@vger.kernel.org>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ab02b589005..0a744da21817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16749,6 +16749,7 @@ M:	?
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/rpmb/*
+F:	include/uapi/linux/rpmb.h
 F:	include/linux/rpmb.h
 
 RPMSG TTY DRIVER
diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
index f2a9ebdc4435..126f336fe9ea 100644
--- a/drivers/rpmb/Kconfig
+++ b/drivers/rpmb/Kconfig
@@ -9,3 +9,10 @@ config RPMB
 	  access RPMB partition.
 
 	  If unsure, select N.
+
+config RPMB_INTF_DEV
+	bool "RPMB character device interface /dev/rpmbN"
+	depends on RPMB
+	help
+	  Say yes here if you want to access RPMB from user space
+	  via character device interface /dev/rpmb%d
diff --git a/drivers/rpmb/Makefile b/drivers/rpmb/Makefile
index 24d4752a9a53..f54b3f30514b 100644
--- a/drivers/rpmb/Makefile
+++ b/drivers/rpmb/Makefile
@@ -3,5 +3,6 @@
 
 obj-$(CONFIG_RPMB) += rpmb.o
 rpmb-objs += core.o
+rpmb-$(CONFIG_RPMB_INTF_DEV) += cdev.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/rpmb/cdev.c b/drivers/rpmb/cdev.c
new file mode 100644
index 000000000000..d9beeba53432
--- /dev/null
+++ b/drivers/rpmb/cdev.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/compat.h>
+#include <linux/slab.h>
+#include <linux/capability.h>
+
+#include <linux/rpmb.h>
+
+#include "rpmb-cdev.h"
+
+static dev_t rpmb_devt;
+#define RPMB_MAX_DEVS  MINORMASK
+
+#define RPMB_DEV_OPEN    0  /** single open bit (position) */
+
+/**
+ * rpmb_open - the open function
+ *
+ * @inode: pointer to inode structure
+ * @fp: pointer to file structure
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int rpmb_open(struct inode *inode, struct file *fp)
+{
+	struct rpmb_dev *rdev;
+
+	rdev = container_of(inode->i_cdev, struct rpmb_dev, cdev);
+	if (!rdev)
+		return -ENODEV;
+
+	/* the rpmb is single open! */
+	if (test_and_set_bit(RPMB_DEV_OPEN, &rdev->status))
+		return -EBUSY;
+
+	mutex_lock(&rdev->lock);
+
+	fp->private_data = rdev;
+
+	mutex_unlock(&rdev->lock);
+
+	return nonseekable_open(inode, fp);
+}
+
+/**
+ * rpmb_release - the cdev release function
+ *
+ * @inode: pointer to inode structure
+ * @fp: pointer to file structure
+ *
+ * Return: 0 always.
+ */
+static int rpmb_release(struct inode *inode, struct file *fp)
+{
+	struct rpmb_dev *rdev = fp->private_data;
+
+	clear_bit(RPMB_DEV_OPEN, &rdev->status);
+
+	return 0;
+}
+
+static long rpmb_ioctl_ver_cmd(struct rpmb_dev *rdev,
+			       struct rpmb_ioc_ver_cmd __user *ptr)
+{
+	struct rpmb_ioc_ver_cmd ver = {
+		.api_version = RPMB_API_VERSION,
+	};
+
+	return copy_to_user(ptr, &ver, sizeof(ver)) ? -EFAULT : 0;
+}
+
+static long rpmb_ioctl_cap_cmd(struct rpmb_dev *rdev,
+			       struct rpmb_ioc_cap_cmd __user *ptr)
+{
+	struct rpmb_ioc_cap_cmd cap;
+
+	cap.target      = rdev->target;
+	cap.block_size  = rdev->ops->block_size;
+	cap.wr_cnt_max  = rdev->ops->wr_cnt_max;
+	cap.rd_cnt_max  = rdev->ops->rd_cnt_max;
+	cap.capacity    = rpmb_get_capacity(rdev);
+	cap.reserved    = 0;
+
+	return copy_to_user(ptr, &cap, sizeof(cap)) ? -EFAULT : 0;
+}
+
+static long rpmb_ioctl_pkey_cmd(struct rpmb_dev *rdev, struct rpmb_ioc_reqresp_cmd __user *ptr)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	u8 *request, *resp = NULL;
+	long ret;
+
+	if (copy_from_user(&cmd, ptr, sizeof(struct rpmb_ioc_reqresp_cmd)))
+		return -EFAULT;
+
+	request = kmalloc(cmd.len, GFP_KERNEL);
+
+	if (!request)
+		return -ENOMEM;
+
+	if (cmd.rlen && cmd.response) {
+		resp = kmalloc(cmd.rlen, GFP_KERNEL);
+		if (!resp) {
+			kfree(request);
+			return -ENOMEM;
+		}
+	}
+
+	if (copy_from_user(request, cmd.request, cmd.len))
+		ret = -EFAULT;
+	else
+		ret = rpmb_program_key(rdev, cmd.len, request, cmd.rlen, resp);
+
+	if (!ret)
+		if (copy_to_user(cmd.response, resp, cmd.rlen))
+			ret = -EFAULT;
+
+	kfree(request);
+	kfree(resp);
+
+	return ret;
+}
+
+static long rpmb_ioctl_counter_cmd(struct rpmb_dev *rdev, struct rpmb_ioc_reqresp_cmd __user *ptr)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	u8 *request, *resp = NULL;
+	long count;
+
+	if (copy_from_user(&cmd, ptr, sizeof(struct rpmb_ioc_reqresp_cmd)))
+		return -EFAULT;
+
+	request = kmalloc(cmd.len, GFP_KERNEL);
+
+	if (!request)
+		return -ENOMEM;
+
+	if (cmd.rlen && cmd.response) {
+		resp = kmalloc(cmd.rlen, GFP_KERNEL);
+		if (!resp) {
+			kfree(request);
+			return -ENOMEM;
+		}
+	}
+
+	if (copy_from_user(request, cmd.request, cmd.len)) {
+		count = -EFAULT;
+	} else {
+		count = rpmb_get_write_count(rdev, cmd.len, request, cmd.rlen, resp);
+		if (resp)
+			if (copy_to_user(cmd.response, resp, cmd.rlen))
+				count = -EFAULT;
+	}
+
+	kfree(request);
+	kfree(resp);
+
+	return count;
+}
+
+static long rpmb_ioctl_wblocks_cmd(struct rpmb_dev *rdev,
+				   struct rpmb_ioc_reqresp_cmd __user *ptr)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	u8 *data, *resp = NULL;
+
+	long ret;
+
+	if (copy_from_user(&cmd, ptr, sizeof(struct rpmb_ioc_reqresp_cmd)))
+		return -EFAULT;
+
+	data = kmalloc(cmd.len, GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	if (cmd.rlen && cmd.response) {
+		resp = kmalloc(cmd.rlen, GFP_KERNEL);
+		if (!resp) {
+			kfree(data);
+			return -ENOMEM;
+		}
+	}
+
+	if (copy_from_user(data, cmd.request, cmd.len))
+		ret = -EFAULT;
+	else
+		ret = rpmb_write_blocks(rdev, cmd.len, data, cmd.rlen, resp);
+
+	if (resp)
+		if (copy_to_user(cmd.response, resp, cmd.rlen))
+			ret = -EFAULT;
+
+	kfree(data);
+	kfree(resp);
+
+	return ret;
+}
+
+static long rpmb_ioctl_rblocks_cmd(struct rpmb_dev *rdev,
+				   struct rpmb_ioc_rblocks_cmd __user *ptr)
+{
+	struct rpmb_ioc_rblocks_cmd rblocks;
+	long ret;
+	u8 *data;
+
+	if (copy_from_user(&rblocks, ptr, sizeof(struct rpmb_ioc_rblocks_cmd)))
+		return -EFAULT;
+
+	if (rblocks.count > rdev->ops->rd_cnt_max)
+		return -EINVAL;
+
+	if (!rblocks.len || !rblocks.data)
+		return -EINVAL;
+
+	data = kmalloc(rblocks.len, GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	ret = rpmb_read_blocks(rdev, rblocks.addr, rblocks.count, rblocks.len, data);
+
+	if (ret == 0)
+		ret = copy_to_user(rblocks.data, data, rblocks.len);
+
+	kfree(data);
+	return ret;
+}
+
+/**
+ * rpmb_ioctl - rpmb ioctl dispatcher
+ *
+ * @fp: a file pointer
+ * @cmd: ioctl command RPMB_IOC_SEQ_CMD RPMB_IOC_VER_CMD RPMB_IOC_CAP_CMD
+ * @arg: ioctl data: rpmb_ioc_ver_cmd rpmb_ioc_cap_cmd pmb_ioc_seq_cmd
+ *
+ * Return: 0 on success; < 0 on error
+ */
+static long rpmb_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct rpmb_dev *rdev = fp->private_data;
+	void __user *ptr = (void __user *)arg;
+
+	switch (cmd) {
+	case RPMB_IOC_VER_CMD:
+		return rpmb_ioctl_ver_cmd(rdev, ptr);
+	case RPMB_IOC_CAP_CMD:
+		return rpmb_ioctl_cap_cmd(rdev, ptr);
+	case RPMB_IOC_PKEY_CMD:
+		return rpmb_ioctl_pkey_cmd(rdev, ptr);
+	case RPMB_IOC_COUNTER_CMD:
+		return rpmb_ioctl_counter_cmd(rdev, ptr);
+	case RPMB_IOC_WBLOCKS_CMD:
+		return rpmb_ioctl_wblocks_cmd(rdev, ptr);
+	case RPMB_IOC_RBLOCKS_CMD:
+		return rpmb_ioctl_rblocks_cmd(rdev, ptr);
+	default:
+		dev_err(&rdev->dev, "unsupported ioctl 0x%x.\n", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations rpmb_fops = {
+	.open           = rpmb_open,
+	.release        = rpmb_release,
+	.unlocked_ioctl = rpmb_ioctl,
+	.owner          = THIS_MODULE,
+	.llseek         = noop_llseek,
+};
+
+void rpmb_cdev_prepare(struct rpmb_dev *rdev)
+{
+	rdev->dev.devt = MKDEV(MAJOR(rpmb_devt), rdev->id);
+	rdev->cdev.owner = THIS_MODULE;
+	cdev_init(&rdev->cdev, &rpmb_fops);
+}
+
+void rpmb_cdev_add(struct rpmb_dev *rdev)
+{
+	cdev_add(&rdev->cdev, rdev->dev.devt, 1);
+}
+
+void rpmb_cdev_del(struct rpmb_dev *rdev)
+{
+	if (rdev->dev.devt)
+		cdev_del(&rdev->cdev);
+}
+
+int __init rpmb_cdev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&rpmb_devt, 0, RPMB_MAX_DEVS, "rpmb");
+	if (ret < 0)
+		pr_err("unable to allocate char dev region\n");
+
+	return ret;
+}
+
+void __exit rpmb_cdev_exit(void)
+{
+	unregister_chrdev_region(rpmb_devt, RPMB_MAX_DEVS);
+}
diff --git a/drivers/rpmb/core.c b/drivers/rpmb/core.c
index 50b358a14db6..969536ba53cc 100644
--- a/drivers/rpmb/core.c
+++ b/drivers/rpmb/core.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 
 #include <linux/rpmb.h>
+#include "rpmb-cdev.h"
 
 static DEFINE_IDA(rpmb_ida);
 
@@ -282,6 +283,7 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 		return -EINVAL;
 
 	mutex_lock(&rdev->lock);
+	rpmb_cdev_del(rdev);
 	device_del(&rdev->dev);
 	mutex_unlock(&rdev->lock);
 
@@ -401,6 +403,8 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
 	if (ret)
 		goto exit;
 
+	rpmb_cdev_add(rdev);
+
 	dev_dbg(&rdev->dev, "registered device\n");
 
 	return rdev;
@@ -417,11 +421,12 @@ static int __init rpmb_init(void)
 {
 	ida_init(&rpmb_ida);
 	class_register(&rpmb_class);
-	return 0;
+	return rpmb_cdev_init();
 }
 
 static void __exit rpmb_exit(void)
 {
+	rpmb_cdev_exit();
 	class_unregister(&rpmb_class);
 	ida_destroy(&rpmb_ida);
 }
diff --git a/drivers/rpmb/rpmb-cdev.h b/drivers/rpmb/rpmb-cdev.h
new file mode 100644
index 000000000000..e59ff0c05e9d
--- /dev/null
+++ b/drivers/rpmb/rpmb-cdev.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2018 Intel Corp. All rights reserved
+ */
+#ifdef CONFIG_RPMB_INTF_DEV
+int __init rpmb_cdev_init(void);
+void __exit rpmb_cdev_exit(void);
+void rpmb_cdev_prepare(struct rpmb_dev *rdev);
+void rpmb_cdev_add(struct rpmb_dev *rdev);
+void rpmb_cdev_del(struct rpmb_dev *rdev);
+#else
+static inline int __init rpmb_cdev_init(void) { return 0; }
+static inline void __exit rpmb_cdev_exit(void) {}
+static inline void rpmb_cdev_prepare(struct rpmb_dev *rdev) {}
+static inline void rpmb_cdev_add(struct rpmb_dev *rdev) {}
+static inline void rpmb_cdev_del(struct rpmb_dev *rdev) {}
+#endif /* CONFIG_RPMB_INTF_DEV */
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index 4ed5e299623e..3b0731c07528 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -8,8 +8,12 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/cdev.h>
+#include <uapi/linux/rpmb.h>
 #include <linux/kref.h>
 
+#define RPMB_API_VERSION 0x80000001
+
 /**
  * struct rpmb_ops - RPMB ops to be implemented by underlying block device
  *
@@ -54,6 +58,8 @@ struct rpmb_ops {
  * @dev        : device
  * @id         : device id
  * @target     : RPMB target/region within the physical device
+ * @cdev       : character dev
+ * @status     : device status
  * @ops        : operation exported by rpmb
  */
 struct rpmb_dev {
@@ -61,6 +67,10 @@ struct rpmb_dev {
 	struct device dev;
 	int id;
 	u8 target;
+#ifdef CONFIG_RPMB_INTF_DEV
+	struct cdev cdev;
+	unsigned long status;
+#endif /* CONFIG_RPMB_INTF_DEV */
 	const struct rpmb_ops *ops;
 };
 
diff --git a/include/uapi/linux/rpmb.h b/include/uapi/linux/rpmb.h
new file mode 100644
index 000000000000..2f4ee7279b1b
--- /dev/null
+++ b/include/uapi/linux/rpmb.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2015-2018 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef _UAPI_LINUX_RPMB_H_
+#define _UAPI_LINUX_RPMB_H_
+
+#include <linux/types.h>
+
+/**
+ * struct rpmb_ioc_ver_cmd - rpmb api version
+ *
+ * @api_version: rpmb API version.
+ */
+struct rpmb_ioc_ver_cmd {
+	__u32 api_version;
+} __packed;
+
+enum rpmb_auth_method {
+	RPMB_HMAC_ALGO_SHA_256 = 0,
+};
+
+/**
+ * struct rpmb_ioc_cap_cmd - rpmb capabilities
+ *
+ * @target: rpmb target/region within RPMB partition.
+ * @capacity: storage capacity (in units of 128K)
+ * @block_size: storage data block size (in units of 256B)
+ * @wr_cnt_max: maximal number of block that can be written in a single request.
+ * @rd_cnt_max: maximal number of block that can be read in a single request.
+ * @auth_method: authentication method: currently always HMAC_SHA_256
+ * @reserved: reserved to align to 4 bytes.
+ */
+struct rpmb_ioc_cap_cmd {
+	__u16 target;
+	__u16 capacity;
+	__u16 block_size;
+	__u16 wr_cnt_max;
+	__u16 rd_cnt_max;
+	__u16 auth_method;
+	__u16 reserved;
+} __packed;
+
+/**
+ * struct rpmb_ioc_reqresp_cmd - general purpose reqresp
+ *
+ * Most RPMB operations consist of a set of request frames and an
+ * optional response frame. If a response is requested the user must
+ * allocate enough space for the response, otherwise the fields should
+ * be set to 0/NULL.
+ *
+ * It is used for programming the key, reading the counter and writing
+ * blocks to the device. If the frames are malformed they may be
+ * rejected by the underlying driver or the device itself.
+ *
+ * Assuming the transaction succeeds it is still up to user space to
+ * validate the response and check MAC values correspond to the
+ * programmed keys.
+ *
+ * @len: length of write counter request
+ * @request: ptr to device specific request frame
+ * @rlen: length of response frame
+ * @resp: ptr to device specific response frame
+ */
+struct rpmb_ioc_reqresp_cmd {
+	__u32 len;
+	__u8 __user *request;
+	__u32 rlen;
+	__u8 __user *response;
+} __packed;
+
+/**
+ * struct rpmb_ioc_rblocks_cmd - read blocks from RPMB
+ *
+ * @addr: index into device (units of 256B blocks)
+ * @count: number of 256B blocks
+ * @len: length of response frame
+ * @data: block data (in device specific framing)
+ *
+ * Reading blocks from an RPMB device doesn't require any specific
+ * authentication. However the result still needs to be validated by
+ * user space.
+ */
+struct rpmb_ioc_rblocks_cmd {
+	__u32 addr;
+	__u32 count;
+	__u32 len;
+	__u8 __user *data;
+} __packed;
+
+#define RPMB_IOC_VER_CMD     _IOR(0xB8, 80, struct rpmb_ioc_ver_cmd)
+#define RPMB_IOC_CAP_CMD     _IOR(0xB8, 81, struct rpmb_ioc_cap_cmd)
+#define RPMB_IOC_PKEY_CMD    _IOWR(0xB8, 82, struct rpmb_ioc_reqresp_cmd)
+#define RPMB_IOC_COUNTER_CMD _IOWR(0xB8, 84, struct rpmb_ioc_reqresp_cmd)
+#define RPMB_IOC_WBLOCKS_CMD _IOWR(0xB8, 85, struct rpmb_ioc_reqresp_cmd)
+#define RPMB_IOC_RBLOCKS_CMD _IOR(0xB8, 86, struct rpmb_ioc_rblocks_cmd)
+
+#endif /* _UAPI_LINUX_RPMB_H_ */
-- 
2.30.2

