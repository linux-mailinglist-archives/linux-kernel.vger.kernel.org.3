Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9358C8D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiHHM6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiHHM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081F64F2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m2so8484769pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKH6Lv1MrMSHH7UvSIShA9HZuky/1Wje6IcDDxkLSRU=;
        b=Bnlh/dVLIe/Yd0Csyb8iZjk5z9ug+FWg4a2yNyR+OMg9TKdYwfm4nL3rrViz65ARvf
         8xMoNQZWnOtd/5IvC1ZducBC6jltnlzUAes0JIqhgzvlwnGtGi9JSIbP7djTmVVXPMoS
         PPAspj3u597/xSPYkf+DxvoiV2Z8NEU8RFa/C5Q2dgyEnzuojlrlO11WjruqD/8S1PoQ
         LeyDId3gK38OBe8/RbFlpQbiNeVRos7V2/5r9d0TmjZ6jiwYpmbme3q0dDMtyhnw9DZW
         5FmyBI2KYhrJaopRm05cqv9t0pJTm+gpww8es4YvbUVdnMaxqIjmGuRq4OWm9PwRPR/o
         wglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKH6Lv1MrMSHH7UvSIShA9HZuky/1Wje6IcDDxkLSRU=;
        b=8K93xgEn95TYNcygneGCd/uQxs3Q5f59JKrm0eBzuf1XRNxS+FBBx7CMtVM6j4bqwJ
         UBpCbXBHEd1QujVlZZJKEU0hJlNsHKekre/g5PiAgreZun8S0ubMQcPG7fjoaMefysV1
         gIN2p7zRJAwf9n5mz64CV8xpoOSajmEYAHwJyyBQiEjMt8yPbH2Gm0CXwnr5HNCMsS/7
         wyk2NisKOHisQXSfxHrlzi0wMYI4kPCHJ5e5JTljrNmW+YjHWoJg7Rr9l0ovlwq6fWYQ
         QYuMfHmKsSAPgnRS3gMKhxc2QnaojQIlytJ/CydzVQ80HIxM2Hx2sMkLDiUkd+6r4m69
         BgCQ==
X-Gm-Message-State: ACgBeo1dujnwMR45GUauWdaXwXdOeKzcHg8mI7bwjsNKO7eU/rn1+OoD
        JrPy83wipMprcxafbzwkA8hUTg==
X-Google-Smtp-Source: AA6agR5w/QIQBW9uDU/ERe4K9SrXYZK2x/qv6JKB9ve1tcNoksGgBygGVxYPcQb6ARRnlPxe2slEsA==
X-Received: by 2002:a17:902:8302:b0:16d:d74f:e5cc with SMTP id bd2-20020a170902830200b0016dd74fe5ccmr18594566plb.6.1659963493267;
        Mon, 08 Aug 2022 05:58:13 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 3/9] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Mon,  8 Aug 2022 20:57:39 +0800
Message-Id: <20220808125745.22566-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c0eb2a4e341..e4c0929a6e71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11660,12 +11660,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
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

