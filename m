Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72404574F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiGNNgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiGNNgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:36:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47350199;
        Thu, 14 Jul 2022 06:36:49 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657805807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUuV7gEmLufUpUosWh0vdx07cSvJv6Gwml73gCX5Z0U=;
        b=kolAvBmlwU5UEH2xz0GhvDBHFD2ezEyMwu3GTJnEEG5cMX30vvodsdA408y1KUS6oTOFLZ
        Ddbz4473DomEadrjOKQSytQohAXqSQqbTcXcEDBFZr2WtbuV8+DzOL3rMMWFyeQqs925Mn
        Q0rExRjlGeqmupFfLYBB0Lcb6Pz1/00E8Ciz3B8WXqjztO3Z/pKB2TVHHgl739iRniAS0/
        nIosiFPMzp2BCno7HDHFCp4PQq+Ag2mNTvHAMKxpJXtQqCBRbeSNKpm8ktHacBSDrTYscr
        l9HVUmHRIDkvO7gAJGR578040KQ7rlhPIWlWwKY1k2ObLHi+fxGxGdphjPe/jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657805807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUuV7gEmLufUpUosWh0vdx07cSvJv6Gwml73gCX5Z0U=;
        b=+hekk2v96XZsGGR/BdQnq8xXOEMGOXXFUFtdnDGfz4ldl60zTJxtu9kFJ76hWrC1lQ4AqM
        SGrgAoyczapKMIAg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/speculation: Use DECLARE_PER_CPU for
 x86_spec_ctrl_current
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713152436.2294819-1-nathan@kernel.org>
References: <20220713152436.2294819-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <165780580628.15455.7953753659675037331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     db866d3352ec85e821e730e191481cba3a2bfa6e
Gitweb:        https://git.kernel.org/tip/db866d3352ec85e821e730e191481cba3a2bfa6e
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 13 Jul 2022 08:24:37 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jul 2022 13:40:21 +02:00

x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current

Clang warns:

  arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
  DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
                      ^
  arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
  extern u64 x86_spec_ctrl_current;
             ^
  1 error generated.

The declaration should be using DECLARE_PER_CPU instead so all
attributes stay in sync.

Fixes: fc02735b14ff ("KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20220713152436.2294819-1-nathan@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bb05ed4..10a3bfc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -11,6 +11,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
+#include <asm/percpu.h>
 
 #define RETPOLINE_THUNK_SIZE	32
 
@@ -280,7 +281,7 @@ static inline void indirect_branch_prediction_barrier(void)
 
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
-extern u64 x86_spec_ctrl_current;
+DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
 extern void write_spec_ctrl_current(u64 val, bool force);
 extern u64 spec_ctrl_current(void);
 
