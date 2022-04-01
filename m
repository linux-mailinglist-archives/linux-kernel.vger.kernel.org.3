Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3C4EF796
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbiDAQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350404AbiDAQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:13:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBD8CC53A;
        Fri,  1 Apr 2022 08:39:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so6685734ejb.4;
        Fri, 01 Apr 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PeXk7Ks+fNVGI2/bl+W72hWsR2c/g3dfM5gY6CT867Q=;
        b=Rp7ne8oDad6XcRIlLfpw/9pQd8HXNWf99qahudH0TbQmMk/jdKmCop8mweJieYHEoh
         m5nkE6Mz/JFKIq+8Lx1O+UbVzwoNyRDG+CnH6DJjlAXnBqjUNiG8qICQCLAYjyzrOgij
         XKRvYmijSQy5NsQNNEAxvjrhum6RQkB4xYBWDi3h6FL0QnI4BbNDvpvjkDbC9Xp9krUW
         //NQBllwVlBRCu1/IxgcuXmmar8POPpLY7yiO2zSwUF2AOCV4vOpf6gYSCKBJWrZcu8O
         RCzLt0mdHcl+gg+ya4zfRgVkvJeEgrzZ16w65ALX9nmd/PDNN0onEHY1HmqkdlomHEMZ
         NSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PeXk7Ks+fNVGI2/bl+W72hWsR2c/g3dfM5gY6CT867Q=;
        b=wum/EfsrYwt7qmsYHM43ez4fKBTETinXGFMNyNdPhz6oXIDgBf5sesrlaMJ2C1x+if
         yBuOqjnypvoVPQR/8alaROmRej+OuXoifCymC34ZF8YcEOR/FG2ngHH2jNCrOyuAFAvk
         IHovNLA/WbNRgKJULGoaGqoYD4UY+tlPw3accDsKZnE/ty3t5BJDq8GYc0In/orzP/F7
         Vy4LZwqyECnsujB8ZIjykOXx2fyQK5Iwy8tUeVXFGTsfzR5BGhk/6hHbl8PNsOYJjYHT
         C6mWl/rWJRI5qC1e4wR/tAENUr30JJ65rOTJ5Mp3zkL1DEqd2ZfvjIrBijjtPwLEJtfR
         lE8Q==
X-Gm-Message-State: AOAM531mxLSryJyiBSzo7msUbXE3cxfMkpT7kZGOc4wxRqJS93xvZfZz
        pdmn6zcUsrNNhG0GV0y8qhE=
X-Google-Smtp-Source: ABdhPJyWp/Eh2olp3U5NWRmn07izDA0NLguhIkEt6HwxOfA08cYF3QYfMQFEQswwwVAQOSiMOvttxg==
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr348766ejc.754.1648827578994;
        Fri, 01 Apr 2022 08:39:38 -0700 (PDT)
Received: from Francescos-Air.fritz.box (host-79-3-210-6.business.telecomitalia.it. [79.3.210.6])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm1134220ejn.130.2022.04.01.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:39:38 -0700 (PDT)
Date:   Fri, 1 Apr 2022 17:39:36 +0200
From:   Francesco Duca <f.duca00@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Francesco Duca <s23265@iisve.it>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: use hostname -s along uname to obtain
 LINUX_COMPILE_HOST
Message-ID: <YkccuNfZOjQ0FQEJ@Francescos-Air.fritz.box>
References: <20220330182329.52310-1-s23265@iisve.it>
 <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
 <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com>
 <YkcU4mpNX7AsJgbg@Francescos-Air.fritz.box>
 <CAK7LNATvFnac4sSFkbtMT-+h6-jGNuCaJpNZOua0g5wg56vRjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATvFnac4sSFkbtMT-+h6-jGNuCaJpNZOua0g5wg56vRjQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ( <hostname> on Debian vs <hostname>.<domainname> on Arch Linux)

Actually, every time i compiled a kernel (on Arch/Ubuntu), KBUILD_BUILD_HOST it's always <hostname>
without <domainname>, while on macOS, KBUILD_BUILD_HOST is <hostname>.<domainname>

> As I said, it is not annoying.

I said it is annoying just because <hostname>.<domainname> is set on
macOS only and not on Linux (Arch or Ubuntu).

Now, it may be a "me only" problem, so i'm not sure, but from my
experience it only happens on macOS.

On Sat, Apr 02, 2022 at 12:22:55AM +0900, Masahiro Yamada wrote:
> On Sat, Apr 2, 2022 at 12:06 AM Francesco Duca <f.duca00@gmail.com> wrote:
> >
> > >And, the intention of this patch is,
> > >print  Francescos-Air if the 'hostname -s' command is available,
> > >but Francescos-Air.fritz.box  otherwise, correct  ?
> >
> > Yes exactly, this is the intention of this patch
> >
> > >error message because   "2>/dev/null" is missing ?
> >
> > It is missing indeed, i forgot to add it.
> >
> > I will send a new v2 patch in a while
> >
> > On Fri, Apr 01, 2022 at 11:19:22PM +0900, Masahiro Yamada wrote:
> > > On Fri, Apr 1, 2022 at 11:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 31, 2022 at 3:23 AM FraSharp <f.duca00@gmail.com> wrote:
> > > > >
> > > > > From: Francesco Duca <s23265@iisve.it>
> > > > >
> > > > > * On some systems (e.g. macOS), using commands like 'uname -n' or
> > > > >   'hostname' will print something similar to "hostname.domain"
> > > >
> > > >
> > > > Not only macOS, but also on Linux systems such as Fedora, Debian.
> > > >
> > > > 'uname -s' or 'hostname' prints "hostname.domain"
> > >
> > > I mean,
> > >
> > >     'uname -n' or 'hostname' prints "hostname.domain"
> > >
> > >
> > >
> > > >
> > > >
> > > >
> > > > >   ("Francescos-Air.fritz.box" for example), which is very annoying.
> > > >
> > > > I do not think so.
> > > >
> > > >
> > > > >   What works instead is 'hostname -s', which will only write hostname
> > > > >   without the domain ("Francescos-Air" for example),
> > > > >   but also keep 'uname -n', as some systems as Arch Linux does not have
> > > > >   'hostname' as command.
> > > >
> > > > If so, on Arch Linux, will this patch spit
> > > >   hostname: command not found
> > > > error message because   "2>/dev/null" is missing ?
> > > >
> > > >
> > > > And, the intention of this patch is,
> > > > print  Francescos-Air if the 'hostname -s' command is available,
> > > > but Francescos-Air.fritz.box  otherwise, correct  ?
> 
> I do not see a good reason to output different strings on different
> distributions.
> ( <hostname> on Debian vs <hostname>.<domainname> on Arch Linux)
> 
> 
> <hostname>.<domainname> is just fine.
> As I said, it is not annoying.
> 
> NACK.
> 
> 
> 
> 
> 
> 
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > * This commit is complementary to
> > > > >   1e66d50ad3a1dbf0169b14d502be59a4b1213149
> > > > >   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
> > > > >
> > > > > Signed-off-by: Francesco Duca <s23265@iisve.it>
> > > > > ---
> > > > >  scripts/mkcompile_h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> > > > > index ca40a5258..6054e3eee 100755
> > > > > --- a/scripts/mkcompile_h
> > > > > +++ b/scripts/mkcompile_h
> > > > > @@ -34,7 +34,7 @@ else
> > > > >         LINUX_COMPILE_BY=$KBUILD_BUILD_USER
> > > > >  fi
> > > > >  if test -z "$KBUILD_BUILD_HOST"; then
> > > > > -       LINUX_COMPILE_HOST=`uname -n`
> > > > > +       LINUX_COMPILE_HOST=$(hostname -s || uname -n)
> > > > >  else
> > > > >         LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
> > > > >  fi
> > > > > --
> > > > > 2.32.0 (Apple Git-132)
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > > Masahiro Yamada
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
