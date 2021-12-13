Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14684734D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhLMTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbhLMTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:46 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFDC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so11857913plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mXcI94hZI44KgJ6v7kx3NwRCMr+kshsnnSDF31iOgc=;
        b=iH8tZWEUvk5a8tULCNAGSxWHm3eQEMGN0wpthpJng2Or62g0QyP6BRBsPlAqTRiPXu
         5lhT9d2OIEhWM5oJZiv3I2JqP7ttiH87jv0Eu5foyzqsc/dxPXj2o3IDnGlYYTAe0Xbz
         86Sm61nla+tabzKMoROawGhEPWNQRZ5814z/20nWgrvF+MJWU+cAzVkpO8RvG8ygsREs
         TvClBZzqEtzY2ZWS3z3fIE0JSJ9DClbowexNI0MTrI54jTw8yI5yjvDfeCUVYRV9HIQ5
         m14gOGj8MJHLncWKypjdvZDDUqfSbfwkubsvz85zdrGOgeQK6kFSysq3DWK1QJ/GxJGE
         6GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+mXcI94hZI44KgJ6v7kx3NwRCMr+kshsnnSDF31iOgc=;
        b=sXFcqdo57QA7dHSgs535Re0JqggE+s48QpFV6HFfCk2kZS9d4zTbn5T4jUKSnp0kp7
         V02dP9jPrTZx+UAX54Zj4ui/uUlpkTfHmXlyvaHFLdMfNzmVXSMMBhyMxLMFJvZXJ1NO
         lRlQliHpslQfSMpRJP4u5hsqDB6orYz41/6mfLaXv2YpGoUpP8FKPrfHAhiMPFZDh87G
         OqFmQ1P/Vy2vXVqqo5YT1LfnXaHYoVvZDv8i32zkt+xuII/TBls8GSpjeZ+li1wawRG5
         9ft9oUA0Wq5VHFRqyj0QsdCavFbDaHbXCvEZblc/gIsP8NJHynakfj0JRJgQ4To1rgLp
         BgWw==
X-Gm-Message-State: AOAM531ohUqFiTywdeCveo1iYLJpcx1YBVzqQhnOu6X7tdl9qqygdOpl
        dhteG0TOfeGYGrKjmFG5WEc=
X-Google-Smtp-Source: ABdhPJzTqaIompO6qGG9x73FH1ZxceNYCnRkhfqLZqVDnywRvDNBe8oxrWu+XsRHptgvTSKbUNg3VQ==
X-Received: by 2002:a17:903:2449:b0:142:b3c:f9c6 with SMTP id l9-20020a170903244900b001420b3cf9c6mr96656062pls.77.1639423125951;
        Mon, 13 Dec 2021 11:18:45 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u36sm12136662pfg.21.2021.12.13.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
        syzbot+50f5cf33a284ce738b62@syzkaller.appspotmail.com
Subject: [PATCH 3/6] cgroup: Use open-time cgroup namespace for process migration perm checks
Date:   Mon, 13 Dec 2021 09:18:30 -1000
Message-Id: <20211213191833.916632-4-tj@kernel.org>
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
the write - the PID. This currently uses current's cgroup namespace which is
a potential security weakness as it may allow scenarios where a less
privileged process tricks a more privileged one into writing into a fd that
it created.

This patch makes cgroup remember the cgroup namespace at the time of open
and uses it for migration permission checks instad of current's. Note that
this only applies to cgroup2 as cgroup1 doesn't have namespace support.

This also fixes a use-after-free bug on cgroupns reported in

 https://lore.kernel.org/r/00000000000048c15c05d0083397@google.com

Note that backporting this fix also requires the preceding patch.

Reported-by: "Eric W. Biederman" <ebiederm@xmission.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: syzbot+50f5cf33a284ce738b62@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/00000000000048c15c05d0083397@google.com
Fixes: 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup-internal.h |  2 ++
 kernel/cgroup/cgroup.c          | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 0ced1e04177f..9ead575f9678 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -66,6 +66,8 @@ static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
 }
 
 struct cgroup_file_ctx {
+	struct cgroup_namespace	*ns;
+
 	struct {
 		bool			started;
 		struct css_task_iter	iter;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a84631d08d98..cafb8c114a21 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3822,14 +3822,19 @@ static int cgroup_file_open(struct kernfs_open_file *of)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+
+	ctx->ns = current->nsproxy->cgroup_ns;
+	get_cgroup_ns(ctx->ns);
 	of->priv = ctx;
 
 	if (!cft->open)
 		return 0;
 
 	ret = cft->open(of);
-	if (ret)
+	if (ret) {
+		put_cgroup_ns(ctx->ns);
 		kfree(ctx);
+	}
 	return ret;
 }
 
@@ -3840,13 +3845,14 @@ static void cgroup_file_release(struct kernfs_open_file *of)
 
 	if (cft->release)
 		cft->release(of);
+	put_cgroup_ns(ctx->ns);
 	kfree(ctx);
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *cgrp = of->kn->parent->priv;
 	struct cftype *cft = of_cft(of);
 	struct cgroup_subsys_state *css;
@@ -3863,7 +3869,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
 	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-	    ns != &init_cgroup_ns && ns->root_cset->dfl_cgrp == cgrp)
+	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
 		return -EPERM;
 
 	if (cft->write)
@@ -4853,9 +4859,9 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 
 static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 					 struct cgroup *dst_cgrp,
-					 struct super_block *sb)
+					 struct super_block *sb,
+					 struct cgroup_namespace *ns)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup *com_cgrp = src_cgrp;
 	int ret;
 
@@ -4884,11 +4890,12 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 
 static int cgroup_attach_permissions(struct cgroup *src_cgrp,
 				     struct cgroup *dst_cgrp,
-				     struct super_block *sb, bool threadgroup)
+				     struct super_block *sb, bool threadgroup,
+				     struct cgroup_namespace *ns)
 {
 	int ret = 0;
 
-	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
+	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb, ns);
 	if (ret)
 		return ret;
 
@@ -4905,6 +4912,7 @@ static int cgroup_attach_permissions(struct cgroup *src_cgrp,
 static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 				    bool threadgroup)
 {
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
 	const struct cred *saved_cred;
@@ -4932,7 +4940,8 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 */
 	saved_cred = override_creds(of->file->f_cred);
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
-					of->file->f_path.dentry->d_sb, threadgroup);
+					of->file->f_path.dentry->d_sb,
+					threadgroup, ctx->ns);
 	revert_creds(saved_cred);
 	if (ret)
 		goto out_finish;
@@ -6152,7 +6161,8 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 		goto err;
 
 	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
-					!(kargs->flags & CLONE_THREAD));
+					!(kargs->flags & CLONE_THREAD),
+					current->nsproxy->cgroup_ns);
 	if (ret)
 		goto err;
 
-- 
2.34.1

