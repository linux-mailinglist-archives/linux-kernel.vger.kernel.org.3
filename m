Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1992146DEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbhLHXLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLHXL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:11:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175FC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 15:07:57 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r138so3353725pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9L/jg5ACJ0+PPXFsqZL+EcDsDoq5cJ70y60xl2x8iuw=;
        b=iQlKhrlR3nnsWj8zf70lcN1k5rnRZHXZP5jHZrlqF9JxDWNs5L3i/i6GLRzI55tvPA
         UlwVvZz02ninCSF70Fau0ohsiUBrTVluv+elZuGHt+IuU8ix/YM2V59xPWla4L7hYYii
         OwDnDV6eVWsZrUf+OatqSCfOyPDbrkRpcn/xkGJWDuTqa2nXRzHG5Cswm9OqdU+ed9M6
         GLLsto+7mvEYlQYeZ2Y8kaH5y4/jeffikTayasiIEDFhaQ70k/WhzRud/PqWppwYMNtA
         FgbmcVAIDJWkZvOBNo/NLq6Yx17y5OiNxoAFjQDgIVlv/uhF57bgOTLMt2n4Tw6+VWcS
         B3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9L/jg5ACJ0+PPXFsqZL+EcDsDoq5cJ70y60xl2x8iuw=;
        b=aP0Rfsg70Oql29HI3jIZzvRj92zjvkx8F7dvq/I6bHOJ2rq10qGGRtotmnSRjmhplg
         Lrs/kJTsBIvgLW2/bhBr17tLA+nRTwgBMPbD6LXRak5kmPSw9L5wjiYhrjx5+pLwkrxU
         QIUo/F44ZzZ3B3QtZx04SHJata6dSLWK32iXF27BtAgK+xsKN5/AmOuDSEt0izzM91lP
         EAtjsfUTbQJouch8GfaEbzfxdxdliM9ux+L3pC7VMu6qWo1O1mjk0s/2Y7+Ju2WWfo16
         iLmKumwG66C8hBU52kuqQ3Ou2Ogd0X4f+rb/NvIeyIWSFGh0vTmlaFecXkNUvwgbVoCD
         A28A==
X-Gm-Message-State: AOAM531BGSZ+wD2fYllo6rtn4tOKVNVgpt2UftWKFOChJSLg3qHdTQ6x
        LLLqeGKzlX7D3QS+LVYGqmA=
X-Google-Smtp-Source: ABdhPJwejsJm+I0VrqJDqvVWaJW/MIevtth9usZ7SFRejHA6fBEW4a6Qark3NpB85yXM64edIWOFOQ==
X-Received: by 2002:a63:1b11:: with SMTP id b17mr31507489pgb.378.1639004876527;
        Wed, 08 Dec 2021 15:07:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j13sm4893630pfc.151.2021.12.08.15.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:07:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Dec 2021 13:07:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Security Officers <security@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <YbE6yvMav5Xtp5HO@slm.duckdns.org>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbEMPal0sKkk0+Tl@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 08, 2021 at 09:49:17AM -1000, Tejun Heo wrote:
> >  (b) alternatively, go ahead and do the permission check at IO time,
> > but do it using "file->f_cred" (ie the open-time permission), not the
> > current process ones.

So, I have sth like the following. It builds and euid-open test case behaves
as expected (can't evade delegation restrictions if the fd was opened with
lesser euid). The namespace part is a bit more involved as f_cred doesn't
capture them on open. I made cgroup file open path capture it and use that
for all permission checks. Please let me know if anything looks weird.
Otherwise, I'm gonna add selftests and prep the patchset.

Thanks.

Index: work/kernel/cgroup/cgroup-v1.c
===================================================================
--- work.orig/kernel/cgroup/cgroup-v1.c
+++ work/kernel/cgroup/cgroup-v1.c
@@ -504,10 +504,11 @@ static ssize_t __cgroup1_procs_write(str
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
Index: work/kernel/cgroup/cgroup.c
===================================================================
--- work.orig/kernel/cgroup/cgroup.c
+++ work/kernel/cgroup/cgroup.c
@@ -3630,6 +3630,7 @@ static int cgroup_cpu_pressure_show(stru
 static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 					  size_t nbytes, enum psi_res res)
 {
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
@@ -3648,7 +3649,7 @@ static ssize_t cgroup_pressure_write(str
 		return PTR_ERR(new);
 	}
 
-	psi_trigger_replace(&of->priv, new);
+	psi_trigger_replace(&ctx->psi.trigger, new);
 
 	cgroup_put(cgrp);
 
@@ -3679,12 +3680,16 @@ static ssize_t cgroup_cpu_pressure_write
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
@@ -3811,24 +3816,42 @@ static ssize_t cgroup_kill_write(struct
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
+
+	ctx->ns = current->nsproxy->cgroup_ns;
+	get_cgroup_ns(ctx->ns);
+
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
+	put_cgroup_ns(ctx->ns);
+	kfree(ctx);
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *cgrp = of->kn->parent->priv;
 	struct cftype *cft = of_cft(of);
 	struct cgroup_subsys_state *css;
@@ -3845,7 +3868,7 @@ static ssize_t cgroup_file_write(struct
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
 	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-	    ns != &init_cgroup_ns && ns->root_cset->dfl_cgrp == cgrp)
+	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
 		return -EPERM;
 
 	if (cft->write)
@@ -4751,21 +4774,23 @@ void css_task_iter_end(struct css_task_i
 
 static void cgroup_procs_release(struct kernfs_open_file *of)
 {
-	if (of->priv) {
-		css_task_iter_end(of->priv);
-		kfree(of->priv);
+	struct cgroup_file_ctx *ctx = of->priv;
+
+	if (ctx->procs.it) {
+		css_task_iter_end(ctx->procs.it);
+		kfree(ctx->procs.it);
 	}
 }
 
 static void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct kernfs_open_file *of = s->private;
-	struct css_task_iter *it = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
 
 	if (pos)
 		(*pos)++;
 
-	return css_task_iter_next(it);
+	return css_task_iter_next(ctx->procs.it);
 }
 
 static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
@@ -4773,7 +4798,8 @@ static void *__cgroup_procs_start(struct
 {
 	struct kernfs_open_file *of = s->private;
 	struct cgroup *cgrp = seq_css(s)->cgroup;
-	struct css_task_iter *it = of->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
+	struct css_task_iter *it = ctx->procs.it;
 
 	/*
 	 * When a seq_file is seeked, it's always traversed sequentially
@@ -4786,7 +4812,7 @@ static void *__cgroup_procs_start(struct
 		it = kzalloc(sizeof(*it), GFP_KERNEL);
 		if (!it)
 			return ERR_PTR(-ENOMEM);
-		of->priv = it;
+		ctx->procs.it = it;
 		css_task_iter_start(&cgrp->self, iter_flags, it);
 	} else if (!(*pos)) {
 		css_task_iter_end(it);
@@ -4838,9 +4864,9 @@ static int cgroup_may_write(const struct
 
 static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 					 struct cgroup *dst_cgrp,
-					 struct super_block *sb)
+					 struct super_block *sb,
+					 struct cgroup_namespace *ns)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup *com_cgrp = src_cgrp;
 	int ret;
 
@@ -4869,11 +4895,12 @@ static int cgroup_procs_write_permission
 
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
 
@@ -4890,8 +4917,10 @@ static int cgroup_attach_permissions(str
 static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 				    bool threadgroup)
 {
+	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
+	const struct cred *saved_cred;
 	ssize_t ret;
 	bool locked;
 
@@ -4909,9 +4938,16 @@ static ssize_t __cgroup_procs_write(stru
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
-					of->file->f_path.dentry->d_sb, threadgroup);
+					of->file->f_path.dentry->d_sb,
+					threadgroup, ctx->ns);
+	revert_creds(saved_cred);
 	if (ret)
 		goto out_finish;
 
@@ -6130,7 +6166,8 @@ static int cgroup_css_set_fork(struct ke
 		goto err;
 
 	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
-					!(kargs->flags & CLONE_THREAD));
+					!(kargs->flags & CLONE_THREAD),
+					current->nsproxy->cgroup_ns);
 	if (ret)
 		goto err;
 
Index: work/kernel/cgroup/cgroup-internal.h
===================================================================
--- work.orig/kernel/cgroup/cgroup-internal.h
+++ work/kernel/cgroup/cgroup-internal.h
@@ -65,6 +65,20 @@ static inline struct cgroup_fs_context *
 	return container_of(kfc, struct cgroup_fs_context, kfc);
 }
 
+struct cgroup_file_ctx {
+	struct cgroup_namespace	*ns;
+
+	union {
+		struct {
+			struct css_task_iter	*it;
+		} procs;
+
+		struct {
+			void			*trigger;
+		} psi;
+	};
+};
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
