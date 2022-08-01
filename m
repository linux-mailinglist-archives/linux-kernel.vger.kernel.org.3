Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D5586AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiHAMii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiHAMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:38:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 201D39E7A1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:17:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxAM9WxOdiKTUAAA--.1249S2;
        Mon, 01 Aug 2022 20:17:27 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 0/4] LoongArch: Add unwinder support
Date:   Mon,  1 Aug 2022 20:17:22 +0800
Message-Id: <20220801121726.9681-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxAM9WxOdiKTUAAA--.1249S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1rGFWxtrykJF4rCw48JFb_yoW5Jr15pF
        ZrZrnxGF4UGrySyr9xtw18urn5Jrn7Gw4aqa9FyryrCF4aqF17ZrnY9r9rZ3WDt395J340
        qFn5G3s0gayjqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3xhLUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series in order to add stacktrace suport, Some upcoming features require
these changes, like trace, divide unwinder into guess unwinder and prologue
unwinder is to add new unwinders in the future, eg:unwind_frame, unwind_orc .etc.
Three stages when we do unwind,
  1) unwind_start(), the prapare of unwinding, fill unwind_state.
  2) unwind_done(), judge whether the unwind process is finished or not.
  3) unwind_next_frame(), unwind the next frame.

you can test them by:
  1) echo t > /proc/sysrq-trigger
  2) cat /proc/*/stack
  4) ftrace: function graph
  5) uprobe: echo 1 > ./options/userstacktrace

Changes from v1 to v2:

- Add the judgment of the offset value of ra in the prologue.
  (Suggested by Youling).
- Create an inline function to check the sign bit, which is convenient
  for extending other types of immediates.  (Suggested by Jinyang).
- Fix sparse warning :
    arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect
    type in argument 2 (different address spaces) @@     expected void const
    *from @@     got void const [noderef] __user *from @@
- Add USER_STACKTRACE support as a series.

Qing Zhang (4):
  LoongArch: Add guess unwinder support
  LoongArch: Add prologue unwinder support
  LoongArch: Add stacktrace support
  LoongArch: Add USER_STACKTRACE support

 arch/loongarch/Kconfig                  |   6 +
 arch/loongarch/Kconfig.debug            |  28 ++++
 arch/loongarch/include/asm/inst.h       |  52 +++++++
 arch/loongarch/include/asm/processor.h  |   9 ++
 arch/loongarch/include/asm/stacktrace.h |  22 +++
 arch/loongarch/include/asm/switch_to.h  |  14 +-
 arch/loongarch/include/asm/uaccess.h    |   4 +-
 arch/loongarch/include/asm/unwind.h     |  45 +++++++
 arch/loongarch/kernel/Makefile          |   4 +
 arch/loongarch/kernel/asm-offsets.c     |   2 +
 arch/loongarch/kernel/process.c         |  64 +++++++++
 arch/loongarch/kernel/stacktrace.c      |  79 +++++++++++
 arch/loongarch/kernel/switch.S          |   2 +
 arch/loongarch/kernel/traps.c           |  27 ++--
 arch/loongarch/kernel/unwind_guess.c    |  65 +++++++++
 arch/loongarch/kernel/unwind_prologue.c | 172 ++++++++++++++++++++++++
 16 files changed, 577 insertions(+), 18 deletions(-)
 create mode 100644 arch/loongarch/include/asm/unwind.h
 create mode 100644 arch/loongarch/kernel/stacktrace.c
 create mode 100644 arch/loongarch/kernel/unwind_guess.c
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c

-- 
2.20.1

