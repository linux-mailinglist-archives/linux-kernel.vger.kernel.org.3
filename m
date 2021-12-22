Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688A947D96F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 23:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhLVWxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 17:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLVWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 17:53:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 14:53:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i8-20020a639d08000000b00340a257c531so2160565pgd.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oNIAkp8neiAB7783twgZn/TOQ9PM7zBBm/WLvA2Zt9k=;
        b=nDgKUnHCmPH/1PpVRNkhtBbODzY52sRC85PwAtvQUnxfM7N0o2wARPvR/muu5AzNw8
         82cyvFCb7Wj2w1u8zWMcOp8QNYGwL/2akDv6EUHpnUXxu7IpBCoweLw3zuLlYHP1E6yd
         n3d2lnpsWohoKv+dDK7C02guj1oMsXtAJzdS8se6b3xhLXLG9/jwJIVUlRUThhIFjvTT
         FRpeqgNndxxn5LjOdn7F4nrR24PUQ0km7DJLYwb393Z2d0MIPZAHiX9FtcTYHy+MuVKk
         JqO6jT+Vt5UiwwOzBrhnUXfeg4HbfrUyflH5D6G8Qo/DNptyIxJFaaKQgcLmRgPMBqf5
         yeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oNIAkp8neiAB7783twgZn/TOQ9PM7zBBm/WLvA2Zt9k=;
        b=iowpAJfW1cUI86i+R76uZuW7SNA6je3n/35owP3ezbODzcuVjup1zNwT29M4iwdlDl
         QeBgJhlSUrLEZzjpvIiK2YYsx3ApuOt71HDHildyFifvHKg/y86iWfL/z+qC0Ix2evbp
         +ylOHcEfUeRCCpZhdLa/rJVgcarGg2Riy4TKps8ugRh6XswRKs2FKb0tSqniZ2FaYxPs
         0A889z+1lRNthqVo1y1zXHgmD7lqQQ/x2D2ljqfyKn7co9ZlHcyL47ubvrkXN0gCntl6
         xqcg3yBw5m/Nhv85m2mH7a2S+2m2HTxueWUp251ZymvPq1xUMYwJOy5crsY8K4TItNFk
         4CPA==
X-Gm-Message-State: AOAM531BUFClPdDrzWca7Ojk5h4IEQz64peZOgl/iEcfBuBl63JIQ1tE
        eiu8mrcxGMS7aqEj9fOnIJzdaCnV+1nH
X-Google-Smtp-Source: ABdhPJz6QB+cG99ugzQmXA5S7F0yVd27ghimYtU78fR/JgqN0PW8ZMeyet2eEfgFWR9J8AF8DO/4oQPlVWog
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:903:2c2:b0:148:aef8:4483 with SMTP id
 s2-20020a17090302c200b00148aef84483mr4556771plk.19.1640213633308; Wed, 22 Dec
 2021 14:53:53 -0800 (PST)
Date:   Wed, 22 Dec 2021 22:53:50 +0000
Message-Id: <20211222225350.1912249-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     dmatlack@google.com, jiangshanlai@gmail.com, kvm@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM worker kthreads can linger in the VM process's cgroup for sometime
after KVM terminates the VM process.

KVM terminates the worker kthreads by calling kthread_stop() which waits
on the 'exited' completion, triggered by exit_mm(), via mm_release(),
during kthread's exit.  However, these kthreads are removed from the
cgroup using cgroup_exit() call which happens after exit_mm(). A VM
process can terminate between the time window of exit_mm() to
cgroup_exit(), leaving only worker kthreads in the cgroup.

Moving worker kthreads back to the original cgroup (kthreadd_task's
cgroup) makes sure that cgroup is empty as soon as the main VM process
is terminated.

kthreadd_task is not an exported symbol which causes build errors if KVM
is built as a loadable module. Both users (kvm_main & vhost) of
cgroup_attach_task_all(), have the same issue, therefore, using
kthreadd_task as a default option is chosen when the API is called with
NULL argument.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---

v2:
- Use kthreadd_task in the cgroup API to avoid build issue.

v1: https://lore.kernel.org/lkml/20211214050708.4040200-1-vipinsh@google.com/

 kernel/cgroup/cgroup-v1.c |  5 +++++
 virt/kvm/kvm_main.c       | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 81c9e0685948..81d4b2f2acf0 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -51,6 +51,8 @@ bool cgroup1_ssid_disabled(int ssid)
  * @from: attach to all cgroups of a given task
  * @tsk: the task to be attached
  *
+ * If @from is NULL then use kthreadd_task for finding the destination cgroups.
+ *
  * Return: %0 on success or a negative errno code on failure
  */
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
@@ -58,6 +60,9 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
+	if (!from)
+		from = kthreadd_task;
+
 	mutex_lock(&cgroup_mutex);
 	percpu_down_write(&cgroup_threadgroup_rwsem);
 	for_each_root(root) {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b0f7e6eb00ff..f7504578c374 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5785,7 +5785,7 @@ static int kvm_vm_worker_thread(void *context)
 	init_context = NULL;
 
 	if (err)
-		return err;
+		goto out;
 
 	/* Wait to be woken up by the spawner before proceeding. */
 	kthread_parkme();
@@ -5793,6 +5793,19 @@ static int kvm_vm_worker_thread(void *context)
 	if (!kthread_should_stop())
 		err = thread_fn(kvm, data);
 
+out:
+	/*
+	 * We need to move the kthread back to its original cgroups, so that it
+	 * doesn't linger in the cgroups of the user process after the user
+	 * process has already terminated.
+	 *
+	 * kthread_stop() waits on 'exited' completion condition which is set
+	 * in exit_mm(), via mm_release(), in do_exit(). However, kthread
+	 * is removed from cgroups in the cgroup_exit() which is called after
+	 * exit_mm(). This causes lingering of kthreads in cgroups after main
+	 * VM process has finished.
+	 */
+	WARN_ON(cgroup_attach_task_all(NULL, current));
 	return err;
 }
 

base-commit: 5e4e84f1124aa02643833b7ea40abd5a8e964388
-- 
2.34.1.307.g9b7440fafd-goog

