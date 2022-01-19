Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D349324A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350704AbiASBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350658AbiASBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:24:43 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:24:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q25so994226pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9a1D5pmV4meg6CQGuPluc6XFagCjYKD6drtbQ058cc=;
        b=zfArFxPdbwEvo40qrJXBnsNwMXTNDZwXC2MSacfoZ4aSq6lFZOfDPxz18fpOf5Rkti
         HGGvWYmYlMtPRNG6SJ//QpqCYAI6J/Af24z4QC3+P61rKfEXS7Bawc8yLlRmHnZKHB4x
         nPuX/YNLPJnw8M4t2W2GRvbS+8ws65xigUtoxPG06gwCds0RPvBmyOVS+I8SLJcyuKmw
         edTP3xBACEoV/TIrZryl9Zkjnajd/7DCmBELv2ECPru3ilEELaoN0fmBMM03ERHHy87s
         VRVOU8nUOr5231HIsSKkOYJXGqJ0wFfpTQvvq4TOIgc8kNIFr3iqKP1h9JORnRCsZmu2
         UgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9a1D5pmV4meg6CQGuPluc6XFagCjYKD6drtbQ058cc=;
        b=X6WLQ1Z0nHrnil0+1VMz5SgoxLi7pHgjYn5xpUZqywmJnaDtmBpYTuJXrnTuxT9v9d
         2kXO2SETMa6Co/ozWqPLE3LfJWslnoKqGyCzMx2NQF5xTJ31bRYqCbmRIK2Y4+Zz6YzH
         RDiAxJaFNmKF8KEMOnfYW49wWKCAMGkYP2EklFmtm7h4DrPW/z0e2yT1oFhvVyBqp04X
         xGac38eQElrnd5PQoA34UU04G4Rl1dOoEGlCS+4PtfriMWZ6tbf68gJQ+MRAPOgEMbGG
         LESz32sNmD2PwkDw5tmht37dvIp0fuS8MakC43PlUG8sCAz5F5Ed5wnzTlKhU3lkwGkP
         PK8Q==
X-Gm-Message-State: AOAM533yPN49+AMbhJhVzmc1Ij4CZ5w/pDonVSCKizLSKdLl5j3/XxuT
        IXcykVXRM+Mpi0ThR3vTLsBr2g==
X-Google-Smtp-Source: ABdhPJzvszrBUj/mnxzS+wYrDiuF+IkE//2Tc3hRguE0N5ir5EI2ke7KCjVgQq6C3nHfdjLonSh3+w==
X-Received: by 2002:a62:1b44:0:b0:4be:3d88:ea9c with SMTP id b65-20020a621b44000000b004be3d88ea9cmr28376548pfb.56.1642555482726;
        Tue, 18 Jan 2022 17:24:42 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ip2sm3820487pjb.11.2022.01.18.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:24:42 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     mingo@redhat.com
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix fault in reweight_entity
Date:   Tue, 18 Jan 2022 17:24:17 -0800
Message-Id: <20220119012417.299060-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot found a GPF in reweight_entity. This has been bisected to commit
c85c6fadbef0 ("kernel/sched: Fix sched_fork() access an invalid sched_task_group")
Looks like after this change there is a time window, when
task_struct->se.cfs_rq can be NULL. This can be exploited to trigger
null-ptr-deref by calling setpriority on that task.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Zhang Qiao <zhangqiao22@huawei.com>
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Link: https://syzkaller.appspot.com/bug?id=9d9c27adc674e3a7932b22b61c79a02da82cbdc1
Fixes: c85c6fadbef0 ("kernel/sched: Fix sched_fork() access an invalid sched_task_group")
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..196f8cee3f9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3042,6 +3042,9 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
+	if (!cfs_rq)
+		return;
+
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
-- 
2.34.1

