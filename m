Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D264E4FB799
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiDKJiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbiDKJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:38:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841118E09
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:35:51 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B635D1EC0202;
        Mon, 11 Apr 2022 11:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649669745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dp/sapD21MQphPMg5mU8VYHpPyigsBxDBVw582cXjRM=;
        b=J4KPEqZ4M0IpJ2yF8qeWmE4+0VaQP7szyaWTmVb4Cc+VgRwqnSJ5EdEL1j34TOAVXxHfNy
        LvzjeUom0nOqIrT9NIGqt0nqbc4UqXKylVQxm+hB51EGa+W6P1W75zPEKwoe6Q2ZvH6p4b
        2na24OGdWUOH4mgbP4QSKTobSpbcdVc=
Date:   Mon, 11 Apr 2022 11:35:44 +0200
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V4 2/7] x86/entry: Switch the stack after error_entry()
 returns
Message-ID: <YlP2cH/MjxMXuX1W@zn.tnic>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318143016.124387-3-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:30:11PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> error_entry() calls sync_regs() to settle/copy the pt_regs and switches
> the stack directly after sync_regs().  But error_entry() itself is also
> a function call, the switching has to handle the return address of it
> together, which causes the work complicated and tangly.

together, which causes the work complicated and tangly 
Unknown word [tangly] in commit message.

Please restrain yourself when writing commit messages - they're not
write-only but actually for other people to read. It is not friendly to
reviewers to start inventing words and then make me decode your patch
twice:

- once the commit message

- and second time the code

Please use simple and trivial sentences.

> Switching to the stack after error_entry() makes the code simpler and
> intuitive.
> 
> The behavior/logic is unchanged:
>   1) (opt) feed fixup_bad_iret() with the pt_regs pushed by ASM code

opt?

>   2) (opt) fixup_bad_iret() moves the partial pt_regs up
>   3) feed sync_regs() with the pt_regs pushed by ASM code or returned
>      by fixup_bad_iret()
>   4) sync_regs() copies the whole pt_regs to kernel stack if needed
>   5) after error_entry() and switching %rsp, it is in kernel stack with
>      the pt_regs
> 
> Changes only in calling:
>   Old code switches to copied pt_regs immediately twice in
>   error_entry() while new code switches to the copied pt_regs only
>   once after error_entry() returns.
>   It is correct since sync_regs() doesn't need to be called close
>   to the pt_regs it handles.
> 
>   Old code stashes the return-address of error_entry() in a scratch
>   register and new code doesn't stash it.
>   It relies on the fact that fixup_bad_iret() and sync_regs() don't
>   corrupt the return-address of error_entry() on the stack.  But even
>   the old code also relies on the fact that fixup_bad_iret() and
>   sync_regs() don't corrupt the return-address of themselves.
>   They are the same reliances and are assured.

This whole paragraph sounds like unneeded rambling. You need to remain
on the subject in your commit messages. Sounds to me like you need to
read the "Changelog" section here:

Documentation/process/maintainer-tip.rst

> After this change, error_entry() will not do fancy things with the stack
> except when in the prolog which will be fixed in the next patch ("move
> PUSH_AND_CLEAR_REGS out of error_entry").  This patch and the next patch

"This patch" is tautology, as already said.

There's no "next patch" in git.

> can't be swapped because the next patch relies on this patch's stopping
> fiddling with the return-address of error_entry(), otherwise the objtool
> would complain.

If that is the case, then those two should me merged into one!

> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e9d896717ab4..8eff3e6b1687 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
>  .macro idtentry_body cfunc has_error_code:req
>  
>  	call	error_entry
> +	movq	%rax, %rsp			/* switch stack settled by sync_regs() */

"settled" doesn't fit here, try again.

> +	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  
>  	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
