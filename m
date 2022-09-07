Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206F5B02C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIGLUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIGLUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3889822
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d12so14186320plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Stmo/b+IFMKFH7NQQb7Kt0yurZmKvJLuzBGo1PCIQOA=;
        b=mZORR5nnp1KIcje6ldMVRn1db1BpmUJJmyvhw/8+SGCmBWLlmYit2p+4VNmS9vBEB8
         epf3wm2sF8HX84dV6SE2vz61xe08SxQ2AiL0VuZl6doERpTRPn7oMWCTd2rb/rPOD7bV
         CYytTdocYXdEWk2NqpHYinqSQobGT5IiorRzDWyUgjDD2nGsmsya1wiMZEbhOfALpQ2Q
         6qz82yd4yST5HJKB9bWc2qZMMtya1P8oW7ba/2T8M7EEggy4LrfNLq9oW56C1g9mMqMx
         eZ0A5SvZd8+EHEkCuT2+lZrj0bsF3oVWC5uvB4FYxMFeNO+dymV1iCM1rDElT4rJf5r4
         j5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Stmo/b+IFMKFH7NQQb7Kt0yurZmKvJLuzBGo1PCIQOA=;
        b=zn/zi6IucK2o+PhMz83XLZx9ZfJekUdw0485RxYyAxg/VtQ+fkcEGQsJdUwOtOE9ml
         wcwjFRYBjQgUkBJbHXJDATpQWIB6XGApJgoB0L+3R4+VmDwzJd2t6MJSQEJ0ux4FrM2K
         uZOGgZUP8crkEr4hv8QFQiy3KY7xTrGsbvFnJ6kvWMh/laUr7j+qoD+08G+/me4bVix4
         0LbjPAW7wf/yR07kguBxlBM5Vvwb2WcNO6AfPzcZTzl8cEvNhR7nJrZ/yF4AZ/6EsAXf
         NOWXw8/IPOz8ydMpFwNjxHk5Z3yG+l+UR0C1u8UuB/nPeiPs5Ktt+TcnMcLmsmHCaNqU
         VRvw==
X-Gm-Message-State: ACgBeo3bmQJ8zxRuoCdRkIHppzE6fhQKQXdhtInL1HehbyMmhzItnEtS
        ZUy3Y7Pp1Jb4rzURjmQ/D27BMA==
X-Google-Smtp-Source: AA6agR6ALcPUImzbs5VWlBJNpidlt9nyHKGmW2mYKaMSecNwNgFLbKRHmLbj10tMLZZ2YhdeSnjgsA==
X-Received: by 2002:a17:902:b484:b0:170:a2d8:80f6 with SMTP id y4-20020a170902b48400b00170a2d880f6mr3233963plr.97.1662549629552;
        Wed, 07 Sep 2022 04:20:29 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:29 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 3/5] sched/fair: Remove useless check in select_idle_core()
Date:   Wed,  7 Sep 2022 19:19:58 +0800
Message-Id: <20220907112000.1854-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907112000.1854-1-wuyun.abel@bytedance.com>
References: <20220907112000.1854-1-wuyun.abel@bytedance.com>
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

The function select_idle_core() only gets called when has_idle_cores
is true which can be possible only when sched_smt_present is enabled.

This change also aligns select_idle_core() with select_idle_smt() in
the way that the caller do the check if necessary.

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
2.37.3

