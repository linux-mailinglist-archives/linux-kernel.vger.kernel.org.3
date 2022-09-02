Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946495AA662
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiIBDbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiIBDa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:30:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA90AB4E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:30:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x80so905597pgx.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bU6YnT1Irux43rCckY/H05qvHpPtKNrJfyRkmbVSwCs=;
        b=h3R0jvspSPn+1MQbGOiwZ0tHVKQQCjxn7QWi+ObgwPcxfKaAphi2IhwbS4xi9w5aag
         7q5KGbh4nyHzHOZdObaSa01WF0TcUkTb9dfyTVAKSLEgMLmtZZ0VfY1fj3Ebc80BgRDr
         VGfpHjUvY4vPDg1vL1xjPoHan10RUOCw4pp6Jj7Xqk66j5Vo8e+mVpXSdIdgJboMeeGY
         iKR6yvKC28hzyi7QSKKJOldPwjmfXfQ9xgpqFkCPCSurQQrA1p4VwiplsODCDTMsHJHF
         RS6AXzyyTKXl+BfK6TZXenJRrsoIS1kFp8ATyOfAsU6/Q+pb2Ee+bV1q6X55n2D7MZ7d
         D1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bU6YnT1Irux43rCckY/H05qvHpPtKNrJfyRkmbVSwCs=;
        b=IdbKykidWLs2lkm//5YSw30HGl/BHAYRCMG9lUN/bk/dP5Uf8VJ/RAGW9Zs7POKqWK
         1Htd5B5Gk0JJENTBn6OhZmCuoFka5SCYtPvGvDWBNOFc5+ywfpKfpoZRIYBfyVaUpLs5
         Mb025uLkqtAY51NWbGrVNtpoCZlGg3kSWc/x8wmDYe21KOSCHbSqP1Pin5PFB8WSh+oH
         msi4cvvbiHjQmyQOQIJ6SoEyvd9g3N/IJi548lhalpK/gFYTkLO2Pf7dNtXbxMw4crKU
         7ZDxrGWKW6PlBMCFtwb8eDkS0oAo6nC8TEwBcNKIu3mJgioBw/TrlXIsSpQyVqSgqw5o
         GEVQ==
X-Gm-Message-State: ACgBeo0CY5MK+bU+uTA4qvsVn2fZidKp+ToDxbtB7G2pz3u34ZfBKr/W
        kCWfu+lo1kGoHCAelY8KiksFEzgZlkPuoT4h
X-Google-Smtp-Source: AA6agR7OL40MnIvkF/dXwxXs8QNqh7/8v/IqsmfSKkPQqwVfCp3AxyuXbWs4TEWSNxmNTDTHdMLt6A==
X-Received: by 2002:a63:e307:0:b0:42f:f6b2:177f with SMTP id f7-20020a63e307000000b0042ff6b2177fmr12341199pgh.370.1662089449758;
        Thu, 01 Sep 2022 20:30:49 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm325680pga.27.2022.09.01.20.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:30:49 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 3/5] sched/fair: remove useless check in select_idle_core
Date:   Fri,  2 Sep 2022 11:30:30 +0800
Message-Id: <20220902033032.79846-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902033032.79846-1-wuyun.abel@bytedance.com>
References: <20220902033032.79846-1-wuyun.abel@bytedance.com>
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
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ad79aaaaf93..03ce65068333 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6321,9 +6321,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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

