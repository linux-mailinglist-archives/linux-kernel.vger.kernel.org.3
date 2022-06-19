Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA41550A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiFSMFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiFSMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2312120BF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso7878287pja.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwPvg9aHPNuFc5Fz4dzlHA+5Jm0CEYz0VOKD2Y6fcIk=;
        b=gG1xeqrfUWtALKZNlOXhvHblX9AqAO3/3KrIqLuCZ4S7A8KjVy/hRUrQ49pF6IlDtR
         ECBfWO+DrzAhUP+HsKzlyzJlqulJ4Y/afNXTVVHocjQtmXFFnJvSkz3VWsezZQSglup/
         D2NBkoBOK/C66d6u1rjXEJ29BOh6sybMdgC5yvV9kG4BK5We2b5FkxqlvKI3/dk41cE3
         Cz3fO7iVxvV5n6+WgZN2sGBiBdZfC+HM7kFLX4aGf0NAsle9/1bmxMMqKDyg3kdDxr67
         OUaTDbKrI9AGrV8eQU4OtYSqKeJrqjSV9UkkBFSuhNqXLYABpkZC3v9TWzSoq4crTt5B
         wq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwPvg9aHPNuFc5Fz4dzlHA+5Jm0CEYz0VOKD2Y6fcIk=;
        b=aPmEl26W0BM4SifZhkmCwMOyXPPLLnknAAm+yUouI8vZFnVis0urnlHbBjqh2G5JSd
         GV7w4PvaS4DTpRIFZPJbHGPd9Zjdjel7pSEsSQlwZP+f9zQjPq/Xjl7DszW24+V75zMY
         eJL6AVCavHWBHRpYFje6TepNUJZyqXrQU8KLCZL2+xmBQ4qKWZ6OEMqr52G2LvXf0RVz
         LtydVwTMvG+SLh2an8Z11vDHPE+bJBZ7pzPJOnh/UtVNqSdKmZMWox11M6P+g2G62lWJ
         OVKV8R3qWWYW+C6CvJPZxozfX1T7CN/1ptErZ+V6nwgtVk40zXUpxDrK2B+LkfaoaKDb
         zj8A==
X-Gm-Message-State: AJIora/4F53IkQNNKcNqEuhr2raLb0boYGLVkK0LLUsH1tPKYbc/t9O/
        r6QQegW73H2hM2vNxnaWze6omA==
X-Google-Smtp-Source: AGRyM1vlo5U9ht1sU+xpVGO7BV0FGLKN8sYisISYQudIrQ5CJw6LLSyO2/2hXK0054Y4j3rw+iyvgA==
X-Received: by 2002:a17:902:9f97:b0:16a:9b9:fb63 with SMTP id g23-20020a1709029f9700b0016a09b9fb63mr10600516plq.7.1655640335257;
        Sun, 19 Jun 2022 05:05:35 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:35 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 4/7] sched/fair: remove useless check in select_idle_core
Date:   Sun, 19 Jun 2022 20:04:48 +0800
Message-Id: <20220619120451.95251-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function only gets called when sds->has_idle_cores is true which can
be possible only when sched_smt_present is enabled.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aba1dad19574..1cc86e76e38e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6256,9 +6256,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	bool idle = true;
 	int cpu;
 
-	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(core, p);
-
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
-- 
2.31.1

