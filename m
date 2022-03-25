Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8D4E737C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbiCYMcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiCYMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:32:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E3D0817;
        Fri, 25 Mar 2022 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YcSVVivNSS6HKwFtzFw9OEfDniOM+I9GJAUb7FZ1W4A=; b=fxduNBYyWHO7Q1Uha+uM3IlStL
        lTG/7c1EFPnG0OYn5uQ6TJEuaizhCeLP5adQrm26TsmRP7uZPScATVueABjnfn2sg0ocQO1wkR6IA
        e9YxSGZrMvzUu4XZCoJPfekTLsjnlLYiivJD6F9XYR4NEWARiqVKLGG3DBf8CuV+wj6CoDVrdiuo8
        LoqIB+iwnrCoERz0M9v0HOK9Zl0kfsMHIEdoqT3GKx8NBFheOqDyqR5G1ZF//Aekrl0P/sjJD0FYv
        vPprZhs55FC4NtDE+I6pHZQT4wKMkIFjjDNeio2ub3qLZFqIvqLMIzD2iXlBDAK5qFxnqBAWcwO77
        F6rD3BUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXj5c-00EM6s-F7; Fri, 25 Mar 2022 12:30:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13483987D26; Fri, 25 Mar 2022 13:30:48 +0100 (CET)
Date:   Fri, 25 Mar 2022 13:30:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@google.com, herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 5/2] x86/sm3: Fixup SLS
Message-ID: <20220325123047.GR8939@worktop.programming.kicks-ass.net>
References: <20220322114809.381992456@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322114809.381992456@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This missed the big asm update due to being merged through the crypto
tree.

Fixes: f94909ceb1ed ("x86: Prepare asm files for straight-line-speculation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/sm3-avx-asm_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@ -513,5 +513,5 @@ SYM_FUNC_START(sm3_transform_avx)
 
 	movq %rbp, %rsp;
 	popq %rbp;
-	ret;
+	RET;
 SYM_FUNC_END(sm3_transform_avx)
