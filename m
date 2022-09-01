Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375DD5A9E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiIARiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiIARhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F585B797
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so4872160ybs.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TUk3GnQXnzjX+dOXwqqLb3j5iouD0aWKTRx7OYILWmo=;
        b=YQqRrP1cOBMmwt/q5otvkRLq5UlRi5nXamV0kPAgq/Llb+F9rrwouZsmTwkjFMW1zs
         mWLW2S110jPh4eYPUbnJWz9aEFHyDND9nIDA90HkjT5HQ91YMufxWCmYs0WU2ooUk8Du
         wzdtu/YDYEQeIpF7CzLVtbR6weBauuj1l4a8qgmBNwRm70UISBCLpd93jjiqNIdE0vgs
         06VcH4KM5paek23OhAbPGd46WTDb6+CqL4Pyf7E1NmlU70RTzjmiFKgXWz0xeqjkJr9W
         NG4J3tGGklDETuONG3YWLZrzk72gi/1u5qstFzrzMP1bg8GyXe5bAXne0/Fv+EFg0xsd
         ouLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TUk3GnQXnzjX+dOXwqqLb3j5iouD0aWKTRx7OYILWmo=;
        b=sw2eOP6ZJ0/aa++mzys4MoIzaGA+r5IuUT6Cdik81GttmKAwUqIo9QrWAOFNAWl7o0
         YM2rc1tV8meCQXCL7qG+swr7M83+8/hRe9y5yei1PuvhCWAiixHRbovMvXZbGP4SlZ9V
         9qHAFMdT4eunBQVLPrRfx1z7Ub1yvVTfEcSjPexAZC3rqW2FUncx7ihUnKAYTudpGzzo
         65CnQgQYkLSkfTS/5a0qtpk9mN5ZGQy46vhA+pNFzWSwolPOyJ1FEnvzqBvaBtcXkb7b
         68jDbqFdzUF3LyZ/qyRToyYpFw0vSpeiksTXquwJElsHzUbIiqZRjQI/kY8XuILup2HE
         A+uw==
X-Gm-Message-State: ACgBeo0bvqAO8aVBmJRMOKJVEGetFeObeZov241n55mwqIdexvv+qPvF
        ESfHdcwrJC/4z8KkYBFxNf2t2iUMlCU=
X-Google-Smtp-Source: AA6agR5HFIn9x2Nfihxx+X7rvP9mQrh+0fzYESFNay7KqUAMxXqLyyvr7HgjmPtUD/1VpOxvT+Ik33q1JvQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:5f10:0:b0:6a3:7eb:762 with SMTP id
 t16-20020a255f10000000b006a307eb0762mr718810ybb.85.1662053778908; Thu, 01 Sep
 2022 10:36:18 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:10 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-23-surenb@google.com>
Subject: [RFC PATCH RESEND 22/28] x86/mm: try VMA lock-based page fault
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

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa71a5d12e87..35e74e3dc2c1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/mm.h>			/* find_and_lock_vma() */
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1323,6 +1324,38 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto lock_mmap;
+
+	vma = find_and_lock_anon_vma(mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (unlikely(access_error(error_code, vma))) {
+		vma_read_unlock(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
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
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
+		return;
+	}
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1423,6 +1456,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
-- 
2.37.2.789.g6183377224-goog

