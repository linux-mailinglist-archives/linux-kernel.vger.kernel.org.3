Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC694734CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhLMTSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhLMTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C41C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so14142150pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8swiEXoojgR8fMVEpmKtUWFtMz5ImAG/VTZz39Zgtg=;
        b=gz1vgU/Ih0LNIF1Otlge+zWADOuoKno2raWat3feJnxU12t6TBXL1PlnO62pCs+NvW
         OAXzEe/0a48ZdoBxV6EG3mSrL7oYAQEdX0RUok4rUC7t8xfchXvpmrDv6a9sczmyHNvW
         QjKj9VYe1LUwm2+fuHM1eOs/8B3uhVl9bDnUdP9lE6aXCwHC/wl0PCKdueiZ9HmoJTrr
         W2CeMbR1If0QJsT5q5AUXo0U3VUx8RK1+Ck+sgvuLQ3tNbHQn5CNbrTfUgDD1TfOTueO
         n4GFCgY02JOfhJ/gN3H7yxMj/7IFJyYmbPbEI0znwsARKg12jJuA/+ep2HijcbD5bMnL
         Jn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=a8swiEXoojgR8fMVEpmKtUWFtMz5ImAG/VTZz39Zgtg=;
        b=jpITsLunv8hb/5+mjBiEahaHcCCTl51vESJprtN/SOeoPaCUS3QBD2izs5BhX3qV5p
         CT6czb+SGoMerW6mnmKXD1GT7foBD965YGQxcgBTF4g3r4nkB60xPArmJKMkVXrMb7e1
         Z0hMI1fSQs+8KCCpCCgHcTakXI3AS5bR+2W8Hzge1gfp0D3BqXqvL7vbI6OapHUyqJEq
         FIF2T3mTY0O2Kkis95gPN7wGzIcdbmgekIZWVwTKNt2/PlibHAvVwxrIeHyQ5MVkOPXz
         aAWpd2wJ+XYnYXyjD6akWWIk8jm8N8dVwFUhdc+Gcp1P72HIlzSOvs4FnlX1UfSn/9Tp
         7Nfg==
X-Gm-Message-State: AOAM531BvL5wBRLgxdRIpibB1An+CPmdiwGKEVpRjvUgFQ7GiuOtPuVR
        H4LQF/I1JVNOiKhR0Mu4cPY=
X-Google-Smtp-Source: ABdhPJy7FBJ2jKCmaCQMwQ0nH5QrwR7C20SIEffKMJoAYP06ERciNJdzlehz3O1W9Zo9Ltg6XNKrUw==
X-Received: by 2002:a17:902:bd02:b0:142:728b:e475 with SMTP id p2-20020a170902bd0200b00142728be475mr85131880pls.15.1639423121756;
        Mon, 13 Dec 2021 11:18:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m24sm11107048pgk.39.2021.12.13.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] cgroup: Use open-time credentials for process migraton perm checks
Date:   Mon, 13 Dec 2021 09:18:28 -1000
Message-Id: <20211213191833.916632-2-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
References: <20211213191833.916632-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup process migration permission checks are performed at write time as
whether a given operation is allowed or not is dependent on the content of
the write - the PID. This currently uses current's credentials which is a
potential security weakness as it may allow scenarios where a less
privileged process tricks a more privileged one into writing into a fd that
it created.

This patch makes both cgroup2 and cgroup1 process migration interfaces to
use the credentials saved at the time of open (file->f_cred) instead of
current's.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Eric W. Biederman" <ebiederm@xmission.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 7 ++++---
 kernel/cgroup/cgroup.c    | 9 ++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 81c9e0685948..0e7369103ba6 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -504,10 +504,11 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 		goto out_unlock;
 
 	/*
-	 * Even if we're attaching all tasks in the thread group, we only
-	 * need to check permissions on one of them.
+	 * Even if we're attaching all tasks in the thread group, we only need
+	 * to check permissions on one of them. Check permissions using the
+	 * credentials from file open to protect against inherited fd attacks.
 	 */
-	cred = current_cred();
+	cred = of->file->f_cred;
 	tcred = get_task_cred(task);
 	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
 	    !uid_eq(cred->euid, tcred->uid) &&
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..2632e46da1d4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4892,6 +4892,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 {
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
+	const struct cred *saved_cred;
 	ssize_t ret;
 	bool locked;
 
@@ -4909,9 +4910,15 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
 	spin_unlock_irq(&css_set_lock);
 
-	/* process and thread migrations follow same delegation rule */
+	/*
+	 * Process and thread migrations follow same delegation rule. Check
+	 * permissions using the credentials from file open to protect against
+	 * inherited fd attacks.
+	 */
+	saved_cred = override_creds(of->file->f_cred);
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb, threadgroup);
+	revert_creds(saved_cred);
 	if (ret)
 		goto out_finish;
 
-- 
2.34.1

