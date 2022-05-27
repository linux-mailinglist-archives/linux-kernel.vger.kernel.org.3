Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D7535B76
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348889AbiE0I1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiE0I1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:27:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112213E09
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:27:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8dFY3tkXzjX5S;
        Fri, 27 May 2022 16:26:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:27:38 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:27:37 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH] arm64/smp: check !ipi_desc[i] in arch_show_interrupts
Date:   Fri, 27 May 2022 08:22:36 +0000
Message-ID: <20220527082236.78037-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

There is a potential dereferencing null pointer issue in
arch_show_interrupts.

Problem 1:
int arch_show_interrupts(struct seq_file *p, int prec)
        for (i = 0; i < NR_IPI; i++) {
                seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i],
			cpu));

Only ipi_desc[0..nr_ipi - 1] are initialized in set_smp_ipi_range.
and ipi_desc[nr_ipi..NR_IPI] are NULL.
irq_desc_kstat_cpu will dereference NULL pointer.
For now, the problem can not be triggered, because NR_IPI is always
equal to nr_ipi.

Problem 2:
If request_percpu_irq failed in set_smp_ipi_range, ipi_desc[i]
would be NULL.
irq_desc_kstat_cpu will dereference NULL pointer.

check !ipi_desc[i] (as arm does) to avoid the problem.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 arch/arm64/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 62ed361a4376..3d54f464428b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -781,6 +781,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		if (!ipi_desc[i])
+			continue;
+
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-- 
2.17.1

