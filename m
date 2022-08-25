Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B365A0DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiHYK2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiHYK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:28:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A19C520
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:28:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e19so18675709pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=O2Ikkum5C34vGQERHK2iuYBRYhJaZQxobN63T5g+OZ4=;
        b=Sfri+HInQMSLrEobvaOIST+ho1iAiUvs8UAlYPAzpUIJJ8C9eAJ9d2GiUSx2sdhbtT
         qOwFSH8ynkSMr6lco+3x7jpYyf6gOBgyD+ukwmY2m3X1F6N7BlYlY00bwwOulCpf239a
         idVdbrUq3Q3K4VPZqMi9oVvUXPLx4Cyb4FEHokFyLKO0FIKWV1J0xhUoVkeEpaZcR+3X
         mtfVzGuW/tTxVA91g2uu24n9rJInnKJ+FaZJgZQy8COCSZSnfyQFgGZicdH5csw+dgVh
         wZBjw+7rAAjexaEVJLUXPdZsJryircnE5+vmwpCSXWJwcEgoJ4YgkPl1oDNVzZBr4L3q
         pVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=O2Ikkum5C34vGQERHK2iuYBRYhJaZQxobN63T5g+OZ4=;
        b=NeCx2Z7RC7Ar8geN7kDmE9JBUtTSb39o8SqlZuBjEAzHg8gH60PPsFhE7/LsN3+gcn
         r8qxyGe+bHJMPG7tHNgnmc+5h0f93KTY47hLGZwruj7Ea9Eh1dy6a3wrELaRf7if3GHr
         iQaWx8MXkaq9p4Sm24LuivHPoXsVtFL7/CFJ5hVRe/OBsq3xfQsH8Gr2rBsyHTZ69oT/
         fwhrDpFbP86m2ThaQ/S23wCvwmpnAvPVxr0iIqLW3jqcL2MrDcGQgv01WF2IRYz0C5SG
         HzIepZfN6T7yUTJ0gqE23EtBYZQzJxid7dBn9JnlWERh94XiNs6R+Tmlqz+XBYWTLd1o
         UNqw==
X-Gm-Message-State: ACgBeo1/Iv/hCmWruEkxrszKEpQ913ij93W/gEFqk+W13gG+n3o1J5Ke
        D36OreCXQ82xKBm53hQn3eOzgw==
X-Google-Smtp-Source: AA6agR7KuXy0jMjTqR7P77WoMhwXzuGW5mnoJiIfWSlBxpCTWDTpYdJT4ZTdGTQdMa/qeVGo19eZvQ==
X-Received: by 2002:a17:90a:1d0:b0:1fa:c551:5e83 with SMTP id 16-20020a17090a01d000b001fac5515e83mr13028533pjd.106.1661423289017;
        Thu, 25 Aug 2022 03:28:09 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902d19500b0016d1bee1519sm14064611plb.102.2022.08.25.03.28.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 03:28:08 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        mhiramat@kernel.org, keescook@chromium.org, Jason@zx2c4.com,
        mark-pk.tsai@mediatek.com, rostedt@goodmis.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com, lizhe.67@bytedance.com
Subject: [PATCH v4] page_ext: introduce boot parameter 'early_page_ext'
Date:   Thu, 25 Aug 2022 18:27:14 +0800
Message-Id: <20220825102714.669-1-lizhe.67@bytedance.com>
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
up and feature 'deferred initialization of struct pages' will be disabled
to initialize the page allocator early and prevent from the panic problem
above. It can help us to catch early page allocations. This is useful
especially when we find that the free memory value is not the same right
after different kernel booting.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
Changelogs:

v1->v2:
- use a cmd line parameter to move up function page_ext_init() instead of
  using CONFIG_DEFERRED_STRUCT_PAGE_INIT
- fix oom problem[1]

v2->v3:
- move the judgment out of page_ext_init()

v3->v4:
- remove dependency on CONFIG_DEFERRED_STRUCT_PAGE_INIT
- modify descriptions in git log && kernel-parameters.txt

v1 patch: https://lore.kernel.org/lkml/Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz/T/
v2 patch: https://lore.kernel.org/lkml/20220824065058.81051-1-lizhe.67@bytedance.com/T/
v3 patch: https://lore.kernel.org/linux-mm/20220825063102.92307-1-lizhe.67@bytedance.com/T/

[1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 include/linux/page_ext.h                        | 11 +++++++++++
 init/main.c                                     |  6 +++++-
 mm/page_alloc.c                                 |  2 ++
 mm/page_ext.c                                   |  8 ++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7f30902fda0..4f43fd5b324d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1471,6 +1471,14 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	early_page_ext [KNL] Enforces page_ext initialization to earlier
+			stages so cover more early boot allocations.
+			Please note that as side effect some optimizations
+			might be disabled to achieve that (e.g. parallelized
+			memory initialization is disabled) so the boot process
+			might take longer, especially on systems with a lot of
+			memory. Available with CONFIG_PAGE_EXTENSION=y.
+
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1e087f..884282a7f03a 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -36,9 +36,15 @@ struct page_ext {
 	unsigned long flags;
 };
 
+extern bool early_page_ext;
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
+static inline bool early_page_ext_enabled(void)
+{
+	return early_page_ext;
+}
+
 #ifdef CONFIG_SPARSEMEM
 static inline void page_ext_init_flatmem(void)
 {
@@ -67,6 +73,11 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
+static inline bool early_page_ext_enabled(void)
+{
+	return false;
+}
+
 static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
 {
 }
diff --git a/init/main.c b/init/main.c
index 91642a4e69be..b5e75f3288d7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -849,6 +849,9 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
+	/* Should be run after vmap initialization */
+	if (early_page_ext_enabled())
+		page_ext_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
@@ -1606,7 +1609,8 @@ static noinline void __init kernel_init_freeable(void)
 	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
-	page_ext_init();
+	if (!early_page_ext_enabled())
+		page_ext_init();
 
 	do_basic_setup();
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..e2faa52cd05d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -482,6 +482,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 {
 	static unsigned long prev_end_pfn, nr_initialised;
 
+	if (early_page_ext_enabled())
+		return false;
 	/*
 	 * prev_end_pfn static that contains the end of previous zone
 	 * No need to protect because called very early in boot before smp_init.
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d7ac29..6c28d623d951 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -85,6 +85,14 @@ unsigned long page_ext_size = sizeof(struct page_ext);
 
 static unsigned long total_usage;
 
+bool early_page_ext __meminitdata;
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
-- 
2.20.1

