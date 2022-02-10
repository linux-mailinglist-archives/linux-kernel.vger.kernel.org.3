Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861524B022C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiBJBZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:25:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiBJBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:25:41 -0500
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 17:25:43 PST
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B81261F;
        Wed,  9 Feb 2022 17:25:42 -0800 (PST)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-01.nifty.com with ESMTP id 21A0nMGk016551;
        Thu, 10 Feb 2022 09:49:22 +0900
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 21A0n28Z006407;
        Thu, 10 Feb 2022 09:49:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 21A0n28Z006407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644454143;
        bh=dAKyP6GJpF6V2QvUnN/LuX24hdc1hZvojEh30WfrKgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IG3GM/DeBViLLxnZ3fQanZTvYc802gcfsCckcPHRrgf4Tgn/4P+ZJFsO3kgDlgsmp
         vI5pkF+QlLMWdv3f52B0XYjh86Z3SnjkGoOvjbmWVbpMB6wBedSkwtS4CKTnv28iJa
         nvcntW2JHBQU1P18cC/PDDZfNV0aP6i8qf4TEK3NjITMDvsHosz7waB8K9oRFRNhJ4
         KUJtRKRrIWLIC0b8npHrf3jv1iiMm+KoZawBTUnYsysnbEkuWH9Qlt2IBQoqIsfgQ1
         ZqEC6DqW6nFmnAOyGwqdyHLC7ab+b2V/y9mylO0uxgtYh/b4C6nJCc6a2jHBRIT0D2
         1vKnjktfIdKRA==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso2785249pjj.1;
        Wed, 09 Feb 2022 16:49:02 -0800 (PST)
X-Gm-Message-State: AOAM533uAB+PAvqxxxQOsb9xhjU1ODM3mH87X1FQ4M/cW1gcEx05HHFZ
        uswokZOlQJDYy/Hrhs0o6o1dMnI3cyZulZxSYX4=
X-Google-Smtp-Source: ABdhPJz+oomnAexVoHRJuLkhmhIQ/hVUcOzqSdE+0J9BS1NupWTERWXAvLXlLHjA+mI8F9nQCQ7P39mPbMqd7K7oOx4=
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr20816pjb.144.1644454142067;
 Wed, 09 Feb 2022 16:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20220208184309.148192-1-nick.alcock@oracle.com> <20220208184309.148192-5-nick.alcock@oracle.com>
In-Reply-To: <20220208184309.148192-5-nick.alcock@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 09:48:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-4sJj9hzPHS2nb01ri+wRv+O-6N4048N2qTVVxicUfg@mail.gmail.com>
Message-ID: <CAK7LNAT-4sJj9hzPHS2nb01ri+wRv+O-6N4048N2qTVVxicUfg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] kallsyms: introduce sections needed to map symbols
 to built-in modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        Daniel Xu <dxu@dxuuu.xyz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 3:44 AM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> The mapping consists of three new symbols, computed by integrating the
> information in the (just-added) .tmp_vmlinux.ranges and
> modules_thick.builtin: taken together, they map address ranges
> (corresponding to object files on the input) to the names of zero or
> more modules containing those address ranges.
>
>  - kallsyms_module_addresses/kallsyms_module_offsets encodes the
>    address/offset of each object file (derived from the linker map), in
>    exactly the same way as kallsyms_addresses/kallsyms_offsets does
>    for symbols.  There is no size: instead, the object files are assumed
>    to tile the address space.  (This is slightly more space-efficient
>    than using a size).  Non-text-section addresses are skipped: for now,
>    all the users of this interface only need module/non-module
>    information for instruction pointer addresses, not absolute-addressed
>    symbols and the like.  This restriction can easily be lifted in
>    future.  (Regarding the name: right now the entries correspond pretty
>    closely to object files, so we could call the section
>    kallsyms_objfiles or something, but the optimizer added in the next
>    commit will change this.)
>
>  - kallsyms_module_names encodes the name of each module in a modified
>    form of strtab: notably, if an object file appears in *multiple*
>    modules, all of which are built in, this is encoded via a zero byte,
>    a one-byte module count, then a series of that many null-terminated
>    strings.  As a special case, the table starts with a single zero byte
>    which does *not* represent the start of a multi-module list.
>
>  - kallsyms_modules connects the two, encoding a table associated 1:1
>    with kallsyms_module_addresses / kallsyms_module_offsets, pointing
>    at an offset in kallsyms_module_names describing which module (or
>    modules, for a multi-module list) the code occupying this address
>    range is part of.  If an address range is part of no module (always
>    built-in) it points at 0 (the null byte at the start of the
>    kallsyms_module_names list).
>
> There is no optimization yet: kallsyms_modules and
> kallsyms_module_names will almost certainly contain many duplicate
> entries, and kallsyms_module_{addresses,offsets} may contain
> consecutive entries that point to the same place.  The size hit is
> fairly substantial as a result, though still much less than a naive
> implementation mapping each symbol to a module name would be: 50KiB or
> so.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
> ---
>  Makefile           |   2 +-
>  init/Kconfig       |   8 +
>  scripts/Makefile   |   6 +
>  scripts/kallsyms.c | 366 +++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 371 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5e823fe8390f..b719244cb571 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1151,7 +1151,7 @@ cmd_link-vmlinux =                                                 \
>         $(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
> -vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
> +vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) modules_thick.builtin FORCE
>         +$(call if_changed_dep,link-vmlinux)
>
>  targets := vmlinux
> diff --git a/init/Kconfig b/init/Kconfig
> index e9119bf54b1f..e1ca3d70cb1c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1530,6 +1530,14 @@ config POSIX_TIMERS
>
>           If unsure say y.
>
> +config KALLMODSYMS
> +       default y
> +       bool "Enable support for /proc/kallmodsyms" if EXPERT
> +       depends on KALLSYMS
> +       help
> +         This option enables the /proc/kallmodsyms file, which maps symbols
> +         to addresses and their associated modules.
> +
>  config PRINTK
>         default y
>         bool "Enable support for printk" if EXPERT
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ce5aa9030b74..c5cc4ac3d660 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -29,6 +29,12 @@ ifdef CONFIG_BUILDTIME_MCOUNT_SORT
>  HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
>  endif
>
> +kallsyms-objs  := kallsyms.o
> +
> +ifdef CONFIG_KALLMODSYMS
> +kallsyms-objs += modules_thick.o
> +endif
> +
>  # The following programs are only built on demand
>  hostprogs += unifdef
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 54ad86d13784..8f87b724d0fa 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -5,7 +5,10 @@
>   * This software may be used and distributed according to the terms
>   * of the GNU General Public License, incorporated herein by reference.
>   *
> - * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
> + * Usage: nm -n vmlinux
> + *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
> + *             [--base-relative] [--builtin=modules_thick.builtin]
> + *        > symbols.S
>   *
>   *      Table compression uses all the unused char codes on the symbols and
>   *  maps these to the most used substrings (tokens). For instance, it might
> @@ -24,6 +27,10 @@
>  #include <string.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <assert.h>
> +#include "modules_thick.h"
> +
> +#include "../include/generated/autoconf.h"



I do not remember if I had pointed this out before,
but including autoconf.h from a host program is wrong.

Do not use ifdef CONFIG_...  in the hostprog code.
Having --builtin=modules_thick.builtin is enough.





-- 
Best Regards
Masahiro Yamada
