Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E555B3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiFZTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFZTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:15:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F15DF3A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:15:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48334)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xiz-00ASkZ-SI; Sun, 26 Jun 2022 13:15:13 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57732 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xiy-008aSI-T2; Sun, 26 Jun 2022 13:15:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
Date:   Sun, 26 Jun 2022 14:14:45 -0500
In-Reply-To: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 16:48:38 -0700")
Message-ID: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5Xiy-008aSI-T2;;;mid=<87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/6ntGUKYDJC32bDb8alF2ElKoq9ehJkes=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 431 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.3%), parse: 0.95
        (0.2%), extract_message_metadata: 3.1 (0.7%), get_uri_detail_list:
        0.96 (0.2%), tests_pri_-1000: 4.3 (1.0%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 171 (39.7%), check_bayes:
        169 (39.3%), b_tokenize: 7 (1.7%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 148 (34.4%), b_finish: 0.93
        (0.2%), tests_pri_0: 219 (50.9%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.92 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] kthread: Stop using TASK_UNINTERRUPTIBLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Being silly I figured I would poke my nose in and see how much work it
is to never wake up kthreads until we are ready to use them.

This is my first draft at that and something that can hopefully shape
the conversation on how we want to fix things a little bit.

The big thing that needs to happen that I haven't implemented is that
kthread_run and kthread_run_on_cpu need to be uninlined and moved into
kthread.c.  This will allow them to call wake_up_new_task even from
modular code.

The handful of drivers that are using kthread_create_on_node by
extension need to be modified to use kthread_run or kthread_run_on_cpu.

Eric W. Biederman (3):
      kthread: Remove the flags argument from kernel_thread
      kthread: Replace kernel_thread with new_kthread
      kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)

 arch/arm/common/bL_switcher.c             |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 drivers/block/mtip32xx/mtip32xx.c         |   2 +-
 drivers/firmware/psci/psci_checker.c      |   2 +-
 drivers/firmware/stratix10-svc.c          |   4 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c         |   2 +-
 drivers/scsi/bnx2i/bnx2i_init.c           |   2 +-
 drivers/scsi/qedi/qedi_main.c             |   2 +-
 include/linux/kthread.h                   |   4 +-
 include/linux/sched/task.h                |   2 +-
 init/main.c                               |   6 +-
 kernel/bpf/cpumap.c                       |   2 +-
 kernel/dma/map_benchmark.c                |   2 +-
 kernel/fork.c                             |   5 +-
 kernel/kthread.c                          | 120 +++++++++++++++---------------
 kernel/smpboot.c                          |   1 +
 kernel/workqueue.c                        |   2 +-
 net/core/pktgen.c                         |   2 +-
 net/sunrpc/svc.c                          |   2 +-
 19 files changed, 82 insertions(+), 86 deletions(-)

Eric
