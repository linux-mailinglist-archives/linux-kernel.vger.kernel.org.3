Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E804E59B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiCWUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbiCWUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:16:55 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41E635F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:15:24 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51338)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7O5-00C9y8-PK; Wed, 23 Mar 2022 14:15:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35234 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7O3-007wcm-Eh; Wed, 23 Mar 2022 14:15:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org, Barret Rhoden <brho@google.com>
References: <20220106172041.522167-1-brho@google.com>
Date:   Wed, 23 Mar 2022 15:14:47 -0500
In-Reply-To: <20220106172041.522167-1-brho@google.com> (Barret Rhoden's
        message of "Thu, 6 Jan 2022 12:20:38 -0500")
Message-ID: <87ee2sfmtk.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nX7O3-007wcm-Eh;;;mid=<87ee2sfmtk.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0zu18wbzoYY0CsriBmgu8B4tvqqWIehM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1532 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.3%), b_tie_ro: 2.6 (0.2%), parse: 0.73
        (0.0%), extract_message_metadata: 9 (0.6%), get_uri_detail_list: 2.1
        (0.1%), tests_pri_-1000: 11 (0.7%), tests_pri_-950: 1.00 (0.1%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 158 (10.3%), check_bayes:
        157 (10.2%), b_tokenize: 7 (0.5%), b_tok_get_all: 9 (0.6%),
        b_comp_prob: 1.98 (0.1%), b_tok_touch_all: 136 (8.8%), b_finish: 0.70
        (0.0%), tests_pri_0: 1337 (87.3%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 1.10 (0.1%), tests_pri_10:
        1.81 (0.1%), tests_pri_500: 7 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] prlimit and set/getpriority tasklist_lock optimizations
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the prlimit-tasklist_lock-for-v5.18 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git prlimit-tasklist_lock-for-v5.18

  HEAD: 18c91bb2d87268d23868bf13508f5bc9cf04e89a prlimit: do not grab the tasklist_lock

From: Barret Rhoden <brho@google.com>

The tasklist_lock popped up as a scalability bottleneck on some testing
workloads.  The readlocks in do_prlimit and set/getpriority are not
necessary in all cases.

Based on a cycles profile, it looked like ~87% of the time was spent in
the kernel, ~42% of which was just trying to get *some* spinlock
(queued_spin_lock_slowpath, not necessarily the tasklist_lock).

The big offenders (with rough percentages in cycles of the overall trace):

- do_wait 11%
- setpriority 8% (this patchset)
- kill 8%
- do_exit 5%
- clone 3%
- prlimit64 2%   (this patchset)
- getrlimit 1%   (this patchset)

I can't easily test this patchset on the original workload for various
reasons.  Instead, I used the microbenchmark below to at least verify
there was some improvement.  This patchset had a 28% speedup (12% from
baseline to set/getprio, then another 14% for prlimit).

One interesting thing is that my libc's getrlimit() was calling
prlimit64, so hoisting the read_lock(tasklist_lock) into sys_prlimit64
had no effect - it essentially optimized the older syscalls only.  I
didn't do that in this patchset, but figured I'd mention it since it was
an option from the previous patch's discussion.

v3: https://lkml.kernel.org/r/20220106172041.522167-1-brho@google.com
v2: https://lore.kernel.org/lkml/20220105212828.197013-1-brho@google.com/
- update_rlimit_cpu on the group_leader instead of for_each_thread.
- update_rlimit_cpu still returns 0 or -ESRCH, even though we don't care
  about the error here.  it felt safer that way in case someone uses
  that function again.

v1: https://lore.kernel.org/lkml/20211213220401.1039578-1-brho@google.com/

int main(int argc, char **argv)
{
        pid_t child;
        struct rlimit rlim[1];

        fork(); fork(); fork(); fork(); fork(); fork();

        for (int i = 0; i < 5000; i++) {
                child = fork();
                if (child < 0)
                        exit(1);
                if (child > 0) {
                        usleep(1000);
                        kill(child, SIGTERM);
                        waitpid(child, NULL, 0);
                } else {
                        for (;;) {
                                setpriority(PRIO_PROCESS, 0,
                                            getpriority(PRIO_PROCESS, 0));
                                getrlimit(RLIMIT_CPU, rlim);
                        }
                }
        }

        return 0;
}

Barret Rhoden (3):
  setpriority: only grab the tasklist_lock for PRIO_PGRP
  prlimit: make do_prlimit() static
  prlimit: do not grab the tasklist_lock

 include/linux/posix-timers.h   |   2 +-
 include/linux/resource.h       |   2 -
 kernel/sys.c                   | 127 +++++++++++++++++----------------
 kernel/time/posix-cpu-timers.c |  12 +++-
 4 files changed, 76 insertions(+), 67 deletions(-)

I have dropped the first change in this series as an almost identical
change was merged as commit 7f8ca0edfe07 ("kernel/sys.c: only take
tasklist_lock for get/setpriority(PRIO_PGRP)"). -- EWB

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
