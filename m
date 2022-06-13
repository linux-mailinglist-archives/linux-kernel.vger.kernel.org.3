Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B791547F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiFMGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiFMGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:07:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0FAB1C3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:07:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so4254761plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2YkzI9j1jsr56lMlCtYILywTtcG8+NXvsHywe0vpm8=;
        b=hhvQSETcJzMWUEZQmAuklFwxKIhtykeBuDIiv8Nc4AScgy9Iu++Ff19Sk1bckffCfs
         pM+5xxeoLj6aMvfb+lweD1Hvty0eL73rvwI0I0KgXEAUj01prXeM+I9T52WMpgOegV5n
         8Tw5EgM1q09dhE/uBZpAUmDe35xQAlbIFQAiuiJDGIBKsn6T52yCtw89phsz2ml9JfQh
         nBfTlSSgk0Orzqd9cWjz5VMsAPGNwzSyhIjnf5AECy+qoqymQ4iZMbEev2JE4F01Ng+L
         aWy5o3pk7RiH1jZV6v0IBPabPa9oreoIUMhJTembQSwIaNCq7jfyjrB6XqWlIJioIyrJ
         AWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2YkzI9j1jsr56lMlCtYILywTtcG8+NXvsHywe0vpm8=;
        b=1y/p1GXH0MazU5ulv5GXCrOXStzmKxiL7vNoH6lWjj8vsQKpF2xDkJeNE3laTOLwur
         JtyJB0bAiKBO/va3lut67nkI8cN4vi8XbaPT1dX4UWhaYpKmkSg5artXMI4cjddoaxOr
         kAGefHZnaPkly/B9ejFUrNXIE+o+JfIq9+iMPZiTNk+Nlb4hSzZgjFSph9rodUFkEigU
         cf3wlfY53OZFDhGobMnTE9hAOUNbqznSjZVyfsPinPEssMpagHr7dzpGDBjbaviF1oO+
         YVhhf4FA6LZ3591NmNCNi0H+Zx5R6UMgUM00EYLrxAK+8QxU4vdOiIa0MYEET5zwAK/X
         fxBg==
X-Gm-Message-State: AOAM531okl+vxM8XHYzdvYZgvQU+2laT0NHfAqk8M+TkU/tT8UwhYvke
        1aVAK577sbkF1CBYQpgOV/kdZVcRkgM=
X-Google-Smtp-Source: ABdhPJxu+n/sA9OaUT7rb/xD5BABGaVCwNCHWLBEpExROYalF9j/xouFkI6qBNBX+qZjZajJV2+ZAw==
X-Received: by 2002:a17:90a:eb17:b0:1e2:f569:6b60 with SMTP id j23-20020a17090aeb1700b001e2f5696b60mr13894942pjz.48.1655100455292;
        Sun, 12 Jun 2022 23:07:35 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b0015e8d4eb1c8sm420157plw.18.2022.06.12.23.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:07:34 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 1/2] fs/exec: allow to unshare a time namespace on vfork+exec
Date:   Sun, 12 Jun 2022 23:07:22 -0700
Message-Id: <20220613060723.197407-1-avagin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, a new process can't be forked in another time namespace
if it shares mm with its parent. It is prohibited, because each time
namespace has its own vvar page that is mapped into a process address
space.

When a process calls exec, it gets a new mm and so it could be "legal"
to switch time namespace in that case. This was not implemented and
now if we want to do this, we need to add another clone flag to not
break backward compatibility.

We don't have any user requests to switch times on exec except the
vfork+exec combination, so there is no reason to add a new clone flag.
As for vfork+exec, this should be safe to allow switching timens with
the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
if a child is forked into another time namespace. With this change,
vfork creates a new process in parent's timens, and the following exec
does the actual switch to the target time namespace.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/exec.c        | 7 +++++++
 kernel/fork.c    | 5 ++++-
 kernel/nsproxy.c | 3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0989fb8472a1..347e8f55bc2b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
+#include <linux/time_namespace.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -982,10 +983,12 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
+	bool vfork;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
+	vfork = !!tsk->vfork_done;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
 	if (old_mm)
@@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
+
+	if (vfork)
+		timens_on_fork(tsk->nsproxy, tsk);
+
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..9174146f6812 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2033,8 +2033,11 @@ static __latent_entropy struct task_struct *copy_process(
 	/*
 	 * If the new process will be in a different time namespace
 	 * do not allow it to share VM or a thread group with the forking task.
+	 *
+	 * On vfork, the child process enters the target time namespace only
+	 * after exec.
 	 */
-	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
+	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
 		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index eec72ca962e2..b4cbb406bc28 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -179,7 +179,8 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
-	timens_on_fork(new_ns, tsk);
+	if ((flags & CLONE_VM) == 0)
+		timens_on_fork(new_ns, tsk);
 
 	tsk->nsproxy = new_ns;
 	return 0;
-- 
2.35.1

