Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14F4E475E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiCVUWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCVUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:22:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F99657A9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:21:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x2so2922192plm.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OzgKQX00j77D35fg7pwuF5yWqtWZcjI+3JQituFaLCQ=;
        b=QgPuYPj8mFIyfXoUJGf4zaJXwCzD2PE3f8RlIStxC/NSba12o0kgL7nS/DpSyT3tXq
         /TfrD02ZwKXySbRTQ2X7BFtrYLC0q4obEWHN5jrCp5RVy6rOktKCV93ytEZmZdA7pU+9
         N6sxdJmyL1HEx/433DeFCKNlYmctiR3l/q8nby0qDJBRp+dV91SQId4aJNrSEwRe2QzC
         hx65g4DAdFyBbgKuEcJbQCvHk/2+7vRvpC4W/UXkeL0GP/Sw8mKtJFvpyQZOFsBz52Fe
         A6Adaz4DjJt3D8FpNmb8FGuztgtOT1vzX+tXelpZN4r5ki+zSrTwdsS1JEpyF1JNPV2v
         k7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OzgKQX00j77D35fg7pwuF5yWqtWZcjI+3JQituFaLCQ=;
        b=0ebGhQNHXeNYZ70YonPFQqAauScjKIxWTHs4b3UJpt7POrDgwDJiKSKU/TSnpTzV+q
         GuVPIq0i/lweZmvE+7tQn8J/kf/7i4zYpjT0e0Gnlnf+yzLEvDdnkeYn7+zwxEGZ0T8b
         kgU+9qTCSP3NgUiUssP8yNia7hUvjSvMwJ/puVGwDEdC1saiTZTnbIOjqXmiHMg4Zhq0
         fHDRcCDQuyd7YQcHNT60KmfrBf7P2KiKyaiIBibQ8LDfoMDT4AIpF+ln1GFtIoGHiNNB
         kQIwmSeGnFcwlTPm81X7Im8Z+h9YKz7nG1qtOr+YQ15wdF4NQu4FzqIYdmHRgYgencfx
         wG9A==
X-Gm-Message-State: AOAM532X0FARaxSwtYIrp0Uc/88iGvas4lOUqaSEdjBNImyyUv6dklcW
        xipN9kVFqhH1lSmA+Q2KkBEIPQ==
X-Google-Smtp-Source: ABdhPJwExt7xSpNVxNS9SolkdaicYIyWQLhE7Kl1FuO/CNsPN1cxEMx698OYo250+QpTB34Qid7eQw==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr16642693plr.3.1647980479095;
        Tue, 22 Mar 2022 13:21:19 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id me5-20020a17090b17c500b001c63699ff60sm3926048pjb.57.2022.03.22.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:21:18 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:21:14 +0000
From:   Chun-Tse Shao <ctshao@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org, DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4] config: Allow kernel installation packaging to
 override pkg-config
Message-ID: <YjovutS5McV8A8z4@google.com>
References: <20220306223016.2239094-1-ctshao@google.com>
 <CAKwvOdnmtRYnSx3VvG=PEnzpzWa8f=0bn1xDymjER5EShS2tmw@mail.gmail.com>
 <YiaMJCHOOuujHwiK@google.com>
 <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
 <YjFQvhv7I6w8xjbK@google.com>
 <CAK7LNATmPXs6f-Oe4XmfcZSRPsCsuexSebA=4-jyNsMYHu9cag@mail.gmail.com>
 <CAKwvOd=D22k53yXFC=E=VkJotn6q-AYCu5QsaFPmH_v+fWGVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=D22k53yXFC=E=VkJotn6q-AYCu5QsaFPmH_v+fWGVwA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:19:14AM -0700, Nick Desaulniers wrote:
> On Tue, Mar 22, 2022 at 12:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Mar 16, 2022 at 11:51 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > Tue, Mar 08, 2022 at 01:01:45PM +0900, Masahiro Yamada wrote:
> > > > On Tue, Mar 8, 2022 at 7:50 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > >
> > > > > On Mon, Mar 07, 2022 at 10:17:17AM -0800, Nick Desaulniers wrote:
> > > > > > On Sun, Mar 6, 2022 at 2:39 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > > > >
> > > > > > > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > > > > > > what pkg-config and parameters are used.
> > > > > >
> > > > > > Sorry, kind a late thought here for v4, but we don't seem to prefix
> > > > > > many other host side tools with HOST_, i.e. LEX, YACC, AWK, PERL,
> > > > > > PYTHON3, etc.  Maybe just having the variable identifier be simply
> > > > > > PKGCONFIG rather than HOSTPKG_CONFIG then put it at the end of the
> > > > > > list in the top level Makefile after ZSTD (i.e. the list of host
> > > > > > tools)?  There's HOST_ prefixes when there's more than one tool
> > > > > > involved (i.e. host compiler vs target compiler), but I suspect
> > > > > > there's no such distinction for the existing uses of pkg-config?
> > > > > >
> > > > > Thanks for your suggestion, Nick! Yes I think it makes sense with PKGCONFIG
> > > > > instead of HOSTPKG_CONFIG since there is only one tool involved. I will
> > > > > work on it and submit a new patch.
> > > > >
> > > >
> > > > Please hold on.
> > > >
> > > > I was also wondering what to do with the "HOST" prefix.
> > > >
> > > > Libraries are usually arch-dependent.
> > > > (in other words, pkg-config should return different library paths
> > > > for $(CC) and $(HOSTCC) )
> > > >
> > > > You already understood this, so you added "HOST" prefix.
> > > >
> > > >
> > > > Please let me take time for further discussion.
> > > > I will come back to this when I get some time.
> > > >
> > > >
> > >
> > > Hi Mashiro,
> > >
> > > I was wondering if you were able to look more into this.
> > >
> > > Thank you!
> > >
> > > -CT
> > >
> > > > In the meantime,
> > > >   a8a5cd8b472ca20e5b8fa649c43b3756867322f8
> > > > as reference info if you have not seen it.
> > > >
> > > >
> > > > How many distros support something like
> > > > "aarch64-linux-gnu-pkg-config"  ?
> > > >
> > > > Ubuntu 18.04 and 20.04 seem to support it.
> > > > I do not know for others.
> > > >
> > > >
> > > >
> > > >
> >
> >
> >
> > Sorry for the delay.
> > I am OK with the idea of allowing users to override the pkg-config command,
> > but I tend to take time before making a decision.
> >
> >
> >
> >
> > Does anybody have any insight / thoughts about the following points?
> >
> >
> >
> >
> >
> >
> > [Q1]   with/without "HOST" prefix
> >
> >
> > Apparently, "pkg-config" should return different libs/cflags
> > for $(CC) and $(HOSTCC).
> >
> > I think the non-prefixed macro name "PKG_CONFIG" should be
> > reserved for $(CC)  (building for the target system).
>
> Ok. I retract my comment on v4 about removing the HOST prefix then.
>
> >
> > "HOSTPKG_CONFIG" looks unbalanced
> > due to the underscore.
> >
> > Perhaps, "HOST_PKG_CONFIG" might be better?
>
> I'm fine with HOSTPKG_CONFIG (what's in v4); follows the style of
> HOSTCC and HOSTCXX.
>

Agree, it should follow the style of HOSTCC/HOSTCXX.

> >
> >
> >
> >
> > [Q2]    "pkg-config" vs "pkgconf"
> >
> > The traditional pkg-config implementation [1] is not actively
> > maintained these days.
> > The last commit was more than one year ago.
> >
> > The alternative one 'pkgconf' [2] is more active.
> >
> > In fact, Fedora already switched to 'pkgconf' [3].
> > Now 'pkg-config' is just a wrapper of 'pkgconf'.
> > Many distributions already support pkgconf.
> >
> >
> > I considered the shorter macro name "HOSTPKGCONF" and
> >
> >    HOSTPKGCONF  = pkgconf
> >
> > but I am not sure if this is the right decision.
> > Maybe we should stick to "PKG_CONFIG" / "HOST_PKG_CONFIG"
> > for the macro names.
> >
> >
> >   [1]  https://gitlab.freedesktop.org/pkg-config/pkg-config.git
> >   [2]  https://github.com/pkgconf/pkgconf.git
> >   [3]  https://fedoraproject.org/wiki/Changes/pkgconf_as_system_pkg-config_implementation
>
> If the folks sending this are working on CrOS, better find what's in
> their build system. Chun-Tse?
>
> (I feel like I'm behind the times again, like when `apt-get install`
> became old news in favor of `apt install`...)
>

In Cros we only support pkg-config, and that is the reason we would like
to make this change in upstream.

> >
> >
> >
> >
> >
> > [Q3] What is the trend of handling cross-compile by pkg-config (or pkgconf).
> >
> >
> > By default, pkg-config returns the libs/cflags for native builds.
> >
> > For cross builds, the search paths for the *.pc files must be changed
> > via the "PKG_CONFIG_LIBDIR" environment variable.
> >
> > To ease this, some distributions provide  <triplet>-pkg-config
> > (for example,   aarch64-linux-gnu-pkg-config).
> > This became the nationale for tools/build/feature/Makefile defining:
> >
> >    PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> >
> > But, this wrapper shell script is not always available.
> > I do not know how to do it with the LLVM tool suite.
> > I am not quite sure if this is the global solution.
> >
> >
> > These days, pkgconf supports another way, .personality file [4]
> > to specify the .pc search paths for cross builds.
> >
> > Is it reasonable to use an option to distinguish native / cross builds
> > and use the same macro   "PKG_CONFIG = pkg-config" everywhere ?
> >
> >
> > [4] http://manpages.ubuntu.com/manpages/focal/en/man5/pkgconf-personality.5.html
>
> I'm not sure, but do we need to cross that bridge for this patch if
> it's just adding support for the HOST? No cross pkg-config necessary,
> yet. (Famous last words).

Agree with Nick.

Thanks,
CT
> --
> Thanks,
> ~Nick Desaulniers
