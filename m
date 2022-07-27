Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005E2581E00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiG0DNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiG0DNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:13:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEEC3CBFD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:13:10 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LszKz1Fp3zjXQ2;
        Wed, 27 Jul 2022 11:10:15 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 11:13:07 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <linux@armlinux.org.uk>, <robh@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <kirill.shtuemov@linux.intel.com>,
        <akpm@linux-foundation.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <austindh.kim@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <weiyongjun1@huawei.com>,
        <guohanjun@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 3/3] arm: Delete similar code across of_flat_dt_match_machine and setup_machine_fdt
Date:   Wed, 27 Jul 2022 03:11:00 +0000
Message-ID: <20220727031100.112919-3-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220727031100.112919-1-xuqiang36@huawei.com>
References: <20220727031100.112919-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_flat_dt_match_machine() print compatible content when its
return value is NULL, and setup_machine_fdt print again when
mdesc is NULL. So remove duplicate print codes in setup_machine_fdt.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 arch/arm/kernel/devtree.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 182a59b23b09..b6151bcf31cb 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -208,25 +208,8 @@ const struct machine_desc * __init setup_machine_fdt(void *dt_virt)
 
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
 
-	if (!mdesc) {
-		const char *prop;
-		int size;
-		unsigned long dt_root;
-
-		early_print("\nError: unrecognized/unsupported "
-			    "device tree compatible list:\n[ ");
-
-		dt_root = of_get_flat_dt_root();
-		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
-		while (size > 0) {
-			early_print("'%s' ", prop);
-			size -= strlen(prop) + 1;
-			prop += strlen(prop) + 1;
-		}
-		early_print("]\n\n");
-
+	if (!mdesc)
 		dump_machine_table(); /* does not return */
-	}
 
 	/* We really don't want to do this, but sometimes firmware provides buggy data */
 	if (mdesc->dt_fixup)
-- 
2.17.1

