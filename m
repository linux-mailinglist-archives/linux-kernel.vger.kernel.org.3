Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CD5AB39B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiIBObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiIBO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCE158199
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/Fb9zUxhEEbcmp5Brb1qrwIPV90iUAqtYDCEw6WSBXI=; b=hKiXy0u9hoSBZF8nc2DmAek7xT
        TEFVtr6iI17ckJ00gdUCFKOkzxud2RS2pcRnzx+7yRivbNAjWM9jEaIjPkzI2sYFPxL4RyBYyBgVU
        dHM8aIxF/6VZ6DDtvX1rsU4hdUf6X+XN9TLDCay5I+u9LOIDZcoMakow3Q4CzDCy6EftPPysqztP4
        aP6P5RmQ7VfzKVLHpab6CV6lJOkt5i8BV718IltoWTNNLqKNHPYkZ97oDVVzPJ/m0D5157rfAE+Nn
        S5Zok8o+Y5aNEW0O3IWboq7C53rBPnQek/Of8ePpXDZqaGz/S91hQ89ukinIHcdOlRQaFFFi3P+Kn
        P5aYbL3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77N-008g8V-6c; Fri, 02 Sep 2022 13:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35D4F302A1D;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 280222B8EF7FC; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.308238294@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:03 +0200
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
Subject: [PATCH v2 38/59] x86/Kconfig: Add CONFIG_CALL_THUNKS
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

In preparation for mitigating the Intel SKL RSB underflow issue in
software, add a new configuration symbol which allows to build the
required call thunk infrastructure conditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2432,6 +2432,13 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config HAVE_CALL_THUNKS
+	def_bool y
+	depends on RETHUNK && OBJTOOL
+
+config CALL_THUNKS
+	def_bool n
+
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
 	default y


