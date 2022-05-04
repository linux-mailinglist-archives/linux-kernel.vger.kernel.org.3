Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7C519CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348011AbiEDKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348094AbiEDKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:24:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389251D313;
        Wed,  4 May 2022 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ESaW3Lw9SOMSc32omcBAeoAPR4+1N9KeZ6OSTGrq0SI=; b=fxxSWhNKz7xeuVwlCstG2wYOEg
        jm6pnlgdg5AAhRIr0NcoKcDWc/qry+0jMni24n0DkaPQbTFdEyDPNEDGm037jg9YiorAU70hTZz7R
        T7BAl2A7B9I8Vz2Sl3leFVwMOmNmtQBR9R5QAUb7m+yKQgzIPb94a46/2ly2uBa1fYx/cH6IkiMev
        ZkdpIXbfDWSA2S/uWiHIYoI/muBWAog1HmUczkA/Vm3Nndb+EUs2fAnUKZjw/ygdjtBxU/ZfBV48k
        DSFTRsG9q/9gxjG8oXY/J4GGIVKy4k8LNy75EG7ezkmaFzy56vlwkG6KxRjJp5JsWoKhj9tAXsWZR
        wTCCku6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmC7K-00GV7a-4w; Wed, 04 May 2022 10:20:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 912D830017D;
        Wed,  4 May 2022 12:20:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5274620275830; Wed,  4 May 2022 12:20:19 +0200 (CEST)
Date:   Wed, 4 May 2022 12:20:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503220244.vyz5flk3gg3y6rbw@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:02:44PM -0700, Josh Poimboeuf wrote:

> I'm not really qualified to comment on this too directly since I haven't
> looked very much at the variations on FineIBT/CFI/KCFI, and what the
> protections and drawbacks are for each approach, and when it might even
> make sense to combine them for a "paranoid user".
> 
> Since we have multiple similar and possibly competing technologies being
> discussed, one thing I do want to warn against is that we as kernel
> developers tend to err on the side of giving people too many choices and
> combinations which *never* get used.

So I don't think there's going to be a user choice here. If there's
hardware support, FineIBT makes more sense. That also means that kCFI no
longer needs to worry about IBT.

If we do something like:


        kCFI                                            FineIBT

__cfi_\sym:                                     __cfi_\sym:
        endbr                           # 4             endbr                   # 4
        sub $hash, %r10                 # 7             sub $hash, %r10         # 7
        je \sym                         # 2             je \sym                 # 2
        ud2                             # 2             ud2                     # 2
\sym:                                           \sym:


caller:                                         caller:
        cmpl $hash, -8(%r11)            # 8             movl $hash, %r10d       # 6
        je 1f                           # 2             sub 15, %r11            # 4
        ud2                             # 2             call *%r11              # 3
1:      call __x86_indirect_thunk_r11   # 5             .nop 4                  # 4 (could even fix up r11 again)


Then, all that's required is a slight tweak to apply_retpolines() to
rewrite a little more text.

Note that this also does away with having to fix up the linker, since
all direct call will already point at \sym. It's just the IBT indirect
calls that need to frob the pointer in order to hit the ENDBR.

On top of that, we no longer have to special case the objtool
instruction decoder, the prelude are proper instructions now.
