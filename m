Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42E59886E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiHRQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbiHRQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0747BAD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BA24CE20F3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A0DC433B5;
        Thu, 18 Aug 2022 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660839249;
        bh=0FaXdO6sfrfgK53welgzflSejRlsGfs8OGtOLtKDMz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhNc45uJMrV6S7gd1FopprJA05XudQLG2G5s/XB6w3LkY3IxBODFOrYsu9UqDgoxt
         atm4CEV2fSvMZJrIId7PZRCe/ytuALSHLoQ1SNJcK5IWIRkcXwqNFre0/9VXVyG0i6
         AVHJuyCuYCTIl9crabfilmE2/f19tymrYYFgaekJnRmVNHQko90YIkGTVtX5sYdCCE
         S0CJGg560JUpCLSeb9+ll2iHdAzb03vJybKOQND2PmsM2wEC8nzwW0bpH2g3vhYRCO
         K2KtIW1BRICwPyai9/qNMxb9CFSAmng3dtGXHwXc73o9GPOpnWur4MMijSXQmR643a
         BRIvCP7Fal5Zw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] x86/ibt, objtool: Add IBT_NOSEAL()
Date:   Thu, 18 Aug 2022 08:53:41 -0700
Message-Id: <5b86c2e3fff1f1e1f3fda126c315819205eb9d20.1660837839.git.jpoimboe@kernel.org>
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

Add a macro which prevents a function from getting sealed if there are
no compile-time references to it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/ibt.h | 10 ++++++++++
 tools/objtool/check.c      |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880eca9ba..372e8eee6e02 100644
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

