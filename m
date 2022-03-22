Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F24E3CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCVKsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiCVKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:48:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3282D09;
        Tue, 22 Mar 2022 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rPfgvhMPQ8dVRipxfd44pwo2B57Mkhi1IcMui1XtQAc=; b=RrmAjBu0pazgrhak5SiNwzd42D
        VzTuoBywbx3av/+nL/d8xZavTYmbkOcLxNupCGZTTHLTS6/uzpCn8nXlsnyUKu60FVotTt1+788I1
        SPfMBbnuziHSu4GNoyMYf7N15OQv19btp21YXvjRIMX/H0avK1kzlybFtHuBe19B77Pr96G/90CYl
        r3lL3HcF6ydKqIctPE++zBmhyHyxzWqLPRRvXlbpuZeYqen3YPUz/KPPpSzINba7gQJUWp53b3G7j
        nY9ZDnxYDbUGTRuSgOprMd0xxppfSSMumdKsAFa3JaQ2Gsf8QqQ19YwXmp9nyllMFiu6U1K0Pcf+z
        IpiY1gbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWc1f-00BVrA-Vm; Tue, 22 Mar 2022 10:46:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E3553001CD;
        Tue, 22 Mar 2022 11:46:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1B162C7D1E6F; Tue, 22 Mar 2022 11:46:04 +0100 (CET)
Date:   Tue, 22 Mar 2022 11:46:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-crypto@vger.kernel.org, ebiggers@google.com,
        herbert@gondor.apana.org.au, Jason@zx2c4.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjmo7KDlfR537J0W@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:

> > [ Note I was already getting these:
> > arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()
> > arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()
> > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx() falls through to next function poly1305_blocks_x86_64()
> > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() falls through to next function poly1305_emit_x86_64()
> > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2() falls through to next function poly1305_blocks_x86_64()
> 
> Yes, those are somewhere on the todo list, lemme bump them.

So the chacha one seems relatively simple, see below.

---
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/crypto/chacha-avx512vl-x86_64.S
index 946f74dd6fba..259383e1ad44 100644
--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -172,7 +172,7 @@ SYM_FUNC_START(chacha_2block_xor_avx512vl)
 	# xor remaining bytes from partial register into output
 	mov		%rcx,%rax
 	and		$0xf,%rcx
-	jz		.Ldone8
+	jz		.Ldone2
 	mov		%rax,%r9
 	and		$~0xf,%r9
 
@@ -438,7 +438,7 @@ SYM_FUNC_START(chacha_4block_xor_avx512vl)
 	# xor remaining bytes from partial register into output
 	mov		%rcx,%rax
 	and		$0xf,%rcx
-	jz		.Ldone8
+	jz		.Ldone4
 	mov		%rax,%r9
 	and		$~0xf,%r9
 
