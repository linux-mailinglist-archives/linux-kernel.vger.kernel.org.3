Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E5A562B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiH2V1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiH2V1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:07 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB49F0DA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:19 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b005358eeebf49so3609848pfa.17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=3FeDd/uESQnEyJqRWNnPK+iT++ObIkcBX2+m7Yxyetk=;
        b=WuXmy7spYby6FKlYZxVkneAX6CYLeedEW25AaCdm5U/xwDtXPaTsukbnW+BREr3wmK
         Yp+DdB6epKs/SB7JvycD5yPQfOWs3SBJlayjVM1bzBPF4xDdscUUlmQ491HoasCmixWz
         EDQApyvlKJ0m9j6IZ5Bl5eAvYAMUvQ5PzTt+MmJPi2OMUuj7wlttfCVr1jtd4buEfno/
         mHPpjk9OptKM0QuTB8OPa5JPYvPxCHU8q8PlG/PC9yFoVmLZ3eeWZBp1XntU6iG84/rA
         BgcQG1UC8Z471LrYLx/b3SNnNzdfHV9f4k2uE0RZvNOL2F/Wod5mOLtISQc7G5F1GR1Y
         7dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3FeDd/uESQnEyJqRWNnPK+iT++ObIkcBX2+m7Yxyetk=;
        b=dY/pvieqME8M6CCzMo8hHMq7UMxLZQz+RzdFj3I9WPsEKkTL2pBTpuNCHOtykGYKoF
         9he7Q7AfIWt82nXkScTsr75fPHfpK2fCfyGSWnSrv+Laoudi1gs8/YVsCiIqABOXguH9
         kGab+DKH0iMqPmgE/qMwIZ8TPiAKkkCwhNjV9+b41E4F2QkfaTxdxASjDAO9XPxbZuAc
         PhzATRSSFiJoIiADifggCgmhI7dvCXWgg4p+8DIPFjF17WdnaQAlwOWuqBn6dxZrgBLw
         0bER5sC8eH38bp8WDDNtj13hvcSmdYv0V1f1kuQcQ0StgCCcrZxOL7eR09fl27Uns8+8
         5VRg==
X-Gm-Message-State: ACgBeo3VhfVFg8TL4yf7UsxbKF8+2ViNxobEb6lUPLxuZ0KGcsbj5Q5T
        FpHq09vUWa2HlnXbvmW0uc7DkmZxwSc=
X-Google-Smtp-Source: AA6agR65SMIHezE5eUhR7FLJy4sKjKwDRErJ8crUMropZEJrhJg/maBEVhsE6eunhKdLtoV+/pEsLbtUb5g=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a62:b519:0:b0:537:9723:5cf2 with SMTP id
 y25-20020a62b519000000b0053797235cf2mr18436343pfe.15.1661808377917; Mon, 29
 Aug 2022 14:26:17 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:27 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-25-surenb@google.com>
Subject: [RFC PATCH 24/28] arm64/mm: try VMA lock-based page fault handling first
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

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c33f1fad2745..f05ce40ff32b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -525,6 +525,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+#ifdef CONFIG_PER_VMA_LOCK
+	struct vm_area_struct *vma;
+#endif
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -575,6 +578,36 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(mm_flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto lock_mmap;
+
+	vma = find_and_lock_anon_vma(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (!(vma->vm_flags & vm_flags)) {
+		vma_read_unlock(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, addr & PAGE_MASK,
+				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
+	vma_read_unlock(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -618,6 +651,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	}
 	mmap_read_unlock(mm);
 
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	/*
 	 * Handle the "normal" (no error) case first.
 	 */
-- 
2.37.2.672.g94769d06f0-goog

