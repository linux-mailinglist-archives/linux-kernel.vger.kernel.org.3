Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF54937DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbiASKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:01:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47854 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbiASKBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:01:32 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03A201EC03AD;
        Wed, 19 Jan 2022 11:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642586487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+sw16Zul1vvekfBj0LiJt53AfIehF1UvXy7HEV0NUk8=;
        b=sNg5oKZ5eGyh5FUA+/j6KEJRvWtedXw7LRPzpsyxJscN/2mXH2VhGn6kHPdRn4g4LaFn6f
        vDUqOxtCAdn1B+CU+RUA5bLMjGKrCmccBjfZ0AIsww/6V4MiIUmra8qPqiHVjwYyfmuA2u
        ps4ZUa6XHh1iytjaugb2xDgVZQUx/Y4=
Date:   Wed, 19 Jan 2022 11:01:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <YefhcXouSQwETTvl@zn.tnic>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble>
 <YedOLva0zos3A1JE@zn.tnic>
 <20220119000327.oapghqad4lebnsra@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119000327.oapghqad4lebnsra@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 04:03:27PM -0800, Josh Poimboeuf wrote:
> If one of the '__bug_table' asm snippets isn't immediately followed by
> the .L[un]reachable asm, then yeah, it's the same issue.

Found one.

AFAICT, that's the WARN_ON_ONCE(1) catch-all in the default: label of
the switch-case in nf_hook(). That thing is followed by other gunk and
no *reachable label near it.

Damn - that was too good to be true. Gotta love those compilers. :-P

# ./include/linux/netfilter.h:252: 		WARN_ON_ONCE(1);
#APP
# 252 "./include/linux/netfilter.h" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC5 - 2b	# bug_entry::file	#
	.word 252	# bug_entry::line	#
	.word 2307	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# 0 "" 2
#NO_APP
	.p2align 4,,3
	jmp	.L344	#
.L265:
# ./include/linux/netfilter.h:229: 		hook_head = rcu_dereference(net->nf.hooks_ipv4[hook]);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
