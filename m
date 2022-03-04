Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102294CD4EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiCDNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiCDNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:13:17 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8B239D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:12:27 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbc48104beso90903017b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H2bUE5UsRsJ8ptX5NtZZM4AcJoObuD1URIhhCGz76U=;
        b=WhB6Wh48TEvBjTMv5sZSD54nnulAJ98TiG3gAlpuBqQcLeaGikVqYWVb/nhT8a5XdL
         yy2hwNvFmjgolm5P3uKxHN+2usV3ZsLzdIR9+xopAPcebCiRHAT26e6UquIRe9sP3NFk
         b4uQfK4KXV9leOilYP5YntZClBt/2p3OhyB7FypzGZiCzvYud137u1x/16P5AnpwKPXA
         MATxTbv4ooL9VCRFkrLEFjYTVhVPDa9oKeLFHNVFMTxvKXwl3S5xjrz2UMwYLJ2804kn
         FIcK4vbe6j4VBpwCQi8MLvPLCsLluqvS6oyRyjWXsfDkXXgSEcuR7Hq/OrZ1eGRwvSdx
         0hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H2bUE5UsRsJ8ptX5NtZZM4AcJoObuD1URIhhCGz76U=;
        b=DFlWUZtmA6bvam1PKFNLfR65H/EvTjg9eBucaE8/jufnWHOjtOrIySSBF8VfHyIaPw
         WN+Rr6LcjuMRdEBlMnDEQfeVTCm16wDK/M1rcZhXf41BTfMsJCyH0OAv88LNgZW0bqQ1
         zHuAITmY6RTDnsgZMFQmTORwfeudcFIydhr6Q9pjkgVGqUyYaNwUk0rPAshn/5268Uew
         fuQPP1/9jvs/bokhFRtGBrv1XZ3lkNX9eHC8PVDbTm03JsJBZpOjgsD7y4xHlN0QwrIF
         OBKsnosAaAdSrBuv9E0/A0DZgXf8Gl69ziBwUIEY73JiA+gRPnn610Z5UqsrZ5g4u5Gt
         EUIA==
X-Gm-Message-State: AOAM5311bqeFm2xoX7OZhSCUJoOT4ro5Gcm2XbDS2/gsle+n+kziUSpd
        3Y55BoXn+DJ6DVC8yhVS7XVk675LQW/RMVn/JuLbfOxpgJQ=
X-Google-Smtp-Source: ABdhPJxjkfwG98FgwOAXl83TLDHcTm1Al4pPfH1i7QQy4ifqoR9WTmSoh3auS2zPcJ0r2ugyjkD9CXiSzzilelN6HjQ=
X-Received: by 2002:a81:8985:0:b0:2dc:472:ff3f with SMTP id
 z127-20020a818985000000b002dc0472ff3fmr14307942ywf.333.1646399546204; Fri, 04
 Mar 2022 05:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20220304063427.372145-1-42.hyeyoo@gmail.com> <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
 <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 14:11:50 +0100
Message-ID: <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] slab cleanups
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 13:02, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Fri, Mar 04, 2022 at 12:50:21PM +0100, Marco Elver wrote:
> > On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > Changes from v1:
> > >         Now SLAB passes requests larger than order-1 page
> > >         to page allocator.
> > >
> > >         Adjusted comments from Matthew, Vlastimil, Rientjes.
> > >         Thank you for feedback!
> > >
> > >         BTW, I have no idea what __ksize() should return when an object that
> > >         is not allocated from slab is passed. both 0 and folio_size()
> > >         seems wrong to me.
> >
> > Didn't we say 0 would be the safer of the two options?
> > https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz
> >
>
> Oh sorry, I didn't understand why 0 was safer when I was reading it.
>
> Reading again, 0 is safer because kasan does not unpoison for
> wrongly passed object, right?

Not quite. KASAN can tell if something is wrong, i.e. invalid object.
Similarly, if you are able to tell if the passed pointer is not a
valid object some other way, you can do something better - namely,
return 0. The intuition here is that the caller has a pointer to an
invalid object, and wants to use ksize() to determine its size, and
most likely access all those bytes. Arguably, at that point the kernel
is already in a degrading state. But we can try to not let things get
worse by having ksize() return 0, in the hopes that it will stop
corrupting more memory. It won't work in all cases, but should avoid
things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
bounds the memory accessed corrupting random memory.

The other reason is that a caller could actually check the size, and
if 0, do something else. Few callers will do so, because nobody
expects that their code has a bug. :-)
