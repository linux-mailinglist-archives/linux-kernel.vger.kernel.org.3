Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8745A5631
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiH2V2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH2V1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDE7268E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 200-20020a6217d1000000b00538090d37f3so2068608pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=TAH5MnJT3oUowhISL8bra7V0NlPN+Gm7GlObU5EM5DA=;
        b=WI+iAkKYdp/dw+q+sE6vVFwD5mLSWBWMhRHboF9Ttbardy/unLndkxHVrzFVqulr1A
         yPcJLa3Ur0z+PJer1B1IamGoCGgxEpMLeAxgWf9CgasGK7cypr9FW+usqow4Tv90c3k6
         hSoUgkPn+GgzurgQcPzRD2rwA/PJHxIAlhRbX6toXLNmtMd1EOWFLhXluJKlLDk1UBbT
         O0I6rKmCm2uwsJ4JnyJZiGAk3wWQ6Qh6RctA9jkOKMvzLM+0NSmJ3ovBUaPQyVoGm6YI
         JXf6mvqPKdqWiUAL/+XE2dov1V39lipJcNcZcI/t4fYcyAX1GpBk//UErawM2Q1iWoKr
         uzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TAH5MnJT3oUowhISL8bra7V0NlPN+Gm7GlObU5EM5DA=;
        b=FnnfvDCIBw0zjAyK4HDilGoC17RsYobiWHfAB7/kGxrNb+dprDONboH34M13fL2Mhp
         +uAkd40/wbODIgpllCUcSFg2IBArmdL+dhNNA/aP8QXFN8sA6mir0Syr1AFN/f91jUcu
         yFL//kic3MAWDXIhiAjc+B/UUwJTQK7bEXIZoI7f8GYohFF3FrDqXRxqEJGiCluQIEMF
         1zKJ3PDT1ayA/6i0eGC8ZyZtKD3/MbgL5qGrfRa35M5Bh2TmUTyYvOwRAUUxXHqX+4QN
         lznlANGwjkbsh4XnDDWu3Q6q5HidDGCZG7qx5yN3JCJXRTdIzdAlqMaJYJp+O2IrySLQ
         1s7Q==
X-Gm-Message-State: ACgBeo1DjhYQBSIGsbwCw0i7qQ0aesyfeoDDbb4PPPlwKtP6HxL5UxS9
        m3vNVACiYGKbWS62RK2y8NdixM/fXzw=
X-Google-Smtp-Source: AA6agR5aic644PZ0OuL1YK8O5lnv8GmzPsmAclgLgLZvZKPuRUB75AtHpFEjRVbtgx264YmpiRiioO9wBJc=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr21187pje.0.1661808373054; Mon, 29 Aug
 2022 14:26:13 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:24 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-22-surenb@google.com>
Subject: [RFC PATCH 21/28] mm: introduce find_and_lock_anon_vma to be used
 from arch-specific code
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce find_and_lock_anon_vma function to lookup and lock an anonymous
VMA during page fault handling. When VMA is not found, can't be locked
or changes after being locked, the function returns NULL. The lookup is
performed under RCU protection to prevent the found VMA from being
destroyed before the VMA lock is acquired. VMA lock statistics are
updated according to the results.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c3190eaabd7..a3cbaa7b9119 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -684,6 +684,9 @@ static inline void vma_assert_no_reader(struct vm_area_struct *vma)
 		      vma);
 }
 
+struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
+					      unsigned long address);
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index 29d2f49f922a..bf557f7056de 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5183,6 +5183,51 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline struct vm_area_struct *find_vma_under_rcu(struct mm_struct *mm,
+							unsigned long address)
+{
+	struct vm_area_struct *vma = __find_vma(mm, address);
+
+	if (!vma || vma->vm_start > address)
+		return NULL;
+
+	if (!vma_is_anonymous(vma))
+		return NULL;
+
+	if (!vma_read_trylock(vma)) {
+		count_vm_vma_lock_event(VMA_LOCK_ABORT);
+		return NULL;
+	}
+
+	/* Check if the VMA got isolated after we found it */
+	if (RB_EMPTY_NODE(&vma->vm_rb)) {
+		vma_read_unlock(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
+		return NULL;
+	}
+
+	return vma;
+}
+
+/*
+ * Lookup and lock and anonymous VMA. Returned VMA is guaranteed to be stable
+ * and not isolated. If the VMA is not found of is being modified the function
+ * returns NULL.
+ */
+struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
+					      unsigned long address)
+{
+	struct vm_area_struct *vma;
+
+	rcu_read_lock();
+	vma = find_vma_under_rcu(mm, address);
+	rcu_read_unlock();
+
+	return vma;
+}
+#endif /* CONFIG_PER_VMA_LOCK */
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
-- 
2.37.2.672.g94769d06f0-goog

