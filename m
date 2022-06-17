Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43D254F3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380682AbiFQJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:10:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA2554BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:10:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s37so3651338pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJGnbwi5MYQyjS4+9q5Y7gKs9wxJntkJMUiVbv/TYHI=;
        b=NyiA/gs6QG0Ta4mkYNXUvyn1qOn1K+ZO30n5HI3lmBVDQAJYvZBupBPVyEMe9wBTIU
         j2DtNgtCFk/g/jp/Dbd/W+fG2CEkl2p9H3YO+t/E//0sM8fxuGVp7BNquAyX2SeI/j1f
         zZ4/FIPIURLTAQQdgTsouj20s6Bk69Lc3R9rOrpK2a+iS28efzILEefHdCWThlLnK23K
         HctuUwrcwaqu6nzqI9jPl7xInYUZ1CqRCHbn1l2JKK8Eipgve2VegiOACvLhHZUxNx6X
         /TuZwGfE0a9cFIei7/TQzQtULShDeHujYG2QNKLgNiw1XDwl9aXFceDFN1NIThchpMH1
         g6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJGnbwi5MYQyjS4+9q5Y7gKs9wxJntkJMUiVbv/TYHI=;
        b=3b+sRejZX2k2JJfO8J7KtqDSo1xafgb/cnzhm6JhnBY6OX3iYr1YWxbSb0VZVLd6EE
         dvE0u+9LayTsO7215F8Fl/fdIOBBsyVvkwd0n2yKxeFwSMIEvX+Zm+axZjae4sPMCTXw
         1cZL+Ny3V7epg2lnGpAFLSUkMtDZKxKgjpcO7PH/wHLSpUgpipsoVGV2XbXp4FsORFaC
         18/desOtzyoTJq/Re/R7CK/TxRKzkHelt0H/Tu2LI5KgjJiGI/SQD+RXZiHeAHKU+Zcq
         oZpIeJKViIv4qGl5/U4wwTRhe1CpxXzka0EtjMH8PL+0wVLGblK1jwpMsKDj8CIV9+x5
         nwcQ==
X-Gm-Message-State: AJIora8KQfXTn5VrbrQNPEg97HI5ARNM3STJ55Ccv5PZh5z4BX/ilkiA
        1BHxBQSbY7gGURyyhllqec0=
X-Google-Smtp-Source: AGRyM1s/ndiCPHLLQcu2gvM1GW8ShZw9MwH6w3kTK1PxJbNF0lorQiBEKZklvOD/sgdqq4Q+zzboaw==
X-Received: by 2002:a63:fc01:0:b0:403:af21:9729 with SMTP id j1-20020a63fc01000000b00403af219729mr8233226pgi.54.1655457043691;
        Fri, 17 Jun 2022 02:10:43 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:d5d2:fc18:6baf:e16b])
        by smtp.gmail.com with ESMTPSA id e11-20020a63744b000000b003c25dfd7372sm3272201pgn.26.2022.06.17.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:10:42 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] locking/rwlocks: do not starve writers
Date:   Fri, 17 Jun 2022 02:10:39 -0700
Message-Id: <20220617091039.2257083-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Networking is still using rwlocks and read_lock() is called
from softirq context, potentially from many cpus.

In this (soft)irq context, rwlock code is unfair to writers
and can cause soft lockups.

We first noticed an issue with epoll after commit a218cc491420
("epoll: use rwlock in order to reduce ep_poll_callback() contention"),
but it is trivial to brick a host using this repro:

for i in {1..48}
do
 ping -f -n -q 127.0.0.1 &
 sleep 0.1
done

If really an unfair version of rwlocks is needed, we should introduce
a new read_lock_unfair().

[  673.678717][   C34] watchdog: BUG: soft lockup - CPU#34 stuck for 82s! [ping:17794]
[  673.700713][   C45] watchdog: BUG: soft lockup - CPU#45 stuck for 82s! [ping:17796]
[  673.702712][   C46] watchdog: BUG: soft lockup - CPU#46 stuck for 78s! [ping:17802]
[  673.704712][   C47] watchdog: BUG: soft lockup - CPU#47 stuck for 82s! [ping:17798]
[  677.636023][   C13] watchdog: BUG: soft lockup - CPU#13 stuck for 82s! [ping:17804]
[  677.638022][   C14] watchdog: BUG: soft lockup - CPU#14 stuck for 75s! [ping:17825]
[  677.644021][   C17] watchdog: BUG: soft lockup - CPU#17 stuck for 75s! [ping:17821]
[  677.650020][   C20] watchdog: BUG: soft lockup - CPU#20 stuck for 82s! [ping:17800]
[  677.686014][   C38] watchdog: BUG: soft lockup - CPU#38 stuck for 75s! [ping:17819]
[  681.691318][   C41] watchdog: BUG: soft lockup - CPU#41 stuck for 74s! [ping:17823]
[  684.657807][   C46] rcu: INFO: rcu_sched self-detected stall on CPU
[  684.664075][   C46] rcu: 	46-....: (1 GPs behind) idle=529/1/0x4000000000000000 softirq=22717/22717 fqs=20200
[  705.633252][   C14] watchdog: BUG: soft lockup - CPU#14 stuck for 101s! [ping:17825]
[  706.999058][  T309] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 14-... 41-... } 88575 jiffies s: 2325 root: 0x5/.
[  706.999069][  T309] rcu: blocking rcu_node structures (internal RCU debug): l=1:0-15:0x4000/. l=1:32-47:0x200/.
[  709.686574][   C41] watchdog: BUG: soft lockup - CPU#41 stuck for 100s! [ping:17823]
[  714.457782][   C41] rcu: INFO: rcu_sched self-detected stall on CPU
[  714.464047][   C41] rcu: 	41-....: (1 GPs behind) idle=403/1/0x4000000000000000 softirq=24654/24655 fqs=4653

Fixes: 70af2f8a4f48 ("locking/rwlocks: Introduce 'qrwlocks' - fair, queued rwlocks")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
---
 kernel/locking/qrwlock.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 2e1600906c9f5cd868415d20e2d7024c5b1e0531..bf64d14f0fc88613363c3c007bca8c0918709123 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	/*
 	 * Readers come here when they cannot get the lock without waiting
 	 */
-	if (unlikely(in_interrupt())) {
-		/*
-		 * Readers in interrupt context will get the lock immediately
-		 * if the writer is just waiting (not holding the lock yet),
-		 * so spin with ACQUIRE semantics until the lock is available
-		 * without waiting in the queue.
-		 */
-		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
-		return;
-	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
 
 	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
-- 
2.36.1.476.g0c4daa206d-goog

