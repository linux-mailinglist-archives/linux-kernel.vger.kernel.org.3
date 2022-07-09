Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAF56CA49
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGIPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGIPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E194AD7F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e16so1365091pfm.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+ZN/qkTNGGZVV+4lPGLakVKyq8BpcGfufNIFKXtAOY=;
        b=4CXgkBbJLsquBCq5ikx+eUuNqAtdxi+lH5ZNgpO9Pz880iESyqQ+RcG3B0/wL7kyJG
         v2sA6QUUkpbxl/6G0DgZN/DDMavceSzpdNGcufzEtFzwYRN4OI7J7uBU+po5soNn72Ie
         gLZ/4AVadgb3DggIo1i+GdjEnfcRM2pFJTVrhsWWhusbo2o6OuPNxy1skX3chcNh4Fvq
         YeQz2iHq/86B+5KRqyoLIb231jdNs+WPxBX4++REDY3+xap7emaaw5FtXHuZPaywv7gq
         SsZiI/faqTxIqco3C8FPzYGp7mqEiWIvUqhagzsoE9az8Dnw+L3KN+R+ejLeExvrjwp/
         /bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+ZN/qkTNGGZVV+4lPGLakVKyq8BpcGfufNIFKXtAOY=;
        b=PcBY8iPoWNcOnF2Ary149SYh02psvJjvphEgvbiIJf5jtJcbq4bHXXO/DQk1HW4Drf
         MQGaK9ejYdFPH6RrJrngnME1lfYYf/vsAcWw85EB98IcCmS5IbdJSDgRRMCAlw1E6BwS
         hKRZ+SJJXjjRlIOrcGgzqyqAU+341PS12ueO6ZVYnrpjeVuMO4l6zsDvB+gjzdIqO5Wi
         2AY8GShMA9YDykjP9aoOSOaBwDAIFRHcy6ctU/dvxU9jmJ2bPhd4edj1O/Q398e4+uER
         II95y9YBP3FPdNv6h5Mabldv9U/+t4bgR2Kurhk9hEz4DkzG7fWRh+8F+Xtg4v2MqHqW
         PRkQ==
X-Gm-Message-State: AJIora+rwniHfo2/X9sov7JdG7fn/AJfvtLKRC8RS/3v7J1mg153wokt
        yMsFax+2phXqWYg5+IlQMpidYQ==
X-Google-Smtp-Source: AGRyM1uyuQLWfGJG0Ls8rXFlRIiNe62a7AoTk5w+Yo/Ep+eghW7FSaAeE858VTM62vaDzOuaCO5dmQ==
X-Received: by 2002:a05:6a00:23c1:b0:525:4886:4083 with SMTP id g1-20020a056a0023c100b0052548864083mr9734511pfc.10.1657379736682;
        Sat, 09 Jul 2022 08:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:36 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 4/8] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Sat,  9 Jul 2022 23:13:49 +0800
Message-Id: <20220709151353.32883-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709151353.32883-1-zhouchengming@bytedance.com>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
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

set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
task's sched_avg when migrate, which is not needed for already detached
task.

task_change_group_fair() will detached the task sched_avg from prev cfs_rq
first, so reset sched_avg last_update_time before set_task_rq() to avoid that.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8992ce5e73d2..171bc22bc142 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11637,12 +11637,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 static void task_change_group_fair(struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
-	set_task_rq(p, task_cpu(p));
 
 #ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
 	p->se.avg.last_update_time = 0;
 #endif
+	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
 }
 
-- 
2.36.1

