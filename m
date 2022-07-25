Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C457F9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGYGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGYGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:21 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C981057D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:15 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220725065311epoutp01bb845d85ff62012e9d5040b38f2767c4~E--VPN1gO1626716267epoutp01U
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220725065311epoutp01bb845d85ff62012e9d5040b38f2767c4~E--VPN1gO1626716267epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731991;
        bh=C9Nje1sgO8VlUjf46SGeoU3DREpLDtyNjQX8MCoGpvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eua10WuaDYsPqAfGR+IWnkY798R84bAjxW+gmPcSevr9F7Ao6jYI3zkelNSGAqRVj
         ZfBfRONZ8bbGvZWXJ6Y3pTUVUSijKnlNgcG1ZWwIk3x8O7vaNnclmwBi/Yb0GvOVvX
         YYzaFZEWugqREc1j19D+gcdnDXIL3HnEZ1TVFlb0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220725065311epcas1p49f827c9dfc04a0a219745dbac22e1b70~E--U80hKC1420214202epcas1p4E;
        Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.133]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LrrN64dHSz4x9QF; Mon, 25 Jul
        2022 06:53:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.91.09633.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epcas1p1841fde6ae768a98543418c81790c0832~E--T1DpMA1733317333epcas1p1H;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epsmtrp206ca2407eb1ab417e8eea23f40e09ae1~E--T0Q2yZ0769507695epsmtrp2u;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
X-AuditID: b6c32a36-05fff700000025a1-94-62de3dd6054b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.B6.08802.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epsmtip2e6e083ee634e7bbf8f82f23ce32c75b1~E--TjR-L92484924849epsmtip2m;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 8/9] trinity: Add trace module
Date:   Mon, 25 Jul 2022 15:53:07 +0900
Message-Id: <20220725065308.2457024-9-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmvu4123tJBo1/lC3+TjrGbtG8eD2b
        xfvu3cwWl3fNYbO43biCzeL5tOssDmwev39NYvTYP3cNu0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8yZdY+94O5m
        xoqPHb2MDYz7pjF2MXJySAiYSCz8Opuli5GLQ0hgB6PEjX2PWCGcT4wSOx90s4NUCQl8ZpTY
        ujYQpmPrqYPMXYwcQPFdjBIvcyHqgUrefNsANpVNQFVi5ow1YL0iAt4S81u7mEDqmQUiJa6t
        qAIJCwvoSTR13GcCsVmAyl8tPQNWzitgLdF48RYziM0pYCOx4MduZoi4oMTJmU9YQGxmAXmJ
        5q2zmUH2SgicY5eYNusSI8h8CQEXibkXEyDOFJZ4dXwLO4QtJfH53V42CDtbYkrHIhYIu0Di
        3POtzBCtxhIXV6RAXKkpsX6XPkSFosTO33MZIbbySbz72sMKUc0r0dEmBFGiJLHkz2GoRRIS
        U2d8Y4Io8ZD4f8kGEjb9jBIbVlxhnMAoPwvJL7OQ/DILYfECRuZVjGKpBcW56anFhgVG8BhN
        zs/dxAhOfFpmOxgnvf2gd4iRiYPxEKMEB7OSCG9X2u0kId6UxMqq1KL8+KLSnNTiQ4ymwNCd
        yCwlmpwPTL15JfGGJpYGJmZGxiYWhmaGSuK8q6adThQSSE8sSc1OTS1ILYLpY+LglGpgWrR1
        SdAVFQFzG+d9KzcqWRv3J+62yuxWYZ87WTGWgW9GZoxxbpPvTuWaCcyPGO7ybXQMsP+wKaph
        6fpNZxu2fM9tY3fxWePAYNg1U8JLLamjP79rj9PcO+nP/rXs6DRyXKiqn+Fnvk1unYgRrzLz
        OxO7p9MmNpvZ/KrPk5rZeqDSke3x0tyGi3PVZB5M2WqQsovHfILXrl2/Zmn+C/0Ru5XhfbLI
        ViaXlENSyVHcAi+EBL9UuTq1pz63szoZsW3a9ZCEb7/Cpjhu37Veidlz9erJqnkbM8+edOhW
        X3bHcXvnnMYffra6fdYyoXr2B294MazunVA9MVd8T+asYvVb6db72E/sYVXhv+/8PFKJpTgj
        0VCLuag4EQAntIfGBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO4123tJBku/8Fj8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKmDPrHnvB3c2MFR87ehkbGPdNY+xi5OSQEDCR2HrqIHMXIxeHkMAORok3bbtZIRIS
        EpvuLQdKcADZwhKHDxdD1HxklDg7dzUTSA2bgKrEzBlr2EFsEQF/ib+fjoH1MgtES6zedp8F
        xBYW0JNo6rgPVs8CVP9q6Rmwel4Ba4nGi7eYQWxOARuJBT92g9lCQPH+rhOsEDWCEidnPmGB
        mCkv0bx1NvMERv5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDlYt
        rR2Me1Z90DvEyMTBeIhRgoNZSYS3K+12khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1Me9euWn5RZZde0IEfVQxLxObed2zwn1DLl1fzdvHEuPk7T6Sc
        FmjyZBAVOzL9gqPpXpO6zbyhL9+ErJi5p4z94nKjKI23ufOtH8ixXTW4f/Nz/EppjmuBqdPW
        PrK1X78qaYJe0dqt8vNYeW64PpzVoHNLdrXISb2+WUZVEfMWnb+599Tys6xr3vU9LZhcYtsT
        cPZaq2qL5vx97zzuday/kxPWuDZF2UPO4drRx7yFnZ8OFqp6fd//55W/RGprR15E2RvJJRdE
        hL+2+GdO3GBQVD6pN493vVrgxTXLKtfZHHkhPOH5npUlHw0a0zv2fi+8zp+lGmiQp5bTV5b6
        R/SapjebsJbEPW1JVgeJ/LtiSizFGYmGWsxFxYkAocpqcMUCAAA=
X-CMS-MailID: 20220725065310epcas1p1841fde6ae768a98543418c81790c0832
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065310epcas1p1841fde6ae768a98543418c81790c0832
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065310epcas1p1841fde6ae768a98543418c81790c0832@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for trace declaration.

'trinity' TRACE SUBSYSTEM is introduced for several trace
points. They are for tracing each ioctl control, wakeup,
irq, and run trigger.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile              |   2 +-
 drivers/misc/trinity/trinity.c             |  82 ++++-
 drivers/misc/trinity/trinity_trace.c       |  15 +
 drivers/misc/trinity/trinity_trace.h       | 406 +++++++++++++++++++++
 drivers/misc/trinity/trinity_vision2_drv.c |  11 +-
 5 files changed, 513 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/trinity/trinity_trace.c
 create mode 100644 drivers/misc/trinity/trinity_trace.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index 22141e2233e8..3b546c0f303d 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -6,7 +6,7 @@ trinity-y := trinity.o
 trinity-y += trinity_resv_mem.o trinity_hwmem.o
 trinity-y += sched/core.o sched/priority.o
 trinity-y += trinity_pm.o
-trinity-y += trinity_debug.o
+trinity-y += trinity_debug.o trinity_trace.o
 trinity-y += trinity_sysfs.o trinity_stat.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 08d15f08da39..b7d6bdcd51d1 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -35,6 +35,7 @@
 #include "trinity_common.h"
 #include "trinity_resv_mem.h"
 #include "trinity_stat.h"
+#include "trinity_trace.h"
 
 #define BASE_DEV_NAME "trinity"
 
@@ -448,6 +449,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((uint32_t __user *)arg, &(desc->ver),
 				 sizeof((desc->ver))))
 			return -EFAULT;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_VERSION");
 		break;
 	}
 	case TRINITY_IOCTL_GET_API_LEVEL: {
@@ -456,6 +460,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((uint32_t __user *)arg, &api_level,
 				 sizeof(api_level)))
 			return -EFAULT;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_API_LEVEL");
 		break;
 	}
 	case TRINITY_IOCTL_GET_STATE: {
@@ -465,18 +472,29 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((enum trinity_state __user *)arg, &ready,
 				 sizeof(ready)))
 			return -EFAULT;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_STATE");
 		break;
 	}
 	case TRINITY_IOCTL_GET_TOPS: {
 		if (copy_to_user((uint32_t __user *)arg, &(drv->tops),
 				 sizeof((drv->tops))))
 			return -EFAULT;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_TOPS");
+
 		break;
 	}
 	case TRINITY_IOCTL_GET_DSPM: {
 		if (copy_to_user((uint32_t __user *)arg, &(drv->dspm),
 				 sizeof((drv->dspm))))
 			return -EFAULT;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_DSPM");
+
 		break;
 	}
 	case TRINITY_IOCTL_GET_NEXT_REQUEST: {
@@ -485,6 +503,10 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((int32_t __user *)arg, &req_id,
 				 sizeof(req_id)))
 			return -EFAULT;
+
+		trace_trinity_ioctl_next_req(drv->dev_id, trinity_get_app_id(),
+					     req_id);
+
 		break;
 	}
 	case TRINITY_IOCTL_HWMEM_ALLOC: {
@@ -497,6 +519,10 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 					  hwmem.type);
 		if (err >= 0)
 			trinity_stat_app_total_alloc(drv, hwmem.size);
+
+		trace_trinity_ioctl_hwmem_alloc(
+			drv->dev_id, trinity_get_app_id(), hwmem.size, err);
+
 		break;
 	}
 	case TRINITY_IOCTL_HWMEM_DEALLOC: {
@@ -513,6 +539,10 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		err = trinity_hwmem_free(drv_to_dev_ptr(drv), hwmem.dbuf_fd);
 		if (err == 0)
 			trinity_stat_app_total_freed(drv, dbuf->size);
+
+		trace_trinity_ioctl_hwmem_dealloc(
+			drv->dev_id, trinity_get_app_id(), hwmem.dbuf_fd);
+
 		break;
 	}
 	case TRINITY_IOCTL_REGISTER_MODEL: {
@@ -536,6 +566,18 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct trinity_model __user *)arg,
 				 &model->config, sizeof(model->config)))
 			return -EFAULT;
+
+		trace_trinity_ioctl_register_model(
+			drv->dev_id, trinity_get_app_id(), model->config.id,
+			model->config.dbuf_fd,
+			model->config.program_offset_addr,
+			model->config.program_size);
+
+		trace_trinity_ioctl_register_model_drv_ver2(
+			model->config.metadata_dbuf_fd,
+			model->config.metadata_ext_dbuf_fd,
+			model->config.metadata_ext_size);
+
 		break;
 	}
 	case TRINITY_IOCTL_DEREGISTER_MODEL: {
@@ -545,6 +587,10 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 
 		err = trinity_deregister_model(drv, id);
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_DEREGISTER_MODEL");
+
 		break;
 	}
 	case TRINITY_IOCTL_RUN_INPUT: {
@@ -572,6 +618,15 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return err;
 		}
 
+		trace_trinity_ioctl_run_input(drv->dev_id, trinity_get_app_id(),
+					      input->config.dbuf_fd,
+					      input->config.model_id);
+
+		trace_trinity_ioctl_run_input_drv_ver2(
+			input->config.timeout_ms, input->config.priority,
+			input->config.num_segments, input->config.input_mode,
+			input->config.output_mode);
+
 		if (copy_to_user((struct trinity_input __user *)arg,
 				 &input->config, sizeof(input->config))) {
 			drv->desc->dealloc_req(drv, req);
@@ -585,8 +640,16 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TRINITY_IOCTL_STOP_REQUESTS: {
-		if (drv->desc->stop_reqs)
+		if (drv->desc->stop_reqs) {
 			schedule_work(&drv->work_stop);
+			trace_trinity_ioctl_msg(drv->dev_id,
+						trinity_get_app_id(),
+						"TRINITY_IOCTL_STOP_REQUESTS");
+		} else {
+			trace_trinity_ioctl_msg(
+				drv->dev_id, trinity_get_app_id(),
+				"TRINITY_IOCTL_STOP_REQUESTS: not supported");
+		}
 		break;
 	}
 	case TRINITY_IOCTL_STAT_CURRENT_APP: {
@@ -602,6 +665,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct trinity_ioctl_stat_app __user *)arg,
 				 &ioctl_stat_app, sizeof(ioctl_stat_app)))
 			return -EACCES;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_CURRENT_APP");
 		break;
 	}
 	case TRINITY_IOCTL_STAT_APPS: {
@@ -617,6 +683,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct trinity_ioctl_stat_apps __user *)arg,
 				 &ioctl_stat_apps, sizeof(ioctl_stat_apps)))
 			return -EACCES;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_APPS");
 		break;
 	}
 	case TRINITY_IOCTL_STAT_REQS: {
@@ -635,6 +704,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct trinity_ioctl_stat_reqs __user *)arg,
 				 &ioctl_stat_reqs, sizeof(ioctl_stat_reqs)))
 			return -EACCES;
+
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_REQS");
 		break;
 	}
 	case TRINITY_IOCTL_GET_PROFILE_META: {
@@ -659,6 +731,11 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct trinity_ioctl_profile_meta __user *)arg,
 				 &profile, sizeof(profile)))
 			return -EACCES;
+
+		trace_trinity_ioctl_get_profile_meta(drv->dev_id,
+						     trinity_get_app_id(),
+						     profile.req_id,
+						     profile.profile_size);
 		break;
 	}
 	case TRINITY_IOCTL_GET_PROFILE_BUFF: {
@@ -677,6 +754,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &profile, sizeof(profile)))
 			return -EACCES;
 
+		trace_trinity_ioctl_get_profile_buff(
+			drv->dev_id, trinity_get_app_id(), profile.req_id,
+			profile.profile_pos, profile.profile_size);
 		break;
 	}
 	case TRINITY_IOCTL_FPGA_MEMCPY: {
diff --git a/drivers/misc/trinity/trinity_trace.c b/drivers/misc/trinity/trinity_trace.c
new file mode 100644
index 000000000000..d5721273eeb1
--- /dev/null
+++ b/drivers/misc/trinity/trinity_trace.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Trace source for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "trinity_trace.h"
+#endif
diff --git a/drivers/misc/trinity/trinity_trace.h b/drivers/misc/trinity/trinity_trace.h
new file mode 100644
index 000000000000..fd87f090b73d
--- /dev/null
+++ b/drivers/misc/trinity/trinity_trace.h
@@ -0,0 +1,406 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Trace header for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#if !defined(__TRINITY_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __TRINITY_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM trinity
+#define TRACE_INCLUDE_FILE trinity_trace
+
+// clang-format off
+TRACE_EVENT(triv2_run_trigger,
+	TP_PROTO(u32 device_id, s32 slot),
+	TP_ARGS(device_id, slot),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+	),
+	TP_printk("device_id=%u slot=%d",
+		__entry->device_id,
+		__entry->slot)
+);
+TRACE_EVENT(triv2_wakeup_cp,
+	TP_PROTO(u32 device_id),
+	TP_ARGS(device_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+	),
+	TP_printk("device_id=%u",
+		__entry->device_id)
+);
+TRACE_EVENT(triv2_handle_irq,
+	TP_PROTO(u32 device_id, s32 irq),
+	TP_ARGS(device_id, irq),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, irq)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->irq = irq;
+	),
+	TP_printk("device_id=%u irq=%d",
+		__entry->device_id,
+		__entry->irq)
+);
+TRACE_EVENT(triv2_handle_threaded_irq,
+	TP_PROTO(u32 device_id, s32 irq),
+	TP_ARGS(device_id, irq),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, irq)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->irq = irq;
+	),
+	TP_printk("device_id=%u irq=%d",
+		__entry->device_id,
+		__entry->irq)
+);
+TRACE_EVENT(triv2_handle_cmd_done,
+	TP_PROTO(u32 device_id, s32 slot, u32 cycles, u32 time),
+	TP_ARGS(device_id, slot, cycles, time),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+		__field(u32, cycles)
+		__field(u32, time)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+		__entry->cycles = cycles;
+		__entry->time = time;
+	),
+	TP_printk("device_id=%u slot=%d cycles=%u time(us)=%u",
+		__entry->device_id,
+		__entry->slot,
+		__entry->cycles,
+		__entry->time)
+);
+TRACE_EVENT(triv2_map_sched_data,
+	TP_PROTO(u32 device_id, s32 slot, u32 batch_size, u32 in_cnt, u32 out_cnt),
+	TP_ARGS(device_id, slot, batch_size, in_cnt, out_cnt),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+		__field(u32, batch_size)
+		__field(u32, in_cnt)
+		__field(u32, out_cnt)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+		__entry->batch_size = batch_size;
+		__entry->in_cnt = in_cnt;
+		__entry->out_cnt = out_cnt;
+	),
+	TP_printk("device_id=%u slot=%d batch_size=%u in_cnt=%u out_cnt=%u",
+		__entry->device_id,
+		__entry->slot,
+		__entry->batch_size,
+		__entry->in_cnt,
+		__entry->out_cnt)
+);
+TRACE_EVENT(triv2_unmap_sched_data,
+	TP_PROTO(u32 device_id, s32 slot),
+	TP_ARGS(device_id, slot),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+	),
+	TP_printk("device_id=%u slot=%d",
+		__entry->device_id,
+		__entry->slot)
+);
+TRACE_EVENT(trinity_ioctl_msg,
+	TP_PROTO(u32 device_id, s32 app_id, char *msg),
+	TP_ARGS(device_id, app_id, msg),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(char*, msg)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->msg = msg;
+	),
+	TP_printk("device_id=%u app_id=%d msg=%s",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->msg)
+);
+TRACE_EVENT(trinity_ioctl_next_req,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id),
+	TP_ARGS(device_id, app_id, req_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id)
+);
+TRACE_EVENT(trinity_ioctl_stop_req,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id),
+	TP_ARGS(device_id, app_id, req_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id)
+);
+TRACE_EVENT(trinity_ioctl_hwmem_alloc,
+	TP_PROTO(u32 device_id, s32 app_id, s64 size, s32 dbuf_fd),
+	TP_ARGS(device_id, app_id, size, dbuf_fd),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s64, size)
+		__field(s32, dbuf_fd)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->size = size;
+		__entry->dbuf_fd = dbuf_fd;
+	),
+	TP_printk("device_id=%u app_id=%d size=%lld dbuf_fd=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->size,
+		__entry->dbuf_fd)
+);
+TRACE_EVENT(trinity_ioctl_hwmem_dealloc,
+	TP_PROTO(u32 device_id, s32 app_id, s32 dbuf_fd),
+	TP_ARGS(device_id, app_id, dbuf_fd),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, dbuf_fd)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->dbuf_fd = dbuf_fd;
+	),
+	TP_printk("device_id=%u app_id=%d dbuf_fd=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->dbuf_fd)
+);
+TRACE_EVENT(trinity_ioctl_get_profile_meta,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id, u32 profile_size),
+	TP_ARGS(device_id, app_id, req_id, profile_size),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+		__field(u32, profile_size)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+		__entry->profile_size = profile_size;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d profile_size=%u",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id,
+		__entry->profile_size)
+);
+TRACE_EVENT(trinity_ioctl_get_profile_buff,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id, u32 profile_pos,
+		u32 profile_size),
+	TP_ARGS(device_id, app_id, req_id, profile_pos, profile_size),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+		__field(u32, profile_pos)
+		__field(u32, profile_size)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+		__entry->profile_pos = profile_pos;
+		__entry->profile_size = profile_size;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d profile_pos=%u profile_size=%u",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id,
+		__entry->profile_pos,
+		__entry->profile_size)
+);
+TRACE_EVENT(trinity_ioctl_register_model,
+	TP_PROTO(u32 device_id, s32 app_id, u64 config_id, s32 dbuf_fd,
+		u64 program_offset_addr, u64 program_size),
+	TP_ARGS(device_id, app_id, config_id, dbuf_fd,
+		program_offset_addr, program_size),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(u64, config_id)
+		__field(s32, dbuf_fd)
+		__field(u64, program_offset_addr)
+		__field(u64, program_size)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->config_id = config_id;
+		__entry->dbuf_fd = dbuf_fd;
+		__entry->program_offset_addr = program_offset_addr;
+		__entry->program_size = program_size;
+	),
+	TP_printk("device_id=%u app_id=%d config_id=0x%llx dbuf_fd=%d program_offset_addr=0x%llx program_size=0x%llx",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->config_id,
+		__entry->dbuf_fd,
+		__entry->program_offset_addr,
+		__entry->program_size)
+);
+TRACE_EVENT(trinity_ioctl_register_model_drv_ver1,
+	TP_PROTO(u64 weight_offset_addr),
+	TP_ARGS(weight_offset_addr),
+	TP_STRUCT__entry(
+		__field(u64, weight_offset_addr)
+	),
+	TP_fast_assign(
+		__entry->weight_offset_addr = weight_offset_addr;
+	),
+	TP_printk("weight_offset_addr=0x%llx",
+		__entry->weight_offset_addr)
+);
+TRACE_EVENT(trinity_ioctl_register_model_drv_ver2,
+	TP_PROTO(s32 metadata_dbuf_fd, s32 metadata_ext_dbuf_fd,
+		u64 metadata_ext_size),
+	TP_ARGS(metadata_dbuf_fd, metadata_ext_dbuf_fd, metadata_ext_size),
+	TP_STRUCT__entry(
+		__field(s32, metadata_dbuf_fd)
+		__field(s32, metadata_ext_dbuf_fd)
+		__field(u64, metadata_ext_size)
+	),
+	TP_fast_assign(
+		__entry->metadata_dbuf_fd = metadata_dbuf_fd;
+		__entry->metadata_ext_dbuf_fd = metadata_ext_dbuf_fd;
+		__entry->metadata_ext_size = metadata_ext_size;
+	),
+	TP_printk("metadata_dbuf_fd=%d metadata_ext_dbuf_fd=%d metadata_ext_size=0x%llx",
+		__entry->metadata_dbuf_fd,
+		__entry->metadata_ext_dbuf_fd,
+		__entry->metadata_ext_size)
+);
+TRACE_EVENT(trinity_ioctl_run_input,
+	TP_PROTO(u32 device_id, s32 app_id, s32 dbuf_fd, u64 model_id),
+	TP_ARGS(device_id, app_id, dbuf_fd, model_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, dbuf_fd)
+		__field(u64, model_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->dbuf_fd = dbuf_fd;
+		__entry->model_id = model_id;
+	),
+	TP_printk("device_id=%u app_id=%d dbuf_fd=%d model_id=0x%llx",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->dbuf_fd,
+		__entry->model_id)
+);
+TRACE_EVENT(trinity_ioctl_run_input_drv_ver1,
+	TP_PROTO(u64 activation_offset_addr0, u64 activation_offset_addr1),
+	TP_ARGS(activation_offset_addr0, activation_offset_addr1),
+	TP_STRUCT__entry(
+		__field(u64, activation_offset_addr0)
+		__field(u64, activation_offset_addr1)
+	),
+	TP_fast_assign(
+		__entry->activation_offset_addr0 = activation_offset_addr0;
+		__entry->activation_offset_addr1 = activation_offset_addr1;
+	),
+	TP_printk("activation_offset_addr0=0x%llx activation_offset_addr1=0x%llx",
+		__entry->activation_offset_addr0,
+		__entry->activation_offset_addr1)
+);
+TRACE_EVENT(trinity_ioctl_run_input_drv_ver2,
+	TP_PROTO(s64 timeout_ms, u32 priority, u32 num_segments, s32 input_mode,
+		s32 output_mode),
+	TP_ARGS(timeout_ms, priority, num_segments, input_mode, output_mode),
+	TP_STRUCT__entry(
+		__field(s64, timeout_ms)
+		__field(u32, priority)
+		__field(u32, num_segments)
+		__field(s32, input_mode)
+		__field(s32, output_mode)
+	),
+	TP_fast_assign(
+		__entry->timeout_ms = timeout_ms;
+		__entry->priority = priority;
+		__entry->num_segments = num_segments;
+		__entry->input_mode = input_mode;
+		__entry->output_mode = output_mode;
+	),
+	TP_printk("timeout_ms=%lld priority=%u num_segments=%u input_mode=%d output_mode=%d",
+		__entry->timeout_ms,
+		__entry->priority,
+		__entry->num_segments,
+		__entry->input_mode,
+		__entry->output_mode)
+);
+// clang-format on
+
+#endif /* __TRINITY_TRACE_H__ */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/misc/trinity
+#include <trace/define_trace.h>
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 539eadeca09d..d1633d8d2f90 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -177,7 +177,8 @@ static int triv2_idu_load(struct trinity_driver *drv, const char *dirpath,
 
 static LIST_HEAD(triv2_driver_list);
 static struct hlist_bl_head triv2_model_node_hlist[TRIV2_MODEL_HASH_SIZE];
-static const char * const triv2_op_names[] = TRIV2_FOREACH_OPNAME(TRIV2_GENERATE_OPNAME);
+static const char *const triv2_op_names[] =
+	TRIV2_FOREACH_OPNAME(TRIV2_GENERATE_OPNAME);
 
 static struct triv2_profile *
 triv2_find_profile(const struct trinity_driver *drv, int req_id)
@@ -418,6 +419,8 @@ static void triv2_wakeup_cp(const struct trinity_driver *drv)
 	void *addr =
 		trinity_get_iomem_addr(drv->mmreg_vaddr[0], OFFSET_CP_PROC_SET);
 
+	trace_triv2_wakeup_cp(drv->dev_id);
+
 	trinity_set_bit(BIT_SET_SEND_EVT1, addr);
 }
 
@@ -541,6 +544,8 @@ static void triv2_run_trigger(const struct trinity_driver *drv, int slot)
 	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
 	struct triv2_req *t_req = cmd_info->reqs[slot];
 
+	trace_triv2_run_trigger(drv->dev_id, slot);
+
 	if (!t_req) {
 		dev_err(drv_to_dev_ptr(drv),
 			"Unable to find the corresponding req");
@@ -605,6 +610,10 @@ static void triv2_handle_cmd_done(struct trinity_driver *drv,
 		req->stat->prev_cycles = cmd->total_cycles;
 		req->stat->num_runs++;
 		req->stat->total_time += req->stat->prev_time;
+
+		trace_triv2_handle_cmd_done(drv->dev_id, cmd->slot,
+					    cmd->total_cycles,
+					    req->stat->prev_time);
 	}
 
 	t_req->total_cycles = cmd->total_cycles;
-- 
2.25.1

