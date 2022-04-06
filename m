Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4B4F5EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiDFNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiDFNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:06:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B456F41D681
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:47:19 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY6lx3K12zgYPh;
        Wed,  6 Apr 2022 09:45:33 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 09:47:17 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <hucool.lihua@huawei.com>,
        <w.f@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH] sched: Fix pointless comparison between unsigned int with zero
Date:   Wed, 6 Apr 2022 09:46:28 +0800
Message-ID: <20220406014628.172539-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is pointless to do a comparison bewteen unsigned variable and zero,
since validation routine requires the MSB of sysctl_sched_rt_period_ms
is 0, so casting variable to signed value before comparing with zero.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..58e105180e67 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2906,7 +2906,7 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
+	if ((int)sysctl_sched_rt_period <= 0)
 		return -EINVAL;
 
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
-- 
2.17.1

