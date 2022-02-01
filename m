Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77A04A677F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiBAWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:03:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3668C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:03:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c19so26438232ybf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KkrfiRtyMaJqqJdjrzkMV83DUGlyweqGta4SJAJDkXw=;
        b=IGttW2G58AVMdCJ+ZQFSiRfakMSISnO8rp5qj+HW196XjZf2cYHtnTkTPBiXxF08zQ
         ePpEX0EyvCsK9dd6pSO/+E2OirT+DdcWmZ4xfVhtOrkrfG5JdtLAtZoI2vR2XROZ3YgR
         uk/hjaLxBx7257IVlCZFC6RpGOzYwiQ2fpUqhb0w6NnH/2a/+EBEIaMhneESxylO19fd
         /DgMGpq3/4N/uRONAKCYH5TbeRhP5bcmnGHafDaVwSrOtM53I9vZcVMihuHUd1mM81Gb
         4jEl5JvKWEhuyks+jQJeBUvjK9rw5RK1X0GP6KxL+BwkFMa2OyRyIVoNbZeX3wT+zNPw
         JxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KkrfiRtyMaJqqJdjrzkMV83DUGlyweqGta4SJAJDkXw=;
        b=SYm7pS0W2m+MqvNJlbdE4+WzPTI+5mKGNywgObCPy7RkN4B6dzSy+LC7YaUMDX83+T
         uKPKHbJmxT0Qq99lMo2VCbjFaT3nLsq/6RExzdx3iKv4TXNfnJ3wVtL5EgclE3jCQZT+
         ZqgnwtjszGZpbtebwE9LMVj7/I4DHWDu7EQLCXcYD6JSwjcKqMJjVDcgZ5vYy0gKOHlM
         enhBej8QaSowWRHNHkZPWl4Bn7ovnY9h+DBaq+hUKEW838HjqrJ2v4c4AsWLvmUE532s
         E8jmeZj6DlAcs4iI5J77pkwdxWrgYg7bx/xSf3F40sDv+/W4mFI2Oime9F+3GQWYpZXb
         50qA==
X-Gm-Message-State: AOAM533WIOctBDTaM5rmAoNLi2DrOUSQzkhrCBKd2EqtAtI0UUdP44b1
        9uAGqjpO/OeHfCjqsannpqGucVOrAP16KRDvyaKuUnTfLHOzxw==
X-Google-Smtp-Source: ABdhPJyoB+XDP74+DoHXoM1KcCJ6c5iLjHOXoJwPJl/3dkSP3VWhODVzE2FQgbdDwy5YS0yj5v9c78vqz8CjNv2CaDM=
X-Received: by 2002:a25:c401:: with SMTP id u1mr25600903ybf.190.1643752999816;
 Tue, 01 Feb 2022 14:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220201213542.2808035-1-quic_eberman@quicinc.com> <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
In-Reply-To: <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 1 Feb 2022 14:03:08 -0800
Message-ID: <CAFP8O3K_=QytpY8h0vGtpNNC5JWLdoyqbtG1bcVuT-iauD_DHA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add environment variables for userprogs flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:38 PM Nick Desaulniers <ndesaulniers@google.com> w=
rote:
>
> On Tue, Feb 1, 2022 at 1:36 PM Elliot Berman <quic_eberman@quicinc.com> w=
rote:
> >
> > Allow additional arguments be passed to userprogs compilation.
> > Reproducible clang builds need to provide a sysroot and gcc path to
> > ensure same toolchain is used across hosts. KCFLAGS is not currently
>
> ^ ensure the same (maybe Masahiro can fix that up locally when applying)
>
> > used for any user programs compilation, so add new USERCFLAGS and
> > USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
> >
> > Clang 13+ might detect GCC installation on hosts which have it installe=
d
> > to a default location in /. With addition of these environment
> > variables, you can specify flags such as:

s/Clang 13+/Clang/.

Clang has been detecting GCC installation for a long time.
Clang 13 just improved some detection, but may not be worth mentioning
in the message.

> > $ make USERCFLAGS=3D--sysroot=3D/path/to/sysroot
> >
> > This can also be used to specify different sysroots such as musl or
> > bionic which may be installed on the host in paths that the compiler
> > may not search by default.
> >
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

LGTM.

Reviewed-by: Fangrui Song <maskray@google.com>

> > ---
> >
> > Changes since v2:
> >  - Incorporated Nick's suggestions:
> >    - Addressed docs and commit text comments
> >    - Introduced KBUILD_USERHOSTCFLAGS as suggested
> >
> >  Documentation/kbuild/kbuild.rst    | 11 +++++++++++
> >  Documentation/kbuild/makefiles.rst |  2 ++
> >  Makefile                           | 10 ++++++----
> >  init/Kconfig                       |  8 ++++----
> >  usr/include/Makefile               |  3 +++
> >  5 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbu=
ild.rst
> > index 2d1fc03d346e..ef19b9c13523 100644
> > --- a/Documentation/kbuild/kbuild.rst
> > +++ b/Documentation/kbuild/kbuild.rst
> > @@ -77,6 +77,17 @@ HOSTLDLIBS
> >  ----------
> >  Additional libraries to link against when building host programs.
> >
> > +.. _userkbuildflags:
> > +
> > +USERCFLAGS
> > +----------
> > +Additional options used for $(CC) when compiling userprogs.
> > +
> > +USERLDFLAGS
> > +-----------
> > +Additional options used for $(LD) when linking userprogs. userprogs ar=
e linked
> > +with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
> > +
> >  KBUILD_KCONFIG
> >  --------------
> >  Set the top-level Kconfig file to the value of this environment
> > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/=
makefiles.rst
> > index b008b90b92c9..11a296e52d68 100644
> > --- a/Documentation/kbuild/makefiles.rst
> > +++ b/Documentation/kbuild/makefiles.rst
> > @@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to u=
se "userprogs" instead of
> >
> >         When linking bpfilter_umh, it will be passed the extra option -=
static.
> >
> > +       From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuild=
flags>` will also be used.
> > +
> >  5.4 When userspace programs are actually built
> >  ----------------------------------------------
> >
> > diff --git a/Makefile b/Makefile
> > index 45278d508d81..1d0172449355 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -431,11 +431,12 @@ HOSTCC    =3D gcc
> >  HOSTCXX        =3D g++
> >  endif
> >
> > -export KBUILD_USERCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prot=
otypes \
> > -                             -O2 -fomit-frame-pointer -std=3Dgnu89
> > -export KBUILD_USERLDFLAGS :=3D
> > +KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototy=
pes \
> > +                        -O2 -fomit-frame-pointer -std=3Dgnu89
> > +KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> > +KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
> >
> > -KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOS=
TCFLAGS)
> > +KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $=
(HOSTCFLAGS)
> >  KBUILD_HOSTCXXFLAGS :=3D -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> >  KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> >  KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> > @@ -530,6 +531,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHO=
LE RESOLVE_BTFIDS LEX YACC AW
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAG=
S_MODULE
> > +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
> >
> >  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD=
_LDFLAGS
> >  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> > diff --git a/init/Kconfig b/init/Kconfig
> > index f2ae41e6717f..164706c38e8b 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -62,13 +62,13 @@ config LLD_VERSION
> >
> >  config CC_CAN_LINK
> >         bool
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(m64-flag)) if 64BIT
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(m32-flag))
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
> >
> >  config CC_CAN_LINK_STATIC
> >         bool
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(m64-flag) -static) if 64BIT
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(m32-flag) -static)
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLA=
NG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
> >
> >  config CC_HAS_ASM_GOTO
> >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > index 1c2ae1368079..0322e567dc1e 100644
> > --- a/usr/include/Makefile
> > +++ b/usr/include/Makefile
> > @@ -12,6 +12,9 @@ UAPI_CFLAGS :=3D -std=3Dc90 -Wall -Werror=3Dimplicit-=
function-declaration
> >  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m=
64.
> >  UAPI_CFLAGS +=3D $(filter -m32 -m64, $(KBUILD_CFLAGS))
> >
> > +# USERCFLAGS might contain sysroot location for CC.
> > +UAPI_CFLAGS +=3D $(USERCFLAGS)
> > +
> >  override c_flags =3D $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/u=
sr/include
> >
> >  # The following are excluded for now because they fail to build.
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
