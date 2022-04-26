Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315450F0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiDZGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbiDZGNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:13:18 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814869FE7;
        Mon, 25 Apr 2022 23:10:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650953409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iitKyA2BmOSsGyxho5Xaj7J6p8svsGj9CM08D3cPrDw=;
        b=pDf8Xdp8mG06STMNFr+MgjyhVeGDYweUdtAvMyJFG3qtkphI/3QCYOf1yYHU1uufXNfMd4
        sSd1ieV0d25+A3tU2uxUri7/FSjZtTHwACxigDRKsQ7pyc3DMnMMwA7FW7XcJaPnGQnKfg
        wJ0K3PRLYO7tnwMkNpYgxPs+9AR6RTI=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of NVDLA driver
Date:   Tue, 26 Apr 2022 14:08:01 +0800
Message-Id: <20220426060808.78225-5-cai.huoqing@linux.dev>
In-Reply-To: <20220426060808.78225-1-cai.huoqing@linux.dev>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
which is integrated into NVIDIA Jetson AGX Xavier,
so add UAPI of this driver.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2:
*Rename nvdla_drm.[ch] to nvdla_drv.[ch] and rename nvdla_ioctl.h to nvdla_drm.h,
 move it to uapi.
 comments link: https://lore.kernel.org/lkml/20bac605-97e6-e5cd-c4e4-83a8121645d8@amd.com/

 include/uapi/drm/nvdla_drm.h | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 include/uapi/drm/nvdla_drm.h

diff --git a/include/uapi/drm/nvdla_drm.h b/include/uapi/drm/nvdla_drm.h
new file mode 100644
index 000000000000..984635285525
--- /dev/null
+++ b/include/uapi/drm/nvdla_drm.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2017-2018 NVIDIA CORPORATION.
+ * Copyright (C) 2022 Cai Huoqing
+ */
+
+#ifndef __LINUX_NVDLA_IOCTL_H
+#define __LINUX_NVDLA_IOCTL_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#if !defined(__KERNEL__)
+#define __user
+#endif
+
+/**
+ * struct nvdla_mem_handle structure for memory handles
+ *
+ * @handle		handle to DMA buffer allocated in userspace
+ * @reserved		Reserved for padding
+ * @offset		offset in bytes from start address of buffer
+ *
+ */
+struct nvdla_mem_handle {
+	__u32 handle;
+	__u32 reserved;
+	__u64 offset;
+};
+
+/**
+ * struct nvdla_ioctl_submit_task structure for single task information
+ *
+ * @num_addresses		total number of entries in address_list
+ * @reserved			Reserved for padding
+ * @address_list		pointer to array of struct nvdla_mem_handle
+ *
+ */
+struct nvdla_ioctl_submit_task {
+#define NVDLA_MAX_BUFFERS_PER_TASK (6144)
+	__u32 num_addresses;
+#define NVDLA_NO_TIMEOUT    (0xffffffff)
+	__u32 timeout;
+	__u64 address_list;
+};
+
+/**
+ * struct nvdla_submit_args structure for task submit
+ *
+ * @tasks		pointer to array of struct nvdla_ioctl_submit_task
+ * @num_tasks		number of entries in tasks
+ * @flags		flags for task submit, no flags defined yet
+ * @version		version of task structure
+ *
+ */
+struct nvdla_submit_args {
+	__u64 tasks;
+	__u16 num_tasks;
+#define NVDLA_MAX_TASKS_PER_SUBMIT	24
+#define NVDLA_SUBMIT_FLAGS_ATOMIC	(1 << 0)
+	__u16 flags;
+	__u32 version;
+};
+
+/**
+ * struct nvdla_gem_create_args for allocating DMA buffer through GEM
+ *
+ * @handle		handle updated by kernel after allocation
+ * @flags		implementation specific flags
+ * @size		size of buffer to allocate
+ */
+struct nvdla_gem_create_args {
+	__u32 handle;
+	__u32 flags;
+	__u64 size;
+};
+
+/**
+ * struct nvdla_gem_map_offset_args for mapping DMA buffer
+ *
+ * @handle		handle of the buffer
+ * @reserved		reserved for padding
+ * @offset		offset updated by kernel after mapping
+ */
+struct nvdla_gem_map_offset_args {
+	__u32 handle;
+	__u32 reserved;
+	__u64 offset;
+};
+
+#define DRM_NVDLA_SUBMIT		0x00
+#define DRM_NVDLA_GEM_CREATE	0x01
+#define DRM_NVDLA_GEM_MMAP		0x02
+
+#define DRM_IOCTL_NVDLA_SUBMIT DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_SUBMIT, struct nvdla_submit_args)
+#define DRM_IOCTL_NVDLA_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_GEM_CREATE, struct nvdla_gem_create_args)
+#define DRM_IOCTL_NVDLA_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_GEM_MMAP, struct nvdla_gem_map_offset_args)
+
+#endif
-- 
2.25.1

