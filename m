Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC754FDF72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiDLMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354462AbiDLMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:14:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FC8595F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so2550876pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UA2E7Swg+iesG+ux9AwzGNddrfmiNsjUbQGq/dsMiM=;
        b=KyuopGe1m1WVOFP9p32hmnKBOcBz7duXJkJk9fS7PkoLF0O/RrKyn0sKqaHT7mwP2o
         Oemd+xORRsXBp6BQ77rF2ECHQKbcsydrcRVQF+xON0R1Tc3192LcDa9tNR+Yhg72Hcko
         WDNb0O+5PAynoZQW4wML+O/ykXnlIcgyVq39+gR98yIkZ48xzIJDvoZWzM+bvssO9tUm
         82+Bu3gpNvE/FAoQFNukD7gOFZ1aOiNOmkU6gSOXM0qJyOIOfevULObXLuMq/Gcki9/P
         1JI9GHBns+7OgvpyjHhLm8EgsSAg1TAA9L0/viQqSSKRt1/ETaLApAa7XkNdQSziZJcQ
         FSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UA2E7Swg+iesG+ux9AwzGNddrfmiNsjUbQGq/dsMiM=;
        b=ZAtDNVULWK2NGXR2a1wCzLOqRpt7pF90TWMj7aPYPtIzaX5gjR+EnxKVm3kENu6fuh
         ikLT1wiZQ50hPnD2dIMwoVTNJOqK2keY2rq8+eJIHjTcC0nH89jAkTBrGe14n2XQoJGK
         tcf26w9Dn1W3HCSGC9I8X/Si76TtHgnTTHaGsxSVTcQgBJ2Zkmb/pQKZ4qoNsqaIpzId
         rI/XQjpf9L2YXBZnqDXLtyKQqcPfc+K1u/FhmPTGR931Uuhbfsv3psKedw257iwlDUCc
         dPlt+veycrRvKiyN2s7rfw5/ZLIIgr+kVpvNesy8zgDi6iEXV/LB9K5P/0k+AXUclQvC
         MGqw==
X-Gm-Message-State: AOAM531VQtSzenGpOAsR3RuExSp6HYV6SL4NZXBCb1pr0C6xsJWGiWVa
        sAQa6mJ8e7z0U4rc8pPtJGh96w==
X-Google-Smtp-Source: ABdhPJw0PpvcK/RfW3RHG1GTMBjicwgJXBBNM/iVvZwsd6IE8JTVr0XCaF+IWKEuybeVVBGmHde9Gw==
X-Received: by 2002:a17:902:c94d:b0:158:4e50:7a32 with SMTP id i13-20020a170902c94d00b001584e507a32mr12971286pla.163.1649762110989;
        Tue, 12 Apr 2022 04:15:10 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l25-20020a635719000000b0039da6cdf82dsm402507pgb.83.2022.04.12.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:15:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Tue, 12 Apr 2022 19:14:32 +0800
Message-Id: <20220412111434.96498-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220412111434.96498-1-songmuchun@bytedance.com>
References: <20220412111434.96498-1-songmuchun@bytedance.com>
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

