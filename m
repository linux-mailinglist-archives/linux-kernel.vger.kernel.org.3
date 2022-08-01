Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA860586309
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiHADWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbiHADWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:22:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D465A1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:22:47 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lx3Jd1FBJzjXfc;
        Mon,  1 Aug 2022 11:19:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 11:22:44 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 11:22:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] ARM: Remove the special printing format of pc and lr in __show_regs()
Date:   Mon, 1 Aug 2022 11:20:16 +0800
Message-ID: <20220801032016.1524-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, instruction pointers are printed in [<%08lx>] format to make
them more visible. However, it is not necessary in __show_regs() because
they have the prefix 'pc :' or 'lr :', and it is also inconsistent with
that of other registers, which causes misalignment.

Before:
pc : [<8019a48c>]    lr : [<8019a48c>]    psr: 60000013
sp : c0965f28  ip : 00000001  fp : 00000001
r10: be6052d8  r9 : 431bde82  r8 : d7b634db

After:
pc : 8019a46c  lr : 8019a46c  psr: 60000013
sp : c8a71f28  ip : 00000001  fp : 00000002
r10: 1ef6a458  r9 : 431bde82  r8 : d7b634db

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
KernelVersion: v5.19
 arch/arm/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 3d9cace63884013..3fb30d734c3568a 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -136,7 +136,7 @@ void __show_regs(struct pt_regs *regs)
 
 	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
 	printk("LR is at %pS\n", (void *)regs->ARM_lr);
-	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
+	printk("pc : %08lx  lr : %08lx  psr: %08lx\n",
 	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
 	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
 	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
-- 
2.25.1

