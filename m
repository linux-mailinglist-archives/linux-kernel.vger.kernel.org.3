Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9E465748
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353058AbhLAUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352927AbhLAUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FF42B81F44;
        Wed,  1 Dec 2021 20:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC5C53FAD;
        Wed,  1 Dec 2021 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391270;
        bh=UlYUruOIlwj8u4zg5yeiwwNYkTjg6cEKgy3ujpg3buk=;
        h=From:To:Subject:Date:From;
        b=RPqnTXCD6HWzptI3Z3FNzyv/5WM0OYBns3P0EvYewRAt3IneXP+3wHfq2nMNnG8cw
         QYSnooRQEZnQ9PasGTyJ+MvEQ+J25tNAeGE5OgyRuAqQbqbObz7IDPr8BSQwTB0G1X
         rl0+mTi0LDrYfkLkudHhDQSA/yMaymJMvKDocAkW83b00dCOPuwfluNF9HS4ZWX5qD
         ObSBc9iAMYsOpIM0OtLHJbX74MvnxPPyD1ciLTEakw/PaxoecZxHUdGcmsj6BiobnA
         LP+US8iGEq20AjXD5TtlJW1w94VVuSGEiTZPDIA79Y4SiVZLla8dzSb6RVZHIuGkFV
         Jwpb/Kau/MrhA==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/8] Linux v5.4.161-rt67-rc1
Date:   Wed,  1 Dec 2021 14:41:00 -0600
Message-Id: <cover.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.161-rt67-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-12-04.

To build 5.4.161-rt67-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.161.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.161-rt67-rc1.patch.xz

You can also build from 5.4.161-rt66 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.161-rt66-rt67-rc1.patch.xz


Enjoy,

-- Tom


Mike Galbraith (1):
  mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t

Sebastian Andrzej Siewior (6):
  sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
  preempt: Move preempt_enable_no_resched() to the RT block
  mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE on
    PREEMPT_RT
  fscache: Use only one fscache_object_cong_wait.
  fscache: Use only one fscache_object_cong_wait.
  locking: Drop might_resched() from might_sleep_no_state_check()

Tom Zanussi (1):
  Linux 5.4.161-rt67-rc1

 fs/fscache/internal.h   |  1 -
 fs/fscache/main.c       |  6 ------
 fs/fscache/object.c     | 13 +++++--------
 include/linux/kernel.h  |  2 +-
 include/linux/preempt.h |  6 +++---
 init/Kconfig            |  2 +-
 kernel/sched/core.c     |  2 +-
 localversion-rt         |  2 +-
 mm/zsmalloc.c           | 12 ++++++------
 9 files changed, 18 insertions(+), 28 deletions(-)

-- 
2.17.1

