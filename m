Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AE529BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiEQIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiEQIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:05:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFAB3EBA9;
        Tue, 17 May 2022 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0DyemnKXz49NVsbKhFdeBmhodjhpRdx89qFzJBEwqrs=; b=DY+X73C+SVWiF9bZk5hf/KqiBd
        YVdPIEBIoFD3Kyxr3gPXX/MhpIS/ktdIWQsQpPNfnxYAvfuE6BXBFbSRFDTFEvBJIjZ1h+sJWQ7xl
        ICnZikro8otJtDYXoqjmqmllfcS9McHEWfA3miP7gX2UwC2F14piBsk0e1q0DQ4d4LR5Mpl83dite
        SjmKztEZam4zNSu3LbGMhzKU9pGxnHvg40FtPwmYQuRVhpw2VUuU8F3gdnLMY71iX8f8X71OIZWUs
        cCgxIFSFxorE6E1WUe/xxRSHRn/DxBwXcSmcFh/q8XCRJiRJqxaAvw5hIWdEDjfY7GajFYM3H5qVU
        EobYhpDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqsCl-00Aelk-T8; Tue, 17 May 2022 08:05:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 804C730018E;
        Tue, 17 May 2022 10:05:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64CD22023D64A; Tue, 17 May 2022 10:05:17 +0200 (CEST)
Date:   Tue, 17 May 2022 10:05:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <202205161531.3339CA95@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205161531.3339CA95@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 03:59:41PM -0700, Kees Cook wrote:

> I'm still not convinced about this, but I'm on the fence.
> 
> Cons:
> - FineIBT does callee-based hash verification, which means any
>   attacker-constructed memory region just has to have an endbr and nops at
>   "shellcode - 9". KCFI would need the region to have the hash at
>   "shellcode - 6" and an endbr at "shellcode". However, that hash is well
>   known, so it's not much protection.

How would you get the ENDBR there anyway? If you can write code it's
game over.

> - Potential performance hit due to making an additional "call" outside
>   the cache lines of both caller and callee.

That was all an effort to shrink and simplify, all this CFI stuff is
massive bloat :/

If we use %eax instead of %r10d for the hash transfer (as per Joao), and
use int3 instead of ud2, then we can shrink the fineibt sequence to:

__cfi_\func:
	endbr				# 4
	xorl	$0x12345678, %eax	# 5
	jz	1f			# 2
	int3				# 1
\func:
	...

Which is 12 bytes, and needs a larger preamble (up from 9 in the current
proposal).

If we do the objtool/linker fixup, such that direct calls/jumps will
*never* hit ENDBR, then we can do something ugly like:

	kCFI			FineIBT

__cfi_\func:			__cfi_\func:
	int3				endbr
	movl $0x12345678, %rax		xorl $0x12345678, %eax
	int3				jz   1f
	int3				int3
\func:
	endbr
__direct_\func:			__direct_\func:
	...				...

which is 12 bytes on both sides and shrinks the preaamble to 8 bytes
while additionally also supporting kCFI+IBT for those few people that
don't care about speculation based attacks much.

But now it's complicated again and requires significant tools work :/
(also, using int3 isn't ideal).

> Pros:
> - FineIBT can be done without read access to the kernel text, which will
>   be nice in the exec-only future.

  - Mostly kills SpectreBHB (because it has the hash check *after*
    ENDBR).

So were IBT limits speculation to all sites that have ENDBR, you can
still target any of them. With FineIBT you loose all sites that don't
match on hash value, significantly reducing the options.

> I'd kind of like the "dynamic FineIBT conversion" to be a config option,
> at least at first. We could at least do performance comparisons between
> them.

Why would you need a config option for that? Since it is dynamic anyway
a boot option works fine.


Also, regardless of all this, it probably makes sense to add an LTO pass
to remove all unused __cfi_ symbols and endbr instructions, less viable
targets is more better :-)

I've been doing that with objtool for the IBT builds.
