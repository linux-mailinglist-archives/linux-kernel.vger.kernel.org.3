Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4A5AB371
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiIBO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiIBO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B56141A12
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kiUBY9L9H1enuPzKP5b8g1QT9pTcpJ/p9g5AdHuOGVs=; b=CGSvGIdS7BzFlGPC66zM67Zsuy
        kJNdSIHdK9ZLcOaYZTpT6E3z703HT21C8Dat37616OGCJG3cZtmwPUDloeuiEmIB569JS1SHyEIHi
        MYz8jua+e4cZMkrg4hapyzRfhvuOxD9J22EOsXlvO4yWnsNp3SvAqklmFN3x0BoVSl6NYTE+/X94c
        xTPSwpQsrnjlIvkv3wh2JRO1BMkJN+HjuHu0g718UhTmlKIngZWrPkvVgd2JH5iiaXoLoYLYA8tgv
        JxTNyEh6RSQ5OEFBnfnBTuPTQY5ZWLuDJNNQdO3R9SsMhCa/qSguFEroBEU+l1Z8DINn+je5bPSPz
        bS/9PKfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77L-008g83-Mx; Fri, 02 Sep 2022 13:53:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1446E301BF2;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 65F492B1A6BC7; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130948.022127024@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:41 +0200
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
Subject: [PATCH v2 16/59] crypto: x86/serpent: Remove redundant alignments
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
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S |    2 --
 arch/x86/crypto/serpent-avx2-asm_64.S       |    2 --
 2 files changed, 4 deletions(-)

--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk8_
 	RET;
 SYM_FUNC_END(__serpent_enc_blk8_avx)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk16
 	RET;
 SYM_FUNC_END(__serpent_enc_blk16)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX


