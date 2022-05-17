Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25FC529E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiEQJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiEQJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:38:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EF44746;
        Tue, 17 May 2022 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwTi2Cazog8blP0yOGLXWlJcsxSDGZ2u4uY9kxsLkfk=; b=MTdKy2r7vz9qnE0wpTp07nMDEg
        ljCp1Zb2NriOnwiA/uzXXdtuSEEAt+8MmHDW386odcrFLXR7ho+3sO3bDv22akTTPVfMMBXnv+sYI
        g6gwbLw7UoFN9kxB7jC1PnSyV0mnJYnpYuoffSyjX5HIclZnpntQBYF3T/PccfzfZB5YTQq8536iO
        PNACVypbg/9epOBrixidP1XzJqc62oEdrDBFOtkey9RO2PV2y4tUg/sKetgnmz/oaloCU6sVTc76I
        GIFxs0GQBFaxTwXsfnWWxc12azbRX8zbFTrsQm1XHYjiH/MDS52S3YLfghOmjbjQalbuvQq7Rp/3m
        60MDw/MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqtf5-00Aje0-Dt; Tue, 17 May 2022 09:38:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F7A130031C;
        Tue, 17 May 2022 11:38:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66A62202BC439; Tue, 17 May 2022 11:38:36 +0200 (CEST)
Date:   Tue, 17 May 2022 11:38:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <YoNtHOm6VH3adwxt@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <202205161531.3339CA95@keescook>
 <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
 <YoNfiK1qKd9YDVIf@hirez.programming.kicks-ass.net>
 <ebd0c266697a42c8b7609ff6cbc5f6c9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd0c266697a42c8b7609ff6cbc5f6c9@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:48:41AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 17 May 2022 09:41
> ...
> > > If we use %eax instead of %r10d for the hash transfer (as per Joao), and
> > > use int3 instead of ud2, then we can shrink the fineibt sequence to:
> > >
> > > __cfi_\func:
> > > 	endbr				# 4
> > > 	xorl	$0x12345678, %eax	# 5
> > > 	jz	1f			# 2
> > > 	int3				# 1
> > > \func:
> > > 	...
> > >
> > > Which is 12 bytes, and needs a larger preamble (up from 9 in the current
> > > proposal).
> > 
> > On all that; perhaps it would be good to have a compiler option to
> > specify the preamble size. It can enforce the minimum at 7 to have at
> > least the required:
> > 
> > 	movl $0x12345678, %eax
> > 	int3
> > 	int3
> > 
> > but any larger number will just increase the preamble with int3 padding
> > at the top.
> > 
> > That can go right along with the option to supress endbr when preamble
> > :-)
> 
> You also need a compiler option to specify the register.
> While (I think) %eax is usable in kernel, it isn't in userspace.
> It is used in varargs calls to pass (IIRC) the number of fp
> args that are passed in registers.

You're mistaken, the compiler doesn't emit the FineIBT code *at*all*.
That's all patched in later. For kCFI the mov is never executed and is
only there to make it a valid instruction.
