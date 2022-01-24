Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D78949783B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiAXEh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:37:59 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:36742 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiAXEh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:37:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1642999077; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0RXLOa0SOhWUj/fhLyb8kCpMc5XnF3qTOu3ySf/VL10=; b=NdwI9ZavKixcLUiphKYQ5PN0yuODYsomS5vmZN5y1oDH6lbEvfQ8nu1QltBhMExJTf3mOxNQ
 s32UNlWAUgmAE98CQp2vTQ5Q+0TLjWVtao2cVOMohsgEdLi5gZRhnAzv5k+A1QQyYSJXESUC
 pzzhhb4y4LwrXIriuCCQQo7LX7s=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61ee2d2406362278a17f06ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Jan 2022 04:37:56
 GMT
Sender: Vijayanand=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADB4EC4360D; Mon, 24 Jan 2022 04:37:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        FROM_ADDR_WS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AB26C4338F;
        Mon, 24 Jan 2022 04:37:50 +0000 (UTC)
From:   Vijayanand@codeaurora.org, Jitta@codeaurora.org
To:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, vjitta@codeaurora.org,
        Vijayanand Jitta <quic_vjitta@quicinc.com>
Subject: [PATCH v4] iommu: Fix potential use-after-free during probe
Date:   Mon, 24 Jan 2022 10:07:27 +0530
Message-Id: <1642999047-13732-1-git-send-email-quic_vjitta@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <quic_vjitta@quicinc.com>

Kasan has reported the following use after free on dev->iommu.
when a device probe fails and it is in process of freeing dev->iommu
in dev_iommu_free function, a deferred_probe_work_func runs in parallel
and tries to access dev->iommu->fwspec in of_iommu_configure path thus
causing use after free.

BUG: KASAN: use-after-free in of_iommu_configure+0xb4/0x4a4
Read of size 8 at addr ffffff87a2f1acb8 by task kworker/u16:2/153

Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x33c
 show_stack+0x18/0x24
 dump_stack_lvl+0x16c/0x1e0
 print_address_description+0x84/0x39c
 __kasan_report+0x184/0x308
 kasan_report+0x50/0x78
 __asan_load8+0xc0/0xc4
 of_iommu_configure+0xb4/0x4a4
 of_dma_configure_id+0x2fc/0x4d4
 platform_dma_configure+0x40/0x5c
 really_probe+0x1b4/0xb74
 driver_probe_device+0x11c/0x228
 __device_attach_driver+0x14c/0x304
 bus_for_each_drv+0x124/0x1b0
 __device_attach+0x25c/0x334
 device_initial_probe+0x24/0x34
 bus_probe_device+0x78/0x134
 deferred_probe_work_func+0x130/0x1a8
 process_one_work+0x4c8/0x970
 worker_thread+0x5c8/0xaec
 kthread+0x1f8/0x220
 ret_from_fork+0x10/0x18

Allocated by task 1:
 ____kasan_kmalloc+0xd4/0x114
 __kasan_kmalloc+0x10/0x1c
 kmem_cache_alloc_trace+0xe4/0x3d4
 __iommu_probe_device+0x90/0x394
 probe_iommu_group+0x70/0x9c
 bus_for_each_dev+0x11c/0x19c
 bus_iommu_probe+0xb8/0x7d4
 bus_set_iommu+0xcc/0x13c
 arm_smmu_bus_init+0x44/0x130 [arm_smmu]
 arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
 platform_drv_probe+0xe4/0x13c
 really_probe+0x2c8/0xb74
 driver_probe_device+0x11c/0x228
 device_driver_attach+0xf0/0x16c
 __driver_attach+0x80/0x320
 bus_for_each_dev+0x11c/0x19c
 driver_attach+0x38/0x48
 bus_add_driver+0x1dc/0x3a4
 driver_register+0x18c/0x244
 __platform_driver_register+0x88/0x9c
 init_module+0x64/0xff4 [arm_smmu]
 do_one_initcall+0x17c/0x2f0
 do_init_module+0xe8/0x378
 load_module+0x3f80/0x4a40
 __se_sys_finit_module+0x1a0/0x1e4
 __arm64_sys_finit_module+0x44/0x58
 el0_svc_common+0x100/0x264
 do_el0_svc+0x38/0xa4
 el0_svc+0x20/0x30
 el0_sync_handler+0x68/0xac
 el0_sync+0x160/0x180

Freed by task 1:
 kasan_set_track+0x4c/0x84
 kasan_set_free_info+0x28/0x4c
 ____kasan_slab_free+0x120/0x15c
 __kasan_slab_free+0x18/0x28
 slab_free_freelist_hook+0x204/0x2fc
 kfree+0xfc/0x3a4
 __iommu_probe_device+0x284/0x394
 probe_iommu_group+0x70/0x9c
 bus_for_each_dev+0x11c/0x19c
 bus_iommu_probe+0xb8/0x7d4
 bus_set_iommu+0xcc/0x13c
 arm_smmu_bus_init+0x44/0x130 [arm_smmu]
 arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
 platform_drv_probe+0xe4/0x13c
 really_probe+0x2c8/0xb74
 driver_probe_device+0x11c/0x228
 device_driver_attach+0xf0/0x16c
 __driver_attach+0x80/0x320
 bus_for_each_dev+0x11c/0x19c
 driver_attach+0x38/0x48
 bus_add_driver+0x1dc/0x3a4
 driver_register+0x18c/0x244
 __platform_driver_register+0x88/0x9c
 init_module+0x64/0xff4 [arm_smmu]
 do_one_initcall+0x17c/0x2f0
 do_init_module+0xe8/0x378
 load_module+0x3f80/0x4a40
 __se_sys_finit_module+0x1a0/0x1e4
 __arm64_sys_finit_module+0x44/0x58
 el0_svc_common+0x100/0x264
 do_el0_svc+0x38/0xa4
 el0_svc+0x20/0x30
 el0_sync_handler+0x68/0xac
 el0_sync+0x160/0x180

Fix this by setting dev->iommu to NULL first and
then freeing dev_iommu structure in dev_iommu_free
function.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <quic_vjitta@quicinc.com>
---
 drivers/iommu/iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d410311..1d320ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -186,9 +186,14 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 
 static void dev_iommu_free(struct device *dev)
 {
-	iommu_fwspec_free(dev);
-	kfree(dev->iommu);
+	struct dev_iommu *param = dev->iommu;
+
 	dev->iommu = NULL;
+	if (param->fwspec) {
+		fwnode_handle_put(param->fwspec->iommu_fwnode);
+		kfree(param->fwspec);
+	}
+	kfree(param);
 }
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
-- 
2.7.4

