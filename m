Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A9516FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385150AbiEBNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiEBNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:04:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B05186CD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZOpFXMvH6fVGm0NN978db6GomlYBIrV4k0UI7h49GGQ=; b=lGrjzTgKcz6Wno4DrkeqUYgsCs
        roZ/YyERXa8i5ToMVM6XWZ/La5QG3K7PizMeBD7DHrAaw0gx8mu2yLgkmBXlNbNfWd6BJmjPAThJF
        oSzAjiE2bvtqTkmZ+R3ht0Cfl1RdQxoCGUV0/wONgHtjSUIq52GX3PoFhjwrWXkWgTyzezfxpwGBW
        Ig1LcrSGPYYCMgVeXmKQNHjTqfiEDykgAewYcN9JI1/P36hM9OuoKYc/1mLqbQIzVG4WJzbVCVLUK
        rc0NSMNng0B9QOKkAsvheN2lBpQWzgyOzrkpk+T1vArvzfsNTaBub+mx5XXgPcrxGPYQDqobPseW5
        cf9TPKbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlVfs-00Ep7O-9f; Mon, 02 May 2022 13:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9424300091;
        Mon,  2 May 2022 15:01:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9B3E20288CF0; Mon,  2 May 2022 15:01:09 +0200 (CEST)
Date:   Mon, 2 May 2022 15:01:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
Message-ID: <Ym/WFW0DMIZY0Yi4@hirez.programming.kicks-ass.net>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.350926848@infradead.org>
 <CANpmjNP6k5F0vHg6xiu9yhmC7PotGPxVW8M2_pvSKY25eNCnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP6k5F0vHg6xiu9yhmC7PotGPxVW8M2_pvSKY25eNCnDQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 01:23:49PM +0200, Marco Elver wrote:
> On Mon, 2 May 2022 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > When building x86_64 with JUMP_LABEL=n it's possible for
> > instrumentation to sneak into noinstr:
> >
> > vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/jump_label.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
> >  #include <linux/atomic.h>
> >  #include <linux/bug.h>
> >
> > -static inline int static_key_count(struct static_key *key)
> > +static __always_inline int static_key_count(struct static_key *key)
> >  {
> > -       return atomic_read(&key->enabled);
> > +       return READ_ONCE_NOCHECK(&key->enabled.count);
> >  }
> 
> Did arch_atomic_read() not work? Or should this also be unchecked in
> instrumented functions?

Urgh, also I think the above is broken for me forgetting to remove the
&.

I think arch_atomic_read() should work, lemme try.
