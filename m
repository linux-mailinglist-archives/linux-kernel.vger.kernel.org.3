Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2250E789
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiDYRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiDYRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:54:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3F105D5E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:51:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n14so6835993lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4CKusOmKFpB//zpJna6TMOVyVV+HbHdecXxRDxqWJE=;
        b=KbnauGYZbd2ceBOD/lP8RHEg9djTXfQAqnpQ28WeYUkk5sNd18iz3LlronhYaLANkw
         pg5xLLuZraGQoEPZe2/GSkeSMbrvolPyxjnwwA1FoiNfOfiwSWUhV20aJXNOVAYV0Ry2
         cwllTyb3FXsbfpuBFn2xTo2Efq34vbdmn/ZN/QXPOoaAMDV8mCVaVu+NdWEMwGLowlJO
         9QoN6avMZS3/+VHZaHXMN1wn5v2Zl1NQzcuUZ9k2rmJCRKd3YOVbJP5ddUmAFfqMts1B
         3D6z8Z7yUMhAcEsXjjDw3FrQE4cz5rKnBYsSi+IvBxi7ozMKqCAv90tLTFGCM0CD5H6r
         tkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4CKusOmKFpB//zpJna6TMOVyVV+HbHdecXxRDxqWJE=;
        b=s/4MwN95vE4iy8dQDHUgMnxmoZt8KSP4SZnxcxqj1TjsUi9d96DvAu9L16ER8xwPRz
         T1gBwc/TpCn/8ae4TGVTT6wQcUyUT1wOr4Ny7vvuhpjeYxhKYgs9fD9fpGPlZGb+qFmL
         zCZz9rOM/r+i/miyxPErv+DDT7ioOwh3iHwZybfgXL+MGs7LQQkFcsMyJCqA7/kZJXCt
         Dnk4z1JsAK+oiZ0mlhGzPqkb8ZS6BqYyZhhVxo8PQ1JZ/sdhiyiEq8+H1pp1hYBJOgyc
         oRPVSsNOTH/aQSiyF+nZIP3ryV35Xw9z0c5ksie5hfkTKPnbz9EZSv0Hil6NzupY4fu1
         mPQA==
X-Gm-Message-State: AOAM532MnOZ4dACo8TF3vKTQ9l4Vs7pzGxOamqLScJHzj4bThwpgrrLw
        b2PlnuXh3ncO8vX6Mc41YQ1960/KhP2tU6k4kDnucg==
X-Google-Smtp-Source: ABdhPJzYxIj3xqgaFZ1xKTponeM1pO9KPmIP8f/N+5TRbu+uuD3iTwOshtcQQhkuqn75wv91nWbwA0TMDleufJhexPw=
X-Received: by 2002:a05:6512:1d1:b0:471:f63a:b182 with SMTP id
 f17-20020a05651201d100b00471f63ab182mr9658870lfp.392.1650909102664; Mon, 25
 Apr 2022 10:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmwyFDYKMpq0dcvbq06drtZonpNJ3PqLx2RMBE00beHZA@mail.gmail.com>
 <CAK7LNARx_z1Cv4YOkYkdbgrv3PKVa3msHh8mCZDFvYDib++4kQ@mail.gmail.com>
In-Reply-To: <CAK7LNARx_z1Cv4YOkYkdbgrv3PKVa3msHh8mCZDFvYDib++4kQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 10:51:30 -0700
Message-ID: <CAKwvOdnzHJX1+H2d4QxhtDS_W96Jq0YAgZJTHwHxmbHRVPx-uA@mail.gmail.com>
Subject: Re: plumbers session on syscall wrapping and kernel header libc
 circular depdence?
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Apr 24, 2022 at 9:45 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hello Nick,
>
> Sorry for the late reply.
>
> On Sat, Apr 16, 2022 at 2:48 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Hi Florian, Arnd, and Masahiro,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.
> >
> > Would you all be interested in a session (if you're planning on
> > attending) discussing syscall wrapping for libc's and UAPI circular
> > dependency on the libc?
> >
> > Masahiro and I were recently discussing the feasibility of building
> > the kernel UAPI header tests with -nostdinc, but there are some
> > interesting complications perhaps worth sharing with others?
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
> I am not sure about the travel at the moment.

Bummer.

> I may be able to attend it remotely if the the plumbers is held as a
> hybrid conference.

I think it will be.
https://lore.kernel.org/llvm/3119c35ba1fa7247e87d7acb56e85ea99092d0a4.camel@HansenPartnership.com/

> I am not quite sure how many developers would be interested in this topic,
> but we can continue discussion in the ML as well.

Ok, based on the feedback, we will scrap the idea for the topic. I
will follow up with the UAPI discussions on the list.
--
Thanks,
~Nick Desaulniers
