Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6051ABE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377020AbiEDRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359299AbiEDRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:35:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D65C670
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:04:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so1954823plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uj6YMBCZWAjWY8ro19VauUXc0fzSyeDEeGTwnyspmvk=;
        b=jFw/YtuAuY8zOu6CBZwrP8/qTS38T5FgjRy6M7i4aX08fnI6fVbU4nJp+GZWb2X/Oi
         5jA20ZVdF1pc2KkJPGk1ZQI0ASmLV2xvybvi+wq5eEX1tHfMhwWyCaaMegbUUXPvCMid
         XmP2uUvXaBb+17kdYgA8aF5HDIHfLFUmZvBEQbJmOVOQFNnEjIWtfcTF/0h2q0y9h7xv
         etMVkh8gaL5cLlgEAODxlKfUa9G8mG51A5Nu5ItKpNLHd9AyJ6QmM+CijTcIlU/TJt8/
         yDHWs26N40Nz6YMgWLFMJQ+5fI/lH5MVmOp0CMxNNdVYu/al9dbglBGJTaQ5ewqoYy9v
         J2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uj6YMBCZWAjWY8ro19VauUXc0fzSyeDEeGTwnyspmvk=;
        b=dcUfhNzALtg/0UBhBKVVQEr8xFXkzhJy2DHDdhxrDy52czREFJUCA0LTLVqfcMEMjb
         FohGV5i+ttuSLxc5GudrbuAMzned2uYuYj52FuiFVVHXTCk7/4D7Ti9lRAbzM1Vc2sMW
         n10u1LgX/WH+BWwr8JsMTgmuK7SPm4BEHrxNt5ThUOAeTtsK53oFSeriMx+2wOxUf3oN
         lP9So6L58Qe8JzAZzi+tJ0RzPicgxPCGyiXNWfbOlmJj5CUPGWfyq1CvlIOnHTEGtrmS
         Ogfbhr9Llo/aLEGQq0dvXzDVtf75mL3wFn7uWqp8CHzTaI/faqV4pvie9gwP0zZmFFjs
         80Xw==
X-Gm-Message-State: AOAM533IBZOYgEzeINz/l1KQk3bFODCjZU6QisbI2lFHM+3eV7esK3N/
        65FCAsWUXbg5Ek57GE7RjA5z7A==
X-Google-Smtp-Source: ABdhPJwQhJX1Wntu7nztS9/CKxmjFCDWW3e5W7Ktqn6IS03XXkrCVf3vv40N8CYVtf+Hw6G24CphUQ==
X-Received: by 2002:a17:90b:1bc3:b0:1dc:61fd:7ea4 with SMTP id oa3-20020a17090b1bc300b001dc61fd7ea4mr473665pjb.31.1651683852263;
        Wed, 04 May 2022 10:04:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1b7:7a5:89b8:a6c6])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0015e8d4eb222sm8437874pld.108.2022.05.04.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:04:11 -0700 (PDT)
Date:   Wed, 4 May 2022 10:04:02 -0700
From:   Peter Collingbourne <pcc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <YnKx5a9WvJ1UhWPm@google.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 12:20:19PM +0200, Peter Zijlstra wrote:
> On Tue, May 03, 2022 at 03:02:44PM -0700, Josh Poimboeuf wrote:
> 
> > I'm not really qualified to comment on this too directly since I haven't
> > looked very much at the variations on FineIBT/CFI/KCFI, and what the
> > protections and drawbacks are for each approach, and when it might even
> > make sense to combine them for a "paranoid user".
> > 
> > Since we have multiple similar and possibly competing technologies being
> > discussed, one thing I do want to warn against is that we as kernel
> > developers tend to err on the side of giving people too many choices and
> > combinations which *never* get used.
> 
> So I don't think there's going to be a user choice here. If there's
> hardware support, FineIBT makes more sense. That also means that kCFI no
> longer needs to worry about IBT.
> 
> If we do something like:
> 
> 
>         kCFI                                            FineIBT
> 
> __cfi_\sym:                                     __cfi_\sym:
>         endbr                           # 4             endbr                   # 4
>         sub $hash, %r10                 # 7             sub $hash, %r10         # 7
>         je \sym                         # 2             je \sym                 # 2
>         ud2                             # 2             ud2                     # 2
> \sym:                                           \sym:
> 
> 
> caller:                                         caller:
>         cmpl $hash, -8(%r11)            # 8             movl $hash, %r10d       # 6
>         je 1f                           # 2             sub 15, %r11            # 4
>         ud2                             # 2             call *%r11              # 3
> 1:      call __x86_indirect_thunk_r11   # 5             .nop 4                  # 4 (could even fix up r11 again)
> 
> 
> Then, all that's required is a slight tweak to apply_retpolines() to
> rewrite a little more text.
> 
> Note that this also does away with having to fix up the linker, since
> all direct call will already point at \sym. It's just the IBT indirect
> calls that need to frob the pointer in order to hit the ENDBR.
> 
> On top of that, we no longer have to special case the objtool
> instruction decoder, the prelude are proper instructions now.

For kCFI this brings back the gadget problem that I mentioned here:
https://lore.kernel.org/all/Yh7fLRYl8KgMcOe5@google.com/

because the hash at the call site is 8 bytes before the call
instruction.

Peter
