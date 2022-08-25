Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F105A08DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiHYGbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:31:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E29DB5D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:31:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so7985069pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OWcpDS3y0WzhcfF5raQouDMQPAkhS16J5NV4eoiKDsQ=;
        b=WqFbHTP4BGdjc26PDYuuMeCvolj2BrklFCImw6aTmhTFFITU+gjOLWY5pkAhh+7lQG
         kL9rvN932+Nb0C6y0o3NfBChJMwhu+xC0tnwevPx00VRXom+a7THOWCJK+TNuhhYAqdy
         kIKDex53XcrrGy+AG/QaAI8PD6qX+A68p5qP8wAmmhOcnHTGL6q16xtHfgO6PmPh+PCw
         zGiJW3SJnQdzvMEtdBityxZ/5KECPl87kuMf4EiNgnPkLLfIL5FdNqHBnvvLErcdQ4oD
         WJqhDVEjH5JPxl92gdvHUzC3YKf/v4ITOacgWudu5zc81QKoDiXknfce5CGnh4WoIOpF
         ag2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OWcpDS3y0WzhcfF5raQouDMQPAkhS16J5NV4eoiKDsQ=;
        b=lEqQOA8/kPKquSc0j6DfLezfO18rG+OO7ykYgzAnUpUoRWuucSrKUTWX8tzlXXNVoN
         Sr7tqvl1gxWMk6Wpvez3hhlFUTGukz5pxQepSBnWGN25BxTZ7YgXZP2xHz+9dDJtPCMZ
         h6MxUf2eDNuMk1jtOz5R0qJglGGSQ6w5YefhuPfV4FBJTF9NROLdS1t2oiMpCEpf4Ewb
         8VRRjBUSVLAedt+drTwqO6wL/eB2QGruqtS5upeVxsv6p3/e7WdMs/pMjNEofSecFqJu
         wxrbSYaav8H3Bbg1QDi8Y1lSHh6h0bekCal8FNYyNTlKznHsCTtyg9vw3VGVr12S+ldU
         MYVg==
X-Gm-Message-State: ACgBeo0yyqxmLsJqq6jgLVhxA59+8kC9QTutmxJZE8ku4EiolQCmVENh
        pykoK0oDUtNcKS19IYMxa1oAiQ==
X-Google-Smtp-Source: AA6agR4vxV+bi3X4AQEc5eY9u8Qvekg1e8gDjihGISwHEUpL5vYhjFWWSgfegJ3ExdxawaJjyUDDmw==
X-Received: by 2002:a63:1e5c:0:b0:41d:b225:9ee1 with SMTP id p28-20020a631e5c000000b0041db2259ee1mr2036452pgm.245.1661409078008;
        Wed, 24 Aug 2022 23:31:18 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id f184-20020a6238c1000000b00536b3fe1300sm7563032pfa.13.2022.08.24.23.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:31:17 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        mhiramat@kernel.org, keescook@chromium.org, Jason@zx2c4.com,
        mark-pk.tsai@mediatek.com, rostedt@goodmis.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com, yuanzhu@bytedance.com,
        lizhe.67@bytedance.com
Subject: [PATCH v3] page_ext: introduce boot parameter 'early_page_ext'
Date:   Thu, 25 Aug 2022 14:31:02 +0800
Message-Id: <20220825063102.92307-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
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

v2->v3:
- make adjustments suggested by Michal Hocko

v1 patch: https://lore.kernel.org/lkml/Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz/T/
v2 patch: https://lore.kernel.org/lkml/20220824065058.81051-1-lizhe.67@bytedance.com/T/

[1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 include/linux/page_ext.h                        | 11 +++++++++++
 init/main.c                                     |  6 +++++-
 mm/page_alloc.c                                 |  2 ++
 mm/page_ext.c                                   | 12 ++++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

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
index fabb2e1e087f..68d690649234 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -36,9 +36,15 @@ struct page_ext {
 	unsigned long flags;
 };
 
+extern bool early_page_ext;
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
+static inline bool early_page_ext_enable(void)
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
 
+static inline bool early_page_ext_enable(void)
+{
+	return false;
+}
+
 static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
 {
 }
diff --git a/init/main.c b/init/main.c
index 91642a4e69be..d95edb67a499 100644
--- a/init/main.c
+++ b/init/main.c
@@ -849,6 +849,9 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
+	/* Should be run after vmap initialization */
+	if (early_page_ext_enable())
+		page_ext_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
@@ -1606,7 +1609,8 @@ static noinline void __init kernel_init_freeable(void)
 	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
-	page_ext_init();
+	if (!early_page_ext_enable())
+		page_ext_init();
 
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
index 3dc715d7ac29..bf4f2a12d7dc 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -85,6 +85,18 @@ unsigned long page_ext_size = sizeof(struct page_ext);
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+bool early_page_ext __meminitdata;
+#else
+bool early_page_ext __meminitdata = true;
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
-- 
2.20.1

