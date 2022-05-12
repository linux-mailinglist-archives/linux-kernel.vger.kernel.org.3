Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707445252B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356566AbiELQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356555AbiELQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:36:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061721262
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k2so8052195wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Gnska8b1Wfv23bF2U4XjBCNfnatEKh8FDyGDQymKDM=;
        b=rBXVL282FjWOaowoTpqpxtn0yMAEBpVZOdZzFXl7jgIiUf6QvjMbp0pKUVpJY47Hll
         iIpZjkl8geXm0/Jd7ZYYX6CbFdrWLpTXyHz5DfrW7RVsJPQusYYCTak4tVnqNEqtp/UJ
         pWWhAIoIdZaTkGkZhaOaVQ1doAInOLYYLojvJblUS9BfCOrPIw6yTockvjzynFWlnc2G
         TseRW4H66K6Wl7gjyUeFdKtuZxab/6Rm1s5bnvGb4jaruFOe8Gj7s+0iAGOrLCXD3mU7
         haU1wD9h3bwxEsLD3qzk3rXCbMDothfLKyPJDTaJyX0pffTEOzZ2obKmy9vXPTgRgd/x
         2N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Gnska8b1Wfv23bF2U4XjBCNfnatEKh8FDyGDQymKDM=;
        b=75pIGE8MPNTfs3vVLoUtFMBB1HampuJqgisTONN1FkkmD/y4nw1fvxHsm+pBlau33x
         Uu540DQi7gWsVoI8RHj5aLLCyOZ3QmURstgxYuSOgS+Xt2LYy49tYlrZXj2CP18163W9
         palkVkEB6/XE6UeitYIRK/dp3hAZg0WeIFpgSN9DphgABN3u+27l2O25huwhrrWtQcuK
         s0HnIONRWS3i1K5JgJ3G5eS1soh7uGJV5D2/3TgJ61pgAJU1dyMAqLn8Vu0s9E+dUXJj
         ewVqs+IlaSgKheQNc7uaM5RdsPICa1kUFT74z78NcNwJICI3FWXXLFp7Vmux4nIaRDhf
         ux5Q==
X-Gm-Message-State: AOAM531C8GylYxmZoswzLimjOuZ8HhM08lKU+nHRRzTITCwfgNNQ7+ke
        98p8UguBijmuTVlr6xNmauJlTA==
X-Google-Smtp-Source: ABdhPJxifD4YkQWr7J8e5gYnRXg2lLdmMTy9didZGBgQDF76kFhGlCM3vRyxBJxjvOMqDvxDo/Ekgg==
X-Received: by 2002:a5d:44cf:0:b0:20a:c5d2:b6c3 with SMTP id z15-20020a5d44cf000000b0020ac5d2b6c3mr430657wrr.177.1652373363677;
        Thu, 12 May 2022 09:36:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:36:02 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 7/7] sched/core: support latency nice with sched core
Date:   Thu, 12 May 2022 18:35:34 +0200
Message-Id: <20220512163534.2572-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 71c0762491c5..063e9a3c7e51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11193,6 +11193,10 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta += wakeup_latency_gran(sea, seb);
+
+
 	return delta > 0;
 }
 #else
-- 
2.17.1

