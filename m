Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925349710B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiAWLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:06:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiAWLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:06:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE80E212BC;
        Sun, 23 Jan 2022 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642936000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8eNWFnpGFqiO4g2o4X7Zt+x6qEEq4MmO+SyRS37X1dk=;
        b=mQXqi+LGN7XCs/oHMDAyODw8YIbdqV7SmAb8pT94RCvN/1nMXxi/0t+5ojjKdw9zZIWVx9
        ExiQ4hoqgx+VKOWopttmILDig0Hs+k0mQ31V0+m9NcUE7/c2lB05noFmVSMQjHnOs8ihA6
        JjNW0UQN6mAGEHDXlIZD1lGhxcRnK0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642936000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8eNWFnpGFqiO4g2o4X7Zt+x6qEEq4MmO+SyRS37X1dk=;
        b=ZEY7UXTLa+bKXLpftpFkksrcvb5s7yOveDUJvpjxguqNqplYhh3LQPtagf9jZPubmCCI+0
        kGuefoiWbZiTuWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEB3F1333C;
        Sun, 23 Jan 2022 11:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Zw4KsA27WGiIwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Jan 2022 11:06:40 +0000
Date:   Sun, 23 Jan 2022 12:06:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.17-rc2
Message-ID: <Ye02u8jFsitJqSO7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of scheduler fixes for v5.17-rc2.

Thx.

---

The following changes since commit fb3b0673b7d5b477ed104949450cd511337ba3c6:

  Merge tag 'mailbox-v5.17' of git://git.linaro.org/landing-teams/working/fujitsu/integration (2022-01-13 11:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2

for you to fetch changes up to 0e3872499de1a1230cef5221607d71aa09264bd5:

  kernel/sched: Remove dl_boosted flag comment (2022-01-18 12:10:00 +0100)

----------------------------------------------------------------
- A bunch of fixes: forced idle time accounting, utilization values
propagation in the sched hierarchies and other minor cleanups and
improvements

----------------------------------------------------------------
Cruz Zhao (1):
      sched/core: Accounting forceidle time for all tasks except idle task

Hui Su (1):
      kernel/sched: Remove dl_boosted flag comment

Peter Zijlstra (1):
      sched: Avoid double preemption in __cond_resched_*lock*()

Randy Dunlap (1):
      sched/fair: Fix all kernel-doc warnings

Suren Baghdasaryan (1):
      psi: Fix uaf issue when psi trigger is destroyed while being polled

Vincent Guittot (4):
      sched/pelt: Relax the sync of util_sum with util_avg
      sched/pelt: Continue to relax the sync of util_sum with util_avg
      sched/pelt: Relax the sync of runnable_sum with runnable_avg
      sched/pelt: Relax the sync of load_sum with load_avg

 Documentation/accounting/psi.rst |   3 +-
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |   3 -
 include/linux/sched.h            |   4 --
 kernel/cgroup/cgroup.c           |  11 +++-
 kernel/sched/core.c              |  15 ++---
 kernel/sched/core_sched.c        |   2 +-
 kernel/sched/fair.c              | 118 +++++++++++++++++++++++++--------------
 kernel/sched/pelt.h              |   4 +-
 kernel/sched/psi.c               |  66 ++++++++++------------
 10 files changed, 125 insertions(+), 103 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
