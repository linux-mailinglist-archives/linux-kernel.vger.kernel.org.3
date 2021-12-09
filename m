Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C814846F3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhLITRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhLITRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:17:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77903C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:13:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so12240946ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TGD1yEXRZ0MgwllUhVvIa/i7an9uYE2v1PNT6apFGJI=;
        b=SUl8NhsoAJRdz0LQdtW1eB9Xs5Y8fHH763/4wqAqzmTa0ilCvW8QVUyzOZYkmIvsc8
         R9fE+KAUto0xhgURFJ1S7aQztTkTD6YLsl/Sn88yMKSGsMu2m1IsZsv8xMBP8oeEqIzh
         XrbU5YGJPTbrlZQ1ky1NDM9uTsXmBpgDmwlo+Nb+DgkYyt8tlDlY3EuwLW/lTbbZBCGZ
         Effb9bBThbMtFYR79CQ99L7ibUrgjyGl4W62Oq2ZJmUcDYqxW7+sTpZIR3qbIOTzHrFB
         9xvNqsWwcAv1NC0OO+MOTjmHvnP2iHaUoS9ayqgK6ilvCDnPMH0WbCujZtt7m2LkCKjU
         kK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TGD1yEXRZ0MgwllUhVvIa/i7an9uYE2v1PNT6apFGJI=;
        b=m6CBkwEpc+rBKHF6ZfAYVglEmQ5yLvKsFBKCYbvqiZFSiCzTGd9jyd2jkbXwoTuuJR
         S29TbWAyslqoAYXtKpgeBEV/evVjBcW6EhnEM1MK4VQ8kIManSv3gDVVsxsbxvS7rhN6
         uauvpnrcBMHJ7hK/pwNkLsrYOHgfazOkBtbpnKMUjfF2orFEfm+WX1IIRFv1kHRXYlIP
         rojYAtPOQt3ZXhwy7Iwr1X+iQYvNQjzDTxfcduWcOqAU1hzPB6CoyOKN4KETtIeA2/rm
         GlZX0HFSpUoqDg1/MLNp50aNWsZCAgj2wRx81uMb7ODhcfqHzHDntyBQb68YbFSrgA2W
         5Afg==
X-Gm-Message-State: AOAM5320X33V2i7bdumcixRtyYvw6527J8wfzXaXpyoQoaBC6PsiCoxi
        EhIsboqfLE07pO8Sv5RLIuj7cnwLDzs=
X-Google-Smtp-Source: ABdhPJzI6MKgxdWBOrBRoG1MLD+oFx/sRDSe7QZtGI0W5qh4PkIQfOOtUwGmoWPwmy/8YdVZhrcexmtxZp8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:8b23:8fcc:c6e4:3a65])
 (user=surenb job=sendgmr) by 2002:a25:d16:: with SMTP id 22mr8607169ybn.51.1639077214712;
 Thu, 09 Dec 2021 11:13:34 -0800 (PST)
Date:   Thu,  9 Dec 2021 11:13:25 -0800
In-Reply-To: <20211209191325.3069345-1-surenb@google.com>
Message-Id: <20211209191325.3069345-3-surenb@google.com>
Mime-Version: 1.0
References: <20211209191325.3069345-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 3/3] mm/oom_kill: allow process_mrelease to run under
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

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
changes in v5
- Removed Fixes: tag, per Michal Hocko
- Added Acked-by's

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
2.34.1.173.g76aa8bc2d0-goog

