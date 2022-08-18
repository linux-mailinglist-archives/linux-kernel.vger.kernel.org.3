Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED2598376
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiHRMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiHRMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038252806
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so1225343pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FRKOdv3Syw9Tzig7kJCUcxunGx7WyPi3SKqsZ5Hh+4Q=;
        b=3QQSntIC7QS74trk48+Z5+EJcgiPmnFJ4yQTTKn+tRkqZx4VfB275BkwGiXzjFxTjq
         Qwws4icn81Pq3SPWTzMO98McyHf/pcWzufvbrE9dXfv6hgYbeZi9+1oAnTx9eQjFQHGy
         sq6E8hY41EesaIy0+5KtTmpbshjLm6PffMRRnRYJLbvCs/KmzOPJwQRbFFvqiOqUf8sf
         2eN3rsVyTfim3eee+9rDUNEf2T1IGRGDjp1+mfI00nAhTPedMilxiYwSPpoSXEtFcBTy
         4N1OT3R/Z8buviMDzm6OU5QtGR8AxOnHPnytPYr9C17EWQQpWWC3NY0gEHfiZrxEdNpY
         ZSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FRKOdv3Syw9Tzig7kJCUcxunGx7WyPi3SKqsZ5Hh+4Q=;
        b=hbO3nDHlxsPC/Fcb3fnNg1DHBTZerNCef+98IVcP5Ilhae2DDqqEojK2qFlKa5A2pu
         pxi/I0ou/6GJlK1plhUKcagOiKsAnCL6I5DoF6faaYcOfel1tivk6lB/PC5gSTnRySJX
         ja/8G2Hla5ic2nXXZYizSiWsItpLimZeD6+PkNBD2onlbWIKqcv9tv0Q6rCmIxUv+RVo
         iR8BJpMWbKyE8/nglxW4kKgcUPnblmMeLLlXqDb6et/RT0WUS8eNsu3QXPDv/pSuff+4
         I6OBFULdZ9mR67DGaac5mEl/VJ4GzXkdTNSjJ+JKCKGiVhBM3Rnwj6U+KLgrh4+SvRU4
         9T1Q==
X-Gm-Message-State: ACgBeo2peBxTqJHzoFHUXJz1yZmmNG+vZzsYaBauw6i/GGfYs7M6yo2j
        /mc5Ml1YO1I6Iuxn2qf/SDsARA==
X-Google-Smtp-Source: AA6agR7L1OtILqPPpJIOMY4RUNL7kAek4rQ9cOsdgZKysLyzpHLZZnnBTvP9RczKpBNzOCdcTb59DA==
X-Received: by 2002:a05:6a00:1a04:b0:52a:d4dc:5653 with SMTP id g4-20020a056a001a0400b0052ad4dc5653mr2838454pfv.69.1660826924201;
        Thu, 18 Aug 2022 05:48:44 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 6/9] sched/fair: fix another detach on unattached task corner case
Date:   Thu, 18 Aug 2022 20:48:02 +0800
Message-Id: <20220818124805.601-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
fixed two load tracking problems for new task, including detach on
unattached new task problem.

There still left another detach on unattached task problem for the task
which has been woken up by try_to_wake_up() and waiting for actually
being woken up by sched_ttwu_pending().

try_to_wake_up(p)
  cpu = select_task_rq(p)
  if (task_cpu(p) != cpu)
    set_task_cpu(p, cpu)
      migrate_task_rq_fair()
        remove_entity_load_avg()       --> unattached
        se->avg.last_update_time = 0;
      __set_task_cpu()
  ttwu_queue(p, cpu)
    ttwu_queue_wakelist()
      __ttwu_queue_wakelist()

task_change_group_fair()
  detach_task_cfs_rq()
    detach_entity_cfs_rq()
      detach_entity_load_avg()   --> detach on unattached task
  set_task_rq()
  attach_task_cfs_rq()
    attach_entity_cfs_rq()
      attach_entity_load_avg()

The reason of this problem is similar, we should check in detach_entity_cfs_rq()
that se->avg.last_update_time != 0, before do detach_entity_load_avg().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1eb3fb3d95c3..eba8a64f905a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11721,6 +11721,17 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+#ifdef CONFIG_SMP
+	/*
+	 * In case the task sched_avg hasn't been attached:
+	 * - A forked task which hasn't been woken up by wake_up_new_task().
+	 * - A task which has been woken up by try_to_wake_up() but is
+	 *   waiting for actually being woken up by sched_ttwu_pending().
+	 */
+	if (!se->avg.last_update_time)
+		return;
+#endif
+
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
 	detach_entity_load_avg(cfs_rq, se);
-- 
2.37.2

