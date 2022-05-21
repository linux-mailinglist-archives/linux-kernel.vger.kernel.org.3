Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299852FAC4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiEUK5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiEUK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 06:57:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C96C580D7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/wgaEZZPzTbr+Xe8tD8yBF1WihgmlBahTE13m1ErG0=; b=QvqJ/Te08o3S0En7DTuvQtGdBy
        PTlNWP8rCToOfbw95crDdvNcDSGr+0ZJ2KO3LFvqgNjgfNv/vfpNYr3nwMVg3BtKt79cWeIdzCr/i
        JJUPjI8O+s4P4haCaPRlbJkQHbdw20zrXjs7rcGdUlnO6pZPFALmR7CUbgDPonoZCMsa2wSEPSx6g
        Qa61+TCrQYSst0qOcKrqVwRGstWehT4/dPr1f3Y42gQSgE3LUKuYZZG2rRzQKA5i6RfRGC+a80X6s
        0nzKCW7Nj7tcysZg4GAmxSJggDrOddUS6lh3p9zccF/VH3781qSrf9MK/WEZVhP7Uhew3xHnqkLlj
        tzzQAMsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsMnA-000D1N-Uh; Sat, 21 May 2022 10:57:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75EB6980E99; Sat, 21 May 2022 12:57:04 +0200 (CEST)
Date:   Sat, 21 May 2022 12:57:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <20220521105704.GE2578@worktop.programming.kicks-ass.net>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
 <b8fac6e2-c117-86cf-2901-5ae0852ca403@csgroup.eu>
 <20220512151206.dphxz5jyeshwc4jb@treble>
 <bedd240b-d5b1-72f9-156d-96d160f180d4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bedd240b-d5b1-72f9-156d-96d160f180d4@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 09:38:35AM +0000, Christophe Leroy wrote:

> I gave it a try this morning, I selected HAVE_OBJTOOL and 
> HAVE_OBJTOOL_MCOUNT from arch/powerpc/Kconfig
> 
> 
> Seems like there are still some x86 arch specific stuff in common common 
> code and I get the following errors.

I'm assuming there's a metric ton of x86 specific stuff in there.
That'll take a while to clean out.

Mostly Josh's rewrite was centered around splitting out the runtime
options, but objtool is still always build with all options included,
even the ones you're not using for your arch, which is what's triggering
the problems you see here, I suppose...

> Also, is it normal to get those functions built allthough I have not 
> selected HAVE_STACK_VALIDATION ?
> 
>    CC      /home/chleroy/linux-powerpc/tools/objtool/check.o
> check.c: In function 'has_valid_stack_frame':
> check.c:2369:30: error: 'CFI_BP' undeclared (first use in this 
> function); did you mean 'CFI_SP'?
>   2369 |         if (cfi->cfa.base == CFI_BP &&
>        |                              ^~~~~~
>        |                              CFI_SP
> check.c:2369:30: note: each undeclared identifier is reported only once 
> for each function it appears in
> check.c:2371:44: error: 'CFI_RA' undeclared (first use in this 
> function); did you mean 'CFI_R3'?
>   2371 |             check_reg_frame_pos(&cfi->regs[CFI_RA], 
> -cfi->cfa.offset + 8))
>        |                                            ^~~~~~
>        |                                            CFI_R3
> check.c: In function 'update_cfi_state':
> check.c:2499:70: error: 'CFI_BP' undeclared (first use in this 
> function); did you mean 'CFI_SP'?
>   2499 |                         if (op->src.reg == CFI_SP && 
> op->dest.reg == CFI_BP &&
>        | 
>        ^~~~~~
>        | 
>        CFI_SP
> make[3]: *** [/home/chleroy/linux-powerpc/tools/build/Makefile.build:97: 
> /home/chleroy/linux-powerpc/tools/objtool/check.o] Error 1
> make[2]: *** [Makefile:54: 
> /home/chleroy/linux-powerpc/tools/objtool/objtool-in.o] Error 2
> make[1]: *** [Makefile:69: objtool] Error 2
> make: *** [Makefile:1337: tools/objtool] Error 2
> 
> 
> What would be the best approach to fix that ?

Define CFI_BP to your frame register (r2, afaict) I suppose. If you're
only using OBJTOOL_MCOUNT this code will never run, so all you have to
ensure is that it compiles, not that it makes sense (-:

The very long and complicated way would be to propagate the various
CONFIG_HAVE_* build time things to the objtool build and librally
sprinkle a lot of #ifdef around.

