Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B2577256
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGPXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiGPXSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFE2409C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:49 -0700 (PDT)
Message-ID: <20220716230953.918740143@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/h0ZE3KOnMvzgiDFOYx6/4OXuRqRs3WRg7RaeD3nrMY=;
        b=A9iZ8Od0A9eYHT4eukFRfhAJ79PiHYnUG7+WTvD0VkBMWvNFZTTRtnJZnH1lTMZrTW+mso
        eyz+x3IkDHY1jPe8Sg8XnnIUnqOZhbWI+IAjQ2ytxiCZ5lmbXESygdD7QFuIxEXKHe9pau
        fcjWp3hBTqaNLJpE0cpeNpGD88ODnmrCOil9AXb1h/aWJSM2JGf4dHrq09ppgSP+Ls7xPg
        p+ohZTC9PqKDb6etzmMsYhXs1Gi6aFrePhZbYmauTsQGOyOAfvQN7CnaJxcvhwtKXfr5jo
        MG0ptkQJ/waBXBldXXXLjLG6F4YtUR7zasHR5quzAPUKfqHq5hi3erLOuNHMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/h0ZE3KOnMvzgiDFOYx6/4OXuRqRs3WRg7RaeD3nrMY=;
        b=aUPrudRtQHSyrbnyMPkrBQnTg0pB/OEBjtFWxlSDNsjncYJSExM7N8fNA5Ru2E92ORvC4A
        fM04bIPi4f46RvCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 21/38] x86/entry: Make some entry symbols global
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:43 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paranoid_entry(), error_entry() and xen_error_entry() have to be
exempted from call accounting by thunk patching because they are
before UNTRAIN_RET.

Expose them so they are available in the alternative code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,7 +326,8 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-SYM_CODE_START_LOCAL(xen_error_entry)
+SYM_CODE_START(xen_error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -904,7 +905,8 @@ SYM_CODE_END(xen_failsafe_callback)
  * R14 - old CR3
  * R15 - old SPEC_CTRL
  */
-SYM_CODE_START_LOCAL(paranoid_entry)
+SYM_CODE_START(paranoid_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -1039,7 +1041,8 @@ SYM_CODE_END(paranoid_exit)
 /*
  * Switch GS and CR3 if needed.
  */
-SYM_CODE_START_LOCAL(error_entry)
+SYM_CODE_START(error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 
 	PUSH_AND_CLEAR_REGS save_ret=1

