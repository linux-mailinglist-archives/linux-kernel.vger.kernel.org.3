Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151184F4ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835170AbiDFAWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348956AbiDEJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C14A5E99
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:38:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so18361350wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XIz5OfvKltqZSeXren24cN8/vWoQ7uO5RENAi6vLig=;
        b=UrUfEXIlvxSp8sIeO6xh/kGe1WpSq4OqI/LhLEgsXMMfzgl7OpApM9zMvJvcWAe7sp
         C1NkO5Z54qjRtT/gZ0XEOf2fVGk0aY/gFKs0y0BkRSO9RQDYk1SoBvSR1M11Kph0SKyW
         kwYz/F8IvDRqTIEx00WxT93T7B6U5KTDejqbmM1mwqf6upU9lzQsnXTdRNUF0jpXzL4w
         fAMflltmSitvXC1olNJQuRNSY8rOcDxVgYPk1879U/D6meXkohynmsgz2Wifn7ALuygs
         Y9xRoD/7cV9jGnmLZ8E/5S296sec2HmVZi7H92tJXDz8EHGl/KHP3F5RjnW/89ewCzRF
         ihsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XIz5OfvKltqZSeXren24cN8/vWoQ7uO5RENAi6vLig=;
        b=URTpCVMgcgA7ACUHsabAeCJx9N/P6R0zWuThtg07dsvq/PS8G/Zbn/olEGxLhTJ8hn
         gaV4q8zWeb18Ho2fXXNashb7jGCclgclymxSozJikmDs5+DAXxZTBe7dAGDoxfWmVf4H
         BYmBVOSrNq+CiveTdMla41HYGAEsWlbYHw/qWbPkpuVa6gXWmb+xKZU+JDJ4XC6BfB/5
         7t9xtUrutWFOurM8tO5kI61TPm64EWkqr4HdXJ0URDA0J1JoF2/9U79nH3r65yG380pa
         lYlANbugdPaqPOEdlA9kw974wNuQUFKHqmJ3t8gzcgq1OKSMr3eTzXm1LNJkZNk77DaD
         1coA==
X-Gm-Message-State: AOAM531Ej5Od2J8fCEOdY/aJJwlq8VFi9i872CxwZuh6qCbBLHXiKUY4
        EdIIKppkOoW7nEmcOp4sq/83uw==
X-Google-Smtp-Source: ABdhPJyuOUieYVJh0pNqAbyEnkD6s6YTyfa0TavUfZNB+FdJRmfUgtO0dixX7I+3Wr7D2BXaYe9gtA==
X-Received: by 2002:a5d:6782:0:b0:203:d6af:5869 with SMTP id v2-20020a5d6782000000b00203d6af5869mr1973756wru.213.1649151485956;
        Tue, 05 Apr 2022 02:38:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002057eac999fsm11955806wrx.76.2022.04.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:38:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 238991FFBB;
        Tue,  5 Apr 2022 10:38:00 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH  v2 3/4] rpmb: create virtio rpmb frontend driver
Date:   Tue,  5 Apr 2022 10:37:58 +0100
Message-Id: <20220405093759.1126835-4-alex.bennee@linaro.org>
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

This implements a virtio rpmb frontend driver for the RPMB subsystem.
This driver conforms to the rpmb internal API which attempts to stay
common for the majority of cases and only expose the low level frame
details as required. In these cases it is up to something outside of
the driver itself to do the appropriate MAC calculations.

The driver does do some basic verification of the incoming data and
will reject frames which are the wrong size or have the wrong commands
in them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>

---
ajb:
  - rewrite for new API
---
 drivers/rpmb/Kconfig             |  10 +
 drivers/rpmb/Makefile            |   1 +
 drivers/rpmb/virtio_rpmb.c       | 518 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_rpmb.h |  54 ++++
 4 files changed, 583 insertions(+)
 create mode 100644 drivers/rpmb/virtio_rpmb.c
 create mode 100644 include/uapi/linux/virtio_rpmb.h

diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
index 126f336fe9ea..cd0d1bb10910 100644
--- a/drivers/rpmb/Kconfig
+++ b/drivers/rpmb/Kconfig
@@ -16,3 +16,13 @@ config RPMB_INTF_DEV
 	help
 	  Say yes here if you want to access RPMB from user space
 	  via character device interface /dev/rpmb%d
+
+config VIRTIO_RPMB
+	tristate "Virtio RPMB driver"
+	default n
+	depends on VIRTIO
+	select RPMB
+	help
+	  Say yes here if you have a Virtio aware RPMB device or want to use
+          RPMB from a Virtual Machine images.
+	  This device interface is only for guest/frontend virtio driver.
diff --git a/drivers/rpmb/Makefile b/drivers/rpmb/Makefile
index f54b3f30514b..4b397b50a42c 100644
--- a/drivers/rpmb/Makefile
+++ b/drivers/rpmb/Makefile
@@ -4,5 +4,6 @@
 obj-$(CONFIG_RPMB) += rpmb.o
 rpmb-objs += core.o
 rpmb-$(CONFIG_RPMB_INTF_DEV) += cdev.o
+obj-$(CONFIG_VIRTIO_RPMB) += virtio_rpmb.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/rpmb/virtio_rpmb.c b/drivers/rpmb/virtio_rpmb.c
new file mode 100644
index 000000000000..db309014a157
--- /dev/null
+++ b/drivers/rpmb/virtio_rpmb.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio RPMB Front End Driver
+ *
+ * Copyright (c) 2018-2019 Intel Corporation.
+ * Copyright (c) 2021-2022 Linaro Ltd.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/err.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/module.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_rpmb.h>
+#include <linux/uaccess.h>
+#include <linux/byteorder/generic.h>
+#include <linux/rpmb.h>
+
+#define RPMB_MAC_SIZE 32
+#define VIRTIO_RPMB_FRAME_SZ 512
+
+static const char id[] = "RPMB:VIRTIO";
+
+struct virtio_rpmb_info {
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+
+	/* The virtq we use */
+	struct virtqueue *vq;
+
+	struct mutex lock; /* info lock */
+	wait_queue_head_t have_data;
+
+	/* Underlying RPMB device */
+	struct rpmb_dev *rdev;
+
+	/* Config values */
+	u8 max_wr, max_rd, capacity;
+};
+
+/**
+ * virtio_rpmb_recv_done() - vq completion callback
+ */
+static void virtio_rpmb_recv_done(struct virtqueue *vq)
+{
+	struct virtio_rpmb_info *vi;
+	struct virtio_device *vdev = vq->vdev;
+
+	vi = vq->vdev->priv;
+	if (!vi) {
+		dev_err(&vdev->dev, "Error: no found vi data.\n");
+		return;
+	}
+
+	wake_up(&vi->have_data);
+}
+
+/**
+ * do_virtio_transaction() - send sg list and wait for result
+ * @dev: linux device structure
+ * @vi: the device info (where the lock is)
+ * @sgs: array of scatterlists
+ * @out: total outgoing scatter lists
+ * @in: total returning scatter lists
+ *
+ * This is just a simple helper for processing the sg list. It will
+ * block until the response arrives. Returns number of bytes written
+ * back or negative if it failed.
+ */
+static int do_virtio_transaction(struct device *dev,
+				 struct virtio_rpmb_info *vi,
+				 struct scatterlist *sgs[],
+				 int out, int in)
+{
+	int ret, len = 0;
+
+	mutex_lock(&vi->lock);
+	ret = virtqueue_add_sgs(vi->vq, sgs, out, in, vi, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to send %d, recv %d sgs (%d) to vq\n",
+			out, in, ret);
+		ret = -1;
+	} else {
+		virtqueue_kick(vi->vq);
+		wait_event(vi->have_data, virtqueue_get_buf(vi->vq, &len));
+	}
+	mutex_unlock(&vi->lock);
+
+	return len;
+}
+
+/**
+ * rpmb_virtio_program_key(): program key into virtio device
+ * @dev: device handle
+ * @target: target region (unused for VirtIO devices)
+ * @klen: length of key programming request
+ * @key_frame: key programming frames
+ * @rlen: length of response buffer
+ * @resp_frame: pointer to optional response frame
+ *
+ * Handle programming of the key (VIRTIO_RPMB_REQ_PROGRAM_KEY)
+ *
+ * The mandatory first frame contains the programming sequence. An
+ * optional second frame may ask for the result of the operation
+ * (VIRTIO_RPMB_REQ_RESULT_READ) which would trigger a response frame.
+ *
+ * Returns success/fail with errno and optional response frame
+ */
+static int rpmb_virtio_program_key(struct device *dev, u8 target,
+				   int klen, u8 *key_frame, int rlen, u8 *resp_frame)
+{
+	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
+	struct virtio_rpmb_frame *pkey = (struct virtio_rpmb_frame *) key_frame;
+	struct virtio_rpmb_frame *resp = NULL;
+	struct scatterlist out_frame;
+	struct scatterlist in_frame;
+	struct scatterlist *sgs[2] = { };
+	int len;
+
+	if (!pkey)
+		return -EINVAL;
+
+	if (be16_to_cpu(pkey->req_resp) != VIRTIO_RPMB_REQ_PROGRAM_KEY)
+		return -EINVAL;
+
+	/* validate incoming frame */
+	switch (klen) {
+	case VIRTIO_RPMB_FRAME_SZ:
+		if (rlen || resp_frame)
+			return -EINVAL;
+		break;
+	case VIRTIO_RPMB_FRAME_SZ * 2:
+		if (!rlen || !resp_frame)
+			return -EINVAL;
+		if (be16_to_cpu(pkey[1].req_resp) != VIRTIO_RPMB_REQ_RESULT_READ)
+			return -EINVAL;
+		if (rlen < VIRTIO_RPMB_FRAME_SZ)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* setup outgoing frame(s) */
+	sg_init_one(&out_frame, pkey, klen);
+	sgs[0] = &out_frame;
+
+	/* optional incoming frame */
+	if (rlen && resp_frame) {
+		resp = (struct virtio_rpmb_frame *) resp_frame;
+		sg_init_one(&in_frame, resp, sizeof(*resp));
+		sgs[1] = &in_frame;
+	}
+
+	len = do_virtio_transaction(dev, vi, sgs, 1, resp ? 1 : 0);
+
+	if (len > 0 && resp) {
+		if (be16_to_cpu(resp->req_resp) != VIRTIO_RPMB_RESP_PROGRAM_KEY) {
+			dev_err(dev, "Bad response from device (%x/%x)",
+				be16_to_cpu(resp->req_resp), be16_to_cpu(resp->result));
+			return -EPROTO;
+		} else {
+			/* map responses to better errors? */
+			return be16_to_cpu(resp->result) == VIRTIO_RPMB_RES_OK ? 0 : -EIO;
+		}
+	}
+
+	/* Something must have failed at this point. */
+	return len < 0 ? -EIO : 0;
+}
+
+static int rpmb_virtio_get_capacity(struct device *dev, u8 target)
+{
+	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
+	struct virtio_device *vdev = vi->vdev;
+
+	u8 capacity;
+
+	virtio_cread(vdev, struct virtio_rpmb_config, capacity, &capacity);
+
+	if (capacity > 0x80) {
+		dev_err(&vdev->dev, "Error: invalid capacity reported.\n");
+		capacity = 0x80;
+	}
+
+	return capacity;
+}
+
+static int rpmb_virtio_get_write_count(struct device *dev, u8 target,
+				       int len, u8 *req, int rlen, u8 *resp)
+
+{
+	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
+	struct virtio_rpmb_frame *request = (struct virtio_rpmb_frame *) req;
+	struct virtio_rpmb_frame *response = (struct virtio_rpmb_frame *) resp;
+	struct scatterlist out_frame;
+	struct scatterlist in_frame;
+	struct scatterlist *sgs[2];
+	unsigned int received;
+
+	if (!len || len != VIRTIO_RPMB_FRAME_SZ || !request)
+		return -EINVAL;
+
+	if (!rlen || rlen != VIRTIO_RPMB_FRAME_SZ || !resp)
+		return -EINVAL;
+
+	if (be16_to_cpu(request->req_resp) != VIRTIO_RPMB_REQ_GET_WRITE_COUNTER)
+		return -EINVAL;
+
+	/* Wrap into SG array */
+	sg_init_one(&out_frame, request, VIRTIO_RPMB_FRAME_SZ);
+	sg_init_one(&in_frame, response, VIRTIO_RPMB_FRAME_SZ);
+	sgs[0] = &out_frame;
+	sgs[1] = &in_frame;
+
+	/* Send it, blocks until response */
+	received = do_virtio_transaction(dev, vi, sgs, 1, 1);
+
+	if (received != VIRTIO_RPMB_FRAME_SZ)
+		return -EPROTO;
+
+	if (be16_to_cpu(response->req_resp) != VIRTIO_RPMB_RESP_GET_COUNTER) {
+		dev_err(dev, "failed to get counter (%x/%x)",
+			be16_to_cpu(response->req_resp), be16_to_cpu(response->result));
+		return -EPROTO;
+	}
+
+	return be16_to_cpu(response->result) == VIRTIO_RPMB_RES_OK ?
+		be32_to_cpu(response->write_counter) : -EIO;
+}
+
+static int rpmb_virtio_write_blocks(struct device *dev, u8 target,
+				    int len, u8 *req, int rlen, u8 *resp)
+{
+	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
+	struct virtio_rpmb_frame *request = (struct virtio_rpmb_frame *) req;
+	struct virtio_rpmb_frame *response = (struct virtio_rpmb_frame *) resp;
+	struct scatterlist out_frame;
+	struct scatterlist in_frame;
+	struct scatterlist *sgs[2];
+	int blocks, data_len, received;
+
+	if (!len || (len % VIRTIO_RPMB_FRAME_SZ) != 0 || !request)
+		return -EINVAL;
+
+	/* The first frame will contain the details of the request */
+	if (be16_to_cpu(request->req_resp) != VIRTIO_RPMB_REQ_DATA_WRITE)
+		return -EINVAL;
+
+	blocks = be16_to_cpu(request->block_count);
+	if (blocks > vi->max_wr)
+		return -EINVAL;
+
+	/*
+	 * We either have exactly enough frames to write all the data
+	 * or we have that plus a frame looking for a response.
+	 */
+	data_len = blocks * VIRTIO_RPMB_FRAME_SZ;
+
+	if (len == data_len + VIRTIO_RPMB_FRAME_SZ) {
+		struct virtio_rpmb_frame *reply = &request[blocks];
+
+		if (be16_to_cpu(reply->req_resp) != VIRTIO_RPMB_REQ_RESULT_READ)
+			return -EINVAL;
+
+		if (!rlen || rlen != VIRTIO_RPMB_FRAME_SZ || !resp)
+			return -EINVAL;
+	} else if (len > data_len) {
+		return -E2BIG;
+	} else if (len < data_len) {
+		return -ENOSPC;
+	} else if (rlen || resp) {
+		return -EINVAL;
+	}
+
+	/* time to do the transaction */
+	sg_init_one(&out_frame, request, len);
+	sgs[0] = &out_frame;
+
+	/* optional incoming frame */
+	if (rlen && resp) {
+		sg_init_one(&in_frame, resp, VIRTIO_RPMB_FRAME_SZ);
+		sgs[1] = &in_frame;
+	}
+
+	received = do_virtio_transaction(dev, vi, sgs, 1, resp ? 1 : 0);
+
+	if (response && received != VIRTIO_RPMB_FRAME_SZ)
+		return -EPROTO;
+
+	if (response && be16_to_cpu(response->req_resp) != VIRTIO_RPMB_RESP_DATA_WRITE) {
+		dev_err(dev, "didn't get a response result (%x/%x)",
+			be16_to_cpu(response->req_resp), be16_to_cpu(response->result));
+		return -EPROTO;
+	}
+
+	return be16_to_cpu(response->result) == VIRTIO_RPMB_RES_OK ? 0 : -EIO;
+}
+
+/**
+ * rpmb_virtio_read_blocks(): read blocks of data
+ * @dev: device handle
+ * @target: target region (unused for VirtIO devices)
+ * @addr: block address to start reading from
+ * @count: number of blocks to read
+ * @len: length of receiving buffer
+ * @data: receiving buffer
+ *
+ * Read a number of blocks from RPMB device. As there is no
+ * authentication required to read data we construct the outgoing
+ * frame in this driver.
+ *
+ * Returns success/fail with errno and filling in the buffer pointed
+ * to by @data.
+ */
+static int rpmb_virtio_read_blocks(struct device *dev, u8 target,
+				   int addr, int count, int len, u8 *data)
+{
+	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
+	struct virtio_rpmb_frame *request;
+	struct virtio_rpmb_frame *response = (struct virtio_rpmb_frame *) data;
+	struct scatterlist out_frame;
+	struct scatterlist in_frame;
+	struct scatterlist *sgs[2];
+	int computed_len = count * VIRTIO_RPMB_FRAME_SZ;
+	int received;
+
+	if (!count || !data)
+		return -EINVAL;
+
+	if (addr + count > vi->capacity)
+		return -ESPIPE;
+
+	if (count > vi->max_rd)
+		return -EINVAL;
+
+	/* EMSGSIZE? */
+	if (len < computed_len)
+		return -EFBIG;
+
+	/*
+	 * With the basics done we can construct our request.
+	 */
+	request = kmalloc(VIRTIO_RPMB_FRAME_SZ, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+
+	request->req_resp = cpu_to_be16(VIRTIO_RPMB_REQ_DATA_READ);
+	request->block_count = cpu_to_be16(count);
+	request->address = cpu_to_be16(addr);
+
+	/* time to do the transaction */
+	sg_init_one(&out_frame, request, sizeof(*request));
+	sgs[0] = &out_frame;
+	sg_init_one(&in_frame, data, len);
+	sgs[1] = &in_frame;
+
+	received = do_virtio_transaction(dev, vi, sgs, 1, 1);
+
+	kfree(request);
+
+	if (received != computed_len)
+		return -EPROTO;
+
+	if (be16_to_cpu(response->req_resp) != VIRTIO_RPMB_RESP_DATA_READ) {
+		dev_err(dev, "didn't get a response result (%x/%x)",
+			be16_to_cpu(response->req_resp), be16_to_cpu(response->result));
+		return -EPROTO;
+	}
+
+	return be16_to_cpu(response->result) == VIRTIO_RPMB_RES_OK ? 0 : -EIO;
+}
+
+static struct rpmb_ops rpmb_virtio_ops = {
+	.program_key = rpmb_virtio_program_key,
+	.get_capacity = rpmb_virtio_get_capacity,
+	.get_write_count = rpmb_virtio_get_write_count,
+	.write_blocks = rpmb_virtio_write_blocks,
+	.read_blocks = rpmb_virtio_read_blocks,
+};
+
+static int rpmb_virtio_dev_init(struct virtio_rpmb_info *vi)
+{
+	struct virtio_device *vdev = vi->vdev;
+	/* XXX this seems very roundabout */
+	struct device *dev = &vi->vq->vdev->dev;
+	int ret = 0;
+
+	virtio_cread(vdev, struct virtio_rpmb_config,
+		     max_wr_cnt, &vi->max_wr);
+	virtio_cread(vdev, struct virtio_rpmb_config,
+		     max_rd_cnt, &vi->max_rd);
+	virtio_cread(vdev, struct virtio_rpmb_config,
+		     capacity, &vi->capacity);
+
+	rpmb_virtio_ops.dev_id_len = strlen(id);
+	rpmb_virtio_ops.dev_id = id;
+	rpmb_virtio_ops.wr_cnt_max = vi->max_wr;
+	rpmb_virtio_ops.rd_cnt_max = vi->max_rd;
+	rpmb_virtio_ops.block_size = 1;
+
+	vi->rdev = rpmb_dev_register(dev, 0, &rpmb_virtio_ops);
+	if (IS_ERR(vi->rdev)) {
+		ret = PTR_ERR(vi->rdev);
+		goto err;
+	}
+
+	dev_set_drvdata(dev, vi);
+err:
+	return ret;
+}
+
+static int virtio_rpmb_init(struct virtio_device *vdev)
+{
+	int ret;
+	struct virtio_rpmb_info *vi;
+
+	vi = kzalloc(sizeof(*vi), GFP_KERNEL);
+	if (!vi)
+		return -ENOMEM;
+
+	init_waitqueue_head(&vi->have_data);
+	mutex_init(&vi->lock);
+
+	/* link virtio_rpmb_info to virtio_device */
+	vdev->priv = vi;
+	vi->vdev = vdev;
+
+	/* We expect a single virtqueue. */
+	vi->vq = virtio_find_single_vq(vdev, virtio_rpmb_recv_done, "request");
+	if (IS_ERR(vi->vq)) {
+		dev_err(&vdev->dev, "get single vq failed!\n");
+		ret = PTR_ERR(vi->vq);
+		goto err;
+	}
+
+	/* create vrpmb device. */
+	ret = rpmb_virtio_dev_init(vi);
+	if (ret) {
+		dev_err(&vdev->dev, "create vrpmb device failed.\n");
+		goto err;
+	}
+
+	dev_info(&vdev->dev, "init done!\n");
+
+	return 0;
+
+err:
+	kfree(vi);
+	return ret;
+}
+
+static void virtio_rpmb_remove(struct virtio_device *vdev)
+{
+	struct virtio_rpmb_info *vi;
+
+	vi = vdev->priv;
+	if (!vi)
+		return;
+
+	if (wq_has_sleeper(&vi->have_data))
+		wake_up(&vi->have_data);
+
+	rpmb_dev_unregister(vi->rdev);
+
+	if (vdev->config->reset)
+		vdev->config->reset(vdev);
+
+	if (vdev->config->del_vqs)
+		vdev->config->del_vqs(vdev);
+
+	kfree(vi);
+}
+
+static int virtio_rpmb_probe(struct virtio_device *vdev)
+{
+	return virtio_rpmb_init(vdev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int virtio_rpmb_freeze(struct virtio_device *vdev)
+{
+	virtio_rpmb_remove(vdev);
+	return 0;
+}
+
+static int virtio_rpmb_restore(struct virtio_device *vdev)
+{
+	return virtio_rpmb_init(vdev);
+}
+#endif
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_RPMB, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_rpmb_driver = {
+	.driver.name =	KBUILD_MODNAME,
+	.driver.owner =	THIS_MODULE,
+	.id_table =	id_table,
+	.probe =	virtio_rpmb_probe,
+	.remove =	virtio_rpmb_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze =	virtio_rpmb_freeze,
+	.restore =	virtio_rpmb_restore,
+#endif
+};
+
+module_virtio_driver(virtio_rpmb_driver);
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+MODULE_DESCRIPTION("Virtio rpmb frontend driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/linux/virtio_rpmb.h b/include/uapi/linux/virtio_rpmb.h
new file mode 100644
index 000000000000..f048cd968210
--- /dev/null
+++ b/include/uapi/linux/virtio_rpmb.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UAPI_LINUX_VIRTIO_RPMB_H
+#define _UAPI_LINUX_VIRTIO_RPMB_H
+
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_types.h>
+
+struct virtio_rpmb_config {
+	__u8 capacity;
+	__u8 max_wr_cnt;
+	__u8 max_rd_cnt;
+} __attribute__((packed));
+
+/* RPMB Request Types (in .req_resp) */
+#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
+#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
+#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
+#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
+#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
+
+/* RPMB Response Types (in .req_resp) */
+#define VIRTIO_RPMB_RESP_PROGRAM_KEY       0x0100
+#define VIRTIO_RPMB_RESP_GET_COUNTER       0x0200
+#define VIRTIO_RPMB_RESP_DATA_WRITE        0x0300
+#define VIRTIO_RPMB_RESP_DATA_READ         0x0400
+
+struct virtio_rpmb_frame {
+	__u8 stuff[196];
+	__u8 key_mac[32];
+	__u8 data[256];
+	__u8 nonce[16];
+	__be32 write_counter;
+	__be16 address;
+	__be16 block_count;
+	__be16 result;
+	__be16 req_resp;
+} __attribute__((packed));
+
+/* RPMB Operation Results (in .result) */
+#define VIRTIO_RPMB_RES_OK                     0x0000
+#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
+#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
+#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
+#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
+#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
+#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
+#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
+#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080
+
+
+#endif /* _UAPI_LINUX_VIRTIO_RPMB_H */
-- 
2.30.2

