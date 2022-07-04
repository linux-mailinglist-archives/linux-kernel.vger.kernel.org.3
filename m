Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C1565780
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGDNhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGDNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:36:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4D62D1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:35:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3432953pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bR272ce/sINZ07mQ+ktujQfAs4k28/j7ThUkd+oaL8U=;
        b=YrfJruS9m6n0HU+jgGKUTIXK2LmHBAjdvlUsSia8RJkvVMOCWqdHqo+DK0qNOJlZck
         89Ckh+EhdZZjSGbMQ559O9nwLMKMIYNkZgjAGq2nB57ob36GqUk7NKnl0WNuUtmnN3P1
         tH6lcZnFao89hCc7sRb7z2AlPvH84Gc1UMM0amgdwNsRpzINIuyvLc2GDxo9MS6KJU4m
         lwHtcmmD/PB+NI95IIICgQBin42NI4kVhZE3CvadkO9CPigKNToknJGAEuu/GPA1RL8/
         CVa3hOKgou+ULN0s3kUsUINhWwWYtUhVQjHnH/mbpqXKElGt3GmZQJRMrFKCdt1m9DVq
         dS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bR272ce/sINZ07mQ+ktujQfAs4k28/j7ThUkd+oaL8U=;
        b=beRFioM+cqXwcO7RqUHn4z4LvmgLv5DrdnEB87fHInArfEpovNoqaDP0cLF/x1Fd9P
         owtrwIbvpN7AOx3hamv2/JnHGo+LluOHcqGX5cyytcNAnJhhD1fLp75KybJxtQbYrzkr
         g/bIyJnySfP00L4dyS3J+XZetX7lFPZNLXulzXmhrzRJSW2UbU+YVzW7SNr62kV8rUN3
         9f3jEhv5CKA4tBm9efT7nJu4aOUhhKPd7akkUKLtNMkVZEUxB3OwNgoONcv6+JK0fTV/
         3KvbRIIeN2/jE8u+yZXPOTQDMREFSyWPnIkWGbB3ljW7Rxxd2Sv/WUO6v4iYaKiO1C19
         t3hQ==
X-Gm-Message-State: AJIora84MG4XEcQmMPontRuOZ/8UaWaw4y/OS+kLnsbtXckcjbbYt9lz
        msFk8a7CVBomq6fuxi17AGg=
X-Google-Smtp-Source: AGRyM1s8mFzOwrQpJPlhHBNTDimxoJjNRt+iXEYFXjvJbocjYx4eDZzHbnNVhKqBc7Ojqc0+fVV0jQ==
X-Received: by 2002:a17:902:f381:b0:16b:d6e0:bfeb with SMTP id f1-20020a170902f38100b0016bd6e0bfebmr11723008ple.66.1656941711135;
        Mon, 04 Jul 2022 06:35:11 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b0016bea26bb2asm1368082plh.245.2022.07.04.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:35:10 -0700 (PDT)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER),
        jserv@ccns.ncku.edu.tw, Chin-En Lin <shiyn.lin@gmail.com>,
        foxhoundsk.tw@gmail.com
Subject: [PATCH v2 RESEND] sched/fair: avoid redundant hrtimer check
Date:   Mon,  4 Jul 2022 21:36:56 +0800
Message-Id: <20220704133656.2676043-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The check is required iff HRTICK is enabled and DOUBLE_TICK is disabled,
don't do that then.

Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
---

Changes since v1:
- Refine commit message

v1 link: https://lore.kernel.org/linux-kernel/20220606122612.2580930-1-foxhoundsk.tw@gmail.com/

Sorry, I shouldn't send v2 in the same thread.

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9..80cc1a924 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4668,7 +4668,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * don't let the period tick interfere with the hrtick preemption
 	 */
-	if (!sched_feat(DOUBLE_TICK) &&
+	if (sched_feat(HRTICK) && !sched_feat(DOUBLE_TICK) &&
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
-- 
2.36.1

