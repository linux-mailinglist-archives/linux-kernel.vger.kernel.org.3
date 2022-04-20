Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809F508A07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379342AbiDTOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379335AbiDTOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172764349B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p3so685954pfw.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2khFeLeVUO5ld1xI1BAqlcBSQpfcvbdSYE3+epMyuqI=;
        b=aeWdipoCVBqQ0XwlZV5CrcAVoHIe3L5+uvMQKpqsl5P76/cMWR8jB8f1opjELbHStN
         9M4Q29RMQEJntWJS1g9GXV4ByQLPo2V/YSsgRgfNFcok6LHwU1h+EiutqDIMkutN2Ap1
         L8eJUZqH6evHozuVd7xD8iZJQzWfKAg5RQM4uV1qAowMz6D5W5jOXspcZuUtnIGLDmF9
         +PvzXfhjpOjx1kJ/3DtQwr32MbTzr6P/ZPDJE3v+kN1mep0Y3xXLNw4K+VIW+Lhmz9Vc
         HsHSLII9Z+oRbYV2vcj8+mETp6NnfMUyH02E4teMuvm754fUVCegrOH1PxSC21FkDoxi
         KV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2khFeLeVUO5ld1xI1BAqlcBSQpfcvbdSYE3+epMyuqI=;
        b=lIblwm/EwRVXrGVPdefW31BD+CEUOzlTLnKFFCzJxynafSEUopts2RuQ5C16zOu7Oq
         UaRMyvzh1pSL3F4Upi3s8jPfrnZDK+YTOkGL/U5P2ZoeywdaYMj2/8Vaqz1y0etZIyu7
         TH8lUmhinxEPSz2KjX2g3IORZyIJRUi2XsQzfw1jSCG24R9FGTQoCWqOkQKNLGeuCmwR
         LuL6vW6NWVPuIoGoInFRJMyndK1/cbF1PRwC8pTNpU4lbz9OsPNdUNc94CyY72s+u/fk
         xatAEB+kQrjH9y5agO8jMOCzW3QDiLjugj81hjImVC3QTnXvkrPHe0coQVm+tericFfx
         87jA==
X-Gm-Message-State: AOAM5330PlFEbLQqi5iFUrXJlpqudsYwZRRzt9uB+TxDGCz8u1GMKIi5
        VFeXN+zGtOP4vq47r4CReHnUjO69iQ==
X-Google-Smtp-Source: ABdhPJw3PaGLjc1VBIEVVM7c6O1tFj2r90M91lThQyFKbvvs94T1JR4g3lDnYQG0+dUkw0MlTXTvCg==
X-Received: by 2002:a63:4c4b:0:b0:3aa:4af8:9ab8 with SMTP id m11-20020a634c4b000000b003aa4af89ab8mr5816697pgl.430.1650463568427;
        Wed, 20 Apr 2022 07:06:08 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:06:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Baokun Li <libaokun1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 7/9] irq: remove needless lock in takedown_cpu()
Date:   Wed, 20 Apr 2022 22:05:19 +0800
Message-Id: <20220420140521.45361-8-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-1-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any allocation or release of irq_desc should fall into the interface of
__irq_alloc_descs() or irq_free_descs(). And both of them hold the mutex
sparse_irq_lock. This preemptability contradicts the preempt-disabled
context when dispatching fn in cpu_stopper_thread(). So allocation or
free of irq_desc can not be demanded in cpu_stopper_thread().

On the other hand, for the safety of access to irq_desc, rcu still keeps
watching the dying cpu until the last minute rcu_report_dead(), so each
cpu_stop_fn_t can safely access irq_desc.

As a result, in takedown_cpu() irq_lock_sparse()/irq_unlock_sparse() can
be safely removed.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..94a6b512c26d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1033,18 +1033,16 @@ static int takedown_cpu(unsigned int cpu)
 	kthread_park(st->thread);
 
 	/*
-	 * Prevent irq alloc/free while the dying cpu reorganizes the
-	 * interrupt affinities.
+	 * RCU keeps watching 'cpu' until do_idle()->rcu_report_dead().
+	 * And cpu_stopper's fn is dispatched with preemption disabled.
+	 * So it can not occur to release a irq_desc.
 	 */
-	irq_lock_sparse();
 
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
 	if (err) {
-		/* CPU refused to die */
-		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
 		kthread_unpark(st->thread);
 		return err;
@@ -1061,9 +1059,6 @@ static int takedown_cpu(unsigned int cpu)
 	wait_for_ap_thread(st, false);
 	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
-	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
-	irq_unlock_sparse();
-
 	hotplug_cpu__broadcast_tick_pull(cpu);
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
-- 
2.31.1

