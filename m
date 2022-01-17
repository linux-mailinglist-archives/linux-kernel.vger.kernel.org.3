Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0668490BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiAQPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:42:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiAQPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:42:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 531DF212B8;
        Mon, 17 Jan 2022 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642434168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+4ye3+lekgmAvrnZnOBgLXp/ufTElkC6yvkqhvuWSY=;
        b=aJQMHGtG53Ckxi9jkIW9G6C9V8pT6E+uYfu2E5ps85eFBVdpvrWMPll1WgGGeDP/QeuxFh
        whNNJwRMwMDbJTTY9gQ2zgNQ3mDhmu1NKyQx0Be7mdVssdHcjq3BaeW1YAWfDqtVnOKGbw
        0WO95B75SyBhXjQFkR/S9f3YFBXXytA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C44CDA3B83;
        Mon, 17 Jan 2022 15:42:47 +0000 (UTC)
Date:   Mon, 17 Jan 2022 16:42:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: Use the given gfp flag when
 allocating memory
Message-ID: <YeWOd2G69LyR3PVZ@dhcp22.suse.cz>
References: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
 <YeU8PhtvvXIWtTk/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeU8PhtvvXIWtTk/@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-01-22 10:51:59, Michal Hocko wrote:
> On Sun 16-01-22 13:49:22, Christophe JAILLET wrote:
> > kstrdup_quotable_cmdline() is given a gfp flag that is passed and used for
> > memory allocation in kstrdup_quotable() just a few lines below.
> > 
> > It looks reasonable to use this gfp value for the buffer allocated and
> > freed in kstrdup_quotable_cmdline() as well.
> > 
> > Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
> 
> I do not think this commit is changing much here. It just replaces
> GFP_TEMPORARY with GFP_KERNEL so the code has ignored the gfp mask even
> before that change.
> 
> All existing callers of kstrdup_quotable_cmdline use GFP_KERNEL so would
> it make more sense to simply drop the gfp argument altogether and use
> GFP_KERNEL internally?
> 
> Normally it is better to have a full control of the allocation mask but
> if we have any non-GFP_KERNEL caller then I would rather have the
> argument added and the function checked whether all internal paths are
> gfp mask aware.

In other words something like this:
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 2c46cd968ac4..44fde4b537f1 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -376,7 +376,7 @@ static void recover_worker(struct kthread_work *work)
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
 			comm = kstrdup(task->comm, GFP_KERNEL);
-			cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+			cmd = kstrdup_quotable_cmdline(task);
 			put_task_struct(task);
 		}
 
@@ -467,7 +467,7 @@ static void fault_worker(struct kthread_work *work)
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
 			comm = kstrdup(task->comm, GFP_KERNEL);
-			cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+			cmd = kstrdup_quotable_cmdline(task);
 			put_task_struct(task);
 		}
 
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4ba39e1403b2..7a67eee8bd0f 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -97,8 +97,8 @@ static inline void string_lower(char *dst, const char *src)
 }
 
 char *kstrdup_quotable(const char *src, gfp_t gfp);
-char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
-char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
+char *kstrdup_quotable_cmdline(struct task_struct *task);
+char *kstrdup_quotable_file(struct file *file);
 
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index d5d008f5b1d9..267e142c7e13 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -618,12 +618,13 @@ EXPORT_SYMBOL_GPL(kstrdup_quotable);
  * command line, with inter-argument NULLs replaced with spaces,
  * and other special characters escaped.
  */
-char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
+char *kstrdup_quotable_cmdline(struct task_struct *task)
 {
+	gfp_t gfp = GFP_KERNEL;
 	char *buffer, *quoted;
 	int i, res;
 
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, gfp);
 	if (!buffer)
 		return NULL;
 
@@ -651,15 +652,16 @@ EXPORT_SYMBOL_GPL(kstrdup_quotable_cmdline);
  * with special characters escaped, able to be safely logged. If
  * there is an error, the leading character will be "<".
  */
-char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
+char *kstrdup_quotable_file(struct file *file)
 {
+	gfp_t gfp = GFP_KERNEL;
 	char *temp, *pathname;
 
 	if (!file)
 		return kstrdup("<unknown>", gfp);
 
 	/* We add 11 spaces for ' (deleted)' to be appended */
-	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
+	temp = kmalloc(PATH_MAX + 11, gfp);
 	if (!temp)
 		return kstrdup("<no_memory>", gfp);
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..79322ba89913 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -23,8 +23,8 @@ static void report_load(const char *origin, struct file *file, char *operation)
 {
 	char *cmdline, *pathname;
 
-	pathname = kstrdup_quotable_file(file, GFP_KERNEL);
-	cmdline = kstrdup_quotable_cmdline(current, GFP_KERNEL);
+	pathname = kstrdup_quotable_file(file);
+	cmdline = kstrdup_quotable_cmdline(current);
 
 	pr_notice("%s %s obj=%s%s%s pid=%d cmdline=%s%s%s\n",
 		  origin, operation,
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..c87a41304b6c 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -54,8 +54,8 @@ static void __report_access(struct callback_head *work)
 		container_of(work, struct access_report_info, work);
 	char *target_cmd, *agent_cmd;
 
-	target_cmd = kstrdup_quotable_cmdline(info->target, GFP_KERNEL);
-	agent_cmd = kstrdup_quotable_cmdline(info->agent, GFP_KERNEL);
+	target_cmd = kstrdup_quotable_cmdline(info->target);
+	agent_cmd = kstrdup_quotable_cmdline(info->agent);
 
 	pr_notice_ratelimited(
 		"ptrace %s of \"%s\"[%d] was attempted by \"%s\"[%d]\n",
-- 
Michal Hocko
SUSE Labs
