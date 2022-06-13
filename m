Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029C549EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiFMUT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351062AbiFMUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:19:38 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD796C9666;
        Mon, 13 Jun 2022 11:58:03 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25DIvX4l017197;
        Tue, 14 Jun 2022 03:57:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25DIvX4l017197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655146654;
        bh=KR8rceanybxTk7+LdtKBIxFqm0gjPvri8QwONiUxCUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZJDPS7U89vRf81QlroMlw0cJnmmeNfyyugJCw+3R9R8hf/YVoww1HeL7EEw8nVde
         9g4Oat65wBCfTlMGdzit4WvFnk5HrT8fjRtEn4zhxOfjTZO4OcqvSX5fpd68TacVhY
         O1ZHlxtp4qogMURz6oPvFiZ8YT1d/amodymmQ6+oRqvPCjpOUQ84Ctg2x4lq8PFBeb
         TrXvI12l0xTQAt3XPWewbHPQSrf0f7+Pvs6RdVkDFMRWlkD7ZuNx4lEWSgt+cSbKfZ
         VsPuRjIXvKL0Sfvpsnp8I4RPBTJbAykH1hqgDNVWDuKizBGXIqDS3kO3poxsZ7Zcuv
         ZYh1WPp8V5a4A==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id a15so8274777wrh.2;
        Mon, 13 Jun 2022 11:57:34 -0700 (PDT)
X-Gm-Message-State: AJIora+3P34vXFP2vK6aPIapItLo0LLEE4r9UZR4ww8LKF0MQEMFKSvr
        1yJbWeryT5qFMteNvhDvT61Ja5kwQ8BBAxApw7s=
X-Google-Smtp-Source: AGRyM1t6enc2nLTTCt2kayaK2+aM97UQczq6PTzHmwGjiCjz1JAwCG0KHDLkGg31ALp1VU56Waio4WShRS8Ars9KOWc=
X-Received: by 2002:a5d:69ca:0:b0:21a:536:61ba with SMTP id
 s10-20020a5d69ca000000b0021a053661bamr1146995wrw.235.1655146652598; Mon, 13
 Jun 2022 11:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org> <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
 <CAK7LNAQ3p2XiLO7tJSJ9JWnqRomCwjYeQy-Z3j0m904Yn6Av_g@mail.gmail.com> <f6fbf06a-6507-a908-33ed-1218713de09b@digikod.net>
In-Reply-To: <f6fbf06a-6507-a908-33ed-1218713de09b@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Jun 2022 03:56:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKT=em99+BY79yWu-i+1O+uDt19pGpw3P=9=baS1AEYQ@mail.gmail.com>
Message-ID: <CAK7LNARKT=em99+BY79yWu-i+1O+uDt19pGpw3P=9=baS1AEYQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 build
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 3:06 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
> On 13/06/2022 16:55, Masahiro Yamada wrote:
> > On Mon, Jun 13, 2022 at 9:34 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >>
> >>
> >>
> >> On 11/06/2022 19:22, Masahiro Yamada wrote:
> >>> Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
> >>> valid") was applied 8 months after the submission.
> >>>
> >>> In the meantime, the base code had been removed by commit b8c96a6b466=
c
> >>> ("certs: simplify $(srctree)/ handling and remove config_filename
> >>> macro").
> >>>
> >>> Fix the Makefile.
> >>>
> >>> Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
> >>> included from certs/blacklist_hashes.c and also works as a timestamp.
> >>>
> >>> Send error messages from check-blacklist-hashes.awk to stderr instead
> >>> of stdout.
> >>>
> >>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are =
valid")
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>
> >> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> As a side note, it may let an orphan certs/blacklist_hashes_checked fi=
le
> >> but we can't really do something about that and it's OK.
> >
> >
> > GNU Make uses timestamps of files for dependency tracking,
> > so Kbuild keeps all intermediate files.
> >
> > Keeping certs/blacklist_hashes_checked
> > is the right thing to do.
>
> blacklist_hashes_checked is the file you replaced with
> blacklist_hash_list, and is then not used in any Makefile anymore. There
> is then no timestamp issue. I just wanted to mention that it is normal
> that a git status will show it on build directories also used as source
> directories that were already using such feature.


Ah, sorry, I misunderstood your feedback.

If 'git status' is your concern,
we can add certs/blacklist_hashes_checked
to scripts/remove-stale-files.

addf466389d9d78f255e8b15ac44ab4791029852
was merged into mainline just recently, and
not contained in any release.

But, if the orphan timestamp matters, I will do it.
It is just a one-liner addition.






--
Best Regards
Masahiro Yamada
