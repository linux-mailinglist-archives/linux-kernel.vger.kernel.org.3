Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C80F46DD8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhLHVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhLHVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:25:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 13:22:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso6648554ybj.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/LdRQnVKFEGyVFkXugJvOQFjhYmdmtnxJCMLa6KGAIY=;
        b=ik0lGloytyqJMBwHPZlQOqLyGVHVJ8skmb+yfBkdfnZ4R41eUquBRC3ulzCWnv8Yop
         DHIJiOfklRnkRfWnrXgyiJDvrck0Og0VPhymdBAxFy2KBrqduxHQmEIhlgJa8wrQHClP
         kPa1Rk8bGcfXYR0KRs1CHPFM7GPeNDJeKmVlN95DFxzzV1dqadhkEaS/P3K641Btrlcq
         NhXoVbYmY7Ja28uxgrq/sR90a8ZuskctY379JhQnHlSqnZ+yBHK0Wll7F40s4fap2M3X
         uW8ITJCXRmGbgaAmxtM13KqdcKkCZocCerIKyi2qLfYIzL8QM17q0dgL8c0m7J+Na60G
         2Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/LdRQnVKFEGyVFkXugJvOQFjhYmdmtnxJCMLa6KGAIY=;
        b=WUGdIhb/e+lVrg981NlX1Kyr/hew0Hx2xSKre1GnF8+jLAQK0QbTgUTpKFWdqNUpjr
         t5X+XG71oHnFzoRHo4c2sigU7J8Ymy2+uV3CDYhsxPBESFWaVg2OxTn0KfN84DAu0lH8
         0NF0/C4GQhx7XJG4v+PaN7XD/JfCrR1m011sY+ZInUSTaEq4aEhTfgjYk1/zFAVMIFZv
         +mWlpRApY1mnUxeSDOevgPen9ceRu4Y9Kvb4nJPmdXEvTkigBmcUCb98fLDAGo94wEx6
         iw9YEfDa1roufVP9dcfexfXTi8BcxY+CgV+YIhfTcbkn+Z4aL753VmOBLQLYnGE6Ld+n
         QtrQ==
X-Gm-Message-State: AOAM531mvG5dLcsVPvzBekphgXUDjPQy6fypqysjkobjtP/cFxnEtNL3
        t14eHn32GUfzg3vLMGx4Lcr3cLX6MdE=
X-Google-Smtp-Source: ABdhPJxUwvDuuaC2E/F2iwSIbNDSm8TNvXzaOJU4mGj28Dea/RhmXNcUnekZSEqBy5C61eQOwQxDs+F7nz4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4efa:9eac:2174:103c])
 (user=surenb job=sendgmr) by 2002:a25:357:: with SMTP id 84mr1583433ybd.220.1638998540126;
 Wed, 08 Dec 2021 13:22:20 -0800 (PST)
Date:   Wed,  8 Dec 2021 13:22:11 -0800
In-Reply-To: <20211208212211.2860249-1-surenb@google.com>
Message-Id: <20211208212211.2860249-3-surenb@google.com>
Mime-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v4 3/3] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With exit_mmap holding mmap_write_lock during free_pgtables call,
process_mrelease does not need to elevate mm->mm_users in order to
prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
is walking the VMA tree. The change prevents process_mrelease from
calling the last mmput, which can lead to waiting for IO completion
in exit_aio.

Fixes: 337546e83fc7 ("mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/oom_kill.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..67780386f478 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1169,15 +1169,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		goto put_task;
 	}
 
-	if (mmget_not_zero(p->mm)) {
-		mm = p->mm;
-		if (task_will_free_mem(p))
-			reap = true;
-		else {
-			/* Error only if the work has not been done already */
-			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
-				ret = -EINVAL;
-		}
+	mm = p->mm;
+	mmgrab(mm);
+
+	if (task_will_free_mem(p))
+		reap = true;
+	else {
+		/* Error only if the work has not been done already */
+		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+			ret = -EINVAL;
 	}
 	task_unlock(p);
 
@@ -1188,13 +1188,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		ret = -EINTR;
 		goto drop_mm;
 	}
-	if (!__oom_reap_task_mm(mm))
+	/*
+	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
+	 * possible change in exit_mmap is seen
+	 */
+	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
 drop_mm:
-	if (mm)
-		mmput(mm);
+	mmdrop(mm);
 put_task:
 	put_task_struct(task);
 	return ret;
-- 
2.34.1.400.ga245620fadb-goog

