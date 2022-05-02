Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B45516B64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382920AbiEBHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350995AbiEBHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:50:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC629CA5;
        Mon,  2 May 2022 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pOoEoq3uxOd2hY3qnCRK9aDXRSIdbU9S375EHmEixg8=; b=Zx1qMADDPH8oEOTa4jVupxWl6E
        jp0Ix1UpwVxb/Fun8uQkpi/VDVUrELD+eS/RX9VUTmUff5Lfk9pHLGnzXGRo5XQjnKpVQAnDGA+HY
        6njW7JD42U9XDnB6D3TI9rmTZ/aqSpbsxfUtPIHKH48smGoBc+hsJpqXaRadtuEJcHvW3GiOXvq13
        d4zs632v/3gKbbrqz0yWyBW7gjlr+57/KxIGorr/dnptiwV1AYALOr2y65wpMHAAJ4xsSV0n37yzE
        19MxrkmlClL3jeLhLETg9bIIv0pjGFEOLCYtKCiGSpok8qhV9B6cU0FBm//Y4T/y5l5jfkXJiDpIU
        UHe+W3Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlQlP-00AOnG-Mt; Mon, 02 May 2022 07:46:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FA2398035B; Mon,  2 May 2022 09:46:33 +0200 (CEST)
Date:   Mon, 2 May 2022 09:46:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH 14/21] treewide: static_call: Pass call arguments to
 the macro
Message-ID: <20220502074633.GA479834@worktop.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-15-samitolvanen@google.com>
 <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
 <CABCJKud8vC6RwQLs2YXnZMZaXGNYBEq+sNmOsgGjjAw4MfuZuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKud8vC6RwQLs2YXnZMZaXGNYBEq+sNmOsgGjjAw4MfuZuw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:49:21PM -0700, Sami Tolvanen wrote:
> On Fri, Apr 29, 2022 at 4:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Can you explain why this is needed? I don't think there are any indirect
> > calls to get confused about. That is, if you have STATIC_CALL_INLINE
> > then the compiler should be emitting direct calls to the trampoline.
> 
> Clang emits an indirect call for ({ &f; })(), which is optimized into
> a direct call when possible. Come to think of it, the recent
> InstCombine change to the compiler patch should solve this issue. Let
> me double check, I'd be more than happy to drop these two patches.

Oooh, but this must not require any magic. That is, we have a *ton* of
code that relies on constant propagation of function pointers to not
emit indirect calls.

Please make sure that 'just-works'.

Look at all the __always_inline functions in rbtree*.h for instance,
some like latch and augment rely on quite complicated const propagation
for the actual function pointer is in a const struct.

I've verified all that actually generates direct calls when we did that
code (on GCC, clang wasn't really a thing back then).



