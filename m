Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6A5971F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiHQOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiHQOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:47:22 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301E9C535;
        Wed, 17 Aug 2022 07:47:18 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27HEki8o017757;
        Wed, 17 Aug 2022 23:46:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27HEki8o017757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660747605;
        bh=nZDn4EG1hSljD8i6cO2cRJtiYUDlU40VfU1RrxVLsqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=en+MVomvOTLh0w/3mToNxslXYH/Cr5rIdqSgpdbdQX8hHsegxZzR8wHuhd5Lrgfnq
         9m7ylb1h9W9UiquTr6Pyx6d12uCqQ5/pMCNr2DOC1NHgNtvFzAHR3NcNGZBWfqInHp
         8CyYhM45D2SE2aCEPkDs7ndaK24KQEw5USDykWdb28TxtVmJhDcSh04gx7LUcTNKg9
         pe/tYTWbJeRZWdP0PP2Eh0fBCFp00n7hzbyVE53kxxdvN+mxJN3Hnmk5Qq9QmmCiDH
         J9CGbfSROLyhwu0xX2OSRkxMlWC+w+XXs0Jvr/LvB++65Vupd7m9ojckCXHTXuXhev
         RWYtSj2IhHi1A==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id v3so16525752wrp.0;
        Wed, 17 Aug 2022 07:46:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo05vdTsCggMikYVsC7aPTeZqOPEAUWjq+MMfl880Ze5o9UJDD/1
        GjNmGgJs1N18Eue/0r6qm29ZJeGBJuqPvRB2Y1A=
X-Google-Smtp-Source: AA6agR5yWUa1GjgceQACTCMBOffaN+qHyvUBReYgIREcBl22CRbDgKPtEY1xcyZKtb4MBiBrMXqeO06/2AR87lwHjvo=
X-Received: by 2002:a05:6000:2ab:b0:223:6167:a213 with SMTP id
 l11-20020a05600002ab00b002236167a213mr14645075wry.310.1660747603852; Wed, 17
 Aug 2022 07:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220809141117.641543-1-masahiroy@kernel.org>
In-Reply-To: <20220809141117.641543-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 17 Aug 2022 23:45:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBhA607fmriSLYSAHBZCYG4MrT9MttU+7j3M911sujbA@mail.gmail.com>
Message-ID: <CAK7LNAQBhA607fmriSLYSAHBZCYG4MrT9MttU+7j3M911sujbA@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix module versioning when a symbol lacks valid CRC
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 11:13 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit 7b4537199a4a ("kbuild: link symbol CRCs at final link,
> removing CONFIG_MODULE_REL_CRCS"), module versioning is broken on
> some architectures. Loading a module fails with "disagrees about
> version of symbol module_layout".
>
> On such architectures (e.g. ARCH=sparc build with sparc64_defconfig),
> modpost shows a warning, like follows:
>
>   WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
>   Is "_mcount" prototyped in <asm/asm-prototypes.h>?
>
> Previously, it was a harmless warning (CRC check was just skipped),
> but now wrong CRCs are used for comparison because invalid CRCs are
> just skipped.
>
>   $ sparc64-linux-gnu-nm -n vmlinux
>     [snip]
>   0000000000c2cea0 r __ksymtab__kstrtol
>   0000000000c2ceb8 r __ksymtab__kstrtoul
>   0000000000c2ced0 r __ksymtab__local_bh_enable
>   0000000000c2cee8 r __ksymtab__mcount
>   0000000000c2cf00 r __ksymtab__printk
>   0000000000c2cf18 r __ksymtab__raw_read_lock
>   0000000000c2cf30 r __ksymtab__raw_read_lock_bh
>     [snip]
>   0000000000c53b34 D __crc__kstrtol
>   0000000000c53b38 D __crc__kstrtoul
>   0000000000c53b3c D __crc__local_bh_enable
>   0000000000c53b40 D __crc__printk
>   0000000000c53b44 D __crc__raw_read_lock
>   0000000000c53b48 D __crc__raw_read_lock_bh
>
> Please notice __crc__mcount is missing here.
>
> When the module subsystem looks up a CRC that comes after, it results
> in reading out a wrong address. For example, when __crc__printk is
> needed, the module subsystem reads 0xc53b44 instead of 0xc53b40.
>
> All CRC entries must be output for correct index accessing. Invalid
> CRCs will be unused, but are needed to keep the one-to-one mapping
> between __ksymtab_* and __crc_*.
>
> The best is to fix all modpost warnings, but several warnings are still
> remaining on less popular architectures.
>
> Fixes: 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS")
> Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: matoro <matoro_mailinglist_kernel@matoro.tk>


Applied to linux-kbuild/fixes.





> ---
>
>  scripts/mod/modpost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 8484c0798f28..22dc332eebfa 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2018,13 +2018,11 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
>         /* record CRCs for exported symbols */
>         buf_printf(buf, "\n");
>         list_for_each_entry(sym, &mod->exported_symbols, list) {
> -               if (!sym->crc_valid) {
> +               if (!sym->crc_valid)
>                         warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
>                              "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
>                              sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
>                              sym->name);
> -                       continue;
> -               }
>
>                 buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
>                            sym->name, sym->crc, sym->is_gpl_only ? "_gpl" : "");
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
