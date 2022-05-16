Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4B527EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiEPH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiEPH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:56:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E2766C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:56:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fee7869e4fso22618517b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbA0qY1A4n3sQ32XOHCQYzNEBpxFCtTkAwZ65vjYfT4=;
        b=EzUcTngDzwso/L64fcVNakp/QNp2XxIVJx7Dc64hdmuiHc5AH2OFv0w8gdLxmwWPWS
         0lQp7y6srQf/7QpKJATmstgTbdAePXt4McKCxanrSy9x4wAMtIKXHDH2UV3TEr2bdzhs
         rcv9dZx45zGWQpgfxEMwDy/ft01xVUILxl+wSJ46UXteeV8JbEzRu/DYN25yCr87q4Et
         WJkOZgXv3btbIB15dVs5CPFaVIHanllDdUmXZbSSbxLomlDB7QFoAqNJIf/80XLX4OVN
         X3x+FbDeBVcrGj1t4b2xdzKv/JYHrwX6M/n8h17yd3Z388IDgEuKg4e5FgyujLjSJRUk
         /O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbA0qY1A4n3sQ32XOHCQYzNEBpxFCtTkAwZ65vjYfT4=;
        b=HFla7H7eSGfgbjN+p+aHHzrGrUf82ITvMckXlk4ljBz/DFu1yiMgjfjo2TbLWqIu6t
         eAz69G2So5czugbvE3rI324fAD9Wp50ESDlxpdr6oXXLiB4qSoEnB4XyeOHgTTc/dpMO
         +Wg9plBD9U9lJI+crlmeYp0cCwuEqmYLH3CXGdGubHJ6j3Jc7UjFPW/bAHHvf0xzHSZW
         kBPJFS7rFy/1T3DQBErThonFzxgOP9bFeDGlYhBLRKJs3Zxl537UgxZizxtDlGp4IdVd
         u2Lwer32TTr7mQZjo89UUbJevFRRd1xJewAUx5/RlmN3JLYpKWq9CoEuj+LondNI8ZTv
         4HOA==
X-Gm-Message-State: AOAM531Vg/nd1D04zpSS11RdFMDEDJbTImo5sNfbCVeYGYhjkBl8kbl5
        AAvKu7qgqkl7av1rAlC5InVMfwUFsVM=
X-Google-Smtp-Source: ABdhPJxRNFyBKRteFpyB2k4NehlzATJkvZrFhQcwM3ufUJXDyGPuUAk/55A2q7MGyZ2oCIfTir1jgdNC7NA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:97b7:3e1e:26a3:690f])
 (user=surenb job=sendgmr) by 2002:a25:b6c9:0:b0:64a:9f32:5ac4 with SMTP id
 f9-20020a25b6c9000000b0064a9f325ac4mr15077774ybm.131.1652687785373; Mon, 16
 May 2022 00:56:25 -0700 (PDT)
Date:   Mon, 16 May 2022 00:56:19 -0700
In-Reply-To: <20220516075619.1277152-1-surenb@google.com>
Message-Id: <20220516075619.1277152-2-surenb@google.com>
Mime-Version: 1.0
References: <20220516075619.1277152-1-surenb@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, surenb@google.com
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

With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
now unused and can be removed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/oom.h            | 9 ---------
 include/linux/sched/coredump.h | 7 +++----
 mm/oom_kill.c                  | 4 +---
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6cdf0772dbae..25990e9d9e15 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
 	return tsk->signal->oom_mm;
 }
 
-/*
- * Use this helper if tsk->mm != mm and the victim mm needs a special
- * handling. This is guaranteed to stay true after once set.
- */
-static inline bool mm_is_oom_victim(struct mm_struct *mm)
-{
-	return test_bit(MMF_OOM_VICTIM, &mm->flags);
-}
-
 /*
  * Checks whether a page fault on the given mm is still reliable.
  * This is no longer true if the oom reaper started to reap the
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..5318c791ad39 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -70,9 +70,8 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_OOM_VICTIM		25	/* mm is the oom victim */
-#define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
-#define MMF_MULTIPROCESS	27	/* mm is shared between processes */
+#define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
+#define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
  * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
  * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
@@ -80,7 +79,7 @@ static inline int get_dumpable(struct mm_struct *mm)
  * pinned pages were unpinned later on, we'll still keep this bit set for the
  * lifecycle of this mm, just for simplicity.
  */
-#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
+#define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 36355b162727..11291b99599f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -732,10 +732,8 @@ static void mark_oom_victim(struct task_struct *tsk)
 		return;
 
 	/* oom_mm is bound to the signal struct life time. */
-	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
+	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
 		mmgrab(tsk->signal->oom_mm);
-		set_bit(MMF_OOM_VICTIM, &mm->flags);
-	}
 
 	/*
 	 * Make sure that the task is woken up from uninterruptible sleep
-- 
2.36.0.550.gb090851708-goog

