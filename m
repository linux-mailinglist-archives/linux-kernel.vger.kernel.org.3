Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7A448F352
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiAOAAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:00:12 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:56808 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiAOAAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:00:12 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54110)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n8WUM-00Cvth-Tb; Fri, 14 Jan 2022 17:00:11 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:35384 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n8WUK-007ub6-Rx; Fri, 14 Jan 2022 17:00:10 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Date:   Fri, 14 Jan 2022 17:59:37 -0600
Message-ID: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n8WUK-007ub6-Rx;;;mid=<878rvhlvh2.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18X2iMVecLfw5CDH+ch2W+Sa7euhFybYfM=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 804 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.1%), b_tie_ro: 7 (0.9%), parse: 1.07 (0.1%),
        extract_message_metadata: 7 (0.9%), get_uri_detail_list: 5 (0.6%),
        tests_pri_-1000: 3.5 (0.4%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 157 (19.5%), check_bayes:
        156 (19.4%), b_tokenize: 17 (2.1%), b_tok_get_all: 13 (1.6%),
        b_comp_prob: 4.2 (0.5%), b_tok_touch_all: 118 (14.7%), b_finish: 0.75
        (0.1%), tests_pri_0: 597 (74.2%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 0.72 (0.1%), tests_pri_10:
        3.5 (0.4%), tests_pri_500: 15 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] signal/exit/ptrace changes for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the signal-for-v5.17 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17

  HEAD: a403df29789ba38796edb97dad9bfb47836b68c0 ptrace/m68k: Stop open coding ptrace_report_syscall


This set of changes deletes some dead code, makes a lot of cleanups
which hopefully make the code easier to follow, and fixes bugs
found along the way.

The end-game which I have not yet reached yet is for fatal signals that
generate coredumps to be short-circuit deliverable from complete_signal,
for force_siginfo_to_task not to require changing userspace configured
signal delivery state, and for the ptrace stops to always happen in
locations where we can guarantee on all architectures that the all of
the registers are saved and available on the stack.

Removal of profile_task_ext, profile_munmap, and profile_handoff_task
are the big successes for dead code removal this round.

A bunch of small bug fixes are included, as most of the issues reported
were small enough that they would not affect bisection so I simply added
the fixes and did not fold the fixes into the changes they were fixing.

There was a bug that broke coredumps piped to systemd-coredump.  I
dropped the change that caused that bug and replaced it entirely with
something much more restrained.  Unfortunately that required some
rebasing.

I am currently investigating to figure out if wake_up_interruptible
(instead of simply wake_up) ever makes sense outside of the signal code.

Some successes after this set of changes: There are few enough calls to
do_exit to audit in a reasonable amount of time.  The lifetime of struct
kthread now matches the lifetime of struct task, and the pointer to
struct kthread is no longer stored in set_child_tid.  The flag
SIGNAL_GROUP_COREDUMP is removed.  The field group_exit_task is removed.
Issues where task->exit_code was examined with signal->group_exit_code
should been examined were fixed.

There are several loosely related changes included because I am cleaning
up and if I don't include them they will probably get lost.

The original postings of these changes can be found at:
   https://lkml.kernel.org/r/87a6ha4zsd.fsf@email.froward.int.ebiederm.org
   https://lkml.kernel.org/r/87bl1kunjj.fsf@email.froward.int.ebiederm.org
   https://lkml.kernel.org/r/87r19opkx1.fsf_-_@email.froward.int.ebiederm.org

I trimmed back the last set of changes to only the obviously correct
once.  Simply because there was less time for review than I had hoped.

I am sending this later than I would like as there was an issue that
was discovered just before the merge window and there is a big storm
coming through where I live.  Linus I hope your travel is going well.

Eric W. Biederman (37):
      exit/s390: Remove dead reference to do_exit from copy_thread
      exit: Add and use make_task_dead.
      exit: Move oops specific logic from do_exit into make_task_dead
      exit: Stop poorly open coding do_task_dead in make_task_dead
      exit: Stop exporting do_exit
      exit: Implement kthread_exit
      exit: Rename module_put_and_exit to module_put_and_kthread_exit
      exit: Rename complete_and_exit to kthread_complete_and_exit
      kthread: Ensure struct kthread is present for all kthreads
      exit/kthread: Move the exit code for kernel threads into struct kthread
      exit/kthread: Fix the kerneldoc comment for kthread_complete_and_exit
      objtool: Add a missing comma to avoid string concatenation
      fork: Stop protecting back_fork_cleanup_cgroup_lock with CONFIG_NUMA
      fork: Rename bad_fork_cleanup_threadgroup_lock to bad_fork_cleanup_delayacct
      kthread: Warn about failed allocations for the init kthread
      kthread: Never put_user the set_child_tid address
      kthread: Generalize pf_io_worker so it can point to struct kthread
      exit/xtensa: In arch/xtensa/entry.S:Linvalid_mask call make_task_dead
      exit: Guarantee make_task_dead leaks the tsk when calling do_task_exit
      exit: Move force_uaccess back into do_exit
      signal: Have the oom killer detect coredumps using signal->core_state
      signal: Have prepare_signal detect coredumps using signal->core_state
      signal: Make coredump handling explicit in complete_signal
      signal: During coredumps set SIGNAL_GROUP_EXIT in zap_process
      signal: Remove SIGNAL_GROUP_COREDUMP
      coredump: Stop setting signal->group_exit_task
      signal: Rename group_exit_task group_exec_task
      signal: Remove the helper signal_group_exit
      exit: Remove profile_task_exit & profile_munmap
      exit: Remove profile_handoff_task
      exit: Coredumps reach do_group_exit
      exit: Fix the exit_code for wait_task_zombie
      exit: Use the correct exit_code in /proc/<pid>/stat
      taskstats: Cleanup the use of task->exit_code
      ptrace: Remove second setting of PT_SEIZED in ptrace_attach
      ptrace: Remove unused regs argument from ptrace_report_syscall
      ptrace/m68k: Stop open coding ptrace_report_syscall

Nathan Chancellor (3):
      hexagon: Fix function name in die()
      h8300: Fix build errors from do_exit() to make_task_dead() transition
      csky: Fix function name in csky_alignment() and die()

Randy Dunlap (1):
      signal: clean up kernel-doc comments

 arch/alpha/kernel/traps.c                    |  6 +-
 arch/alpha/mm/fault.c                        |  2 +-
 arch/arm/kernel/traps.c                      |  2 +-
 arch/arm/mm/fault.c                          |  2 +-
 arch/arm64/kernel/traps.c                    |  2 +-
 arch/arm64/mm/fault.c                        |  2 +-
 arch/csky/abiv1/alignment.c                  |  2 +-
 arch/csky/kernel/traps.c                     |  2 +-
 arch/csky/mm/fault.c                         |  2 +-
 arch/h8300/kernel/traps.c                    |  3 +-
 arch/h8300/mm/fault.c                        |  2 +-
 arch/hexagon/kernel/traps.c                  |  2 +-
 arch/ia64/kernel/mca_drv.c                   |  2 +-
 arch/ia64/kernel/traps.c                     |  2 +-
 arch/ia64/mm/fault.c                         |  2 +-
 arch/m68k/kernel/ptrace.c                    | 12 +---
 arch/m68k/kernel/traps.c                     |  2 +-
 arch/m68k/mm/fault.c                         |  2 +-
 arch/microblaze/kernel/exceptions.c          |  4 +-
 arch/mips/kernel/traps.c                     |  2 +-
 arch/nds32/kernel/fpu.c                      |  2 +-
 arch/nds32/kernel/traps.c                    |  8 +--
 arch/nios2/kernel/traps.c                    |  4 +-
 arch/openrisc/kernel/traps.c                 |  2 +-
 arch/parisc/kernel/traps.c                   |  2 +-
 arch/powerpc/kernel/traps.c                  |  8 +--
 arch/riscv/kernel/traps.c                    |  2 +-
 arch/riscv/mm/fault.c                        |  2 +-
 arch/s390/kernel/dumpstack.c                 |  2 +-
 arch/s390/kernel/nmi.c                       |  2 +-
 arch/s390/kernel/process.c                   |  1 -
 arch/sh/kernel/traps.c                       |  2 +-
 arch/sparc/kernel/traps_32.c                 |  4 +-
 arch/sparc/kernel/traps_64.c                 |  4 +-
 arch/x86/entry/entry_32.S                    |  6 +-
 arch/x86/entry/entry_64.S                    |  6 +-
 arch/x86/kernel/dumpstack.c                  |  4 +-
 arch/xtensa/kernel/entry.S                   |  2 +-
 arch/xtensa/kernel/traps.c                   |  2 +-
 crypto/algboss.c                             |  4 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_main.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c  |  2 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c   |  2 +-
 drivers/pnp/pnpbios/core.c                   |  6 +-
 drivers/staging/rts5208/rtsx.c               | 16 ++---
 drivers/usb/atm/usbatm.c                     |  2 +-
 drivers/usb/gadget/function/f_mass_storage.c |  2 +-
 fs/cifs/connect.c                            |  2 +-
 fs/coredump.c                                | 14 ++--
 fs/exec.c                                    | 12 ++--
 fs/io-wq.c                                   |  6 +-
 fs/io-wq.h                                   |  2 +-
 fs/jffs2/background.c                        |  2 +-
 fs/nfs/callback.c                            |  4 +-
 fs/nfs/nfs4state.c                           |  2 +-
 fs/nfsd/nfssvc.c                             |  2 +-
 fs/proc/array.c                              |  6 +-
 include/linux/kernel.h                       |  1 -
 include/linux/kthread.h                      |  4 +-
 include/linux/module.h                       |  6 +-
 include/linux/profile.h                      | 45 -------------
 include/linux/sched.h                        |  4 +-
 include/linux/sched/signal.h                 | 18 +-----
 include/linux/sched/task.h                   |  1 +
 include/linux/tracehook.h                    |  7 +-
 kernel/exit.c                                | 97 +++++++++++++++-------------
 kernel/fork.c                                | 20 +++---
 kernel/futex/core.c                          |  2 +-
 kernel/kexec_core.c                          |  2 +-
 kernel/kthread.c                             | 88 +++++++++++++++++--------
 kernel/module.c                              |  6 +-
 kernel/profile.c                             | 73 ---------------------
 kernel/ptrace.c                              |  2 -
 kernel/sched/core.c                          | 16 ++---
 kernel/signal.c                              | 19 +++---
 kernel/tsacct.c                              |  7 +-
 lib/kunit/try-catch.c                        |  4 +-
 mm/mmap.c                                    |  1 -
 mm/oom_kill.c                                |  2 +-
 net/bluetooth/bnep/core.c                    |  2 +-
 net/bluetooth/cmtp/core.c                    |  2 +-
 net/bluetooth/hidp/core.c                    |  2 +-
 tools/objtool/check.c                        |  8 ++-
 84 files changed, 274 insertions(+), 377 deletions(-)

Eric
