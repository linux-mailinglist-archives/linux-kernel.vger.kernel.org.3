Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F14EF6EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbiDAPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353489AbiDAPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:37:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E02299A77;
        Fri,  1 Apr 2022 08:06:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j15so6425747eje.9;
        Fri, 01 Apr 2022 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1aIdSTD8TnyATUg/08ECyQi65DWuH9gNC6k+3hhp9Dk=;
        b=l7p4wBJj9lJIaiZLxB+EvoUVmuY93G/f1oiMuCwUSA0gYridJroVuNNR3AJ2aGLLT+
         9oU+txa+YoeSLF4Q36XTrmPtJKWL6RRwSVLqZMk2gpSb6JC/SJ0rpgLTSaaouzUdJpXZ
         ZscYjNDWx1vVKHAr+487KRYGnqapS1x6jDyvd3jFMS/qJtsFf6TjvRx2w7HwXgjSb8d4
         x3UhRDYlb54nDwjGCeUGe6ZjPJ4sioJeHFX1tq1ThYT3wSZg+h8OGLB5G+IKoKM8qrkK
         UiE9biavXIBl39hB2BOmg8M+ithsu9P1GJDkF19wvVaqc+0xpJzn8cG6JqlfPduYPW7v
         0VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1aIdSTD8TnyATUg/08ECyQi65DWuH9gNC6k+3hhp9Dk=;
        b=z5tba7vP5Um/d7cEMeSQLDNs4nZRK4hQQpIKNNN5SPhRDDBG9z/QAWrXSbOGO8fLDI
         Mp0eKVQMepKnO9uZpvhM8mZHpoz6gKLiZq5mrHsCPbeVyXViZf5rnFza4eCzm7wcevw2
         h9nAYUj2vLOtctekM6eEXAmBL6GQx9VDmJsXDeN4FJUKGkwbUP4yOHfsOUiNvLIPTn+c
         2ja9t4I0m+FjiHgEGEBUeSUknY/8eRXkjbBzM9d+3MDvC0mlKJdMIsp19ZCEyz/aHGYw
         ml5D/BvXgIUVjM3hRdp6hI0tAcqMPd6aRUi8doA0tsigjA4+B0vgze0tc0LLemI+6dvP
         ESDA==
X-Gm-Message-State: AOAM531uRbrsJbZTCVKWZJzb9JtP48gLwCmgIZ9tZOP2rmlCDb7XkqK7
        l2Mum2TPYUTJtEKLJ3x7Dd7HjWnqWm2TCg==
X-Google-Smtp-Source: ABdhPJwsmoYsLNouKjrforxkIwsJYsjRWlQ7xS1SqjEHAgbCjUtvNeqpR7jOsQQUMhysQQtEb7SGMA==
X-Received: by 2002:a17:907:9627:b0:6df:b95b:b028 with SMTP id gb39-20020a170907962700b006dfb95bb028mr214447ejc.568.1648825573025;
        Fri, 01 Apr 2022 08:06:13 -0700 (PDT)
Received: from Francescos-Air.fritz.box (host-79-3-210-6.business.telecomitalia.it. [79.3.210.6])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170907160600b006dff6a979fdsm1110522ejc.51.2022.04.01.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:06:12 -0700 (PDT)
Date:   Fri, 1 Apr 2022 17:06:10 +0200
From:   Francesco Duca <f.duca00@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Francesco Duca <s23265@iisve.it>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: use hostname -s along uname to obtain
 LINUX_COMPILE_HOST
Message-ID: <YkcU4mpNX7AsJgbg@Francescos-Air.fritz.box>
References: <20220330182329.52310-1-s23265@iisve.it>
 <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
 <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>And, the intention of this patch is,
>print  Francescos-Air if the 'hostname -s' command is available,
>but Francescos-Air.fritz.box  otherwise, correct  ?

Yes exactly, this is the intention of this patch

>error message because   "2>/dev/null" is missing ?

It is missing indeed, i forgot to add it.

I will send a new v2 patch in a while

On Fri, Apr 01, 2022 at 11:19:22PM +0900, Masahiro Yamada wrote:
> On Fri, Apr 1, 2022 at 11:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Thu, Mar 31, 2022 at 3:23 AM FraSharp <f.duca00@gmail.com> wrote:
> > >
> > > From: Francesco Duca <s23265@iisve.it>
> > >
> > > * On some systems (e.g. macOS), using commands like 'uname -n' or
> > >   'hostname' will print something similar to "hostname.domain"
> >
> >
> > Not only macOS, but also on Linux systems such as Fedora, Debian.
> >
> > 'uname -s' or 'hostname' prints "hostname.domain"
> 
> I mean,
> 
>     'uname -n' or 'hostname' prints "hostname.domain"
> 
> 
> 
> >
> >
> >
> > >   ("Francescos-Air.fritz.box" for example), which is very annoying.
> >
> > I do not think so.
> >
> >
> > >   What works instead is 'hostname -s', which will only write hostname
> > >   without the domain ("Francescos-Air" for example),
> > >   but also keep 'uname -n', as some systems as Arch Linux does not have
> > >   'hostname' as command.
> >
> > If so, on Arch Linux, will this patch spit
> >   hostname: command not found
> > error message because   "2>/dev/null" is missing ?
> >
> >
> > And, the intention of this patch is,
> > print  Francescos-Air if the 'hostname -s' command is available,
> > but Francescos-Air.fritz.box  otherwise, correct  ?
> >
> >
> >
> >
> >
> >
> > >
> > > * This commit is complementary to
> > >   1e66d50ad3a1dbf0169b14d502be59a4b1213149
> > >   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
> > >
> > > Signed-off-by: Francesco Duca <s23265@iisve.it>
> > > ---
> > >  scripts/mkcompile_h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> > > index ca40a5258..6054e3eee 100755
> > > --- a/scripts/mkcompile_h
> > > +++ b/scripts/mkcompile_h
> > > @@ -34,7 +34,7 @@ else
> > >         LINUX_COMPILE_BY=$KBUILD_BUILD_USER
> > >  fi
> > >  if test -z "$KBUILD_BUILD_HOST"; then
> > > -       LINUX_COMPILE_HOST=`uname -n`
> > > +       LINUX_COMPILE_HOST=$(hostname -s || uname -n)
> > >  else
> > >         LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
> > >  fi
> > > --
> > > 2.32.0 (Apple Git-132)
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
