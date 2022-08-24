Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353C559F3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiHXGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHXGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:51:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596F7F25E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:51:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p185so1152551pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=f4kGHpDiTMc7aSXLbliqd1x6vmGGCzguotz7s4Fiy6o=;
        b=8NmA2RtSjgVWxKE3P11MYB9xDj+uZFhnJM4DBdnFMMYaISlvqmru3I8t0IzAfBIjm+
         2V2FLdpH6+LNGtbFnfGeQ9Lx81O1rFyRBvaJ0muM9OdPCF2/n5k4ionqO9SStAka9nH2
         fzezBt4n6/UcyipjQABD1cAdptiNyEgRj4HakdiHCcYhcqYK3FKz8eIO9TIBe1WDD1u5
         IlBdaEaog0UcgcN41Xxlo3XX58N/dVI+xU6bP/s2+X0wxvZFIl2foudWDyBqjyID4FX3
         9ZHnwtMwKQaNU7A2TuEciz3XwbIlWMstA1TPvcBPvYklrnpf7GDOUFYOt4yLk3Q/kawq
         TlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=f4kGHpDiTMc7aSXLbliqd1x6vmGGCzguotz7s4Fiy6o=;
        b=yAgitN6/5vf5x/tNMeMpusiWhfZcU+zx7TIuFpOuXE4TH17mbB5WAWoXrn2xqgQfOi
         gZDKcwUFsEylp+9Wg290qGecpv9PrOVh6dosH3m4Poa7nO4/D2pLTWX4dRP9eJMWAsUc
         p5PwLEpSs6OE9IYsDFzeyYcyAyfCQIafQ8qC8TvMo67n9UX7mNBI2hnmDgmSiTllZa3t
         dY632fNE+j/O4kNYmhv2Xfy5DiryBWw6ltbiJnFj5LWcqVFOXJwWzOK3YzA08MGTVmn1
         MrEMNDVX+y4tSbizxN4XEJM1aI9mIkxs2B9kltpl2MF0GRqIExpODMB/HdhoyYaYpQwo
         vtjQ==
X-Gm-Message-State: ACgBeo3VgSQDqK2gazBWV9ajcqqlEC5hRz5HMY9F3vPx+QcAD7m/DUZj
        2Lfg3Dnf/wBoQhc8XnJVBF/0wg==
X-Google-Smtp-Source: AA6agR4iPifEiVYf6J0ntQeFYnS7mi+e8o3iPYpH7UDbIWZxWhEewn2WsiEkUPKeHN3dcgHgdD5huQ==
X-Received: by 2002:a63:8bc1:0:b0:42a:1604:3342 with SMTP id j184-20020a638bc1000000b0042a16043342mr21693992pge.368.1661323880784;
        Tue, 23 Aug 2022 23:51:20 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id a12-20020aa794ac000000b00536873f23dfsm6318112pfl.136.2022.08.23.23.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2022 23:51:20 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        mhiramat@kernel.org, keescook@chromium.org, Jason@zx2c4.com,
        mark-pk.tsai@mediatek.com, rostedt@goodmis.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com, yuanzhu@bytedance.com,
        lizhe.67@bytedance.com
Subject: [PATCH v2] page_ext: introduce boot parameter 'early_page_ext'
Date:   Wed, 24 Aug 2022 14:50:58 +0800
Message-Id: <20220824065058.81051-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
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

From: Li Zhe <lizhe.67@bytedance.com>

In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
we call page_ext_init() after page_alloc_init_late() to avoid some panic
problem. It seems that we cannot track early page allocations in current
kernel even if page structure has been initialized early.

This patch introduce a new boot parameter 'early_page_ext' to resolve this
problem. If we pass it to kernel, function page_ext_init() will be moved
up and feature 'deferred initialization of struct pages' will be disabled.
It can help us to catch early page allocations. This is useful especially
when we find that the free memory value is not the same right after
different kernel booting.

Changelogs:

v1->v2:
- use a cmd line parameter to move up function page_ext_init() instead of
  using CONFIG_DEFERRED_STRUCT_PAGE_INIT
- fix oom problem[1]

v1 patch: https://lore.kernel.org/lkml/Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz/T/

[1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 include/linux/page_ext.h                      | 14 ++++++++++---
 init/main.c                                   |  4 +++-
 mm/page_alloc.c                               |  2 ++
 mm/page_ext.c                                 | 21 ++++++++++++++++++-
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7f30902fda0..7b5726828ac0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1471,6 +1471,12 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	early_page_ext [KNL] Boot-time early page_ext initializing option.
+			This boot parameter disables the deferred initialization
+			of struct page and move up function page_ext_init() in
+			order to catch early page allocations. Available with
+			CONFIG_PAGE_EXTENSION=y.
+
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1e087f..3e081cf8a1ec 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -38,19 +38,22 @@ struct page_ext {
 
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+extern bool early_page_ext_enable(void);
+#endif
 
 #ifdef CONFIG_SPARSEMEM
 static inline void page_ext_init_flatmem(void)
 {
 }
-extern void page_ext_init(void);
+extern void page_ext_init(bool early);
 static inline void page_ext_init_flatmem_late(void)
 {
 }
 #else
 extern void page_ext_init_flatmem(void);
 extern void page_ext_init_flatmem_late(void);
-static inline void page_ext_init(void)
+static inline void page_ext_init(bool early)
 {
 }
 #endif
@@ -67,6 +70,11 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
+static inline bool early_page_ext_enable(void)
+{
+	return false;
+}
+
 static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
 {
 }
@@ -76,7 +84,7 @@ static inline struct page_ext *lookup_page_ext(const struct page *page)
 	return NULL;
 }
 
-static inline void page_ext_init(void)
+static inline void page_ext_init(bool early)
 {
 }
 
diff --git a/init/main.c b/init/main.c
index 91642a4e69be..3760c0326525 100644
--- a/init/main.c
+++ b/init/main.c
@@ -849,6 +849,8 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
+	/* Should be run after vmap initialization */
+	page_ext_init(true);
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
@@ -1606,7 +1608,7 @@ static noinline void __init kernel_init_freeable(void)
 	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
-	page_ext_init();
+	page_ext_init(false);
 
 	do_basic_setup();
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..e580b197aa1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -482,6 +482,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 {
 	static unsigned long prev_end_pfn, nr_initialised;
 
+	if (early_page_ext_enable())
+		return false;
 	/*
 	 * prev_end_pfn static that contains the end of previous zone
 	 * No need to protect because called very early in boot before smp_init.
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d7ac29..82ba561730ef 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -85,6 +85,22 @@ unsigned long page_ext_size = sizeof(struct page_ext);
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static bool early_page_ext __meminitdata;
+bool __meminit early_page_ext_enable(void)
+{
+	return early_page_ext;
+}
+#else
+static bool early_page_ext __meminitdata = true;
+#endif
+static int __init setup_early_page_ext(char *str)
+{
+	early_page_ext = true;
+	return 0;
+}
+early_param("early_page_ext", setup_early_page_ext);
+
 static bool __init invoke_need_callbacks(void)
 {
 	int i;
@@ -378,11 +394,14 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 	return notifier_from_errno(ret);
 }
 
-void __init page_ext_init(void)
+void __init page_ext_init(bool early)
 {
 	unsigned long pfn;
 	int nid;
 
+	if (early != early_page_ext)
+		return;
+
 	if (!invoke_need_callbacks())
 		return;
 
-- 
2.20.1

