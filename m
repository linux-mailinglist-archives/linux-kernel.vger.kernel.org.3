Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7D50AB40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392512AbiDUWOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiDUWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:14:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639E4EDD0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:11:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so6741866plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzZtQodB38R9G1B2K9PNO0OqeUH9OKgM3+X+Uqmq3wQ=;
        b=GsF5dIPg3ljO4kyklpR4+04dCCFzGd4eoKAKhlNh5bUPCYjdjb93MHSXTGVulkQzqE
         8iesEd2rlpnmYXjLfn32ja++vzE4s1wbIdSFaV+ncpgWYsYpwWLCFEBH0zJFJdiPWbgs
         vctHOd2PyMWbAbVdAtCur+JSCxS9mmhBlOa8pr4yOY9dTJ/q8iuzLc+bY0ST8ufKb3EM
         EolObpPJoVNagSM8aKDhN02DEBlrP66FgqAV8H2QZAOoQIjTxdV/bbLJI3m1azyRrMwR
         jWcrj8MJH6YPz0J8LRMAIlua84IVj6KmjLY67pJdVwJSsXhvWH7yu7NADhHyXPRO91In
         t8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzZtQodB38R9G1B2K9PNO0OqeUH9OKgM3+X+Uqmq3wQ=;
        b=h80fmamaLCOaqBsHjN4Dsgkkpi2H/98iFIaaWXL22Ft/cEC2F4a78+ZxfKhZAyVDO4
         +71ZTvBTuPFei7xl7WMX3OtkhBybdWqBXtcMWCseVOjrB+TsKG7urkWY6EiDZ/L8Ghhj
         uFePr4NmXrtA+RUbfvhVOFlzNBtczGjhMU1AeMnKDn9dWy7FM/Dv+irPqVF8WsGpgkgf
         xP9SvWJCLoCm2fHLAuXBj6Cx5sZEsvp3gUDqairWIxYM8qqMGa+UefzzCQhgJ6sIWq7O
         XX0i1pQPb95d/1vDww9GeCfZkWQb3IR0amUZreWuAeTfwWy3TZBFx7w2it76eS68JJ4r
         2irw==
X-Gm-Message-State: AOAM533NqeFishHnxHpOIES0bfnkJLRKy9A/xgzBANqVvQ+tfFGPUZUv
        9n60vKDqvi79RgUMALGRh0woVg==
X-Google-Smtp-Source: ABdhPJzcNbfwlfxRaUKMbmTx7svPUJrBiNQbGyB/MhJ15cZWvNmeBdDnD4HYpbOIPbsrMdb6HUB6Sw==
X-Received: by 2002:a17:903:32ce:b0:159:5f7:49db with SMTP id i14-20020a17090332ce00b0015905f749dbmr1319654plr.110.1650579076619;
        Thu, 21 Apr 2022 15:11:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5062:5b73:5dd3:65fe])
        by smtp.gmail.com with ESMTPSA id f10-20020a63de0a000000b003aab55ad590sm121788pgg.93.2022.04.21.15.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:11:16 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:11:10 -0700
From:   Fangrui Song <maskray@google.com>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <20220421221110.nq3e2vje7uvuu5dd@google.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
 <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
 <bf3273120d8d48a79357f229c5890576@overdrivepizza.com>
 <20220421074920.GK2731@worktop.programming.kicks-ass.net>
 <643dac8c3ccb0720b4a8e67a472b08de@overdrivepizza.com>
 <CAMe9rOqG5iAbYm_h3KsUeiToGPAs5SZ3SuWUn+_P-5Ax37=f1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMe9rOqG5iAbYm_h3KsUeiToGPAs5SZ3SuWUn+_P-5Ax37=f1A@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21, H.J. Lu wrote:
>On Thu, Apr 21, 2022 at 8:23 AM Joao Moreira <joao@overdrivepizza.com> wrote:
>>
>> On 2022-04-21 00:49, Peter Zijlstra wrote:
>> > On Wed, Apr 20, 2022 at 03:40:41PM -0700, Joao Moreira wrote:
>> >> > >
>> >> > > If FineIBT needs it, I could reconsider.  But I think there's a strong
>> >> > > case to be made that the linker should be doing that instead.
>> >> >
>> >> > That sounds reasonable to me (and reminds me of linker relaxation).
>> >> > Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
>> >> > determine how feasible this would be? I assume code outside the kernel
>> >> > might enjoy such an optimization, too.  When that's the case, then it
>> >> > probably makes more sense to "upstream" such "optimizations" from the
>> >> > kernel-specific objtool into the toolchains.
>> >>
>> >> Alright, these are the greenlights I was hoping for.
>> >>
>> >> I went quickly into this with HJ and he mentioned that it should be
>> >> doable
>> >> in the linker, and that he has a patch for it in gcc (for local
>> >> function,
>> >> from what I could see):
>> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
>> >>
>> >> If @Fangrui is fine with it, I would like to try implementing this
>> >> myself in
>> >> lld (I'm still learning a lot about lld and having an actual problem
>> >> to
>> >> solve is the kind of fuel I need). Should take me a while, but I think
>> >> this
>> >> is not urgent, right? I can also go ahead and replicate HJ's gcc patch
>> >> into
>> >> clang, so we can also handle the local functions within the compiler
>> >> (I
>> >> think this makes a lot of sense).
>> >>
>> >> Once we have these in, I'll revisit FineIBT and extend the features to
>> >> handle the FineIBT instrumentation. Hopefully we'll be released from
>> >> needing
>> >> objtool (famous last words?!).
>> >>
>> >> This sounds like a plan, but I'm ofc open to suggestions or different
>> >> ideas/plans.

Thanks for looping me in! (I mean: this is discussed beforehand, instead
of GCC/GNU ld taking some steps and pushing LLVM toolchain to follow
suite..)
Though I think I may not have the full context here...

I can see that you have a request to skip the endbr instruction
(and potentially more instructions for FineIBT).

The GCC patch https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
achieves it. A linker implementation will handle more cases.
This is somewhat similar to PowerPC64's global entry vs local entry.
The linker can redirect a branch instruction to the local entry in some
conditions. My concern is that inspecting the section content goes too far
and breaks the spirit of ELF relocation resolving. The proper way is to use
a symbol attribute (e.g. st_other).

st_other bits are scarce, so any use needs to be prudent.

>> > So trivially the plan sounds like: compiler fixes STB_LOCAL because it
>> > has the scope, and the linker fixes everything else. However, that
>> > seems
>> > to assume that !STB_LOCAL will have ENDBR.
>> >
>> > This latter isn't true; for one there's __attribute__((nocf_check))
>> > that
>> > can be used to suppress ENDBR generation on a function.
>> >
>> > Alternatively the linker will need to 'read' the function to determine
>> > if it has ENDBR, or we need to augment the ELF format such that we can
>> > tell from that.
>> >
>> > So what exactly is the plan?
>>
>> I ran into too many broken dreams by trying to infer the presence of
>> ENDBRs just by the symbol locality/linkage... not only because of the
>> attribute, but also because of ancient assembly.
>>
>> So, my first thought was to use something similar to the
>> __patchable_function_entries section
>> (https://man7.org/linux/man-pages/man1/gcc.1.html), where we would have
>> a section to mark all the placed ENDBR. But then it occurred to me that
>> if we follow that road we'll miss the ENDBR placed in assembly unless we
>> mark it manually, so I started thinking that reading the target
>> instructions from the ELF object could be a more simplified approach,
>> although a little more treacherous.
>>
>> I didn't decide yet what to try first -- any thoughts?
>>
>> @Fangrui's and @HJ's thoughts about this could be gold.
>
>You can't assume ENDBR existence just by symbol visibility.
>Compiler knows if there is an ENDBR at function entry since
>it is generated by compiler.   Otherwise, you need to check
>the first 4 bytes at function entry,
>
>-- 
>H.J.
