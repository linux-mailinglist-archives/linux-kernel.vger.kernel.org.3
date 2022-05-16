Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB9528DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbiEPTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiEPTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:09:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749A39164
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:09:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b94-20020a25a267000000b0064ba19b0dedso7590741ybi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OsfXXuRBMtyyl4vBjBv793drneZEBuNK1ZgrRoVyJEE=;
        b=H6qVcawecXcVuKBkgGDdR5WWZXwaZzeFs3wdTjIvH7IVnzSO+AlfDGdcDQ8APaJ/GV
         i/FgdgFOVfUDu/6fFEm0GgtFffPLah+qnuPrZbT3KbG2wzEQJlT43xo7gUFBzDCO5J32
         nTaAmp66RykdnzhkspOQujBiYffSrjxNX05ECj3A5oCiePv7KcjwN1syyjq2rquatFXE
         jjKUGQg03o8a6Avd1R05Fxz45o9VfrgCKL3tQxKyfxxJuKrxRjiG9D+17Ep0HgebdmRI
         P7G/yFqHInKR/BaJ3p2TO/FjMxIz1Oj1bWk2IQgACctuhE8TGXG/zaRwzgliwDql5HgW
         EOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OsfXXuRBMtyyl4vBjBv793drneZEBuNK1ZgrRoVyJEE=;
        b=HpfNBxBCoZhO2wZZXMEU+J1zZZrMHD5KA9oryyUf/RP2O6BXb07pFcR0/LejS6OVc2
         8ex0+SPSAncfpHzpia+O9ZcIVmZFF40MZjHFT4IsK8mhmo9D0+MbdFikGCTRMJuTZSWT
         5ksbALROY0cjzONFOBTtsVYvrIuHnoA9YVkiY+KIw/A+ref/JBnbFbc6Kad81bQYF6cb
         1nOiU9pMDxbQk65owo/vAObio9eh/oNPT32ar1ptMK/dbI/vrFxMxAP6SN/E1k/VyHgg
         sW63TYxwg93nBRGbShjk6/nuSsLH+4n0fX1qggGSWqr3ZLrybeLCn5unegvDnSE9Kmdu
         LHhA==
X-Gm-Message-State: AOAM533h6wbkZG3q+JAo3ZZ/goIKqC1FApZtJLBBZu8sbTjMnXmL8HHN
        Jnj0WfPGJ6Wb6cfoXweZmLGFo8kHA+s=
X-Google-Smtp-Source: ABdhPJzHn9obxwzCw/t1KsdsQpcnOlbeyWKX3+K+W78Qasij2Bb0eKBEK44BUWcQ/af+ijFcNjipQ6Q8cek=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:e952:d4d4:b0de:c336])
 (user=haoluo job=sendgmr) by 2002:a05:6902:507:b0:64d:e8c6:942c with SMTP id
 x7-20020a056902050700b0064de8c6942cmr1893070ybs.267.1652728197301; Mon, 16
 May 2022 12:09:57 -0700 (PDT)
Date:   Mon, 16 May 2022 12:09:51 -0700
Message-Id: <20220516190951.3144144-1-haoluo@google.com>
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

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 fs/kernfs/dir.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e205fde7163a..6eca72cfa1f2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -18,7 +18,15 @@
 #include "kernfs-internal.h"
 
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
-static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
+/*
+ * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
+ * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
+ * will perform wakeups when releasing console_sem. Holding rename_lock
+ * will introduce deadlock if the scheduler reads the kernfs_name in the
+ * wakeup path.
+ */
+static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
+static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
@@ -229,12 +237,12 @@ void pr_cont_kernfs_name(struct kernfs_node *kn)
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
@@ -248,10 +256,10 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
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
@@ -265,7 +273,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	pr_cont("%s", kernfs_pr_cont_buf);
 
 out:
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
 
 /**
@@ -823,13 +831,12 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 
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
 
@@ -841,7 +848,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 		parent = kernfs_find_ns(parent, name, ns);
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	spin_unlock_irq(&kernfs_pr_cont_lock);
 
 	return parent;
 }
-- 
2.36.1.124.g0e6072fb45-goog

