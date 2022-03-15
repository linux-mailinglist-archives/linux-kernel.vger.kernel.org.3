Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFDE4DA387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351577AbiCOT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351515AbiCOT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B496656211
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=qCY2f1+6Dna/1FmjtGsZdGTpo+y9L+avQYwWLVrrzHY=;
        b=U0otjwgkXDtvadYwD2Wnmv4bm/418Rc5Y3ARuigpYPFUtOUZ2FfqASvYVP+5mwf7mSxtqY
        dhKVbykICFsr9CMLVfT4fxVHXdU2hx4l/TzFUJqwvsl56jE7LX3kCA//CRtI5YpF4iEVTa
        DrGOOJn4lLo9hd3kZXPT0Jehac3c0UE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-4pksHqhENkG71WohVSA-pw-1; Tue, 15 Mar 2022 15:55:30 -0400
X-MC-Unique: 4pksHqhENkG71WohVSA-pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 246FF185A7B2;
        Tue, 15 Mar 2022 19:55:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DDB6C4C7A0;
        Tue, 15 Mar 2022 19:55:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id AFFC1416D5CB; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153132.717153751@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [patch v12 00/13] extensible prctl task isolation interface and vmstat sync
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on
the CPU in question.

To fix this, add task isolation prctl interface to quiesce
deferred actions when returning to userspace.

The patchset is based on ideas and code from the
task isolation patchset from Alex Belits:
https://lwn.net/Articles/816298/

Please refer to Documentation/userspace-api/task_isolation.rst
(patch 1) for details. Its attached at the end of this message
in .txt format as well.

Note: the prctl interface is independent of nohz_full=.

The userspace patches can be found at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/

- qemu-task-isolation.patch: activate task isolation from CPU execution loop
- rt-tests-task-isolation.patch: add task isolation activation to cyclictest/oslat
- util-linux-chisol.patch: add chisol tool to util-linux.

---

v12
- Set TIF_TASK_ISOL only when necessary         (Frederic Weisbecker)
- Switch from raw_cpu_read to __this_cpu_read   (Frederic Weisbecker)
- Add missing kvm-entry.h change                (Frederic Weisbecker)

v11
- Add TIF_TASK_ISOL bit to thread info flags and use it
  to decide whether to perform task isolation work on
  return to userspace                                   (Frederic Weisbecker)
- Fold patch to add task_isol_exit hooks into
  "sync vmstats on return to userspace" patch.          (Frederic Weisbecker)
- Fix typo on prctl_task_isol_cfg_get declaration      (Oscar Shiang)
- Add preempt notifiers

v10
- no changes (resending series without changelog corruption).

v9
- Clarify inheritance is propagated to all descendents (Frederic Weisbecker)
- Fix inheritance of one-shot mode across exec/fork    (Frederic Weisbecker)
- Unify naming on "task_isol_..."                      (Frederic Weisbecker)
- Introduce CONFIG_TASK_ISOLATION                      (Frederic Weisbecker)

v8
- Document the possibility for ISOL_F_QUIESCE_ONE,
  to configure individual features                    (Frederic Weisbecker).
- Fix PR_ISOL_CFG_GET typo in documentation           (Frederic Weisbecker).
- Rebased against linux-2.6.git.

v7
 - no changes (resending series without changelog corruption).

v6
 - Move oneshot mode enablement to configuration time (Frederic Weisbecker).
 - Allow more extensions to CFG_SET of ISOL_F_QUIESCE (Frederic Weisbecker).
 - Update docs and samples regarding oneshot mode     (Frederic Weisbecker).
 - Update docs and samples regarding more extensibility of
   CFG_SET of ISOL_F_QUIESCE                          (Frederic Weisbecker).
 - prctl_task_isolation_activate_get should copy active_mask
   to address in arg2.
 - modify exit_to_user_mode_loop to cover exceptions
   and interrupts.
 - split exit hooks into its own patch

v5
  - Add changelogs to individual patches                (Peter Zijlstra).
  - Add documentation to patchset intro                 (Peter Zijlstra).

v4:
 - Switch to structures for parameters when possible
   (which are more extensible).
 - Switch to CFG_{S,G}ET naming and use drop
   "internal configuration" prctls            (Frederic Weisbecker).
 - Add summary of terms to documentation      (Frederic Weisbecker).
 - Examples for compute and one-shot modes    (Thomas G/Christoph L).

v3:

 - Split in smaller patches              (Nitesh Lal).
 - Misc cleanups                         (Nitesh Lal).
 - Clarify nohz_full is not a dependency (Nicolas Saenz).
 - Incorrect values for prctl definitions (kernel robot).
 - Save configured state, so applications
   can activate externally configured
   task isolation parameters.
 - Remove "system default" notion (chisol should
   make it obsolete).
 - Update documentation: add new section with explanation
   about configuration/activation and code example.
 - Update samples.
 - Report configuration/activation state at
   /proc/pid/task_isolation.
 - Condense dirty information of per-CPU vmstats counters
   in a bool.
 - In-kernel KVM support.

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).

- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

v11 can be found at:

https://lore.kernel.org/all/20220204173537.429902988@fedora.localdomain/

---

 Documentation/userspace-api/task_isolation.rst |  379 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/include/asm/thread_info.h            |    2
 arch/x86/include/asm/thread_info.h             |    2
 fs/proc/base.c                                 |   68 ++++++++++
 include/linux/entry-common.h                   |    2
 include/linux/entry-kvm.h                      |    2
 include/linux/sched.h                          |    5
 include/linux/task_isolation.h                 |  136 ++++++++++++++++++++
 include/linux/vmstat.h                         |   25 +++
 include/uapi/linux/prctl.h                     |   47 +++++++
 init/Kconfig                                   |   16 ++
 init/init_task.c                               |    3
 kernel/Makefile                                |    2
 kernel/entry/common.c                          |    4
 kernel/entry/kvm.c                             |    4
 kernel/exit.c                                  |    2
 kernel/fork.c                                  |   23 +++
 kernel/sys.c                                   |   16 ++
 kernel/task_isolation.c                        |  424 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c                                    |  173 +++++++++++++++++++++-----
 samples/Kconfig                                |    7 +
 samples/Makefile                               |    1
 samples/task_isolation/Makefile                |   11 +
 samples/task_isolation/task_isol.c             |   92 ++++++++++++++
 samples/task_isolation/task_isol.h             |    9 +
 samples/task_isolation/task_isol_computation.c |   89 +++++++++++++
 samples/task_isolation/task_isol_oneshot.c     |  104 +++++++++++++++
 samples/task_isolation/task_isol_userloop.c    |   54 ++++++++
 28 files changed, 1664 insertions(+), 38 deletions(-)

---

Task isolation prctl interface
******************************

Certain types of applications benefit from running uninterrupted by
background OS activities. Realtime systems and high-bandwidth
networking applications with user-space drivers can fall into the
category.

To create an OS noise free environment for the application, this
interface allows userspace to inform the kernel the start and end of
the latency sensitive application section (with configurable system
behaviour for that section).

Note: the prctl interface is independent of nohz_full=.

The prctl options are:

   * PR_ISOL_FEAT_GET: Retrieve supported features.

   * PR_ISOL_CFG_GET: Retrieve task isolation configuration.

   * PR_ISOL_CFG_SET: Set task isolation configuration.

   * PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.

   * PR_ISOL_ACTIVATE_SET: Set task isolation activation state.

Summary of terms:

* feature:

     A distinct attribute or aspect of task isolation. Examples of
     features could be logging, new operating modes (eg: syscalls
     disallowed), userspace notifications, etc. The only feature
     currently available is quiescing.

* configuration:

     A specific choice from a given set of possible choices that
     dictate how the particular feature in question should behave.

* activation state:

     The activation state (whether active/inactive) of the task
     isolation features (features must be configured before being
     activated).

Inheritance of the isolation parameters and state, across fork(2) and
clone(2), can be changed via PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.

At a high-level, task isolation is divided in two steps:

1. Configuration.

2. Activation.

Section "Userspace support" describes how to use task isolation.

In terms of the interface, the sequence of steps to activate task
isolation are:

1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).

2. Configure task isolation features
   (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).

3. Activate or deactivate task isolation features
   (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).

This interface is based on ideas and code from the task isolation
patchset from Alex Belits: https://lwn.net/Articles/816298/

Note: if the need arises to configure an individual quiesce feature
with its own extensible structure, please add ISOL_F_QUIESCE_ONE to
PR_ISOL_CFG_GET/PR_ISOL_CFG_SET (ISOL_F_QUIESCE operates on multiple
features per syscall currently).


Feature description
===================

   * "ISOL_F_QUIESCE"

   This feature allows quiescing selected kernel activities on return
   from system calls.


Interface description
=====================

**PR_ISOL_FEAT**:

   Returns the supported features and feature capabilities, as a
   bitmask:

      prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);

   The 'feat' argument specifies whether to return supported features
   (if zero), or feature capabilities (if not zero). Possible values
   for 'feat' are:

   * "0":

        Return the bitmask of supported features, in the location
        pointed  to  by  "(int *)arg3". The buffer should allow space
        for 8 bytes.

   * "ISOL_F_QUIESCE":

        Return a structure containing which kernel activities are
        supported for quiescing, in the location pointed to by "(int
        *)arg3":

           struct task_isol_quiesce_extensions {
                   __u64 flags;
                   __u64 supported_quiesce_bits;
                   __u64 pad[6];
           };

        Where:

        *flags*: Additional flags (should be zero).

        *supported_quiesce_bits*: Bitmask indicating
           which features are supported for quiescing.

        *pad*: Additional space for future enhancements.

   Features and its capabilities are defined at
   include/uapi/linux/task_isolation.h.

**PR_ISOL_CFG_GET**:

   Retrieve task isolation configuration. The general format is:

      prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);

   The 'what' argument specifies what to configure. Possible values
   are:

   * "I_CFG_FEAT":

        Return configuration of task isolation features. The 'arg3'
        argument specifies whether to return configured features (if
        zero), or individual feature configuration (if not zero), as
        follows.

        * "0":

             Return the bitmask of configured features, in the
             location pointed  to  by  "(int *)arg4". The buffer
             should allow space for 8 bytes.

        * "ISOL_F_QUIESCE":

             If arg4 is QUIESCE_CONTROL, return the control structure
             for quiescing of background kernel activities, in the
             location pointed to by "(int *)arg5":

                struct task_isol_quiesce_control {
                       __u64 flags;
                       __u64 quiesce_mask;
                       __u64 quiesce_oneshot_mask;
                       __u64 pad[5];
                };

             See PR_ISOL_CFG_SET description for meaning of fields.

   * "I_CFG_INHERIT":

        Retrieve inheritance configuration across fork/clone.

        Return the structure which configures inheritance across
        fork/clone, in the location pointed to by "(int *)arg4":

           struct task_isol_inherit_control {
                   __u8    inherit_mask;
                   __u8    pad[7];
           };

        See PR_ISOL_CFG_SET description for meaning of fields.

**PR_ISOL_CFG_SET**:

   Set task isolation configuration. The general format is:

      prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);

   The 'what' argument specifies what to configure. Possible values
   are:

   * "I_CFG_FEAT":

        Set configuration of task isolation features. 'arg3' specifies
        the feature. Possible values are:

        * "ISOL_F_QUIESCE":

             If arg4 is QUIESCE_CONTROL, set the control structure for
             quiescing of background kernel activities, from the
             location pointed to by "(int *)arg5":

                struct task_isol_quiesce_control {
                       __u64 flags;
                       __u64 quiesce_mask;
                       __u64 quiesce_oneshot_mask;
                       __u64 pad[5];
                };

             Where:

             *flags*: Additional flags (should be zero).

             *quiesce_mask*: A bitmask containing which kernel
             activities to quiesce.

             *quiesce_oneshot_mask*: A bitmask indicating which kernel
             activities should behave in oneshot mode, that is,
             quiescing will happen on return from
             prctl(PR_ISOL_ACTIVATE_SET), but not on return of
             subsequent system calls. The corresponding bit(s) must
             also be set at quiesce_mask.

             *pad*: Additional space for future enhancements.

             For quiesce_mask (and quiesce_oneshot_mask), possible bit
             sets are:

             * "ISOL_F_QUIESCE_VMSTATS"

             VM statistics are maintained in per-CPU counters to
             improve performance. When a CPU modifies a VM statistic,
             this modification is kept in the per-CPU counter. Certain
             activities require a global count, which involves
             requesting each CPU to flush its local counters to the
             global VM counters.

             This flush is implemented via a workqueue item, which
             might schedule a workqueue on isolated CPUs.

             To avoid this interruption, task isolation can be
             configured to, upon return from system calls, synchronize
             the per-CPU counters to global counters, thus avoiding
             the interruption.

   * "I_CFG_INHERIT":

        Set inheritance configuration when a new task is created via
        fork and clone.

        The "(int *)arg4" argument is a pointer to:

           struct task_isol_inherit_control {
                   __u8    inherit_mask;
                   __u8    pad[7];
           };

        inherit_mask is a bitmask that specifies which part of task
        isolation should be inherited:

        * Bit ISOL_INHERIT_CONF: Inherit task isolation
          configuration. This is the state written via
          prctl(PR_ISOL_CFG_SET, ...).

        * Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
          (requires ISOL_INHERIT_CONF to be set). The new task should
          behave, after fork/clone, in the same manner as the parent
          task after it executed:

             prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);

        Note: the inheritance propagates to all the descendants and
        not just the immediate children, unless the inheritance is
        explicitly reconfigured by some children.

**PR_ISOL_ACTIVATE_GET**:

   Retrieve task isolation activation state.

   The general format is:

      prctl(PR_ISOL_ACTIVATE_GET, pmask, arg3, arg4, arg5);

   'pmask' specifies the location of a feature mask, where the current
   active mask will be copied. See PR_ISOL_ACTIVATE_SET for
   description of individual bits.

**PR_ISOL_ACTIVATE_SET**:

   Set task isolation activation state (activates/deactivates task
   isolation).

   The general format is:

      prctl(PR_ISOL_ACTIVATE_SET, pmask, arg3, arg4, arg5);

   The 'pmask' argument specifies the location of an 8 byte mask
   containing which features should be activated. Features whose bits
   are cleared will be deactivated. The possible bits for this mask
   are:

      * "ISOL_F_QUIESCE":

      Activate quiescing of background kernel activities. Quiescing
      happens on return to userspace from this system call, and on
      return from subsequent system calls (unless quiesce_oneshot_mask
      has been set at PR_ISOL_CFG_SET time).

   Quiescing can be adjusted (while active) by
   prctl(PR_ISOL_ACTIVATE_SET, &new_mask, ...).


Userspace support
*****************

Task isolation is divided in two main steps: configuration and
activation.

Each step can be performed by an external tool or the latency
sensitive application itself. util-linux contains the "chisol" tool
for this purpose.

This results in three combinations:

1. Both configuration and activation performed by the latency
sensitive application. Allows fine grained control of what task
isolation features are enabled and when (see samples section below).

2. Only activation can be performed by the latency sensitive app (and
configuration performed by chisol). This allows the admin/user to
control task isolation parameters, and applications have to be
modified only once.

3. Configuration and activation performed by an external tool. This
allows unmodified applications to take advantage of task isolation.
Activation is performed by the "-a" option of chisol.


Examples
********

The "samples/task_isolation/" directory contains 3 examples:

* task_isol_userloop.c:

     Example of program with a loop on userspace scenario.

* task_isol_computation.c:

     Example of program that enters task isolated mode, performs an
     amount of computation, exits task isolated mode, and writes the
     computation to disk.

* task_isol_oneshot.c:

     Example of program that enables one-shot mode for quiescing,
     enters a processing loop, then upon an external event performs a
     number of syscalls to handle that event.

This is a snippet of code to activate task isolation if it has been
previously configured (by chisol for example):

   #include <sys/prctl.h>
   #include <linux/types.h>

   #ifdef PR_ISOL_CFG_GET
   unsigned long long fmask;

   ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
   if (ret != -1 && fmask != 0) {
           ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
           if (ret == -1) {
                   perror("prctl PR_ISOL_ACTIVATE_SET");
                   return ret;
           }
   }
   #endif





