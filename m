Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAC4FAC22
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 06:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiDJFAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 01:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiDJFAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 01:00:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C01BE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 21:58:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so11945pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=re0SYElh8Djw9DjBeyMp4tYzK4WKuGI/dfR89zOFSkU=;
        b=NtOy2QtB5ZZ5MdRiOw8B29TeCsbwI6UVuJx9uJafnW0wQxaovIcUYo+kuYx0CDvz7H
         HuoXtb7jzixpLB/BcijksoITt6TTd+KY1BQuxP4Y3H5xXQPA7KYotiuy7IxmSKkwDvYH
         +MQ1HppNI2wNmSp75BesS5P6t6iV4f3puka8iXmCYhig88cd5HxvHQ1rrnsp/RDGLy60
         NBoBxf3eyB9/FG7Ub8h0tpX24ksxv20SmSfI0tPX1VIND9f+C9sf6+hJt45OH0x2KRzc
         yYFukm3xRYI1QCVNRJiNbzwegJYkT/YK7S266vfQntxas9Kv0h9XZn2GwUxmCncnJk4q
         wiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=re0SYElh8Djw9DjBeyMp4tYzK4WKuGI/dfR89zOFSkU=;
        b=kJ8L3/nQJsBX7M/dQPrOWrXFZRvxFrtd3y31VI6fKfjrutDVdXQIlO0B+wF7963rBN
         UuqMfFcq3Xo3iUuph1HRnCqCqiX2TLFs/Kr0XnVnI4lDIiNLxgHNClXrNFWcTFNz+yrN
         3rVUS6kw5j+PyX5ykhcaJAOIfLDcBwl2tUUIADHufc9+krre/wK0/173cCBzxCnzLF1s
         h8/E+W68yCAXzaWqpzSV/iZGfoAuBgHl2LXFzOkHlBIorcHGLTaYg7OzSKUjBgnToiRI
         kOhFCUy/OU7vRACQR9qb//VDzPUv3MMUpJi+ploBt4Q+TZzkySZPzvO5Eva608y+INkr
         6LxQ==
X-Gm-Message-State: AOAM531aZBZNMqonadx/sT6KzzDypIzrWPZjCUurKuHRERYNjjLNa2/n
        mlJtg9MEwVg24TM1C0TfuOw=
X-Google-Smtp-Source: ABdhPJz+JfyXkIOkVjlr5UF6w+nOGZZV1PM9ktGIkVZ9YkaNnMx9CCThTCAa+LY2snXpQktge266Zg==
X-Received: by 2002:a17:902:ced0:b0:153:f78e:c43f with SMTP id d16-20020a170902ced000b00153f78ec43fmr26374284plg.64.1649566721041;
        Sat, 09 Apr 2022 21:58:41 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm30493643pfi.86.2022.04.09.21.58.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2022 21:58:40 -0700 (PDT)
From:   zgpeng <zgpeng.linux@gmail.com>
X-Google-Original-From: zgpeng <zgpeng@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix the scene where group's imbalance is set incorrectly
Date:   Sun, 10 Apr 2022 12:58:36 +0800
Message-Id: <1649566716-24687-1-git-send-email-zgpeng@tencent.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the load_balance function, if the balance fails due to
affinity,then parent group's imbalance will be set to 1.
However, there will be a scene where balance is achieved,
but the imbalance flag is still set to 1, which needs to
be fixed.

The specific trigger scenarios are as follows. In the
load_balance function, the first loop picks out the busiest
cpu. During the process of pulling the process from the
busiest cpu, it is found that all tasks cannot be run on the
DST cpu. At this time, both LBF_SOME_PINNED andLBF_ALL_PINNED
of env.flags are set. Because balance fails and LBF_SOME_PINNED
is set, the parent group's mbalance flag will be set to 1. At
the same time, because LBF_ALL_PINNED is set, it will re-enter
the second cycle to select another busiest cpu to pull the process.
Because the busiest CPU has changed, the process can be pulled to
DST cpu, so it is possible to reach a balance state.

But at this time, the parent group's imbalance flag is not set
correctly again. As a result, the load balance is successfully
achieved, but the parent group's imbalance flag is incorrectly
set to 1. In this case, the upper-layer load balance will
erroneously select this domain as the busiest group, thereby
breaking the balance.

Signed-off-by: zgpeng <zgpeng@tencent.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299..e137917 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10019,13 +10019,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		}
 
 		/*
-		 * We failed to reach balance because of affinity.
+		 * According to balance status, set group_imbalance correctly.
 		 */
 		if (sd_parent) {
 			int *group_imbalance = &sd_parent->groups->sgc->imbalance;
 
-			if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0)
-				*group_imbalance = 1;
+			if (env.flags & LBF_SOME_PINNED)
+				*group_imbalance = env.imbalance > 0 ? 1 : 0;
 		}
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-- 
2.9.5

