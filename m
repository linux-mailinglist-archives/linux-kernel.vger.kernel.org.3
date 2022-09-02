Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6B5AB390
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiIBOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiIBO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB51581A0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SRnNkt6hDAocphBeeJEDz/2BjTiGPSIHa9g4nx269kU=; b=W9YsMVXO3ZSwz6cwrIMHRc5R+H
        pAPx70Q9qxyZ4fHSzemN4QHmvkXMfcQL6Pd4mRJnWXEb08hmQzO4PFwU69vObFim3DrYxmYO5vD2s
        stA7RoiwHu2GeCsAzgQPTvI/Xy+WDViFH13I0vwsnolDFYCQsYLfSrOXxigfTMMLU4haPFxzf4puZ
        s3soTbw7D/RaFGQgaB3zcLWoqrXYBUnJD47l0B1u2AgHU/V07gmXXHLnW2TJ1ZP+kK7syF7J7pdW8
        DgaBgOZYOLYvEukw11aUvwv4E6h3dh7w98TnzwwK6+qf6Ls2fXnHMj0fblhbshti9zZF72nRLxzRP
        Vie5G/ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-008g8c-2B; Fri, 02 Sep 2022 13:54:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39EB2302ADB;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 45F262B8EFB4D; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.722045248@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:07 +0200
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
Subject: [PATCH v2 42/59] x86/entry: Make some entry symbols global
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

paranoid_entry(), error_entry() and xen_error_entry() have to be
exempted from call accounting by thunk patching because they are
before UNTRAIN_RET.

Expose them so they are available in the alternative code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -327,7 +327,8 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-SYM_CODE_START_LOCAL(xen_error_entry)
+SYM_CODE_START(xen_error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -906,7 +907,8 @@ SYM_CODE_END(xen_failsafe_callback)
  * R14 - old CR3
  * R15 - old SPEC_CTRL
  */
-SYM_CODE_START_LOCAL(paranoid_entry)
+SYM_CODE_START(paranoid_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -1041,7 +1043,8 @@ SYM_CODE_END(paranoid_exit)
 /*
  * Switch GS and CR3 if needed.
  */
-SYM_CODE_START_LOCAL(error_entry)
+SYM_CODE_START(error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 
 	PUSH_AND_CLEAR_REGS save_ret=1


