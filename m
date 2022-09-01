Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC35A9E41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiIARiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiIARhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D65A2E7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k126-20020a253d84000000b0068bb342010dso4890646yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2BdbpYN+cfrtXte3gt5P0NOm/DHEryE/xIPhm7Rz1xg=;
        b=VLuZCO0l2heZzbazUktWTHDEraaU4YdHq4KUbShg6HpER9jaDaB5f4y1Bzq/1FTL0k
         Hef4re0Ge4vhRYArZVPVcwZDWlez9FLwBw1PsG7bcW/Kbgpuv9Pp9OJGNf6JnrGh3HSa
         qO0dYIzHK0WtoIREDnu1aZZK8mbeTv1bHWQjDQ3XJuqrg6Mb+eT6a9R2PACl9oYgExkp
         BYTnrJsd86ZN2nyjWVo4xWQ85kSe7EiDolkrvd8eM4uZtObKMsI19IUrWn7JY9Y8YYi6
         3keq2T13Rmwv4h2gxcKkEIlsATye3QMfjNN6OckMSJWRV6GvnHlPAwoTd+EEwFOjiqHw
         hSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2BdbpYN+cfrtXte3gt5P0NOm/DHEryE/xIPhm7Rz1xg=;
        b=B3kW8VNvf9t88xJFvllUJMRXt7GQGML7gowFBuj/Lxd7/vDi/u/szPntjZV12o3Pbm
         w9VRTpTJKpFxUGlR57yePOPaVL4ML7XXNPWr3+gIh3R5v4eYGdU8YN+/+wWJpa16DPXr
         f20ln+NIODjAg9eSO1UY9+sevmWoQmmvGw4TTTrQ8ExfP9MAA93UMKumMg57kzGxyOg6
         UtMIXOIVg0Loq7+bTas12SfaF8FTUCdlHAlil6a5nAALUY/qgo4/1CzBbaTp6DiiySWu
         MMgHU93XjdpEIVuTULulMkLbA33awoT5dffCo6onUNc6q9tjYY7H3Ir9YShCg5s9BMp6
         fljw==
X-Gm-Message-State: ACgBeo3EjDoHSzsn3nbEIKt94ln4iwOshQQN8f7B95+453PxgROblvGz
        p1Gp2PoZwsFVpkFDErlHdPZwzgDKp/A=
X-Google-Smtp-Source: AA6agR4CvVkCfuV2stbCR2feIvgwEhmkbLBkcVFIjpWyBvtco7HBu4vzJWRMfUlZ+fh/HitarNYnWQuKjvQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a81:5a56:0:b0:33b:52a8:c360 with SMTP id
 o83-20020a815a56000000b0033b52a8c360mr22687651ywb.329.1662053784110; Thu, 01
 Sep 2022 10:36:24 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:12 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-25-surenb@google.com>
Subject: [RFC PATCH RESEND 24/28] arm64/mm: try VMA lock-based page fault
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
2.37.2.789.g6183377224-goog

