Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5146CE73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbhLHHmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhLHHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:42:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:38:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so1015589plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 23:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PY7oKNxMgQYxehuDeQTBJfRVsoorUJJ0ihPRLjmLxc=;
        b=irxxbZLQdbdNtFKqDWy3gkIkS9XYgvjIrIPiUSkpiWf5yaIVZbHgub6ZSIwTTWptW2
         c8pKYeBHdC3b3aZJslCqtinfk8/XDuew8G5sbQJjdjXmxIAqA+SKcRHLbiavOnjns2+C
         AwoBDBNGOD8Pf2SvXBnkkXrsf9hg76f0Dqy0fG+pZ+Ib+Y2secTv3XLw5FwtQWTOTR3d
         d/KJj03EHVbuswG89U/Pu/qeGKuQbkwyBM8A3I9HpM5gbbQGU2Wym0uvdXE2gNp+w1pX
         I+l74a6jmR2XUV01nmHIhOJjySSsUZChdSbxRf3iDA/YeDv1J4w2J9vjEIkQa33Ods2d
         Vs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PY7oKNxMgQYxehuDeQTBJfRVsoorUJJ0ihPRLjmLxc=;
        b=uMpxoDe44LW3TG1Gp4P8X99q1v33QVo8shttcczM1T0ZnhXQ/VixI1W18PIK312Scx
         cO5UzMVY9jjAwBX70WBwftVkxR+Y1fXLMaFchCQH//ICY2WbOqiMyUmM9Mqw3IYSg/W2
         qgImXk0SlF8ZHPrj4spEjA/arO/GmDAcdDRpIAIYIeFjszPgGmaJwCF+Q8UYmABH3d0j
         PDc8L2FeqBC/o88Si96XyGMJxTVm09sLX2Bkx40QqpNFaLJWGKsxAgM1VoTVZCtFwYvw
         PH7vuX4RQcl2juqQ10nWGSklirYsaxN3tBmglZDB8QyZ4IGGl5sgckprv5kCnNCS1hT4
         F8/w==
X-Gm-Message-State: AOAM531DctoX3VPtYYYP3w5CKYbfdHyMkyCNtl3JH9NFMWuDl7ZjTz7+
        3QNJGKmByDnIud7GJIGuPwQjJw==
X-Google-Smtp-Source: ABdhPJxl084B6ehMgbFk7b4pNqCZyKlzQUn9C7Jnh9Y33uAqfLneXWBwu3cC3CYUpeYeEhYG8Vw2lQ==
X-Received: by 2002:a17:90b:1057:: with SMTP id gq23mr5137961pjb.203.1638949127358;
        Tue, 07 Dec 2021 23:38:47 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v15sm2331153pfu.195.2021.12.07.23.38.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 23:38:47 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Xuan Lu <luxuan.windniw@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
Subject: [PATCH] sched/cpuacct: fix percpu time accounting
Date:   Wed,  8 Dec 2021 15:38:36 +0800
Message-Id: <20211208073836.70619-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage percpu data is the CPU time consumed on each CPU by all tasks
in this cgroup (including tasks lower in the hierarchy). When cpuacct_charge
called from other CPUs, we should use the CPU of task, not this CPU.

e.g.
    cpuacct_charge+1
    update_curr+332
    enqueue_entity+70
    enqueue_task_fair+169
    activate_task+57
    attach_task+46
    load_balance+1512
    run_rebalance_domains+451
    __do_softirq+282
    sysvec_apic_timer_interrupt+159
    asm_sysvec_apic_timer_interrupt+18
    native_safe_halt+11
    default_idle+10
    default_enter_idle+45
    cpuidle_enter_state+130
    cpuidle_enter+47
    do_idle+489
    cpu_startup_entry+25
    start_secondary+261
    secondary_startup_64_no_verify+176

Reported-by: Xuan Lu <luxuan.windniw@bytedance.com>
Reported-by: Minye Zhu <zhuminye@bytedance.com>
Co-developed-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 893eece65bfd..aab51c88bd34 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -341,6 +341,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	struct cpuacct *ca;
 	int index = CPUACCT_STAT_SYSTEM;
 	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
+	unsigned int cpu = task_cpu(tsk);
 
 	if (regs && user_mode(regs))
 		index = CPUACCT_STAT_USER;
@@ -348,7 +349,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(ca->cpuusage->usages[index], cputime);
+		per_cpu_ptr(ca->cpuusage, cpu)->usages[index] += cputime;
 
 	rcu_read_unlock();
 }
-- 
2.11.0

