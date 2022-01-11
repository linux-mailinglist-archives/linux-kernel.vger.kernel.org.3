Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAE48B3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbiAKRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:23:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34634 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiAKRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:22:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F3331F3B8;
        Tue, 11 Jan 2022 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641921777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZskkMbhrttBPymzvjqC0CxctwAqREPpDVDJuIHLbQw=;
        b=EYPm6xaE0PxL6rTyPVl6Mc/d4NkcrJkYiLvxhZejHxDO7P9C4xZCDC5QQ1N+RzliZpBPuE
        MdSnCZZwtIgSbxsyyseHpoVrAlM0rJ13mKWz0daEK2Knk+jIoiQxUDv3Sbp0Jh/IgQe8il
        wob4sRVCu6UK9ghTGL4Aa1U/tg0wi7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641921777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZskkMbhrttBPymzvjqC0CxctwAqREPpDVDJuIHLbQw=;
        b=pocegx6lFJH70d4LTF2pDgthnl+Sz0i42aYqhTqvAZW8XnV5CHMF32go3KQDEXTsqS0ubE
        tgz9kZR1EjRiENDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 363AC13AE7;
        Tue, 11 Jan 2022 17:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ePRODPG83WGFTgAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 11 Jan 2022 17:22:57 +0000
Date:   Tue, 11 Jan 2022 18:23:01 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/core for v5.17
Message-ID: <Yd289b35jcsSdJfl@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the sched/core pile for 5.17.

Thx.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_core_for_v5.17_rc1

for you to fetch changes up to 82762d2af31a60081162890983a83499c9c7dd74:

  sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs() (2021-12-11 09:10:00 +0100)

----------------------------------------------------------------
Peter Zijlstra says:

"Mostly minor things this time; some highlights:

 - core-sched: Add 'Forced Idle' accounting; this allows to track how
   much CPU time is 'lost' due to core scheduling constraints.

 - psi: Fix for MEM_FULL; a task running reclaim would be counted as a
   runnable task and prevent MEM_FULL from being reported.

 - cpuacct: Long standing fixes for some cgroup accounting issues.

 - rt: Bandwidth timer could, under unusual circumstances, be failed to
   armed, leading to indefinite throttling."

----------------------------------------------------------------
Andrey Ryabinin (4):
      cputime, cpuacct: Include guest time in user time in cpuacct.stat
      cpuacct: Convert BUG_ON() to WARN_ON_ONCE()
      sched/cpuacct: Fix user/system in shown cpuacct.usage*
      sched/cpuacct: Make user/system times in cpuacct.stat more precise

Barry Song (1):
      sched/fair: Document the slow path and fast path in select_task_rq_fair

Brian Chen (1):
      psi: Fix PSI_MEM_FULL state when tasks are in memstall and doing reclaim

Dietmar Eggemann (1):
      sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs()

Josh Don (1):
      sched/core: Forced idle accounting

Li Hua (1):
      sched/rt: Try to restart rt period timer when rt runtime exceeded

Liu Xinpeng (2):
      psi: Remove repeated verbose comment
      psi: Add a missing SPDX license header

Vincent Donnefort (3):
      sched/fair: Fix detection of per-CPU kthreads waking a task
      sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
      sched/fair: Cleanup task_util and capacity type

 include/linux/psi.h              |   1 +
 include/linux/psi_types.h        |  14 ++++-
 include/linux/sched.h            |   4 ++
 kernel/sched/core.c              |  84 ++++++++++++++++++++++--------
 kernel/sched/core_sched.c        |  66 +++++++++++++++++++++++-
 kernel/sched/cpuacct.c           | 107 ++++++++++++++++++---------------------
 kernel/sched/cpufreq_schedutil.c |   2 +-
 kernel/sched/cputime.c           |   4 +-
 kernel/sched/debug.c             |   4 ++
 kernel/sched/fair.c              |  87 ++++++++-----------------------
 kernel/sched/psi.c               |  47 ++++++++++-------
 kernel/sched/rt.c                |  23 +++++++--
 kernel/sched/sched.h             |  76 ++++++++++++++++++++++++---
 kernel/sched/stats.h             |   5 +-
 14 files changed, 343 insertions(+), 181 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
