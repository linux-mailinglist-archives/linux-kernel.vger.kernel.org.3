Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4235AB380
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiIBO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiIBO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6E141A1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BJHqXamgAJqTcT2FFMKxQyrqmVcujF7M2+0CHXkEhUI=; b=H5hU9sfBcD7OUyu4swO7EK/OTZ
        MmGmNZef0mMHGjyQq8bgUPvguOphKna5I1Hw1FlXrFgP+EA3wQXJKyrUCNhyLfCdgW8oS+QXIqd0x
        DhvuaRO98BdPJYnC0Ln68CNn8w39QW4ES0XmD5+hhh1XJTLoGtPvTVnsAEWUEbWL5HJY7WdQrHnL8
        HYh4m7LkOW6z/VoylyEZiNBPPHmYCbjLoRt3IsoOUlHBj6NI+8Rw//OZKvj9HsI8Z1Mmp7FRQTOHm
        mTeMYNpOoiOzUCMAlur2oAWSN5u0kfts3ENZIYvxLLRqxAjFKh6k1g0Rgr4xOxVAwBWD0l48CBAYY
        NoHy5w7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-0074T9-TV; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 128AC301BCC;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57F1F2B077D29; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.709764677@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:38 +0200
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
Subject: [PATCH v2 13/59] crypto: x86/camellia: Remove redundant alignments
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |    2 --
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |    4 ----
 2 files changed, 6 deletions(-)

--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -712,7 +712,6 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1
 
 .text
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -799,7 +798,6 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk1
 	jmp .Lenc_done;
 SYM_FUNC_END(__camellia_enc_blk16)
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -221,7 +221,6 @@
  * Size optimization... with inlined roundsm32 binary would be over 5 times
  * larger and would only marginally faster.
  */
-.align 8
 SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm32(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %ymm5, %ymm6, %ymm7,
 		  %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14, %ymm15,
@@ -229,7 +228,6 @@ SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_
 	RET;
 SYM_FUNC_END(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
-.align 8
 SYM_FUNC_START_LOCAL(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm32(%ymm4, %ymm5, %ymm6, %ymm7, %ymm0, %ymm1, %ymm2, %ymm3,
 		  %ymm12, %ymm13, %ymm14, %ymm15, %ymm8, %ymm9, %ymm10, %ymm11,
@@ -748,7 +746,6 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1
 
 .text
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -835,7 +832,6 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk3
 	jmp .Lenc_done;
 SYM_FUNC_END(__camellia_enc_blk32)
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX


