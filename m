Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90D54B30F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiFNOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiFNOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:25:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B72D1D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:25:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w27so11887537edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFomLMEva8Yh4yV7wX36S+lJqBHeHMxTg006+cmh2Z8=;
        b=mxM5NEaugV7fe4nEdzlMb+Uz9n7BEnJEzZS0XDietw/N1OfzfHjr+LYmfctn59vimo
         IO572jNAs/bdkhv140kEW/d0CG2SqaVbsr6sTEfB8sUecNAl93Fmi/C7XqFOA2KXCkDi
         nFsj3T0CZRzT7XA09BQDLTrBWOONoVsVHIB0ZzsVqnawu9pzCs/X0LfrpNCGzfJzfU4q
         BUYqEcY7q1cZ9qOYnX6QzR4wVMfLDh9AxzAPDfoFDm/koCSiYzBDiZWmQntJ+VSRadkJ
         p6HL59Com6yngVC3zy9Q0qjMzZ50CygY8DNVwdk7rnPrDaMect7ebtL1ltP5aaNx8Zyn
         ElWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFomLMEva8Yh4yV7wX36S+lJqBHeHMxTg006+cmh2Z8=;
        b=Dh+dnPBMaJpO4INqk2hO3d/OQQbTlL7G0a2SbfnXDR8jQ0kaG69W7mWhMB2N48vUKq
         Xi11eddlimvtuZOixKqOUrZCuM1teFyO4r/1+9OlCMrtD6V73Uw/m6hkRsTLr4zvgAY+
         2I3PXbXuzBxmaS8skv/OYaG9Ri2K6YzdtTVDfvV2oZgCr4zagNIcVTHPGA9YpkFSZ+z/
         6VezBaJleuoDJGvBeoHd1xCobrx9xILAnkaw5UQWagkK+jVhwa8L1QUjeFsMBO4FG+ah
         oJXKN4/IQaI7/ThhtqRsZJn9w3175garffU+hx5h7yczMxn4F13iqJ+NGt/JfveJkWkU
         4gKg==
X-Gm-Message-State: AOAM531VDbWHgMz/R8oJT6qREszWAW4/X9b+UfH1sQc9ZKR1BCgaxbPC
        hhj7C9dTNheQNs5Q+s7yGeQ=
X-Google-Smtp-Source: AGRyM1uYmiaaVKSUmqQbKzqcMKqaXq80W7r5EdGI0fz07u86SzupJAchOxdIkz240JOibvq0lNt0VA==
X-Received: by 2002:aa7:da50:0:b0:42d:cdc8:8751 with SMTP id w16-20020aa7da50000000b0042dcdc88751mr6547181eds.19.1655216735712;
        Tue, 14 Jun 2022 07:25:35 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id ss19-20020a170907039300b006febde6d771sm5093401ejb.160.2022.06.14.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:25:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: [PATCH] highmem: Make __kunmap_{local,atomic}() take "const void *"
Date:   Tue, 14 Jun 2022 16:25:31 +0200
Message-Id: <20220614142531.16478-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes __kunmap_{local,atomic}() should take pointers to const void.
Currently their prototypes take pointers to void, therefore compilations
break in cases like the above-mentioned.

This is the output of GCC-12 when it encounters one those cases:

./linux/fs/btrfs/zstd.c:547:33: warning: passing
argument 1 of '__kunmap_local' discards 'const' qualifier from pointer
target type [-Wdiscarded-qualifiers]
  547 |   kunmap_local(workspace->in_buf.src);
      |                ~~~~~~~~~~~~~~~~~^~~~
./linux/include/linux/highmem-internal.h:284:17:
note: in definition of macro 'kunmap_local'
  284 |  __kunmap_local(__addr);     \
      |                 ^~~~~~
./linux/include/linux/highmem-internal.h:92:41:
note: expected 'void *' but argument is of type 'const void *'
   92 | static inline void __kunmap_local(void *vaddr)
      |                                   ~~~~~~^~~~~

Make __kunmap_{local,atomic}() take pointers to const void.

Suggested-by: David Sterba <dsterba@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem-internal.h | 10 +++++-----
 mm/highmem.c                     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index cddb42ff0473..034b1106d022 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_KMAP_LOCAL
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
-void kunmap_local_indexed(void *vaddr);
+void kunmap_local_indexed(const void *vaddr);
 void kmap_local_fork(struct task_struct *tsk);
 void __kmap_local_sched_out(void);
 void __kmap_local_sched_in(void);
@@ -89,7 +89,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
 	return __kmap_local_pfn_prot(pfn, kmap_prot);
 }
 
-static inline void __kunmap_local(void *vaddr)
+static inline void __kunmap_local(const void *vaddr)
 {
 	kunmap_local_indexed(vaddr);
 }
@@ -121,7 +121,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
 	return __kmap_local_pfn_prot(pfn, kmap_prot);
 }
 
-static inline void __kunmap_atomic(void *addr)
+static inline void __kunmap_atomic(const void *addr)
 {
 	kunmap_local_indexed(addr);
 	pagefault_enable();
@@ -197,7 +197,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
 	return kmap_local_page(pfn_to_page(pfn));
 }
 
-static inline void __kunmap_local(void *addr)
+static inline void __kunmap_local(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
@@ -224,7 +224,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
 	return kmap_atomic(pfn_to_page(pfn));
 }
 
-static inline void __kunmap_atomic(void *addr)
+static inline void __kunmap_atomic(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
diff --git a/mm/highmem.c b/mm/highmem.c
index 1a692997fac4..e32083e4ce0d 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -561,7 +561,7 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
 }
 EXPORT_SYMBOL(__kmap_local_page_prot);
 
-void kunmap_local_indexed(void *vaddr)
+void kunmap_local_indexed(const void *vaddr)
 {
 	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
 	pte_t *kmap_pte;
-- 
2.36.1

