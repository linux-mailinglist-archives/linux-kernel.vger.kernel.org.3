Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5B497D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiAXKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:53:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34180 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiAXKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:53:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B280C612EE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2950C340E1;
        Mon, 24 Jan 2022 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643021579;
        bh=H9C2x7PpN/VlHX2YT1+5FCG3Bk/b1nbud5w/gdFgFQI=;
        h=From:To:Cc:Subject:Date:From;
        b=igvS5vDY9nm32mnYZUdYwOPG5/5GHg/PQXKRsh+8eJyE+ibMMDA81fdJr4XQDRrjp
         Gqh6IMKx3MCYZ6uug/eARA06qMs6AKqqHfrfYifc0BAJ+7oSgClSoR/p36ZQBzZ0EW
         CVRRceZOqifbTHysLhqHEmNdFHY+zL9KzDPqkENspTp5n3vitS7IEGY0KQIiEexEkl
         yXV3YCJNTUlmuyY7+IW0XnwRg4Iv2LxA8MJzI78UN47csQwtt5VRzk7+QQK8D7+C/z
         jlyBggVOqjag8rrnQp/ZgW/TIZeq+/tLcmc5sn9y1qLM906Ue2o+xqBfdMjHNQKkKx
         L30UO57rNddqg==
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
Subject: [resend RFC 0/3] core scheduling: add PR_SCHED_CORE_SHARE
Date:   Mon, 24 Jan 2022 11:52:44 +0100
Message-Id: <20220124105247.2118990-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9801; h=from:subject; bh=H9C2x7PpN/VlHX2YT1+5FCG3Bk/b1nbud5w/gdFgFQI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS+a/kTOUHE84nb+enSkxs8d8Qf+1okwsAsKSu5/53Olrap d5gcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSxs/wP27ViQPfUnu0Z8bO84g5bm w1JV/NTf9mGvfhibs3ZrQlcDP8D75Z8LK5c5b2m7+lNd/+CjzNVr2xZ83iWUnrwut/zkrawwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

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

Thanks!
Christian

Christian Brauner (3):
  pid: introduce task_by_pid()
  sched/prctl: add PR_SCHED_CORE_SHARE command
  tests: add new PR_SCHED_CORE_SHARE test

 arch/mips/kernel/mips-mt-fpaff.c              | 14 +-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 19 +++-----
 block/ioprio.c                                | 10 +----
 include/linux/sched.h                         |  9 +++-
 include/uapi/linux/prctl.h                    |  3 +-
 kernel/cgroup/cgroup.c                        | 12 ++---
 kernel/events/core.c                          |  5 +--
 kernel/futex/syscalls.c                       | 20 +++------
 kernel/pid.c                                  |  5 +++
 kernel/sched/core.c                           | 27 ++++--------
 kernel/sched/core_sched.c                     | 44 ++++++++++++++-----
 kernel/sys.c                                  | 12 ++---
 mm/mempolicy.c                                |  2 +-
 tools/testing/selftests/sched/cs_prctl_test.c | 23 ++++++++++
 14 files changed, 105 insertions(+), 100 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.32.0

