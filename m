Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A850A3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389903AbiDUPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiDUPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:13:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BDB3299D;
        Thu, 21 Apr 2022 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4rWOXJsvuobYbiGoWOq011uN1R9GhH39hya4yiHq06A=; b=DfAJsgGXTHsCtf/8unN3gWA2wH
        yoC+BnND0K6m4IGyU7/G5FNcjA3agmRBpUoO9qZC/eB4/Jtt5UpuMkC7K0T9JAbHVQYuXcdK3o/JS
        bOpLMLK8XuFbzi93q6gAsY9jDcfu22RhhDtjZtoYxOoEZ6Mj6nplGj0q5j+BTf2RQsewA62vxggFi
        k/clpnM+9WCaCxVwyre3joSS+KcL8zuKehO6cnERl6r+OZiH4EHeqD0Y+iTEwPuQqY/S5ctG7Ojj8
        +unNQIq4dGz1chrFR2SdUDHrOHKQphduo3tep+5FanU2SjWGODgCjy/zYx3fI3k4C8GWK1mzHbBmv
        wJAM7G5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhYRk-007QKR-48; Thu, 21 Apr 2022 15:10:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A6543006C5;
        Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FA6A2B32F273; Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Message-ID: <20220421150248.667412396@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Apr 2022 17:02:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/5] ptrace-vs-PREEMPT_RT and freezer rewrite
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Find here a new posting of the ptrace and freezer patches :-)

The majority of the changes are in patch 2, which with much feedback from Oleg
and Eric has changed lots.

I'm hoping we're converging on something agreeable.

---
 drivers/acpi/x86/s2idle.c         |  12 +-
 drivers/android/binder.c          |   4 +-
 drivers/media/pci/pt3/pt3.c       |   4 +-
 drivers/scsi/scsi_transport_spi.c |   7 +-
 fs/cifs/inode.c                   |   4 +-
 fs/cifs/transport.c               |   5 +-
 fs/coredump.c                     |   5 +-
 fs/nfs/file.c                     |   3 +-
 fs/nfs/inode.c                    |  12 +-
 fs/nfs/nfs3proc.c                 |   3 +-
 fs/nfs/nfs4proc.c                 |  14 +--
 fs/nfs/nfs4state.c                |   3 +-
 fs/nfs/pnfs.c                     |   4 +-
 fs/xfs/xfs_trans_ail.c            |   8 +-
 include/linux/completion.h        |   1 +
 include/linux/freezer.h           | 244 ++------------------------------------
 include/linux/sched.h             |  49 ++++----
 include/linux/sched/jobctl.h      |  10 ++
 include/linux/sched/signal.h      |   5 +-
 include/linux/sunrpc/sched.h      |   7 +-
 include/linux/suspend.h           |   8 +-
 include/linux/umh.h               |   9 +-
 include/linux/wait.h              |  40 ++++++-
 init/do_mounts_initrd.c           |  10 +-
 kernel/cgroup/legacy_freezer.c    |  23 ++--
 kernel/exit.c                     |   4 +-
 kernel/fork.c                     |   5 +-
 kernel/freezer.c                  | 137 +++++++++++++++------
 kernel/futex/waitwake.c           |   8 +-
 kernel/hung_task.c                |   4 +-
 kernel/power/hibernate.c          |  35 ++++--
 kernel/power/main.c               |  18 +--
 kernel/power/process.c            |  10 +-
 kernel/power/suspend.c            |  12 +-
 kernel/power/user.c               |  24 ++--
 kernel/ptrace.c                   | 114 ++++++++++--------
 kernel/sched/completion.c         |   9 ++
 kernel/sched/core.c               |  24 ++--
 kernel/signal.c                   |  62 +++++++---
 kernel/time/hrtimer.c             |   4 +-
 kernel/umh.c                      |  18 ++-
 mm/khugepaged.c                   |   4 +-
 net/sunrpc/sched.c                |  12 +-
 net/unix/af_unix.c                |   8 +-
 44 files changed, 478 insertions(+), 528 deletions(-)

