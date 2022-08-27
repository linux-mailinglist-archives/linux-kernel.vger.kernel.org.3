Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3B5A335E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiH0BQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiH0BPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:15:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038107B2AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:15:51 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDzGt6vkXznTpV;
        Sat, 27 Aug 2022 09:13:26 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 09:15:48 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <tglx@linutronix.de>, <frederic@kernel.org>,
        <peterz@infradead.org>, <nitesh@redhat.com>,
        <bigeasy@linutronix.de>, <douliyangs@gmail.com>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 2/3] genirq/affinity: Define tmp_mask as a local variable in irq_do_set_affinity
Date:   Sat, 27 Aug 2022 01:13:50 +0000
Message-ID: <20220827011351.9185-2-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220827011351.9185-1-xuqiang36@huawei.com>
References: <20220827011351.9185-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq_do_set_affinity is called, tmp_mask saved last time
does not make any sense. it is reassigned before each use,
so it should be defined as a local variable.

Fixes: 33de0aa4bae9 (“genirq: Always limit the affinity to online CPUs”)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c3423f552e0b..ae1c7eebdfa6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -218,7 +218,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	int ret;
 
 	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
+	struct cpumask tmp_mask;
 
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
-- 
2.17.1

