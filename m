Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD3497954
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiAXHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:18:45 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31117 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiAXHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:18:44 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jj1T66vJwz1FCqD;
        Mon, 24 Jan 2022 15:14:50 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 15:18:42 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 15:18:42 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <guohanjun@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Select housekeeping CPUs preferentially for managed IRQs
Date:   Mon, 24 Jan 2022 15:34:40 +0800
Message-ID: <20220124073440.88598-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using kernel parameter 'isolcpus=managed_irq,xxxx' to bind the
managed IRQs to housekeeping CPUs, the effective_affinity sometimes
still contains the non-housekeeping CPUs.

irq_do_set_affinity() passes the housekeeping cpumask to
chip->irq_set_affinity(), but ITS driver select CPU according to
irq_common_data->affinity. While 'irq_common_data->affinity' is updated
after chip->irq_set_affinity() is called in irq_do_set_affinity(). Also
'irq_common_data->affinity' may contains non-housekeeping CPUs. I found
the below link explaining the reason.
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2267032.html

To modify CPU selecting logic to prefer housekeeping CPUs, select CPU
from the input cpumask parameter first. If none of it is online, then
select CPU from 'irq_common_data->affinity'.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d25b7a864bbb..17c15d3b2784 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,7 +1624,10 @@ static int its_select_cpu(struct irq_data *d,
 
 		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	} else {
-		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
+		if (cpumask_empty(tmpmask))
+			cpumask_and(tmpmask, irq_data_get_affinity_mask(d),
+				    cpu_online_mask);
 
 		/* If we cannot cross sockets, limit the search to that node */
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
-- 
2.20.1

