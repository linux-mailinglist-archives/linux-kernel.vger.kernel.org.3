Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7452931A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349461AbiEPVpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiEPVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76742480
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38331B8167B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAE0C385AA;
        Mon, 16 May 2022 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652737536;
        bh=zN3GIOBzpH9pP/0yJi427+Aqc4nfKhALIaFtl/JNTRk=;
        h=From:To:Cc:Subject:Date:From;
        b=XqKxUKFIyW+1J/94sZx+Odzy1zf2mUD0dzXHCf8ffIvqHa1PaH2dhf49DUuHUN5Vv
         gZNKY5J3iL5GBlQeqPhZmc2Mk/KQKezdvJIgklIoe120fEX7N6HLxY3ZElR4NVEqfV
         FIVWSPBSgu5MilkLHcSyGSZ98LWzKNR4pTicIQKBEDxC3VapGY94HaYmH8mc7eXIHq
         wTevjZA0MKX5Ge1eXtWpzIMwOqyjkGuwO0huwXyyJVJan8cI7Lc0mBFdmZYv4/nVtJ
         C+WXue543uBp8bbEkcxk6xGe1W10D4ZsnBRr28tMcGb05ghtRmrr7Zi4vfsCrz/imE
         ZztMr31JfR2zg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: Move alternative length validation into subsection
Date:   Mon, 16 May 2022 14:45:21 -0700
Message-Id: <20220516214520.3252074-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 49b290e430d3 ("riscv: prevent compressed instructions in
alternatives"), builds with LLVM's integrated assembler fail:

  In file included from arch/riscv/mm/init.c:10:
  In file included from ./include/linux/mm.h:29:
  In file included from ./include/linux/pgtable.h:6:
  In file included from ./arch/riscv/include/asm/pgtable.h:108:
  ./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
          ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
          ^
  ./arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
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
  ./arch/riscv/include/asm/alternative-macros.h:99:3: note: expanded from macro 'ALT_NEW_CONTENT'
          ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
           ^
  <inline asm>:26:6: note: instantiated into assembly here
  .org    . - (889b - 888b) + (887b - 886b)
          ^

This error happens because LLVM's integrated assembler has a one-pass
design, which means it cannot figure out the instruction lengths when
the .org directive is outside of the subsection that contains the
instructions, which was changed by the .option directives added by the
above change.

Move the .org directives before the .previous directive so that these
directives are always within the same subsection, which resolves the
failures and does not introduce any new issues with GNU as. This was
done for arm64 in commit 966a0acce2fc ("arm64/alternatives: move length
validation inside the subsection") and commit 22315a2296f4 ("arm64:
alternatives: Move length validation in alternative_{insn, endif}").

While there is no error from the assembly versions of the macro, they
appear to have the same problem so just make the same change there as
well so that there are no problems in the future.

Link: https://github.com/ClangBuiltLinux/linux/issues/1640
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/include/asm/alternative-macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index e13b1f6bb400..ec2f3f1b836f 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -27,9 +27,9 @@
 	\new_c
 	.option pop
 889 :
-	.previous
 	.org    . - (889b - 888b) + (887b - 886b)
 	.org    . - (887b - 886b) + (889b - 888b)
+	.previous
 	.endif
 .endm
 
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

base-commit: 93c0651617a62a69717299f1464dda798af8bebb
-- 
2.36.1

