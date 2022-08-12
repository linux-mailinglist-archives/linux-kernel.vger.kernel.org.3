Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2F5909CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiHLBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:22:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62916642D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:22:10 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M3m6S5yJtzlW89;
        Fri, 12 Aug 2022 09:19:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 09:22:08 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 09:22:08 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] ARM: Make the dumped instructions are consistent with the disassembled ones
Date:   Fri, 12 Aug 2022 09:21:38 +0800
Message-ID: <20220812012138.1782-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ARM, the mapping of instruction memory is always little-endian, except
some BE-32 supported ARM architectures. Such as ARMv7-R, its instruction
endianness may be BE-32. Of course, its data endianness will also be BE-32
mode. Due to two negatives make a positive, the instruction stored in the
register after reading is in little-endian format. But for the case of
BE-8, the instruction endianness is LE, the instruction stored in the
register after reading is in big-endian format, which is inconsistent
with the disassembled one.

For example:
The content of disassembly:
c0429ee8:       e3500000        cmp     r0, #0
c0429eec:       159f2044        ldrne   r2, [pc, #68]
c0429ef0:       108f2002        addne   r2, pc, r2
c0429ef4:       1882000a        stmne   r2, {r1, r3}
c0429ef8:       e7f000f0        udf     #0

The output of undefined instruction exception:
Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
... ...
Code: 000050e3 44209f15 02208f10 0a008218 (f000f0e7)

This inconveniences the checking of instructions. What's worse is that,
for somebody who don't know about this, might think the instructions are
all broken.

So, when CONFIG_CPU_ENDIAN_BE8=y, let's convert the instructions to
little-endian format before they are printed. The conversion result is
as follows:
Code: e3500000 159f2044 108f2002 1882000a (e7f000f0)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
KernelVersion: v5.19
 arch/arm/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 00006d268906088..1518a1f443ff866 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -193,6 +193,13 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 				bad = get_user(val, &((u32 *)addr)[i]);
 		}
 
+		if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE8)) {
+			if (thumb)
+				val = cpu_to_le16(val);
+			else
+				val = cpu_to_le32(val);
+		}
+
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
 					width, val);
-- 
2.25.1

