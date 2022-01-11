Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5DF48B7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbiAKUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiAKUO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:14:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:14:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k15so729703edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz1QeCMypWRNHsaswZGWwNkZnFrocm7g8332CrVVw7w=;
        b=joYOFYv/akVdeZNliDu9ngr4oF8Str+p+zfuE2UHLGo6eotnFohRy8qOVkHRoFprJf
         4Z08fya2igdFtlQ71lBPGvGcmW1J+pbzEjfUj8mRmVLajVqcCvgK1uB+y2ipPy+3t77N
         ivpO9cGtSyB5q9W65j7gQTgIIX1hvi/S+tJBE5W9zJU0HlDm00x4n4VBs19xteo/+OW2
         3bTpqg9eFKyOf8jodMkbNGBT9w+t4ejaR9Umj5JxAgp3IRzyF3ly+CA18YFBh41s4qHP
         ZG4xiRC1tdNqP7OWw4X59m+A1/eLHBm2lDX00a9F93bWZEZWDC5z2SUDQWhWWBSU3bv3
         +muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz1QeCMypWRNHsaswZGWwNkZnFrocm7g8332CrVVw7w=;
        b=pr0Yzke9WYG5K280/7F5Lnt20mvYYi5MJ16pnzVTht9BlKk/m46HysoDNjiLV9z/Ga
         IWdh+BP/WrNAtUJZIKIHuBJZs2WYD9oZvpE6YxzUTMgCMB1yqXENU1Yo55IQfIb5vAq9
         JzZpFBZVb1MyTdtpAU5YGTTlBKDGD4Ap+XyL3G0dc7xVARfb2cxKeVXzSk2TuiKnw+ix
         mdfiuFppBEVVquM1nlnn11f2eoptogxSzdn5FAClY4/8ZZkDyxwI1qpDOAwxkDqcIyo1
         9gjsQ7y4Sjh0NYIGLHL3AIuC8QVZfYYq+d9m/9SPCTHLz8+zjVD+O+5BkWZHIjspAao4
         J88A==
X-Gm-Message-State: AOAM530pKFLokvztie+ymzJQmu0qDpi6QKFQBjNEXn0kE1/1C7BSGFVn
        bRWhilGezrVdtSJa+SnWbiIRLLeCSLqUVXfsNStwjA==
X-Google-Smtp-Source: ABdhPJzjbWryRfVW6tYMprX3pcitcY3S0LHecAMbw6En56cZDxaeTrpfssB6hszQpxXVXdRFwzyblHSlRK9kOS065/E=
X-Received: by 2002:a05:6402:5214:: with SMTP id s20mr6013113edd.13.1641932095386;
 Tue, 11 Jan 2022 12:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20211215172349.388497-1-willmcvicker@google.com>
 <CAK7LNAT=U9xE5QTPThRTf3V=WEh3WmUh6w-89mm+APjnYp701Q@mail.gmail.com> <CABYd82YUpf5OCuE6q87UZ5+LiRtxqd2yiM25s85KQnxTFcyRzQ@mail.gmail.com>
In-Reply-To: <CABYd82YUpf5OCuE6q87UZ5+LiRtxqd2yiM25s85KQnxTFcyRzQ@mail.gmail.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Tue, 11 Jan 2022 12:14:39 -0800
Message-ID: <CABYd82YK=QVQAuJUrqsNXx33SvcX=1J2xNfHt-rTzMBmUh=_iA@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: install the modules.order for external modules
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:13 AM Will McVicker <willmcvicker@google.com> wrote:
>
> On Fri, Dec 17, 2021 at 5:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > (Cc: Lucas De Marchi)
> >
> > On Thu, Dec 16, 2021 at 2:23 AM Will McVicker <willmcvicker@google.com> wrote:
> > >
> > > Add support to install the modules.order file for external modules
> > > during module_install in order to retain the Makefile ordering
> > > of external modules. This helps reduce the extra steps necessary to
> > > properly order loading of external modules when there are multiple
> > > kernel modules compiled within a given KBUILD_EXTMOD directory.
> > >
> > > To handle compiling multiple external modules within the same
> > > INSTALL_MOD_DIR, kbuild will append a suffix to the installed
> > > modules.order file defined like so:
> > >
> > >   echo ${KBUILD_EXTMOD} | sed 's:[./_]:_:g'
> > >
> > > Ex:
> > >   KBUILD_EXTMOD=/mnt/a.b/c-d/my_driver results in:
> > >   modules.order._mnt_a_b_c_d_my_driver
> > >
> > > The installed module.order.$(extmod_suffix) files can then be cat'd
> > > together to create a single modules.order file which would define the
> > > order to load all of the modules during boot.
> >
> >
> > So, the user must do this manually?
> >
> > cat extra/modules.order._mnt_a_b_c_d_my_driver  \
> >    extra/modules.order._mnt_e_f_g_h_my_driver \
> >    >> modules.order
> >
> > This is so ugly, and incomplete.
> >
> > I cc'ed the kmod maintainer, who may have
> > comments or better approach.
> >
> >
> >
> >
> >
> >
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > ---
> > >  scripts/Makefile.modinst | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> > > index ff9b09e4cfca..2e2e31696fd6 100644
> > > --- a/scripts/Makefile.modinst
> > > +++ b/scripts/Makefile.modinst
> > > @@ -24,6 +24,10 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)  := .xz
> > >  suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  := .zst
> > >
> > >  modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
> > > +ifneq ($(KBUILD_EXTMOD),)
> > > +extmod_suffix := $(subst /,_,$(subst .,_,$(subst -,_,$(KBUILD_EXTMOD))))
> > > +modules += $(dst)/modules.order.$(extmod_suffix)
> > > +endif
> > >
> > >  __modinst: $(modules)
> > >         @:
> > > @@ -82,6 +86,12 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
> > >         $(call cmd,strip)
> > >         $(call cmd,sign)
> > >
> > > +ifneq ($(KBUILD_EXTMOD),)
> > > +$(dst)/modules.order.$(extmod_suffix): $(MODORDER) FORCE
> > > +       $(call cmd,install)
> > > +       @sed -i "s:^$(KBUILD_EXTMOD):$(INSTALL_MOD_DIR):g" $@
> > > +endif
> > > +
> > >  else
> > >
> > >  $(dst)/%.ko: FORCE
> > > --
> > > 2.34.1.173.g76aa8bc2d0-goog
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
>
> Hi Masahiro,
>
> Thanks for your response! I agree with you that this is ugly and would
> love feedback on the direction to take this. With regards to
> incompleteness, the existing kbuild implementation for external
> modules is already incomplete in the sense that it doesn't even
> attempt to install the already generated modules.order files to
> INSTALL_MOD_DIR. I believe this patch gets us a little closer to
> closing the gap, but agree it's nowhere complete. I would be happy to
> fully close the gap if I knew that it would be accepted or welcomed.
> Let me give you some insight on how we currently do this on Android
> and how this patch changes that.
>
> Currently, the Android build.sh script (which is used to compile the
> Android Common Kernel) supports the build variable EXT_MODULES which
> is a list of paths to external modules to be compiled. The build
> script loops through this list and calls "make modules" and "make
> modules_install" to compile and install the external modules. Then,
> the build script creates the modules.order file like this:
>
> cd ${MODLIB}
> find extra -type f -name "*.ko" | sort >> modules.order
>
> Sorting is used so that the modules.order file is deterministic. This
> proposed patch allows us to use the Makefile defined ordering instead
> of this sorted ordering. In Android the paths to external modules must
> be relative to the kernel repository. For example, the kernel and all
> external modules are all cloned within a root directory and the paths
> in EXT_MODULES are all relative to the root directory. So our build.sh
> script can use the relative path from the root directory as part of
> INSTALL_MOD_DIR to get rid of the suffix ugliness. For example, we can
> do this:
>
> for EXT_MOD in ${EXT_MODULES}; do
>   # make modules
>   make -C ${EXT_MOD} ...
>   # make modules_install
>   make -C ${EXT_MOD} ...  INSTALL_MOD_DIR="extra/${EXT_MOD}" modules_install
> done
>
> for EXT_MOD in ${EXT_MODULES}; do
>   modules_order_file=$(ls ${MODLIB}/extra/${EXT_MOD}/modules.order.*)
>   cat ${modules_order_file} >> ${MODLIB}/modules.order
> done
>
> Since kbuild doesn't know about how many external modules there are
> nor does it retain any information about each individual call to "make
> modules" or "make modules_install", we can't do the concatenation
> within the Makefile.modinst script. To close the gap, we could add an
> additional make target that one could call after all of the external
> modules have been installed to do this concatenation, but I wasn't
> sure how open everyone would be to accepting this. Let me know your
> thoughts on that.
>
> Thanks,
> Will

Friendly reminder on this patch now that most are back from the holiday break.

Lucas, could you comment please?

Thanks,
Will
