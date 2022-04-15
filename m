Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8249B502E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbiDORUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiDORU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:20:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3634F9C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:18:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u19so14933574lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iS0+HG7ppU7CKCESRGpHVtK2c0Z1R6B4jgH5kiji7QQ=;
        b=F+sP503RIL9KnXQKFdw8jFLgM3dZlF/04PJ2kbfhxrIPN8Yhalc4DyWAUkxYtxEMrJ
         6bpDPGxbX5lWWQY+UrqYLwmhf4TOMq1HomOXo6Ise88EsvgtWPbA16ZQC5HToYsBVvWj
         xFKWWY4dyZoFOYnAM8yJ1ZJzApEuz8pBi7ayyQMZh5S5B7pvlsPanNXiYsiNEAsfqjIP
         T/hVCQxrw1DsiAOoppGY6NEe7Qb46C55TTHnI5LshCw1Da65ed//UKa4Y1AKT6SqAeoz
         SYTVrEua5tfScXJxSK9v/ctW6IVtJ3NMaVZGxyunlygcB1GB4POJvBW4pwdkfEFLruJp
         Vm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iS0+HG7ppU7CKCESRGpHVtK2c0Z1R6B4jgH5kiji7QQ=;
        b=p3QYj6Y+odbKOg788IDJm2JanSDd0Oksry0KqTRnIqfPzksOr8eknXz9nn0tHZ2zq+
         CUP6ZRn6cGLrJx+wf3vOIcMggkpRJi/sTdCWsrvIKHTmBE/CmAeRi1EXlUBDSfuPZglh
         XbKxVZD9sFFM+sZ3uC152QrOq1bNIQZi5xfkUoSeirNurimAYEjX/De6aQ4Z6CN06uMa
         8OBJxN8GuiUWSi1kMMy8qt6A5Xacjn95xK48+vtbkpByMc2PcOF3es1S+IPbhbzItzMg
         R5cFGaY1PyBtoYI1Em57uuCMrwNX7kNP8L694ciiC6D1+i/Y/10+69HGF4yIXMN26msS
         x6fA==
X-Gm-Message-State: AOAM531m0U6z5yqALUeJi9bFZspXS/VXRBzG4EFsEvvXp7gb/iU92cs0
        EQoKt5lt/YRBPKHblwQxNWLgSZg4os5JwqsKxBXX7w==
X-Google-Smtp-Source: ABdhPJz5of4FOiZi7NmycxKw8mSHActvr8uPwHDxx+aTPMtO/jpqtfkfOuFpJ3bGjiebmm/zAydSQ6u1oJBop708IOQ=
X-Received: by 2002:ac2:5313:0:b0:46d:ef7:c2db with SMTP id
 c19-20020ac25313000000b0046d0ef7c2dbmr28258lfh.392.1650043078292; Fri, 15 Apr
 2022 10:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
 <3DE35A81-1FC6-4EC7-8F3A-B395B576644D@oracle.com>
In-Reply-To: <3DE35A81-1FC6-4EC7-8F3A-B395B576644D@oracle.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 10:17:46 -0700
Message-ID: <CAKwvOd=CqOfd=zprWQPYoddgnGPJMb_sdk2Eut9DZNJq_fFJ-w@mail.gmail.com>
Subject: Re: toolchain mitigations plumbers session
To:     Qing Zhao <qing.zhao@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 15, 2022 at 7:50 AM Qing Zhao <qing.zhao@oracle.com> wrote:
>
> Hi, Nick,
>
> > On Apr 14, 2022, at 4:30 PM, Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
> >
> > Hi Qing, Kees, and Bill,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.
> >
> > Would you all be interested in leading another session on
> > kernel+toolchain collaboration for mitigations? Do you plan to attend
> > plumbers this year which will be in person?
>
> I=E2=80=99d love to attend  plumbers this year to meet people in person!
> But not sure whether there will be enough new, big stuff to report this y=
ear since mostly bunch of bug fixes and minor
> Improvements to the previous work.

No worries; it doesn't need to be a presentation, or just one person
presenting.  I think a quick review of newly developed features from
various authors, then a discussion with consumers (kernel developers)
would be beneficial.
--=20
Thanks,
~Nick Desaulniers
