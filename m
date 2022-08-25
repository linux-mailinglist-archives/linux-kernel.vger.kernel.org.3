Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D25A08E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiHYGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiHYGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:32:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED729F77C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:32:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCtMB0pXBzXdSS;
        Thu, 25 Aug 2022 14:28:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 14:32:40 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 14:32:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] ARM: Replace this_cpu_* with raw_cpu_* in panic_bad_stack()
Date:   Thu, 25 Aug 2022 14:31:54 +0800
Message-ID: <20220825063154.69-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220825063154.69-1-thunder.leizhen@huawei.com>
References: <20220825063154.69-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware automatically disable the IRQ interrupt before jumping to the
interrupt or exception vector. Therefore, the preempt_disable() operation
in this_cpu_read() after macro expansion is unnecessary. In fact, function
this_cpu_read() may trigger scheduling, see pseudocode below.

Pseudocode of this_cpu_read(xx):
preempt_disable_notrace();
raw_cpu_read(xx);
if (unlikely(__preempt_count_dec_and_test()))
	__preempt_schedule_notrace();

Therefore, use raw_cpu_* instead of this_cpu_* to eliminate potential
hazards. At the very least, it reduces a few lines of assembly code.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
KernelVersion: v6.0-rc2
 arch/arm/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1518a1f443ff866..d5903d790cf3b7e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -927,9 +927,9 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 #ifdef CONFIG_IRQSTACKS
-	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
+	unsigned long irq_stk = (unsigned long)raw_cpu_read(irq_stack_ptr);
 #endif
-	unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
+	unsigned long ovf_stk = (unsigned long)raw_cpu_read(overflow_stack_ptr);
 
 	console_verbose();
 	pr_emerg("Insufficient stack space to handle exception!");
-- 
2.25.1

