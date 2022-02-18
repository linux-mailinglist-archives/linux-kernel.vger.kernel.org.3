Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6A4BBC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiBRPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiBRPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:24:27 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC371251E6E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:24:10 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id d3so15306989qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HicT2KGwDhgG1AYwf+MMrWNob5K09V49Vg8labRu7kg=;
        b=d4beppwB5fncwyC54lnbewyFAaG7ETyrZhdj0Ph5PbOch13zVobeX7xbo+X8sdZE7Y
         8YS4tgBRcV8EuMqs6hgA4Uz6v9qYxI2kBWXGhhlfrXk4rQD5WiagnMKZnIm5dD08ac0W
         yzi0ZReZ+Hp52L7RkmrDDx3BFP3AdkoAc62uIYdMZdX2Zf9ot/E7k08nEbpjx1GUtWWZ
         XX7pNVBTSX2yNCWi7KRvbca6h7XeCxbZBxnZRitfULxEH+DtttBMUolcmZhILUAMoPrL
         Qm1b7cXGkyx19obAanIw1/qa80zQRtnIpUaP5x+LYotW2sl2MWsdb5KJixQfVkpV1wRO
         GxJQ==
X-Gm-Message-State: AOAM532OSPHa2E+ypdeoDbOzeyPYB/tJFIKB9NyrvLND1CM9sXzfwNPS
        q9MVlzuZ4XkAXg9Btbc3VyQ=
X-Google-Smtp-Source: ABdhPJwJLyhtSjopHm8e2GCkzQjrvcV2L/Z8t7S3K+hHtkJkpcX6l4ogXK7Pbx20H72XsjsBbfv/GQ==
X-Received: by 2002:a05:6214:2a82:b0:42a:a3c7:b3be with SMTP id jr2-20020a0562142a8200b0042aa3c7b3bemr6399961qvb.131.1645197849808;
        Fri, 18 Feb 2022 07:24:09 -0800 (PST)
Received: from localhost (fwdproxy-ash-008.fbsv.net. [2a03:2880:20ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id x16sm22075203qko.17.2022.02.18.07.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:24:09 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     void@manifault.com, kernel-team@fb.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Subject: [PATCH] sched: Fix stale try_invoke_on_locked_down_task comment
Date:   Fri, 18 Feb 2022 07:23:29 -0800
Message-Id: <20220218152328.883437-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211230193633.1295745-1-void@manifault.com>
References: <20211230193633.1295745-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1e08b02e0cd5..d76e3da0d7d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4042,7 +4042,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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

