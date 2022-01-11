Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7448B690
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiAKTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:15:00 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40503 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350417AbiAKTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:14:59 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 20BJEcfg015619
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:14:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 20BJEcfg015619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641928479;
        bh=CtHOSXVtKGXQXItvatUNChY2KFd7B8FzZNRA3joojV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dAuAbFqqSJjG8V7tBiELyMPuV1NlvDduZwC9vzk+LdZQ1IFv3ya4ATFo/UEECniQ2
         jHTYVd91v2e+Mc+CTT/Zki/mO9vfouU3u7gkJCQ4nxW8TcbTW/nRcBOww+yGXxqdjt
         dAAC1eLDMCU0u2xq1NDPk/CYZTnLo9OF7O+cFJDGQboNXa50usKM61vD+UDxQEUIF5
         s5tq1+lONP2EBCpBSJQe1+YsRmUNj8WO41myJk9z4nPNCyLrhZw1y1uz5kFSffQHkH
         U9+IVU3LyG0lFUMnRaUg0SeGtdEsdb/QHagBxaRqIKshBEGuiFMoqIipCwTdzjN8Io
         5kI+6LJAWAqOA==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id l15so253769pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:14:38 -0800 (PST)
X-Gm-Message-State: AOAM531SnutwShP8no4J3oTNrznUSaBxUDVnqNJFJXRnup1elpgsm89l
        wtkzuPbxkbh+43wjHD9VcjJq027ZKX2Z0Of2PTE=
X-Google-Smtp-Source: ABdhPJxNA+PXoK9Dd+LkSQ5hqaVAmVLjFXI7W4EF5Nez/GBtC+uDQzvlywQprHUfDfJeF0tRnCK2CR7f34O6ZxumwdQ=
X-Received: by 2002:a17:90a:680a:: with SMTP id p10mr4715814pjj.144.1641928477950;
 Tue, 11 Jan 2022 11:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Jan 2022 04:14:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASC+PBFqbsAFWbePoEjL5d21z95Nb84AHTkPjiMcWG_Gg@mail.gmail.com>
Message-ID: <CAK7LNASC+PBFqbsAFWbePoEjL5d21z95Nb84AHTkPjiMcWG_Gg@mail.gmail.com>
Subject: Re: [PATCH] export: fix string handling of namespace in EXPORT_SYMBOL_NS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 11:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Commit c3a6cf19e695 ("export: avoid code duplication in
> include/linux/export.h") broke the ability for a defined string to be
> used as a namespace value.  Fix this up by adding another layer of
> indirection to preserve the previous functionality.
>
> Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Matthias Maennich <maennich@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, I found this while forward porting an out-of-tree Android kernel
> patch from 5.4 to 5.10 that used module namespaces to help wall-off vfs
> symbols from being used by non-filesystem modules.  This issue does not
> affect any in-kernel code, so I am not so sure if it really is needed
> here, but it does restore the previous functionality that was being used
> in older kernels so it might be good to put back in case others want to
> do much the same thing.
>
>  include/linux/export.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 27d848712b90..9a992809f57d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -162,8 +162,10 @@ struct kernel_symbol {
>
>  #define EXPORT_SYMBOL(sym)             _EXPORT_SYMBOL(sym, "")
>  #define EXPORT_SYMBOL_GPL(sym)         _EXPORT_SYMBOL(sym, "_gpl")
> -#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", #ns)
> -#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", #ns)
> +#define _EXPORT_SYMBOL_NS(sym, ns)     __EXPORT_SYMBOL(sym, "", #ns)
> +#define _EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL(sym, "_gpl", #ns)
> +#define EXPORT_SYMBOL_NS(sym, ns)      _EXPORT_SYMBOL_NS(sym, ns)
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)  _EXPORT_SYMBOL_NS_GPL(sym, ns)
>
>  #endif /* !__ASSEMBLY__ */
>
> --
> 2.34.1
>

I see __stringify() a few files above.
So, you can use it here as well.


Does the following code work?   (untested)





diff --git a/include/linux/export.h b/include/linux/export.h
index 27d848712b90..5910ccb66ca2 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H

+#include <linux/stringify.h>
+
 /*
  * Export symbols from the kernel to modules.  Forked from module.h
  * to reduce the amount of pointless cruft we feed to gcc when only
@@ -154,7 +156,6 @@ struct kernel_symbol {
 #endif /* CONFIG_MODULES */

 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#include <linux/stringify.h>
 #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec,
__stringify(DEFAULT_SYMBOL_NAMESPACE))
 #else
 #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec, "")
@@ -162,8 +163,8 @@ struct kernel_symbol {

 #define EXPORT_SYMBOL(sym)             _EXPORT_SYMBOL(sym, "")
 #define EXPORT_SYMBOL_GPL(sym)         _EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", #ns)
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", #ns)
+#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "",
__stringify(ns))
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl",
__stringify(ns))

 #endif /* !__ASSEMBLY__ */






-- 
Best Regards
Masahiro Yamada
