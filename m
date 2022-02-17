Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19D4BA453
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbiBQP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:26:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiBQP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:26:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4CD2B1033;
        Thu, 17 Feb 2022 07:25:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q17so10327403edd.4;
        Thu, 17 Feb 2022 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bSgOxeSJt8cnP/CvpA9EZuXcjXeTNEZw5hWUR2FJOtw=;
        b=knv+NhjnXGyBJIi09/apBOogAjT2DKC0QydwlHLDILQomKWlu94vMKxxbb4AMcvCA3
         t6IXryVR67bURYkM+ftwM//3YFuYG34J70iuB6oVRF0nqFpyhqcr0cLBSWW/uCAG3lOH
         raVlS1+7ZAdOC8M6kZVvbHk454OUnX8dxBSX7kxRJ5OBJVxGlUGw2zXiHEvEmMLvp8+c
         SlBYcEkXC751fDkwgp7a69dsPc+Gu5JCbHb3nx8BHJ6/xkZqhaKQf9GjJfIUr/f/Xg84
         Y9d/YSKH9HXndyP++Sm82w2yaOtuyN3cUWW/24F4laqiC8htRkKSWqqTv8EqVGuMiZDW
         ngNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bSgOxeSJt8cnP/CvpA9EZuXcjXeTNEZw5hWUR2FJOtw=;
        b=pdmBaGSXllmtB7N7uzc4Ml+addKXNtFY9Wl1ZhYZTQVZYVcmvk98pglygeNoCpCY2t
         rixBJSP0uheQTlsVI7pabstEWcJ2YD/RYhDWeCYywYQ1pZp0mrAi65XlJwWDYOuxossg
         coxvTaXWp5zgSLpDN5f3uzMtLkOgImoQEY8v6TcMB5ol6LAO2pXE2v0b9idmhALKhV2k
         ZcVjy1FA3M9vbIDssMl8lAVKU4v11UIyabC1nnxUKHYAIfMtYA3xMmU+BhpX7CvfnQPR
         /4xe5WfL2aqb67uOgNxcVUJLPkgl/mDGy3awGOOfxxCjGneXG/wlEg7wFo5Y62dDlqnJ
         9riA==
X-Gm-Message-State: AOAM530pFgHj8V2He7yOuBrsS0x7vzDoRyHdkUwKMBBZ10cDKPfFXSYk
        PTieWybzSfEhj+tzoIV2lPPMWqu/bmZ3bsC0flk=
X-Google-Smtp-Source: ABdhPJyDg2YG+jgpUvKAM5eSQ1s/iyvGB+fIFJzwD9Wcn8vEx9tLJxQsdJwflK0kfQwFUnkehPJuLA==
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr3156305edt.338.1645111556805;
        Thu, 17 Feb 2022 07:25:56 -0800 (PST)
Received: from localhost.localdomain ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id u23sm928964edo.64.2022.02.17.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:25:56 -0800 (PST)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, treasure4paddy@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] rcu-tasks: Fix race in schedule and flush work
Date:   Thu, 17 Feb 2022 16:25:19 +0100
Message-Id: <20220217152520.18972-1-treasure4paddy@gmail.com>
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

While booting secondary CPUs, cpus_read_[lock/unlock] not keeping online
cpumask stable. The transient online mask results in below calltrace.

[    0.324121] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.346652] Detected PIPT I-cache on CPU2
[    0.347212] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.377255] Detected PIPT I-cache on CPU3
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
[    0.414566] CPU features: detected: 32-bit EL0 Support
[    0.415414] CPU features: detected: 32-bit EL1 Support
[    0.416278] CPU features: detected: CRC32 instructions
[    0.447021] Callback from call_rcu_tasks_rude() invoked.
[    0.506693] Callback from call_rcu_tasks() invoked.

Link: https://lore.kernel.org/lkml/20220210184319.25009-1-treasure4paddy@gmail.com/T/
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d64f0b1d8cd3..30c42797f53b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -950,6 +950,9 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	if (num_online_cpus() <= 1)
+		return;	// Fastpath for only one CPU.
+
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
-- 
2.17.1

