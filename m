Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B753A463
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352987AbiFALvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352970AbiFALuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:50:51 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69F57163;
        Wed,  1 Jun 2022 04:50:50 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 251BoWtW017272;
        Wed, 1 Jun 2022 20:50:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 251BoWtW017272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654084233;
        bh=NATsHGCbKK8PLdAiZ14t0wK1RPAlU5XauGOgv25vz2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FcxrU9gUfili9Q5SstEgSpxLaaV0nz3bM0Yy8fKMH+6R5J9RfiQpf1/ZY4iK/bACG
         3Zo4oft8Ri09tR/v9CCnUC2XE7okwtkz6yDTqIu/65BmCH1mI2sYtf1ObBXfQq8NWj
         v+Hmjv90XiAnPyVNjujZHJMojQedtPzYuFMKfCytuWqRfrmclK5auD2V78EpUYTBWV
         7d3rt94Jl0LsWysMIZEv34HH3S8k/TQ9/xYum6sK9jxDAq06z7EBp0O1zOzRGkFxZ3
         stFvI1HjNwnUs+96Oh4rs2l2OJy3B/6Eih4MrlVIOa3+ETT9C4bPn9iG62kK6LiAJR
         /a2+s4Rm85JvQ==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id i1so1561459plg.7;
        Wed, 01 Jun 2022 04:50:32 -0700 (PDT)
X-Gm-Message-State: AOAM532y68Wi9imx6VZfx5b9EKrWwYV7LfM8pKvJpGPcd8OWaSFzRKa0
        Nfdid7wgqDfEOhwqyHTHMXBH4JFFFB1cr/Wa06k=
X-Google-Smtp-Source: ABdhPJyuQ86Chu9+Z6HG3rMD5E8egdmdsP1qvRPB7VUu7U3nrj9aJIk50Z/W4oqMDRDJ4D05ERPURs1SKzSx1NIG6WY=
X-Received: by 2002:a17:902:f68f:b0:162:23c6:e61b with SMTP id
 l15-20020a170902f68f00b0016223c6e61bmr48058326plg.136.1654084232131; Wed, 01
 Jun 2022 04:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <YpdOBmEmkG0AaOX0@debian>
In-Reply-To: <YpdOBmEmkG0AaOX0@debian>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Jun 2022 20:49:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjJ-n2FM28FvK6iof=DDs073MJ_fDmvgVGymQvRQj_gw@mail.gmail.com>
Message-ID: <CAK7LNATjJ-n2FM28FvK6iof=DDs073MJ_fDmvgVGymQvRQj_gw@mail.gmail.com>
Subject: Re: mainline build failure due to f292d875d0dc ("modpost: extract
 symbol versions from *.cmd files")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 8:31 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build for csky allmodconfig
> with the error:
>
> ._divsi3.o.cmd: No such file or directory
> make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
> make: *** [Makefile:1160: vmlinux] Error 2
>
> git bisect pointed to f292d875d0dc ("modpost: extract symbol versions from *.cmd files")
>
> I will be happy to test any patch or provide any extra log if needed.
>
>
> --
> Regards
> Sudip

A patch exists, and is already queued up in linux-next.

https://patchwork.kernel.org/project/linux-kbuild/patch/20220529042318.2630379-1-masahiroy@kernel.org/

I will send a pull request this week.


-- 
Best Regards
Masahiro Yamada
