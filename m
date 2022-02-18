Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1544BC1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiBRVQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiBRVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:09 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662023DCDF;
        Fri, 18 Feb 2022 13:15:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 25E573BA77A;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Kw0NzY-6FgDp; Fri, 18 Feb 2022 16:06:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 78C833BA579;
        Fri, 18 Feb 2022 16:06:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 78C833BA579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218402;
        bh=10jACHExCr29lZJSF+RqFchPVJPsovh4LMgPAKY+QjM=;
        h=From:To:Date:Message-Id;
        b=kUqJoY3rr967uyTbjvfdYnHXDkESx5qxmPybjTW18Q7x+Zg5+41scdj/CTGoHlksg
         g3LHEuNioZugkASqeHjoFdGCL11FkGNhLoEIZKCucSXiDnXtbvcZ6IBz4uQfEu1841
         LdGwsvS0gobtDek33SBifsBtaed5lOZe53QHNf60SaIKx2+duMrjO7fszi+a2fSGlp
         gMn+F5ZA1cOB/nAzQ8t/41s0KVaWQ0NbiJf3TRr0MqTyePY7JctGh7eDTRmJYQ4Tcx
         F9MBYmmJCOs/l3/cxfkAvLp4f1N0rkxPZ2To4HWp3JQPMEkwt1kGZBOM8dMSpQPYwR
         uZWQ6e8nwuxxg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AcNg9HfHBGDg; Fri, 18 Feb 2022 16:06:42 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 03CC53BA922;
        Fri, 18 Feb 2022 16:06:41 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 00/11] RSEQ node id and virtual cpu id extensions
Date:   Fri, 18 Feb 2022 16:06:22 -0500
Message-Id: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending this series for feedback. There appears to be a lot of
interest in the virtual cpu id feature for use in user-space memory
allocators (e.g. glibc malloc), so I am sending this out as RFC.

The most interesting patch in here is "sched: Introduce per memory space
current virtual cpu id". So if you want to jump to the meat, go
immediately to that patch.

This series is based on the tip tree core/sched branch [1] at commit
ed3b362d54f0 ("sched/isolation: Split housekeeping cpumask per isolation
features").

Feedback is welcome!

Thanks,

Mathieu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

Mathieu Desnoyers (11):
  rseq: Introduce feature size and alignment ELF auxiliary vector
    entries
  rseq: Introduce extensible rseq ABI
  rseq: extend struct rseq with numa node id
  selftests/rseq: Use ELF auxiliary vector for extensible rseq
  selftests/rseq: Implement rseq numa node id field selftest
  lib: invert _find_next_bit source arguments
  lib: implement find_{first,next}_{zero,one}_and_zero_bit
  cpumask: implement cpumask_{first,next}_{zero,one}_and_zero
  sched: Introduce per memory space current virtual cpu id
  rseq: extend struct rseq with per memory space vcpu id
  selftests/rseq: Implement rseq vm_vcpu_id field support

 fs/binfmt_elf.c                           |   5 +
 fs/exec.c                                 |   4 +
 include/linux/cpumask.h                   |  94 ++++++
 include/linux/find.h                      | 123 +++++++-
 include/linux/mm.h                        |  25 ++
 include/linux/mm_types.h                  | 111 +++++++
 include/linux/sched.h                     |   9 +
 include/trace/events/rseq.h               |   4 +-
 include/uapi/linux/auxvec.h               |   2 +
 include/uapi/linux/rseq.h                 |  22 ++
 init/Kconfig                              |   4 +
 kernel/fork.c                             |  15 +-
 kernel/ptrace.c                           |   2 +-
 kernel/rseq.c                             |  60 +++-
 kernel/sched/core.c                       |  82 +++++
 kernel/sched/deadline.c                   |   3 +
 kernel/sched/debug.c                      |  13 +
 kernel/sched/fair.c                       |   1 +
 kernel/sched/rt.c                         |   2 +
 kernel/sched/sched.h                      | 364 ++++++++++++++++++++++
 kernel/sched/stats.c                      |  16 +-
 lib/find_bit.c                            |  17 +-
 tools/include/linux/find.h                |   9 +-
 tools/lib/find_bit.c                      |  17 +-
 tools/testing/selftests/rseq/basic_test.c |   5 +
 tools/testing/selftests/rseq/rseq-abi.h   |  22 ++
 tools/testing/selftests/rseq/rseq.c       |  86 ++++-
 tools/testing/selftests/rseq/rseq.h       |  46 ++-
 28 files changed, 1106 insertions(+), 57 deletions(-)

-- 
2.17.1

