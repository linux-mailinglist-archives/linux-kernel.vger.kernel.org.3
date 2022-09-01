Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29395A9E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiIARjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiIARhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E939C2E8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w63-20020a25c742000000b006960ac89fedso4938117ybe.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=GxTYNSy2f61J0vFNTG2PuheznwcSGYj4QW8UtE2cKCs=;
        b=kyDYAAajD8Ict5/thoW7CTIWmHJF9O2tLJRCa3mFAvG6icZFINT6cR9wp1PVCpk34d
         ZW6ubLRV3shjslvaFAJXlbBGTzPKjvgVDQeukMqdqtwYsjBpj2zHvD901sTZUMPhJtXT
         2ltqU4ShN/OuGiFl+1aMyLRwy+OC1Eq/JzpPgbsdEFfqg/fH8TS912PoVzzOgyXwQY4c
         Neb0lZJutieMXKVcpmbRLxmWRs14AnetVBjrLGSATrWD8Sx1+eyAMSMAZjNqX2Pwkr4/
         vSA7Eawe2WnSKfYYTXdrBr34gwdU8C4wAuI9C4koFQPreF/LzpOWpEs87ZTSq2ciWD6Q
         PcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=GxTYNSy2f61J0vFNTG2PuheznwcSGYj4QW8UtE2cKCs=;
        b=f1AooCiLreBMkEj4kLvyJe1V6IsMPk2kh7GltQP4miNM+ZYvnLQDSeRdkFAfD0BRei
         OUC/Tx+VLU+5rppFxa/dO73yhgsSU28eWyOYHYz4a/w4KNOXZGySg+3GXfwkOYYiyFJD
         4k3l9FIjUyue7/mEte2EIhZfZSpKXgvihBPtXvZpzJPYPQAw7LVR7lDEVlt4j6TVvFuF
         uzx504S2T13fr6WjWO2/4s6srmfXNI/7k41YNKAZOLVZ6vx1QKVrOFjs48XC2+C9RnH4
         9/uOoyZz0ffF6oSDDKbmvWy9h1pCudyHABIsgJqkJLnmkVB5M7WiQ7xyRfVh/Xb6fiM2
         gbGg==
X-Gm-Message-State: ACgBeo04B1hvlbPNJQBX5D2cgFylJE0nPF9nN9ZPU1iKtW7EK9jyWhSK
        WBfX+a/iIgYDBv4/Dw0P/Y+h3ho1wZA=
X-Google-Smtp-Source: AA6agR7h/HXbYJenfJy6WhKZaSvOltpWgwSfG3A/YQRl84q3AZw84By7flMTVszUCEhzYjvcGJ4xQ/dizwg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a81:650a:0:b0:33c:f030:7e9f with SMTP id
 z10-20020a81650a000000b0033cf0307e9fmr23813234ywb.16.1662053789340; Thu, 01
 Sep 2022 10:36:29 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:14 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-27-surenb@google.com>
Subject: [RFC PATCH RESEND 26/28] powerc/mm: try VMA lock-based page fault
 handling first
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

From: Laurent Dufour <ldufour@linux.ibm.com>

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.
Copied from "x86/mm: try VMA lock-based page fault handling first"

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/mm/fault.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 014005428687..c92bdfcd1796 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -450,6 +450,44 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto lock_mmap;
+
+	vma = find_and_lock_anon_vma(mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				       (error_code & DSISR_KEYFAULT), vma))) {
+		int rc = bad_access_pkey(regs, address, vma);
+
+		vma_read_unlock(vma);
+		return rc;
+	}
+
+	if (unlikely(access_error(is_write, is_exec, vma))) {
+		int rc = bad_access(regs, address);
+
+		vma_read_unlock(vma);
+		return rc;
+	}
+
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
+	vma_read_unlock(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -526,6 +564,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	mmap_read_unlock(current->mm);
 
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
-- 
2.37.2.789.g6183377224-goog

