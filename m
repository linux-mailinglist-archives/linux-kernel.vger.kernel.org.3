Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121575795EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiGSJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiGSJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:16:46 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878471FCD5;
        Tue, 19 Jul 2022 02:16:45 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 26J9GEOS019313;
        Tue, 19 Jul 2022 18:16:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 26J9GEOS019313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658222175;
        bh=E6Fkm5tCJlGuOKWaAMEh0ilTa5IY0MFugXH1W5B6FaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DfcznssbMealKDrdn4IXdRIBZ7GjmWfPe/ze3vNwUO2L6C4uzn+EwsiskwwEfIWNz
         H/CQUq7T6ZUCkrs0wvxXJqbXQGEPtS6pIqOhQGQtLvyMj3AYv2aaYA0jM4aE253QcY
         3cILq9DIvkjKjgjY6Zryl/YzkXt9z7oECboAjbObA40MyPXnDUxXdswyHjkR5rMg8L
         7ULlyKI7IISilSMu5kmq9QqYlczn9Yj4F9PTvYHbKFp+Ctqgs7oHhnIGvbMZMsfeC1
         /k/KNd3VZBdGKL6nLk4HGCOEFftENcehx6Mp+3NimqLPtNIvFB4DKNpogbGmNwFCDY
         ayo88BdrLgJ0w==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id n12so7788881wrc.8;
        Tue, 19 Jul 2022 02:16:15 -0700 (PDT)
X-Gm-Message-State: AJIora+HDSLk9M95VvJBeGrafEkPOpfbT5lvDPODOE6DscMPgpw3JWOt
        Pfvqq0G/QUiDMoSivteZW7spjL1b2BjW+4+Uk3M=
X-Google-Smtp-Source: AGRyM1t0LcKuGmlIJeETeYT7z2TiaHuzBecJ8jPSuoHQM9Xu+Ks2gE3l3ufKz54a41kTLel2HtK50jsvTgq9dzG1YDM=
X-Received: by 2002:adf:979b:0:b0:21d:868a:7f2f with SMTP id
 s27-20020adf979b000000b0021d868a7f2fmr25642176wrb.409.1658222173652; Tue, 19
 Jul 2022 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220719084149.29950-1-jslaby@suse.cz>
In-Reply-To: <20220719084149.29950-1-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 19 Jul 2022 18:15:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQa0QqEG1PLY3nr_ajP59d9cNU-0FBq2WGKnvEnZGJ1MA@mail.gmail.com>
Message-ID: <CAK7LNAQa0QqEG1PLY3nr_ajP59d9cNU-0FBq2WGKnvEnZGJ1MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Signed-off-by : Martin Liska" <mliska@suse.cz>
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
> Until the link-vmlinux.sh split (cf. the commit below), the linker was
> run with jobserver set in MAKEFLAGS. After the split, the command in
> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> is lost.
>
> Restore it as linkers working in parallel (esp. the LTO ones) make a use
> of it. In this case, it is gcc producing this warning otherwise:
> lto-wrapper: warning: jobserver is not available: =E2=80=98--jobserver-au=
th=3D=E2=80=99 is not present in =E2=80=98MAKEFLAGS=E2=80=99
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Signed-off-by: Martin Liska <mliska@suse.cz>
> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmli=
nux_o)
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>
> Notes:
>     [v2] only commit message updated


Did you read my previous email?

https://lore.kernel.org/linux-kbuild/CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4=
t-TFH_H344NOg@mail.gmail.com/






>
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 84019814f33f..886db0659d9c 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
>  endef
>
>  vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS=
) FORCE
> -       $(call if_changed_rule,ld_vmlinux.o)
> +       +$(call if_changed_rule,ld_vmlinux.o)
>
>  targets +=3D vmlinux.o
>
> --
> 2.37.1
>


--=20
Best Regards
Masahiro Yamada
