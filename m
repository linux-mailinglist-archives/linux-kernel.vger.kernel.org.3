Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15393529E78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiEQJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiEQJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:49:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B707AE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:49:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2WX76253zcmxx;
        Tue, 17 May 2022 17:48:23 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 17:49:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/kaslr_booke: Fix build error
Date:   Tue, 17 May 2022 17:49:00 +0800
Message-ID: <20220517094900.14900-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/mm/nohash/kaslr_booke.c: In function ‘kaslr_get_cmdline’:
arch/powerpc/mm/nohash/kaslr_booke.c:46:2: error: implicit declaration of function ‘early_init_dt_scan_chosen’; did you mean ‘early_init_mmu_secondary’? [-Werror=implicit-function-declaration]
  early_init_dt_scan_chosen(boot_command_line);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
  early_init_mmu_secondary
arch/powerpc/mm/nohash/kaslr_booke.c: In function ‘get_initrd_range’:
arch/powerpc/mm/nohash/kaslr_booke.c:210:10: error: implicit declaration of function ‘of_read_number’; did you mean ‘seq_read_iter’? [-Werror=implicit-function-declaration]
  start = of_read_number(prop, len / 4);
          ^~~~~~~~~~~~~~
          seq_read_iter

Add missing include files to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 5da604cd2be6..1f3f9fedf1bc 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -14,6 +14,8 @@
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <linux/crash_core.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <asm/cacheflush.h>
 #include <asm/kdump.h>
 #include <mm/mmu_decl.h>
-- 
2.17.1

