Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA93F469530
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbhLFLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:46:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35144 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbhLFLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:46:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF3861232
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F0C341C2;
        Mon,  6 Dec 2021 11:42:31 +0000 (UTC)
Date:   Mon, 6 Dec 2021 12:42:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
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
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [RFC PATCH 0/3] core scheduling: add PR_SCHED_CORE_SHARE
Message-ID: <20211206114227.hhekx7ex22o5zexj@wittgenstein>
References: <20211123132907.3138476-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123132907.3138476-1-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:29:04PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey everyone,
> 
> This adds the new PR_CORE_SCHED prctl() command PR_SCHED_CORE_SHARE to
> allow a third process to pull a core scheduling domain from one task and
> push it to another task.

Hey Peter,

Did you get anywhere in finding out whether we can support something
like this here or whether there was a reason we can't?

Thanks!
Christian

> 
> The core scheduling uapi is exposed via the PR_SCHED_CORE option of the
> prctl() system call. Two commands can be used to alter the core
> scheduling domain of a task:
> 
> 1. PR_SCHED_CORE_SHARE_TO
>    This command takes the cookie for the caller's core scheduling domain
>    and applies it to a target task identified by passing a pid.
> 
> 2. PR_SCHED_CORE_SHARE_FROM
>    This command takes the cookie for a task's core scheduling domain and
>    applies it to the calling task.
> 
> While these options cover nearly all use-cases they are rather
> inconvient for some common use-cases. A vm/container manager often
> supervises a large number of vms/containers:
> 
>                                vm/container manager
> 
> vm-supervisor-1    container-supervisor-1    vm-supervisor-2    container-supervisor-2
> 
> Where none of the vms/container are its immediate children.
> 
> For container managers each container often has a separate supervising
> process and the workload is the parent of the container. In the example
> below the supervising process is "[lxc monitor]" and the workload is
> "/sbin/init" and all descendant processes:
> 
> ├─[lxc monitor] /var/lib/lxd/containers imp1
> │   └─systemd
> │       ├─agetty -o -p -- \\u --noclear --keep-baud console 115200,38400,9600 linux
> │       ├─cron -f -P
> │       ├─dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> │       ├─networkd-dispat /usr/bin/networkd-dispatcher --run-startup-triggers
> │       ├─rsyslogd -n -iNONE
> │       │   ├─{rsyslogd}
> │       │   └─{rsyslogd}
> │       ├─systemd-journal
> │       ├─systemd-logind
> │       ├─systemd-network
> │       ├─systemd-resolve
> │       └─systemd-udevd
> 
> Similiar in spirit but different in layout a vm often has a supervising
> process and multiple threads for each vcpu:
> 
> ├─qemu-system-x86 -S -name f2-vm [...]
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   ├─{qemu-system-x86}
> │   └─{qemu-system-x86}
> 
> So ultimately an approximation of that layout would be:
> 
>                                vm/container manager
> 
> vm-supervisor-1    container-supervisor-1    vm-supervisor-2    container-supervisor-2
>        |                      |                    |                      |
>      vcpus                 workload              vcpus                 workload
>                           (/sbin/init)                               (/sbin/init)
> 
> For containers a new core scheduling domain is allocated for the init
> process. Any descendant processes and threads init spawns will
> automatically inherit the correct core scheduling domain.
> 
> For vms a new core scheduling domain is allocated and each vcpu thread
> will be made to join the new core scheduling domain.
> 
> Whenever the tool or library that we use to run containers or vms
> exposes an option to automatically create a new core scheduling domain
> we will make use of it. However that is not always the case. In such
> cases the vm/container manager will need to allocate and set the core
> scheduling domain for the relevant processes or threads.
> 
> Neither the vm/container mananger nor the indivial vm/container
> supervisors are supposed to run in any or the same core scheduling
> domain as the respective vcpus/workloads.
> 
> So in order to create to create a new core scheduling domain we need to
> fork() off a new helper process which allocates a core scheduling domain
> and then pushes the cookie for the core scheduling domain to the
> relevant vcpus/workloads.
> 
> This works but things get rather tricky, especially for containers, when
> a new process is supposed to be spawned into a running container.
> An important step in creating a new process inside a running container
> involves:
> 
> - getting a handle on the container's init process (pid or nowadays
>   often a pidfd)
> - getting a handle on the container's namespaces (namespace file
>   descriptors reachable via /proc/<init-pid>/ns/<ns-typ> or nowadays
>   often a pidfd)
> - calling setns() either on each namespace file descriptor individually
>   or on the pidfd of the init process
> 
> An important sub-step here is to attach to the container's pid namespace
> via setns(). After attaching to the container's pid namespace any
> process created via a fork()-like system calls will be a full member of
> the container's pid namespace.
> 
> So attaching often involves two child processes. The first child simply
> attaches to the namespaces of the container including the container's
> pid namespace. The second child fork()s and ultimately exec()s thereby
> guaranteeing that the newly created process is a full member of the
> container's pid namespace:
> 
> first_child = fork();
> if (first_child == 0) {
>         setns(CLONE_NEWPID);
> 
>         second_child = fork();
>         if (second_child == 0) {
>                 execlp();
>         }
> }
> 
> As part of this we also need to make sure that the second child - the
> one ultimately exec()ing the relevant programm in an already running
> container - joins the core scheduling domain of the container. When the
> container runs in a new pid namespace this can usually be done by
> calling:
> 
> first_child = fork();
> if (first_child == 0) {
>         setns(CLONE_NEWPID);
> 
>         second_child = fork();
>         if (second_child == 0) {
>                 prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM,
>                       1, PR_SCHED_CORE_SCOPE_THREAD, 0);
> 
>                 execlp();
>         }
> }
> 
> from the second child since we know that pid 1 in a container running
> inside of a separate pid namespace is the correct process to get the
> core scheduling domain from.
> 
> However, this doesn't work when the container does not run in a separate
> pid namespace or when it shares the pid namespace with another
> container. In these scenarios we can't simply call
> PR_SCHED_CORE_SHARE_FROM from the second child since we don't know the
> correct pid number to call it on in the pid namespace.
> 
> (Note it is of course possible to learn the pid of the process in the
> relevant pid namespace but it is rather complex involving three separate
> processes and an AF_UNIX domain socket over which to send a message
> including struct ucred from which to learn the relevant pid. But that
> doesn't work in all cases since it requires privileges to translate
> arbitrary pids. In any case, this is not an option for performance
> reasons alone. However, I do also have a separate patchset in [1]
> allowing translation of pids between pid namespaces which will help with
> that in the future - something which I had discussed with Joel a while
> back but haven't pushed for yet since implementing it early 2020. Both
> patches are useful independent of one another.)
> 
> Additionally, we ideally always want to manage the core scheduling
> domain from the first child since the first child knows the pids for the
> relevant processes in its current pid namespace. The first child knows
> the pid of the init process in the current pid namespace from which to
> pull the core scheduling domain and it knows the pid of the second child
> it created to which to apply the core scheduling domain.
> 
> The core scheduling domain of the first child needs to be unaffected as
> it might run sensitive codepaths that should not be exposed in smt attacks.
> 
> The new PR_CORE_SCHED_SHARE command for the PR_SCHED_CORE prctl() option
> allows to support this and other use-cases by making it possible to pull
> the core scheduling domain from a task identified via its pid and push
> it to another task identified via its pid from a third managing task:
> 
> prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE,
>       <pid-to-which-to-apply-coresched-domain>,
>       PR_SCHED_CORE_SCOPE_{THREAD,THREAD_GROUP,PROCESS_GROUP},
>       <pid-from-which-to-take-coresched-domain>)
> 
> In order to use PR_SCHED_CORE_SHARE the caller must have
> ptrace_may_access() rights to both the task from which to take the core
> scheduling domain and to the task to which to apply the core scheduling
> domain. If the caller passes zero as the 5th argument then its own core
> scheduling domain is applied to the target making the option adhere to
> regular prctl() semantics.
> 
> Thanks!
> Christian
> 
> Christian Brauner (3):
>   pid: introduce task_by_pid()
>   sched/prctl: add PR_SCHED_CORE_SHARE command
>   tests: add new PR_SCHED_CORE_SHARE test
> 
>  arch/mips/kernel/mips-mt-fpaff.c              | 14 +-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 19 +++-----
>  block/ioprio.c                                | 10 +----
>  include/linux/sched.h                         |  9 +++-
>  include/uapi/linux/prctl.h                    |  3 +-
>  kernel/cgroup/cgroup.c                        | 12 ++---
>  kernel/events/core.c                          |  5 +--
>  kernel/futex/syscalls.c                       | 20 +++------
>  kernel/pid.c                                  |  5 +++
>  kernel/sched/core.c                           | 27 ++++--------
>  kernel/sched/core_sched.c                     | 44 ++++++++++++++-----
>  kernel/sys.c                                  | 12 ++---
>  mm/mempolicy.c                                |  2 +-
>  tools/testing/selftests/sched/cs_prctl_test.c | 23 ++++++++++
>  14 files changed, 105 insertions(+), 100 deletions(-)
> 
> 
> base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
> -- 
> 2.30.2
> 
