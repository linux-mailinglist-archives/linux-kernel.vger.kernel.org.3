Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7774BBE12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiBRRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiBRRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29024C78A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cLs5KwDBeXI4YaK2Xyaf/MdILlBcETZiDFFGNwB8et0=; b=R2suKUv3sInwTfAwzo2rVF7yik
        DNxMroDw+EnwocNFNGwDgOczTatcKEZP7mmcxl0ctMb0MJ70uK5QmSgBvBq7G77lQBba16b4+jHKG
        F3BZdAEzHjNACldznDRdhdQkaIuIplc3rmfRGShYl1/1360aTHtBRtTPQtxh3AyICAtsSHq2nsnt3
        HWpDZKbocUdE0/zfcBureATCTbFYJJQjJj7wKnrpI5jB1FbTOx5Q4Wv7S/LRNQNuBlf8CcxwPG+43
        50GrWBn66tpx7/NSJNeRYJSe+xttUOUtpb1CYmzeGtgFQuN8Hs3s8k3PwdrjVHzMG3FXHhDDSyb3q
        pvPkMZ+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qB-00AsBn-2U; Fri, 18 Feb 2022 17:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7054302A1E;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69BE72B09FA68; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.990016403@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 24/29] x86/text-patching: Make text_gen_insn() IBT aware
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we don't generate direct JMP/CALL instructions to an ENDBR
instruction (which might be poison).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <asm/ptrace.h>
+#include <asm/ibt.h>
 
 struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
@@ -101,6 +102,11 @@ void *text_gen_insn(u8 opcode, const voi
 	static union text_poke_insn insn; /* per instance */
 	int size = text_opcode_size(opcode);
 
+#ifdef CONFIG_X86_IBT
+	if (is_endbr(dest))
+		dest += 4;
+#endif
+
 	insn.opcode = opcode;
 
 	if (size > 1) {


