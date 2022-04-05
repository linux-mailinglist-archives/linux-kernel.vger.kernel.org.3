Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A904F4970
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383540AbiDEWQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbiDEJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA4A2069
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:38:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so18429569wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kxJqP7a1M2gpL6SMSPDw94NffEPUOvYaV+FubVSaZo=;
        b=wRmNlkC5m4iGc78HN11BCavIkWRbMMK1+Bo1yXjgsRM4gS/6LOiQbvEWwODolabhrb
         K4aC/mXYUssgxN07Op2s83ZJUItpexJBaX513jgSby+nmn990bj6rSPhbS3wahYS1Wbg
         BuMTBifAJbROYT9PcfHYDR4dT6KzfuJkDSVIe4lugEp4iDf/f8mNUysNj5OQmKQZvnCa
         i8cUmDjmPSa1u5KjKo0wzMZ9GOIOxocs5WLG/HH0YADIS1xs0fXHg7bTJCJGQ7tas71k
         IbhhGMroJpZh9JjHl0hYwyI0TIDbCiLC8zUU+V35N4qBs3p5xolKL7tuG0DgJ5k9iy8A
         Py1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kxJqP7a1M2gpL6SMSPDw94NffEPUOvYaV+FubVSaZo=;
        b=6o0CU4/iY0wUcwDvVwHcYk9bKYnrI7Z54iU0nXzPVLyDdIJVCir/hkH5r+e1PjGWQX
         Z5FPQE7XolAPEH1iAjUiuOcuLJhLE/olpPd6/DSJz2u5AFpovXWr4Vmc8Wb1vud5luwg
         +c93Volo3W0EHNhQDgHtO0t4SOL3kb+cTIlDVDZcRXosPQ1aQyN+XcbTitPNl6+Y7jKj
         Nmflw2ApNov8Y+NuUflPySGnpIoS4j05eo85k/CDNl9RZdZ6/tMIJr7T1NG1V3u3JdOW
         C9e6Fm+YD6l3LlqRCZlQr1ZDeym+jEfYqdn37SunSeVwi8rroSQeOQmMLAyoWYX1FmYq
         F3/Q==
X-Gm-Message-State: AOAM530K6fJaAYK2PRelGn6ZpWx3jxyh+UHgvkN13SIvwz1aTMuUzQsB
        xJNU6FFZpLaEGYsWfotKRyWvVg==
X-Google-Smtp-Source: ABdhPJziSgg2ISzYD+NQwV22bFIPYzBUI9GfT/TLjFTC+cQ2qIT1LU0iej+X30xqxW1XrxfY6ap9EA==
X-Received: by 2002:a5d:4712:0:b0:206:120d:b038 with SMTP id y18-20020a5d4712000000b00206120db038mr2052231wrq.542.1649151483317;
        Tue, 05 Apr 2022 02:38:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm11346872wrw.91.2022.04.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:38:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 0E3441FFB8;
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
        Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: [PATCH  v2 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date:   Tue,  5 Apr 2022 10:37:56 +0100
Message-Id: <20220405093759.1126835-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405093759.1126835-1-alex.bennee@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
partition provides authenticated and replay protected access, hence
suitable as a secure storage.

The RPMB layer aims to provide in-kernel API for Trusted Execution
Environment (TEE) devices that are capable to securely compute block
frame signature. In case a TEE device wishes to store a replay
protected data, requests the storage device via RPMB layer to store
the data.

A TEE device driver can claim the RPMB interface, for example, via
class_interface_register(). The RPMB layer provides a series of
operations for interacting with the device.

  * program_key - a one time operation for setting up a new device
  * get_capacity - introspect the device capacity
  * get_write_count - check the write counter
  * write_blocks - write a series of blocks to the RPMB device
  * read_blocks - read a series of blocks from the RPMB device

The detailed operation of implementing the access is left to the TEE
device driver itself.

[This is based-on Thomas Winkler's proposed API from:

  https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/

The principle difference is the framing details and HW specific
bits (JDEC vs NVME frames) are left to the lower level TEE driver to
worry about. The eventual userspace ioctl interface will aim to be
similarly generic. This is an RFC to follow up on:

  Subject: RPMB user space ABI
  Date: Thu, 11 Feb 2021 14:07:00 +0000
  Message-ID: <87mtwashi4.fsf@linaro.org>]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus  Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---
v2
  - dropped keyid stuff
  - moved from char to its own subdirectory driver/rpmb
  - fixed compile errors for bisectability
---
 MAINTAINERS           |   7 +
 drivers/Kconfig       |   2 +
 drivers/Makefile      |   1 +
 drivers/rpmb/Kconfig  |  11 ++
 drivers/rpmb/Makefile |   7 +
 drivers/rpmb/core.c   | 434 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h  | 172 +++++++++++++++++
 7 files changed, 634 insertions(+)
 create mode 100644 drivers/rpmb/Kconfig
 create mode 100644 drivers/rpmb/Makefile
 create mode 100644 drivers/rpmb/core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a34a..9ab02b589005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16744,6 +16744,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
 
+RPMB SUBSYSTEM
+M:	?
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/rpmb/*
+F:	include/linux/rpmb.h
+
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-remoteproc@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0d399ddaa185..90d18a8a0e72 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -236,4 +236,6 @@ source "drivers/interconnect/Kconfig"
 source "drivers/counter/Kconfig"
 
 source "drivers/most/Kconfig"
+
+source "drivers/rpmb/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index a110338c860c..ade465c4589f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -187,3 +187,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
+obj-$(CONFIG_RPMB)		+= rpmb/
diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
new file mode 100644
index 000000000000..f2a9ebdc4435
--- /dev/null
+++ b/drivers/rpmb/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015-2019, Intel Corporation.
+
+config RPMB
+	tristate "RPMB partition interface"
+	help
+	  Unified RPMB partition interface for RPMB capable devices such as
+          eMMC and UFS. Provides interface for in kernel security controllers to
+	  access RPMB partition.
+
+	  If unsure, select N.
diff --git a/drivers/rpmb/Makefile b/drivers/rpmb/Makefile
new file mode 100644
index 000000000000..24d4752a9a53
--- /dev/null
+++ b/drivers/rpmb/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015-2019, Intel Corporation.
+
+obj-$(CONFIG_RPMB) += rpmb.o
+rpmb-objs += core.o
+
+ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/rpmb/core.c b/drivers/rpmb/core.c
new file mode 100644
index 000000000000..50b358a14db6
--- /dev/null
+++ b/drivers/rpmb/core.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
+ * Copyright(c) 2021 - 2022 Linaro Ltd.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include <linux/rpmb.h>
+
+static DEFINE_IDA(rpmb_ida);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return get_device(&rdev->dev) ? rdev : NULL;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get);
+
+/**
+ * rpmb_dev_put() - decrease rpmb device ref counter
+ * @rdev: rpmb device
+ */
+void rpmb_dev_put(struct rpmb_dev *rdev)
+{
+	put_device(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_put);
+
+/**
+ * rpmb_program_key() - program the RPMB access key
+ * @rdev: rpmb device
+ * @keylen: length of key data
+ * @key: key data
+ *
+ * A successful programming of the key implies it has been set by the
+ * driver and can be used.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EPERM key already programmed
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_program_key(struct rpmb_dev *rdev, int klen, u8 *key, int rlen, u8 *resp)
+{
+	int err;
+
+	if (!rdev || !key)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->program_key) {
+		err = rdev->ops->program_key(rdev->dev.parent, rdev->target,
+					     klen, key, rlen, resp);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_program_key);
+
+/**
+ * rpmb_get_capacity() - returns the capacity of the rpmb device
+ * @rdev: rpmb device
+ *
+ * Return:
+ * *        capacity of the device in units of 128K, on success
+ * *        -EINVAL on wrong parameters
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_get_capacity(struct rpmb_dev *rdev)
+{
+	int err;
+
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->get_capacity)
+		err = rdev->ops->get_capacity(rdev->dev.parent, rdev->target);
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_get_capacity);
+
+/**
+ * rpmb_get_write_count() - returns the write counter of the rpmb device
+ * @rdev: rpmb device
+ * @len: size of request frame
+ * @request: request frame
+ * @rlen: size of response frame
+ * @resp: response frame
+ *
+ * Return:
+ * *        counter
+ * *        -EINVAL on wrong parameters
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_get_write_count(struct rpmb_dev *rdev, int len, u8 *request, int rlen, u8 *resp)
+{
+	int err;
+
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->get_write_count)
+		err = rdev->ops->get_write_count(rdev->dev.parent, rdev->target,
+						 len, request, rlen, resp);
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_get_write_count);
+
+/**
+ * rpmb_write_blocks() - write data to RPMB device
+ * @rdev: rpmb device
+ * @addr: block address (index of first block - 256B blocks)
+ * @count: number of 256B blosks
+ * @data: pointer to data to program
+ *
+ * Write a series of blocks to the RPMB device.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EACCESS no key set
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_write_blocks(struct rpmb_dev *rdev, int len, u8 *request,
+		      int rlen, u8 *response)
+{
+	int err;
+
+	if (!rdev || !len || !request)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->write_blocks) {
+		err = rdev->ops->write_blocks(rdev->dev.parent, rdev->target,
+					      len, request, rlen, response);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_write_blocks);
+
+/**
+ * rpmb_read_blocks() - read data from RPMB device
+ * @rdev: rpmb device
+ * @addr: block address (index of first block - 256B blocks)
+ * @count: number of 256B blocks
+ * @data: pointer to data to read
+ *
+ * Read a series of one or more blocks from the RPMB device.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EACCESS no key set
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count, int len, u8 *data)
+{
+	int err;
+
+	if (!rdev || !count || !data)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->read_blocks) {
+		err = rdev->ops->read_blocks(rdev->dev.parent, rdev->target,
+					     addr, count, len, data);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_read_blocks);
+
+
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	kfree(rdev);
+}
+
+struct class rpmb_class = {
+	.name = "rpmb",
+	.owner = THIS_MODULE,
+	.dev_release = rpmb_dev_release,
+};
+EXPORT_SYMBOL(rpmb_class);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * Return: matching rpmb device or NULL on failure
+ */
+static
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      int (*match)(struct device *dev,
+						   const void *data))
+{
+	struct device *dev;
+
+	dev = class_find_device(&rpmb_class, NULL, data, match);
+
+	return dev ? to_rpmb_dev(dev) : NULL;
+}
+
+struct device_with_target {
+	const struct device *dev;
+	u8 target;
+};
+
+static int match_by_parent(struct device *dev, const void *data)
+{
+	const struct device_with_target *d = data;
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	return (d->dev && dev->parent == d->dev && rdev->target == d->target);
+}
+
+/**
+ * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
+ * @parent: parent device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ *
+ * Return: NULL if there is no rpmb device associated with the parent device
+ */
+struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target)
+{
+	struct device_with_target t;
+
+	if (!parent)
+		return NULL;
+
+	t.dev = parent;
+	t.target = target;
+
+	return rpmb_dev_find_device(&t, match_by_parent);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_find_by_device);
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	device_del(&rdev->dev);
+	mutex_unlock(&rdev->lock);
+
+	rpmb_dev_put(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_unregister_by_device() - unregister RPMB partition
+ *     from the RPMB subsystem
+ * @dev: the parent device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -ENODEV if a device cannot be find.
+ */
+int rpmb_dev_unregister_by_device(struct device *dev, u8 target)
+{
+	struct rpmb_dev *rdev;
+
+	if (!dev)
+		return -EINVAL;
+
+	rdev = rpmb_dev_find_by_device(dev, target);
+	if (!rdev) {
+		dev_warn(dev, "no disk found %s\n", dev_name(dev->parent));
+		return -ENODEV;
+	}
+
+	rpmb_dev_put(rdev);
+
+	return rpmb_dev_unregister(rdev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister_by_device);
+
+/**
+ * rpmb_dev_get_drvdata() - driver data getter
+ * @rdev: rpmb device
+ *
+ * Return: driver private data
+ */
+void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev)
+{
+	return dev_get_drvdata(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get_drvdata);
+
+/**
+ * rpmb_dev_set_drvdata() - driver data setter
+ * @rdev: rpmb device
+ * @data: data to store
+ */
+void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data)
+{
+	dev_set_drvdata(&rdev->dev, data);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_set_drvdata);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * @ops: device specific operations
+ *
+ * Return: a pointer to rpmb device
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
+				   const struct rpmb_ops *ops)
+{
+	struct rpmb_dev *rdev;
+	int id;
+	int ret;
+
+	if (!dev || !ops)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->program_key)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->get_capacity)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->get_write_count)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->write_blocks)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->read_blocks)
+		return ERR_PTR(-EINVAL);
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto exit;
+	}
+
+	mutex_init(&rdev->lock);
+	rdev->ops = ops;
+	rdev->id = id;
+	rdev->target = target;
+
+	dev_set_name(&rdev->dev, "rpmb%d", id);
+	rdev->dev.class = &rpmb_class;
+	rdev->dev.parent = dev;
+
+	rpmb_cdev_prepare(rdev);
+
+	ret = device_register(&rdev->dev);
+	if (ret)
+		goto exit;
+
+	dev_dbg(&rdev->dev, "registered device\n");
+
+	return rdev;
+
+exit:
+	if (id >= 0)
+		ida_simple_remove(&rpmb_ida, id);
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+static int __init rpmb_init(void)
+{
+	ida_init(&rpmb_ida);
+	class_register(&rpmb_class);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	class_unregister(&rpmb_class);
+	ida_destroy(&rpmb_ida);
+}
+
+subsys_initcall(rpmb_init);
+module_exit(rpmb_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("RPMB class");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
new file mode 100644
index 000000000000..4ed5e299623e
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/kref.h>
+
+/**
+ * struct rpmb_ops - RPMB ops to be implemented by underlying block device
+ *
+ * @program_key    : program device key (once only op).
+ * @get_capacity   : rpmb size in 128K units in for region/target.
+ * @get_write_count: return the device write counter
+ * @write_blocks   : write blocks to RPMB device
+ * @read_blocks    : read blocks from RPMB device
+ * @block_size     : block size in half sectors (1 == 256B)
+ * @wr_cnt_max     : maximal number of blocks that can be
+ *                   written in one access.
+ * @rd_cnt_max     : maximal number of blocks that can be
+ *                   read in one access.
+ * @dev_id         : unique device identifier
+ * @dev_id_len     : unique device identifier length
+ */
+struct rpmb_ops {
+	int (*program_key)(struct device *dev, u8 target,
+			   int keylen, u8 *key_frame,
+			   int rlen, u8 *resp);
+	int (*get_capacity)(struct device *dev, u8 target);
+	int (*get_write_count)(struct device *dev, u8 target,
+			       int len, u8 *requests,
+			       int rlen, u8 *resp);
+	int (*write_blocks)(struct device *dev, u8 target,
+			    int len, u8 *requests,
+			    int rlen, u8 *resp);
+	int (*read_blocks)(struct device *dev, u8 target,
+			   int addr, int count,
+			   int len, u8 *data);
+	u16 block_size;
+	u16 wr_cnt_max;
+	u16 rd_cnt_max;
+	const u8 *dev_id;
+	size_t dev_id_len;
+};
+
+/**
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @lock       : the device lock
+ * @dev        : device
+ * @id         : device id
+ * @target     : RPMB target/region within the physical device
+ * @ops        : operation exported by rpmb
+ */
+struct rpmb_dev {
+	struct mutex lock; /* device serialization lock */
+	struct device dev;
+	int id;
+	u8 target;
+	const struct rpmb_ops *ops;
+};
+
+#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target);
+struct rpmb_dev *rpmb_dev_get_by_type(u32 type);
+struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
+				   const struct rpmb_ops *ops);
+void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev);
+void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+int rpmb_dev_unregister_by_device(struct device *dev, u8 target);
+
+int rpmb_program_key(struct rpmb_dev *rdev,
+		     int klen, u8 *key, int rlen, u8 *resp);
+int rpmb_get_capacity(struct rpmb_dev *rdev);
+int rpmb_get_write_count(struct rpmb_dev *rdev,
+			 int len, u8 *request, int rlen, u8 *resp);
+int rpmb_write_blocks(struct rpmb_dev *rdev,
+		      int len, u8 *request, int rlen, u8 *resp);
+int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count, int len, u8 *data);
+
+#else
+static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
+
+static inline struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent,
+						       u8 target)
+{
+	return NULL;
+}
+
+static inline
+struct rpmb_dev *rpmb_dev_get_by_type(enum rpmb_type type)
+{
+	return NULL;
+}
+
+static inline void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data)
+{
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, u8 target, const struct rpmb_ops *ops)
+{
+	return NULL;
+}
+
+static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
+{
+	return 0;
+}
+
+static inline int rpmb_dev_unregister_by_device(struct device *dev, u8 target)
+{
+	return 0;
+}
+
+static inline int rpmb_program_key(struct rpmb_dev *rdev,
+				   int klen, u8 *key,
+				   int rlen, u8 *resp)
+{
+	return 0;
+}
+
+static inline rpmb_set_key(struct rpmb_dev *rdev, u8 *key, int keylen);
+{
+	return 0;
+}
+
+static inline int rpmb_get_capacity(struct rpmb_dev *rdev)
+{
+	return 0;
+}
+
+static inline int rpmb_get_write_count(struct rpmb_dev *rdev,
+				       int len, u8 *request, int rlen, u8 *resp)
+{
+	return 0;
+}
+
+static inline int rpmb_write_blocks(struct rpmb_dev *rdev,
+				    int len, u8 *request, int rlen, u8 *resp);
+{
+	return 0;
+}
+
+static inline int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count,
+				   int len, u8 *data)
+{
+	return 0;
+}
+
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
-- 
2.30.2

