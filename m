Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87EF5A9E30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiIARhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiIARgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704F2B63C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n18-20020a25d612000000b0069661a1dc48so4978157ybg.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=b/hqij6YMtUKn07CMMZGWuY0xy+IpIQzVd6D2LweKqw=;
        b=KRAo4osvkXfti83dlr7pDy0khew3B+/GxQjWEAl6TnacUwl+mtLybx0YLCFQUFV0lg
         sqmNuGzCNSRuL2SViXVJ2r0wrXOlXyxs3u9yAmqqg3AvKB9F3JJSO7rq3ZQJpqtxodOF
         i7G/Yua6+zv1pQayP4MuTvdM1yGvpgFJMwTj6dIMUAQKUS2ErYsxnukeEQ3tr0wanncl
         yMd9bQqlR0P+NMVZ/l+rGeUj3MMbqQRN0a5ORe8qDMpkAqtMCeKLfNSS6669H06w2E3e
         HhGcmv1HGm3kJoo9dZc+gF0PSVEl7OpLVCRJfkfc6aws3/7f1ZLX+WRY47T74JB1rzMb
         smKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=b/hqij6YMtUKn07CMMZGWuY0xy+IpIQzVd6D2LweKqw=;
        b=gbbb2IZAe/l6jLZhvz4cpuw+sIyYhF2oQbXuapOHTSV/bs2YG3QlDX3Sfq3q+3GVx+
         VZemq0SWar2A9/5hTI2DYHAna/tVbyg9fjlubqibUs9Lyhiw3Wq08shtB0Bd2BM39UMe
         RIF42CIhS2OVKtpl6dQpQLDQh228WwST85CbwFT1eVTafxUxjxhX3kTHcAP8ZgASDnPu
         DnT5CunwgL90cUnvUTAb9jjDqiAS86cIjRZsaox5YzVD9ZlBA5kihbnjKfSVmuMIGFLL
         BXUt3Qa9qks5zMHoU9Wd9iObCKWRitSVotAgrxD2iwAMIIRwAUQ6pWcsIFWAP//bYbGO
         ep6w==
X-Gm-Message-State: ACgBeo1Nw+/FxTYQ7gBAUDoRMRpM/KYJOPTbUIl7s1N3as3e2jirirGX
        +qg6cO4D5q3/+zVpU7aC9KC1WxDFzGE=
X-Google-Smtp-Source: AA6agR5jEvG/zgKOeD87JHuYvOxB9Vp8GPj5NQSbzUKBEagOp3ZLZ7YArxKySukyQ3HnfRTZ0d7o3HLJ11s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a05:6902:91d:b0:672:e583:9ed9 with SMTP id
 bu29-20020a056902091d00b00672e5839ed9mr20010197ybb.225.1662053766633; Thu, 01
 Sep 2022 10:36:06 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:05 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-18-surenb@google.com>
Subject: [RFC PATCH RESEND 17/28] mm/mmap: prevent pagefault handler from
 racing with mmu_notifier registration
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

Pagefault handlers might need to fire MMU notifications while a new
notifier is being registered. Modify mm_take_all_locks to mark all VMAs
as locked and prevent this race with fault handlers that would hold VMA
locks.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index b31cc97c2803..1edfcd384f5e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3538,6 +3538,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
  *     hugetlb mapping);
  *   - all i_mmap_rwsem locks;
  *   - all anon_vma->rwseml
+ *   - all vmas marked locked
  *
  * We can take all locks within these types randomly because the VM code
  * doesn't nest them and we protected from parallel mm_take_all_locks() by
@@ -3579,6 +3580,7 @@ int mm_take_all_locks(struct mm_struct *mm)
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_lock_anon_vma(mm, avc->anon_vma);
+		vma_mark_locked(vma);
 	}
 
 	return 0;
@@ -3636,6 +3638,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
+	vma_mark_unlocked_all(mm);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-- 
2.37.2.789.g6183377224-goog

