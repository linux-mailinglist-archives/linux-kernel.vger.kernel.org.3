Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D335272D0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiENQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiENQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:09:09 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B327F0C
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:09:07 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24EG8hOe024205
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 01:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24EG8hOe024205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652544524;
        bh=sz2XzzgYNDJvTzd0PRzJk/pGT+oU5urGUxAfMIxIabo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oK5kf/bmCwIhV8nViceFmeVwRbq1DrZSJBIUViYf9LR4AaRR/Z7usZPDa+/XqKchv
         cF9T1oPfW03F0239yTbOJpOKSVKrkXBG3BUOsu/hZkmGknhqnrSh7hIKQVC0uFxRS6
         nEKNTBG4Pz2mBi3b9frg6J1p063PDwMkknpZy15aO8DspLvg0iroORyG7UANtJR6oy
         BnyAS5SOqhorOTefxGQrMWqRTg/YFUD4z22+gIwOMsSTgFzB6q/6GuYplcBeb6Jr28
         Z4tDmF6cmkuvLJ0wMHxazle7YTTtOGoKYEfJt2CUc2FsVLPtwtNhYtA8MXhLrn2k1H
         AZqRufwQzqKmw==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id v10so10193785pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:08:44 -0700 (PDT)
X-Gm-Message-State: AOAM53197xEUqBXhiovtY9NEPeEpad09FmDKfQgx2Wl0ykM+9FSi4YuV
        fZ2fxbfMnUILOzwnHdrsIenVApSsREf9xdVahfU=
X-Google-Smtp-Source: ABdhPJz+MjOpLsj7WYejiogsvPh1TNXDi5ermnU5gurzP0umx5V8HeXIbwByRv6NY7Wf0+x/a7c9xeSWVDpt3+FAz1o=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr9648452pfj.32.1652544523203; Sat, 14
 May 2022 09:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr> <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com> <20220514131448.GL76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220514131448.GL76023@worktop.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 May 2022 01:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUMfyqiWeZeZJCVO74XtQ1Bw-MN7bcaTZ1pgQy8H2Ehg@mail.gmail.com>
Message-ID: <CAK7LNATUMfyqiWeZeZJCVO74XtQ1Bw-MN7bcaTZ1pgQy8H2Ehg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 10:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, May 14, 2022 at 04:01:18AM +0900, Masahiro Yamada wrote:
> > I wrote a different patch.
> > https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u
>
> I'm not seeing that in my inbox :-(
>
> AFAICT this way 'make tags' will not find and index the files, which is
> a total no-go.

Not only these, we have more generated files.
Why are these bad?

Also, "make tags" picks up headers in include/generated/


>
> NAK

I consider NAK as "I do not like it".



-- 
Best Regards
Masahiro Yamada
