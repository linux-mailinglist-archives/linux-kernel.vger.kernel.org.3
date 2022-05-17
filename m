Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6662529CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiEQImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbiEQIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:40:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA9637B;
        Tue, 17 May 2022 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z19aIPjW70USLBbDz8uwfQbhmVmgCMWnBLLEt2fwQnk=; b=voDMYDaCISF39VMEpWSPipKHw4
        RJaugttebgQvZtxGRduIu8CzrYyHjtMiZtXJZeJXSLVHC+ZDD/t2wf6LKvmk2MPzv3SWZMwo3lGde
        eJd09dZ+ZdyK/cw81ZmHLGuNqJwJfOXTnDKKfpYGS3zC+tOit5o9pavUKyDuW+fAIBOg8j7CY59di
        XevmJRydszXBTDMJIwM5TIGA4qto7CiVmv+9xJu2gepwBfx3tazxUiO0Vjmfvt2fe9aL5GTEBjIkR
        zO3FmVe5j26LXpdAVEeCabxU98ftjnaU+WW5Hcm0YqEK7gHtczNWKF11XiwBDv2q0AQf0vpxmUyGB
        Nkg6s9zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqsl0-00AgeZ-K5; Tue, 17 May 2022 08:40:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7EA48300642;
        Tue, 17 May 2022 10:40:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 402F22023D0E2; Tue, 17 May 2022 10:40:40 +0200 (CEST)
Date:   Tue, 17 May 2022 10:40:40 +0200
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
Message-ID: <YoNfiK1qKd9YDVIf@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <202205161531.3339CA95@keescook>
 <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:05:17AM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 03:59:41PM -0700, Kees Cook wrote:
> 
> > I'm still not convinced about this, but I'm on the fence.
> > 
> > Cons:
> > - FineIBT does callee-based hash verification, which means any
> >   attacker-constructed memory region just has to have an endbr and nops at
> >   "shellcode - 9". KCFI would need the region to have the hash at
> >   "shellcode - 6" and an endbr at "shellcode". However, that hash is well
> >   known, so it's not much protection.
> 
> How would you get the ENDBR there anyway? If you can write code it's
> game over.
> 
> > - Potential performance hit due to making an additional "call" outside
> >   the cache lines of both caller and callee.
> 
> That was all an effort to shrink and simplify, all this CFI stuff is
> massive bloat :/
> 
> If we use %eax instead of %r10d for the hash transfer (as per Joao), and
> use int3 instead of ud2, then we can shrink the fineibt sequence to:
> 
> __cfi_\func:
> 	endbr				# 4
> 	xorl	$0x12345678, %eax	# 5
> 	jz	1f			# 2
> 	int3				# 1
> \func:
> 	...
> 
> Which is 12 bytes, and needs a larger preamble (up from 9 in the current
> proposal).

On all that; perhaps it would be good to have a compiler option to
specify the preamble size. It can enforce the minimum at 7 to have at
least the required:

	movl $0x12345678, %eax
	int3
	int3

but any larger number will just increase the preamble with int3 padding
at the top.

That can go right along with the option to supress endbr when preamble
:-)
