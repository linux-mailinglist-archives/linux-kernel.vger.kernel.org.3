Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171F4FF963
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiDMOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiDMOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:51:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F4644F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d15so2148941pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UA2E7Swg+iesG+ux9AwzGNddrfmiNsjUbQGq/dsMiM=;
        b=qy9bm5h22bSwGRfwhbePUNdpcjM3mbKq7ygfInxMwnDotiXu2yFUlYBXkhCnlMwPOW
         Lo2SdpeT//ZkMmHnrxy9LBo5B95Tlnt+22gl8vhDUY9E6Z7VmlJqtv4TQCKfIppDEkuA
         n3OZ1/n5jMzs4/wXvQkg2zjrHNln5L/W2mIZPXdGC9gnqfOEcJjfpGUtXMrOAstS2drY
         XD2xConyvFGywLEX099TYe/QaqPF5qS8isNoPOJt+c7hjXq6KTZNriLARnsksUWFqSoe
         6+Zxaa/iEbJMLdAX3guDL3tWIpzNGg33TqEGTq0Fa3U0TzSo4hXMQmyOW3sbhipZXbtm
         A2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UA2E7Swg+iesG+ux9AwzGNddrfmiNsjUbQGq/dsMiM=;
        b=kRqXvZH1QpkvZFjnBYNDlbB8voI9WD+CwbyfQVMJTpg85vCgAW/FyU6w8r6czLp3Xh
         DO5PQs1LezOCTcoZZhrrLnLOGz5xLs5QxH7roI/EoH8OLxoD9Eskh/tNim+TB/T07D1u
         w7WguOxL/8OKDatENOpAEtNmFbqE1xoC15nFtxDrInj0uF+qg+DAdMlGuipBIYOhkYk7
         8KdOQFTYHBHc2RAgB7V/PEy4roYbhgS6aPP0CYQazBCJEJ9OuCHikmS1zwpSJHPvYhZh
         9DcR/DvUf0j74HUAvmQ4UyysMXVf1Gyj4BOAfClXUyZf2x9GllXud5JLJuIYLSJGiBsf
         kXuA==
X-Gm-Message-State: AOAM533HJXyge6ZJmEfNe0+2ioRTH42F8PUBFv73J2yCsghZM1mzevWO
        h7wSgMtMn2knJopg43I2dWMNjw==
X-Google-Smtp-Source: ABdhPJyX5qDb668ls6tZ6opY0Ql76EWScJCRk2AzqYp8TKQVr1l9ARVh218HOC97y2V1F7Wd/U1wCw==
X-Received: by 2002:a17:90b:3e82:b0:1c7:2920:7c54 with SMTP id rj2-20020a17090b3e8200b001c729207c54mr11381401pjb.2.1649861320371;
        Wed, 13 Apr 2022 07:48:40 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm47817257pfh.58.2022.04.13.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:48:40 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Wed, 13 Apr 2022 22:47:46 +0800
Message-Id: <20220413144748.84106-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220413144748.84106-1-songmuchun@bytedance.com>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "hugetlb_free_vmemmap=on" and "memory_hotplug.memmap_on_memory"
are both passed to boot cmdline, the variable of "memmap_on_memory"
will be set to 1 even if the vmemmap pages will not be allocated from
the hotadded memory since the former takes precedence over the latter.
In the next patch, we want to enable or disable the feature of freeing
vmemmap pages of HugeTLB via sysctl.  We need a way to know if the
feature of memory_hotplug.memmap_on_memory is enabled when enabling
the feature of freeing vmemmap pages since those two features are not
compatible, however, the variable of "memmap_on_memory" cannot indicate
this nowadays.  Do not set "memmap_on_memory" to 1 when both parameters
are passed to cmdline, in this case, "memmap_on_memory" could indicate
if this feature is enabled by the users.

Also introduce mhp_memmap_on_memory() helper to move the definition of
"memmap_on_memory" to the scope of CONFIG_MHP_MEMMAP_ON_MEMORY.  In the
next patch, mhp_memmap_on_memory() will also be exported to be used in
hugetlb_vmemmap.c.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 74430f88853d..f6eab03397d3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,14 +42,36 @@
 #include "internal.h"
 #include "shuffle.h"
 
+#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
+static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
+{
+	if (hugetlb_optimize_vmemmap_enabled())
+		return 0;
+	return param_set_bool(val, kp);
+}
+
+static const struct kernel_param_ops memmap_on_memory_ops = {
+	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
+	.set	= memmap_on_memory_set,
+	.get	= param_get_bool,
+};
 
 /*
  * memory_hotplug.memmap_on_memory parameter
  */
 static bool memmap_on_memory __ro_after_init;
-#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
-module_param(memmap_on_memory, bool, 0444);
+module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
+
+static inline bool mhp_memmap_on_memory(void)
+{
+	return memmap_on_memory;
+}
+#else
+static inline bool mhp_memmap_on_memory(void)
+{
+	return false;
+}
 #endif
 
 enum {
@@ -1272,9 +1294,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	return memmap_on_memory &&
-	       !hugetlb_optimize_vmemmap_enabled() &&
-	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
+	return mhp_memmap_on_memory() &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
 	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
@@ -2081,7 +2101,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
 	 * the same granularity it was added - a single memory block.
 	 */
-	if (memmap_on_memory) {
+	if (mhp_memmap_on_memory()) {
 		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
 						      get_nr_vmemmap_pages_cb);
 		if (nr_vmemmap_pages) {
-- 
2.11.0

