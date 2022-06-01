Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613053A597
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbiFAM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiFAM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:59:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B2120A3;
        Wed,  1 Jun 2022 05:59:51 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-306b5b452b1so17642587b3.1;
        Wed, 01 Jun 2022 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BqBLWoNu4B19J1Fspc2SAHZEi09XiRE7XyWJyBtdXI=;
        b=Uy6ZSBgjed02+E2fMw0xKiNmN82sv0yobPE8khGV873qgMLIwDwAeTyqtzeZ5QBFlD
         j7KkJo50kZiEGEokdat0X5GacsYGz4UT/3NRWi7Jn4zTXfhJayUQ14hPLOU3NcIB9Sav
         LbXjrL+5P74mStixCyakpj5byNs9VRUi20bByV8JfVsu+17/CmNWImqcKWYmP5o+76Rn
         uteCFMwPDAotIbzRdFl8FCktgyk612VrqvRMIGB5JftCiPIK7DepLE/dXDSHv0KuI+33
         ZK8f+HwvTUVTl6G7cINeS3jkOvPe1nw/NXuaCchpltovpDscZvj98Bi55pYiq3OySSDV
         NgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BqBLWoNu4B19J1Fspc2SAHZEi09XiRE7XyWJyBtdXI=;
        b=FbCUdA6igGSWDZGavrtt54orNRcteDBs1FSTCwojkHVn4rQJRqEHaJZNLPRp/hUoEg
         KFeF1ro/AJq4E3V4sR4+2MrPFxFTOL7XBYBKOEWR7iNtVoFqnqqlW18D8uK9z0UbYTGT
         tyx73qQ8Oj8qsIHLAiWi5YWoNu/TLrj2/5+0aWegKTcfJUpZAbByahALTOT/fjmCmFt8
         mWH+yCV0CSt+3WOQ6ZruzyF1F2TdKu4TXSCz1Vaj9bOjQkWjyAh3ccAHxgyWxblVyY+h
         v9OIWDuyTOqXVm7KzqJCHlOvnjKmxjOdKAD9nWfexicygw5WjP3tX3elAB8W0COpChzR
         AKUg==
X-Gm-Message-State: AOAM531KDcPrx4EufCKPPTCNE/Qhw2DJXhSWZ22YKDRX/mRRnHJoubjk
        1/9rkGzp4XHvYMQsxKx4/WuupfErmFwr/nkUa1TPm9+m
X-Google-Smtp-Source: ABdhPJyF/ZTRrecG2Ztj6/kVSuGD3ioIxzwAowB8jNZKCcH0dY8zyUa4x6AuqMeup2HB/K6WP/CFUWeqdUoTaa/CCMY=
X-Received: by 2002:a81:4ecc:0:b0:2ff:5ba5:6239 with SMTP id
 c195-20020a814ecc000000b002ff5ba56239mr69932035ywb.233.1654088390579; Wed, 01
 Jun 2022 05:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <YpdOBmEmkG0AaOX0@debian> <CAK7LNATjJ-n2FM28FvK6iof=DDs073MJ_fDmvgVGymQvRQj_gw@mail.gmail.com>
In-Reply-To: <CAK7LNATjJ-n2FM28FvK6iof=DDs073MJ_fDmvgVGymQvRQj_gw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 1 Jun 2022 13:59:14 +0100
Message-ID: <CADVatmNf0DzuaL7ESgCSZV2mQjMdx=X9YD3FRJ-bKRj_-W6T2Q@mail.gmail.com>
Subject: Re: mainline build failure due to f292d875d0dc ("modpost: extract
 symbol versions from *.cmd files")
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 12:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jun 1, 2022 at 8:31 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > The latest mainline kernel branch fails to build for csky allmodconfig
> > with the error:
> >
> > ._divsi3.o.cmd: No such file or directory
> > make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
> > make: *** [Makefile:1160: vmlinux] Error 2
> >
> > git bisect pointed to f292d875d0dc ("modpost: extract symbol versions from *.cmd files")
> >
> > I will be happy to test any patch or provide any extra log if needed.
> >
> >
> > --
> > Regards
> > Sudip
>
> A patch exists, and is already queued up in linux-next.
>
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220529042318.2630379-1-masahiroy@kernel.org/
>
> I will send a pull request this week.

Thanks and I can confirm it fixes the build for me also.


-- 
Regards
Sudip
