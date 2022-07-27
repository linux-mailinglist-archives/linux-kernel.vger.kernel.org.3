Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A0581DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiG0DNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbiG0DNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:13:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B83CBF7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:13:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LszJm2W8JzWft6;
        Wed, 27 Jul 2022 11:09:12 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 11:13:05 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <linux@armlinux.org.uk>, <robh@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <kirill.shtuemov@linux.intel.com>,
        <akpm@linux-foundation.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <austindh.kim@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <weiyongjun1@huawei.com>,
        <guohanjun@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 1/3] ARM: 9011/1: remove atags_vaddr variable double check
Date:   Wed, 27 Jul 2022 03:10:58 +0000
Message-ID: <20220727031100.112919-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
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

setup_machine_fdt() can handle NULL atags_vaddr as its argument,
and return NULL mdesc when atags_vaddr is NULL. So remove NULL
check before setup_machine_fdt operation.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 arch/arm/kernel/setup.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..07039c98be15 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1101,13 +1101,10 @@ void __init setup_arch(char **cmdline_p)
 		atags_vaddr = FDT_VIRT_BASE(__atags_pointer);
 
 	setup_processor();
-	if (atags_vaddr) {
-		mdesc = setup_machine_fdt(atags_vaddr);
-		if (mdesc)
-			memblock_reserve(__atags_pointer,
-					 fdt_totalsize(atags_vaddr));
-	}
-	if (!mdesc)
+	mdesc = setup_machine_fdt(atags_vaddr);
+	if (mdesc)
+		memblock_reserve(__atags_pointer, fdt_totalsize(atags_vaddr));
+	else
 		mdesc = setup_machine_tags(atags_vaddr, __machine_arch_type);
 	if (!mdesc) {
 		early_print("\nError: invalid dtb and unrecognized/unsupported machine ID\n");
-- 
2.17.1

