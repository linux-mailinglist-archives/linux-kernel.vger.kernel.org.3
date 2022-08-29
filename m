Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDF5A562C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiH2V15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiH2V1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D8979F0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t13-20020a170902e84d00b00174b03be629so3066595plg.16
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=plnLK4otWaGxR+W8sd3fBxFm06LW87+WFj6YX7JmKJI=;
        b=O7Fq7HWZ7z8n2j/HcxIFYSMFkVCbPksq++2+VIS66vXRQwbI7dU8JTklRI8MPiby2e
         edzsUySG6IImo6mrh8ENCQ2+wxA6BfMFPfkVn5AwXOsZupGcnzhGGSKXttVqFe7CqMCi
         1h3acQOuI10/ig3PP8xkKsm4NtzNbHGpaQpLwoGjKN2BSoc/HFLvkEbHUIkKXG5J3g9z
         9q6Jpb0Ph5QlVq/4hF27NyIuM3/V2/KAkuHoouSJodEv2dWsfVfE58VeJPPY/+QOUQfz
         r+QwUf2vpfx2TV1s2fbWWB8eIKopRLMSEdWWEDiBiVoTpxt/dnwqSCw7tnlmHUsJj3fT
         5A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=plnLK4otWaGxR+W8sd3fBxFm06LW87+WFj6YX7JmKJI=;
        b=An68qMb3BQkaDFoaTCxxaamXw5oAoZjEZ7URrhoAlVLhpPPeIod/NjRIeZ/XAJELtP
         SdGjfhkagpI+4ovYHYfoh0wHCiouDbkhANyMYodmk0cGBhsLdPWXs/5aPwHYd3afAgaY
         0L8TekAY3mwVPvfb8uyAIpm9+E5T2Cn8658i28tbHqjQyPyzGNqlkYvay1fVTBV/gxWT
         TEUEycUn29XF8BshCGVVxbGfqJmNLiDxs/Zl6VLMe2hYtMQlco6srBdoi8B5umRZfSks
         /FIKwo7LY2PSn61X5Smh3RNo7PsvmoKSDpL+idWeY7NCj6PgOiPkZTG7/MbEtUmqW0lw
         UwmQ==
X-Gm-Message-State: ACgBeo2EsFHSUIqvf1DUgRM5kcCBycJEV/nx+1wFHuzeZIFIEHnQjKAU
        O99mch1GH+nLfRxtKzykcdvKqt1VyDM=
X-Google-Smtp-Source: AA6agR6koDuvaTUSC7OU/WlAja75jS99jSayBh5syt6ErVM0PHA+biyxUvs5Ar838YXdhWnvkXm6gonES4M=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a05:6a00:14c7:b0:52e:efb7:bd05 with SMTP id
 w7-20020a056a0014c700b0052eefb7bd05mr17908102pfu.24.1661808374985; Mon, 29
 Aug 2022 14:26:14 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:25 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-23-surenb@google.com>
Subject: [RFC PATCH 22/28] x86/mm: try VMA lock-based page fault handling first
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
2.37.2.672.g94769d06f0-goog

