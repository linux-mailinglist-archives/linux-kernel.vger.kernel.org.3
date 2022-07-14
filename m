Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4721E5740F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGNBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiGNBbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:31:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF9F14D30;
        Wed, 13 Jul 2022 18:31:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o15so978798pjh.1;
        Wed, 13 Jul 2022 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilqttwPjepFmD0kTfN75XWGy4SipmcKZuxYQ1eii/xY=;
        b=GKRliKCwtnaD66A0Ae+OyYbPImmQaG2tNrTZKV1gZ52F3r1bLvcAc3Hr4mw3TrnmLD
         9gQViN1fPPKUqykFkbr5g84/3mclhW118fP8W9N3SDEakHX8XD0ccUOjfFzMPCcJ2e/Q
         CD8wWNELZvy37nwwMaUw7ShL16oSQARG6pHoWktW9MtbDvy6XHPHzqXxFmurZ3Slqz5G
         4IZn3OoVCmF9me5jujxBy6bzz41aA/BFGIkmwEatV76QLX1dbWWHpSOippyHaisKom0U
         xBezwhqpglnHNTor5kRqsZMg7q18+Qpq1wNmnQZ7rkZICTNRp48kliBXk6OWtxYpKFvz
         41pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilqttwPjepFmD0kTfN75XWGy4SipmcKZuxYQ1eii/xY=;
        b=NKd7/wPWeHKibpmN1j7nO0seENEAPGcmoTYCGLMkb27eREURBKpsInf2PJjOjjTy81
         AzWm5/bBBmlHRxh4vr5L2u78TIyBR4DTcZzt9uFuYxrThZNz18XV/nR2bfoRZ7KHCVUg
         tXRcalQXgPCUBuuqPlgNmmYy9yRqVfSJZ9Lb/lad4XWIWF7wCcdjFTbMG+/3cu3WcgZA
         N6AVUXm7H5z9vMJjoLqt281xIwesTLVxAbASmHnF2RaR4g6EXR8xZ6aAGAGWJyYcAZZk
         hs/3VayELe1paDsXD5Cqn7WcSjRuNWT/NTtVIzpyIcSnfaRhVJ+aWK4/uBHpBMD4HlQN
         fWxQ==
X-Gm-Message-State: AJIora+8Ct30as3E03JYIEO0jGIoqAcpR/V6jDsgZPM0P3Onivay4/jY
        yWQU5GBSGr90tzd2ZTaLp0I=
X-Google-Smtp-Source: AGRyM1veZQifNlI6HlJ1G5RFvwADsMIqAt4I7Ix+cZ73sqMaCWOau4H+HR4whROaPJKbCpwYRJGREw==
X-Received: by 2002:a17:90a:2c0d:b0:1ef:c839:c34b with SMTP id m13-20020a17090a2c0d00b001efc839c34bmr13481892pjd.39.1657762306790;
        Wed, 13 Jul 2022 18:31:46 -0700 (PDT)
Received: from localhost.localdomain ([85.203.23.27])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b004150a28a56fsm21912pgj.53.2022.07.13.18.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 18:31:46 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, ldufour@linux.ibm.com, pmladek@suse.com,
        john.ogness@linutronix.de, Julia.Lawall@inria.fr,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lance@osuosl.org, paulmck@kernel.org, rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] powerpc: use raw_smp_processor_id in arch_touch_nmi_watchdog
Date:   Thu, 14 Jul 2022 09:31:31 +0800
Message-Id: <20220714013131.12648-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use raw_smp_processor_id() in arch_touch_nmi_watchdog
because when called from watchdog, the cpu is preemptible.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear PPC developers

I found this bug when trying to do rcutorture tests in ppc VM of
Open Source Lab of Oregon State University.

qemu-system-ppc64  -nographic -smp cores=4,threads=1 -net none  -M pseries -nodefaults -device spapr-vscsi -serial file:/tmp/console.log -m 2G -kernel /home/ubuntu/linux-next/tools/testing/selftests/rcutorture/res/2022.07.08-22.36.11-torture/results-rcuscale-kvfree/TREE/vmlinux -append "debug_boot_weak_hash panic=-1 console=ttyS0 rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot rcuscale.shutdown=1 rcuscale.verbose=0"

tail /tmp/console.log
[ 1232.433552][   T41] BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/41
[ 1232.439751][   T41] caller is arch_touch_nmi_watchdog+0x34/0xd0
[ 1232.440934][   T41] CPU: 3 PID: 41 Comm: khungtaskd Not tainted 5.19.0-rc5-next-20220708-dirty #106
[ 1232.442684][   T41] Call Trace:
[ 1232.443343][   T41] [c0000000029cbbb0] [c0000000006df360] dump_stack_lvl+0x74/0xa8 (unreliable)
[ 1232.445237][   T41] [c0000000029cbbf0] [c000000000d04f30] check_preemption_disabled+0x150/0x160
[ 1232.446926][   T41] [c0000000029cbc80] [c000000000035584] arch_touch_nmi_watchdog+0x34/0xd0
[ 1232.448532][   T41] [c0000000029cbcb0] [c0000000002068ac] watchdog+0x40c/0x5b0
[ 1232.451449][   T41] [c0000000029cbdc0] [c000000000139df4] kthread+0x144/0x170
[ 1232.452896][   T41] [c0000000029cbe10] [c00000000000cd54] ret_from_kernel_thread+0x5c/0x64

After this fix, "BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/41" does not
appear again.

I also examined other places in watchdog.c where smp_processor_id() are used, but they are well protected by preempt
disable.

Kind Regards
Zhouyi
--
 arch/powerpc/kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 7d28b9553654..ab6b84e00311 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -450,7 +450,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 	u64 tb;
 
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
-- 
2.25.1

