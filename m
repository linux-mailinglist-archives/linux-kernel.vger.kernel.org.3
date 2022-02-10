Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA30E4B0200
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiBJBW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:22:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiBJBWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:22:53 -0500
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1E767E;
        Wed,  9 Feb 2022 17:22:54 -0800 (PST)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-08.nifty.com with ESMTP id 21A0aquJ004113;
        Thu, 10 Feb 2022 09:36:52 +0900
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 21A0aO2n010388;
        Thu, 10 Feb 2022 09:36:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 21A0aO2n010388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644453385;
        bh=gxjASy4yU28gsqLNibgVXOH1h+qkwzKge336qQ/QGKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YP1SsRn3KwHVLZ79mE1I3F7r3IS5RWRn29Uc0PxFoIjB0qnkABndrRgSnw391Ip1j
         Eb8llS7r2oPcl/NvkEqZY3Tq0mM5Nb3D44bRWr2fpxblwm+LWjN94Newk62rMDmlYV
         gJqYLDt6e5zPbE1UCS1Z2x6EiW1RTW8al+GfyFeJmfeT0pV2a5QHWCR6LArh6+t/Xd
         oXDhd/eyBkXLRt6BZbARD3UPmQ+P08N4ThwbAXWXAc4kgaKdLp+eiP1BMn9KWaO9mX
         JoF3dvuW6Suoo09URHwbJPy3Pgk311Zjk0ZVJ3ae9vEy2iETpKaThr96HfNAVcwGnD
         ACbDf64i6GO/g==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso6853913pjt.4;
        Wed, 09 Feb 2022 16:36:25 -0800 (PST)
X-Gm-Message-State: AOAM530q8UDdiBzyDI3K5VaPpDV9LMOIQXbMeRmA3HdSbhSIk3ImhBk/
        dm6fmNgqV5XJ+kQvqui1nDlgxJ+EibAoaI/QnoY=
X-Google-Smtp-Source: ABdhPJwNXUBTxEmzEGG7AZEUSnIuMPjraLWofy9i0YS+D8Y60QNIpGltEJ10tBO4+xCr+apLDhQVpV5hWojAfFrNN1c=
X-Received: by 2002:a17:903:22c5:: with SMTP id y5mr2792908plg.99.1644453383904;
 Wed, 09 Feb 2022 16:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20220208184309.148192-1-nick.alcock@oracle.com> <20220208184309.148192-3-nick.alcock@oracle.com>
In-Reply-To: <20220208184309.148192-3-nick.alcock@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 09:35:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToG8ozUcMcro4osBKPiisqW4mpo+=uBeMUmVfztnNMDA@mail.gmail.com>
Message-ID: <CAK7LNAToG8ozUcMcro4osBKPiisqW4mpo+=uBeMUmVfztnNMDA@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] kbuild: add modules_thick.builtin
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
> This is similar to modules.builtin, and constructed in a similar way to
> the way that used to be built before commit
> 8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
> and recursive concatenation up the tree. Unlike modules.builtin,
> modules_thick.builtin givs the names of the object files that make up
> modules that are comprised of more than one object file, using a syntax
> similar to that of makefiles, e.g.:
>
> crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
> crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
> crypto/aead.o:
> crypto/geniv.o:
>
> (where the latter two are single-file modules).
>
> An upcoming commit will use this mapping to populate /proc/kallmodsyms.
>
> A parser is included that yields a stram of (module, objfile name[])
> mappings: it's a bit baroque, but then parsing text files in C is quite
> painful, and I'd rather put the complexity in here than in its callers.
> The parser is not built in this commit, nor does it have any callers
> yet; nor is any rule added that causes modules_thick.builtin to actually
> be constructed.  (Again, see a later commit for that.)
>
> I am not wedded to the approach used to construct this file, but I don't
> see any other way to do it despite spending a week or so trying to tie
> it into Kbuild without using a separate Makefile.modbuiltin: unlike the
> names of builtin modules (which are also recorded in the source files
> themseves via MODULE_*() macros) the mapping from object file name to
> built-in module name is not recorded anywhere but in the makefiles
> themselves, so we have to at least reparse them with something to
> indicate the builtin-ness of each module (i.e., tristate.conf) if we are
> to figure out which modules are built-in and which are not.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>


modules.builtin was initially implemented in a terrible way,
hence I cleaned up the code and removed the double recursion
of the source tree.

Honestly, I do not want to see you bringing back
all the bloat.





> ---
>  .gitignore                  |   1 +
>  Documentation/dontdiff      |   1 +
>  Makefile                    |  19 +++-
>  scripts/Kbuild.include      |   6 ++
>  scripts/Makefile.modbuiltin |  56 ++++++++++
>  scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
>  scripts/modules_thick.h     |  48 +++++++++
>  7 files changed, 330 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/Makefile.modbuiltin
>  create mode 100644 scripts/modules_thick.c
>  create mode 100644 scripts/modules_thick.h
>
> diff --git a/.gitignore b/.gitignore
> index 7afd412dadd2..b49cd96f587a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -49,6 +49,7 @@
>  *.zst
>  Module.symvers
>  modules.order
> +modules_thick.builtin
>
>  #
>  # Top-level generic files
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 910b30a2a7d9..6a78988547d0 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -183,6 +183,7 @@ modules.builtin
>  modules.builtin.modinfo
>  modules.nsdeps
>  modules.order
> +modules_thick.builtin
>  modversions.h*
>  nconf
>  nconf-cfg
> diff --git a/Makefile b/Makefile
> index 199b6f388484..5e823fe8390f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1470,6 +1470,23 @@ __modinst_pre:
>
>  endif # CONFIG_MODULES
>
> +# modules_thick.builtin maps from kernel modules (or rather the object file
> +# names they would have had had they not been built in) to their constituent
> +# object files: we can use this to determine which modules any given object
> +# file is part of.  (We cannot eliminate the slight redundancy here without
> +# double-expansion.)
> +
> +modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
> +
> +modules_thick.builtin: $(modthickbuiltin-files)
> +       $(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
> +
> +# tristate.conf is not included from this Makefile. Add it as a prerequisite
> +# here to make it self-healing in case somebody accidentally removes it.
> +$(modthickbuiltin-files): include/config/tristate.conf
> +       $(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
> +
> +
>  ###
>  # Cleaning is done on three levels.
>  # make clean     Delete most generated files
> @@ -1849,7 +1866,7 @@ clean: $(clean-dirs)
>                 -o -name '*.lex.c' -o -name '*.tab.[ch]' \
>                 -o -name '*.asn1.[ch]' \
>                 -o -name '*.symtypes' -o -name 'modules.order' \
> -               -o -name '.tmp_*.o.*' \
> +               -o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
>                 -o -name '*.c.[012]*.*' \
>                 -o -name '*.ll' \
>                 -o -name '*.gcno' \
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 3514c2149e9d..167bbbd5fdf5 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -74,6 +74,12 @@ endef
>  # $(Q)$(MAKE) $(build)=dir
>  build := -f $(srctree)/scripts/Makefile.build obj
>
> +###
> +# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
> +# Usage:
> +# $(Q)$(MAKE) $(modbuiltin)=dir
> +modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
> +
>  ###
>  # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
>  # Usage:
> diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
> new file mode 100644
> index 000000000000..a27b692ea795
> --- /dev/null
> +++ b/scripts/Makefile.modbuiltin
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# ==========================================================================
> +# Generating modules_thick.builtin
> +# ==========================================================================
> +
> +src := $(obj)
> +
> +PHONY := __modbuiltin
> +__modbuiltin:
> +
> +include include/config/auto.conf
> +# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
> +# That way, we get the list of built-in modules in obj-Y
> +include include/config/tristate.conf
> +
> +include scripts/Kbuild.include
> +
> +ifdef building_out_of_srctree
> +# Create output directory if not already present
> +_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
> +endif
> +
> +# The filename Kbuild has precedence over Makefile
> +kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> +kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
> +include $(kbuild-file)
> +
> +include scripts/Makefile.lib
> +
> +modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
> +modthickbuiltin-target  := $(obj)/modules_thick.builtin
> +
> +__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
> +       @:
> +
> +$(modthickbuiltin-target): $(subdir-ym) FORCE
> +       $(Q) rm -f $@
> +       $(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
> +               printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
> +               printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
> +                       $($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
> +               printf "\n" >> $@; ) \
> +       cat /dev/null $(modthickbuiltin-subdirs) >> $@;
> +
> +PHONY += FORCE
> +
> +FORCE:
> +
> +# Descending
> +# ---------------------------------------------------------------------------
> +
> +PHONY += $(subdir-ym)
> +$(subdir-ym):
> +       $(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
> +
> +.PHONY: $(PHONY)
> diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
> new file mode 100644
> index 000000000000..9a15e99c1330
> --- /dev/null
> +++ b/scripts/modules_thick.c
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * A simple modules_thick reader.
> + *
> + * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "modules_thick.h"
> +
> +/*
> + * Read a modules_thick.builtin file and translate it into a stream of
> + * name / module-name pairs.
> + */
> +
> +/*
> + * Construct a modules_thick.builtin iterator.
> + */
> +struct modules_thick_iter *
> +modules_thick_iter_new(const char *modules_thick_file)
> +{
> +       struct modules_thick_iter *i;
> +
> +       i = calloc(1, sizeof(struct modules_thick_iter));
> +       if (i == NULL)
> +               return NULL;
> +
> +       i->f = fopen(modules_thick_file, "r");
> +
> +       if (i->f == NULL) {
> +               fprintf(stderr, "Cannot open builtin module file %s: %s\n",
> +                       modules_thick_file, strerror(errno));
> +               return NULL;
> +       }
> +
> +       return i;
> +}
> +
> +/*
> + * Iterate, returning a new null-terminated array of object file names, and a
> + * new dynamically-allocated module name.  (The module name passed in is freed.)
> + *
> + * The array of object file names should be freed by the caller: the strings it
> + * points to are owned by the iterator, and should not be freed.
> + */
> +
> +char ** __attribute__((__nonnull__))
> +modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
> +{
> +       size_t npaths = 1;
> +       char **module_paths;
> +       char *last_slash;
> +       char *last_dot;
> +       char *trailing_linefeed;
> +       char *object_name = i->line;
> +       char *dash;
> +       int composite = 0;
> +
> +       /*
> +        * Read in all module entries, computing the suffixless, pathless name
> +        * of the module and building the next arrayful of object file names for
> +        * return.
> +        *
> +        * Modules can consist of multiple files: in this case, the portion
> +        * before the colon is the path to the module (as before): the portion
> +        * after the colon is a space-separated list of files that should be
> +        * considered part of this module.  In this case, the portion before the
> +        * name is an "object file" that does not actually exist: it is merged
> +        * into built-in.a without ever being written out.
> +        *
> +        * All module names have - translated to _, to match what is done to the
> +        * names of the same things when built as modules.
> +        */
> +
> +       /*
> +        * Reinvocation of exhausted iterator. Return NULL, once.
> +        */
> +retry:
> +       if (getline(&i->line, &i->line_size, i->f) < 0) {
> +               if (ferror(i->f)) {
> +                       fprintf(stderr, "Error reading from modules_thick file:"
> +                               " %s\n", strerror(errno));
> +                       exit(1);
> +               }
> +               rewind(i->f);
> +               return NULL;
> +       }
> +
> +       if (i->line[0] == '\0')
> +               goto retry;
> +
> +       /*
> +        * Slice the line in two at the colon, if any.  If there is anything
> +        * past the ': ', this is a composite module.  (We allow for no colon
> +        * for robustness, even though one should always be present.)
> +        */
> +       if (strchr(i->line, ':') != NULL) {
> +               char *name_start;
> +
> +               object_name = strchr(i->line, ':');
> +               *object_name = '\0';
> +               object_name++;
> +               name_start = object_name + strspn(object_name, " \n");
> +               if (*name_start != '\0') {
> +                       composite = 1;
> +                       object_name = name_start;
> +               }
> +       }
> +
> +       /*
> +        * Figure out the module name.
> +        */
> +       last_slash = strrchr(i->line, '/');
> +       last_slash = (!last_slash) ? i->line :
> +               last_slash + 1;
> +       free(*module_name);
> +       *module_name = strdup(last_slash);
> +       dash = *module_name;
> +
> +       while (dash != NULL) {
> +               dash = strchr(dash, '-');
> +               if (dash != NULL)
> +                       *dash = '_';
> +       }
> +
> +       last_dot = strrchr(*module_name, '.');
> +       if (last_dot != NULL)
> +               *last_dot = '\0';
> +
> +       trailing_linefeed = strchr(object_name, '\n');
> +       if (trailing_linefeed != NULL)
> +               *trailing_linefeed = '\0';
> +
> +       /*
> +        * Multifile separator? Object file names explicitly stated:
> +        * slice them up and shuffle them in.
> +        *
> +        * The array size may be an overestimate if any object file
> +        * names start or end with spaces (very unlikely) but cannot be
> +        * an underestimate.  (Check for it anyway.)
> +        */
> +       if (composite) {
> +               char *one_object;
> +
> +               for (npaths = 0, one_object = object_name;
> +                    one_object != NULL;
> +                    npaths++, one_object = strchr(one_object + 1, ' '));
> +       }
> +
> +       module_paths = malloc((npaths + 1) * sizeof(char *));
> +       if (!module_paths) {
> +               fprintf(stderr, "%s: out of memory on module %s\n", __func__,
> +                       *module_name);
> +               exit(1);
> +       }
> +
> +       if (composite) {
> +               char *one_object;
> +               size_t i = 0;
> +
> +               while ((one_object = strsep(&object_name, " ")) != NULL) {
> +                       if (i >= npaths) {
> +                               fprintf(stderr, "%s: num_objs overflow on module "
> +                                       "%s: this is a bug.\n", __func__,
> +                                       *module_name);
> +                               exit(1);
> +                       }
> +
> +                       module_paths[i++] = one_object;
> +               }
> +       } else
> +               module_paths[0] = i->line;      /* untransformed module name */
> +
> +       module_paths[npaths] = NULL;
> +
> +       return module_paths;
> +}
> +
> +/*
> + * Free an iterator. Can be called while iteration is underway, so even
> + * state that is freed at the end of iteration must be freed here too.
> + */
> +void
> +modules_thick_iter_free(struct modules_thick_iter *i)
> +{
> +       if (i == NULL)
> +               return;
> +       fclose(i->f);
> +       free(i->line);
> +       free(i);
> +}
> diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
> new file mode 100644
> index 000000000000..f5edcaf9550c
> --- /dev/null
> +++ b/scripts/modules_thick.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * A simple modules_thick reader.
> + *
> + * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_MODULES_THICK_H
> +#define _LINUX_MODULES_THICK_H
> +
> +#include <stdio.h>
> +#include <stddef.h>
> +
> +/*
> + * modules_thick.builtin iteration state.
> + */
> +struct modules_thick_iter {
> +       FILE *f;
> +       char *line;
> +       size_t line_size;
> +};
> +
> +/*
> + * Construct a modules_thick.builtin iterator.
> + */
> +struct modules_thick_iter *
> +modules_thick_iter_new(const char *modules_thick_file);
> +
> +/*
> + * Iterate, returning a new null-terminated array of object file names, and a
> + * new dynamically-allocated module name.  (The module name passed in is freed.)
> + *
> + * The array of object file names should be freed by the caller: the strings it
> + * points to are owned by the iterator, and should not be freed.
> + */
> +
> +char ** __attribute__((__nonnull__))
> +modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
> +
> +void
> +modules_thick_iter_free(struct modules_thick_iter *i);
> +
> +#endif
> --
> 2.35.0.260.gb82b153193.dirty
>


-- 
Best Regards
Masahiro Yamada
