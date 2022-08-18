Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083259886C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiHRQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiHRQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3F474DC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E393B8221D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F1C43140;
        Thu, 18 Aug 2022 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660839250;
        bh=LklsORKu6eLoWSUy8Uv/91SX4T5e2aOeczaluthpBWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsLszNJ3f2L4nbyCqD+5T07lURvGYi6AVA/5VggLdyEV1znUd7o2KRiNvSKgubRPF
         nUOYJT7odSMOSfU7PwwLh8FLzhTn1ZiaGtsfyfbjc3ziYqk1Henxd0ayZ4MRhKwZXr
         LbyJH7Z2KbA8ImR+YhkLDQ2NLZk8v53CQRUtEGty3e98Nac8Cp6OblMaOj4Gdv+BYB
         Y6cO4/kxUgInyOR8eEmYSaijciZUak64MSmrapVdjQ0U5xW2RE9KJIqyIQ8d8RR/47
         pECRO4NzhNWnVIs3GxzYpkZKc2JmexHOwJ5TAL/7ynmPSXbtjCEsCqMcbs1Iaiwczw
         1yi9o5fJwAbhQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] x86/kvm: Fix "missing ENDBR" BUG for fastop functions
Date:   Thu, 18 Aug 2022 08:53:43 -0700
Message-Id: <0d4116f90e9d0c1b754bb90c585e6f0415a1c508.1660837839.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1660837839.git.jpoimboe@kernel.org>
References: <cover.1660837839.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following BUG was reported:

  traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
  ------------[ cut here ]------------
  kernel BUG at arch/x86/kernel/traps.c:253!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
   <TASK>
   asm_exc_control_protection+0x2b/0x30
  RIP: 0010:andw_ax_dx+0x0/0x10 [kvm]
  Code: c3 cc cc cc cc 0f 1f 44 00 00 66 0f 1f 00 48 19 d0 c3 cc cc cc
        cc 0f 1f 40 00 f3 0f 1e fa 20 d0 c3 cc cc cc cc 0f 1f 44 00 00
        <66> 0f 1f 00 66 21 d0 c3 cc cc cc cc 0f 1f 40 00 66 0f 1f 00 21
        d0

   ? andb_al_dl+0x10/0x10 [kvm]
   ? fastop+0x5d/0xa0 [kvm]
   x86_emulate_insn+0x822/0x1060 [kvm]
   x86_emulate_instruction+0x46f/0x750 [kvm]
   complete_emulated_mmio+0x216/0x2c0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x604/0x650 [kvm]
   kvm_vcpu_ioctl+0x2f4/0x6b0 [kvm]
   ? wake_up_q+0xa0/0xa0

The BUG occurred because the ENDBR in the andw_ax_dx() fastop function
had been incorrectly "sealed" (converted to a NOP) by apply_ibt_endbr().

Objtool marked it to be sealed because KVM has no compile-time
references to the function.  Instead KVM calculates its address at
runtime.

Prevent objtool from annotating fastop functions as sealable by creating
throwaway dummy compile-time references to the functions.

Fixes: 6649fa876da4 ("x86/ibt,kvm: Add ENDBR to fastops")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 205d566ebd72..f092c54d1a2f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -326,7 +326,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t" \
-	ASM_ENDBR
+	ASM_ENDBR \
+	IBT_NOSEAL(name)
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
-- 
2.37.2

