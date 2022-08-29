Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9C5A561B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH2V0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH2V0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2C6E2C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:47 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s8-20020a170902ea0800b00172e456031eso6759721plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Ymgoo1txtx46eok3IPOZQ+7oQJBGfBlI8J01hhP7hOA=;
        b=V7GGgx774wbENy2sL3aG99hkTB/qGZUI2IMkW5Z7Ox/AY4k1IvJaJqWcS2+hJrQTXz
         qJiaho12WNhOPkKsDNI4kFEEE0MJklisQUNbnL2MLe3SXi7RR3OSC49CxUHm5rWNBWOA
         wHnBj0rB97rbw4NvbtXfeTLWG+Vyzon45DGcHKdD67SN4QP16ppc4Mfgkavx0/TZazKT
         jRNtTwjBlBNTzgM29WASwCLg6OtowkNwGUZwoCyX8zuUMvza2TeNlSBp6kFeN5K2wkE2
         aGwm4Y8asgOKWmz3tiq46nHGojR+kREyp0h1B2grUgz1rUK/O35dZpO1+I8qz72cYmP5
         /MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Ymgoo1txtx46eok3IPOZQ+7oQJBGfBlI8J01hhP7hOA=;
        b=1/UjouWp4gqJwzjTTXsbnRLV3k5pNGC1rv+gf99KSMNOSzLwFhKiMzPtpIGEsZBmih
         wPMB2xLLsi+D+bMSW71Iwr4kkfhRqE/sMnUY5g4t8k6nMYwj/kOK7Vk8mZfL39oqbRUz
         0JRD/SS72t/FGc1FgiJPyfIbypxyu16O1ZR7Dl996+M0ThOfYNIDwuasqb7Nttqsw9a1
         LjWCfS7BhT6ciuJUVeaF6gIqXqoo+rKqDzyHicoRVY7C9lGe4LCbVb6QimIDz30uTAIz
         QO+YiPwIaWH/hPpJJHfdrnC5x0cNeP9e/zXPrpjOws4Hc/9EviMcqa6twPQFaZDkJfra
         mTMw==
X-Gm-Message-State: ACgBeo3HG3Ug74rNEJsAH7yqTIWW7JwQKVSoTqEpf3Ww3qGyvB2YTvjU
        aIED7Y4Pi+31tM/hzjwnwM+VSXkpGqY=
X-Google-Smtp-Source: AA6agR5xVu1GUsjULFDqf0en50jiRHsHcqxte0InGO36KTqnyV9YWBjqbQ+B0gx1566Kx/T+OnpxLJSWOq4=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:d48a:b0:16f:c31:7005 with SMTP id
 c10-20020a170902d48a00b0016f0c317005mr18369268plg.173.1661808346364; Mon, 29
 Aug 2022 14:25:46 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:09 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-7-surenb@google.com>
Subject: [RFC PATCH 06/28] mm: mark VMA as locked whenever vma->vm_flags are modified
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

VMA flag modifications should be done under VMA lock to prevent concurrent
page fault handling in that area.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 1 +
 fs/userfaultfd.c   | 6 ++++++
 mm/madvise.c       | 1 +
 mm/mlock.c         | 2 ++
 mm/mmap.c          | 1 +
 mm/mprotect.c      | 1 +
 6 files changed, 12 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4e0023643f8b..ceffa5c2c650 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1285,6 +1285,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
+				vma_mark_locked(vma);
 				vma->vm_flags &= ~VM_SOFTDIRTY;
 				vma_set_page_prot(vma);
 			}
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 175de70e3adf..fe557b3d1c07 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -620,6 +620,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		mmap_write_lock(mm);
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
+				vma_mark_locked(vma);
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				vma->vm_flags &= ~__VM_UFFD_FLAGS;
 			}
@@ -653,6 +654,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+		vma_mark_locked(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 		return 0;
@@ -734,6 +736,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		atomic_inc(&ctx->mmap_changing);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		vma_mark_locked(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 	}
@@ -891,6 +894,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			vma = prev;
 		else
 			prev = vma;
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
@@ -1449,6 +1453,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
@@ -1630,6 +1635,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 5f0f0948a50e..a173f0025abd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -181,6 +181,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	/*
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 */
+	vma_mark_locked(vma);
 	vma->vm_flags = new_flags;
 	if (!vma->vm_file) {
 		error = replace_anon_vma_name(vma, anon_name);
diff --git a/mm/mlock.c b/mm/mlock.c
index b14e929084cc..f62e1a4d05f2 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -380,6 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (newflags & VM_LOCKED)
 		newflags |= VM_IO;
+	vma_mark_locked(vma);
 	WRITE_ONCE(vma->vm_flags, newflags);
 
 	lru_add_drain();
@@ -456,6 +457,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 
 	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
 		/* No work to do, and mlocking twice would be wrong */
+		vma_mark_locked(vma);
 		vma->vm_flags = newflags;
 	} else {
 		mlock_vma_pages_range(vma, start, end, newflags);
diff --git a/mm/mmap.c b/mm/mmap.c
index 693e6776be39..f89c9b058105 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1818,6 +1818,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 out:
 	perf_event_mmap(vma);
 
+	vma_mark_locked(vma);
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bc6bddd156ca..df47fc21b0e4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -621,6 +621,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
+	vma_mark_locked(vma);
 	vma->vm_flags = newflags;
 	/*
 	 * We want to check manually if we can change individual PTEs writable
-- 
2.37.2.672.g94769d06f0-goog

