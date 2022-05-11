Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A7523153
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiEKLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEKLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:19:01 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0623712E7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:18:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VCw.72d_1652267933;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VCw.72d_1652267933)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 19:18:54 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, wangkefeng.wang@huawei.com, rppt@kernel.org,
        alex@ghiti.fr, twd2.me@gmail.com, david@redhat.com,
        seanjc@google.com, petr.pavlu@suse.com, atishp@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved memory
Date:   Wed, 11 May 2022 19:18:51 +0800
Message-Id: <20220511111851.559684-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
added IORESOURCE_BUSY flag for no-map reserved memory, this casued
devm_ioremap_resource() failed for the no-map reserved memory in subsequent
operations of related driver, so remove the IORESOURCE_BUSY flag.

The code to reproduce the issue,
dts:
	mem0: memory@a0000000 {
                reg = <0x0 0xa0000000 0 0x1000000>;
                no-map;
        };

	&test {
		status = "okay";
		memory-region = <&mem0>;
	};

code:
	np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
	ret = of_address_to_resource(np, 0, &r);
	base = devm_ioremap_resource(&pdev->dev, &r);
	// base = -EBUSY

Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
CC: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 834eb652a7b9..71f2966b1474 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -214,7 +214,7 @@ static void __init init_resources(void)
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
-			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+			res->flags = IORESOURCE_MEM;
 		} else {
 			res->name = "System RAM";
 			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-- 
2.17.1

