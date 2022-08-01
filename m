Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F691586383
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiHAE3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiHAE2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2813E25
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so10731542pjk.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKQDPUfMOqNNFX3ZLkp3YqkVikVp2AFXf+ofcvp1J5c=;
        b=xCo14mSny3rZHNsOFgGw4Mkq+T0dT7zpzcYZyORepoc5/u42hGdysangVWtHvSMnik
         kd3BQuYTvkg/oeuQdUS6ZJT3ZN8+WnucAnFlsQ18pbaG5lFh9+RIMom7TLe/O9vpFcTb
         UL5o4SfrSOYML5eNcGLPYIG2lbS6OU9IGNKbtusG6tpmv45IQNFRiaX2ctCuBSOwdoig
         pfTnOu+2eZSJ0Zyi4x9pS6F97P+H+pdKO1qVCI0P0P2Uw/6aq07Kj9tYWI0oDpgjFnU/
         qkTYhGTXuOycgLX0G0EzILNt5rMbdXDRJ8uXU/5SCvU6MhaZuKmSxJgow0rjOtQPLq04
         KFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKQDPUfMOqNNFX3ZLkp3YqkVikVp2AFXf+ofcvp1J5c=;
        b=2mj+DZp6yBJHVDbtSOrBOslOlCjGVrEc2xv2GPrsyfT0QgvwxaAKX7GLaWBSH6lqj1
         /2LStU4G9LR+mIiiZ8SULruLPmGJ/sv+/3ztmOLnV1pr2QJmCxlVsat+2JsCn3ydOmnl
         dIW9DLaY0Oyi/Gryg8aS+nNWf/pseekoJ8whbLTwD20b+KN1KPQGu+U8fgOlhdetyMIT
         8+J3JBDBc06AnKuJ4K5wmY5jsz2JCMGpaCTuXVcAscumyLaNMTRat95b9BatfIoLyTt6
         bHMUTdBc/D7LN5P4dIE2k8GwHvHOAy0q7151m1ndvPzG5pkmg7CjXeWiPyXqDEZzZ28U
         GFLg==
X-Gm-Message-State: ACgBeo2crmySdwKLRGQqgOrAsGsl3tvXL1A5n36In1gYJ7q/zMrA9r2L
        GH0tzVG4vysBE55n3THt2XF4lHwfBsKJpA==
X-Google-Smtp-Source: AA6agR4G9Fl+nArsOolHt1TIH4T/atuWoRK1GVSJgygTE68ffdHM2cygtSYrbBRVPc2Tt+/jyYsj2g==
X-Received: by 2002:a17:902:e84e:b0:16c:773:9daf with SMTP id t14-20020a170902e84e00b0016c07739dafmr14999273plg.43.1659328116230;
        Sun, 31 Jul 2022 21:28:36 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:35 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 09/10] sched/fair: defer task sched_avg attach to enqueue_entity()
Date:   Mon,  1 Aug 2022 12:27:44 +0800
Message-Id: <20220801042745.7794-10-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wake_up_new_task(), we would use post_init_entity_util_avg()
to init util_avg/runnable_avg based on cpu's util_avg at that time,
then attach task sched_avg to cfs_rq.

Since enqueue_entity() would always attach any unattached task entity,
so we can defer this work to enqueue_entity().

post_init_entity_util_avg(p)
  attach_entity_cfs_rq()  --> (1)
activate_task(rq, p)
  enqueue_task() := enqueue_task_fair()
  enqueue_entity()
    update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
      if (!se->avg.last_update_time && (flags & DO_ATTACH))
        attach_entity_load_avg()  --> (2)

This patch defer attach from (1) to (2)

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8cb826bd755..18e3dff606db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
 
-static void attach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
@@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
-
-	attach_entity_cfs_rq(se);
 }
 
 #else /* !CONFIG_SMP */
-- 
2.36.1

