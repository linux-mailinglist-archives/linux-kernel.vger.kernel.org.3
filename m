Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6D95A08E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiHYGcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:32:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD69F8C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:32:42 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCtQC2sgGzGplj;
        Thu, 25 Aug 2022 14:30:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 14:32:40 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 14:32:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] arm64/traps: Replace this_cpu_* with raw_cpu_* in panic_bad_stack()
Date:   Thu, 25 Aug 2022 14:31:53 +0800
Message-ID: <20220825063154.69-2-thunder.leizhen@huawei.com>
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
in this_cpu_read() after macro expansion is unnecessary. In fact, before
commit 8168f098867f ("arm64: entry: split bad stack entry"), the operation
this_cpu_read() precedes arm64_enter_nmi(). If set_preempt_need_resched()
is called before stack overflow, this_cpu_read() may trigger scheduling,
see pseudocode below.

Pseudocode of this_cpu_read(xx) when CONFIG_PREEMPTION=y:
preempt_disable_notrace();
raw_cpu_read(xx);
if (unlikely(__preempt_count_dec_and_test()))
	__preempt_schedule_notrace();

Therefore, use raw_cpu_* instead of this_cpu_* to eliminate potential
hazards. At the very least, it reduces a few lines of assembly code.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b7fed33981f7b76..e6b6f4650e3d895 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -871,8 +871,8 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
-	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
-	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
+	unsigned long irq_stk = (unsigned long)raw_cpu_read(irq_stack_ptr);
+	unsigned long ovf_stk = (unsigned long)raw_cpu_ptr(overflow_stack);
 
 	console_verbose();
 	pr_emerg("Insufficient stack space to handle exception!");
-- 
2.25.1

