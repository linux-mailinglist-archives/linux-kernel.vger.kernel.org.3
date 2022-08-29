Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C65A562D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH2V2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiH2V1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F59F1B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k62-20020a638441000000b0042b66a99b6aso4565641pgd.18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=o1aoXsAZRKWKp3E60vO3aTfa7LhhJu+wloCiW42SL3o=;
        b=hVadOQBIf7hIcCCPF4k/V8ishbMycFmV23IYK2/L+oJFUn4snhEXCB8nhiJ0XvBmGq
         IPVx7m/qpumur19aTHX425elTvPhBwnAWLq2eu14tCxMYLfyVDPtnXMD7eRtBYdE8ib6
         g6FY2QFmIprsXVeiDN0/TJA6z8yPl6Ga6H+AU+5BAz5wvK9q2eG8K6M5/G5IT26iqvDR
         sF5KQOom085C4/LO0v/IjmuRTEiouanpvkUJ/WwC7Eqe/f3fgCYq7VPZ9r9nrS+kR+CY
         ydqosByt6O340qUe8wv/4Yn0djwvN5x2tceHdnG95lN+D/X9zA9TkMcItH0K4FkMtDqG
         cLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=o1aoXsAZRKWKp3E60vO3aTfa7LhhJu+wloCiW42SL3o=;
        b=v6A9chmvQp+ELHi2dDyqGF4FtldW0N0uyu1UnHDbGszi390jX54OufIbIfhbff+/bT
         2irXbMdwo8OrusGu5hFXsWkgHhdRa0TW272BNHsBdmD6uarIOfOLZqloCotWaZ0Iowjh
         H8Y/C5AiUZqZkF//lkR052QjnStLuGj51usJiGlp22c6V7aIPLsdWFPqyX+GMjtc2r1z
         sq6c1wMn/FoAkKrPj3ZIxRAo2qejpC5hzVuKVWq4/NRaqxREkG/MP8gwp8AxqQRC/hGz
         e2n8SlJ9//QqQ7M8/BRpTEg8qdrcEGet81tJzrA7vUdCw+H+Vpy/kDPfdbNyAtaxG8OC
         5HhA==
X-Gm-Message-State: ACgBeo2FLzFSSQOOzZU998cKoRkBBWkHpwfjssHVFm6PIPsXFLUll5a1
        1EmmkxT65bdfMOFAaz9YQkfKZTr+x0o=
X-Google-Smtp-Source: AA6agR5CaUs6YJBbyF56NgpgIgB6cgapfFaHPRJdugast+FKzlkUBYXObPd4n8zhAA8UFAnqt1i7b7mpRsg=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:903:41c6:b0:174:3acf:8294 with SMTP id
 u6-20020a17090341c600b001743acf8294mr17683670ple.118.1661808381376; Mon, 29
 Aug 2022 14:26:21 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:29 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-27-surenb@google.com>
Subject: [RFC PATCH 26/28] powerc/mm: try VMA lock-based page fault handling first
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

From: Laurent Dufour <ldufour@linux.ibm.com>

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.
Copied from "x86/mm: try VMA lock-based page fault handling first"

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
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
2.37.2.672.g94769d06f0-goog

