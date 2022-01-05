Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28F485AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiAEVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiAEVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4645CC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:31:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so1231076yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/c+hupHolpNezWXPsUIEtILMcSftWF7JWna4vjK/AJs=;
        b=de7Q4G3fJEQF5UTIrNkDt6hX7dxiERqP01VvYVK3KMyXKDNwZDIwz5s9S2rIoxH/69
         VT3Kg5uv7uxHTT4KbSjFlvml09+gDUnC7HpxvhE+o6BnOWcpdwFfhQY5zWro27Ph549M
         +CwUofeHBhDKTABFsMdoVv2kqjqYXCJGHVpwsz3Y36SBsLehGtqzA2psW+6OdEQuUUb3
         Ol5dU/x8ts5UIlAZFSv03c3sKG7Og18ZGp5+C3rNHYCsXNjim7i5r95oQEwJYRm4BSkP
         OUtWtzhJB7FGB/hBvuUnR2VL4nswP0UVYD0TrUTMgdKypq5rdpxS8jG2mLfulo3qOENd
         X1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/c+hupHolpNezWXPsUIEtILMcSftWF7JWna4vjK/AJs=;
        b=rnpdRAT61gMZy8vvhZWGGFa+cxsZWc+yh57pLH4Ntvm8KFfea+VkI9JkBWh0zLA1mZ
         ZA4hs0ctVlS1nqnJCHUzCSl0zoh7s8IezlJUEq1KfNB/ul73aVWhryIpUVKFhIl4wO9H
         vd2OjHEkeGaiTsGQi89Khx/cYgu9Z0sTK7vT+uaCOUbMME/QMv5jWmc4n57VAU6iZme2
         4ulSYLTRGNjiBX+F6ZcIa4uciVYE7Sz9RgYAA8ghkuuYtkyNb616agjbmjVujoXU/+hk
         7wLRWl2DW1Hv1yQiDAO3GsHkiawLBCAWYdAwSp18NerFd7UMya70BRIiMkj/7lixUNRf
         Jefw==
X-Gm-Message-State: AOAM533FUsmSUkoscF08grA99p6pAnTAHAjsm0ROitY/+S9p+Kf7soGb
        /kavtFTv5YMXiB4dT3+bcn/9gi9M
X-Google-Smtp-Source: ABdhPJyWgIBHuYnsd2kQNibQ2qyHm/PrjNUg/NEAx+nGQ2fRsKrxQD014t6XxgFIN+puZFw6X1bB3iP1
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:3ab7:a23:e07a:5e22])
 (user=brho job=sendgmr) by 2002:a25:add7:: with SMTP id d23mr63761902ybe.583.1641418287448;
 Wed, 05 Jan 2022 13:31:27 -0800 (PST)
Date:   Wed,  5 Jan 2022 16:28:25 -0500
Message-Id: <20220105212828.197013-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 0/3] prlimit and set/getpriority tasklist_lock optimizations
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
baseline to set/getprio, then another 14% for prlimmit).

One interesting thing is that my libc's getrlimit() was calling
prlimit64, so hoisting the read_lock(tasklist_lock) into sys_prlimit64
had no effect - it essentially optimized the older syscalls only.  I
didn't do that in this patchset, but figured I'd mention it since it was
an option from the previous patch's discussion.

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
 kernel/sys.c                   | 134 ++++++++++++++++++---------------
 kernel/time/posix-cpu-timers.c |  12 ++-
 4 files changed, 83 insertions(+), 67 deletions(-)

-- 
2.34.1.448.ga2b2bfdf31-goog

