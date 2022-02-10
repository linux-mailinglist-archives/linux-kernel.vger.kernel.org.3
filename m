Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B5C4B1579
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiBJSoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbiBJSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:44:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E2F47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:44:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p24so17542679ejo.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1ckcBw6FCyxQ+HYlSX3q9jndl/QYggwGtWTc2feWOh8=;
        b=NYdO6NoI00ptXaz0YYNrl8gxLEOR2Fiz6qJ+zjIi+e3FOuRLDUDqLINP3Z3zHs+AYp
         lVlwvCDDqHBOhCIH6wuO/q1rtPxEmaVlpCbssOZv9tOZ8wYj6mTGNAl21rHN67WrNxYP
         PLootRk/mLFfZj0IRQe/Yg/0RaIiTmvPQGa/sLVLtmB+YZDnUTZtYZlOfaSF98RvICEJ
         XkYNMBo9g7FroJ1bK2fITmwO3ZCriBbOn3FP1CeWwC59gI5UXIX4lJ4pci8vjog+0HIL
         pRdsWqIx8sRHrgEhXzy7XUawFn8OY7g2jwhz6Qhs72dR/Aoe5NqvYrN95KINGb6ILXJS
         +4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ckcBw6FCyxQ+HYlSX3q9jndl/QYggwGtWTc2feWOh8=;
        b=Ace0p93eCNuDjvTXswb6eJ3XWIHgkyMHPNg+8KKokYTEMyxxsFhTLEwbglKxyZwBta
         j1Lc9AURkvV94hSpZpbBEHrDkJldISpLmAVw1I8GOl1jqPsfWfgOxN0T0d4BVKd6Ouqx
         r5ee2VGVC5RFLrnxV7IPUG2y8pfwWgifWE3dw2d/88PMCNQzMf1k6qdYKLjg07m1Gdw0
         izeKbf+QzZCF7KUqCIYiUKDX1VDMObHcJY9hcVSSslNKCwmF27pag4IZVv6R5c5PW22+
         2jcEWn2Yas5TUAmfBAIHalanUG2DwFfJNrI7oxT5geJF0uH9qFBp2pZI6/mJ4rJWaLzl
         E+4Q==
X-Gm-Message-State: AOAM531jqiGsYR0jLP3jjoyi64JNrvlMXvKW+pfeHQHcOJQ6eGNJf69G
        TMiubVisccX61ADhzhWSTNw19P+FSQTCOSc6xhc=
X-Google-Smtp-Source: ABdhPJwYXcVF+nU6St3sHud59Pt0LOLMzsQ6IjybEkkcxNoGvnRGRTIA5azts1MwkvMVT+sdhKm23A==
X-Received: by 2002:a17:906:faec:: with SMTP id lu44mr7285458ejb.216.1644518663667;
        Thu, 10 Feb 2022 10:44:23 -0800 (PST)
Received: from localhost.localdomain ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id h16sm7326182ejj.56.2022.02.10.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:44:23 -0800 (PST)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, treasure4paddy@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] workqueue: Fix race in schedule and flush work
Date:   Thu, 10 Feb 2022 19:43:18 +0100
Message-Id: <20220210184319.25009-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting secondary cpus, online cpus mask is transient and can end up
in below calltrace. Using same cpumask for both schedule and flush of
work resolves the issue.

[    0.377823] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.379040] ------------[ cut here ]------------
[    0.383662] WARNING: CPU: 0 PID: 10 at kernel/workqueue.c:3084 __flush_work+0x12c/0x138
[    0.384850] Modules linked in:
[    0.385403] CPU: 0 PID: 10 Comm: rcu_tasks_rude_ Not tainted 5.17.0-rc3-v8+ #13
[    0.386473] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[    0.387289] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.388308] pc : __flush_work+0x12c/0x138
[    0.388970] lr : __flush_work+0x80/0x138
[    0.389620] sp : ffffffc00aaf3c60
[    0.390139] x29: ffffffc00aaf3d20 x28: ffffffc009c16af0 x27: ffffff80f761df48
[    0.391316] x26: 0000000000000004 x25: 0000000000000003 x24: 0000000000000100
[    0.392493] x23: ffffffffffffffff x22: ffffffc009c16b10 x21: ffffffc009c16b28
[    0.393668] x20: ffffffc009e53861 x19: ffffff80f77fbf40 x18: 00000000d744fcc9
[    0.394842] x17: 000000000000000b x16: 00000000000001c2 x15: ffffffc009e57550
[    0.396016] x14: 0000000000000000 x13: ffffffffffffffff x12: 0000000100000000
[    0.397190] x11: 0000000000000462 x10: ffffff8040258008 x9 : 0000000100000000
[    0.398364] x8 : 0000000000000000 x7 : ffffffc0093c8bf4 x6 : 0000000000000000
[    0.399538] x5 : 0000000000000000 x4 : ffffffc00a976e40 x3 : ffffffc00810444c
[    0.400711] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
[    0.401886] Call trace:
[    0.402309]  __flush_work+0x12c/0x138
[    0.402941]  schedule_on_each_cpu+0x228/0x278
[    0.403693]  rcu_tasks_rude_wait_gp+0x130/0x144
[    0.404502]  rcu_tasks_kthread+0x220/0x254
[    0.405264]  kthread+0x174/0x1ac
[    0.405837]  ret_from_fork+0x10/0x20
[    0.406456] irq event stamp: 102
[    0.406966] hardirqs last  enabled at (101): [<ffffffc0093c8468>] _raw_spin_unlock_irq+0x78/0xb4
[    0.408304] hardirqs last disabled at (102): [<ffffffc0093b8270>] el1_dbg+0x24/0x5c
[    0.409410] softirqs last  enabled at (54): [<ffffffc0081b80c8>] local_bh_enable+0xc/0x2c
[    0.410645] softirqs last disabled at (50): [<ffffffc0081b809c>] local_bh_disable+0xc/0x2c
[    0.411890] ---[ end trace 0000000000000000 ]---
[    0.413000] smp: Brought up 1 node, 4 CPUs
[    0.413762] SMP: Total of 4 processors activated.

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
 kernel/workqueue.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..a3f53f859e9d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3326,28 +3326,38 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
  */
 int schedule_on_each_cpu(work_func_t func)
 {
-	int cpu;
 	struct work_struct __percpu *works;
+	cpumask_var_t sched_cpumask;
+	int cpu, ret = 0;
 
-	works = alloc_percpu(struct work_struct);
-	if (!works)
+	if (!alloc_cpumask_var(&sched_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
+	works = alloc_percpu(struct work_struct);
+	if (!works) {
+		ret = -ENOMEM;
+		goto free_cpumask;
+	}
+
 	cpus_read_lock();
 
-	for_each_online_cpu(cpu) {
+	cpumask_copy(sched_cpumask, cpu_online_mask);
+	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask) {
 		struct work_struct *work = per_cpu_ptr(works, cpu);
 
 		INIT_WORK(work, func);
 		schedule_work_on(cpu, work);
 	}
 
-	for_each_online_cpu(cpu)
+	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask)
 		flush_work(per_cpu_ptr(works, cpu));
 
 	cpus_read_unlock();
 	free_percpu(works);
-	return 0;
+
+free_cpumask:
+	free_cpumask_var(sched_cpumask);
+	return ret;
 }
 
 /**
-- 
2.17.1

