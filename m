Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F021A4C02B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiBVUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiBVUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:01:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97113E7F69;
        Tue, 22 Feb 2022 12:00:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n29-20020a05600c3b9d00b00380e379bae2so1398299wms.3;
        Tue, 22 Feb 2022 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6kHPkg5k58qsIdOvIQ+qhGU6z4S5D+VaMWvw/nz6R0=;
        b=le+tliZN2fdgoBaxQh4jKSU9E5lisc2ynwcXeRfZFFVkFKv3UtFNXHsUGvHj9/FPUZ
         acXUlgjZNAJoKCLqZkQZ6FYK8w3NizbF0BYRFMC+mMMgCaqH3aeuA4F4lpujgxghY5ai
         dQ2iILUpy+fF0MRgDDMjNCi+8OBY9YrquAyRGfhMpWo4uRalHTM5SgSbuKJa5N0qOl9f
         bjzkFDKh+q5PXlndXjsh+vroHNKWPuRqkADvHNt5+kb08Dv96Psin8no1TkHFRpdQCmF
         c4agQotTr/fR1dNarwZVJU2CNRwgGJ8xQZSTxcYPp+cL4iqj6w4b2JvVUeC8P5iJKaBo
         01GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6kHPkg5k58qsIdOvIQ+qhGU6z4S5D+VaMWvw/nz6R0=;
        b=5ikaFEcLWgx5sNzl2yH3UiqhoDTzcCejudLmpYXRBedtJWQn6Zc3WrgHMnT4ys3O6M
         QD1cwnLAbl9txmvkoFDfQ71vD71PK1iPozwxxkUm81OjvzISG5GZa7QFzdHLoz5ok4fv
         wE/633PiJf1bDraUZDkcCqIp98efxBYOqYBIy9bomZ7kdOezDbAAdj2qoV8i9qGiXAkJ
         jfFMpNGtAnlmR8W7zCYpDQ41Q8uQiFl4eMl4k21FddhUe+77gsmmJXmrE7CLA02FfWSt
         K7GGRaG3neC7B6iZPrE3tabTPflf7XAYVYrxw76N7kevg/L+SYr3pz2iJ90U30qTeEEs
         VeaA==
X-Gm-Message-State: AOAM530WE+HQqwQ2ib9yXufLkLRddnEj4Ajh4M6fAt8KwQQsSaqOJG2b
        Sf/wrRjI8G8lZCuMvr6zyGw5wl7e0ZjvqmYj+vguJeFj
X-Google-Smtp-Source: ABdhPJyF3+19dv9Ol01sXRbKWDLuvxS5r6z5YydbQfLCi1QhD54gw2+i7PKSiOiHxfVv/DCcNlsessSTEfifGfeWa0M=
X-Received: by 2002:a05:600c:354e:b0:37c:815f:8a3f with SMTP id
 i14-20020a05600c354e00b0037c815f8a3fmr4654255wmq.15.1645560037067; Tue, 22
 Feb 2022 12:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20220222141303.1392190-1-atomlin@redhat.com> <20220222141303.1392190-2-atomlin@redhat.com>
In-Reply-To: <20220222141303.1392190-2-atomlin@redhat.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 22 Feb 2022 12:00:26 -0800
Message-ID: <CAOMdWSJDG6CYD8ie38gYWSxGO6vcogpE57MPUrLWYj==pDjOMw@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] module: Move all into module/
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Joe Perches <joe@perches.com>,
        msuchanek@suse.de, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I did some testing on x86/ARM, no regressions.
Looks good so far. Will run it for little longer.

Thanks.

On Tue, Feb 22, 2022 at 6:13 AM Aaron Tomlin <atomlin@redhat.com> wrote:
>
> No functional changes.
>
> This patch moves all module related code into a separate directory,
> modifies each file name and creates a new Makefile. Note: this effort
> is in preparation to refactor core module code.
>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  MAINTAINERS                                         |  2 +-
>  kernel/Makefile                                     |  5 +----
>  kernel/module/Makefile                              | 12 ++++++++++++
>  kernel/{module_decompress.c => module/decompress.c} |  2 +-
>  kernel/{module-internal.h => module/internal.h}     |  0
>  kernel/{module.c => module/main.c}                  |  2 +-
>  kernel/{module_signing.c => module/signing.c}       |  2 +-
>  7 files changed, 17 insertions(+), 8 deletions(-)
>  create mode 100644 kernel/module/Makefile
>  rename kernel/{module_decompress.c => module/decompress.c} (99%)
>  rename kernel/{module-internal.h => module/internal.h} (100%)
>  rename kernel/{module.c => module/main.c} (99%)
>  rename kernel/{module_signing.c => module/signing.c} (97%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd86ed9fbc79..463bdb829db4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13012,7 +13012,7 @@ L:      linux-kernel@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
>  F:     include/linux/module.h
> -F:     kernel/module.c
> +F:     kernel/module/
>
>  MONOLITHIC POWER SYSTEM PMIC DRIVER
>  M:     Saravanan Sekar <sravanhome@gmail.com>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 56f4ee97f328..717075b65deb 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -29,7 +29,6 @@ KCOV_INSTRUMENT_softirq.o := n
>  KCSAN_SANITIZE_softirq.o = n
>  # These are called from save_stack_trace() on slub debug path,
>  # and produce insane amounts of uninteresting coverage.
> -KCOV_INSTRUMENT_module.o := n
>  KCOV_INSTRUMENT_extable.o := n
>  KCOV_INSTRUMENT_stacktrace.o := n
>  # Don't self-instrument.
> @@ -53,6 +52,7 @@ obj-y += rcu/
>  obj-y += livepatch/
>  obj-y += dma/
>  obj-y += entry/
> +obj-$(CONFIG_MODULES) += module/
>
>  obj-$(CONFIG_KCMP) += kcmp.o
>  obj-$(CONFIG_FREEZER) += freezer.o
> @@ -66,9 +66,6 @@ ifneq ($(CONFIG_SMP),y)
>  obj-y += up.o
>  endif
>  obj-$(CONFIG_UID16) += uid16.o
> -obj-$(CONFIG_MODULES) += module.o
> -obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
> -obj-$(CONFIG_MODULE_SIG) += module_signing.o
>  obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
>  obj-$(CONFIG_KALLSYMS) += kallsyms.o
>  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> new file mode 100644
> index 000000000000..cdd5c61b8c7f
> --- /dev/null
> +++ b/kernel/module/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for linux kernel module support
> +#
> +
> +# These are called from save_stack_trace() on slub debug path,
> +# and produce insane amounts of uninteresting coverage.
> +KCOV_INSTRUMENT_module.o := n
> +
> +obj-y += main.o
> +obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
> +obj-$(CONFIG_MODULE_SIG) += signing.o
> diff --git a/kernel/module_decompress.c b/kernel/module/decompress.c
> similarity index 99%
> rename from kernel/module_decompress.c
> rename to kernel/module/decompress.c
> index ffef98a20320..d14d6443225a 100644
> --- a/kernel/module_decompress.c
> +++ b/kernel/module/decompress.c
> @@ -12,7 +12,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/vmalloc.h>
>
> -#include "module-internal.h"
> +#include "internal.h"
>
>  static int module_extend_max_pages(struct load_info *info, unsigned int extent)
>  {
> diff --git a/kernel/module-internal.h b/kernel/module/internal.h
> similarity index 100%
> rename from kernel/module-internal.h
> rename to kernel/module/internal.h
> diff --git a/kernel/module.c b/kernel/module/main.c
> similarity index 99%
> rename from kernel/module.c
> rename to kernel/module/main.c
> index 46a5c2ed1928..34a2b0cf3c3e 100644
> --- a/kernel/module.c
> +++ b/kernel/module/main.c
> @@ -58,7 +58,7 @@
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
>  #include <uapi/linux/module.h>
> -#include "module-internal.h"
> +#include "internal.h"
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/module.h>
> diff --git a/kernel/module_signing.c b/kernel/module/signing.c
> similarity index 97%
> rename from kernel/module_signing.c
> rename to kernel/module/signing.c
> index 8723ae70ea1f..8aeb6d2ee94b 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module/signing.c
> @@ -12,7 +12,7 @@
>  #include <linux/string.h>
>  #include <linux/verification.h>
>  #include <crypto/public_key.h>
> -#include "module-internal.h"
> +#include "internal.h"
>
>  /*
>   * Verify the signature on a module.
> --
> 2.34.1
>


-- 
       - Allen
