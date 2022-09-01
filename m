Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86EC5A9E26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiIARgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiIARfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217567C82
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f16-20020a17090a4a9000b001f234757bbbso7906905pjh.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=f3HBd//8MTEjGtUKjIJ6VlUao66B8ATA87dRitXKN6o=;
        b=osN5P5u2gNPNqCUBvTG+Zi66behXZjVMeiTYran173d3bK7x/C4pNezlQHCFvkYQk7
         qOQqzQeCFbXQDX9e+QRzeVBdZKr22OFya12CKF/BNucIJ15gJeM6CJ6xJtVhkJ86JMIW
         z0BrEcSFGRuuGzZ7AIa/XsKdDh+JkQT9DWUmeCCWJ5VsR1VGSIBZmgZx0ZCJYBHl+XPj
         GoCI/RFibFsonWSqgiZwplWva8pXUgT5urz+18AucAe/seeiQYlfr5LWvUC2qg96tyno
         slrVqaBJlR1Fm38ZmASWvylf1J3rbhYM8n7OsiK4uazMHDS7+qFeKWZULOPVqfmGOKH5
         n3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=f3HBd//8MTEjGtUKjIJ6VlUao66B8ATA87dRitXKN6o=;
        b=4kf6+oiwsHYjVM2VEdhZ+BOF4k3Cz1fTofqAa30nVQAAG+76qqT0pWwH1dLj9QDVum
         /PqES7QqW+nfGInP1VFX1xmx8tsnzmVEPe3tukXRQyvIAKQFk2oBV5N4WUS+2IIpqNWc
         G0K6qHV7gGlGRIfYNqzC9/O0tpXfTN8K8vyJFZjPCmXyfr6grQUiszlW/1P8D2WGUi9J
         FW0CB8HK4AII3uuu7zsuwwdxzcPdHMZIbgbYGRJb8sVu3IAeZ4v4mFStM22gIVkTBJQq
         U/6zx36E3R4XRacL7bTBm+eNL97/7TeQHhqJt0CRjnsenJUzJG6j8swPSc5zuvZIZFCL
         SIfw==
X-Gm-Message-State: ACgBeo20KIbojXmnWkNa1VWvQFSeXj7u2wQFWZjOUrUEpty56JF+i47J
        LZov4+9KEXRRnfykkBWo3i1L1WtdCS8=
X-Google-Smtp-Source: AA6agR6Q3wPydZYjoco/mRjMkhmNWxJo3Xdi/ebZ3ovzfa+ebF5iWZWFhqHdfMvubIqW+qGVzpwNqTYAd9U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a17:903:2351:b0:175:58b8:cdef with SMTP id
 c17-20020a170903235100b0017558b8cdefmr4890777plh.30.1662053745409; Thu, 01
 Sep 2022 10:35:45 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:57 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-10-surenb@google.com>
Subject: [RFC PATCH RESEND 09/28] mm/mempolicy: mark VMA as locked when
 changing protection policy
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

Protect VMA from concurrent page fault handler while performing VMA
protection policy changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mempolicy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b73d3248d976..6be1e5c75556 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -383,8 +383,10 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	struct vm_area_struct *vma;
 
 	mmap_write_lock(mm);
-	for (vma = mm->mmap; vma; vma = vma->vm_next)
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		vma_mark_locked(vma);
 		mpol_rebind_policy(vma->vm_policy, new);
+	}
 	mmap_write_unlock(mm);
 }
 
@@ -632,6 +634,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 	struct mmu_gather tlb;
 	int nr_updated;
 
+	vma_mark_locked(vma);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
 	nr_updated = change_protection(&tlb, vma, addr, end, PAGE_NONE,
@@ -765,6 +768,7 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
+	vma_mark_locked(vma);
 	if (vma->vm_ops && vma->vm_ops->set_policy) {
 		err = vma->vm_ops->set_policy(vma, new);
 		if (err)
-- 
2.37.2.789.g6183377224-goog

