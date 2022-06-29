Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E9560AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiF2TtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiF2Tsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:48:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9D3EF24
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:48:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t24so29901541lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDpRTVhKkWSy2MvVKUZ3Z3z1Bt+bBeXV0KIHaszmkuA=;
        b=g3Uaclg64d1TGHzQcBfl7t9w3I1ww5YYtVkypt3S0N5+TmABgMDxTUWvOXt+9mE0Le
         is4FHdD4ZkcI9SN/SIcqtii+qeRjvjZe6VAIbiqCVXchroWHh2LwaXMpwGCocA1tbv0B
         hjr7V6fjm/b+USYataYNnwfHfWPE0kQxbi15bDZMZ58npPO/z1/6UndlovS7hWHSG67i
         cQLWaO3ZHi2zkaIKnEUd44KY6MliZhLMN928/SwMz5yzbgz3jszpOfA90ilDArEe1HUI
         8r3NhHwX5cnxRMZvHR8E+HsLScWoSk0y+DodSdeK7w7KCcyrnAph846jsrTCUnHseGvh
         4nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDpRTVhKkWSy2MvVKUZ3Z3z1Bt+bBeXV0KIHaszmkuA=;
        b=zrl43rqTX18LTv+alzp6QOZ6/jhDdzguXNt4BspgPyI3x0KrJHmM33LnJZhTBWzWkJ
         4ekD/4mtfiJ2/F+olXr0RTzQuuoES2ulYJKvkXgOw9Uwkpq32w8tqmJBHSj0INdxSf1A
         e5eGOxQcESFpqE27LkxD+gJJb5+iVYWbTgFXDUO+MMUHhZ7+9rYdA7xemHFeeU/9Uj0f
         oWcnWBWNZ3rIFypUGc6xOtTDLVXHv9mi3LXQoN4j4nlJR3m6y7fxlrUSl/uiCQFCtHtk
         27X0uxU1YeKyW9mGjttZoezIPjWlY72spTX7GaOzJgUa2UQsFHwoZSpEULBUqYpkbfH/
         cPqw==
X-Gm-Message-State: AJIora/Y4LxJu8csmYuHHUGFS0p1FJBlxvnedBFIfSipbFKi2IlO6bCw
        LytGX++dvUU19eUtfvKk6Vigx9uKs2tuNMyY1KTU
X-Google-Smtp-Source: AGRyM1vOzYL8y+rYaHubXte6XVU+zHTAwaKw4l5hfw2LEvmAQQHulkepcxbBzAjO3GZRm1rXAwzmuBMIM7rYOPMx+fg=
X-Received: by 2002:a05:6512:3503:b0:481:4470:4128 with SMTP id
 h3-20020a056512350300b0048144704128mr2025991lfs.303.1656532122803; Wed, 29
 Jun 2022 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org> <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com> <878rpgpvfj.fsf@gnu.org>
In-Reply-To: <878rpgpvfj.fsf@gnu.org>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 29 Jun 2022 12:48:31 -0700
Message-ID: <CAGG=3QVNid_s5QFCtPF1hVChsm89hax=KuHTt8Z=huP+CV_edQ@mail.gmail.com>
Subject: Re: plumbers session on profiling?
To:     "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     Ruud van der Pas <ruud.vanderpas@oracle.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have experience in this area with our internal production kernel.

-bw

On Wed, Jun 29, 2022 at 2:00 AM Jose E. Marchesi <jemarch@gnu.org> wrote:
>
>
> [Added linux-toolchains@vger in CC]
>
> It would be interesting to have some discussion in the Toolchains track
> on building the kernel with PGO/FDO.  I have seen a raise on interest on
> the topic in several companies, but it would make very little sense if
> no kernel hacker is interested in participating... anybody?
>
> > Hi Nick,
> >
> > Apologies for the delay. It's been a busy week with gprofng related work.
> >
> >> If you're still considering attending Linux Plumbers conf, please
> >> submit a proposal:
> >> https://lpc.events/event/16/abstracts/
> >> Please make sure to select "Toolchains Track" as the "Track" after
> >> clicking on "Submit new abstract."
> >
> > Thanks for asking!
> >
> > Our presence largely depends on a discussion on kernel profiling and
> > to see what we might be able to do with gprofng regarding this.
> >
> >>From our side, the main person will be Vladimir. He knows the code
> > inside and out, but I will also try to attend such a session.
> >
> > Is there any news regarding such a session on kernel profiling?
> >
> > Kind regards, Ruud
> >
> >>
> >>>
> >>> Kind regards, Ruud
> >>>
> >>>> On 24 May 2022, at 12:24, Jose E. Marchesi <jemarch@gnu.org> wrote:
> >>>>
> >>>>
> >>>> I am adding Ruud van der Pas in CC. He works in gprofng and would be
> >>>> willing to participate in a discussion on kernel profiling.
> >>>>
> >>>>> (Re-sending with Vladamir's email addr fixed; sorry for the noise)
> >>>>>
> >>>>> On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
> >>>>> <ndesaulniers@google.com> wrote:
> >>>>>>
> >>>>>> Hi Sami, Bill, Jose, and Vladamir,
> >>>>>> Jose and I are currently in the planning process to put together a
> >>>>>> Kernel+Toolchain microconference track at Linux Plumbers Conference
> >>>>>> this year (Sept 12-14) in Dublin, Ireland.
> >>>>>>
> >>>>>> Would you all be interested in leading a session discussing various
> >>>>>> profiling related topics such as:
> >>>>>> * gprofng
> >>>>>> * PGO
> >>>>>> * AutoFDO
> >>>>>>
> >>>>>> Would others find such a discussion useful?
> >>>>>> --
> >>>>>> Thanks,
> >>>>>> ~Nick Desaulniers
> >>>
> >>
> >>
> >> --
> >> Thanks,
> >> ~Nick Desaulniers
