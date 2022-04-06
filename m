Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218EA4F6B88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiDFUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiDFUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:44:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C873B1229
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:00:47 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864671EC0541;
        Wed,  6 Apr 2022 21:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649271641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nVtR34tb07UE9Vh8kqXmqxis7soj7DeR1fabMcehfKk=;
        b=O4BAWDQjL0fuQD7LGSfPrQ7Vcwh5qc7yVk0HEDaOp8DDjECmIDCb7wN2F0uHncwqEdSRZg
        +FNqqVNo838Fkvo8yhXXlIjclP/zVl1XgyCn4nzdsWefi45aG8MO289TFtQ2oWZn64n8al
        kvoZSBNYSdLfn7CWQFljegiUmmcKTBE=
Date:   Wed, 6 Apr 2022 21:00:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Message-ID: <Yk3jVrXoVpxuR0Mp@zn.tnic>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318143016.124387-2-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:30:10PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> fixup_bad_iret() and sync_regs() have similar arguments and do similar
> work that copies full or partial pt_regs to a place and switches stack
> after return.  They are quite the same, but fixup_bad_iret() not only
> copies the pt_regs but also the return address of error_entry() while

What return address of error_entry()? You lost me here.

fixup_bad_iret() moves the stack frame while sync_regs() switches to the
thread stack. I have no clue what you mean.

> sync_regs() copies the pt_regs only and the return address of
> error_entry() was preserved and handled in ASM code.

Nope, no idea.
 
> This patch makes fixup_bad_iret() work like sync_regs() and the

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> handling of the return address of error_entry() is moved in ASM code.
> 
> It removes the need to use the struct bad_iret_stack, simplifies
> fixup_bad_iret() and makes the ASM error_entry() call fixup_bad_iret()
> as the same as calling sync_regs() which adds readability because
> the calling patterns are exactly the same.

So fixup_bad_iret() gets the stack ptr passed in by doing:

        mov     %rsp, %rdi
        call    fixup_bad_iret
        mov     %rax, %rsp


and error_regs()

        movq    %rsp, %rdi                      /* arg0 = pt_regs pointer */
        call    sync_regs
        movq    %rax, %rsp                      /* switch stack */

the same way.

Confused.

> It is prepared for later patch to do the stack switch after the
> error_entry() which simplifies the code further.

Looking at your next patch, is all this dance done just so that you can
do

	leaq    8(%rsp), %rdi

in order to pass in pt_regs to both functions?

And get rid of the saving/restoring %r12?

Is that what the whole noise is about?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
