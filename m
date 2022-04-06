Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0704F620E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiDFOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiDFOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:50:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715265E9857
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:23:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d15so1657580pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=W1IYkjMUQdZYCUET1UeGta4MM9L17ipJdw8Dgmfkpyw=;
        b=Et4N7xK4bHak89+cPHZp1nSEK+bpG+KgCEzg6jNz3ydXqMPk31aYkVJ2Z28lRccDbw
         8YAJXY/4iN480SVqbhRUocuamQS1/sv6t+BhkWCzaffILyCbRZfPB+Ubay6WatQLuXyB
         LwnWHjkir59o+yNSyApQFwhrcAZb8IxmRTA37HmResrVPB+WCAZ85gm46qLN63bBMIUY
         tembVvxxfAV8CGOorTYEt9Iz+VmI3hv14Rs7FYLeMvVPbxzYei6t0z4Wya3RcdnZ/Okw
         yCJCGdjdWpCk42AnObeo0gHcqJGpJ2sMySYg8rnVMq43yFBhoS6PlIgICUwNmquEfBsA
         6Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=W1IYkjMUQdZYCUET1UeGta4MM9L17ipJdw8Dgmfkpyw=;
        b=q96vA1pFe71iToxnBk8+akw0hNU18zyaGD+Q2LkLFBKvR8Q0jHB7UtxESK+sTM1n7o
         XdUMXpSbyRg2uqjzjTh4wxKMjacFgJAmEGL4zWBEe9gB15Hbi4y2Cl9Cys7sIQS7RI/V
         GR7N3BIjAa2R0VTkHkX6GmGqp+mhS2hjavIN4zQ+We5fT2C/IXtUqegqLbmX4jNwnC12
         neWQkaNcOKFCD3O3bbmW10j4WDEgr8utz0avLM4FHtYfS9BUACH29I/TM6ShErFAne7G
         Mxzsa2J7g+gsJzgAkT2JgdHKBpw0gKUS3+cxKkvbulR2mAFNSa0mxIeKZpU8BW6kh9NP
         Xu2g==
X-Gm-Message-State: AOAM532/qzUib3dJ8U0Gh4CQfqbqaMcLueppgP2jng0dIZr0twKD6cip
        XpFA+xTsJnLDWuPKn4NGYZc=
X-Google-Smtp-Source: ABdhPJxR9BkekwUN/i1+Qy04bmdgbscQESwDFAeZsMoiCq+aUcQtbd4EF5LdSBRUHQjC9l0z1d0k/w==
X-Received: by 2002:a17:902:da8c:b0:156:c7a0:10f8 with SMTP id j12-20020a170902da8c00b00156c7a010f8mr8017518plx.71.1649244208555;
        Wed, 06 Apr 2022 04:23:28 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm19209287pfh.83.2022.04.06.04.23.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:23:28 -0700 (PDT)
From:   zgpeng <zgpeng.linux@gmail.com>
X-Google-Original-From: zgpeng <zgpeng@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Return the busiest group only if imbalance is meaningful
Date:   Wed,  6 Apr 2022 19:23:24 +0800
Message-Id: <1649244204-23471-1-git-send-email-zgpeng@tencent.com>
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

When calculate_imbalance function calculate the imbalance, it may
actually get a negative number. In this case, it is meaningless to
return the so-called busiest group and continue to search for the
busiest cpu later. Therefore, only when the imbalance is greater
than 0 should return the busiest group, otherwise return NULL.

Signed-off-by: zgpeng <zgpeng@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 601f8bd..9f75303 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9639,7 +9639,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
 	calculate_imbalance(env, &sds);
-	return env->imbalance ? sds.busiest : NULL;
+	return env->imbalance > 0 ? sds.busiest : NULL;
 
 out_balanced:
 	env->imbalance = 0;
-- 
2.9.5

