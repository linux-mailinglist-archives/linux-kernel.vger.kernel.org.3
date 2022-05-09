Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9A51F4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiEIGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiEIGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:33:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFA818A69C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:29:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j6so11405985pfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxGePxN899QZhoK9/ghhqKhjvB6kwBatns9zvkXLNoM=;
        b=YxJIkB+tjVeh+3RaEuq0lx22G52hqRP2Q41/98aBO7PbNanU0ZAG/2VYybdqoy7A9G
         NMUXQFOd0c0pmsmXy+HaT2LDFlWv5g5lewOhRall6jZaP7EaHXIRTmKbhLMvQJu8U0Z2
         KD0/h6+ozi2Qm+EGZh7LEP+B6OSR1gFw+hOA2mZy2JOIZOdQ9Gu5iF2EblTcQHtyBNHD
         HFdPX8PW+nM7stUaD0vTKqmz6t8ps5QUjKtNLW/JM7V457xk441c9ZwHf0Uaqa3hQqIJ
         sD5wJ69vhdY8VHBVEl7SGO6pZjj3slZUUYcA8gL9PtZ4GTtPMNGbsoC7QudoKYbgfAod
         B3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxGePxN899QZhoK9/ghhqKhjvB6kwBatns9zvkXLNoM=;
        b=e1w1hXb+EsjBuHZC+f8AVY7ESbDFF3hmMhFcWWbhQepLW9ywvZjPLzO5N2BJXNMmOF
         k7nxVDgRRb8lWssdg9tWFADHwpMQbU2hDROY0gxndB3ZranC0BR6JuGAlcxxJD65Bd79
         T6ml6KCDZInA96qrUVxpf6DJ4LVY+PRJl5oz1ZxP4UobPiL3tRYhxZip3WND4yv2eaTI
         +vN2Jl16aoq0Hw1Gkot/6ZsbFS0cN5+exEKy4eOIg7G71eW+CPy934KTnBOsa7Btrajw
         OqK8j5DYFXdDN+HIKPQM+kuyoy9d28GyJ0QwOIYQuSw2DtdimQ48s/+cELbKEBMHmbOK
         mQDA==
X-Gm-Message-State: AOAM5334KxnzPfCzrbT7XRNPPjxaDNa1qCH2NLRuUatRNtrWDo1k61cr
        1RICkwzJAb+0XZrmlcYd2kdsTQ==
X-Google-Smtp-Source: ABdhPJx/EFqVRRy5eL0t3+AS10kjTooGOitYJZKGi7Xtf2ozkJgteJkT0pgvGVy/dc2m1ku/jQuGXw==
X-Received: by 2002:a65:6a16:0:b0:39d:4f3:67e6 with SMTP id m22-20020a656a16000000b0039d04f367e6mr12242601pgu.84.1652077768485;
        Sun, 08 May 2022 23:29:28 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ba9100b0015e8d4eb2c2sm6162001pls.268.2022.05.08.23.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:29:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Mon,  9 May 2022 14:27:01 +0800
Message-Id: <20220509062703.64249-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220509062703.64249-1-songmuchun@bytedance.com>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
hot added memory. If "hugetlb_free_vmemmap=on" and
memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
optimizing hugetlb pages takes precedence.  However, the global variable
memmap_on_memory will still be set to 1, even though we will not try to
allocate memmap on hot added memory.

Also introduce mhp_memmap_on_memory() helper to move the definition of
"memmap_on_memory" to the scope of CONFIG_MHP_MEMMAP_ON_MEMORY.  In the
next patch, mhp_memmap_on_memory() will also be exported to be used in
hugetlb_vmemmap.c.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory_hotplug.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 111684878fd9..a6101ae402f9 100644
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
@@ -1263,9 +1285,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
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
@@ -2083,7 +2103,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
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

