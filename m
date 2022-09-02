Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600045AB36E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiIBO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiIBO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D23168A24
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9QYIh8jQSl50RNoTtByBwdectJ68tUz/IPDpIU6AK7o=; b=fh5xwzjEJoiHoArDYodXaKOPzB
        3sHrNANwxw02c12yHuEGSNj0GuQBLf47DWS/kZbi+z3i2j9K1omyFocuQAj+KW1qH410BvVUsAUpW
        NrF/Ju77aCcU42b7I6srN5zP7HVFGhFun1Mu6Hyk1erRokiLpUEPsty5b9GCpoNkDuFXWix75Mjqf
        Fvrax1CbdLynF7mZp5FeHzuqmQRImmrMWYLAXTYj14d2oYLBNmUkZ8+afY+lPA/c/eACDeRjRrKJn
        mGyyj6gryGI5tA0qs2WSOJGQ7FETL5+Ff8qiDet2Id0UWky530Nspuxgbo2JI9SyAhE8UF1J2KR9N
        UdiBA+rQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77L-008g7y-JF; Fri, 02 Sep 2022 13:53:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 084F330088D;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 492222B1A6BD1; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.396644686@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:35 +0200
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
Subject: [PATCH v2 10/59] x86/error_inject: Align function properly
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

From: Peter Zijlstra <peterz@infradead.org>

Ensure inline asm functions are consistently aligned with compiler
generated and SYM_FUNC_START*() functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/error-inject.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -11,6 +11,7 @@ asm(
 	".text\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
+	ASM_FUNC_ALIGN
 	"just_return_func:\n"
 		ANNOTATE_NOENDBR
 		ASM_RET


