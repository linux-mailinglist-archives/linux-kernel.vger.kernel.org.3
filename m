Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD7558971
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiFWToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiFWToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:44:01 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289624F9E3;
        Thu, 23 Jun 2022 12:35:42 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25NJZAiJ026139;
        Fri, 24 Jun 2022 04:35:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25NJZAiJ026139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656012911;
        bh=pEL1WpSAMyD9mSY4a16U3Cj3+7K9DHBU8p8yE5/Cd+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sdy61U8S1Mu+wzsbo79yD/KwiVM9vgopBQ9Z2NbvOlwcpawkA3a7xy0iEOEDeGPF7
         /2bi6nQmF6xTOlzE0PA0Yj+qZH777RpcOE7gTfR+BPYphWq2y3B/jpo6iVeUdoCMWo
         rs8RvCcEwQ1gUHgcVw1zWbbWzHTD181NghhQXuNwNxatWSFODy1FHw5BjDiO9Up3do
         OlZEX4scuTO6xDmeT4dr0bEcFp7qscIOmSrZ9985Syau9p9BQnWKqWUPTXuyrx6bmg
         mPmfFYTxzgRIICm5jDYcWBW0qVtAhaRtpHsrkU7TMqVXRnl9hoIdvyw7o3TLuDVAgi
         /pTtygIPHwYKg==
X-Nifty-SrcIP: [209.85.221.43]
Received: by mail-wr1-f43.google.com with SMTP id q9so212873wrd.8;
        Thu, 23 Jun 2022 12:35:10 -0700 (PDT)
X-Gm-Message-State: AJIora/RI2JdJxw2SiRbGGzKltZTbs76FY91IhbK6WF2zoog/shN7USv
        pufKEqmraQiXEcPaXQOtuSFjPFsT8JAAaMCc570=
X-Google-Smtp-Source: AGRyM1srspw7EU7Xm6FsPrhI/NLmn/WuKT0VLoKcN/Mob1luYu0IWi9h8tBScStCWHAgSQBNK+67fnFqeVBqJEJupxs=
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id
 ck18-20020a5d5e92000000b0021a278cb901mr9825142wrb.461.1656012909393; Thu, 23
 Jun 2022 12:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220616195759.3214538-1-samitolvanen@google.com>
 <CAK7LNARAAdWPxaMWawQf5Y4kYJ065OMtvrnUaHkjCquL_BZYYQ@mail.gmail.com> <CABCJKudwqKOGfE0Ha9b8DXaZ23bvKk+DhdVbJHoLneV5zJaZzQ@mail.gmail.com>
In-Reply-To: <CABCJKudwqKOGfE0Ha9b8DXaZ23bvKk+DhdVbJHoLneV5zJaZzQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Jun 2022 04:34:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXFjoS70nvBRiwFA46qLhCDG52x=MzXqBEc3cUaxYkcw@mail.gmail.com>
Message-ID: <CAK7LNAQXFjoS70nvBRiwFA46qLhCDG52x=MzXqBEc3cUaxYkcw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Ignore __this_module in gen_autoksyms.sh
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steve Muckle <smuckle@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:37 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Sat, Jun 18, 2022 at 4:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Jun 17, 2022 at 4:58 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Module object files can contain an undefined reference to __this_module,
> > > which isn't resolved until we link the final .ko. The kernel doesn't
> > > export this symbol, so ignore it in gen_autoksyms.sh.
> >
> > OK, I understand these two sentences.
> >
> > > This avoids an
> > > unnecessary vmlinux rebuild with UNUSED_KSYMS_WHITELIST when we have a
> > > symbol list that already contains all the module dependencies.
> > >
> >
> > I do not understand how this can happen.
> >
> >
> > Can you provide me steps to reproduce it?
>
> This issue only happens when we have a whitelist that already contains
> all the symbols we need to export. As autoksyms.h contains all the
> necessary symbols in the initial vmlinux build, there should be no
> need to link vmlinux again. However, as the code is looking at
> undefined symbols in module .o files before __this_module is resolved,
> adjust_autoksyms.sh thinks that __this_module is still missing and
> triggers a rebuild, without actually changing anything.
>
> I suspect this isn't a common situation, but it does happen when
> building Android kernels, which specify a complete list of exported
> symbols. Linking vmlinux.o takes a while with LTO and we would like to
> avoid performing this step more than once.
>
> Sami

Thanks, confirmed.

But, this patch does not shoot the root cause.
The relink of vmlinux should not happen irrespective of
UNUSED_KSYMS_WHITELIST.


I thought I had fixed this issue long time before, but
actually didn't due to my mistake in
commit 3fdc7d3fe4c0 ("kbuild: link vmlinux only once for
CONFIG_TRIM_UNUSED_KSYMS").


I will pick up this patch anyway, but the re-link of vmlinux
should be addressed by the other patch.



-- 
Best Regards
Masahiro Yamada
