Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0714CEE44
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiCFWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiCFWvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:51:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF46954FA9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:50:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso12067104pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0+aB5+iWTlcM+YdHU/av3SeWoXDvBLYyb7Gk7+TnDY=;
        b=EAvajnNnAUTetZ3AX6do1P54c3fdWapxxfXbUi+zNuGqMoAKXJzZ+cBDgtSlOPUvd0
         v5iAi+oSxu+ZnI2b5EGL40epO0bA0/7ovi+10inkI1YnbSFjIYhRFT0Htso/9wybGMi5
         lLosT5Rlcs+8n40tvfkljOZ94xeTZES4xipDN/7X2IgegzzNXWyTTfupaha8Q1Z2qUF0
         lEWwPido8n2B+3ggyVssVYJfSACLBD3zrbmzDx6QoPG79ThMDaNb74uFzCcahUPo0oFa
         DWXAZzsbf9yL96W8SvhnIMn5EYo9yBfYaCO8Z8RnrWsw2ivOsPMNmT3lLGtgy6ZSnO56
         Crmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I0+aB5+iWTlcM+YdHU/av3SeWoXDvBLYyb7Gk7+TnDY=;
        b=EP1ioF+bDzm0MpbnncMS7+fVqLzVII5LTp2WMXuSnbnpahkMuljl7DFFxnDI/Ed40i
         vsbmzDt9uaRdBijXXwC/5dVLHi+QcpWIoaD2fyZ8aYbHDvaFifd06d3lZuHEo9tHibAc
         fVDWXg7mVN9XvPshZ553Db0p0wPxJApm6wCIctvXoEGh5LdqcNhUXZweYl3E0eMlgT0D
         yCiHhKEqSCModTHMxmYxD8cBUc+uyhZYdU7pc3xnYc0gLrwk+LJcXeCkPiS0GYwwSqMJ
         ObsNCcbF11SvkcPtG0gMKLREwgOZnAHQgBFUnKJECvVqyhJM21Ilwk8XaZvCN6Q8fUJk
         bENw==
X-Gm-Message-State: AOAM5311glRGlmLmwfRWLxjZXUyoyjvlYjEDbNLOyMpmQFU+bvwrXEHl
        UbNWKwgay3LjuIfHvw8+WZKIog==
X-Google-Smtp-Source: ABdhPJw9PioSsePdhp91Ue54wpRHN5AOtdnsfTdre7EJlnCRMXW777L0rZmTL86yhueDsuRTmW2kPQ==
X-Received: by 2002:a17:902:8bc2:b0:149:1ce6:c28c with SMTP id r2-20020a1709028bc200b001491ce6c28cmr9430521plo.164.1646607020763;
        Sun, 06 Mar 2022 14:50:20 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id o125-20020a625a83000000b004f6d32cd541sm6384833pfb.152.2022.03.06.14.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:50:20 -0800 (PST)
Date:   Sun, 6 Mar 2022 22:50:16 +0000
From:   Chun-Tse Shao <ctshao@google.com>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     rostedt@goodmis.org, ndesaulniers@google.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] config: Allow kernel installation packaging to
 override pkg-config
Message-ID: <YiU6qJ9EIspJfnto@google.com>
References: <20220304041449.939308-1-ctshao@google.com>
 <YiPUp2KDmlnzv0MR@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiPUp2KDmlnzv0MR@fjasle.eu>
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

On Sat, Mar 05, 2022 at 10:22:47PM +0100, Nicolas Schier wrote:
> On Fri, Mar 04, 2022 at 04:14:51AM +0000 Chun-Tse Shao wrote:
> > [ Resending as a separate thread ]
> >
> > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > what pkg-config and parameters are used.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> > Changes from v2: https://lore.kernel.org/all/20220302193638.11034-1-ctshao@google.com/
> >   - Fix more open coded instance of pkg-config in scripts and certs
> >   - Tested with make allmodconfig
> >
> > Changes from v1: https://lore.kernel.org/all/20220301230629.1892828-1-ctshao@google.com/
> >   - Make the commit message more clearer.
> > ---
> >
> >  Makefile                     |  3 ++-
> >  certs/Makefile               |  4 ++--
> >  scripts/Makefile             |  4 ++--
> >  scripts/dtc/Makefile         |  6 +++---
> >  scripts/kconfig/gconf-cfg.sh | 10 +++++-----
> >  scripts/kconfig/mconf-cfg.sh | 14 +++++++-------
> >  scripts/kconfig/nconf-cfg.sh | 14 +++++++-------
> >  scripts/kconfig/qconf-cfg.sh | 14 +++++++-------
> >  tools/objtool/Makefile       |  4 ++--
> >  9 files changed, 37 insertions(+), 36 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index daeb5c88b50b..f6c5bef7e141 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -430,6 +430,7 @@ else
> >  HOSTCC	= gcc
> >  HOSTCXX	= g++
> >  endif
> > +HOSTPKG_CONFIG	= pkg-config
> >
> >  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> >  			      -O2 -fomit-frame-pointer -std=gnu89
> > @@ -525,7 +526,7 @@ KBUILD_LDFLAGS_MODULE :=
> >  KBUILD_LDFLAGS :=
> >  CLANG_FLAGS :=
> >
> > -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
> > +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
> >  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> > diff --git a/certs/Makefile b/certs/Makefile
> > index 3ea7fe60823f..fa540d14ef2d 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -89,5 +89,5 @@ targets += x509_revocation_list
> >
> >  hostprogs := extract-cert
> >
> > -HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> > -HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> > +HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> > +HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index ce5aa9030b74..f084f08ed176 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -14,8 +14,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
> >  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
> >  HOSTLDLIBS_sorttable = -lpthread
> >  HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
> > -HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> > -HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> > +HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> > +HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> >
> >  ifdef CONFIG_UNWINDER_ORC
> >  ifeq ($(ARCH),x86_64)
> > diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> > index 95aaf7431bff..743fc08827ea 100644
> > --- a/scripts/dtc/Makefile
> > +++ b/scripts/dtc/Makefile
> > @@ -18,7 +18,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
> >  # Source files need to get at the userspace version of libfdt_env.h to compile
> >  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
> >
> > -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> > +ifeq ($(shell $(HOSTPKG_CONFIG) --exists yaml-0.1 2>/dev/null && echo yes),)
> >  ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
> >  $(error dtc needs libyaml for DT schema validation support. \
> >  	Install the necessary libyaml development package.)
> > @@ -27,9 +27,9 @@ HOST_EXTRACFLAGS += -DNO_YAML
> >  else
> >  dtc-objs	+= yamltree.o
> >  # To include <yaml.h> installed in a non-default path
> > -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> > +HOSTCFLAGS_yamltree.o := $(shell $(HOSTPKG_CONFIG) --cflags yaml-0.1)
> >  # To link libyaml installed in a non-default path
> > -HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
> > +HOSTLDLIBS_dtc	:= $(shell $(HOSTPKG_CONFIG) yaml-0.1 --libs)
> >  endif
> >
> >  # Generated files need one more search path to include headers in source tree
> > diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> > index 480ecd8b9f41..267ef6012203 100755
> > --- a/scripts/kconfig/gconf-cfg.sh
> > +++ b/scripts/kconfig/gconf-cfg.sh
> > @@ -3,14 +3,14 @@
> >
> >  PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
> >
> > -if [ -z "$(command -v pkg-config)" ]; then
> > +if [ -z "$(command -v $(HOSTPKG_CONFIG))" ]; then
>
> Dereferencing variables in shell scripts has to be done by using "${var}" or
> "$var".  "$(var)" starts a sub-shell and executes "var", which is not your
> intention.  Thus, better try something like:
>
>     if [ -z "$(command -v "${HOSTPKG_CONFIG}")" ]; then
>
> (and all other shell script replacements in need to be revised, too.)
>
> Kind regards,
> Nicolas

Thanks Nicolas! I submitted another patch with your suggestions:
https://lore.kernel.org/all/20220306223016.2239094-1-ctshao@google.com/

A question: Would it be good if I also add {} for other variables (for exmaple: $PKG
and $PKG2) in these scripts along with my change?

-CT
