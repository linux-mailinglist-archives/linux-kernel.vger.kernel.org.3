Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B557725B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiGPXSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiGPXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123AA23BCD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:34 -0700 (PDT)
Message-ID: <20220716230953.500517388@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QqAiRodBnzoFq0Uv7yhac721jXiH8ElvZylHXExmCIo=;
        b=rc1Ng1Bc0mSzCZ/ImhA9uf8toqbfvxb+B6ftlfcWG2JyuRJudFt2g7sSsCzqjtYkEj14DI
        QPvFMvBcJb6wRR9dqB9aD2kkVIg5F5z9es74kovLN9hxHidtN5xAH9bmqFnm6X4hHfMaHe
        GyyETPaiceyyDHB1Evwmp4Qyc4aHqJqIINX5CrbDAArAGTNzkzyAwKZIdF+6KRcCC7a4MP
        AMHMu/jbLzNJAuQJVaQxOZB3TTeX8yCJTzCewDNIrG+X2ndUPEPKOg65QPP4Idi8ZBdtJE
        AFdrioCjAKEUF1y2Ccxcg22gBstUtfw4QMup4ftqKotH9l/IOiBKUsOqzUMNyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QqAiRodBnzoFq0Uv7yhac721jXiH8ElvZylHXExmCIo=;
        b=h3EmeZaBUFDKVEHqcnwlhn/N/0VIM4S+ifGV9IOeuhi+KU5NpQAvw512pb2glCrTBLzpD9
        g7STLvCrOC9Cz0Aw==
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
Subject: [patch 14/38] x86/Kconfig: Add CONFIG_CALL_THUNKS
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:32 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for mitigating the Intel SKL RSB underflow issue in
software, add a new configuration symbol which allows to build the
required call thunk infrastructure conditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,6 +2439,14 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config HAVE_CALL_THUNKS
+	def_bool y
+	depends on RETHUNK && OBJTOOL
+
+config CALL_THUNKS
+	def_bool n
+	select MODULE_ALLOC
+
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
 	default y

