Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BFE4DADCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354998AbiCPJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiCPJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:53:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD7606E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:51:55 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJQVS2hVpzCqpY;
        Wed, 16 Mar 2022 17:49:52 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:51:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 17:51:52 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <bobo.shaobowang@huawei.com>, <zengshun.wu@outlook.com>
Subject: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic trampoline
Date:   Wed, 16 Mar 2022 18:01:28 +0800
Message-ID: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements dynamic trampoline in ARM64, as reference said, we
complete whole design of supporting long jump in dynamic trampoline:

   .text section:
     funcA:         |    funcA():        funcB():|
      `->  +-----+  |    |   ...         mov x9  |
           | ... |  |    |   adrp   <-   bl  <>  |
           | nop |  |    |   mov
           | nop |  |    |   br   x16 ---+
     funcB | nop |  |                    | ftrace_(regs_)caller_tramp:
      `->  +-----+  |                    `--> +---------------------+
           | nop |  |                         | ...                 |
           | nop |  |       ftrace callsite   +---------------------+
           | ... |  |                `----->  | PLT entry:          |
           | nop |  |                         |       adrp          |
           | nop |  |                         |       add           |
    funcC: | nop |  | ftrace graph callsite   |       br   x16      |
      `->  +-----+  |                `----->  +---------------------+
           | nop |  |                         | ...                 |
           | nop |  |                         +---------------------+

But there is still a tricky problem that is how to adjust tracing ip,
waiting to be solved:

For ARM64, somecases there may be extra instructions inserted into the
head of tracable functions(but not all) by compiler, for instance BTI[1].

This dump vmlinux with CONFIG_BTI=y:

(1) function gic_handle_irq has bti in its head, so we adjust rec->ip+=5 to last nop
    ffffffc0080100e0:       d53cd042        mrs     x2, tpidr_el2
            ...
    ffffffc0080100f0:       d503201f        nop     //__mcount_loc tells the rec->ip
    ffffffc0080100f4:       d503201f        nop
    ffffffc0080100f8:       d503201f        nop

    ffffffc0080100fc <gic_handle_irq>:
    ffffffc0080100fc:       d503245f        bti     c
    ffffffc008010100:       d503201f        nop
    ffffffc008010104:       d503201f        nop     //we adjust origin rec->ip+5 to here
    ffffffc008010108:       d503233f        paciasp
(2) name_to_dev_t.part.0 do not has bti in its head, so we should adjust rec->ip+=4 to last nop
    ffff8000080137d4:       d503201f        nop
    ffff8000080137d8:       d503201f        nop
    ffff8000080137dc:       d503201f        nop
    
    ffff8000080137e0 <name_to_dev_t.part.0>:
    ffff8000080137e0:       d503201f        nop
    ffff8000080137e4:       d503201f        nop
    ffff8000080137e8:       d503233f        paciasp

So at this time we have no idea to identify rec->ip for each tracable function.

we are looking forward to follow-up discussions.

References:
[1] https://developer.arm.com/documentation/100076/0100/a64-instruction-set-reference/a64-general-instructions/bti
[2] https://lore.kernel.org/linux-arm-kernel/20200109142736.1122-1-cj.chengjian@huawei.com/

Cheng Jian (4):
  arm64: introduce aarch64_insn_gen_load_literal
  arm64/ftrace: introduce ftrace dynamic trampoline entrances
  arm64/ftrace: support dynamically allocated trampolines
  arm64/ftrace: implement long jump for dynamic trampolines

 arch/arm64/Makefile              |   2 +-
 arch/arm64/include/asm/ftrace.h  |  10 +-
 arch/arm64/include/asm/insn.h    |   6 +
 arch/arm64/include/asm/module.h  |   9 +
 arch/arm64/kernel/entry-ftrace.S |  88 ++++++--
 arch/arm64/kernel/ftrace.c       | 366 ++++++++++++++++++++++++++++---
 arch/arm64/kernel/module-plts.c  |  50 +++++
 arch/arm64/lib/insn.c            |  49 +++++
 8 files changed, 532 insertions(+), 48 deletions(-)

-- 
2.25.1

