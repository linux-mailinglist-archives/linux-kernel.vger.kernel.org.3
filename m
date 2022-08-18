Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6873598FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbiHRVjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiHRVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E8719B6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AA36157D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99F7C433D6;
        Thu, 18 Aug 2022 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660858770;
        bh=M6x0irxxuJwNXw2fUJWnaMeJqqXhC2RpPVqJabLbJk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWAiowo7vjX9mhqZ5Yp2Kjauc+3N8bUQuzmO68pd3qY0dD9eEsLqaR3Jwu/GoEUcR
         6TnscElrxAM3rEDsvWd/fg9DLvGSzhlJCwygWAO2Dsz5ZQjm2uBAD2VyaZ0U1tIzo3
         QuFQucfjLW/eNXp02SRHNARhVzOJ6J911KJvl3AQbLKLxYnFLyhg1tTyAsaEEF7I+r
         I8/Lh5wvmEIt/Mitya36UHA2Z2Au450bEa2+XCvzYvUOXvK47+OuzUySCijTAVwp10
         avVVKxfJKlAbg8k6JCUBvebXIpJobGrUMselncxhPV82SdLVV7K2P6BYxo9jZkSEgw
         tHw92Hn0Z5GkA==
Date:   Thu, 18 Aug 2022 14:39:27 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1.1] x86/ibt, objtool: Add IBT_NOSEAL()
Message-ID: <20220818213927.e44fmxkoq4yj6ybn@treble>
References: <cover.1660837839.git.jpoimboe@kernel.org>
 <5b86c2e3fff1f1e1f3fda126c315819205eb9d20.1660837839.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b86c2e3fff1f1e1f3fda126c315819205eb9d20.1660837839.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro which prevents a function from getting sealed if there are
no compile-time references to it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
v1.1:
- add empty IBT_NOSEAL for CONFIG_X86_KERNEL_IBT=n

 arch/x86/include/asm/ibt.h | 11 +++++++++++
 tools/objtool/check.c      |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880eca9ba..9b08082a5d9f 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -31,6 +31,16 @@
 
 #define __noendbr	__attribute__((nocf_check))
 
+/*
+ * Create a dummy function pointer reference to prevent objtool from marking
+ * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
+ * apply_ibt_endbr()).
+ */
+#define IBT_NOSEAL(fname)				\
+	".pushsection .discard.ibt_endbr_noseal\n\t"	\
+	_ASM_PTR fname "\n\t"				\
+	".popsection\n\t"
+
 static inline __attribute_const__ u32 gen_endbr(void)
 {
 	u32 endbr;
@@ -84,6 +94,7 @@ extern __noendbr void ibt_restore(u64 save);
 #ifndef __ASSEMBLY__
 
 #define ASM_ENDBR
+#define IBT_NOSEAL(name)
 
 #define __noendbr
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..91678252a9b6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4096,7 +4096,8 @@ static int validate_ibt(struct objtool_file *file)
 		 * These sections can reference text addresses, but not with
 		 * the intent to indirect branch to them.
 		 */
-		if (!strncmp(sec->name, ".discard", 8)			||
+		if ((!strncmp(sec->name, ".discard", 8) &&
+		     strcmp(sec->name, ".discard.ibt_endbr_noseal"))	||
 		    !strncmp(sec->name, ".debug", 6)			||
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
-- 
2.37.2

