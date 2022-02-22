Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7D4BF1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiBVFtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:49:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBVFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:49:18 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961298F4E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:48:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id a15-20020a17090ad80f00b001b8a1e1da50so1010405pjv.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vYqEunhu/KkkvrCVtcAZ/IBktz7bD/y5RYmB+FXwm9M=;
        b=l4pFyhnwPZYCiIGuD75Kd2iBJySA4ALu9YTOi7btZ4InnfPxYzI50wuTW6UN5529gH
         rU8VSCHZ6nGma5hpopCaZ9FtHcZiHoefHIYbfHfIjLCUyS6Bjy5dlAXOxk2zmfCPHXyX
         fvHv8aBK2tv+B/eY9K50OPpJPIWyerAph1wRy7Ngg8scbBigtPeKzzbWr6qvT1KOAcwj
         jeOcDzf1hICZShCh4ja7GjqWMz8uRWPDDqoIZlCmCTkdKNBOoHmDXVcRaQO/jr51N8oZ
         zoTPVnJm/J1PSsKDEYydGKgDLyE/iRPqSRl32mXEopj8EIzDydsBXXu1LwtnHNlu6bFM
         /7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vYqEunhu/KkkvrCVtcAZ/IBktz7bD/y5RYmB+FXwm9M=;
        b=MYI/9ptXqLYIQgy5d9VIqb6tXbEH0zkIIr9MBz7pgRujiPdL6k4GsG6rXaKyJ+zEz2
         046sKYRYSqWNfNAdQiSn7fTvv/Jt8+/DC/IDkxVVDzgD9Z9Zh/KV78/xDPOCumKM6CF0
         kz/UPvknElSZXvBE1tm5ZGgGZhj0ky9nQ8WtEPKuqW8V6LdSyAu2bpwghWeOuCLrAEGj
         QT78oc9Iq0exHiWUskg6o9C+XezP40k56KGjJiJrsDBKPrgbW4nB7mLaRVwu9eUxZWs/
         nOH8K0llGOR37xhFDGHnZWzeJ7IyFa/Q9Yk9DPWZAFmaL2Jzr+NblDf3iTDpe4+JjMGB
         /tfA==
X-Gm-Message-State: AOAM533Ktm6DShsdVniG8xCp+C4v8FNXtZPFwUhvNg7QDmMT7TdGozaX
        eHFmMPVZXXladN1fKIi+hhvWap8f/xDi
X-Google-Smtp-Source: ABdhPJx24KtHMYp7elwgwkTvRMMRg0uiLVvq5dDP7PfUsIQBi1+d2j1aY7UGpF6ytXdJwFqYOan3fDP3CAP9
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a62:7c56:0:b0:4f0:f268:ec03 with SMTP id
 x83-20020a627c56000000b004f0f268ec03mr16839218pfc.8.1645508932777; Mon, 21
 Feb 2022 21:48:52 -0800 (PST)
Date:   Tue, 22 Feb 2022 05:48:48 +0000
Message-Id: <20220222054848.563321-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v4] KVM: Move VM's worker kthreads back to the original cgroup
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
exit_mm(). Therefore, A VM process can terminate in between the
exit_mm() and cgroup_exit() calls, leaving only worker kthreads in the
cgroup.

Moving worker kthreads back to the original cgroup (kthreadd_task's
cgroup) makes sure that the cgroup is empty as soon as the main VM
process is terminated.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
---

Thanks Sean, for the example on how to use the real_parent outside of the RCU
critical region. I wrote your name in Suggested-by, I hope you are fine with
it and this is the right tag/way to give you the credit.

v4:
- Read task's real_parent in the RCU critical section.
- Don't log error message from the cgroup_attach_task_all() API.

v3: https://lore.kernel.org/lkml/20220217061616.3303271-1-vipinsh@google.com/
- Use 'current->real_parent' (kthreadd_task) in the
  cgroup_attach_task_all() call.
- Revert cgroup APIs changes in v2. Now, patch does not touch cgroup
  APIs.
- Update commit and comment message

v2: https://lore.kernel.org/lkml/20211222225350.1912249-1-vipinsh@google.com/
- Use kthreadd_task in the cgroup API to avoid build issue.

v1: https://lore.kernel.org/lkml/20211214050708.4040200-1-vipinsh@google.com/

 virt/kvm/kvm_main.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 83c57bcc6eb6..cdf1fa3c60ae 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5810,6 +5810,7 @@ static int kvm_vm_worker_thread(void *context)
 	 * we have to locally copy anything that is needed beyond initialization
 	 */
 	struct kvm_vm_worker_thread_context *init_context = context;
+	struct task_struct *parent;
 	struct kvm *kvm = init_context->kvm;
 	kvm_vm_thread_fn_t thread_fn = init_context->thread_fn;
 	uintptr_t data = init_context->data;
@@ -5836,7 +5837,7 @@ static int kvm_vm_worker_thread(void *context)
 	init_context = NULL;
 
 	if (err)
-		return err;
+		goto out;
 
 	/* Wait to be woken up by the spawner before proceeding. */
 	kthread_parkme();
@@ -5844,6 +5845,25 @@ static int kvm_vm_worker_thread(void *context)
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
+	rcu_read_lock();
+	parent = rcu_dereference(current->real_parent);
+	get_task_struct(parent);
+	rcu_read_unlock();
+	cgroup_attach_task_all(parent, current);
+	put_task_struct(parent);
+
 	return err;
 }
 

base-commit: 1bbc60d0c7e5728aced352e528ef936ebe2344c0
-- 
2.35.1.473.g83b2b277ed-goog

