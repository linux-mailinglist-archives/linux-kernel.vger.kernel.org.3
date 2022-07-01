Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB10563A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGATeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGATeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:34:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9FB1B7A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:34:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x20so3252793plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6DQEpCZmENQjptqwXHTLDnHKYxz0tItpU2pHyOaa2BU=;
        b=ENMXyFsagrwPreoXC0IcQgCjq2ZOyXfGYmdvaPqyKoMhXr8NDMVnJpwnrj3JDHE4pR
         5cMQnCQN83oK9EPcrT/l5Wd2xQ0D6tjPRq5exXLhTKN7W76Mwwy6PIEJC+iKmnZo4M4W
         XF/yXtPsIfNirLCheH8pZFLtd+0jW5QTcfD3jfL/y7BfrbXKKYVJxcw+7GuIFklckeSj
         1lssJ0DIDMdBh+fgq8pwzfJ4JjNcU3JndBLnDEDlRbRBHIZBc61esTIkSWbu36GsfRC2
         FLlfqvVKwV/tyUR3aNuFVL8WSBErkFrl2yAoYdx2EHOspGKcAESUeEB9NcRdSXl+U/uh
         Pjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DQEpCZmENQjptqwXHTLDnHKYxz0tItpU2pHyOaa2BU=;
        b=zzdJFkzPOUCV3IVeiPk51sqTLBYtBGGRfYBoWUgbn4Jm3ZPg/THanq3HhPLx9dFMGy
         DgcOXQGMM5ChngH3VXHDASAv9vPAawWwt97ES6ZwqEm+45a41qhZSfMckxVkcPEiSw6K
         fTylu4h108KalJWrzz9E5WtF9m3rkCRvBgwHZygVuB2VLTPqsqyyyGjHyz6ICrHSc864
         gS9qa35ujXUmjnwOESTkMCSj1i7N6xB+EEob3b+PcAXn/+luwFEWvS1ciOWqgsriUSEk
         u53MSWbBTz+rEiT2COUrTcW4DdCr3Agd6zUFVGYqQu3pbWDQkcE7+UeotjJRr9jiqjDz
         MHiA==
X-Gm-Message-State: AJIora/i8nom+3jdwUygOjUAIb2caUZHvYTZnfyNBOvP42Op1ey3HG5J
        3OOkr7dmdZOszEXBr3GCll3Q1w==
X-Google-Smtp-Source: AGRyM1u4tKYRL61FCzkvy9quGxHDZr27egEzECUFdcIXqDA/BGs2yOGbamWbzSQyb95RZoInzFJmvw==
X-Received: by 2002:a17:90b:3804:b0:1ec:fe8d:8705 with SMTP id mq4-20020a17090b380400b001ecfe8d8705mr20069078pjb.103.1656704054526;
        Fri, 01 Jul 2022 12:34:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2e5b:78f:605a:c739])
        by smtp.gmail.com with ESMTPSA id q6-20020a63cc46000000b0040d287f1378sm15763422pgi.7.2022.07.01.12.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:34:14 -0700 (PDT)
Date:   Fri, 1 Jul 2022 12:34:09 -0700
From:   Fangrui Song <maskray@google.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
Message-ID: <20220701193409.p4ejod7olx7ngl5m@google.com>
References: <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
 <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
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

On 2022-07-01, Bill Wendling wrote:
>On Fri, Jul 1, 2022 at 4:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Fri, Jul 01, 2022 at 03:17:54AM -0700, Bill Wendling wrote:
>> > On Fri, Jul 1, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> > >
>> > > On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
>> > > >
>> > > > [Added linux-toolchains@vger in CC]
>> > > >
>> > > > It would be interesting to have some discussion in the Toolchains track
>> > > > on building the kernel with PGO/FDO.  I have seen a raise on interest on
>> > > > the topic in several companies, but it would make very little sense if
>> > > > no kernel hacker is interested in participating... anybody?
>> > >
>> > > I know there's been a lot of work in this area, but none of it seems to
>> > > have trickled down to be easy enough for me to use it.
>> >
>> > We use an instrumented kernel to collect the data we need. It gives us
>> > the best payoff, because the profiling data is more fine-grained and
>> > accurate. (PGO does much more than make inlining decisions.)
>> >
>> > If I recall correctly, you previously suggested using sampling data.
>> > (Correct?) Is there a document or article that outlines that process?
>>
>> IIRC Google has LBR sample driven PGO somewhere as well. ISTR that being
>> the whole motivation for that gruesome Zen3 BRS hack.
>>
>> Google got me this: https://research.google.com/pubs/archive/45290.pdf
>>

I very support that the mainline kernel adds instrumentation based PGO
but I vaguely recall that it was NAKed by Linus (because he thought
sample based is better).

>Right. However, there's a chicken-and-egg issue with AutoFDO for the
>production kernel. We can't release a kernel that hasn't been compiled
>with PGO/FDO. We could only release it in a test environment, in which
>case we could use AutoFDO. However, the document says that AutoFDO
>only reaches ~90% of FDO. They list some reasons for this, but
>nonetheless I suspect that the delta would be too severe for us to
>release the kernel.
>
>As for LBR, that will work with Intel/AMD, but I thought that LBR
>doesn't exist for Arm processors (my knowledge could be out of date on
>this).

Some folks try using Embedded Trace Macrocells.
I am not at all familiar with it but it seems that retrieving profiles
is not easy. The needed efforts seem even higher than using
instrumentation based PGO.

Instrumentation based PGO has the nice property that it works with all
architectures (the compiler supports) and does not rely on hardware
support. In addition, it collects indirect call targets and string
operation sizes which are very difficult/impossible for sample based
PGO.

>What would make PGO (sample-based or instrumented) easy enough for you
>to use? What're the key elements missing?
>
>-bw
>
