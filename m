Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31956D451
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGKFba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKFb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:31:28 -0400
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E718E11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 22:31:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:145f:6500:b54:140f:b5d9:b486])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id EA3953C0465;
        Mon, 11 Jul 2022 13:31:22 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yupeng Li <liyupeng@zbhlos.com>, Caicai <caizp2008@163.com>
Subject: [PATCH 1/1]     Loongson: Fix section mismatch warning
Date:   Mon, 11 Jul 2022 13:31:08 +0800
Message-Id: <20220711053108.328029-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk9IVk9NHk5KSEweGRkZTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPTh1BTU5LS0EZTk9BSk9LHUEZTh9CQRlPQ01ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hOT1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Eyo6Dz06KBM1IiowEiFM
        FxBPFDJVSlVKTU5MTkpMT0NIT0pJVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT04dQU1OS0tBGU5PQUpPSx1BGU4fQkEZT0NNWVdZCAFZQUlIT003Bg++
X-HM-Tid: 0a81ebbda4562eb0kusnea3953c0465
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    init_numa_memory() is annotated __init and not used by any module,
    thus don't export it.

    Remove not needed EXPORT_SYMBOL for init_numa_memory() to fix the
    following section mismatch warning:

  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
The symbol prom_init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

  MODINFO modules.builtin.modinfo
  GEN     modules.builtin

    This is build on Linux 5.19-rc5.

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
Reviewed-by: Caicai <caizp2008@163.com>
---
 arch/mips/loongson64/numa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 69a533148efd..8f61e93c0c5b 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -196,7 +196,6 @@ void __init prom_init_numa_memory(void)
 	pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
 	prom_meminit();
 }
-EXPORT_SYMBOL(prom_init_numa_memory);
 
 pg_data_t * __init arch_alloc_nodedata(int nid)
 {
-- 
2.34.1

