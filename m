Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09DE533BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiEYLaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiEYLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:30:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F889EB5F;
        Wed, 25 May 2022 04:30:00 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cx7+U2E45iXTcBAA--.7414S2;
        Wed, 25 May 2022 19:29:58 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC
Date:   Wed, 25 May 2022 19:29:55 +0800
Message-Id: <1653478195-21095-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Cx7+U2E45iXTcBAA--.7414S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrGF17WFWfCF43tryUAwb_yoW5Cr48pF
        s5Ar92vw4rGFy3Ga1fZFn7uFsxWws8XFWUXr1FgwnxZF1qq347Jrs3Kr15AFW5JFs2qFWx
        tr1fKw1UZFyqyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUAhltUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports a build error used with clang compiler and
mips-randconfig [1]:

    ld.lld: error: undefined symbol: pci_remap_iospace

we can see the following configs in the mips-randconfig file:

    CONFIG_RALINK=y
    CONFIG_SOC_MT7620=y
    CONFIG_PCI_DRIVERS_LEGACY=y
    CONFIG_PCI=y

CONFIG_RALINK is set, so pci_remap_iospace is defined in the related
arch/mips/include/asm/mach-ralink/spaces.h header file:

    #define pci_remap_iospace pci_remap_iospace

CONFIG_PCI is set, so pci_remap_iospace() in drivers/pci/pci.c is not
built due to pci_remap_iospace is defined under CONFIG_RALINK.

    #ifndef pci_remap_iospace
    int pci_remap_iospace(const struct resource *res, ...)

    $ objdump -d drivers/pci/pci.o | grep pci_remap_iospace
    00004cc8 <devm_pci_remap_iospace>:
        4d18:	10400008 	beqz	v0,4d3c <devm_pci_remap_iospace+0x74>
        4d2c:	1040000c 	beqz	v0,4d60 <devm_pci_remap_iospace+0x98>
        4d70:	1000fff3 	b	4d40 <devm_pci_remap_iospace+0x78>

In addition, CONFIG_PCI_DRIVERS_GENERIC is not set, so pci_remap_iospace()
in arch/mips/pci/pci-generic.c is not built too.

    #ifdef pci_remap_iospace
    int pci_remap_iospace(const struct resource *res, ...)

For the above reasons, undefined reference pci_remap_iospace() looks like
reasonable.

Here are simple steps to reproduce used with gcc and defconfig:

    cd mips.git
    make vocore2_defconfig # set RALINK, SOC_MT7620, PCI_DRIVERS_LEGACY
    make menuconfig        # set PCI
    make

there exists the following build error:

      LD      vmlinux.o
      MODPOST vmlinux.symvers
      MODINFO modules.builtin.modinfo
      GEN     modules.builtin
      LD      .tmp_vmlinux.kallsyms1
    drivers/pci/pci.o: In function `devm_pci_remap_iospace':
    pci.c:(.text+0x4d24): undefined reference to `pci_remap_iospace'
    Makefile:1158: recipe for target 'vmlinux' failed
    make: *** [vmlinux] Error 1

Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC can fix the build
error, with this patch, no build error remains. This patch is similar with
commit e538e8649892 ("MIPS: asm: pci: define arch-specific
'pci_remap_iospace()' dependent on 'CONFIG_PCI_DRIVERS_GENERIC'").

[1] https://lore.kernel.org/lkml/202205251247.nQ5cxSV6-lkp@intel.com/

Fixes: 09d97da660ff ("MIPS: Only define pci_remap_iospace() for Ralink")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/include/asm/mach-ralink/spaces.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index f7af11e..a9f0570 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -6,7 +6,9 @@
 #define PCI_IOSIZE	SZ_64K
 #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
+#ifdef CONFIG_PCI_DRIVERS_GENERIC
 #define pci_remap_iospace pci_remap_iospace
+#endif
 
 #include <asm/mach-generic/spaces.h>
 #endif
-- 
2.1.0

