Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDD4EC86F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348322AbiC3Pk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348297AbiC3PkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:40:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818C5FAE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id o13so17866275pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=DL6MvDKNwjEQAcAjwqdIUR2I8Y7w3p50Rxwzf5Gami2jRkn7Omgk00iSd2R/cVitvy
         JAxo5e70v9RocacCHTEFuqP0nWFlqfihqMkP09MRQ7jNZEoTwKOe2AwGdcAgyoF9ehYZ
         WUHLFD8Op0Y0jfuWDOragISN2nhXe6QtaGu8FEFZ5S5/QAPh/4Slhp7csz4jnj4kRSIu
         cd8xyQCLxUR5dhzG8Dktrpuk88Q75Dw2XiQRcrrHf0lPz5Oh0lrEJbOZQn/YnQA+b6oM
         Migr6cQ27ui58BOxlm/IZuyRNbzfg6KMGWhVrWFNX+/T6H/kHHCwxdtfgrkO/IERP86Q
         mfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=sWXuknjZ82qcikKvrfDOxK7njAESnKP2r1AETZVyI7NYpn+DcmQyGkzdFd0hPJBzz9
         bjtY9Po1t0GW6IaGe9BQhpXBhndorpGwOQoc1v5tbypin5g/0bfi1tCm1MLab5oSxH2S
         YRaMqpUnQ/EL2bK/dJQHOaODTZ5Exdcam/5b3JRSuHQcDs1cCdF3DwzPLACNcsP52FGv
         MbjuuGiGRPEuO6x2QJzqNUoixaIyL1JU+1zgXuTkEDMOsro7f0g46uCd5Mk2Pppq+X4z
         TH6tr2ap8HWRvUzvvfRJbFkHF0UX7NbUx+CXwu+OKD4wHTrxDMYNgZOw8UERZlwsOMXV
         PsvQ==
X-Gm-Message-State: AOAM5338OLhYAVbqhQoUjl9ZuO7ndY9goz4eCi3d0bZydm8Vx23CknBF
        IfOBy6L+pRu89gFd8d4jYMo1og==
X-Google-Smtp-Source: ABdhPJzYQ3DB1iiUN+HrZJlK9ubuScf4cy2yWJ1ccvf2ryWt32fgS0PQ7IPR8xmBmftgaxU73KaEHg==
X-Received: by 2002:a63:4147:0:b0:382:9ac9:b12b with SMTP id o68-20020a634147000000b003829ac9b12bmr6832277pga.277.1648654711766;
        Wed, 30 Mar 2022 08:38:31 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm6686039pjp.9.2022.03.30.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:38:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Wed, 30 Mar 2022 23:37:43 +0800
Message-Id: <20220330153745.20465-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220330153745.20465-1-songmuchun@bytedance.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
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
index 416b38ca8def..da594b382829 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,14 +42,36 @@
 #include "internal.h"
 #include "shuffle.h"
 
+#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
+static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
+{
+	if (hugetlb_free_vmemmap_enabled())
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
@@ -1288,9 +1310,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	return memmap_on_memory &&
-	       !hugetlb_free_vmemmap_enabled() &&
-	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
+	return mhp_memmap_on_memory() &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
 	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
@@ -2074,7 +2094,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
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

