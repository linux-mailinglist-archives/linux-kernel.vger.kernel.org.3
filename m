Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027385A5622
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiH2V1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiH2V0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886798588
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k1-20020a17090a658100b001fb35f86ccdso10084925pjj.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=J1u/YkZ7r4U6qP3j3HXey3MGQlv66sCtBUAUQwGtkmo=;
        b=bssUgHF5w47sbr7l7KTrCUB9BNCgN6M5weE9wkVgXyWLQuTUzyGpg0OJvcyz0sW5UD
         jBcbuP4XXvP/J4pS6AqtYRXplk3ioZfRWOizdHfYubwqdaFV7iqu+wCAfN30wOXuSJR5
         rOeSjLAnMTV/UMrEb+PillTsGibQBZHi92r8Zd7PRmmwTLk5upCdMt9/ApQU+Kr/zUNy
         g3HC4+2oFiondWWpmL/CQDHhjiEfoJFEyDpo5hDjW6J9yE1A4zjv6LFdAo5+gh9e4xsA
         3B8ihRdAo9AsX2EZ1zty6Setu8LqB98WdsMEL3dnRqIhFnd/9nqnY8Jcva4fprwPuNko
         5pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=J1u/YkZ7r4U6qP3j3HXey3MGQlv66sCtBUAUQwGtkmo=;
        b=chesZP8fpu+lqS1YYS84XLjXNgxOzZ14Jb0YwZ8iRxjSwPVX0adPUfGp86rplQgHDo
         vvXW7HO6NLGOaB53JTK9EEegCegFEnjdsWMjnrh1vF+XNaged6+cUMN/Es36O7/HAtik
         oTPV1xlRo7WZPdamDPBEMZggDpSH7eea+RKyrS5pFi08pSikpZtvZIXCT2n3lq5WMUrU
         PwzMhpsVEGtFEefDzY2CSt0tY+ipzhsEeKGA544B1p2ecRYFTUZE6aGgfGMupp29Fk6q
         /VPWRIMUWqs+Zei8kQUKgIh90RnJPWp+QwkU9K2E2XUQDL/tDp3k9Jv4pbfnGpu6YuBc
         cq0w==
X-Gm-Message-State: ACgBeo2tip4lytpdthssvLFycjYafVVaC9G+hB2P3B2CAzdwHB70GyDx
        SoZtb1uqFkViVw2fo3RPgAIOdfkuwuA=
X-Google-Smtp-Source: AA6agR7FrxHuf3ebSGip6Dsrc2j7pCNXLJVmg+GJ9+F6P4LGjbGDMIiC+XxX5XFr/bvFDyLyzfk2y9GLnRc=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:903:248:b0:172:7520:db07 with SMTP id
 j8-20020a170903024800b001727520db07mr18052271plh.76.1661808361566; Mon, 29
 Aug 2022 14:26:01 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:17 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-15-surenb@google.com>
Subject: [RFC PATCH 14/28] mm: mark VMAs as locked before isolating them
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
2.37.2.672.g94769d06f0-goog

