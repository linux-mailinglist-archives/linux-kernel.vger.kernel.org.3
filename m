Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4048684E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiAFRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiAFRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:20:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBEC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:20:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so6214618ybp.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K9TUtPModkAHXBzXcKkpf5OJ1aK/jrUSBQ4bJOlGXG0=;
        b=iOTK/PFVTzyNu9OwQgW24CE8GR020/SHk0H9p2OonGZSfh7bmq7NbT/QB88vX0hfmT
         TISep02s7agJ2wHlM+rJN55KFszZxm1b2oS6YoM7HhjgGt5wraTeG4pg5BuHHlVAVKSN
         jjN2LaaIxZNU7G3fS3jA78oJX4oLn64yL3ny7QpnDT1j/d8yB3b7jGLZV5ZFfWh21zZC
         SDmDtVqLN6CMatDd9yv94DnTDB9oBiCG5t9QqmyPLyaKRpivPHGGicUCsNs3NldQCnYE
         MOASyEcqNpYnn5gOvL0jhupn7d2AI/QAa8JcFLB6zB5L/m2p04UGt6Wbw3Xs94j1aJ9T
         gz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K9TUtPModkAHXBzXcKkpf5OJ1aK/jrUSBQ4bJOlGXG0=;
        b=gpno5SSN90WvKg65O8S7Lu5QRgQA77D9hNtUrM1duYbddvwqO/H/RibEnql5bjf+Bx
         1e2lS5Z/C3P6Nx2q07ZKKax078Cp/Byo7fsZE2pmldq6GMHMoJQFTonAQyLosf7o3tKP
         mUA/a20Awk50osETGxMned4lrGstAz6ZuXJhnA6Ig2Y0DEcAFj19Ngur+jiX6THMz+vn
         suuI8u6yqnSBYFeGCggaS9nA9lpWa3kLlQkrb3paRrKJhYBnLPZXjJTqweO7lDPBPM/N
         bGnL+5YKixsO0QetccHhfrkAbAB6dgqg4LEXVqFNqIhjLv/7Yauhxep4ojOUwlDMEePW
         Lmjg==
X-Gm-Message-State: AOAM531J/rB0EfmiX091el3TX1fM3hhRHpRnlVlDIo+tiDPtiMOYFQbX
        9vshUu7XF1N+d3wJY6retjtZetXc
X-Google-Smtp-Source: ABdhPJyG8PYtAw2y8kUall7irnMe7o7v/8DM1FFtEAANjOeQ3txDb4Gt7BEWxPFRvml6nXlwKuqFeHly
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:f130:19b6:8678:c9d1])
 (user=brho job=sendgmr) by 2002:a5b:38b:: with SMTP id k11mr70987955ybp.220.1641489653264;
 Thu, 06 Jan 2022 09:20:53 -0800 (PST)
Date:   Thu,  6 Jan 2022 12:20:38 -0500
Message-Id: <20220106172041.522167-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 0/3] prlimit and set/getpriority tasklist_lock optimizations
From:   Barret Rhoden <brho@google.com>
To:     ebiederm@xmission.com
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v2: https://lore.kernel.org/lkml/20220105212828.197013-1-brho@google.com/
- update_rlimit_cpu on the group_leader instead of for_each_thread.
- update_rlimit_cpu still returns 0 or -ESRCH, even though we don't care
  about the error here.  it felt safer that way in case someone uses
  that function again.

v1: https://lore.kernel.org/lkml/20211213220401.1039578-1-brho@google.com/

#include <sys/resource.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

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

-- 
2.34.1.448.ga2b2bfdf31-goog

