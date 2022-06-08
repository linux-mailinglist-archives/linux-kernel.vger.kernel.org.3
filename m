Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11654267D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiFHGEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbiFHF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACA2945D7;
        Tue,  7 Jun 2022 21:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7C461902;
        Wed,  8 Jun 2022 04:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9220C341C6;
        Wed,  8 Jun 2022 04:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654661521;
        bh=H+1MmtTtvQLsNZTrmQNlzsqkx+xHxGbkSkRUBtO1cMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRmb41fbyr182sJHzxcwjxdxcL3B8RTZPEz7yItlT2aYivO23ePNfRY2ECLKyop+y
         gkoq0NvgN6nDP5ACdXjOe9osa2Lpgep3fs17rMK6M/xa03zYmg503ay4yYFxX8PaSr
         Ph9x1kYgG+SYvqrIQ44X0JreCP6Wh8r+5MemBTaN5zF3S7TWTcCAEOAxw7YGm0IoPY
         FTAdyvAYhh6mJzdyDbwuq4i1/X0kyA+pJiVtLv+L71SOH03TgjFsLlOwYoMOr7HzpT
         uS6XvU/QM2rf3Zw25GK/O8EMGcXnXJviBU0BIncFfktr9hFr3vg1E5bV9NhUWkg4fw
         Y9hCR6G3LeS6Q==
Received: by mail-lf1-f42.google.com with SMTP id a2so25178895lfg.5;
        Tue, 07 Jun 2022 21:12:01 -0700 (PDT)
X-Gm-Message-State: AOAM531yaWPeXuly/LlWqxO00zC1zt/6dt+eFWZS1o1AHOi+VA5Surec
        dc0v057WwdGDf8hjFHQn4tl98QPZkaE2Ky8FxLI=
X-Google-Smtp-Source: ABdhPJzJe/7j12uZOrVpl6r/1eUa9+dVSPDjLIDkUtz6kk9LZs9Ey/RjEjyXG6U7s6oL7B63aQjHbZ0lAKTa0QMZH8g=
X-Received: by 2002:a05:6512:4019:b0:479:2d65:dd9f with SMTP id
 br25-20020a056512401900b004792d65dd9fmr11811475lfb.275.1654661519839; Tue, 07
 Jun 2022 21:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220608011229.2056016-1-liyupeng@zbhlos.com> <4ebf3fb3-47c8-b4b4-e9b2-630e3f540316@roeck-us.net>
In-Reply-To: <4ebf3fb3-47c8-b4b4-e9b2-630e3f540316@roeck-us.net>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 8 Jun 2022 12:11:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H69N+ECH-V1VktcD2=EO-i+q1MMm0hB4FdQGyEpRoDKiw@mail.gmail.com>
Message-ID: <CAAhV-H69N+ECH-V1VktcD2=EO-i+q1MMm0hB4FdQGyEpRoDKiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Loongson-3: fix compile mips cpu_hwmon as
 module build error.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yupeng Li <liyupeng@zbhlos.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        caizp2008@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Wed, Jun 8, 2022 at 9:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/7/22 18:12, Yupeng Li wrote:
> >    set cpu_hwmon as a module build with loongson_sysconf, loongson_chip=
temp
> >    undefined error,fix cpu_hwmon compile options to be bool.Some kernel
> >    compilation error information is as follows:
> >
> >    Checking missing-syscalls for N32
> >    CALL    scripts/checksyscalls.sh
> >    Checking missing-syscalls for O32
> >    CALL    scripts/checksyscalls.sh
> >    CALL    scripts/checksyscalls.sh
> >    CHK     include/generated/compile.h
> >    CC [M]  drivers/platform/mips/cpu_hwmon.o
> >    Building modules, stage 2.
> >    MODPOST 200 modules
> > ERROR: "loongson_sysconf" [drivers/platform/mips/cpu_hwmon.ko] undefine=
d!
> > ERROR: "loongson_chiptemp" [drivers/platform/mips/cpu_hwmon.ko] undefin=
ed!
> > make[1]: *** [scripts/Makefile.modpost:92=EF=BC=9A__modpost] =E9=94=99=
=E8=AF=AF 1
> > make: *** [Makefile:1261=EF=BC=9Amodules] =E9=94=99=E8=AF=AF 2
> >
> > Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> > ---
> >   drivers/platform/mips/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kcon=
fig
> > index d421e1482395..6b51ad01f791 100644
> > --- a/drivers/platform/mips/Kconfig
> > +++ b/drivers/platform/mips/Kconfig
> > @@ -17,7 +17,7 @@ menuconfig MIPS_PLATFORM_DEVICES
> >   if MIPS_PLATFORM_DEVICES
> >
> >   config CPU_HWMON
> > -     tristate "Loongson-3 CPU HWMon Driver"
> > +     bool "Loongson-3 CPU HWMon Driver"
> >       depends on MACH_LOONGSON64
> >       select HWMON
> >       default y
>
