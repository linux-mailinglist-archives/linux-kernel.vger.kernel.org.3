Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F9577253
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiGPXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiGPXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791023BD3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:05 -0700 (PDT)
Message-ID: <20220716230954.470918864@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QMc5vSkp40P2d+jY5LFr071gTHJY7fEdf/VlKzlHVVI=;
        b=4IQkCHfHf1/mvq1CUwZOV29fe86HDSfLQZ37SslVG18eluh8arFjSxoTnb+67JsQMGTeUE
        KGWIWof9HQ39phxWZnGnw2NQyOxYBzQ2NHjKfSuyo8umK2clI/NVdzRmL2I1MqQBiOPrzU
        EupHbjkDsrwgWL9Vfxui9R0d5Ho6xFsLirL56eUQ9NSAgN61MlzEJ/VNA40J6mySlfWNbp
        pULWGP1xlBMIk+kcNWy/3fGoSYlBfyDDCiDBaJyohgxynyi2+KhdfbZwjhY4vJA/rsH3PB
        7DJb4CXVG3YZ0ISGjCzd9p6L7zsKoWtgprylHb/t/VOecwnteS8lXPrQNMtKhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QMc5vSkp40P2d+jY5LFr071gTHJY7fEdf/VlKzlHVVI=;
        b=XidcQsbkLQgs93ZB2oKlm16rt5MV1bnkdHJyGP+ENcy5BQohTo3yPonBQfZJP9LapjLZRh
        ZqlBqe7f36ewhfAw==
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
Subject: [patch 30/38] x86/retbleed: Add SKL call thunk
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the actual SKL call thunk for call depth accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/callthunks.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -52,6 +52,24 @@ struct thunk_desc {
 
 static struct thunk_desc callthunk_desc __ro_after_init;
 
+asm (
+	".pushsection .rodata				\n"
+	".global skl_call_thunk_template		\n"
+	"skl_call_thunk_template:			\n"
+		__stringify(INCREMENT_CALL_DEPTH)"	\n"
+	".global skl_call_thunk_tail			\n"
+	"skl_call_thunk_tail:				\n"
+	".popsection					\n"
+);
+
+extern u8 skl_call_thunk_template[];
+extern u8 skl_call_thunk_tail[];
+
+#define SKL_TMPL_SIZE \
+	((unsigned int)(skl_call_thunk_tail - skl_call_thunk_template))
+#define SKL_CALLTHUNK_CODE_SIZE	(SKL_TMPL_SIZE + JMP32_INSN_SIZE + INT3_INSN_SIZE)
+#define SKL_CALLTHUNK_SIZE	roundup_pow_of_two(SKL_CALLTHUNK_CODE_SIZE)
+
 struct thunk_mem {
 	void			*base;
 	unsigned int		size;
@@ -447,6 +465,12 @@ static __init noinline void callthunks_i
 {
 	int ret;
 
+	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
+		callthunk_desc.template = skl_call_thunk_template;
+		callthunk_desc.template_size = SKL_TMPL_SIZE;
+		callthunk_desc.thunk_size = SKL_CALLTHUNK_SIZE;
+	}
+
 	if (!callthunk_desc.template)
 		return;
 

