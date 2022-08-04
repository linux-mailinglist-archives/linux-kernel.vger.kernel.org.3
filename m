Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEF5897F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiHDGzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiHDGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:55:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189F6469
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:55:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j17so2819442pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GuVM7gKhQND8I7y9IPoXxEMzzZslmNdwtV7SuQsxHVU=;
        b=5HDQrH59USeGPDJOHElvyJo52weo6SvT/vGhzU3vJwuqaGJbTNVR9h+qV63D7vGNgl
         4HBbm3Sg67rSbr3uhMavl0eZ7BgJ9IgWtgfiKSoM8JrOOZpwFxTg2mWeDWbubJRnqD1t
         RaXX1ohgk0DSq2JpwcQEx3/WOqzkKgSOYIKJD39RLOJRyp8La694rhm4EGGQp/8sWEsj
         hjZv2G0tm6ebv86j1GSqKT89fc5MwD9+Ky2WZD1YGUf2NfjCmLDbnOHDb9XnuTm1mhYt
         AcAUUMDtdSffLl2wjFDARklK6WLozx9+quwAd5SjtAzpKqKAe1+bCYAZAIp7/LnvdHeF
         7qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GuVM7gKhQND8I7y9IPoXxEMzzZslmNdwtV7SuQsxHVU=;
        b=vYP980Dk5uarFU1Xnn9QqwB83LLOjwh2JcqcJohpkyy4aO3EXPiXPEYq+o8zcLYsJn
         O7EakrpuGCR6wRSlllFPHtMJqkoAkKPt07HN4iFYjmc6dRORP+/kA4vNVI/VhNoPpF6Y
         tfYrDKEmoNw4L64Wiq8ZZJZzxcSKXbOVvNjilaTdFx33SkeSidDrHnYq/FYJTaIkMPI2
         1EoHWuEQCrilbmvrzTc79mGX5V2XR4M98vn8fFo+o01GAweunK3TUMwEufWH53g59Ja8
         d+phiHrAcwEUdjN6rCzFabkbq/5mjH8QjRPHJg4X+CBQ+W6jdmJ6AY3bRZ0Af7fk/iXn
         nSnQ==
X-Gm-Message-State: ACgBeo3/q+ZJBgkneuUgWcxFKrHpcKPPUsC3C7CDLEoSatgmFpGX8khs
        ZsyEBRAbIHr9DmGBCsrWnTRGPQ==
X-Google-Smtp-Source: AA6agR6ZOn1TFy9F+PIK9rHzzfYE08TOonKZG4SmOvcqohSoJiFZYK2oZdcceyGjmbwgEvc+Q/ZE5w==
X-Received: by 2002:a63:5353:0:b0:419:f140:2dae with SMTP id t19-20020a635353000000b00419f1402daemr503806pgl.526.1659596128000;
        Wed, 03 Aug 2022 23:55:28 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id f1-20020a655501000000b0041975999455sm353120pgr.75.2022.08.03.23.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 23:55:27 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, yuanzhu@bytedance.com,
        lizhe.67@bytedance.com
Subject: [RFC] page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n
Date:   Thu,  4 Aug 2022 14:55:15 +0800
Message-Id: <20220804065515.85794-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/page_ext.h | 28 ++++++++++++++++++++++++++--
 init/main.c              |  7 +++++--
 mm/page_ext.c            |  2 +-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1e087f..82ebca63779c 100644
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
@@ -80,6 +100,10 @@ static inline void page_ext_init(void)
 {
 }
 
+static inline void page_ext_init_late(void)
+{
+}
+
 static inline void page_ext_init_flatmem_late(void)
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

