Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2B5795EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiGSJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGSJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:16:43 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC521FCD5;
        Tue, 19 Jul 2022 02:16:42 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 26J9GLma011815;
        Tue, 19 Jul 2022 18:16:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 26J9GLma011815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658222183;
        bh=wH/Tsl8zm14eAI6d32omduniRSdl18xFQNgRubEatAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FrgR6IlDBLEr3wUcTZFn/ehPN5pJYQ65vCZ0FDX7osYYvgOPI0J6LVJj0ez3ZUNbc
         zvUKAKN5jtRC4otLyEWTKWkzfgErCPfZPX3PUkEPunvKTZl7qpsItuWhnIWAW8tCcI
         WZD86LT9cAQGuElDbw0knxWMD56g1b8OnGZoRg3+CpfslbraZWd4TWXQaUn6CWIG8h
         YuvtC2zZLyaO+LPUbwXlMU1/Y8U/y3OIOABHg4xyVGpfZNxL9PcJgKFZBszfWuH3Pa
         aMWdaO67UL/7LVl+MA9KM2QoVpXYJHJy1B6HKXPQpaegK0QhseC4qpytEWr9ZF0ivc
         vm05t3Zhqv4yQ==
X-Nifty-SrcIP: [209.85.221.41]
Received: by mail-wr1-f41.google.com with SMTP id h17so20695952wrx.0;
        Tue, 19 Jul 2022 02:16:22 -0700 (PDT)
X-Gm-Message-State: AJIora/h+ICvQcFBzwsZg1OaNeeG/YKgP+JPBbazvznnPcB/nBmNGPdI
        FpTEmnbejRvxV1h9IY0vPapFeBVsyg0DDvHtCJI=
X-Google-Smtp-Source: AGRyM1uYA9Im/QslVsqIrAg9baewk1pEtoDjXsviWn2NdJKlZddmPPiGfYAjAUMXdjUCPsx6uWumJ0x2mIcr+k4P2Xc=
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id
 c12-20020a056000104c00b0021d87bf63a2mr25545803wrx.461.1658222181220; Tue, 19
 Jul 2022 02:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220719084149.29950-1-jslaby@suse.cz> <20220719084149.29950-2-jslaby@suse.cz>
In-Reply-To: <20220719084149.29950-2-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 19 Jul 2022 18:15:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNy6-W+9USiO1pEK1syj1M1fVB1Zda2NuDmPogVp4cmQ@mail.gmail.com>
Message-ID: <CAK7LNATNy6-W+9USiO1pEK1syj1M1fVB1Zda2NuDmPogVp4cmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: lto: preserve MAKEFLAGS for module linking
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 5:41 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> From: Martin Liska <mliska@suse.cz>
>
> Prefix command in makefile run in order to preserve access to jobserver.
> This is needed for gcc at least.
>
> Fixes this warning:
> lto-wrapper: warning: jobserver is not available: =E2=80=98--jobserver-au=
th=3D=E2=80=99 is not present in =E2=80=98MAKEFLAGS=E2=80=99


What is lto-wrapper ?

>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmli=
nux_o)
> Signed-off-by: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>
> Notes:
>     [v2] this is new in v2
>
>  scripts/Makefile.build | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index bb63374fb055..493f3c4e8461 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -247,8 +247,8 @@ endef
>
>  # Built-in and composite module parts
>  $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
> -       $(call if_changed_rule,cc_o_c)
> -       $(call cmd,force_checksrc)
> +       +$(call if_changed_rule,cc_o_c)
> +       +$(call cmd,force_checksrc)


cmd_force_checksrc invokes sparse.
How is it related to GCC?




>
>  # To make this rule robust against "Argument list too long" error,
>  # ensure to add $(obj)/ prefix by a shell command.
> @@ -457,7 +457,7 @@ endef
>  $(multi-obj-m): objtool-enabled :=3D $(delay-objtool)
>  $(multi-obj-m): part-of-module :=3D y
>  $(multi-obj-m): %.o: %.mod FORCE
> -       $(call if_changed_rule,ld_multi_m)
> +       +$(call if_changed_rule,ld_multi_m)
>  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)


cmd_ld_multi_m invokes $(LD) directly.
How is it related to gcc?






>
>  targets :=3D $(filter-out $(PHONY), $(targets))
> --
> 2.37.1
>


--=20
Best Regards
Masahiro Yamada
