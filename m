Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8644797F2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhLRBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:01:30 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35483 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhLRBBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:01:30 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1BI115WJ001407;
        Sat, 18 Dec 2021 10:01:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1BI115WJ001407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639789266;
        bh=cdV3K3Xo1adlvyUB8o2XGZPju6TJ88tkBCM2bHAlT7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fxN3cR9vZJM1ZDk36N2YMFETKY4aeGbXTow2rI5gYGYrUtp2x0XeQez151PK7GwUF
         t5hNyCWJEBMAZhWOo77j47Ga7Os4QXusT/JprU4yBxqNKaQq1wTRPLvMvLez+s4T4z
         LFGZ5MFcW52gbDZhrYZ7XAypHqFlbN08rRRc+W6WBRufIjo6oGsbPse+oCDSAbwOvZ
         HwThyXIrYjOSlvS05/9fjAZdM+EWy/D0kodcLl+a5/Ybs90GONh2bmGaKPwbECnOUm
         7avrCj8g9ypayDyNyRAQqp0l5ukq7JpH9gnRUjmTePq1igjR85QDNmjM+OWQNIXPkO
         Vie7ZvAh/kdwg==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso5256353pjc.0;
        Fri, 17 Dec 2021 17:01:06 -0800 (PST)
X-Gm-Message-State: AOAM531a0N3mBPraC4mtKRdcd5SRZykJdxmwT3nPmG+AlkU/wyVC0sLv
        7KE9FgndYxUiZtpU6J1gIDC7tR7uzKtP0+7dCVQ=
X-Google-Smtp-Source: ABdhPJyox3fWVmR7Q2cVsXwBo0TH3kYWp+sG+skM+lIBKxR5u5PfnRwWH8HL68mxmfz6yCStMkBHb8P9O4zV/j38zJk=
X-Received: by 2002:a17:902:9a47:b0:148:a2f7:9d69 with SMTP id
 x7-20020a1709029a4700b00148a2f79d69mr535657plv.136.1639789265216; Fri, 17 Dec
 2021 17:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20211215172349.388497-1-willmcvicker@google.com>
In-Reply-To: <20211215172349.388497-1-willmcvicker@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 18 Dec 2021 10:00:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=U9xE5QTPThRTf3V=WEh3WmUh6w-89mm+APjnYp701Q@mail.gmail.com>
Message-ID: <CAK7LNAT=U9xE5QTPThRTf3V=WEh3WmUh6w-89mm+APjnYp701Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: install the modules.order for external modules
To:     Will McVicker <willmcvicker@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc: Lucas De Marchi)

On Thu, Dec 16, 2021 at 2:23 AM Will McVicker <willmcvicker@google.com> wrote:
>
> Add support to install the modules.order file for external modules
> during module_install in order to retain the Makefile ordering
> of external modules. This helps reduce the extra steps necessary to
> properly order loading of external modules when there are multiple
> kernel modules compiled within a given KBUILD_EXTMOD directory.
>
> To handle compiling multiple external modules within the same
> INSTALL_MOD_DIR, kbuild will append a suffix to the installed
> modules.order file defined like so:
>
>   echo ${KBUILD_EXTMOD} | sed 's:[./_]:_:g'
>
> Ex:
>   KBUILD_EXTMOD=/mnt/a.b/c-d/my_driver results in:
>   modules.order._mnt_a_b_c_d_my_driver
>
> The installed module.order.$(extmod_suffix) files can then be cat'd
> together to create a single modules.order file which would define the
> order to load all of the modules during boot.


So, the user must do this manually?

cat extra/modules.order._mnt_a_b_c_d_my_driver  \
   extra/modules.order._mnt_e_f_g_h_my_driver \
   >> modules.order

This is so ugly, and incomplete.

I cc'ed the kmod maintainer, who may have
comments or better approach.






> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  scripts/Makefile.modinst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ff9b09e4cfca..2e2e31696fd6 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -24,6 +24,10 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)  := .xz
>  suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  := .zst
>
>  modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
> +ifneq ($(KBUILD_EXTMOD),)
> +extmod_suffix := $(subst /,_,$(subst .,_,$(subst -,_,$(KBUILD_EXTMOD))))
> +modules += $(dst)/modules.order.$(extmod_suffix)
> +endif
>
>  __modinst: $(modules)
>         @:
> @@ -82,6 +86,12 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>         $(call cmd,strip)
>         $(call cmd,sign)
>
> +ifneq ($(KBUILD_EXTMOD),)
> +$(dst)/modules.order.$(extmod_suffix): $(MODORDER) FORCE
> +       $(call cmd,install)
> +       @sed -i "s:^$(KBUILD_EXTMOD):$(INSTALL_MOD_DIR):g" $@
> +endif
> +
>  else
>
>  $(dst)/%.ko: FORCE
> --
> 2.34.1.173.g76aa8bc2d0-goog
>


-- 
Best Regards
Masahiro Yamada
