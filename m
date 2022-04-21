Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE75509993
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386221AbiDUHwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386262AbiDUHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:52:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125E658D;
        Thu, 21 Apr 2022 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b/atdEajx4p/InTBGf9pz75b6PN3+RGLM2H3UyyRqww=; b=gGuH9238Tkpk6NHCyrEPhvr0ZL
        HRe2ZG9WdJv6oSHV7hyzGlvkr/jBlMTxoJXZIhApBqhgsHQ7MB63hd/HHjWC8HtxNJfSm0gW7z6Qq
        fTwV74RPZ7kyAhfOmlwKFWh7ErO4VeATzoeh9FRGPQT5IEAsTJV/cYXiQbw0iI7c1qVPxK93s3TFL
        s6Nb6Z1cd/7luE9DnimnriqEKIYMQRoLiKTV/x8WxSf6dsF7H86m3q3O1Q6Br+p03NxOKAEa5ZoMX
        M1YLkJOI0/Lyw/L0DGCk/3tWyf3j0LDHzz8n597hUru7dN4OyB+T1+WjSviGPm8P+AWtR92klc5+e
        YJyx7VqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRZ4-007LZQ-Vp; Thu, 21 Apr 2022 07:49:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C74C29861A4; Thu, 21 Apr 2022 09:49:20 +0200 (CEST)
Date:   Thu, 21 Apr 2022 09:49:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, hjl.tools@gmail.com,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <20220421074920.GK2731@worktop.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
 <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
 <bf3273120d8d48a79357f229c5890576@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3273120d8d48a79357f229c5890576@overdrivepizza.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:40:41PM -0700, Joao Moreira wrote:
> > > 
> > > If FineIBT needs it, I could reconsider.  But I think there's a strong
> > > case to be made that the linker should be doing that instead.
> > 
> > That sounds reasonable to me (and reminds me of linker relaxation).
> > Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
> > determine how feasible this would be? I assume code outside the kernel
> > might enjoy such an optimization, too.  When that's the case, then it
> > probably makes more sense to "upstream" such "optimizations" from the
> > kernel-specific objtool into the toolchains.
> 
> Alright, these are the greenlights I was hoping for.
> 
> I went quickly into this with HJ and he mentioned that it should be doable
> in the linker, and that he has a patch for it in gcc (for local function,
> from what I could see):
> https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
> 
> If @Fangrui is fine with it, I would like to try implementing this myself in
> lld (I'm still learning a lot about lld and having an actual problem to
> solve is the kind of fuel I need). Should take me a while, but I think this
> is not urgent, right? I can also go ahead and replicate HJ's gcc patch into
> clang, so we can also handle the local functions within the compiler (I
> think this makes a lot of sense).
> 
> Once we have these in, I'll revisit FineIBT and extend the features to
> handle the FineIBT instrumentation. Hopefully we'll be released from needing
> objtool (famous last words?!).
> 
> This sounds like a plan, but I'm ofc open to suggestions or different
> ideas/plans.

So trivially the plan sounds like: compiler fixes STB_LOCAL because it
has the scope, and the linker fixes everything else. However, that seems
to assume that !STB_LOCAL will have ENDBR.

This latter isn't true; for one there's __attribute__((nocf_check)) that
can be used to suppress ENDBR generation on a function.

Alternatively the linker will need to 'read' the function to determine
if it has ENDBR, or we need to augment the ELF format such that we can
tell from that.

So what exactly is the plan?
