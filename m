Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D95A5624
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH2V1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiH2V0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19F9E891
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q9-20020a17090aa00900b001fd93514a68so4327603pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+ZeFgC+onLi5H2Gk/r+wfB2lUIAEpTgiMaISz2j8Yh8=;
        b=sfdQ+2NyYwxA7WE4W+U26tjnRsGpTwH+W4yCMsULIhDPYOMjHM3COZzPg/S6KTqrLL
         mCgPnd6W8rrgwvL37XiGeYHG8ArgrFQG0UGf2gLsolv/ME8hJmTyRg7Fg1LBPlsPaNI3
         te4whtYEHF8c2GeRvQHa/rDrJjk62KSTUlVEPYqGvjKgQGKn8f4Dp8C4KiASRefP1Qh1
         bQmVBjd8KI32N8+vGT1M5VRcf57cOjajmNaLyJUUpin1ccvlQLSGjkUAJOTaDxWOJrJ5
         Pk3cN7LOZgsgUwKnowGjucplCuekHbu//K343iXFhb3F2AjszKhuURdvTUr7Fsy7vLjJ
         fKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+ZeFgC+onLi5H2Gk/r+wfB2lUIAEpTgiMaISz2j8Yh8=;
        b=0WhHNp+Psn1uZcM7tnssYkTXQuKK03hKUOCjWoI3BEFXnigAtIVartwiKm+ZzS8BjU
         OjUl/sN13/ZIO7hL/OXNN3+peDvajdpysxrfaB8juq0pTADEHWFNEtxjs51KWkMFvhl4
         YjgCMMyuTG4PodFxqcqBdEhjzHZJztpsp3ulp7PJkfQU9OIsgoMqegwIVy91V59fVfO9
         r/tlpOe/CrvuanRmqML8+qT/YEvgDihwJs0GO3ZZRshToxT5aMtQpEi60hFb9Ho9HXzm
         AxF5D8JUpNORXF19ChKDyXf4Svo6RQFZNQnpki2WKEkC+IsQLJfXXYaUoxt5Xh744B4N
         ivfQ==
X-Gm-Message-State: ACgBeo3xUpGG5Do3ibkTCxHCYw70BGUOuACDkVIbsmIxlA4A05uFT5ip
        2GBFo17U4aoFElorfMw5A3CnCfvFz6o=
X-Google-Smtp-Source: AA6agR60gqv1XJF9S7yhKpnItHkmCdUjQh3CpTVXyWE3xiDHKhNiTBjmbY9F8YGX1B9vpUO9txTmTcIisVc=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:6b88:b0:173:c1:691b with SMTP id
 p8-20020a1709026b8800b0017300c1691bmr18372367plk.18.1661808366708; Mon, 29
 Aug 2022 14:26:06 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:20 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-18-surenb@google.com>
Subject: [RFC PATCH 17/28] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
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
2.37.2.672.g94769d06f0-goog

