Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D34B3B39
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiBMMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiBMMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:01:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA195B8BF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:01:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id l19so18637937pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BY+eqDY7Gm6uLwRYPFjvZ4Cqy/jojZcPso7meEn/08=;
        b=TznwSDRNzmeCTJ104miSU3X/kmPsq8ZfoaqydB4mRuo5lg/Aws7eONVvqtltRdaw51
         l6geyWA0PnIKShxr3ajtzN0WpF8WuiokgG2Vmj2UgbTbDkx3Mp7R4iZX4JipMNfLyI+M
         oQuQ355VWq+CTp+O9cIJBtt30UoFeY47y7/7njcSKdHe4SaiGJbHQXZ2PFHBMmUiGaA4
         JDWi2zecgg71eFkdEUUInhOs7i3jUvehM+VAuNbA6QvF6S2YyVVzXeODCtHM69F/r0Hd
         Oz1K4EkqnJjUFrMV9TByZ8g/y691NAh+gp3/QTzo90whDKGEPYX5FYIIDWlT7Xl1D6aE
         abcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BY+eqDY7Gm6uLwRYPFjvZ4Cqy/jojZcPso7meEn/08=;
        b=fEL7ehPMncM+RtRF/nv4Y+XTerU2AOAuHr7AxgbU8Pl0MKS3yt8rzhcpgiXZzHdgSb
         WmiMQr9NKG2X0Zq4S8XWrvbwDyZS/BxcZvPsGn0e4DaIFR1KYaJxHfcBiboIb4gVNHoZ
         6H/xDOmDE/5j0ziEvyTXRADk2ujYC45CXEl+YHB6cMlIdQNz0Exvd2cEJze5i43VcUmx
         WhmyiqfTJrDGyRK4Jpxqq5OM396deVL/ZCCIc91j8xfptEfbBqiHXoPh8pFkr8q4f1FG
         z0nj60bTkfFgUpIX4Lr9BVZHalaFGsf06GRqMHUfaZsdqCn5bkYskGmoMmCr3G+EHhNN
         rV3Q==
X-Gm-Message-State: AOAM530pmymvEKZdSySrznujKO90G1ntUFgJwBUpguXTHPnMqscoN+po
        5+ja3dM8Um41MDQIK+QNEZ+MsA==
X-Google-Smtp-Source: ABdhPJwxLQf4l3CNqY3sAot07p3fPJAlTH7opCljZoOtVN1VlJZoia4axTMN08G8CIU8hNX87+DzdA==
X-Received: by 2002:a05:6a00:170d:: with SMTP id h13mr9769295pfc.39.1644753689350;
        Sun, 13 Feb 2022 04:01:29 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e62:a940:a829:bd2c:4db4:c6fa])
        by smtp.gmail.com with ESMTPSA id j4sm33474965pfc.217.2022.02.13.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 04:01:29 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, arbn@yandex-team.com, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>
Subject: [PATCH] sched/cpuacct: fix charge percpu cpuusage
Date:   Sun, 13 Feb 2022 20:01:18 +0800
Message-Id: <20220213120118.93471-1-zhouchengming@bytedance.com>
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

Reported-by: Minye Zhu <zhuminye@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3d06c5e4220d..75fbc212cb71 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -335,11 +335,12 @@ static struct cftype files[] = {
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
+	unsigned int cpu = task_cpu(tsk);
 
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(*ca->cpuusage, cputime);
+		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
 
 	rcu_read_unlock();
 }
-- 
2.20.1

