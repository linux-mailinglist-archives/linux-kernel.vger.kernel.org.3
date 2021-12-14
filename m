Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66D7474C33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhLNToc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLNTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:44:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:44:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k26so18698684pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7tGK1Fhp6JjhpXXN4wfQH9yatHwcp9tuM7l+M2TpL1g=;
        b=Tzzc79Bg4cqfKKs09ztNDsGwoTxBrdwPcRbBKEsq/2X0YJWIqwHcYjbSD1mXGmAJRY
         pBsV5AedqX56r3DfB6lnWkmFK3c9FOw4Zo+VumFHiXtP924Syn/y/CQhAu7vcrDHMAak
         ipRy9xTNgYFuNSePJSHGUuOmkXn2sOKIFLTkuMVmHXWL226FwHNloY706DeoqrCfzZtD
         HZ02fl3rSONuOhShTf1NdJe05qiM8w3v9d/FkLTYHNo0FwPcIskiAWyrmM8Hwi9kqkxg
         QUtjvo/+OOWOGymThVAuA8z2DG4BNXosAoTtirdpaPUPEmjAzvS5E3gCn4xngbCTUjte
         whXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7tGK1Fhp6JjhpXXN4wfQH9yatHwcp9tuM7l+M2TpL1g=;
        b=WRgYge+uiKbXeJs0lOt81TObkoE+cV6gR6J9Wz6dYG0pnn0CGgInJ4CuMdlpXB2Mml
         HP6EV9RmDnoP9G7N+jZ245itGDo2G9jlSIHu6b3cOjOQYC3JrAzp9W03gBjQy/V6PM04
         ne4IV4fj6fycs+5bMTqBxgrNk4IQp3WGCgmf0Nm3anpL9gM8AKLaUQvrHzWhe3tXdrqB
         cSxbRO4ZV7MSHKtfWFHHG+BvIViNWIf7J1eu2LCMgdE+baQY5mOWMhGFxxp8QwoyJ8xi
         w15yAN2TsC4dCd+ZLRWV4SFnRPtxVqNtwHQBz2/bKB8wM0lNFSCodLhv7QAoiBdtUc5R
         YfEQ==
X-Gm-Message-State: AOAM53328ZHKuwCNm+yu4lOyVyR+YJeV3/1f2pHhitLoGdR/iiupO2cT
        pJes1zop2uFJzW/fqbMAPJY=
X-Google-Smtp-Source: ABdhPJyDiZO7Pt9lCRpx4TZaNspqECXbrlUrHttg1iLCrk4dK6fTucD6SFYFsbZs//RqEJY+YL+/7w==
X-Received: by 2002:a63:6909:: with SMTP id e9mr5155926pgc.7.1639511068288;
        Tue, 14 Dec 2021 11:44:28 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c11sm3045711pji.42.2021.12.14.11.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:44:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Dec 2021 09:44:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <Ybj0GqMfY4n2TSSn@slm.duckdns.org>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-3-tj@kernel.org>
 <20211214170352.GA7969@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214170352.GA7969@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9a572a58dc5b8046e22550301581d95e2b62fbcd Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 14 Dec 2021 09:42:03 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

v3: Michal pointed out that cgroup1's procs pidlist uses of->priv too.
    Converted. Didn't change to embedded allocation as cgroup1 pidlists get
    stored for caching.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
The rest of the patchset applies as-is. The following git branch contains
the latest.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-migration-perms-2

Thanks.

 kernel/cgroup/cgroup-internal.h | 17 +++++++++++
 kernel/cgroup/cgroup-v1.c       | 26 ++++++++--------
 kernel/cgroup/cgroup.c          | 53 +++++++++++++++++++++------------
 3 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..cf637bc4ab45 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -65,6 +65,23 @@ static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct cgroup_fs_context, kfc);
 }
 
+struct cgroup_pidlist;
+
+struct cgroup_file_ctx {
+	struct {
+		void			*trigger;
+	} psi;
+
+	struct {
+		bool			started;
+		struct css_task_iter	iter;
+	} procs;
+
+	struct {
+		struct cgroup_pidlist	*pidlist;
+	} procs1;
+};
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 0e7369103ba6..41e0837a5a0b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -394,6 +394,7 @@ static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
 	 * next pid to display, if any
 	 */
 	struct kernfs_open_file *of = s->private;
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *cgrp = seq_css(s)->cgroup;
 	struct cgroup_pidlist *l;
 	enum cgroup_filetype type = seq_cft(s)->private;
@@ -403,25 +404,24 @@ static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
 	mutex_lock(&cgrp->pidlist_mutex);
 
 	/*
-	 * !NULL @of->priv indicates that this isn't the first start()
-	 * after open.  If the matching pidlist is around, we can use that.
-	 * Look for it.  Note that @of->priv can't be used directly.  It
-	 * could already have been destroyed.
+	 * !NULL @ctx->procs1.pidlist indicates that this isn't the first
+	 * start() after open. If the matching pidlist is around, we can use
+	 * that. Look for it. Note that @ctx->procs1.pidlist can't be used
+	 * directly. It could already have been destroyed.
 	 */
-	if (of->priv)
-		of->priv = cgroup_pidlist_find(cgrp, type);
+	if (ctx->procs1.pidlist)
+		ctx->procs1.pidlist = cgroup_pidlist_find(cgrp, type);
 
 	/*
 	 * Either this is the first start() after open or the matching
 	 * pidlist has been destroyed inbetween.  Create a new one.
 	 */
-	if (!of->priv) {
-		ret = pidlist_array_load(cgrp, type,
-					 (struct cgroup_pidlist **)&of->priv);
+	if (!ctx->procs1.pidlist) {
+		ret = pidlist_array_load(cgrp, type, &ctx->procs1.pidlist);
 		if (ret)
 			return ERR_PTR(ret);
 	}
-	l = of->priv;
+	l = ctx->procs1.pidlist;
 
 	if (pid) {
 		int end = l->length;
@@ -449,7 +449,8 @@ static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
 static void cgroup_pidlist_stop(struct seq_file *s, void *v)
 {
 	struct kernfs_open_file *of = s->private;
-	struct cgroup_pidlist *l = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
+	struct cgroup_pidlist *l = ctx->procs1.pidlist;
 
 	if (l)
 		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork,
@@ -460,7 +461,8 @@ static void cgroup_pidlist_stop(struct seq_file *s, void *v)
 static void *cgroup_pidlist_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct kernfs_open_file *of = s->private;
-	struct cgroup_pidlist *l = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
+	struct cgroup_pidlist *l = ctx->procs1.pidlist;
 	pid_t *p = v;
 	pid_t *end = l->list + l->length;
 	/*
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

