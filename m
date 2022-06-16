Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E654D867
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbiFPCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFPCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:34:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFC31228
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:34:51 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNmRl3Gttz1K9sx;
        Thu, 16 Jun 2022 10:32:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 10:34:50 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 10:34:49 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH 1/1] lockdep: make PROVE_RAW_LOCK_NESTING depend on PREEMPT_RT
Date:   Thu, 16 Jun 2022 02:29:11 +0000
Message-ID: <20220616022911.35826-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

CONFIG_PROVE_RAW_LOCK_NESTING is used to check two things.
1. calling spin_lock in hardirq.
2. raw_spinlock - spinlock nesting.
The error messages like below:
[   13.485711] [ BUG: Invalid wait context ]
However there is no problem on non-PREEMPT_RT kernel. The messages may be
confusing and disturbing. 

Therefore, do not check raw_spinlock - spinlock nesting
on non-PREEMPT_RT kernel.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bd90664a2783..163d3a6606f3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1227,6 +1227,7 @@ config PROVE_LOCKING
 config PROVE_RAW_LOCK_NESTING
 	bool "Enable raw_spinlock - spinlock nesting checks"
 	depends on PROVE_LOCKING
+	depends on PREEMPT_RT
 	default n
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
-- 
2.17.1

