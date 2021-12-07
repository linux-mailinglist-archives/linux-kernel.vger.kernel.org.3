Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2546B407
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhLGHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLGHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:38:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D0C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so1917884pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rsxgFQcAdu4hWoHlpus5/PXVf7/O96VUMaXvlheY6k=;
        b=Ch00g5onDvt4dUj3v1sisEasyhFtN3ci0XaTZkI/vxwIXwBrrCEcHztJfmyOgrJFCt
         8dKDDWirlyzIk3+BTMRa/gFSpjizmZLlk/P+gLqnuPrIssP1B7Fd6AAY0KvgL2u7t1cJ
         1wpPsoP0mbNFYbbGAcHMLEelyctsq+bNAhfep1jjWbzaLiu51x+SOydCDHGtWUQ3H0No
         baEUVHLkbvk+xTBM7ooDsfBNPjlgY3f/psnv7avxt1EseR7EjoXjWEFv0D9ExYY3O0uN
         69K9Yyr4JqLD/6oNDSB4rwIdV3Uobg/5A5ArcUG3JHORYdEnorUY5tRhKO6Fsk7k/Td4
         UTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rsxgFQcAdu4hWoHlpus5/PXVf7/O96VUMaXvlheY6k=;
        b=cb52iUC8nWcb2V1J8ql/g/TBoBTuI2CcjSNblMHQL7FU+p+L/IxHEvx04U4a+DH3rV
         pEwHTa97iaVCkEGFipF4JoLdY92jk3WSThz5Qt0YVtH4aT7i0UKrqR1GE5RkAb3ITXID
         2mkDUSPrsl7GDsC6MGa6L38OquOOShO9d44ArWJk9KhxsFVVnGNsfz7OfalEH+80SlXT
         aqa6+8jHfzrtjFeS/LfEu0GKKjCztxeLgxPl8CqTaDcWgzjNxpzrwFYoGG/CXVlbLF53
         4nIMqYT9f1B5vcF4AzTmlCCrblYS8LHzt0lionH6GwVcv+o/dmgsVqxfDzImKqHC9r8s
         yM6w==
X-Gm-Message-State: AOAM533wlFdjEqSUnpQNOyd5H55kHnoEF3ywjWAIcWYkzMoau7PvtD4k
        bLm75RKkeo3wTd3Rj0kSN40ecckfuIA=
X-Google-Smtp-Source: ABdhPJzr/xdjzde/kDdJXWm7R7uhROxjdDTNB4E1XF++aP0QzNN9rU1P7sHUEq6nNAb4wGzD4asgCg==
X-Received: by 2002:a17:902:ee95:b0:141:f28f:7296 with SMTP id a21-20020a170902ee9500b00141f28f7296mr49525247pld.50.1638862529535;
        Mon, 06 Dec 2021 23:35:29 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id j17sm14406831pfe.174.2021.12.06.23.35.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:29 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/7] workqueue: cleanups for schedule callbacks
Date:   Tue,  7 Dec 2021 15:35:36 +0800
Message-Id: <20211207073543.61092-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 6d25be5782e4 ("sched/core, workqueues: Distangle worker
accounting from rq lock") changed the schedule callbacks for workqueue.

It simplified the connection between scheduler and workqueue.  But it
caused some code uselss and some comments outdated in workqueue.  This
patchset clean them up.

Patch1 is unrelated to 6d25be5782e4, it is related to a recent change
to make wq_worker_sleeping() not being called in preempt disabled
section.

Patch2 is cleanup for 6d25be5782e4 not calling schedule callbacks in
deeper sleeping path with local-wake-up fashion.

Patch3 is unrelated to 6d25be5782e4, but weakly prepared for patch4.

Patch4-6 are cleanup for 6d25be5782e4 not calling schedule callbacks in
wakeup code, so cacheline_aligned for nr_running and schedule() in
unbind_workers() is unneeded.

6d25be5782e4 also changed to use pool lock in wq_worker_sleeping(),
and patch 7 changes it back to use preemption disabling.  This patch is
marked for 'RFC' because using pool lock in slow (sleeping) path is OK
for me and paves the road to remove "X:" protection.

There are several further cleanups depended on if patch7 is accepted or
not.  For example, mb() in insert_work() can be removed if pool lock
wins.

Lai Jiangshan (7):
  workqueue: Remove the outdated comment before wq_worker_sleeping()
  workqueue: Remove the advanced kicking of the idle workers in
    rebind_workers()
  workqueue: Remove outdated comment about exceptional workers in
    unbind_workers()
  workqueue: Remove schedule() in unbind_workers()
  workqueue: Move the code of waking a worker up in unbind_workers()
  workqueue: Remove the cacheline_aligned for nr_running
  workqueue: Replace pool lock with preemption disabling in
    wq_worker_sleeping()

 kernel/workqueue.c | 102 +++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

-- 
2.19.1.6.gb485710b

