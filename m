Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1F4BCC3D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiBTFQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiBTFPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:15:44 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81F44775
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q1so1756603plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDzj7KZknHyouw/r6qE4vjgFR7kon3SsiF5AQBFK5Gw=;
        b=EFzLVl5Ix1bXx0C5RFyXdcz9Swcll0Zadz/75SV0gqKiGcE5XUTNNXtq9oNbfhzZ23
         1K5JYnaeWCSXUdH/8TZ3CCpsNQ2PukgmrZTfFSJ/6gTFSOzJyvkNeyT6anVqCEgYtnCx
         gJ4w8E5uGRgKMfSMeXX0RUk+1EzKnVMDlMyg24QnXxGZsY4zwgn+Tcqy+j4mD060gnWy
         4SkUXrCkCE8+4wy8JPqxdv65pskmaYXPtS8mi6ITuyMu6rqM9adwq2UYIVlIEL6NcL6x
         A+ozfsSVlnXlYDV9sBw+XHL8BRMs1veUccFYwQung4Ps7Dt0NB4Rk3SAwx3OeJL5Cdk6
         cxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDzj7KZknHyouw/r6qE4vjgFR7kon3SsiF5AQBFK5Gw=;
        b=eHagkyc64BMqB9ADpRmlsWD4lFnVRNFa2L1WZStTQuG1wJjlE1brZ/AAGoJp83KNsG
         C4qYlPo0msPf6XB+ofhQk96yp3QKxz2Hl5OP/xYPSS54EHt6YR9tX70BkzTrsdj8ARRy
         KdGFJRgnt856khvNqUuQXgFierrqFqqmsqQq2MyFzHRUxPSsV7CutJNMClZ2LdZwyLGq
         XtLuxPN/TaXOyc3b7h/g+Cbywn8PRDjg5Q9XiAQY2qvsXwP1/bN6PQJHRDKkDLfGnLqq
         j574R813+5cutKBcDUYtLUiorb6/GMs/lYYYZPGtPKrET6RFNXgXU095NwDAZHTjJCti
         Osyg==
X-Gm-Message-State: AOAM531M9KdGGRo4eEobc2KQTcUoEn5v1xwp1G2GW6hLcIThC9TiZeRU
        XHlFHfF11HtAZQ/Q29IzelkF8g==
X-Google-Smtp-Source: ABdhPJzStZ5RaSbbvogMa/4zlhfjcCdnWmX8k5xjzbsDd67FoFMiQSOOChplCLzarh1NSzmb99VwTA==
X-Received: by 2002:a17:90b:4d11:b0:1b8:b502:d190 with SMTP id mw17-20020a17090b4d1100b001b8b502d190mr19911800pjb.27.1645334123411;
        Sat, 19 Feb 2022 21:15:23 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e61:5860:2995:483c:273c:28ec])
        by smtp.gmail.com with ESMTPSA id y23sm7737907pfa.67.2022.02.19.21.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:15:22 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>
Subject: [PATCH v3 1/3] sched/cpuacct: fix charge percpu cpuusage
Date:   Sun, 20 Feb 2022 13:14:24 +0800
Message-Id: <20220220051426.5274-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuacct_account_field() is always called by the current task
itself, so it's ok to use __this_cpu_add() to charge the tick time.

But cpuacct_charge() maybe called by update_curr() in load_balance()
on a random CPU, different from the CPU on which the task is running.
So __this_cpu_add() will charge that cputime to a random incorrect CPU.

Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
Reported-by: Minye Zhu <zhuminye@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3d06c5e4220d..307800586ac8 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -334,12 +334,13 @@ static struct cftype files[] = {
  */
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
+	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(*ca->cpuusage, cputime);
+		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
 
 	rcu_read_unlock();
 }
-- 
2.20.1

