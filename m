Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337557A728
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiGSTTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiGSTTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7A5D5A7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE7A0B81CCF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B618C341CA;
        Tue, 19 Jul 2022 19:19:18 +0000 (UTC)
Date:   Tue, 19 Jul 2022 15:19:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] ftrace/x86: Remove jumps to ftrace_epilogue and
 simplify trampolines
Message-ID: <20220719151916.160ee4a2@gandalf.local.home>
In-Reply-To: <20220719103201.38cb994c@gandalf.local.home>
References: <20220719103201.38cb994c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 10:32:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 5b4efc927d80..7225ccca94b9 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -301,8 +301,6 @@ union ftrace_op_code_union {
>  	} __attribute__((packed));
>  };
>  
> -#define RET_SIZE		1 + IS_ENABLED(CONFIG_SLS)
> -
>  static unsigned long
>  create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  {
> @@ -319,7 +317,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	void *ip;
>  	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
>  	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
> -	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
>  	union ftrace_op_code_union op_ptr;
>  	int ret;
>  
> @@ -341,14 +338,14 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  
>  	/*
>  	 * Allocate enough size to store the ftrace_caller code,
> -	 * the iret , as well as the address of the ftrace_ops this
> -	 * trampoline is used for.
> +	 * as well as the address of the ftrace_ops this trampoline
> +	 * is used for.
>  	 */
> -	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
> +	trampoline = alloc_tramp(size + sizeof(void *));
>  	if (!trampoline)
>  		return 0;
>  

Bah, I didn't realize that Linus already applied the retbleed patches. The
above conflicts.

I'll rebase it and send out a v3.

-- Steve
