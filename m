Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5D53CFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbiFCR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiFCRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:51:15 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9656FAA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:48:28 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36402)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxBPP-00Gg1P-0c; Fri, 03 Jun 2022 11:48:27 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42780 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxBPN-000zSt-Ka; Fri, 03 Jun 2022 11:48:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Jun 2022 12:48:19 -0500
Message-ID: <87v8th7i58.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nxBPN-000zSt-Ka;;;mid=<87v8th7i58.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19mNLrrPBZ5vfWVQCM18ArZKaY0/4+5EE8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (2.7%), b_tie_ro: 11 (2.3%), parse: 1.33
        (0.3%), extract_message_metadata: 19 (3.8%), get_uri_detail_list: 3.7
        (0.7%), tests_pri_-1000: 19 (3.9%), tests_pri_-950: 1.76 (0.4%),
        tests_pri_-900: 1.25 (0.3%), tests_pri_-90: 77 (15.4%), check_bayes:
        75 (15.0%), b_tokenize: 11 (2.2%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 48 (9.6%), b_finish: 1.18
        (0.2%), tests_pri_0: 330 (66.4%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 11 (2.3%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        4.7 (1.0%), tests_pri_500: 25 (5.1%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] kthread cleanups for v5.19
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This set of changes updates init and user mode helper tasks to be
ordinary user mode tasks.

In commit 40966e316f86 ("kthread: Ensure struct kthread is present for
all kthreads") caused init and the user mode helper threads that call
kernel_execve to have struct kthread allocated for them.  This struct
kthread going away during execve in turned made a use after free of
struct kthread possible.

The commit 343f4c49f243 ("kthread: Don't allocate kthread_struct for
init and umh") is enough to fix the use after free and is simple enough
to be backportable.

The rest of the changes pass struct kernel_clone_args to clean things
up and cause the code to make sense.

In making init and the user mode helpers tasks purely user mode tasks
I ran into two complications.  The function task_tick_numa was
detecting tasks without an mm by testing for the presence of
PF_KTHREAD.  The initramfs code in populate_initrd_image was using
flush_delayed_fput to ensuere the closing of all it's file descriptors
was complete, and flush_delayed_fput does not work in a userspace thread.

I have looked and looked and more complications and in my code review
I have not found any, and neither has anyone else with the code sitting
in linux-next.

Link: https://lkml.kernel.org/r/87mtfu4up3.fsf@email.froward.int.ebiederm.org

Eric W. Biederman (8):
      kthread: Don't allocate kthread_struct for init and umh
      fork: Pass struct kernel_clone_args into copy_thread
      fork: Explicity test for idle tasks in copy_thread
      fork: Generalize PF_IO_WORKER handling
      init: Deal with the init process being a user mode process
      fork: Explicitly set PF_KTHREAD
      fork: Stop allowing kthreads to call execve
      sched: Update task_tick_numa to ignore tasks without an mm

 arch/alpha/kernel/process.c      | 13 ++++++------
 arch/arc/kernel/process.c        | 13 ++++++------
 arch/arm/kernel/process.c        | 12 ++++++-----
 arch/arm64/kernel/process.c      | 12 ++++++-----
 arch/csky/kernel/process.c       | 15 ++++++-------
 arch/h8300/kernel/process.c      | 10 ++++-----
 arch/hexagon/kernel/process.c    | 12 ++++++-----
 arch/ia64/kernel/process.c       | 15 +++++++------
 arch/m68k/kernel/process.c       | 12 ++++++-----
 arch/microblaze/kernel/process.c | 12 ++++++-----
 arch/mips/kernel/process.c       | 13 ++++++------
 arch/nios2/kernel/process.c      | 12 ++++++-----
 arch/openrisc/kernel/process.c   | 12 ++++++-----
 arch/parisc/kernel/process.c     | 18 +++++++++-------
 arch/powerpc/kernel/process.c    | 15 +++++++------
 arch/riscv/kernel/process.c      | 12 ++++++-----
 arch/s390/kernel/process.c       | 12 ++++++-----
 arch/sh/kernel/process_32.c      | 12 ++++++-----
 arch/sparc/kernel/process_32.c   | 12 ++++++-----
 arch/sparc/kernel/process_64.c   | 12 ++++++-----
 arch/um/kernel/process.c         | 15 +++++++------
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/switch_to.h |  8 +++----
 arch/x86/kernel/fpu/core.c       |  4 ++--
 arch/x86/kernel/process.c        | 18 +++++++++-------
 arch/xtensa/kernel/process.c     | 17 ++++++++-------
 fs/exec.c                        |  8 ++++---
 include/linux/sched/task.h       |  8 +++++--
 init/initramfs.c                 |  2 ++
 init/main.c                      |  2 +-
 kernel/fork.c                    | 46 +++++++++++++++++++++++++++++++++-------
 kernel/sched/fair.c              |  2 +-
 kernel/umh.c                     |  6 +++---
 33 files changed, 234 insertions(+), 160 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

p.s.  My apologies for this coming in so late.  The code has been ready
just everyone in my house has been sick since the start of the merge window.
