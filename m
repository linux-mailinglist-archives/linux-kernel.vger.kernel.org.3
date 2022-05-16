Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3694528D08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiEPS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbiEPS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:29:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F573E0E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:29:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z39-20020a25a12a000000b0064dbcd526ffso2279305ybh.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CGsBgLCZ1E7ckC4MxiSy9sirQYDPuKObKimIDda5O9I=;
        b=VIcEg1aulc0rZskxO6n7AgH4wUYDZgUEC7oUOu3scKOOGZb8FeXCoRIkU/vsRrjNHh
         DlRqvZOUuhfgzMsvWfiCJyK2mNmrjOCc9VHGEzAD1kccaZMQZ9yPZkMLyH2RzDw3LNzX
         1PBhU4yJNowUHFBtlK3Ed0W1PJyndEH8VLNEHtwAr1WrC87xMlfp71wyzTImBu/j3Ucc
         cjn63FrlMgecWpoYTIuXzeUwMP2SNrdLRMZCvJcatCfyTFHhJvyFxjYex8589wfzjpaq
         gHyndZDEwQNQ60gC1bw2mhWXwmKcO5aZl+Tw6ivMKFCTZOiNj+SVjDPFuZPVeWjxIfkl
         cCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CGsBgLCZ1E7ckC4MxiSy9sirQYDPuKObKimIDda5O9I=;
        b=XiAnxzuriLIJT5Wf3WOzAlJ/u8RECcOEWNLJ1a/vNxjMCJk8hinJCw0K7rQwF7TVfP
         zYVIhp1+3Sf8gm6onbl1xNrprY6ssxmwXI1dIxBNgY72oqwf6hHN18yyktEwppqHxJa1
         HzDONgMQoKpLd/piMRWo1WNhVAGN+bWk9etWicoIyTmfF22CkZp+JutXKGlCDsbPZbZx
         csfdWucIBfeCQFvxOa4YU2aZWocwWtJtXcNRBuNErPCs80ghZz4S/atpkfi11byD3fa/
         /3EtvUGo2ztJtx7GVoDqCCUO8TkjXzIzSJV16g9ENVTUTkmIZ0yhGMyJ7Wm+5iFDNxtl
         xG+w==
X-Gm-Message-State: AOAM531YUPSFf7obdM9hUzHHfPEVtdyamJt2TTcVD4CiJocMcxlXCOSk
        hXTw8Cty537vH7ca4i7btyIMoLhJpIk=
X-Google-Smtp-Source: ABdhPJyjtL3SjX2c2EVY0p5QZbSrJrTJPhvHli/Dz5nPlQrg28kyyyPOGyA7ksdmcRkzjA3j43SkwwqK0fA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:e952:d4d4:b0de:c336])
 (user=haoluo job=sendgmr) by 2002:a81:2084:0:b0:2fb:7a14:ea36 with SMTP id
 g126-20020a812084000000b002fb7a14ea36mr21166392ywg.26.1652725767645; Mon, 16
 May 2022 11:29:27 -0700 (PDT)
Date:   Mon, 16 May 2022 11:28:59 -0700
Message-Id: <20220516182859.3131675-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] kernfs: Separate kernfs_pr_cont_buf and rename_lock.
From:   Hao Luo <haoluo@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the protection of kernfs_pr_cont_buf was piggy backed by
rename_lock, which means that pr_cont() needs to be protected under
rename_lock. This can cause potential circular lock dependencies.

If there is an OOM, we have the following call hierarchy:

 -> cpuset_print_current_mems_allowed()
   -> pr_cont_cgroup_name()
     -> pr_cont_kernfs_name()

pr_cont_kernfs_name() will grab rename_lock and call printk. So we have
the following lock dependencies:

 kernfs_rename_lock -> console_sem

Sometimes, printk does a wakeup before releasing console_sem, which has
the dependence chain:

 console_sem -> p->pi_lock -> rq->lock

Now, imagine one wants to read cgroup_name under rq->lock, for example,
printing cgroup_name in a tracepoint in the scheduler code. They will
be holding rq->lock and take rename_lock:

 rq->lock -> kernfs_rename_lock

Now they will deadlock.

A prevention to this circular lock dependency is to separate the
protection of pr_cont_buf from rename_lock. In principle, rename_lock
is to protect the integrity of cgroup name when copying to buf. Once
pr_cont_buf has got its content, rename_lock can be dropped. So it's
safe to drop rename_lock after kernfs_name_locked (and
kernfs_path_from_node_locked) and rely on a dedicated pr_cont_lock
to protect pr_cont_buf.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 fs/kernfs/dir.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e205fde7163a..966d24562f0f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -18,7 +18,8 @@
 #include "kernfs-internal.h"
 
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
-static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
+static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
+static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
@@ -229,12 +230,12 @@ void pr_cont_kernfs_name(struct kernfs_node *kn)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
 
-	kernfs_name_locked(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
+	kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
 	pr_cont("%s", kernfs_pr_cont_buf);
 
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
 
 /**
@@ -248,10 +249,10 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	unsigned long flags;
 	int sz;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
 
-	sz = kernfs_path_from_node_locked(kn, NULL, kernfs_pr_cont_buf,
-					  sizeof(kernfs_pr_cont_buf));
+	sz = kernfs_path_from_node(kn, NULL, kernfs_pr_cont_buf,
+				   sizeof(kernfs_pr_cont_buf));
 	if (sz < 0) {
 		pr_cont("(error)");
 		goto out;
@@ -265,7 +266,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	pr_cont("%s", kernfs_pr_cont_buf);
 
 out:
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
 
 /**
@@ -823,13 +824,12 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
-	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
-	spin_lock_irq(&kernfs_rename_lock);
+	spin_lock_irq(&kernfs_pr_cont_lock);
 
 	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
 	if (len >= sizeof(kernfs_pr_cont_buf)) {
-		spin_unlock_irq(&kernfs_rename_lock);
+		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
 
@@ -841,7 +841,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 		parent = kernfs_find_ns(parent, name, ns);
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	spin_unlock_irq(&kernfs_pr_cont_lock);
 
 	return parent;
 }
-- 
2.36.1.124.g0e6072fb45-goog

