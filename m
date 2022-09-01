Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3806C5A9E24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiIARhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiIARgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7695AC0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o144-20020a25d796000000b0069b523a4234so4911191ybg.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=CVmSMjmLYwB9FBtpYSNLJ0EV++HpteWYtmAikuEnyj8=;
        b=RQU4Av3GuaGnYpE9oeVZ2Qc2D9oyD+ip4sYivAtlCkyS2/hNn9rv0v8p2M0NIGYJND
         Yf8x5cX18al4RtSO4Q1PhkVmfw1aU1Ab/Cll55dcKrRpQKauqrB7xyNC80pmZ6bW9bAC
         e95UH0jr+QtsvW6E0Yi+7Q29f7LTJtJy2OM2cQAlA/mMmKe3iC7olC3Rgqr7kYyQ1CJQ
         Co86J6JNei7V+ykfhNyFAPymL77cyA2ZQroFaHENAEs99CXDu6wa2X/Gpfr/HBQQdv4H
         QNCI3+GHYcOaSG+P0vp/Qcr7DGv7/3qUpIL4nQqbN3ksWTquAWAHtimY4d22gaOesNyT
         C0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=CVmSMjmLYwB9FBtpYSNLJ0EV++HpteWYtmAikuEnyj8=;
        b=FoC3/++dFxIQuP3DES2tZBjA418HtRJQVcbGm6gBMA9L3+a7/J7u6egFZVCDEIF3lR
         uXAdsHkSX9xTxlA4lnUS/B1jDM3+LDUjpOG+tWZ816jl+yqJPghqg0/hRd3OjZhA4rRY
         Xn7RY1qIblYM4QARsA65/dMdCiJ0skXYuLtxC1oIrpfBp61bz/bvD6m/9yRGFm+bpizJ
         1jZBIgZwjqjn7K+K+uvVvr87ChZq+9FAXkoeyAMYCBUbSWySl5PU0NNS73L8lXz9U4I+
         0B5zXvoQwCpPAD1huT8nJRdz4lfHPeaHu6sQJFdC8fjqBDJZFQr5eSFnSOpg3BInAN8i
         QuhQ==
X-Gm-Message-State: ACgBeo3pjymzTlgcA2eqLW+NkzslHasP4iLdAlGj07GV16KdDKT/d5j5
        f5h8XwD78DRi+cLOvk6INSq6d45kA5k=
X-Google-Smtp-Source: AA6agR571otBJ73SV6fz6quBhFyvEDhG9tsbvxbf3EGsugmeaIr00wfh/qpDUZrPhQkoYyC6wjg4lFM6a0U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:1c3:0:b0:6a2:2d4e:6bf8 with SMTP id
 186-20020a2501c3000000b006a22d4e6bf8mr1787307ybb.564.1662053758377; Thu, 01
 Sep 2022 10:35:58 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:02 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-15-surenb@google.com>
Subject: [RFC PATCH RESEND 14/28] mm: mark VMAs as locked before isolating them
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

Mark VMAs as locked before isolating them and clear their tree node so
that isolated VMAs are easily identifiable. In the later patches page
fault handlers will try locking the found VMA and will check whether
the VMA was isolated. Locking VMAs before isolating them ensures that
page fault handlers don't operate on isolated VMAs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c  | 2 ++
 mm/nommu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 094678b4434b..b0d78bdc0de0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -421,12 +421,14 @@ static inline void vma_rb_insert(struct vm_area_struct *vma,
 
 static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
 {
+	vma_mark_locked(vma);
 	/*
 	 * Note rb_erase_augmented is a fairly large inline function,
 	 * so make sure we instantiate it only once with our desired
 	 * augmented rbtree callbacks.
 	 */
 	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
+	RB_CLEAR_NODE(&vma->vm_rb);
 }
 
 static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
diff --git a/mm/nommu.c b/mm/nommu.c
index e819cbc21b39..ff9933e57501 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -622,6 +622,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
 	struct mm_struct *mm = vma->vm_mm;
 	struct task_struct *curr = current;
 
+	vma_mark_locked(vma);
 	mm->map_count--;
 	for (i = 0; i < VMACACHE_SIZE; i++) {
 		/* if the vma is cached, invalidate the entire cache */
@@ -644,6 +645,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
 
 	/* remove from the MM's tree and list */
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
+	RB_CLEAR_NODE(&vma->vm_rb);
 
 	__vma_unlink_list(mm, vma);
 }
-- 
2.37.2.789.g6183377224-goog

