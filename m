Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2DC59965E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbiHSHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346383AbiHSHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:46:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778CD7422
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:46:23 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8DJ21Zr4zkWYv;
        Fri, 19 Aug 2022 15:42:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:46:21 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 15:46:21 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <nick.child@ibm.com>, <zhengzucheng@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <paulus@samba.org>, <rppt@kernel.org>, <akpm@linux-foundation.org>,
        <oohall@gmail.com>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] powerpc/powermac: Fix symbol not declared warnings
Date:   Fri, 19 Aug 2022 15:43:11 +0800
Message-ID: <20220819074311.862263-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. ppc_override_l2cr and ppc_override_l2cr_value are only used in
   l2cr_init() function, so move them inside the function.
2. has_l2cache is not used outside of the file, so mark it static, and
   do not initialise statics to 0.

Fixes the following warning:

arch/powerpc/platforms/powermac/setup.c:74:5: warning: symbol 'ppc_override_l2cr' was not declared. Should it be static?
arch/powerpc/platforms/powermac/setup.c:75:5: warning: symbol 'ppc_override_l2cr_value' was not declared. Should it be static?
arch/powerpc/platforms/powermac/setup.c:76:5: warning: symbol 'has_l2cache' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/powerpc/platforms/powermac/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 04daa7f0a03c..f8b847a2f5b5 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -68,13 +68,11 @@
 
 #include "pmac.h"
 
 #undef SHOW_GATWICK_IRQS
 
-int ppc_override_l2cr = 0;
-int ppc_override_l2cr_value;
-int has_l2cache = 0;
+static int has_l2cache;
 
 int pmac_newworld;
 
 static int current_root_goodness = -1;
 
@@ -226,10 +224,13 @@ static void __init ohare_init(void)
 	}
 }
 
 static void __init l2cr_init(void)
 {
+	int ppc_override_l2cr = 0;
+	int ppc_override_l2cr_value;
+
 	/* Checks "l2cr-value" property in the registry */
 	if (cpu_has_feature(CPU_FTR_L2CR)) {
 		struct device_node *np;
 
 		for_each_of_cpu_node(np) {
-- 
2.37.1

