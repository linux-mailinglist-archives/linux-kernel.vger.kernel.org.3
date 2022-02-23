Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AB4C0BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiBWF0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiBWFZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:25:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4646D953
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i205-20020a2522d6000000b00622c778ac7cso26758116ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eHvI/S5CbFiuxrTOsf9OKECf8MKQA40+sVHVsgBWXTI=;
        b=V0N2AQ61NCzV6BZmqiQxUYs5pGX63pZ6VVRWlptLLGQUiVMxzlkVsCzNfrYnsMXVug
         KGkm/PYQEu9If/h+TwyTP773A843C1vccvswNpzQzC+CWF0lyH9rv4lYVpwygBHxjjxF
         KtfQ48TD03/CH3MJc6uQdii7U/orjcd6yROvM49vbkxsBatJT7hHIeSSgYOHhBpNRFtZ
         ikDCPeVq4k3/1dGPRt9rMDvqd7qp2qvlw0rdUxHJz6cMzz6PpmzwFKFFGSl65Hota3P/
         hcaYP68KMD05XrecJbTtx+liHxuoMDRkdxyvRDaTUelX+R7q43SiNNrm4qp+y/niXgLp
         +m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eHvI/S5CbFiuxrTOsf9OKECf8MKQA40+sVHVsgBWXTI=;
        b=t/0XFCQpQntOWvt0UpdJ0ZxaqKnq2n+1Hu0sEBqQGyfC14DYrht2kNdgyWC13JJIt9
         iWm+MX2EiL/sfeNFrceTh1afSlfbeKtDSUUjW9j+t0MOeNguuirlUnYuajsXHDMOax2d
         io9DWdS7wy4J7420iGzgT1Lc2IZs3rwopf9x20QTKeyqMXzaq7ki1HL608n92hAhlN+s
         CpRbuN9Air5RKwYm8aXW5u8MhfeD4d3zEZNq1OtSd9aQgx8JJwC8qEtb0I3oQIcmKCPe
         6Foo9GQOwZga5qWxlZYwvb/vx4Mb/K0BUHMjS1Mkiy+CdDslXNuxn0fMG1qzUxLXN7yq
         bjQg==
X-Gm-Message-State: AOAM531ijgeESWaFaNVBySC8+dB077H0FdIRZclQp1XFdBW7anJkLbLr
        te9zd0xC2hEohnjtF3oAxAmChbEuuRL4fua/VBvqKdojroUKDMngCUL37B9A+3FzInbtwOl5BQ4
        p53XlT7haBcpWe24QvxSbdURxBXHpAvB5qNOU+Pv0H5dYLKK2/dp8XcBKK12ppjPGNmXTuzgX
X-Google-Smtp-Source: ABdhPJylISnqnK8ITQ9nblGksWK/PwAayD9axmVlFF61BCPqFWoHn9afvvtl0MNwA3JR60UblOXBCmfjIzzy
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a81:7951:0:b0:2d6:b7bf:216a with SMTP id
 u78-20020a817951000000b002d6b7bf216amr24436525ywc.258.1645593874907; Tue, 22
 Feb 2022 21:24:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:21:58 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-23-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 22/47] mm: asi: Added refcounting when initilizing an asi
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Weisse <oweisse@google.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        alexandre.chartre@oracle.com, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Weisse <oweisse@google.com>

Some KVM tests initilize multiple VMs in a single process. For these
cases, we want to suppurt multiple callse to asi_init() before a single
asi_destroy is called. We want the initilization to happen exactly once.
IF asi_destroy() is called, release the resources only if the counter
reached zero. In our current implementation, asi's are tied to
a specific mm. This may change in a future implementation. In which
case, the mutex for the refcounting will need to move to struct asi.

Signed-off-by: Ofir Weisse <oweisse@google.com>


---
 arch/x86/include/asm/asi.h |  1 +
 arch/x86/mm/asi.c          | 52 +++++++++++++++++++++++++++++++++-----
 include/linux/mm_types.h   |  2 ++
 kernel/fork.c              |  3 +++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index e3cbf6d8801e..2dc465f78bcc 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -40,6 +40,7 @@ struct asi {
 	pgd_t *pgd;
 	struct asi_class *class;
 	struct mm_struct *mm;
+        int64_t asi_ref_count;
 };
 
 DECLARE_PER_CPU_ALIGNED(struct asi_state, asi_cpu_state);
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 91e5ff1224ff..ac35323193a3 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -282,9 +282,25 @@ static int __init asi_global_init(void)
 }
 subsys_initcall(asi_global_init)
 
+/* We're assuming we hold mm->asi_init_lock */
+static void __asi_destroy(struct asi *asi)
+{
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return;
+
+        /* If refcount is non-zero, it means asi_init() was called multiple
+         * times. We free the asi pgd only when the last VM is destroyed. */
+        if (--(asi->asi_ref_count) > 0)
+                return;
+
+	asi_free_pgd(asi);
+	memset(asi, 0, sizeof(struct asi));
+}
+
 int asi_init(struct mm_struct *mm, int asi_index, struct asi **out_asi)
 {
-	struct asi *asi = &mm->asi[asi_index];
+        int err = 0;
+        struct asi *asi = &mm->asi[asi_index];
 
 	*out_asi = NULL;
 
@@ -295,6 +311,15 @@ int asi_init(struct mm_struct *mm, int asi_index, struct asi **out_asi)
 	WARN_ON(asi_index == 0 || asi_index >= ASI_MAX_NUM);
 	WARN_ON(asi->pgd != NULL);
 
+        /* Currently, mm and asi structs are conceptually tied together. In
+         * future implementations an asi object might be unrelated to a specicic
+         * mm. In that future implementation - the mutex will have to be inside
+         * asi. */
+	mutex_lock(&mm->asi_init_lock);
+
+        if (asi->asi_ref_count++ > 0)
+                goto exit_unlock; /* err is 0 */
+
 	/*
 	 * For now, we allocate 2 pages to avoid any potential problems with
 	 * KPTI code. This won't be needed once KPTI is folded into the ASI
@@ -302,8 +327,10 @@ int asi_init(struct mm_struct *mm, int asi_index, struct asi **out_asi)
 	 */
 	asi->pgd = (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
 					     PGD_ALLOCATION_ORDER);
-	if (!asi->pgd)
-		return -ENOMEM;
+	if (!asi->pgd) {
+                err = -ENOMEM;
+		goto exit_unlock;
+        }
 
 	asi->class = &asi_class[asi_index];
 	asi->mm = mm;
@@ -328,19 +355,30 @@ int asi_init(struct mm_struct *mm, int asi_index, struct asi **out_asi)
 			set_pgd(asi->pgd + i, asi_global_nonsensitive_pgd[i]);
 	}
 
-	*out_asi = asi;
+exit_unlock:
+	if (err)
+		__asi_destroy(asi);
 
-	return 0;
+        /* This unlock signals future asi_init() callers that we finished. */
+	mutex_unlock(&mm->asi_init_lock);
+
+	if (!err)
+		*out_asi = asi;
+	return err;
 }
 EXPORT_SYMBOL_GPL(asi_init);
 
 void asi_destroy(struct asi *asi)
 {
+        struct mm_struct *mm;
+
 	if (!boot_cpu_has(X86_FEATURE_ASI) || !asi)
 		return;
 
-	asi_free_pgd(asi);
-	memset(asi, 0, sizeof(struct asi));
+        mm = asi->mm;
+        mutex_lock(&mm->asi_init_lock);
+        __asi_destroy(asi);
+        mutex_unlock(&mm->asi_init_lock);
 }
 EXPORT_SYMBOL_GPL(asi_destroy);
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f9702d070975..e6980ae31323 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -16,6 +16,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/mutex.h>
 
 #include <asm/mmu.h>
 #include <asm/asi.h>
@@ -628,6 +629,7 @@ struct mm_struct {
                  * these resources for every mm in the system, we expect that
                  * only VM mm's will have this flag set. */
 		bool asi_enabled;
+                struct mutex asi_init_lock;
 #endif
 		struct user_namespace *user_ns;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index dd5a86e913ea..68b3aeab55ac 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1084,6 +1084,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 
 	mm->user_ns = get_user_ns(user_ns);
 
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+        mutex_init(&mm->asi_init_lock);
+#endif
 	return mm;
 
 fail_noasi:
-- 
2.35.1.473.g83b2b277ed-goog

