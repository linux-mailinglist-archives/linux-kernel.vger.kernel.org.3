Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F073B497D70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiAXKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiAXKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566FC061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 540DC612F2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD27EC340E9;
        Mon, 24 Jan 2022 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643021588;
        bh=0IJRbMvxIVHHKgHnDPeMAzag7U1Dn6cvWSryKx8Upv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acfqtPz+zBjNDnVpyyoMsdlXbyztoTH9bmR10JfSI+5poMudCH6tyXdZSavN96FBl
         3/RU9qsnXyw8uK2FZ4zsNaYcaRACC2lv9bFbsHIE/cbZxCJJhAM+wmlQplwU3VGMag
         NNg+SpDP77Rh0DbVjYcIPkFJzJzKF6yTGMf1dbMS1Qp9dOwgEK3haPzbZEh/C9sJ+6
         +XAwVio+s1RrbXSDQamm/MDelol/RDOhXEe7HYuQRbV5ED5dJGlHuw6plsK0xIACkk
         yah272oYrcohmiGv06G95zXoOsqd5k8kOaxUjbtQnze+YjBqVgWhuNFjsaWuUIxIYk
         VRBhz9WeR+u/Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [resend RFC 2/3] sched/prctl: add PR_SCHED_CORE_SHARE command
Date:   Mon, 24 Jan 2022 11:52:46 +0100
Message-Id: <20220124105247.2118990-3-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124105247.2118990-1-brauner@kernel.org>
References: <20220124105247.2118990-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12803; h=from:subject; bh=0IJRbMvxIVHHKgHnDPeMAzag7U1Dn6cvWSryKx8Upv4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS+a/kTseN+ksDvhw+6s1ruCx7bKs2xMFXoLePRxY+aH/A/ P+o0saOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiogcYGXaavXHuavC8sqUkM3x60o vLd2Q/h7S9n31GqFbLfK/K4l+MDK+u3N8er3D39VfNHx+XhfhzyW72Ky2Kk3/iKHJKa/YTAwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the new PR_CORE_SCHED prctl() command PR_SCHED_CORE_SHARE to
allow a third process to pull a core scheduling domain from one task and
push it to another task.

The core scheduling uapi is exposed via the PR_SCHED_CORE option of the
prctl() system call. Two commands can be used to alter the core
scheduling domain of a task:

1. PR_SCHED_CORE_SHARE_TO
   This command takes the cookie for the caller's core scheduling domain
   and applies it to a target task identified by passing a pid.

2. PR_SCHED_CORE_SHARE_FROM
   This command takes the cookie for a task's core scheduling domain and
   applies it to the calling task.

While these options cover nearly all use-cases they are rather
inconvient for some common use-cases. A vm/container manager often
supervises a large number of vms/containers:

                               vm/container manager

vm-supervisor-1    container-supervisor-1    vm-supervisor-2    container-supervisor-2

Where none of the vms/container are its immediate children.

For container managers each container often has a separate supervising
process and the workload is the parent of the container. In the example
below the supervising process is "[lxc monitor]" and the workload is
"/sbin/init" and all descendant processes:

├─[lxc monitor] /var/lib/lxd/containers imp1
│   └─systemd
│       ├─agetty -o -p -- \\u --noclear --keep-baud console 115200,38400,9600 linux
│       ├─cron -f -P
│       ├─dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
│       ├─networkd-dispat /usr/bin/networkd-dispatcher --run-startup-triggers
│       ├─rsyslogd -n -iNONE
│       │   ├─{rsyslogd}
│       │   └─{rsyslogd}
│       ├─systemd-journal
│       ├─systemd-logind
│       ├─systemd-network
│       ├─systemd-resolve
│       └─systemd-udevd

Similiar in spirit but different in layout a vm often has a supervising
process and multiple threads for each vcpu:

├─qemu-system-x86 -S -name f2-vm [...]
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   ├─{qemu-system-x86}
│   └─{qemu-system-x86}

So ultimately an approximation of that layout would be:

                               vm/container manager

vm-supervisor-1    container-supervisor-1    vm-supervisor-2    container-supervisor-2
       |                      |                    |                      |
     vcpus                 workload              vcpus                 workload
                          (/sbin/init)                               (/sbin/init)

For containers a new core scheduling domain is allocated for the init
process. Any descendant processes and threads init spawns will
automatically inherit the correct core scheduling domain.

For vms a new core scheduling domain is allocated and each vcpu thread
will be made to join the new core scheduling domain.

Whenever the tool or library that we use to run containers or vms
exposes an option to automatically create a new core scheduling domain
we will make use of it. However that is not always the case. In such
cases the vm/container manager will need to allocate and set the core
scheduling domain for the relevant processes or threads.

Neither the vm/container mananger nor the indivial vm/container
supervisors are supposed to run in any or the same core scheduling
domain as the respective vcpus/workloads.

So in order to create to create a new core scheduling domain we need to
fork() off a new helper process which allocates a core scheduling domain
and then pushes the cookie for the core scheduling domain to the
relevant vcpus/workloads.

This works but things get rather tricky, especially for containers, when
a new process is supposed to be spawned into a running container.
An important step in creating a new process inside a running container
involves:

- getting a handle on the container's init process (pid or nowadays
  often a pidfd)
- getting a handle on the container's namespaces (namespace file
  descriptors reachable via /proc/<init-pid>/ns/<ns-typ> or nowadays
  often a pidfd)
- calling setns() either on each namespace file descriptor individually
  or on the pidfd of the init process

An important sub-step here is to attach to the container's pid namespace
via setns(). After attaching to the container's pid namespace any
process created via a fork()-like system calls will be a full member of
the container's pid namespace.

So attaching often involves two child processes. The first child simply
attaches to the namespaces of the container including the container's
pid namespace. The second child fork()s and ultimately exec()s thereby
guaranteeing that the newly created process is a full member of the
container's pid namespace:

first_child = fork();
if (first_child == 0) {
        setns(CLONE_NEWPID);

        second_child = fork();
        if (second_child == 0) {
                execlp();
        }
}

As part of this we also need to make sure that the second child - the
one ultimately exec()ing the relevant programm in an already running
container - joins the core scheduling domain of the container. When the
container runs in a new pid namespace this can usually be done by
calling:

first_child = fork();
if (first_child == 0) {
        setns(CLONE_NEWPID);

        second_child = fork();
        if (second_child == 0) {
                prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM,
                      1, PR_SCHED_CORE_SCOPE_THREAD, 0);

                execlp();
        }
}

from the second child since we know that pid 1 in a container running
inside of a separate pid namespace is the correct process to get the
core scheduling domain from.

However, this doesn't work when the container does not run in a separate
pid namespace or when it shares the pid namespace with another
container. In these scenarios we can't simply call
PR_SCHED_CORE_SHARE_FROM from the second child since we don't know the
correct pid number to call it on in the pid namespace.

(Note it is of course possible to learn the pid of the process in the
relevant pid namespace but it is rather complex involving three separate
processes and an AF_UNIX domain socket over which to send a message
including struct ucred from which to learn the relevant pid. But that
doesn't work in all cases since it requires privileges to translate
arbitrary pids. In any case, this is not an option for performance
reasons alone. However, I do also have a separate patchset in [1]
allowing translation of pids between pid namespaces which will help with
that in the future - something which I had discussed with Joel a while
back but haven't pushed for yet since implementing it early 2020. Both
patches are useful independent of one another.)

Additionally, we ideally always want to manage the core scheduling
domain from the first child since the first child knows the pids for the
relevant processes in its current pid namespace. The first child knows
the pid of the init process in the current pid namespace from which to
pull the core scheduling domain and it knows the pid of the second child
it created to which to apply the core scheduling domain.

The core scheduling domain of the first child needs to be unaffected as
it might run sensitive codepaths that should not be exposed in smt attacks.

The new PR_CORE_SCHED_SHARE command for the PR_SCHED_CORE prctl() option
allows to support this and other use-cases by making it possible to pull
the core scheduling domain from a task identified via its pid and push
it to another task identified via its pid from a third managing task:

prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE,
      <pid-to-which-to-apply-coresched-domain>,
      PR_SCHED_CORE_SCOPE_{THREAD,THREAD_GROUP,PROCESS_GROUP},
      <pid-from-which-to-take-coresched-domain>)

In order to use PR_SCHED_CORE_SHARE the caller must have
ptrace_may_access() rights to both the task from which to take the core
scheduling domain and to the task to which to apply the core scheduling
domain. If the caller passes zero as the 5th argument then its own core
scheduling domain is applied to the target making the option adhere to
regular prctl() semantics.

[1]: https://git.kernel.org/brauner/h/ioctl_ns_get_init_pid
     https://git.kernel.org/brauner/c/1ad81fd698dd7e6511c3db422eba42dec3ce1b08
Cc: Peter Collingbourne <pcc@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Chris Hyser <chris.hyser@oracle.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Balbir Singh <sblbir@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/sched.h      |  2 +-
 include/uapi/linux/prctl.h |  3 ++-
 kernel/sched/core_sched.c  | 32 +++++++++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0408372594dd..2eeac7a341ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2341,7 +2341,7 @@ const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
-				unsigned long uaddr);
+				unsigned long arg);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index e998764f0262..e53945dadede 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -267,7 +267,8 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
 # define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
-# define PR_SCHED_CORE_MAX		4
+# define PR_SCHED_CORE_SHARE		4
+# define PR_SCHED_CORE_MAX		5
 # define PR_SCHED_CORE_SCOPE_THREAD		0
 # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
 # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 0c40445337c5..241bb38f5e55 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -129,9 +129,10 @@ static void __sched_core_set(struct task_struct *p, unsigned long cookie)
 
 /* Called from prctl interface: PR_SCHED_CORE */
 int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
-			 unsigned long uaddr)
+			 unsigned long arg)
 {
-	unsigned long cookie = 0, id = 0;
+	unsigned long cookie = 0, id = 0, uaddr = 0;
+	pid_t pid_share = -1;
 	struct task_struct *task, *p;
 	struct pid *grp;
 	int err = 0;
@@ -144,9 +145,20 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_PROCESS_GROUP != PIDTYPE_PGID);
 
 	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
-	    (cmd != PR_SCHED_CORE_GET && uaddr))
+	    (cmd != PR_SCHED_CORE_GET && cmd != PR_SCHED_CORE_SHARE && arg))
 		return -EINVAL;
 
+	switch (cmd) {
+	case PR_SCHED_CORE_GET:
+		uaddr = arg;
+		break;
+	case PR_SCHED_CORE_SHARE:
+		pid_share = arg;
+		if (pid_share < 0)
+			return -EINVAL;
+		break;
+	}
+
 	rcu_read_lock();
 	task = task_by_pid(pid);
 	if (!task) {
@@ -200,6 +212,20 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 		__sched_core_set(current, cookie);
 		goto out;
 
+	case PR_SCHED_CORE_SHARE:
+		rcu_read_lock();
+		p = task_by_pid(pid_share);
+		if (!p)
+			err = -ESRCH;
+		else if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+			err = -EPERM;
+		if (!err)
+			cookie = sched_core_clone_cookie(p);
+		rcu_read_unlock();
+		if (err)
+			goto out;
+		break;
+
 	default:
 		err = -EINVAL;
 		goto out;
-- 
2.32.0

