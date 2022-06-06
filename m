Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C353E05A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiFFD47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiFFD4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:56:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5194197
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:56:45 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LGfmq2KDvzKmJG;
        Mon,  6 Jun 2022 11:56:27 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 11:56:42 +0800
Date:   Mon, 6 Jun 2022 11:56:35 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Changbin Du <changbin.du@gmail.com>,
        Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <changbin.du@huawei.com>
Subject: [PATCH] riscv: kexec: build
 {kexec_relocate,crash_save_regs,machine_kexec}.c as kexec core files
Message-ID: <20220606035635.o52ja3bjpru3fqcf@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes below linking errors when building with CONFIG_KEXEC_FILE=y &&
CONFIG_KEXEC=n. The {kexec_relocate,crash_save_regs,machine_kexec}.c should
be core kexec source files.

riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `kimage_free':
/home/changbin/work/linux-riscv/kernel/kexec_core.c:651: undefined reference to `machine_kexec_cleanup'
riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `__crash_kexec':
/home/changbin/work/linux-riscv/kernel/kexec_core.c:981: undefined reference to `machine_crash_shutdown'
riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_core.c:982: undefined reference to `machine_kexec'
riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `crash_setup_regs':
/home/changbin/work/linux-riscv/./arch/riscv/include/asm/kexec.h:35: undefined reference to `riscv_crash_save_regs'
riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `kernel_kexec':
/home/changbin/work/linux-riscv/kernel/kexec_core.c:1200: undefined reference to `machine_shutdown'
riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_core.c:1204: undefined reference to `machine_kexec'
riscv64-linux-gnu-ld: kernel/kexec_file.o: in function `__do_sys_kexec_file_load':
/home/changbin/work/linux-riscv/kernel/kexec_file.c:363: undefined reference to `machine_kexec_prepare'
riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_file.c:363: undefined reference to `machine_kexec_prepare'
make: *** [Makefile:1160: vmlinux] Error 1

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 arch/riscv/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c71d6591d539..33bb60a354cd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
+obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
 obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
-- 
2.26.2


-- 
Cheers,
Changbin Du
