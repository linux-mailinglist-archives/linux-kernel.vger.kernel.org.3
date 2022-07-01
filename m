Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2856396B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiGAS5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGAS5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:57:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11460427C0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:57:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f39so5359877lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0KdEbiynSy3UiWxTupG4zXX+ERXEfCNO0HgPeCNmcQ=;
        b=ajUY5R62oawU/SkqqkYkb2oyPNb5Rqyoaw0WEy6B57lexEox+Ca/1k23nyG8nSwGsj
         o/oC0s5/9d7PI71ONrUVHURSljx/ubpX+mo6vbvK8JxoqJy79UbjONaKKP5sk/iem3i8
         Yj4si367nalMxeUlEReftDFyEF+MiF5YqWJPxOOzkjQxK002qWxD2LTlzsG1cMzbncBL
         V/15bdZatMk/VHihrJnTceXsAP4zfxh+lNHzRQ4Fro1rUUKqUi7pCljyoH/+1GjRdpf3
         9LmjitaGowZuX5MrGdnpGupeubdavj9s47dxtUZnEhopxuy8oPi9xko+FYjyS4VZc/XS
         vR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0KdEbiynSy3UiWxTupG4zXX+ERXEfCNO0HgPeCNmcQ=;
        b=wsbc+GNt5HHdFM6tAq/mh2gvBSwKh8101q71jMF4D4hJhrZhY6sIFyKVgxQ8K3wzum
         EcJgcDEMriyr6LK9yUxaruLgBbV2ov8d0m8f50UFycB6pUKbsUjepuucqOA6wJj/YssG
         ZIpb2UylGY1+/deWlaa91PWhGLlTnBuEsGyA0LQQskgDs+t+2nKePMmK8zZ72LvxN9o8
         tVNz/dqoxlGl6Pw8VUUDlE8U57EnXHkVOC+/fYH9fDvSQczrzEG9Pe+lWisGzttmeYZn
         a+BDo22lBxskMb31gedDasDmt7olR7Zg+DDvb62fByjPTqfIiObqJW3SU+2Xe7br9QHE
         qvxQ==
X-Gm-Message-State: AJIora9hF01UGIyJ/y33eYsTxDilnmUAdK2XodTbxtoUkNvG5P9Byjqh
        s+8kYirlVkED1sMA8s/brFk2P3bEfq87zRboKGt2
X-Google-Smtp-Source: AGRyM1t8yk+8taY+B/TVH2Z5UU4gYFK1wvUBxVy0PKD0NKAKcpREKJV7lHzMmmRUhrIhVy3FRiiW7Emjl4dZhJcbhTE=
X-Received: by 2002:a05:6512:3088:b0:47f:77df:45be with SMTP id
 z8-20020a056512308800b0047f77df45bemr10721828lfd.134.1656701857195; Fri, 01
 Jul 2022 11:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org> <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com> <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net> <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
In-Reply-To: <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 1 Jul 2022 11:57:25 -0700
Message-ID: <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
Subject: Re: plumbers session on profiling?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
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
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jul 1, 2022 at 4:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jul 01, 2022 at 03:17:54AM -0700, Bill Wendling wrote:
> > On Fri, Jul 1, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
> > > >
> > > > [Added linux-toolchains@vger in CC]
> > > >
> > > > It would be interesting to have some discussion in the Toolchains track
> > > > on building the kernel with PGO/FDO.  I have seen a raise on interest on
> > > > the topic in several companies, but it would make very little sense if
> > > > no kernel hacker is interested in participating... anybody?
> > >
> > > I know there's been a lot of work in this area, but none of it seems to
> > > have trickled down to be easy enough for me to use it.
> >
> > We use an instrumented kernel to collect the data we need. It gives us
> > the best payoff, because the profiling data is more fine-grained and
> > accurate. (PGO does much more than make inlining decisions.)
> >
> > If I recall correctly, you previously suggested using sampling data.
> > (Correct?) Is there a document or article that outlines that process?
>
> IIRC Google has LBR sample driven PGO somewhere as well. ISTR that being
> the whole motivation for that gruesome Zen3 BRS hack.
>
> Google got me this: https://research.google.com/pubs/archive/45290.pdf
>
Right. However, there's a chicken-and-egg issue with AutoFDO for the
production kernel. We can't release a kernel that hasn't been compiled
with PGO/FDO. We could only release it in a test environment, in which
case we could use AutoFDO. However, the document says that AutoFDO
only reaches ~90% of FDO. They list some reasons for this, but
nonetheless I suspect that the delta would be too severe for us to
release the kernel.

As for LBR, that will work with Intel/AMD, but I thought that LBR
doesn't exist for Arm processors (my knowledge could be out of date on
this).

What would make PGO (sample-based or instrumented) easy enough for you
to use? What're the key elements missing?

-bw
