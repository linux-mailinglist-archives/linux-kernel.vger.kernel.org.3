Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5029572C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiGMEFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMEFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED9DA0D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p9so10274998pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+ZN/qkTNGGZVV+4lPGLakVKyq8BpcGfufNIFKXtAOY=;
        b=tj7ioNMzHWXt9gnDDbJRVz7gJ09wqIOJgSiU/7EzqLdp+K14oSUZ1JI5cfXnCLVdl6
         s06LvD0zWXHMhFSSWPvy7cG2Ex10djxaJvIapuFoBNEbaikYXEqnoUBC9OBbtqUkZymf
         gBXrXn9m/ypWFnndZqKZm9Ljy/6Qchd+DkeFL9ypSjnj4s07B825fU/lHwee1s6N5B+k
         IKZ2YJuSOvyU+xCQTiYbk7vLYhuR7cXu7mUyVRymBMz6oAdgAJXZdP8sUXggRmDFIvVt
         qUQEM4BPrVVDXnwlGC1esyf1LQzQZrLXTOgxXoal4BMhxKQ27jdGBObL/a6SCnEQJnrv
         KzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+ZN/qkTNGGZVV+4lPGLakVKyq8BpcGfufNIFKXtAOY=;
        b=1+4JS2Vyg5mRyr1cdUNik+ZQvRJDiQv6sDdHBCvQWX06L33tLYy9MUP1KM/TKF+aGZ
         1/LTGsbDVe3+jO79FwZP/ZrUh5ih0Kv3uW988QL/c/M2qaTjxt14yCzGn9i0/8nA+XtE
         U/F99iqmqcDqTTCzsYeSYX7DNWULfDNLYKB6LwgC6NWxWOdpr71Y6omdfVVosFFEicwo
         e47Rol3j2DAyc2LNVsxuBesDCmcGzAZV3HBUYNVVs7UsI2ILQcDKXXcJEtDU5o2u1Ppn
         1ws8Xu/jQcJ2xgEJzYCc7LY29BQQYBGMI1OAPIP/geS6+LzceVGaE9fS2K1rLryWUufN
         2dZA==
X-Gm-Message-State: AJIora+pp0oIXE+KMVfB99l203kjs0bsJikcmjXDTYcestVpchpL1czc
        Tt0lkJLF1HQzIIkBhW6xHFiVQw==
X-Google-Smtp-Source: AGRyM1uQNB1XnDhjcblgVDJgtpTlMM6dtbCRISGOpvX3Q38jH8edt4ZJ0kjs4K9OplGrwN+kuFs/hQ==
X-Received: by 2002:a17:902:e945:b0:16b:f802:1660 with SMTP id b5-20020a170902e94500b0016bf8021660mr1557501pll.7.1657685106150;
        Tue, 12 Jul 2022 21:05:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 05/10] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Wed, 13 Jul 2022 12:04:25 +0800
Message-Id: <20220713040430.25778-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
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

