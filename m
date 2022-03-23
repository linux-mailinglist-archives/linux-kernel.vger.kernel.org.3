Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882764E5BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiCWXHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiCWXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:07:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93AE9027B;
        Wed, 23 Mar 2022 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rTqyapXJEPXdek0o+t1d69NBA3uFR+P099kAs8qNELA=; b=WAWLzaENlDd97FfBI3URKeLG3e
        ULc78LIKp6yx69ECyiYOH4cjLzIsm6W5K0KIj1D7cxGqZo+59pfCEoJbFTk68RQRgI7UvB42qenGJ
        WUro0wAMFuXMKGaqYNi5px2CXUN+M0caU8D7v6zZGLTx4Zm/EscOspCRvwFOlbuwpMeiYbjKbuoDS
        Yg02JBMYkY/UZaOIe9qLNOOwCaTAFAGQVDr5EfAGAOa6wlYXnW9asjUiCXibhf/DI41YF4lnSFnhn
        /GTUBXD2377lGuDaMmYbK0eV4MtUFfJeSnd98DWrhYhZCJA38qCIswKO3XBkqCbG0VXHOfu+CkmCi
        jCzt+nNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXA3C-00Cv4m-06; Wed, 23 Mar 2022 23:05:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A60C4986200; Thu, 24 Mar 2022 00:05:55 +0100 (CET)
Date:   Thu, 24 Mar 2022 00:05:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@google.com, herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 3/2] x86/poly1305: Fixup SLS
Message-ID: <20220323230555.GZ8939@worktop.programming.kicks-ass.net>
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


Due to being a perl generated asm file, it got missed by the mass
convertion script.

arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_init_x86_64()+0x3a: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_x86_64()+0xf2: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_x86_64()+0x37: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_block()+0x6d: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_init_avx()+0x1e8: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0x18a: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0xaf8: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_avx()+0x99: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x18a: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x776: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x18a: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x796: missing int3 after ret
arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x10bd: missing int3 after ret

Fixes: f94909ceb1ed ("x86: Prepare asm files for straight-line-speculation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
+++ b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
@@ -297,7 +297,7 @@ ___
 $code.=<<___;
 	mov	\$1,%eax
 .Lno_key:
-	ret
+	RET
 ___
 &end_function("poly1305_init_x86_64");
 
@@ -373,7 +373,7 @@ $code.=<<___;
 .cfi_adjust_cfa_offset	-48
 .Lno_data:
 .Lblocks_epilogue:
-	ret
+	RET
 .cfi_endproc
 ___
 &end_function("poly1305_blocks_x86_64");
@@ -399,7 +399,7 @@ $code.=<<___;
 	mov	%rax,0($mac)	# write result
 	mov	%rcx,8($mac)
 
-	ret
+	RET
 ___
 &end_function("poly1305_emit_x86_64");
 if ($avx) {
@@ -429,7 +429,7 @@ ___
 	&poly1305_iteration();
 $code.=<<___;
 	pop $ctx
-	ret
+	RET
 .size	__poly1305_block,.-__poly1305_block
 
 .type	__poly1305_init_avx,\@abi-omnipotent
@@ -594,7 +594,7 @@ $code.=<<___;
 
 	lea	-48-64($ctx),$ctx	# size [de-]optimization
 	pop %rbp
-	ret
+	RET
 .size	__poly1305_init_avx,.-__poly1305_init_avx
 ___
 
@@ -747,7 +747,7 @@ $code.=<<___;
 .cfi_restore	%rbp
 .Lno_data_avx:
 .Lblocks_avx_epilogue:
-	ret
+	RET
 .cfi_endproc
 
 .align	32
@@ -1452,7 +1452,7 @@ $code.=<<___	if (!$win64);
 ___
 $code.=<<___;
 	vzeroupper
-	ret
+	RET
 .cfi_endproc
 ___
 &end_function("poly1305_blocks_avx");
@@ -1508,7 +1508,7 @@ $code.=<<___;
 	mov	%rax,0($mac)	# write result
 	mov	%rcx,8($mac)
 
-	ret
+	RET
 ___
 &end_function("poly1305_emit_avx");
 
@@ -1675,7 +1675,7 @@ $code.=<<___;
 .cfi_restore 	%rbp
 .Lno_data_avx2$suffix:
 .Lblocks_avx2_epilogue$suffix:
-	ret
+	RET
 .cfi_endproc
 
 .align	32
@@ -2201,7 +2201,7 @@ $code.=<<___	if (!$win64);
 ___
 $code.=<<___;
 	vzeroupper
-	ret
+	RET
 .cfi_endproc
 ___
 if($avx > 2 && $avx512) {
@@ -2792,7 +2792,7 @@ $code.=<<___	if (!$win64);
 .cfi_def_cfa_register	%rsp
 ___
 $code.=<<___;
-	ret
+	RET
 .cfi_endproc
 ___
 
@@ -2893,7 +2893,7 @@ $code.=<<___	if ($flavour =~ /elf32/);
 ___
 $code.=<<___;
 	mov	\$1,%eax
-	ret
+	RET
 .size	poly1305_init_base2_44,.-poly1305_init_base2_44
 ___
 {
@@ -3010,7 +3010,7 @@ $code.=<<___;
 	jnz		.Lblocks_vpmadd52_4x
 
 .Lno_data_vpmadd52:
-	ret
+	RET
 .size	poly1305_blocks_vpmadd52,.-poly1305_blocks_vpmadd52
 ___
 }
@@ -3451,7 +3451,7 @@ $code.=<<___;
 	vzeroall
 
 .Lno_data_vpmadd52_4x:
-	ret
+	RET
 .size	poly1305_blocks_vpmadd52_4x,.-poly1305_blocks_vpmadd52_4x
 ___
 }
@@ -3824,7 +3824,7 @@ $code.=<<___;
 	vzeroall
 
 .Lno_data_vpmadd52_8x:
-	ret
+	RET
 .size	poly1305_blocks_vpmadd52_8x,.-poly1305_blocks_vpmadd52_8x
 ___
 }
@@ -3861,7 +3861,7 @@ $code.=<<___;
 	mov	%rax,0($mac)	# write result
 	mov	%rcx,8($mac)
 
-	ret
+	RET
 .size	poly1305_emit_base2_44,.-poly1305_emit_base2_44
 ___
 }	}	}
@@ -3916,7 +3916,7 @@ $code.=<<___;
 
 .Ldone_enc:
 	mov	$otp,%rax
-	ret
+	RET
 .size	xor128_encrypt_n_pad,.-xor128_encrypt_n_pad
 
 .globl	xor128_decrypt_n_pad
@@ -3967,7 +3967,7 @@ $code.=<<___;
 
 .Ldone_dec:
 	mov	$otp,%rax
-	ret
+	RET
 .size	xor128_decrypt_n_pad,.-xor128_decrypt_n_pad
 ___
 }
@@ -4109,7 +4109,7 @@ $code.=<<___;
 	pop	%rbx
 	pop	%rdi
 	pop	%rsi
-	ret
+	RET
 .size	avx_handler,.-avx_handler
 
 .section	.pdata
