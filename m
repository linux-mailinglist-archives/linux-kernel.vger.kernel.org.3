Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395CF4E6B30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbiCXXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355752AbiCXXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:21:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E16554B3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:20:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4so6024199pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tyTpYV+qLd3kiCOmwuwEqZzrCGB5RjcTEwNX2Jl7UEA=;
        b=N36LSw7J4Ad6KB9y5Sj67YKYV6mXZvsH8bYHCiyCwTOj6H63DijLBlEMv450NCtV8u
         kQHcDEkhXKCmkiSkTCUpis6/nucGUmAwtRR5L5bIrcD7hu1YE/8SEGjoqBSrLHqfHSsn
         4WmIEKf0WmMgkWJviaxiy+MgajPclr9xWrNW5KYY9e1SAimz6Q0pB0h8NRm5AkJb8C5F
         VJ1ilbu9bVqZJuT7x3W33NfbRrXUB3c19FITLo0XeVxms7QGftQC76GGU+4+Co8Pwdp2
         g18Q8YZWb+NKtxiqD8wYZE0nSw/usHc4WTDa16QVgGC8BVewlqWd3hnziRHQMyrTJcei
         Ankw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyTpYV+qLd3kiCOmwuwEqZzrCGB5RjcTEwNX2Jl7UEA=;
        b=bIxXPhEDiE0+KuazzKJr5uUNpukufT3lRsw93bbonvQXTCFFcf6wxsV0KOV8nZq8vY
         KuCh9f4bzdxF8GFxIljSY03R17eT96O8B5UMZWBYug+nEGrE7MshT5wHud5cFPYx4A4V
         m1pps9hGCfbR8vNS6CM/c3SaRcDP6NmgQd5eNSf6Gf8of1Ec8OxgN15418u+NfsH8ahy
         pUr8XoZRKTeZDZEyc11XCmQ9DIQkCAOEsBPPXxMDj4f0q2VEDzQZ+pp7kHVlrQ659Q5k
         Gd0EY9YjJz28IfV9PXF2/Rtqt7F0EsLsDz9CDuWCZFpSw45TDmuyiYDHrLvhGsvIFbmf
         m3Rg==
X-Gm-Message-State: AOAM531L0UZHabO7L1/Ft7XpT0A5vYzFQ8rC3EvUBhOqzs3KkurdFzd/
        pB8wegJbjNNwkQxltA1EM2ckiA==
X-Google-Smtp-Source: ABdhPJwAgOGkPpuK+V2kEzPXMze0c/NG28V5NRgS2aL1z5C83rlqPXntNdJyV8xjYqDrNbN2xQO9uw==
X-Received: by 2002:a17:90a:c595:b0:1c7:bb62:4487 with SMTP id l21-20020a17090ac59500b001c7bb624487mr6473841pjt.190.1648164000136;
        Thu, 24 Mar 2022 16:20:00 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:7198:79bb:dcac:4972])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f737480bb8sm4446746pfj.4.2022.03.24.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:19:58 -0700 (PDT)
Date:   Thu, 24 Mar 2022 16:19:49 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <Yjz8lQtnWimVeTp7@google.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <CAHk-=whNBs07foho7=QxVbs_hnpDfPP3s2fwyXK-reNw67mU=g@mail.gmail.com>
 <YjwueBQoung7rFD+@gmail.com>
 <YjxFzlzfTF5Av3Zc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjxFzlzfTF5Av3Zc@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:19:58AM +0100, Borislav Petkov wrote:
> On Thu, Mar 24, 2022 at 09:40:24AM +0100, Ingo Molnar wrote:
> > Only intermittently on my side - it only recently started working
> > reliably & it doubles the not inconsiderable test time :-/
> 
> True dat - last time I measured, clang builds take roughly double the
> time gcc builds with the same config do.

See also:
https://lore.kernel.org/lkml/CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com/

We do have to pay a penalty in that if these binaries can be built as
shared objects, the MUST be. (Actually, IDK if Debian has the same
policy as Fedora).

If you see libLLVM-*.so (and libclang-cpp.so) in your list of
`ldd $(which clang)`, or see multiple symbols from the dynamic linker
after running:

$ perf record -e cycles:pp --call-graph lbr make LLVM=1
$ perf report --no-children --sort=dso,cycles

Then dynamic linking is the main source of performance difference
between GCC and Clang on those distributions. So we're kind of fighting
with one hand behind our backs.

For Linux distros that have server costs, my guess is these policies
allow them to minimize their costs of serving prebuilt binaries, since
dynamic linking does allow for smaller binaries.

For short lived processes like most of the toolchain (and parts that
generally don't overlap, such as the serialization between compilation
THEN linkages), dynamic linking provides a ridiculous startup cost. CoW
gets us most of the benefits of dynamic linking in terms of shared
memory between processes. (I don't think ASLR hurts CoW in that way?)

On the flip side, I have been banging pots and pans around internally
trying to raise awareness of the issue (I'm but a peasant though, Mr.
bottom rung of the ladder); we do have budget finally allocated to focus
on compiler performance. Getting the checks written involves more red
tape and more effort than I expected.

I might start ignoring compiler bugs for a while, go off into the
wilderness, and not come back until I have statically linked images of
clang available to host on kernel.org though. There's a lot we could be
doing to hot rod the compiler to optimize for developer's (and CI's)
time.
