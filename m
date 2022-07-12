Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA64571468
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiGLIWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGLIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:22:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27899A2E55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o18so6911627pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lB01uOqkHsSTj1k0Qc0PPFlLmv1AdfQPVQEj5smHQY=;
        b=aUeQeiOM9gP+inZESDjpYXky41b/FYuMawY7u01ip7ODzNTdV/t/vaE7YQ+se4eEWj
         EDmjLVcymmkJyeBpBJXNliBohJnftQO8AVgwK89XlIIke+liNhlV2KwMQHPN6RLBO4tI
         vq0IRzUE8p1dEMY9Ikok5YFnl6acVkb8v3B2/+4DVSMWeaeTu34VvClXfmv6rvtyuBA6
         9zoHjSoydFBvkGiyXvkCNQEzYFzmpjCKgf3E0sDrD5gIIjfRAUSQRAAZyPrdxu5Ca6We
         7i6fSNvEkdrOWjkcwtx9MDv55Oe0oxgktnn1Z382Uvoanm809EfiwlGzwFp6JpZ9UTWe
         81sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lB01uOqkHsSTj1k0Qc0PPFlLmv1AdfQPVQEj5smHQY=;
        b=NbcVO4Yqw60T5Da1ZqGyMF6ovJ3IPKjrdD9KJ/59xDpIdjOjX1hbQMJLqAGRbd40z2
         r0J76DC83SaAClgJ7uk1H06nypG0HccQsisFKAeFtZkY3m/I6kG+Q1qWf/HLzSYXvQfT
         KGnkQkaNtgRNr+NbK5epOxNuiUjcGgoIsZEJkJ5DU5fi4uF4/yK05Uat7GFA8g/KOVtJ
         SZhaSlP74SQEx5bJf7VN4oCXcFvZVnrumC4jaNGhYOJd8zLclo67ycWcPrMPj2JpuvGl
         AHdniz/hSdIw3Oti8PnGdktHsXolKoeVdcruSZYPvc4ZVhofBezsfUNOQnwNSXzeM0GW
         pj9g==
X-Gm-Message-State: AJIora/rbKDRshscY/0LmTMvp5SICoSZLLh+QIcnojcn6UO0pmb4puGG
        03gNMH+bBMFHDeuz+RtUoH5xYw==
X-Google-Smtp-Source: AGRyM1t/WDstJHyps+iSwM/OfNzCW8PKhA0zB1hnOIPeTR4rr5aLKL2XKMcXm8IRzxqQCjM9L2Cm5w==
X-Received: by 2002:a05:6a00:993:b0:52a:dd93:f02d with SMTP id u19-20020a056a00099300b0052add93f02dmr5122263pfg.12.1657614091466;
        Tue, 12 Jul 2022 01:21:31 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:31 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 5/5] sched/fair: remove useless check in select_idle_core
Date:   Tue, 12 Jul 2022 16:20:36 +0800
Message-Id: <20220712082036.5130-6-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712082036.5130-1-wuyun.abel@bytedance.com>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
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

The function only gets called when sds->has_idle_cores is true
which can be possible only when sched_smt_present is enabled.
This change also aligns select_idle_core with select_idle_smt
that the caller do the check if necessary.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4cf000604fc..7c47621ccd40 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6310,9 +6310,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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

