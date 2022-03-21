Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB24E2E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiCUQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiCUQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:46:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502762DD48;
        Mon, 21 Mar 2022 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oJ9Qvw5oXwS4GQGsOIZPh2cYX0tdWh2rdUhpNrMbGAI=; b=Wf13uQGgu5LlB1T0RiH5DnWLtr
        Es3xkJsC7yQJbgDsza/QL5Lidt9VGfx0J8ACxJ1VQiWhhpRwilKwds11y6jEB6U8c8AJUVCHm+3cB
        RSzbwfRbMNUVoOGLdXlu77Z96ra2u5NK9fxNI10e2UfLiHjW3aF5A2ojzoS7gSw5MdRBLLpKr8L3t
        pfL7a/eU9x/hGgyTO/a5XYFdgMhWWLbU7sGC9vgve4jzwDwEp9BgI2ZTvrzrv+pkn+/gNWiTUvutd
        FJ73bBCEEu5QX84N/91xSXagoa3qHjwgoqFey6RoIHd3Dpldx0f5KezJZcdtXkIou5upGV6wrHbuh
        7XZX56JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWL9B-00AkyC-M3; Mon, 21 Mar 2022 16:44:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1815930020B;
        Mon, 21 Mar 2022 17:44:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F34242DB88BF5; Mon, 21 Mar 2022 17:44:44 +0100 (CET)
Date:   Mon, 21 Mar 2022 17:44:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <YjirfOJ2HQAnTrU4@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <Yjh4xzSWtvR+vqst@hirez.programming.kicks-ass.net>
 <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net>
 <YjiZhRelDJeX4dfR@hirez.programming.kicks-ass.net>
 <YjidpOZZJkF6aBTG@hirez.programming.kicks-ass.net>
 <CAHk-=wigO=68WA8aMZnH9o8qRUJQbNJPERosvW82YuScrUTo7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigO=68WA8aMZnH9o8qRUJQbNJPERosvW82YuScrUTo7Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:37:35AM -0700, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 8:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > This landing in -next only today (after having been committed last
> > friday night) is another clue it should probably go next round.
> 
> I went and looked at lore to get the context that I didn't get in this
> email that I was added to the participants for.
> 
> I didn't find the context there either.
> 
> Sure, I found the thread, but the whole "that x86 patch" that you
> refer to was never actually specified even in the full thread as far
> as I can tell. I see that there is an arm64 equivalent too of what you
> are complaining about, and I have no idea about that one either..
> 
> Mind actually giving the full details so that we don't have to go
> re-do the work you already did?
> 
> Because right now I know something is wrong, I know the warnings, but
> I don't actually have any handle on the actual patches to look out
> for.
> 
> It's presumably not in any of the pull requests I already have
> pending, but it would be nice if I saw some details of _what_ you are
> complaining about, and not just the complaint itself ;)

Duh, right. It's this series:

  https://lore.kernel.org/bpf/164757541675.26179.17727138330733641017.git-patchwork-notify@kernel.org/

That went into bpf-next last Friday. I just checked but haven't found a
pull for it yet.
