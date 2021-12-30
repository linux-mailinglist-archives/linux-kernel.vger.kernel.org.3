Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6906481FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhL3Tjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:39:37 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38434 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbhL3Tjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:39:31 -0500
Received: by mail-qk1-f177.google.com with SMTP id i187so21382187qkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCSpXCV412msKEEhoCBJsLwOms/P7rpzVy9MnDRV6dI=;
        b=idFuSdFmwxdT35Tfo1s9ZhlploOlGF7SvnTa5UqJMW2cs38AKZGDVws20deik/5Twu
         KcSTq11a0vC2qWWad2SQCnE2v+ephbxblIXL/4DxVwFY8LCXBAeolxpy6SB9uiW4TlnB
         wShd+QZlLccUtPWDu/1HmIABxhIvaSY/MDyKw9Rkr0JWxttvufR6BYMQf8LiMmwvhRS2
         IcJeSJaS+mF4TiNil2HEybxAx2uqHIYNasGe5zS9MROtb8ENmim1/uUCMf6CAcNIKBkX
         r1hbQaHdVh7Aj/jJP6s0fnJDeEIMs/B+nkzxUNUOkxC/eoEWfXDZpQEK3pr1P9jrDvOi
         hKgQ==
X-Gm-Message-State: AOAM5322g4oKN0bJzGXMdSQTgj3IElD/NwJKzffjN6hzl9Ih4qZvIVPq
        ljv4gU/edTQr3XP74IE4bJI77JgsvCx6kg==
X-Google-Smtp-Source: ABdhPJzUfh6xlXyVGYycGEU743vSctGS4rNokzW8zKPtS+SkcbvS/xMrr2uZtF8PclcjWt9eLHNDYQ==
X-Received: by 2002:a05:620a:2586:: with SMTP id x6mr23525172qko.260.1640893169877;
        Thu, 30 Dec 2021 11:39:29 -0800 (PST)
Received: from localhost (fwdproxy-ash-022.fbsv.net. [2a03:2880:20ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id o10sm21354332qtx.33.2021.12.30.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:39:29 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, void@manifault.com
Subject: [PATCH] sched: Fix stale try_invoke_on_locked_down_task comment
Date:   Thu, 30 Dec 2021 11:36:34 -0800
Message-Id: <20211230193633.1295745-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 9b3c4ab3045e, try_invoke_on_locked_down_task() was renamed to
task_call_func(), and several callers, comments, etc were updated to use
the new name and signature. There was one comment in try_to_wake_up() that
was missed, and still refers to the old name. This diff corrects that
comment to refer to the new name.

Fixes: 9b3c4ab3045e ("sched,rcu: Rework try_invoke_on_locked_down_task()")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe53e510e711..ec78cf2e97f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4038,7 +4038,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 *
-	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+	 * A similar smb_rmb() lives in task_call_func().
 	 */
 	smp_rmb();
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
-- 
2.30.2

