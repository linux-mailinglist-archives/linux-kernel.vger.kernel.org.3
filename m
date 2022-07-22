Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AA57D9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiGVEjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVEjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:39:33 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086FE92861;
        Thu, 21 Jul 2022 21:39:30 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26M4d1rZ014673;
        Fri, 22 Jul 2022 13:39:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26M4d1rZ014673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658464742;
        bh=bKMUfrTKOsP1GGsADuAYCls8YzGD7J6lUjCJRuyyov8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oN7b194fCPaDLcthu3E25AIMv0Wtmefg6rWZBW7L8SBomdC+BnlIfXqgQNc4XQHsN
         pPjr6kQ33RGZvADWdpSBY3OvH3mw9D4AhfT1gxLD1mGjGspN7LkZHPjK9AbxiISUDQ
         qmPkNKylOlB/xu7G890gyUpxu1oduD2Y9RoPgn0Vb5nMOQJJL1xG943RUkPIGen+B+
         CBUh40eLOzJJBdIZUcjxTkkb4qorMwy5rejSLdk1lI3k2/ep7wSfp5/WpIsOCdLyym
         vixN7fGpCnsD5+5MfTVXVX2NbQ8vUwrNV0JGGY+rcjFy6gg+qDozld7P5OiWHPhOVn
         tAHoSqWgEJehQ==
X-Nifty-SrcIP: [209.85.221.48]
Received: by mail-wr1-f48.google.com with SMTP id h8so4932795wrw.1;
        Thu, 21 Jul 2022 21:39:01 -0700 (PDT)
X-Gm-Message-State: AJIora/dbApTuWlKBZ2UgF8l+jCilcDVdeV9h8vOl8yN/XvAmbgeSnqf
        egwwniZtiJGl5MMcwSF8Y2bo+SFlR8ruMstb4Ak=
X-Google-Smtp-Source: AGRyM1sItaEUsnHoJNCspEvVf0e9oIihbKp+/P5gvYjP+sZJx5AZ1E3g5/PgKcgcJSz4aAGaKgZxUtuEluYDChLvtzU=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr990123wrd.682.1658464740201; Thu, 21 Jul
 2022 21:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220720124137.151714-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20220720124137.151714-1-dimitri.ledkov@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Jul 2022 13:38:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRj_+N-MJ8nqLPqwOG2XyRcvvesPRUOoHxwoKJFE1NcQ@mail.gmail.com>
Message-ID: <CAK7LNASRj_+N-MJ8nqLPqwOG2XyRcvvesPRUOoHxwoKJFE1NcQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: introduce $(GCC) variable for path-prefix or version-suffix
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 9:41 PM Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Introduce $(GCC) variable with similar semantics to $(LLVM) for
> setting path-prefix or version-suffix.
>
> Currently to correctly and consistently use gcc-10 on Ubuntu 20.04
> LTS, to cross compile a kernel one has to do:
>
> $ make ... CROSS_COMPILE=riscv64-linux-gnu- \
>            CC=riscv64-linux-gnu-gcc-10 \
>            HOSTCC=gcc-10 \
>            HOSTCXX=g++-10


I think this way is enough.




> With this change
>
> $ make ... CROSS_COMPILE=riscv64-linux-gnu- GCC=-10
>
> is sufficient to correctly select a consistent CC/HOSTCC/HOSTCXX set.


LLVM=-13 is useful to switch all tools in the LLVM suite
such as clang-13, ld.lld-13, llvm-ar-13, etc.



When you use GCC, the other tools come from binutils.

Also, I tend to think CC and HOSTCC/HOSTCXX are different groups.
There is no strong reason for the target GCC and the host GCC
must be the same version.

You can set CC, HOSTCC, HOSTCXX indivudually.


>
> Similarly GCC=/path/to/unpacked/toolchains/ can be used to select
> toolchain outside of PATH.

I think CROSS_COMPILE=/path/to/unpacked/toolchains/ is more common
because gcc and binutils are usually bundled together.




Overall, I do not think GCC= is so useful.
(at least not so useful as LLVM= syntax)





>
> Update documentation for LLVM variable, and mention that GCC variable
> can be used in a similar fashion to set path-prefix, or
> version-suffix.
>
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  Documentation/kbuild/kbuild.rst | 12 ++++++++++--
>  Makefile                        | 12 +++++++++---
>  tools/testing/selftests/lib.mk  |  2 +-
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index ef19b9c13523..6382b082018e 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -276,5 +276,13 @@ whoami and host, respectively.
>
>  LLVM
>  ----
> -If this variable is set to 1, Kbuild will use Clang and LLVM utilities instead
> -of GCC and GNU binutils to build the kernel.
> +If this variable is set to 1, Kbuild will use Clang and LLVM utilities
> +instead of GCC and GNU binutils to build the kernel. It can also be
> +used to set a path prefix, or a version suffix, see "Building
> +Linux with Clang/LLVM".
> +
> +GCC
> +---
> +This variable can be used similar to LLVM variable above to set a path
> +prefix, or a version suffix for GNU Toolchain binaries. See examples
> +in "Building Linux with Clang/LLVM".
> diff --git a/Makefile b/Makefile
> index 00fd80c5dd6e..e7bd0b572b14 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -433,8 +433,14 @@ endif
>  HOSTCC = $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
>  HOSTCXX        = $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
>  else
> -HOSTCC = gcc
> -HOSTCXX        = g++
> +ifneq ($(filter %/,$(GCC)),)
> +GCC_PREFIX := $(GCC)
> +else ifneq ($(filter -%,$(GCC)),)
> +GCC_SUFFIX := $(GCC)
> +endif
> +
> +HOSTCC = $(GCC_PREFIX)gcc$(GCC_SUFFIX)
> +HOSTCXX        = $(GCC_PREFIX)g++$(GCC_SUFFIX)
>  endif
>  HOSTPKG_CONFIG = pkg-config
>
> @@ -461,7 +467,7 @@ OBJDUMP             = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>  READELF                = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>  STRIP          = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>  else
> -CC             = $(CROSS_COMPILE)gcc
> +CC             = $(GCC_PREFIX)$(CROSS_COMPILE)gcc$(GCC_SUFFIX)
>  LD             = $(CROSS_COMPILE)ld
>  AR             = $(CROSS_COMPILE)ar
>  NM             = $(CROSS_COMPILE)nm
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1a5cc3cd97ec..777757d54f42 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -30,7 +30,7 @@ endif # CROSS_COMPILE
>
>  CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
>  else
> -CC := $(CROSS_COMPILE)gcc
> +CC := $(GCC_PREFIX)$(CROSS_COMPILE)gcc$(GCC_SUFFIX)
>  endif # LLVM
>
>  ifeq (0,$(MAKELEVEL))
> --
> 2.34.1
>


--
Best Regards

Masahiro Yamada
