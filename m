Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F15AAC14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiIBKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiIBKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:09:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A922CC2757
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:09:00 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s31hFjz8APAA--.65103S2;
        Fri, 02 Sep 2022 18:08:55 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] Add kernel relocation and KASLR support
Date:   Fri,  2 Sep 2022 18:08:52 +0800
Message-Id: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_2s31hFjz8APAA--.65103S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYQ7k0a2IF6F4UM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j
        6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
        W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
        Y2xG8wASzI0E04IjxsIE14AKx2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwAKzVC20s0267AEwI8IwI0ExsIj0wCY02Avz4vE14v_Gw1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUJVWUGwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4oGQDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support kernel relocation and KASLR (only 64bit).

When CONFIG_RELOCATABLE is enabled add --emit-relocs to vmlinux LDFLAGS so
that fully linked vmlinux contains relocation information. Run the previously
added relocs tool to fill in the .data.relocs section of vmlinux with a table
of relocations. 

Call relocate_kernel()，the kernel makes a copy of itself at the new address.
It uses the relocation table inserted by the relocs tool to fix symbol
references within the new image. This function will return the entry point
of the relocated kernel if copy/relocate is successful or the original entry
point if not. The stack pointer must then be pointed into the new image.

This feature is supported in both old and new toolchains, note that patches
need to be applied [1] when building with old toolchains.

[1] link: https://lore.kernel.org/loongarch/1662030659-21558-1-git-send-email-tangyouling@loongson.cn/T/#u

Youling Tang (3):
  LoongArch: tools: Add relocs tool support
  LoongArch: Add support for kernel relocation
  LoongArch: Add support for kernel address space layout randomization
    (KASLR)

 arch/loongarch/Kconfig                  |  51 +++
 arch/loongarch/Makefile                 |   7 +
 arch/loongarch/Makefile.postlink        |  33 ++
 arch/loongarch/boot/.gitignore          |   1 +
 arch/loongarch/boot/tools/Makefile      |   8 +
 arch/loongarch/boot/tools/relocs.c      | 544 ++++++++++++++++++++++++
 arch/loongarch/boot/tools/relocs.h      |  55 +++
 arch/loongarch/boot/tools/relocs_64.c   |  18 +
 arch/loongarch/boot/tools/relocs_main.c |  82 ++++
 arch/loongarch/include/asm/page.h       |   6 +
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/head.S            |  17 +
 arch/loongarch/kernel/relocate.c        | 328 ++++++++++++++
 arch/loongarch/kernel/setup.c           |   3 +
 arch/loongarch/kernel/vmlinux.lds.S     |  25 ++
 15 files changed, 1180 insertions(+)
 create mode 100644 arch/loongarch/Makefile.postlink
 create mode 100644 arch/loongarch/boot/tools/Makefile
 create mode 100644 arch/loongarch/boot/tools/relocs.c
 create mode 100644 arch/loongarch/boot/tools/relocs.h
 create mode 100644 arch/loongarch/boot/tools/relocs_64.c
 create mode 100644 arch/loongarch/boot/tools/relocs_main.c
 create mode 100644 arch/loongarch/kernel/relocate.c

-- 
2.36.1

