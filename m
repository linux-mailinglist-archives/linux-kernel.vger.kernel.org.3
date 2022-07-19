Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96157935A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiGSGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGSGjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:39:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD8248FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:39:12 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ln8Hc2j5tz1M7yl;
        Tue, 19 Jul 2022 14:36:28 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 14:39:10 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <weiyongjun1@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH v2 -next 1/2] irqdomain: Fix an issue where the Linux IRQ number is not stored
Date:   Tue, 19 Jul 2022 06:36:40 +0000
Message-ID: <20220719063641.56541-2-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719063641.56541-1-xuqiang36@huawei.com>
References: <20220719063641.56541-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a NOMAP domain, __irq_resolve_mapping() doesn't store
the Linux IRQ number at the address optionally provided by the caller.
While this isn't a huge deal (the returned value is guaranteed
to the hwirq that was passed as a parameter), let's honour the letter
of the API by writing the expected value.

Fixes: d22558dd0a6c (“irqdomain: Introduce irq_resolve_mapping()”)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/irq/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d5ce96510549..481abb885d61 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -910,6 +910,8 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 			data = irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq == hwirq)
 				desc = irq_data_to_desc(data);
+			if (irq && desc)
+				*irq = hwirq;
 		}
 
 		return desc;
-- 
2.17.1

