Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1DF48E106
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiAMXkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiAMXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:40:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B4C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g6-20020a25db06000000b00611ca09ecd0so4587161ybf.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L3L608G8dLCC2M7zwc9YsP4GPhXeQWfVU2hcffF/nIQ=;
        b=tOOMnMmr4EweDOpVrMetgQw/nTj7tdLM9/og1CME1sbHCa1RgGMrZItNHCVmzxO9JA
         oAQCNeizO7OM953sQhxt34uuWWkRupyiEA9o4dRBAIE/XNL6E/in4N1Nfv67kjDfErwU
         /+Bi6mP5vtQtHVsPjPlGUeg3x6+avIiKSyDHtHs1MgYNPlQMRyhtGit4nOsYapDMWv2v
         3PKITVR6WCP5SQ8sxWF9LehDb6ke9/6EWNX2bK52ZGp/BAF3Bf4b2p1+3Pl1jqpYLmN5
         jphiRLI+Tr3+S0ei7PvlutokPwDMhatv0ww+2g8esIMuVsWEPxY3rDNqtWQjdES/C6e4
         /clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L3L608G8dLCC2M7zwc9YsP4GPhXeQWfVU2hcffF/nIQ=;
        b=WOtY57yZQ9uug4zG+GtFYdoiETF+qcTo1M3M8XljOmSjiN8cMcZry10Qk3GsoP/S9n
         zO2SuSQ6z1R3u85WQzvT+RAZL/e4OBiPD6kqqLWcKBM2TxMG747g76dTE19g0rHcAi0a
         PT9Fv9Z+Mmap8JvDXeU6lMJVqNKOED9lVYolhh+Wy37dfg1VMqLP3cxOwIOTwELbPXpr
         P1JQWo3SqVAoxnMmGAhswdYhPllM0BaCeZ8thA2dcfnUkXYt2GBlIOiaA0+OzY8qzZS5
         mDYeakJJ4bpz2O+eD6qTi1xoIVOXQMqShOlWIRZjj+5WZLNS9kpO8Lqi3YHdEsGCAWhU
         hXjg==
X-Gm-Message-State: AOAM533calNzwemfbHyxxqBygRXBA74y2jbtnvAiAxv0ubHO5L+U6Nzz
        gBilw9gz4isCZHJ+bQXIfabqaHPA
X-Google-Smtp-Source: ABdhPJwd13mNuiyAq/bOxfawkAKuzEBTlexflryVlvN15dLvMviu88qazdMu0oVcevG2zyvWfwkli6lA
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a05:6902:1504:: with SMTP id
 q4mr9994403ybu.375.1642117201723; Thu, 13 Jan 2022 15:40:01 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:35 -0800
Message-Id: <20220113233940.3608440-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 0/5] User Managed Concurrency Groups
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two small patches on top of peterz@'s RFC from
https://lore.kernel.org/lkml/20211214204445.665580974@infradead.org/


The new patches are not fully tested - I'm still working on it.
I'll post another patch shortly that adds worker timeouts in
sys_umcg_wait().

Sending this out just to break the silence and to assess if the
approach I'm taking here is not strongly NACKed.


Peter Oskolkov (3):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  sched: UMCG: add a blocked worker list
  sched: UMCG: allow to sys_umcg_kick UMCG servers

Peter Zijlstra (2):
  x86/uaccess: Implement unsafe_try_cmpxchg_user()
  sched: User Mode Concurency Groups

 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   3 +
 arch/x86/include/asm/thread_info.h     |   2 +
 arch/x86/include/asm/uaccess.h         |  57 ++
 fs/exec.c                              |   1 +
 include/linux/entry-common.h           |   6 +
 include/linux/sched.h                  |  86 +++
 include/linux/syscalls.h               |   4 +
 include/linux/thread_info.h            |   2 +
 include/uapi/asm-generic/unistd.h      |   9 +-
 include/uapi/linux/umcg.h              | 161 +++++
 init/Kconfig                           |  15 +
 kernel/entry/common.c                  |  18 +-
 kernel/exit.c                          |   5 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  12 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 913 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   5 +
 20 files changed, 1305 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c


base-commit: 85538cc07d6b6dcffc1df64a22308fcb05ecddf4
-- 
2.34.1.703.g22d0c6ccf7-goog

