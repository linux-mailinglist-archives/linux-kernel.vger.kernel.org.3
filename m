Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7884EA869
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiC2HS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2HSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:18:53 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCE36164;
        Tue, 29 Mar 2022 00:17:06 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22T7Gkvh024200;
        Tue, 29 Mar 2022 16:16:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22T7Gkvh024200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648538207;
        bh=eB5aOkAFQlAmH94e981qffj77etAAcsA22OkA/A+Bc0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m6Fdy22GlFzKaqqdsUvqtwYhybL/cAL8rDtOX1449DnlLZxEQlEv1tM84PishqE1Z
         wyYH7kCnjJW2iK5Tmf+s1/oxY/i/ONDMA9Pn+p0sUWqxeY6FsTG2P37RJS1pbnY0HT
         gjAK0wdUcKdycESobtzfyym+5oDbiLP9mFHxbLjFhFlbfMP75o1tj1dYqpYnWy7LXe
         /uqTyU6tQCJvkSviOSRybRHA7kQV6on1470+GI8HfnahNB7gfj1qioEetXodxfi5A4
         sjO5VgKXS7EqyUoBU93IKwQC31caPuzFKoONFQ8yfdv5eFJbhxSb5xnAF6nFghqpAP
         D9WdR+/pLh1BQ==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so1911413pjf.1;
        Tue, 29 Mar 2022 00:16:47 -0700 (PDT)
X-Gm-Message-State: AOAM531PYcnm1YaJTwSRxQRddO8J1AGPxSXjfBJooMTc0vppnS1eYInS
        pKXTig/tBRFdgwJ9zESNAIgkESK72OIXjBYfic4=
X-Google-Smtp-Source: ABdhPJzhtt5iIobVj3UbcadBSRT4HTqkuuSmAs7DtZrXJ/kphKZ0E4Oc1c2XnDUFXIo9sSxBFNCP1cVzBndfwlEl4AU=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr28765352plp.162.1648538206462; Tue, 29
 Mar 2022 00:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220328172130.197319-1-masahiroy@kernel.org> <20220328172130.197319-2-masahiroy@kernel.org>
 <YkKhc2BbkmdVwKex@kroah.com>
In-Reply-To: <YkKhc2BbkmdVwKex@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Mar 2022 16:16:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0nuMXDjPzc37g_Pg-h+-iUOf8hrzqwZTF=N3RDUhosA@mail.gmail.com>
Message-ID: <CAK7LNAT0nuMXDjPzc37g_Pg-h+-iUOf8hrzqwZTF=N3RDUhosA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: forbid exported headers from including
 <stdint.h>, <stdbool.h>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 3:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 29, 2022 at 02:21:30AM +0900, Masahiro Yamada wrote:
> > Some UAPI headers included <stdlib.h>, like this:
> >
> >   #ifndef __KERNEL__
> >   #include <stdlib.h>
> >   #endif
> >
> > As it turned out, they just included it for no good reason.
> >
> > After some fixes, now I can compile-test UAPI headers
> > (CONFIG_UAPI_HEADER_TEST=y) without <stdlib.h> included.
> >
> > To avoid somebody getting it back again, this commit adds the dummy
> > header, usr/dummy-include/stdlib.h
> >
> > I added $(srctree)/usr/dummy-include to the header search paths.
> > Because it is searched before the system directories, if someone
> > tries to include <stdlib.h>, they will see the error message.
> >
> > While I am here, I also replaced $(objtree)/usr/include with $(obj), but
> > it is just a small refactoring.
> >
> > If we achieve the situation where none of system headers is included
> > from exported kernel headers (i.e. kernel headers become self-contained),
> > we might be able to add -nostdinc, but that is much far from where we
> > stand now. (see many no-header-test lines in usr/include/Makefile)
> >
> > As a realistic solution, you can forbid header inclusion individually by
> > putting a dummy header into usr/dummy-include/.
> >
> > Currently, no header include <stdbool.h>. I put it as well before somebody
> > attempts to use it.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Nice work!
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


I made a mistake in the patch subject.

The correct title should be:

    kbuild: forbid exported headers from including <stdlib.h>, <stdbool.h>

I will fix it in v2.



We cannot ban <stdint.h> for now because there are still some users.

A fix-up patch exists, but the fuse maintainer was opposed to it.
https://lore.kernel.org/lkml/20220318171405.2728855-1-cmllamas@google.com/



-- 
Best Regards
Masahiro Yamada
