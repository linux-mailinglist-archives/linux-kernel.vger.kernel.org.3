Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A474734CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbhLMTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhLMTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u80so15787767pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nS6KLB2wafE+xu7w3/sMdojH1TDZhD8mHEzNLFQI3Aw=;
        b=SBmC/P7A+Ykw4xrpj3cTUxgJzCid4/11wfwg2E+rjFFfEHVYF3usPW/bGDTcuxb4qX
         gq3/Kp7mbnwOaipjNa+68o4zPKpbRu2NAgzkMAFMFOWM4kDwdiFwQZbnLLH992fTRmKO
         wae6/4qFYtNfifdjtGX8gZ4y6hndbhTMgvJ4BWWS+Yi0TUTufDsL5rDzxKB5lH+9Fazg
         kHR9yVa7HW1+b0x+jez2WMHv7I/wMuarwL9LXS8CpF7K10H0iBfvnrC1rcFVd1U7Kfvq
         EcNbve+JZvRXolBA1JzbaFqeRn/tj6DmJzZ+G1tzBBViYCqR2wFU2EY2WlcnTPgxeY+S
         xYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nS6KLB2wafE+xu7w3/sMdojH1TDZhD8mHEzNLFQI3Aw=;
        b=7QQgHsojkcz49B/owVjSQByFBnBsQhkE+3HVmWX0czVRE1CgbC1ip0B9DW9oKS6cR9
         RISSBEV/y9HOinycyVzRlsO/fxGS+u0kqyuRNhVsg+8rG9EvdJnaCIYhuj4U9ZcUoo4k
         peBymlH9pgys9T9pXXJyQMynCJ8usvtPF5zpTjX8H8CU9WSmxBqWJ6ynBlgiDZvoHz82
         NuPSVJIpXUn9xMMz8st//bbqSlTPLO5r0JOT2WSYoD6rCL4a8WH+OSMw/shbgY5TaGgf
         Ymnr6ZHPZBSsjO3XYNTE7sjCbpTus0g8+ypZRm0bdvWAfbml+YQS2nvvjiyb/1jf3Vc1
         lpvQ==
X-Gm-Message-State: AOAM531ahdRvLOXNWjcRWwPJRXN41Ps1SyWFP7u82B/L8GkK4/+U7v8v
        svyBiP2PR+3VqcCZMiEeBz0=
X-Google-Smtp-Source: ABdhPJwrAaxkcmdbjjldKcmzQHPyVpQHxNfmMQvP5+7Jb+tjUFi5cM7kOEeeuQz1HHSfZiHGq+fDmw==
X-Received: by 2002:a63:5518:: with SMTP id j24mr367700pgb.401.1639423124071;
        Mon, 13 Dec 2021 11:18:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h22sm13197777pfv.25.2021.12.13.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
Date:   Mon, 13 Dec 2021 09:18:29 -1000
Message-Id: <20211213191833.916632-3-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
References: <20211213191833.916632-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of->priv is currently used by each interface file implementation to store
private information. This patch collects the current two private data usages
into struct cgroup_file_ctx which is allocated and freed by the common path.
This allows generic private data which applies to multiple files, which will
be used to in the following patch.

Note that cgroup_procs iterator is now embedded as procs.iter in the new
cgroup_file_ctx so that it doesn't need to be allocated and freed
separately.

v2: union dropped from cgroup_file_ctx and the procs iterator is embedded in
    cgroup_file_ctx as suggested by Linus.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/cgroup/cgroup-internal.h | 11 +++++++
 kernel/cgroup/cgroup.c          | 53 +++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..0ced1e04177f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -65,6 +65,17 @@ static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct cgroup_fs_context, kfc);
 }
 
+struct cgroup_file_ctx {
+	struct {
+		bool			started;
+		struct css_task_iter	iter;
+	} procs;
+
+	struct {
+		void			*trigger;
+	} psi;
+};
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2632e46da1d4..a84631d08d98 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3630,6 +3630,7 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 					  size_t nbytes, enum psi_res res)
 {
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
@@ -3648,7 +3649,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 		return PTR_ERR(new);
 	}
 
-	psi_trigger_replace(&of->priv, new);
+	psi_trigger_replace(&ctx->psi.trigger, new);
 
 	cgroup_put(cgrp);
 
@@ -3679,12 +3680,16 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
-	return psi_trigger_poll(&of->priv, of->file, pt);
+	struct cgroup_file_ctx *ctx = of->priv;
+
+	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
 }
 
 static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
-	psi_trigger_replace(&of->priv, NULL);
+	struct cgroup_file_ctx *ctx = of->priv;
+
+	psi_trigger_replace(&ctx->psi.trigger, NULL);
 }
 
 bool cgroup_psi_enabled(void)
@@ -3811,18 +3816,31 @@ static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of_cft(of);
+	struct cgroup_file_ctx *ctx;
+	int ret;
 
-	if (cft->open)
-		return cft->open(of);
-	return 0;
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	of->priv = ctx;
+
+	if (!cft->open)
+		return 0;
+
+	ret = cft->open(of);
+	if (ret)
+		kfree(ctx);
+	return ret;
 }
 
 static void cgroup_file_release(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of_cft(of);
+	struct cgroup_file_ctx *ctx = of->priv;
 
 	if (cft->release)
 		cft->release(of);
+	kfree(ctx);
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
@@ -4751,21 +4769,21 @@ void css_task_iter_end(struct css_task_iter *it)
 
 static void cgroup_procs_release(struct kernfs_open_file *of)
 {
-	if (of->priv) {
-		css_task_iter_end(of->priv);
-		kfree(of->priv);
-	}
+	struct cgroup_file_ctx *ctx = of->priv;
+
+	if (ctx->procs.started)
+		css_task_iter_end(&ctx->procs.iter);
 }
 
 static void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct kernfs_open_file *of = s->private;
-	struct css_task_iter *it = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
 
 	if (pos)
 		(*pos)++;
 
-	return css_task_iter_next(it);
+	return css_task_iter_next(&ctx->procs.iter);
 }
 
 static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
@@ -4773,21 +4791,18 @@ static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
 {
 	struct kernfs_open_file *of = s->private;
 	struct cgroup *cgrp = seq_css(s)->cgroup;
-	struct css_task_iter *it = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
+	struct css_task_iter *it = &ctx->procs.iter;
 
 	/*
 	 * When a seq_file is seeked, it's always traversed sequentially
 	 * from position 0, so we can simply keep iterating on !0 *pos.
 	 */
-	if (!it) {
+	if (!ctx->procs.started) {
 		if (WARN_ON_ONCE((*pos)))
 			return ERR_PTR(-EINVAL);
-
-		it = kzalloc(sizeof(*it), GFP_KERNEL);
-		if (!it)
-			return ERR_PTR(-ENOMEM);
-		of->priv = it;
 		css_task_iter_start(&cgrp->self, iter_flags, it);
+		ctx->procs.started = true;
 	} else if (!(*pos)) {
 		css_task_iter_end(it);
 		css_task_iter_start(&cgrp->self, iter_flags, it);
-- 
2.34.1

