Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E05645CF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGCIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGCIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:32:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF35F52
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:32:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n12so6411699pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMpPdgT3m3hcJZsMbJrt95Zf/ktxKJuN2o5LG2MRoOc=;
        b=fGFeMM20Zhqd+QNAIcTYCYD2dWK+QWlaiNTPIHXTC68UE/GRVjH3NdA8b9rjf8+TcP
         SVOtE3gKYtt7GsBthEsk7RmHQLMSAIRlzR9xLAjNYZYXrpXbwEmIKg7ZUxAYtVNdXkTx
         F0V4QswyEErJ6IcIz8EU6hgJ7qe+qPk1Xocw1m9F/V7PG0s+cgIVr/6XCNX4+KxZOaKL
         wZrZ59PPym+35T3bE9e+v9xxldkknwZSYck9YdITZLE8iPQP7UfMJNywidXp89pNvTDY
         2uW1FNvILb7oafitPDUa355CyeMso0B7ClOfu02edfyUY4NZeZGpPdFgxYutzrw5fNSe
         1nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMpPdgT3m3hcJZsMbJrt95Zf/ktxKJuN2o5LG2MRoOc=;
        b=nsD819Pxiiv2gtKfQb6p9mbqUqehHSLmNDEwGfP5UbFjlB1tkDIpUCrGGlqjf7CjUa
         y6SNwWbccMj5lkaTSqwBlc9Mpsg/vmwjzASeIXPVPcERvkBIZIlvlN1RNfm3Y0LONWDJ
         GdU04uvrt/AnRpCJmytv14cr1LQa2nQyKel9gKKkQfjQWe+aL+SXyTJG8Kn6vXyRSTS0
         AV7OjuDS4syiR4z8OffaDYh3JWVO7s0mIEB8U1Jm51pvn4FHI5atN5BvWc3WoryP1Ap+
         el9zOREQe3mA4FJW+8WMjup2KQrs/UY5nr6jPRhUzXGcq/MRD6UflILra5L1+CM7LnnQ
         Quyg==
X-Gm-Message-State: AJIora+3faGn0EmOf5oVo13/cMnDxkDMdrNV6YSIUvjX07aJIKBoSm4l
        fgHmynKibCUd9jkeezvt4VA=
X-Google-Smtp-Source: AGRyM1uIEeT6gzJZsmXUWUjIJwe7wdYrf3YloOPdqX//NZyLbnJE5hV44kCWDBFpSYhpcE1sJkG1TA==
X-Received: by 2002:a05:6a00:c:b0:525:55cb:83cd with SMTP id h12-20020a056a00000c00b0052555cb83cdmr30009804pfk.20.1656837126122;
        Sun, 03 Jul 2022 01:32:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:e180:8860:f76d:3964:f5ce:a23:a451])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027d8900b0016397da033csm18496022plm.62.2022.07.03.01.31.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 Jul 2022 01:32:05 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, 1030steven@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: fix outdated file path for entry_64.S
Date:   Sun,  3 Jul 2022 16:31:41 +0800
Message-Id: <20220703083141.34946-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file "entry_64.S" has been moved into the directory "entry".
This patch will fix the file path mentioned in core.c

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9..96a442b32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6305,7 +6305,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
  *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *      paths. For example, see arch/x86/entry/entry_64.S.
  *
  *      To drive preemption between tasks, the scheduler sets the flag in timer
  *      interrupt handler scheduler_tick().
-- 
2.35.1

