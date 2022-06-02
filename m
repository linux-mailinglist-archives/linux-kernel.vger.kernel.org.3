Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEA53B7C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiFBL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiFBL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:27:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BD1AF12
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:27:44 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LDNxz0M3PzjXBp;
        Thu,  2 Jun 2022 19:26:31 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 19:27:41 +0800
Date:   Thu, 2 Jun 2022 19:27:34 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <changbin.du@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: riscv: alternatives: move length validation inside the subsection
Message-ID: <20220602112734.it2bzlqaismotjof@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Apply the same fix from commit 966a0acce2fc ("arm64/alternatives: move
length validation inside the subsection") to riscv.  Due to the one-pass
design of LLVM's integrated assembler, it can not compute the length of
instructions if the .org directive is outside of the subsection that these
instructions are in.

Here is the build error reported by llvm:

In file included from ./arch/riscv/include/asm/pgtable.h:108:
./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
        ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
        ^
./arch/riscv/include/asm/errata_list.h:41:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
    ^
./arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
        _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
        ^
./arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
        __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
        ^
./arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
        ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
        ^
./arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
        ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         ^
<inline asm>:25:6: note: instantiated into assembly here
.org    . - (887b - 886b) + (889b - 888b)
        ^

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/include/asm/alternative-macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index e13b1f6bb400..c7d7f1945768 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -94,9 +94,9 @@
 	new_c "\n"							\
 	".option pop\n"							\
 	"889 :\n"							\
-	".previous\n"							\
 	".org	. - (887b - 886b) + (889b - 888b)\n"			\
 	".org	. - (889b - 888b) + (887b - 886b)\n"			\
+	".previous\n"							\
 	".endif\n"
 
 #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
-- 
2.26.2

