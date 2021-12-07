Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2146C6F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhLGVyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbhLGVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:54:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:50:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso877965ybl.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/LdRQnVKFEGyVFkXugJvOQFjhYmdmtnxJCMLa6KGAIY=;
        b=TSJWEN5Rxnaz9qPe6LANpcROYMKs/1uxR8XQ00zuKDcOln90goPFm9ZMukj5h99YvI
         F6PWoJXTp25T1ZhljvKKy1ACHUHwBaNLT+OIkBFIgc7VhBI+Y0k73esSPt/dzgjPM282
         +Iz/khJp3V0PQjhMaSiWxWUWtGpW4k9lz56DeyI1r2fpbGxzibzl2vCL6lH8RzekXxk2
         Dc79FQ22KzgCLljjSr1N7BsB1Dq7NGM0H4PSBuMHpFeXDwMz2P4A8vqVJIRUwLtW6gcX
         ob95GCzQoUc04mF6hFFKUS4EEEXArZBFAj6u1kam/x1MU/FIX7v+/wLzUqoTBLCuXZTn
         UyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/LdRQnVKFEGyVFkXugJvOQFjhYmdmtnxJCMLa6KGAIY=;
        b=Asv9s1EjuK4sK0V4t8EaNQMxer8kImUOjY0X8veiRsY1vljwFLJFv+tvDaACYajb5l
         7SlWOqPRLYhdOAxPzgQAoO/ljbFhCKG1IozcxoneJLsWGgOmAYYK5DyQVoyKhnFXWbc/
         toPKquUASqTlXoWvn1Eltt8fk7EH/q50WiOQ3QG7NpxUN66V5xcMcmA5iqL89fvOJOU6
         GEcsIFPEN8YPdH7EDb4Psb4erVxDe63ZB2nIVeMb4xKqJVVE0OD5R4cXiTLhRkMRo3ri
         +yfffaGZP+XbYk9CWuxWmucw9jw9svzOKauzwgOjNkQYYfymej+/FPUsIidKn0bAIXV/
         +ooA==
X-Gm-Message-State: AOAM531Klx/PO16PZhMvHVY9k+uX/JdOOFxE8mkb0IUD69K6nNgbW3Gp
        0odSVnjevPBBjHfmkUiAOhc6N8NXpMs=
X-Google-Smtp-Source: ABdhPJwczMrB/D5UxD3qYy1dxNZtBECINmekRXrVCSEVzUwTVEXKrH833TdiHRiC+ZHYFRov7+HszGzjwvw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c2df:fc7c:ed5e:6133])
 (user=surenb job=sendgmr) by 2002:a25:308b:: with SMTP id w133mr54895368ybw.534.1638913838031;
 Tue, 07 Dec 2021 13:50:38 -0800 (PST)
Date:   Tue,  7 Dec 2021 13:50:31 -0800
In-Reply-To: <20211207215031.2251719-1-surenb@google.com>
Message-Id: <20211207215031.2251719-2-surenb@google.com>
Mime-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 2/2] mm/oom_kill: allow process_mrelease to run under
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

