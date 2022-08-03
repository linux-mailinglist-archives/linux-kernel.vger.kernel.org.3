Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5097558915A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiHCR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiHCR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:26:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B9564DF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:26:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-32269d60830so178546987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=GFxAw/jBxe5LyMOP+HmBMT2P1a4JnHFp13BCTBWGaAQ=;
        b=S9GOm9JhkpXet5QE1g6qStdUS01m5oEGnSr+xoXFKylVXyDOjto9yj3KvBUKmkWYHQ
         QtriN3zqO/SCTIN7N289ER4t7VIU4mbb7r7xAQ+IUUK3q2PufBwzCYUJ4q+YB+2hA46n
         kDZYvRlVOT0GhCBLTrCZhbjWJogEtkf+Nh0e1uwp9xoqotk666gubA9i9DzFCCIxPJjZ
         rIXcZy7zzvvRdhvN8upFK0Ld8TerAmcZpsBIt8yX18aeys0qTpXLo6wFf8cy/2rbM5VD
         1DrlTtkPiROfJID3eSL+RZMaU7fVTKZeh6KukejUV8OKYfukA5RnU/D+ej7fz7b/wN+E
         Esjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=GFxAw/jBxe5LyMOP+HmBMT2P1a4JnHFp13BCTBWGaAQ=;
        b=luEvIuRbnSiGTSAGcN67sCsXlr4C3GPBQm4p7Lyn8kbgRQ6dMsvwMNzm0eD1yMa19/
         pbBvlAWr4WAxfYfSxjtYoW/EkmgaN63kqFxXukvkYKg9PyD50i4aWysBjYdPQ+ZRy8Ps
         YRk7t0PZmvHdvaMfiPtI+PzQEbKSfobJsufTY/mJzXmkQxBvB43vR6+Wc19NGxtxbN9j
         FCtxKHNVjKKmwTkT3linv9SvwzO1SPWVN2ebdgdOcCGp0MQ7bg0WdNAz+68wxDoIzw5a
         H5kDL+ZdfKloCDqTyfKTEhO95WVbiHIncx8n5e9tAabbh0uXloMr8kZj58nDGS0kHWxw
         ZO8A==
X-Gm-Message-State: ACgBeo3NdKTxykidGBL+EZvqt3S9/+eGWDQC/7Xrg/KifI/gSeD2ox2q
        nbqPmE3EgLt19867xfV97u/0AkFk0IAg0/TReKlems+QCjg=
X-Google-Smtp-Source: AA6agR7Pj2xv/8h3UZoq7GMEfel/PV3Cx0fY7u6nPz19urddu/CnfjbVwmAi8z7209lpFtoa6svstVuCqHFOmXbo1IQ=
X-Received: by 2002:a81:7586:0:b0:31f:658e:1ac7 with SMTP id
 q128-20020a817586000000b0031f658e1ac7mr25234452ywc.295.1659547563352; Wed, 03
 Aug 2022 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-12-glider@google.com>
 <20220702001806.1379-1-hdanton@sina.com>
In-Reply-To: <20220702001806.1379-1-hdanton@sina.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 19:25:26 +0200
Message-ID: <CAG_fn=VUOgfjzWEU+2dTs=gd0hdW9YEbT=sdW8wgx93c3cASTQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/45] kmsan: add KMSAN runtime core
To:     Hillf Danton <hdanton@sina.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jul 2, 2022 at 2:18 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri,  1 Jul 2022 16:22:36 +0200 Alexander Potapenko wrote:
> > +
> > +bool kmsan_internal_is_module_addr(void *vaddr)
> > +{
> > +     return ((u64)vaddr >=3D3D MODULES_VADDR) && ((u64)vaddr < MODULES=
_END);
> > +}
> > +
> > +bool kmsan_internal_is_vmalloc_addr(void *addr)
> > +{
> > +     return ((u64)addr >=3D3D VMALLOC_START) && ((u64)addr < VMALLOC_E=
ND);
> > +}
>
> Given is_vmalloc_addr(), feel free to add a one-line comment showing the
> reason for adding the kmsan internal version.

Ok, will do. I'm also going to move these two to mm/kmsan/kmsan.h, so
that they can be inlined.
Keeping internal versions allows us to not have these two functions
instrumented by KMSAN, which gains us some performance and (more
importantly) prevents potential recursion.

In fact right now the original is_vmalloc_addr() doesn't contain
instrumented memory accesses and is thus safe to be called from KMSAN
runtime without causing recursion.
I am not sure though whether we can rely on that remaining true, so I
added it along with the internal version of is_module_address(), which
actually has the problem.

> Hillf




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
