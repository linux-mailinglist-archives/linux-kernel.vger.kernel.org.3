Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A759E9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiHWRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiHWRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:39:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D898768A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:26:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so19467375ejt.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gEDf08m9HuAaIRwhCw4ILroe/xz2UKZPzGdHs/AgXVE=;
        b=kqz6xYFl/d69sgLHoKpc/nNhpq5FV8X/oKohlSTCoFOeEmdwBIpQ9wVlu2enP3Q4DP
         YfgSc1xZFDn2Qb8ZyXylsZxJkbprMOHgXp9q1UO4u9SH+fY1v38yA7sBkQYYESvup9IE
         Ez2P5/pifaGhYewtsl625Nz53YPDIrPDXxC4I2uCSAZET2zDioo0Jzv+3mXhJO5X7Iem
         fIOa3AanvUL2cNlVC8ThozJEVKCLIA18le76Ibwc7SJjSOvUiPWrMAiDo+sQSdhPv7RU
         KQv3SgMJ6HdbVNitl/92j17+62xvvsArxOkwoSUouspIXj6OI8p+lZJ4y7+OWQCMf5B5
         Zj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gEDf08m9HuAaIRwhCw4ILroe/xz2UKZPzGdHs/AgXVE=;
        b=s6bICA13GPhjDfAh7vPKkNfrH3Rg1sjVPQkwfYtB1smvHn7GdryAt0JyJFi/M144h2
         Q2nFTeWkFsvHdEpoFxrgiO17la967kgt9SkEockcfpCownyyFqsO3ZOgp5sSYvqy4YY6
         KND+ergFdiFigbmHvSE4l8TqyobtciIoOPbSFd5qdUEh+oVKA8WCJQJirehPPiCXJxiv
         9fbBvhY2+uHJODbcUQRyLIfH+x6E2yQtKq3dgHKY5tvEoeEZ5tQ6MkTjx7767eNfZWth
         cvp8xkFrnJ9kY21RZhVNG+lamX5FTupjDTFx1Ezm7/KIGw46ytpSTOP+Z6ryWVKbK/zS
         7rcg==
X-Gm-Message-State: ACgBeo1/AkqrYlOC7Q9gZWYFvm6hb+OLFisNU/C4T0zggOMcDjB+5w9e
        lIYw0/xBq+rJ1fvLsYGUSPUC/Z79qrFjJQ==
X-Google-Smtp-Source: AA6agR7tDFsZvDMSefudWnSPcjv11EV3KYeeoQcguLzkRqF4zlEvCmvVrN+6FyIFYINrKzR5Y3SPCA==
X-Received: by 2002:a17:907:9803:b0:73d:836f:d266 with SMTP id ji3-20020a170907980300b0073d836fd266mr75501ejc.171.1661268401740;
        Tue, 23 Aug 2022 08:26:41 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b007030c97ae62sm7531572ejy.191.2022.08.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:26:41 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] task_work: Use try_cmpxchg in task_work_add, task_work_cancel_match and task_work_run
Date:   Tue, 23 Aug 2022 17:26:32 +0200
Message-Id: <20220823152632.4517-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
task_work_add, task_work_cancel_match and task_work_run. x86 CMPXCHG
instruction returns success in ZF flag, so this change saves a compare
after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

The patch avoids extra memory read in case cmpxchg fails.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/task_work.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index dff75bcde151..065e1ef8fc8d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -47,12 +47,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	/* record the work call stack in order to print it in KASAN reports */
 	kasan_record_aux_stack(work);
 
+	head = READ_ONCE(task->task_works);
 	do {
-		head = READ_ONCE(task->task_works);
 		if (unlikely(head == &work_exited))
 			return -ESRCH;
 		work->next = head;
-	} while (cmpxchg(&task->task_works, head, work) != head);
+	} while (!try_cmpxchg(&task->task_works, &head, work));
 
 	switch (notify) {
 	case TWA_NONE:
@@ -100,10 +100,12 @@ task_work_cancel_match(struct task_struct *task,
 	 * we raced with task_work_run(), *pprev == NULL/exited.
 	 */
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
-	while ((work = READ_ONCE(*pprev))) {
-		if (!match(work, data))
+	work = READ_ONCE(*pprev);
+	while (work) {
+		if (!match(work, data)) {
 			pprev = &work->next;
-		else if (cmpxchg(pprev, work, work->next) == work)
+			work = READ_ONCE(*pprev);
+		} else if (try_cmpxchg(pprev, &work, work->next))
 			break;
 	}
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
@@ -151,16 +153,16 @@ void task_work_run(void)
 		 * work->func() can do task_work_add(), do not set
 		 * work_exited unless the list is empty.
 		 */
+		work = READ_ONCE(task->task_works);
 		do {
 			head = NULL;
-			work = READ_ONCE(task->task_works);
 			if (!work) {
 				if (task->flags & PF_EXITING)
 					head = &work_exited;
 				else
 					break;
 			}
-		} while (cmpxchg(&task->task_works, work, head) != work);
+		} while (!try_cmpxchg(&task->task_works, &work, head));
 
 		if (!work)
 			break;
-- 
2.37.1

