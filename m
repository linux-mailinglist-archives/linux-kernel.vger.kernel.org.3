Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C171592EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiHOMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHOMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:10:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBCB26117
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:10:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d20so6475646pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OlDX2VDnJXF8DFXTx8IYulTZNrKUDZ/9Y1YnZ/YzQC4=;
        b=lDZ61bhM15Wngv3Bvpqwe7Ilv9QfpUGUgKo1boTWthrF2QgDG+E5j3/uZZcijmb5XQ
         QkiUQ+zW5ZpnCZT9S4YlmE5SqX328yZ9MorMW1j77Vqu1qPdgXxGa892gjy/AUyQo/l8
         tVz4Lg69erHas3S36eVSzsf/lXYA9wvUTuF0EHbaVdjINMnwJpsSrhx7H2NcPaeateV2
         hEQzPQpnI5v3GNlnA9bnXr30E6AkAFxC0By77BuRBvLoxH/BywxqoAx9T3T+diJVribi
         vrvgyQkEi/KMBUteI2nlXzqpliO/j+8DAg8dvSHSjfPfMX78mojznYyRqdXj1BoEkpJY
         TjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OlDX2VDnJXF8DFXTx8IYulTZNrKUDZ/9Y1YnZ/YzQC4=;
        b=SA49zKfG8s0pZ5G6P9MOMOTad0zxuD9Mvq4KEJ+xPCo92UYXNOcSKYxO+qt7VTT9Ev
         IvflvgetuuJCoPh8B2oKmOTH34QHID7Q64mbjUZEyqWovzWOfaHP6ksdmB/DiXHwF1pT
         nTgizvZ1Kujks9iY0QZY2X9m56JxVa4yicluyEzXEYgNnl2ojp/MKA5HHrSS7c+HU0dy
         5/ETjaZavzA0xUAuL1fjSlWa2Zwu47S292vGd6fwcAh3JWjXFoV8j3nEewSveBveKLhF
         /rW3+9u97ehOeCn3ohtF0cjLrP46VvVOp1ZbAoAM45g3E+OJ8uCDXD9BZxVbAQhWlifN
         35RQ==
X-Gm-Message-State: ACgBeo0N4neKmYr3YEQWt19SgPNMA1Vb0cJcda2XDg0eN1R6fNU4In1D
        tGvRY4nxvBj5uRvRU2SnoACahg==
X-Google-Smtp-Source: AA6agR7bBC5JKuBtwgIwIds69ERKbTRvLzHGmp/pKrpijW7/diQ/huZoEWLp758tFQQMw9DoESc1Lw==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr15907837pfu.28.1660565409307;
        Mon, 15 Aug 2022 05:10:09 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id q16-20020aa79830000000b0052d36feb7fcsm6426193pfl.198.2022.08.15.05.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 05:10:09 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org, mhiramat@kernel.org, vbabka@suse.cz,
        keescook@chromium.org, Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, yuanzhu@bytedance.com,
        lizhe.67@bytedance.com
Subject: [PATCH] page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n
Date:   Mon, 15 Aug 2022 20:09:54 +0800
Message-Id: <20220815120954.65957-1-lizhe.67@bytedance.com>
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

This patch move up page_ext_init() to catch early page allocations when
DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
allocations. This is useful especially when we find that the free memory
value is not the same right after different kernel booting.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 include/linux/page_ext.h | 30 +++++++++++++++++++++++++++---
 init/main.c              |  7 +++++--
 mm/page_ext.c            |  2 +-
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1e087f..b77a13689e00 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -43,14 +43,34 @@ extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 static inline void page_ext_init_flatmem(void)
 {
 }
-extern void page_ext_init(void);
 static inline void page_ext_init_flatmem_late(void)
 {
 }
+extern void _page_ext_init(void);
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static inline void page_ext_init_early(void)
+{
+}
+static inline void page_ext_init_late(void)
+{
+	_page_ext_init();
+}
+#else
+static inline void page_ext_init_early(void)
+{
+	_page_ext_init();
+}
+static inline void page_ext_init_late(void)
+{
+}
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 #else
 extern void page_ext_init_flatmem(void);
 extern void page_ext_init_flatmem_late(void);
-static inline void page_ext_init(void)
+static inline void page_ext_init_early(void)
+{
+}
+static inline void page_ext_init_late(void)
 {
 }
 #endif
@@ -76,7 +96,11 @@ static inline struct page_ext *lookup_page_ext(const struct page *page)
 	return NULL;
 }
 
-static inline void page_ext_init(void)
+static inline void page_ext_init_early(void)
+{
+}
+
+static inline void page_ext_init_late(void)
 {
 }
 
diff --git a/init/main.c b/init/main.c
index 91642a4e69be..7f9533ba527d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -845,6 +845,7 @@ static void __init mm_init(void)
 	 * slab is ready so that stack_depot_init() works properly
 	 */
 	page_ext_init_flatmem_late();
+	page_ext_init_early();
 	kmemleak_init();
 	pgtable_init();
 	debug_objects_mem_init();
@@ -1605,8 +1606,10 @@ static noinline void __init kernel_init_freeable(void)
 
 	padata_init();
 	page_alloc_init_late();
-	/* Initialize page ext after all struct pages are initialized. */
-	page_ext_init();
+	/* Initialize page ext after all struct pages are initialized if
+	 * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled
+	 */
+	page_ext_init_late();
 
 	do_basic_setup();
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d7ac29..50419e7349cb 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -378,7 +378,7 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 	return notifier_from_errno(ret);
 }
 
-void __init page_ext_init(void)
+void __init _page_ext_init(void)
 {
 	unsigned long pfn;
 	int nid;
-- 
2.20.1

