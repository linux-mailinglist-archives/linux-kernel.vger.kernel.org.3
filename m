Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3435A983F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiIANNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiIANM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5624F3D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:11:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso5755274pjv.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bU6YnT1Irux43rCckY/H05qvHpPtKNrJfyRkmbVSwCs=;
        b=D6K3yNO7nSYxsNrdfR70WXaTGkTv5c3Fr9L50BVNSw8RBCsA9hJ8FSnFvcx2F8BpVN
         UW01szIQTk/b/pc4G/B7OxL1YH3RP7GR05/RTY1gJODE9T74wLoWUMVjSUYy6neHMwPa
         8/3TqjTwT8Ba+tTg/7fK3Fi8cGRDxDHjOjbJ/Q8OOAfjHXNygwDrB+kABEwbTphl0m93
         +cbiKAvEl5A/Jn0pczZnZcZAVrtIlIMjbePG5LW0ej3o9r1QaNXAR5vO0B7i3vUv4mES
         tttZan5r4bOeFBEDJ+LzOkyhJqZv2ANrgHwtUidbUmZ3bl3sNbKJB9opoXwqo5cb/kCQ
         nQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bU6YnT1Irux43rCckY/H05qvHpPtKNrJfyRkmbVSwCs=;
        b=AySMzGU3WNf7uC5XrM+giZqTOzlHdBB/3SEnvl+lWFZdGQO0pIwtiYUGA2Udd700PN
         uYVinrChdDw+mhWR83xHD4BQ09P7Fg2rGd2xEJycwHRE9LIQe3a6jPT5OGyw6hEtmOui
         D2nCepjQfxzOsIdsF3P/++Pxf0I5RCDt0tKzrfX2KLjx1ERFv4PG4/uttUjQCQWnE78t
         x95mB6w/DVL/ZmUp+ko2972AEeIE1i9ddZ3Hiz+LF+g29LsNpnvkhh89dvyyi3HbVghH
         4+x1G5wcgQYSdOuXa/4XUQJSuCUH2wR+GRQOrRUzdgwGAtYQUwRTnZiIqRKfv2o9Byvv
         Ul/g==
X-Gm-Message-State: ACgBeo1QVftHmlkbiZkNEfzPtXtFSeEBklnhQ4/ujexAKU8RHOn1SHea
        5TWsCha4EV/HB0QGb45h5r2xUw==
X-Google-Smtp-Source: AA6agR7ZfGZ38pVUkFxHjEOnG1NhNbeYQ/Gr0CkiSqNBeV8RU5M2xa02wDufgaMuOZLLYYdDUcJajg==
X-Received: by 2002:a17:90b:293:b0:1fd:7caa:e324 with SMTP id az19-20020a17090b029300b001fd7caae324mr8782978pjb.11.1662037898777;
        Thu, 01 Sep 2022 06:11:38 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00175111a277dsm6221156plg.185.2022.09.01.06.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:11:38 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 3/5] sched/fair: remove useless check in select_idle_core
Date:   Thu,  1 Sep 2022 21:11:05 +0800
Message-Id: <20220901131107.71785-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901131107.71785-1-wuyun.abel@bytedance.com>
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
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

