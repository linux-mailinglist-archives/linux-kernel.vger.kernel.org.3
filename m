Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B95653E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiGDLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiGDLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:41:49 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF6FD08
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:41:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIKqSvs_1656934902;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VIKqSvs_1656934902)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:45 +0800
From:   Kaihao Bai <carlo.bai@linux.alibaba.com>
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, carlo.bai@linux.alibaba.com
Subject: [PATCH 2/2] kexec: release reserved memory ranges to RAM if crashk_low_res defined
Date:   Mon,  4 Jul 2022 19:41:35 +0800
Message-Id: <1656934895-12334-3-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If reserving low memory range for crashkenrel, the range could not free
to System RAM all the time. However, the high memory range corresponding
to crashk_res can free to RAM through /sys/kernel/kexec_crash_size. If I
write a smaller size to /sys/kernel/kexec_crash_size,  the exceeded part
of  the new size would be released.

To support releasing the low memory range,  we should determine whether
the new size is greater than the accumulated size. If not, the reserved
high memory range will be released firstly. If the new size is smaller
than the size of low memory range, we continue to release the reserved
low memory range after completely releasing the high memory range.

Signed-off-by: Kaihao Bai <carlo.bai@linux.alibaba.com>
---
 kernel/kexec_core.c | 75 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 137f6eb..e89c171 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1031,12 +1031,42 @@ void __weak crash_free_reserved_phys_range(unsigned long begin,
 		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
 }
 
+static int __crash_shrink_memory(struct resource *crashkernel,
+				 unsigned long start, unsigned long end)
+{
+	int ret = 0;
+	struct resource *ram_res;
+
+	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
+	if (!ram_res) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	crash_free_reserved_phys_range(end, crashkernel->end);
+
+	if ((start == end) && (crashkernel->parent != NULL))
+		release_resource(crashkernel);
+
+	ram_res->start = end;
+	ram_res->end = crashk_res.end;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
+	ram_res->name = "System RAM";
+
+	crashkernel->end = end - 1;
+
+	insert_resource(&iomem_resource, ram_res);
+
+	return ret;
+}
+
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
 	unsigned long start, end;
+	unsigned long low_start, low_end;
 	unsigned long old_size;
-	struct resource *ram_res;
+	unsigned long low_old_size;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1047,33 +1077,40 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	low_start = crashk_low_res.start;
+	low_end = crashk_low_res.end;
+	low_old_size = (low_end == 0) ? 0 : low_end - low_start + 1;
+	old_size += low_old_size;
+
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
 	}
+	if (start != end) {
+		start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
 
-	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
-	if (!ram_res) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
-	crash_free_reserved_phys_range(end, crashk_res.end);
+		/*
+		 * If the new_size is smaller than the reserved lower memory
+		 * range of crashkernel, it releases all higher memory range.
+		 * Otherwise it releases part of higher range.
+		 */
+		end = (new_size <= low_old_size) ?
+			roundup(start, KEXEC_CRASH_MEM_ALIGN) :
+			roundup(start + new_size - low_old_size,
+				KEXEC_CRASH_MEM_ALIGN);
 
-	if ((start == end) && (crashk_res.parent != NULL))
-		release_resource(&crashk_res);
+		ret = __crash_shrink_memory(&crashk_res, start, end);
 
-	ram_res->start = end;
-	ram_res->end = crashk_res.end;
-	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
-	ram_res->name = "System RAM";
+		if (ret)
+			goto unlock;
+	}
 
-	crashk_res.end = end - 1;
+	if (new_size < low_old_size) {
+		low_start = roundup(low_start, KEXEC_CRASH_MEM_ALIGN);
+		low_end = roundup(low_start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
-	insert_resource(&iomem_resource, ram_res);
+		ret = __crash_shrink_memory(&crashk_low_res, low_start, low_end);
+	}
 
 unlock:
 	mutex_unlock(&kexec_mutex);
-- 
1.8.3.1

