Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73C5AB796
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiIBRc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiIBRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:32:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8201F63D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZvPsgCeBrb7LWKubupD95PymNZTXgE+09rpNPKxSDsQ=; b=a1BCGo9k8KoOfgDYOLcmYlWFRs
        cQiL3DIDFiNJbCRcrM7r27xu5inS1bKUEulFYS/R+kVUbVeO8NtMFriLHH1IEjd/0y83dXXsNfP4i
        zEOapOx3Hj1RK7IdHz2ZBB9BUZrD7OyWmB6ZjIZeXDEsgAMj2uCZZXpGqENi2RtjlwJv0SnEwhYc3
        5xIetADZmOeNpIXU5x7+lHjIazPpaIYIZoGigNdHxS1vsnBSrRh2uJOKn9aHZ5sZ73/ynFUgoQaGa
        wkDE+B7aryhfG/nUdFclUf2EvfRK2w212fR3dzakwYoNISjx2oZZSai/sVn8Hch98VXW4i4SFgETk
        YxwVLk/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUAWr-007Cpr-El; Fri, 02 Sep 2022 17:32:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E9643002A3;
        Fri,  2 Sep 2022 19:32:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15F9E2B9048DE; Fri,  2 Sep 2022 19:32:27 +0200 (CEST)
Date:   Fri, 2 Sep 2022 19:32:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
Message-ID: <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:51:17AM -0700, Linus Torvalds wrote:
> On Fri, Sep 2, 2022 at 6:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > --- a/arch/x86/include/asm/linkage.h
> > +++ b/arch/x86/include/asm/linkage.h
> > @@ -14,9 +14,10 @@
> >
> >  #ifdef __ASSEMBLY__
> >
> > -#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
> > -#define __ALIGN                .p2align 4, 0x90
> > -#define __ALIGN_STR    __stringify(__ALIGN)
> > +#if CONFIG_FUNCTION_ALIGNMENT == 16
> > +#define __ALIGN                        .p2align 4, 0x90
> > +#define __ALIGN_STR            __stringify(__ALIGN)
> > +#define FUNCTION_ALIGNMENT     16
> >  #endif
> 
> Ugh.
> 
> Why is this conditional on that alignment being 16?

There is a DEBUG case that increases the thing to 32.
