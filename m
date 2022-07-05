Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637DA566427
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiGEHeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGEHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:34:09 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6F21B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:34:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VIR2GSE_1657006431;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VIR2GSE_1657006431)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 15:34:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] x86/CPU: drop set but unused variable
Date:   Tue,  5 Jul 2022 15:33:49 +0800
Message-Id: <20220705073349.1512-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning showed up when compiling with W=1.

arch/x86/kernel/cpu/cacheinfo.c:730:15: warning: variable 'trace' set but not used [-Wunused-but-set-variable].

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 66556833d7af..7ef070fbc14c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -727,7 +727,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0;
+	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
@@ -828,9 +828,11 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 						case LVL_3:
 							l3 += cache_table[k].size;
 							break;
-						case LVL_TRACE:
-							trace += cache_table[k].size;
-							break;
+						/*
+						 * case LVL_TRACE:
+						 *	trace += cache_table[k].size;
+						 *	break;
+						 */
 						}
 
 						break;
-- 
2.20.1.7.g153144c

