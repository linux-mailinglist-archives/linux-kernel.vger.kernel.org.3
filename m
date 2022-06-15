Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2754C110
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiFOFNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFOFND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75D1AF28
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x5so14456202edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mY5uUzRLIv+qWqAZwhy5rAX2VURsU+HFir0jQmIf+E=;
        b=D4lNg5pGfDC5L7OynUcOtFDfDFXTzP57VRgS54pnNILexTkfY55HZrnfn6ectaXrBG
         A6kLQ0xSTYqyTXCTRn4w0i6Vd+v4HUbV41jbNegFNpfszNUe+dh6NLxvb6Oo90niEEQs
         REaa69GMCIA3rdKcMnKcOIKt5/wUCkOT1Nr4VCeJ6GE683gOM99eGYLgE7RxUctHEo3+
         yGIiz+uujjS8SDgXQdiwjcfxhRGpBAQQY7IwV5YHA9F647FYEXbYtStm/OXXcmBUkjz4
         bpqE4qdjs/rJTME5S8IySJ1j9e4a2Lv/G7a9Kc1e8D7hqYVpeWyIiNem5oGdbXc9s6yr
         0Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mY5uUzRLIv+qWqAZwhy5rAX2VURsU+HFir0jQmIf+E=;
        b=sjES2+TE7CAXrp+L5ZGgSSFC6+65NmYIjaPX/DZGGdI2twsnDNtyk0haNc2CaltIsG
         7845vh6A1esdAK+nmZ5TYKkgni1ajMd0f6bp1H64tgvtvv7enu9yJYzkBtv1WESYpCGd
         RkL133aKxQwQtU9PWHuOvCtfOUtroq9Ws20CebguhsypdJlqA736fGiAuHHthbgLqmHF
         Dt8Mu7hqHsGPFwNSjNVsj/HBAfXq6CMANvnf7iVP0PE7XQa8rULI6vCfhNRybCNf79qx
         Ft/Ow7ZRpYECr38BhZcHiIEt/bERRVAlro68Ms40D3Q7OLM+qDtzZcfv3ur1vTALIYUN
         tNSA==
X-Gm-Message-State: AOAM532EGVPZAWBN5MipZmZqx+shK2KMyyxtBQOUPyNgcQbl8QS+4iBp
        wnue7L9Wjyzd+NfZerNVtIE=
X-Google-Smtp-Source: ABdhPJxhYMFkCRk/jQsGMOehbltcc94Zq3y+ix+ulVfAnwPWazD5hPAfvsW2FGORfYxdxXRqti07vg==
X-Received: by 2002:a05:6402:60d:b0:42f:ac38:af75 with SMTP id n13-20020a056402060d00b0042fac38af75mr10100824edv.203.1655269981157;
        Tue, 14 Jun 2022 22:13:01 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b006feb6dee4absm5838034ejj.137.2022.06.14.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:13:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] highmem: Make kunmap_{local,atomic}() take pointers to const void
Date:   Wed, 15 Jun 2022 07:12:56 +0200
Message-Id: <20220615051256.31466-1-fmdefrancesco@gmail.com>
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

kunmap_ {local,atomic}() currently take pointers to void. However, this
is semantically incorrect, since these functions do not change the memory
their arguments point to.

Therefore, make this semantics explicit by modifying the
kunmap_{local,atomic}() prototypes to take pointers to const void.

As side effects, compilers will likely produce more efficient code and
they won't any longer need casts to pointers to void where these functions
take arguments of type pointer to const void.

Suggested-by: David Sterba <dsterba@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Change the commit message to clearly explain why these functions
should require pointers to const void. The fundamental argument behind the
commit message changes is semantic correctness. Other bonuses come as side
effects. Obviously there are no changes to the code. 

Many thanks to David Sterba and Ira Weiny for suggestions and reviews.

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

