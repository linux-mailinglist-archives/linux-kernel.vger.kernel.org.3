Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493BE5AB3A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiIBOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiIBO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DD13F66
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=I2N57Nlq+w/EFdJFmxq8wOkT8KRRYqRZgwOlt/Ls3NU=; b=QjRVDgaoHYpUC28SmZJRPYSCLy
        SMBrXOg7vu9rL9QEBkuG8oq2cVrnE9hFLzi1NM3jHRuZDolKvjrMef8MzZhyL2//Kk3tSMjAUvfOH
        WJhE39IUWDgQ3ZsdCxW/A9ioev4BQmNXwUXAfqC1cPoKl8EDH+BnvsHmVYruCpjb3cBMOcgOwPoja
        93Fgb1jWv7M3kL6rdET+wBs1hsf+rrVCMS6td1x1RaCqT4BG4uKu3IE/wH944kBm8OBmaCXKpn/3A
        Lr0GDKz6Km82kS+yH/SOWFNLkHVHADVITYXr4HyRq2rGk4Qj7TLLrqxm3vP4Co+WXD3MJWRSaPEub
        b+MiHXUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77L-008g88-RI; Fri, 02 Sep 2022 13:53:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B1C6301C3D;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7C8FA2B8EF7E9; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130948.334367209@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 19/59] crypto: x86/sm[34]: Remove redundant alignments
References: <20220902130625.217071627@infradead.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

( this code couldn't seem to make up it's mind about what alignment it
  actually wanted, randomly mixing 8 and 16 bytes )

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/sm3-avx-asm_64.S        |    1 -
 arch/x86/crypto/sm4-aesni-avx-asm_64.S  |    7 -------
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S |    6 ------
 3 files changed, 14 deletions(-)

--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@ -327,7 +327,6 @@
  * void sm3_transform_avx(struct sm3_state *state,
  *                        const u8 *data, int nblocks);
  */
-.align 16
 SYM_FUNC_START(sm3_transform_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -139,13 +139,11 @@
 
 
 .text
-.align 16
 
 /*
  * void sm4_aesni_avx_crypt4(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -249,7 +247,6 @@ SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	RET;
 SYM_FUNC_END(sm4_aesni_avx_crypt4)
 
-.align 8
 SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -363,7 +360,6 @@ SYM_FUNC_END(__sm4_crypt_blk8)
  * void sm4_aesni_avx_crypt8(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_crypt8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -419,7 +415,6 @@ SYM_FUNC_END(sm4_aesni_avx_crypt8)
  * void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -494,7 +489,6 @@ SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8)
  * void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -544,7 +538,6 @@ SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8)
  * void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -153,9 +153,6 @@
 	.long 0xdeadbeef, 0xdeadbeef, 0xdeadbeef
 
 .text
-.align 16
-
-.align 8
 SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -281,7 +278,6 @@ SYM_FUNC_END(__sm4_crypt_blk16)
  * void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -394,7 +390,6 @@ SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk1
  * void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -448,7 +443,6 @@ SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk1
  * void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX


