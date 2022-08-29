Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0B5A41F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH2EhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiH2EhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:37:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A1203ED40
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:37:16 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtvQgxjO6YLAA--.39821S2;
        Mon, 29 Aug 2022 12:37:04 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] LoongArch: Add kexec/kdump support
Date:   Mon, 29 Aug 2022 12:37:00 +0800
Message-Id: <1661747823-23745-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxvmtvQgxjO6YLAA--.39821S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xGFy7tF1rWw4ruFy8Xwb_yoW8uw1kpF
        4Uurn8Kr48GFn3Jwnxtw1DuryrJ3s7Gw1ag3ZIy34rZFW2qF1UZrnYqF9rXF15tw4fKrW0
        qFnYg3y2g3WUJa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07br4EiUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support kexec/kdump (only 64bit).

Kexec is a system call that enables you to load and boot into another kernel
from the currently running kernel. This is useful for kernel developers or
other people who need to reboot very quickly without waiting for the whole
BIOS boot process to finish. 

Kdump uses kexec to quickly boot to a dump-capture kernel whenever a
dump of the system kernel's memory needs to be taken (for example, when
the system panics). The system kernel's memory image is preserved across
the reboot and is accessible to the dump-capture kernel.

For details, see Documentation/admin-guide/kdump/kdump.rst.

User tools kexec-tools see link [1].

TODO:
Currently kdump does not support the same binary image, the production kernel
and the capture kernel will be generated with different configurations. I will
support kernel relocation support in the near future. Then will go to implement
the same binary support based on kernel relocation support.

[1] Link: https://github.com/tangyouling/kexec-tools


Youling Tang (3):
  LoongArch: Add kexec support
  LoongArch: Add kdump support
  LoongArch: Enable CONFIG_KEXEC

 arch/loongarch/Kconfig                     |  33 ++++
 arch/loongarch/Makefile                    |   4 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/kexec.h         |  58 +++++++
 arch/loongarch/kernel/Makefile             |   3 +
 arch/loongarch/kernel/crash.c              | 100 ++++++++++++
 arch/loongarch/kernel/crash_dump.c         |  19 +++
 arch/loongarch/kernel/head.S               |   7 +-
 arch/loongarch/kernel/machine_kexec.c      | 176 +++++++++++++++++++++
 arch/loongarch/kernel/mem.c                |   6 +
 arch/loongarch/kernel/relocate_kernel.S    | 131 +++++++++++++++
 arch/loongarch/kernel/setup.c              |  49 ++++++
 arch/loongarch/kernel/traps.c              |   4 +
 13 files changed, 590 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/kexec.h
 create mode 100644 arch/loongarch/kernel/crash.c
 create mode 100644 arch/loongarch/kernel/crash_dump.c
 create mode 100644 arch/loongarch/kernel/machine_kexec.c
 create mode 100644 arch/loongarch/kernel/relocate_kernel.S

-- 
2.36.0

