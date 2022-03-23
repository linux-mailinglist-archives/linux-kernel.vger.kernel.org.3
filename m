Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2D4E52A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiCWM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbiCWM65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:58:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148E7C7A4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:57:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t2so1421335pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=klQHErqFx0PL/Fv5xPsDY5FCp9h1WAWHtQY8CkLJqSnWWxlf7n8gZPbF1jU67rWUkO
         RiNMKhxX/Xg1v5vX52kPo/YZ9LUvdvabSQyz+QHeO8CRTXNQ+zFyjfInSR4JoPxA3Z5F
         SRAfE1BxdQg1gFD8ogKft8NnWyg8oM1opsAaki/A9v6Mb9WFi+MI/e3hCeDvBkSzggEO
         DZzHUo3JWrwfdiuJg5dS4p02oU2qGMsbQSGu32tpXh9I/KPjvq97JrKDey8w9cKoviVw
         TOVj2mC/CUcDvDZg5H2V5bgy2VpnFGnoDgr4naFnzqFOiFOKszSHtWEqrrgq4Z63avHo
         UiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=zgmOliyqLKnekr9btD6BmCH5zUdqKGMD9+f3sCph6Ges/Lh3PxqQQJprLZeIZdhVK4
         gKOSU455tOqKO2DWeQcPsjfQ8D4IWtQysiLG88X9yQOvjSasY6bGXCncDMIYvqNdrG7K
         GVvbsh2y6Gn3Ccm5OsunpDCgQce5uTQeszc6QN2Ep0hMP0CR277EvTF9L4Te1jubplMq
         PM+KPbYBl1zt2TitT+h3YrZm/s5kmCtGPkVcVnuCoDrzBx7OQoJKYgnqlTNibFEtBkJc
         LJsVAliFqx1WzkRnVU0u1nl4E4AwicnYldf5P0MobLLaOo3QdD6nCSKTXjvGHqeZdAaq
         hVwA==
X-Gm-Message-State: AOAM531C0M8koxLLMOF8UR/xjiB4U5Xs0ppZ80vbZr09o3f/5WWp8hNs
        X4SM7gu8WhYVoqZUOFfU61+QVA==
X-Google-Smtp-Source: ABdhPJxBpZnTaoYXrcelzj7ZCP8izarLpVDuw5/fdNopmLw6AjGmH4Z7zl4e+9aOupHblaaznliQNw==
X-Received: by 2002:a05:6a00:22c3:b0:4f7:7cb:26b0 with SMTP id f3-20020a056a0022c300b004f707cb26b0mr33799357pfj.47.1648040246799;
        Wed, 23 Mar 2022 05:57:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm15716517pgd.27.2022.03.23.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:57:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Wed, 23 Mar 2022 20:55:21 +0800
Message-Id: <20220323125523.79254-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220323125523.79254-1-songmuchun@bytedance.com>
References: <20220323125523.79254-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

