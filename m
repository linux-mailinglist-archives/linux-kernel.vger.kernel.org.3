Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B435A9E37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiIARiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiIARgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82C9A9FE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dc888dc62so234887347b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=BJfct7EED8CP836t+WrOyNhtwjRjF3r9ZgkUbpnfoug=;
        b=eEZ4BqXkAmPCIUFHBPa2tHlcApvv3HMidc3eCYWOXuAzHrpAN0HS0lhYeZxby9RzBR
         0w6QoRpV+iKQz37VUGml6Y4ETbNA7OPStJ8QApy5HYv7GzeLDO7+EvEq5dUOIcaM6UVC
         7rLgM8Qnok81T8RLLnPTDqNW3fzyiOCIgOk9erIOBMCvX1CoI/RbBp7yoBH88B/Pqkwt
         H8ojE/1F974lnPVAUpGISzyJjuOBuorgNT9VfkfOyqVqOEVMNKxpaqT01PsyXu4rsbpt
         stRow1K+x3Cpkks4NKMTKIZbGi9T2v1db4rNZMcbp4CaDTkAzPc4JsqrDHDLe5K5oO1C
         a6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=BJfct7EED8CP836t+WrOyNhtwjRjF3r9ZgkUbpnfoug=;
        b=WE6lNI/69d0HM7gp0xQnYa5aUMIH8gBwWzlwEwJdlB4hqNPW0uLL1ZbdQEzSR/vRnV
         rZVmJoEXOgHMisXTlzTbv7ZgOb1bu8fa4yh35v4ZE13KnT8Fbaver6MeZcihhoceGp5a
         QURe+J8H7bwSj3MjQJXiWiONm1C6JcSUKU1CnjREMvJDu6gOgx4Qs9bXwYtoIslX5P1p
         /VUAsEQjFpcgJ/h5cHCzfG1IfJPqDabV7G5OdOTZDG2hKCV04pm5Jgf8lScOEQd0bB6u
         Gsiga2xVoy6EV7uncu5mcvdkvWAQF6MhggIlrpSJaeYsN2qniQ0d5dc9v3QUt4GiHKZB
         3D1A==
X-Gm-Message-State: ACgBeo3b4oyDFS1CJuDKudKas98FWhTeV6gzzWgbiS72qAk9QT6t5Gn5
        6cWVzHoDT1TzMw56F9umMoCF1OdGaH0=
X-Google-Smtp-Source: AA6agR7n//3fxGZjvfyML08bNSpeGfau+aTgkZu5QxUJzLJc9oUWAiawZA1UWbNFrnWa2xxdQVaE06YdPF8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a05:6902:18c:b0:695:9d04:c3e with SMTP id
 t12-20020a056902018c00b006959d040c3emr19907526ybh.58.1662053776523; Thu, 01
 Sep 2022 10:36:16 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:09 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-22-surenb@google.com>
Subject: [RFC PATCH RESEND 21/28] mm: introduce find_and_lock_anon_vma to be
 used from arch-specific code
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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
2.37.2.789.g6183377224-goog

