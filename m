Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9571539DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350166AbiFAHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiFAHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:03:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2CA8BD3F;
        Wed,  1 Jun 2022 00:03:53 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LCg7Q5gDFz1K97R;
        Wed,  1 Jun 2022 15:02:10 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 15:03:49 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <rdunlap@infradead.org>, <palmer@rivosinc.com>, <mick@ics.forth.gr>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <liaochang1@huawei.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-next@vger.kernel.org>
Subject: [PATCH] RISC-V: kexec: Fix build error without CONFIG_KEXEC
Date:   Wed, 1 Jun 2022 15:02:04 +0800
Message-ID: <20220601070204.26882-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KEXEC_FILE=y but CONFIG_KEXEC is not set:

kernel/kexec_core.o: In function `kimage_free':
kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
kernel/kexec_core.o: In function `.L231':
kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
kernel/kexec_core.o: In function `.L312':
kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
kernel/kexec_file.o: In function `.L0 ':
kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
kernel/kexec_file.o: In function `.L177':
kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'
Makefile:1160: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

These symbols should depend on CONFIG_KEXEC_CORE rather than CONFIG_KEXEC
when kexec_file has been implemented on RISC-V, like the other archs have
done.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
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
2.17.1

