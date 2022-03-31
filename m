Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3D4ED443
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiCaG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiCaG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:57:36 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41BBCBD;
        Wed, 30 Mar 2022 23:55:46 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 22V6tRcj004529;
        Thu, 31 Mar 2022 15:55:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 22V6tRcj004529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648709727;
        bh=L9kZOKHWhsgjEmJ2R6+mrbuMRxdSlCSQGK98H4ZVo9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfTSMeNvw/ruxmXXFZ9QNFY67/n54RPdp/gZ0a27GWZlfKgcSwZ9OK+ZlkJUQBFNg
         ZZNbdEntatoATiEydGQB2nbao318zUAvHhf0EkKyjphSj7EUfsjElyWjFkdDKlT4yl
         VAOKYrjqo3Fj1W/2ALxs7+iivh5Gv5U2o/NEVZ8NRPr5T6hI50rZ24ojUMi8pygxrR
         F02rmGZ+aZG0Y+PzB1TZQX6pvmc/uoX/4nwyTC18qU9nRaGku9ZxefImJpbWYdVYMq
         0/SJFIO+g8CSBLtoBKQYRa13yeklUCs7QlZNtiemBvQw3PDpQa/I1ZFu8zZ9So8tBd
         eyjkGlktcO8fQ==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id cm17so3182683pjb.2;
        Wed, 30 Mar 2022 23:55:27 -0700 (PDT)
X-Gm-Message-State: AOAM531NF2nJy8rBxEjvMBSDpdAONjlfLFFXFfib3Fc/fOgq8r17CbFL
        SiwNkNgRbDtgH1J3z8fPb838HaAwOcYxNLtpG/I=
X-Google-Smtp-Source: ABdhPJxsaGNhoSEJTEpheUYWiqhafrHfxnSoM0vUmaP7qyboo7NjwIbHvtlP7G0UtQOUPG2tIQLpBH78IrV3Knmf58s=
X-Received: by 2002:a17:90a:8041:b0:1c9:fc3a:f6ee with SMTP id
 e1-20020a17090a804100b001c9fc3af6eemr4470147pjw.144.1648709726539; Wed, 30
 Mar 2022 23:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <164870615889.127053.9055569952366814752.stgit@devnote2>
 <164870619150.127053.3677457860116913262.stgit@devnote2> <CAK7LNARfcVt9L=BBmB7N8GNBHHU_LZx7mjMF9zW0ozfW3WNfeg@mail.gmail.com>
 <20220331154918.67fdd2b2c18262631588e07c@kernel.org>
In-Reply-To: <20220331154918.67fdd2b2c18262631588e07c@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 15:54:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvO2i7k7bSgCiE944yUXvK=J3bo_=MiDa6TZuqY87p_A@mail.gmail.com>
Message-ID: <CAK7LNARvO2i7k7bSgCiE944yUXvK=J3bo_=MiDa6TZuqY87p_A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] bootconfig: Support embedding a bootconfig file in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 3:49 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 31 Mar 2022 15:27:56 +0900
> Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > On Thu, Mar 31, 2022 at 2:56 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > This allows kernel developer to embed a default bootconfig file in
> > > the kernel instead of embedding it in the initrd. This will be good
> > > for who are using the kernel without initrd, or who needs a default
> > > bootconfigs.
> > > This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
> > > the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.
> > >
> > > Note that you still need 'bootconfig' command line option to load the
> > > embedded bootconfig. Also if you boot using an initrd with a different
> > > bootconfig, the kernel will use the bootconfig in the initrd, instead
> > > of the default bootconfig.
> > >
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  Changes in v6:
> > >   - Split out the .incbin asm part as bootconfig-data.S according to
> > >     Masahiro's comment.
> > >  Changes in v5:
> > >   - Fix .gitignore to be sorted alphabetically.
> > >   - Make default.bconf is cleaned up correctly.
> > >   - Allow user to specify relative path to CONFIG_EMBED_BOOT_CONFIG_FILE.
> > >     (Thanks Masahiro!)
> > >  Changes in v4:
> > >   - Avoid updating the default.bconf if the file is not changed.
> > > ---
> > >  MAINTAINERS                |    1 +
> > >  include/linux/bootconfig.h |   10 ++++++++++
> > >  init/Kconfig               |   21 +++++++++++++++++++++
> > >  init/main.c                |   13 ++++++++-----
> > >  lib/.gitignore             |    1 +
> > >  lib/Makefile               |    8 ++++++++
> > >  lib/bootconfig-data.S      |   11 +++++++++++
> > >  lib/bootconfig.c           |   13 +++++++++++++
> > >  8 files changed, 73 insertions(+), 5 deletions(-)
> > >  create mode 100644 lib/bootconfig-data.S
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b555a5e8704f..9b4910685412 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7350,6 +7350,7 @@ S:        Maintained
> > >  F:     Documentation/admin-guide/bootconfig.rst
> > >  F:     fs/proc/bootconfig.c
> > >  F:     include/linux/bootconfig.h
> > > +F:     lib/bootconfig-data.S
> > >  F:     lib/bootconfig.c
> > >  F:     tools/bootconfig/*
> > >  F:     tools/bootconfig/scripts/*
> > > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > > index a4665c7ab07c..5dbda5e3e9bb 100644
> > > --- a/include/linux/bootconfig.h
> > > +++ b/include/linux/bootconfig.h
> > > @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
> > >  /* XBC cleanup data structures */
> > >  void __init xbc_exit(void);
> > >
> > > +/* XBC embedded bootconfig data in kernel */
> > > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > > +char * __init xbc_get_embedded_bootconfig(size_t *size);
> > > +#else
> > > +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> > > +{
> > > +       return NULL;
> > > +}
> > > +#endif
> > > +
> > >  #endif
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 97463a33baa7..f5d14a78cfce 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1361,6 +1361,27 @@ config BOOT_CONFIG
> > >
> > >           If unsure, say Y.
> > >
> > > +config EMBED_BOOT_CONFIG
> > > +       bool "Embed bootconfig file in the kernel"
> > > +       depends on BOOT_CONFIG
> > > +       default n
> > > +       help
> > > +         Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> > > +         kernel. Usually, the bootconfig file is loaded with the initrd
> > > +         image. But if the system doesn't support initrd, this option will
> > > +         help you by embedding a bootconfig file while building the kernel.
> > > +
> > > +         If unsure, say N.
> > > +
> > > +config EMBED_BOOT_CONFIG_FILE
> > > +       string "Embedded bootconfig file path"
> > > +       default ""
> > > +       depends on EMBED_BOOT_CONFIG
> > > +       help
> > > +         Specify a bootconfig file which will be embedded to the kernel.
> > > +         This bootconfig will be used if there is no initrd or no other
> > > +         bootconfig in the initrd.
> > > +
> > >  choice
> > >         prompt "Compiler optimization level"
> > >         default CC_OPTIMIZE_FOR_PERFORMANCE
> > > diff --git a/init/main.c b/init/main.c
> > > index 266d61bc67b0..a5db3e36b809 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -266,7 +266,7 @@ static int __init loglevel(char *str)
> > >  early_param("loglevel", loglevel);
> > >
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > -static void * __init get_boot_config_from_initrd(u32 *_size)
> > > +static void * __init get_boot_config_from_initrd(size_t *_size)
> > >  {
> > >         u32 size, csum;
> > >         char *data;
> > > @@ -412,12 +412,15 @@ static void __init setup_boot_config(void)
> > >         static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > >         const char *msg;
> > >         int pos;
> > > -       u32 size;
> > > +       size_t size;
> > >         char *data, *err;
> > >         int ret;
> > >
> > >         /* Cut out the bootconfig data even if we have no bootconfig option */
> > >         data = get_boot_config_from_initrd(&size);
> > > +       /* If there is no bootconfig in initrd, try embedded one. */
> > > +       if (!data)
> > > +               data = xbc_get_embedded_bootconfig(&size);
> > >
> > >         strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > >         err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > > @@ -436,8 +439,8 @@ static void __init setup_boot_config(void)
> > >         }
> > >
> > >         if (size >= XBC_DATA_MAX) {
> > > -               pr_err("bootconfig size %d greater than max size %d\n",
> > > -                       size, XBC_DATA_MAX);
> > > +               pr_err("bootconfig size %ld greater than max size %d\n",
> > > +                       (long)size, XBC_DATA_MAX);
> > >                 return;
> > >         }
> > >
> > > @@ -450,7 +453,7 @@ static void __init setup_boot_config(void)
> > >                                 msg, pos);
> > >         } else {
> > >                 xbc_get_info(&ret, NULL);
> > > -               pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> > > +               pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> > >                 /* keys starting with "kernel." are passed via cmdline */
> > >                 extra_command_line = xbc_make_cmdline("kernel");
> > >                 /* Also, "init." keys are init arguments */
> > > diff --git a/lib/.gitignore b/lib/.gitignore
> > > index e5e217b8307b..54596b634ecb 100644
> > > --- a/lib/.gitignore
> > > +++ b/lib/.gitignore
> > > @@ -1,6 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  /crc32table.h
> > >  /crc64table.h
> > > +/default.bconf
> > >  /gen_crc32table
> > >  /gen_crc64table
> > >  /oid_registry_data.c
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index 08053df16c7c..2a82cc324f91 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -280,6 +280,14 @@ $(foreach file, $(libfdt_files), \
> > >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> > >
> > >  obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
> > > +obj-$(CONFIG_EMBED_BOOT_CONFIG) += bootconfig-data.o
> > > +
> > > +$(obj)/bootconfig-data.o: $(obj)/default.bconf
> > > +
> > > +targets += default.bconf
> > > +filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
> > > +$(obj)/default.bconf: $(CONFIG_EMBED_BOOT_CONFIG_FILE) FORCE
> > > +       $(call filechk,defbconf)
> > >
> > >  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> > >  obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
> > > diff --git a/lib/bootconfig-data.S b/lib/bootconfig-data.S
> > > new file mode 100644
> > > index 000000000000..df674ea7d8be
> > > --- /dev/null
> > > +++ b/lib/bootconfig-data.S
> > > @@ -0,0 +1,11 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Embed default bootconfig in the kernel.
> > > + */
> > > +       .pushsection .init.data, "aw"
> > > +       .global embedded_bootconfig_data
> > > +embedded_bootconfig_data:
> > > +       .incbin "lib/default.bconf"
> > > +       .global embedded_bootconfig_data_end
> > > +embedded_bootconfig_data_end:
> > > +       .popsection
> >
> >
> >
> > You used  .pushsection / .popsection because it was
> > previously located in bootconfig.c, where there are
> > functions, which should go to the ".text" section.
>
> Oops, yes. I have made a dumb copy from the inline asm...
>
> > Now that you split this into a separate compilation unit,
> > there is only one ".init.data" section in the file.
> >
> >
> >      .section  .init.data, "aw"
> >
> > should be enough.
>
> OK.
>
> > BTW, is it reasonable/possible to make it explicitly read-only?
> >
> > I have not tested this patch at all. Nor do I have enough insight.
> >
> >      .section  .init.rodata, "a"
> >
> > I am not sure whether this is possible or not.
>
> Yes, it can be. The data is passed via 'const char *'.

But, you didn't add "const" in the C code:

extern __visible char embedded_bootconfig_data[];
extern __visible char embedded_bootconfig_data_end[];


Is it possible to use "const char" ?



-- 
Best Regards
Masahiro Yamada
