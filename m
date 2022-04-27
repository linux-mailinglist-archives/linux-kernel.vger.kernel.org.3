Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD65119DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiD0OeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiD0OeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:34:01 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71935617C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:30:47 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23REUMKv013589
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:30:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23REUMKv013589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651069823;
        bh=PaAe2OFK506VVqXplQDNPZOKX+44YVahRECy+APqLjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w5tapwFWKkhIK37xg0+ASjYfOkAOkNUoTuSC4NhqJ7MyEtYf6Fa0zwpF/TI6L1d2R
         rb0UZMgfW6jxY8lqZco/flmD3tX8/C1tBvAZxK5IzWstlzHRnXyxO11Q6RYw9KbP0o
         4u0I5LpbDHKJQq15lDh9d6nfymy0hfapbpTxekG7DyvhqqQJav5+h2LhhKiw73HSjF
         UgN2EeV6g2RzVWsowgiCZt9chU2pE/wE6czC+kxQ7D1ss+pjMiniQA21PMbhbUBK6L
         ngW8lJypz2s/0TrYIRbJRZH8ilBBsg1nZRsT1/pHICTxTBZyAg7X3IXHqiEWBtwpF4
         8o+2QMjCvocMg==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id fv2so1637665pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:30:22 -0700 (PDT)
X-Gm-Message-State: AOAM531Csb05+RhN4nCk81gDEyE5ViIJGm0/i2U5jRQWlvENWiWsaA4U
        Z0553cTL3QdrmuvzKDzN/GGBRfMz6K1vTYY5PSc=
X-Google-Smtp-Source: ABdhPJzsqO5dqPiCgEbDywVSsGVMqRfZVIbn+bDPITwKt7U1kozX58TTKo8CXXJNGCMuJrcaEa3uaRpPqcrxDMUVLPY=
X-Received: by 2002:a17:90a:e7d1:b0:1da:30d0:9327 with SMTP id
 kb17-20020a17090ae7d100b001da30d09327mr4886230pjb.144.1651069821974; Wed, 27
 Apr 2022 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 27 Apr 2022 23:29:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
Message-ID: <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
Subject: Re: [PATCH v2] export: fix string handling of namespace in EXPORT_SYMBOL_NS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Commit c3a6cf19e695 ("export: avoid code duplication in
> include/linux/export.h") broke the ability for a defined string to be
> used as a namespace value.

In hindsight, this was a bad idea.


EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")

   is much much better than:

EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)




ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE

is also a bad idea.

When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
aware of the presence of the namespace.



Anyway, it is presumably too late to fix it.


>  Fix this up by using stringify to properly
> encode the namespace name.
>
> Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

This email is no longer valid.

Feel free to replace it with

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



> Cc: Matthias Maennich <maennich@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: use stringify() instead of 2 step redirection as pointed out by Masahiro
>
>  include/linux/export.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 27d848712b90..5910ccb66ca2 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_EXPORT_H
>  #define _LINUX_EXPORT_H
>
> +#include <linux/stringify.h>
> +
>  /*
>   * Export symbols from the kernel to modules.  Forked from module.h
>   * to reduce the amount of pointless cruft we feed to gcc when only
> @@ -154,7 +156,6 @@ struct kernel_symbol {
>  #endif /* CONFIG_MODULES */
>
>  #ifdef DEFAULT_SYMBOL_NAMESPACE
> -#include <linux/stringify.h>
>  #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec, __stringify(DEFAULT_SYMBOL_NAMESPACE))
>  #else
>  #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec, "")
> @@ -162,8 +163,8 @@ struct kernel_symbol {
>
>  #define EXPORT_SYMBOL(sym)             _EXPORT_SYMBOL(sym, "")
>  #define EXPORT_SYMBOL_GPL(sym)         _EXPORT_SYMBOL(sym, "_gpl")
> -#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", #ns)
> -#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", #ns)
> +#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", __stringify(ns))
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", __stringify(ns))
>
>  #endif /* !__ASSEMBLY__ */
>
> --
> 2.36.0
>


-- 
Best Regards
Masahiro Yamada
