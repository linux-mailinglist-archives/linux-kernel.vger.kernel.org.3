Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB44CBC96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiCCLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiCCLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469B1795D4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=N852q9aWEiK0I+Tjg4v4NRP8lVB+Lypx5hQ0mJxyRSo=; b=Natgi1cpc+CeIwbllRxYMLcq24
        uPs9h6Bhmv34lxQVFKJPJjfwFke59Xj47zuA7+sd2qmgMHjXB/8zy93bnreuawQp6ZUV8/R1RG5bY
        oNYw54bUyEVOdxfa5ouLl1/V5hAzftAMjfxUUQ2lvbIzixPpLI6d0XSoSFuBEETJbsteI8sH8Fx8n
        wKO6XXrUUbzPsKTJooROSJQ6MkxOZSueyUlr2yRxlIAj7fMxoP7v6Nq6AXn5WMiWHa9v8WHwKiSC6
        pVcEBxx62Ka+UU7xjvEmJkGdVetqwdNjUFnYbrSEVGoAeekrNeL8EDFsXSP3RW9H7veFAahM/VT1v
        6rxca0UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00Etpa-VQ; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F04D93021AE;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 505183002B44C; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.864704778@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 15/39] x86/ibt,kvm: Add ENDBR to fastops
References: <20220303112321.422525803@infradead.org>
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -189,7 +189,7 @@
 #define X16(x...) X8(x), X8(x)
 
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
-#define FASTOP_SIZE 8
+#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
 
 struct opcode {
 	u64 flags;
@@ -311,7 +311,8 @@ static int fastop(struct x86_emulate_ctx
 #define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
-	name ":\n\t"
+	name ":\n\t" \
+	ASM_ENDBR
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
@@ -433,6 +434,7 @@ static int fastop(struct x86_emulate_ctx
 	".align 4 \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
+	ASM_ENDBR \
 	#op " %al \n\t" \
 	__FOP_RET(#op)
 


