Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1771C4B9912
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiBQGQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:16:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiBQGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:16:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501352A2297
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:16:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso2794618pjq.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+ImC79Dcr6MPcSexLv46tRLEGOitgoCcctAfOPO5qjY=;
        b=YNCjCeuT5YwOr8Vwll+nu+pLmG5IRCsOmwtIXVBSpZ9mO3kW7DRPbjJPbhz36fdUtf
         Y+5Z2xT0WVGttuPyK/7l91ZtKqwGZar8SyzqEtQ1kYlfu6yDD1CA1q0W6WuMCHCbX+By
         jFkNLehZQjKpcbJqc/Bbr4VeR55M+Q8TCVdKl3jAodvkAXAELlXZEA4U/5QOslMZQDI0
         /x4Iq4ezjYggiFwXGZ4j0ZVduynMWRU+TnVpaqNXcXC81Vo+azZa4t6v23aNJBQpkmJr
         EHNBQD6OWHFtMqqBfQgg+NJysxYuTnbJMOjqK8qCstomIvIxxiTsK9eWe8ya3vqYxkLE
         Fpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+ImC79Dcr6MPcSexLv46tRLEGOitgoCcctAfOPO5qjY=;
        b=O5rGyE4GXCud8N4LODWmxC4fbZI/yfdt+eg0nKQqdthsvHj5FUmz2cwJKxUfflFOID
         em2umwE6yRetchj4nFqQ4Ukps1lDoDT9b21TIW3EVK7YmhaUmsHbxLd6CD1xOV3Tx8uf
         e331eyC33p7HV4sO0wWveaR0avN1DJANxKTQEwU7rJIfT3oUI8YHm2f6/pYow1dxGQtg
         bJzT4nhGQpsDiqVYW2ttFq83QXZjhst1CH/Byd08x1SpHcgBdoSA3afjqV8vrl6kwccj
         PkQwjrUW4sd+w9O9sXXfuucbaxURCvf+yz8vSehNH5jZw0qJ9j0edD+5oy3MpQOXH4gs
         HHFg==
X-Gm-Message-State: AOAM532XDG6iCm6IR5VI8KLkgBSM0eyQIu2WXcFna1iUdqLrWSYXS1xc
        2IRyhXc062cdaq1fN0k4GwsxuejtBrNe
X-Google-Smtp-Source: ABdhPJxklgUIr46F4p0ISbx+SjpyDWWTjEIrYfiou9Y+av2WQ/seEA4Ut6+gzzQTPT+ONtwGkBNgQGE/S22T
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id
 az5-20020a170902a58500b0014d58ef0065mr1504289plb.139.1645078580734; Wed, 16
 Feb 2022 22:16:20 -0800 (PST)
Date:   Thu, 17 Feb 2022 06:16:16 +0000
Message-Id: <20220217061616.3303271-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3] KVM: Move VM's worker kthreads back to the original cgroup
 before exiting.
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com
Cc:     mkoutny@suse.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, dmatlack@google.com, jiangshanlai@gmail.com,
        kvm@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

VM worker kthreads can linger in the VM process's cgroup for sometime
after KVM terminates the VM process.

KVM terminates the worker kthreads by calling kthread_stop() which waits
on the 'exited' completion, triggered by exit_mm(), via mm_release(), in
do_exit() during the kthread's exit.  However, these kthreads are
removed from the cgroup using the cgroup_exit() which happens after the
exit_mm(). Therefore, a VM process can terminate in between the
exit_mm() and cgroup_exit() calls, leaving only worker kthreads in the
cgroup.

Moving worker kthreads back to the original cgroup (kthreadd_task's
cgroup) makes sure that the cgroup is empty as soon as the main VM
process is terminated.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---

v3:
- Use 'current->real_parent' (kthreadd_task) in the
  cgroup_attach_task_all() call.
- Revert cgroup APIs changes in v2. Now, patch does not touch cgroup
  APIs.
- Update commit and comment message

v2: https://lore.kernel.org/lkml/20211222225350.1912249-1-vipinsh@google.com/
- Use kthreadd_task in the cgroup API to avoid build issue.

v1: https://lore.kernel.org/lkml/20211214050708.4040200-1-vipinsh@google.com/

 virt/kvm/kvm_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 83c57bcc6eb6..2c9dcfffb606 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5813,7 +5813,7 @@ static int kvm_vm_worker_thread(void *context)
 	struct kvm *kvm = init_context->kvm;
 	kvm_vm_thread_fn_t thread_fn = init_context->thread_fn;
 	uintptr_t data = init_context->data;
-	int err;
+	int err, reattach_err;
 
 	err = kthread_park(current);
 	/* kthread_park(current) is never supposed to return an error */
@@ -5836,7 +5836,7 @@ static int kvm_vm_worker_thread(void *context)
 	init_context = NULL;
 
 	if (err)
-		return err;
+		goto out;
 
 	/* Wait to be woken up by the spawner before proceeding. */
 	kthread_parkme();
@@ -5844,6 +5844,23 @@ static int kvm_vm_worker_thread(void *context)
 	if (!kthread_should_stop())
 		err = thread_fn(kvm, data);
 
+out:
+	/*
+	 * Move kthread back to its original cgroup to prevent it lingering in
+	 * the cgroup of the VM process, after the latter finishes its
+	 * execution.
+	 *
+	 * kthread_stop() waits on the 'exited' completion condition which is
+	 * set in exit_mm(), via mm_release(), in do_exit(). However, the
+	 * kthread is removed from the cgroup in the cgroup_exit() which is
+	 * called after the exit_mm(). This causes the kthread_stop() to return
+	 * before the kthread actually quits the cgroup.
+	 */
+	reattach_err = cgroup_attach_task_all(current->real_parent, current);
+	if (reattach_err) {
+		kvm_err("%s: cgroup_attach_task_all failed on reattach with err %d\n",
+			__func__, reattach_err);
+	}
 	return err;
 }
 

base-commit: db6e7adf8de9b3b99a9856acb73870cc3a70e3ca
-- 
2.35.1.265.g69c8d7142f-goog

