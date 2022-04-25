Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB550D875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiDYEsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiDYEsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:48:25 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CA630B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 21:44:52 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23P4iae3003089;
        Mon, 25 Apr 2022 13:44:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23P4iae3003089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650861877;
        bh=eXtnkq15f32F+dq4gvLxxREDloNqTab17KTvabJawdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0PT6vvPiMccgBL21PVKDbkrYYrkHF6hvriHDGpu/bG84+d/gTqmkHSUbF43W8lTj3
         K5aTL8jEqohOicko2BOlQygdCTXwL/XAw/Ku8ka7Ei6b0UeQSLcNRoVLfIh9OTrybB
         +uksMZClTTM67WyRQKkUfa3z+pMvzn857QDxkJmkTsshR0L4OdJW7ljYn0TbHE7AJE
         O+Q6rn5N1RWn1NIj4LIJEfXtQNpPCBC9mj/Jq9bs+/FzDwUv/bIXL+C4hFN75PyuE9
         f9buAz7YrObWC2aGnyr4E5IMRSZa+5Kx4nuDhzvOddQ90X6GzulCC4qmnHRHiJg6PZ
         B1tjsZRKZdXOg==
X-Nifty-SrcIP: [209.85.215.180]
Received: by mail-pg1-f180.google.com with SMTP id v10so1333977pgl.11;
        Sun, 24 Apr 2022 21:44:37 -0700 (PDT)
X-Gm-Message-State: AOAM532F6lAzkhBeO5iHbbT/iFCfY7tQtrxKQW9AFRZdxf1tU683x/Aj
        RwYWtQ1uhLktiiDf/JG4Nywyh+ykLlKwmlnsfFk=
X-Google-Smtp-Source: ABdhPJx0G06+SVFeAfanWZgl4Wt1aq8jSyAW3//gm+gaqO8zChYq9THeWCes77xvYw4BxAmfT1sE3Kw9TcV5DS7Z7Dk=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr17038240pfj.32.1650861876491; Sun, 24
 Apr 2022 21:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmwyFDYKMpq0dcvbq06drtZonpNJ3PqLx2RMBE00beHZA@mail.gmail.com>
In-Reply-To: <CAKwvOdmwyFDYKMpq0dcvbq06drtZonpNJ3PqLx2RMBE00beHZA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Apr 2022 13:43:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARx_z1Cv4YOkYkdbgrv3PKVa3msHh8mCZDFvYDib++4kQ@mail.gmail.com>
Message-ID: <CAK7LNARx_z1Cv4YOkYkdbgrv3PKVa3msHh8mCZDFvYDib++4kQ@mail.gmail.com>
Subject: Re: plumbers session on syscall wrapping and kernel header libc
 circular depdence?
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

Sorry for the late reply.

On Sat, Apr 16, 2022 at 2:48 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Florian, Arnd, and Masahiro,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
>
> Would you all be interested in a session (if you're planning on
> attending) discussing syscall wrapping for libc's and UAPI circular
> dependency on the libc?
>
> Masahiro and I were recently discussing the feasibility of building
> the kernel UAPI header tests with -nostdinc, but there are some
> interesting complications perhaps worth sharing with others?
> --
> Thanks,
> ~Nick Desaulniers


I am not sure about the travel at the moment.
I may be able to attend it remotely if the the plumbers is held as a
hybrid conference.

I am not quite sure how many developers would be interested in this topic,
but we can continue discussion in the ML as well.

-- 
Best Regards
Masahiro Yamada
