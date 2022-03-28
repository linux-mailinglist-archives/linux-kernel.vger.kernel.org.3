Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6444E931E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiC1LST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiC1LSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382255492;
        Mon, 28 Mar 2022 04:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1384D61147;
        Mon, 28 Mar 2022 11:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B358AC340EC;
        Mon, 28 Mar 2022 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466189;
        bh=SEGKAv2y0LvSw8+qA9ED5lVRRO6x9HRUKOz3nmtGoC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUTV/QOq7dDA4kcmIkSHlLL/Hr9M04Fs6Vl5W5VQmjdsYu270n5hz/mijUUoBCylW
         RyysfIlXK7NXFCbLPvxou3Rv/NxGZhCanIVqXYkk1C+xyRGK4VwJGH3PrXY9tHNPTc
         reOczTlpUZSom/wyacm3f2vHkjY1t++RgYCFKu2IzJxjEJKhWV4F5wvgZbbcTbc1hC
         044fBGw9JLpSB6LhU+ye76Spr+A37VSsQvcxKkyB0fWpE80MQlGOOhjZsskkHYZhbY
         5wmKVwR3jKiwjfmAxTg8LdL7sdqj9YsjPQuWPTyl8OF4jgTO11Qvf4gThlBKtpRqyS
         kIq7WJRMN83ZQ==
Date:   Mon, 28 Mar 2022 20:16:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
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
Subject: Re: [PATCH v4 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220328201622.c0b06c599b2f3dfc971f48eb@kernel.org>
In-Reply-To: <CAK7LNATv8aHMPazZ1TrLjT4T6SfFSpFJcQNJOVFdc4_noO61Kw@mail.gmail.com>
References: <164833878595.2575750.1483106296151574233.stgit@devnote2>
        <164833880897.2575750.113875316750095499.stgit@devnote2>
        <CAK7LNATv8aHMPazZ1TrLjT4T6SfFSpFJcQNJOVFdc4_noO61Kw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 15:27:43 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Sun, Mar 27, 2022 at 8:53 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > This allows kernel developer to embed a default bootconfig file in
> > the kernel instead of embedding it in the initrd. This will be good
> > for who are using the kernel without initrd, or who needs a default
> > bootconfigs.
> > This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
> > the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.
> >
> > Note that you still need 'bootconfig' command line option to load the
> > embedded bootconfig. Also if you boot using an initrd with a different
> > bootconfig, the kernel will use the bootconfig in the initrd, instead
> > of the default bootconfig.
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Avoid updating the default.bconf if the file is not changed.
> > ---
> >  include/linux/bootconfig.h |   10 ++++++++++
> >  init/Kconfig               |   21 +++++++++++++++++++++
> >  init/main.c                |   13 ++++++++-----
> >  lib/.gitignore             |    1 +
> >  lib/Makefile               |   10 ++++++++++
> >  lib/bootconfig.c           |   23 +++++++++++++++++++++++
> >  6 files changed, 73 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > index a4665c7ab07c..5dbda5e3e9bb 100644
> > --- a/include/linux/bootconfig.h
> > +++ b/include/linux/bootconfig.h
> > @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
> >  /* XBC cleanup data structures */
> >  void __init xbc_exit(void);
> >
> > +/* XBC embedded bootconfig data in kernel */
> > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > +char * __init xbc_get_embedded_bootconfig(size_t *size);
> > +#else
> > +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> > +{
> > +       return NULL;
> > +}
> > +#endif
> > +
> >  #endif
> > diff --git a/init/Kconfig b/init/Kconfig
> > index beb5b866c318..bff308a782f8 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1357,6 +1357,27 @@ config BOOT_CONFIG
> >
> >           If unsure, say Y.
> >
> > +config EMBED_BOOT_CONFIG
> > +       bool "Embed bootconfig file in the kernel"
> > +       depends on BOOT_CONFIG
> > +       default n
> > +       help
> > +         Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> > +         kernel. Usually, the bootconfig file is loaded with the initrd
> > +         image. But if the system doesn't support initrd, this option will
> > +         help you by embedding a bootconfig file while building the kernel.
> > +
> > +         If unsure, say N.
> > +
> > +config EMBED_BOOT_CONFIG_FILE
> > +       string "Embedded bootconfig file path"
> > +       default ""
> > +       depends on EMBED_BOOT_CONFIG
> > +       help
> > +         Specify a bootconfig file which will be embedded to the kernel.
> > +         This bootconfig will be used if there is no initrd or no other
> > +         bootconfig in the initrd.
> > +
> >  choice
> >         prompt "Compiler optimization level"
> >         default CC_OPTIMIZE_FOR_PERFORMANCE
> > diff --git a/init/main.c b/init/main.c
> > index 4f3ba3b84e34..180511324c95 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
> >  early_param("loglevel", loglevel);
> >
> >  #ifdef CONFIG_BLK_DEV_INITRD
> > -static void * __init get_boot_config_from_initrd(u32 *_size)
> > +static void * __init get_boot_config_from_initrd(size_t *_size)
> >  {
> >         u32 size, csum;
> >         char *data;
> > @@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
> >         static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> >         const char *msg;
> >         int pos;
> > -       u32 size;
> > +       size_t size;
> >         char *data, *err;
> >         int ret;
> >
> >         /* Cut out the bootconfig data even if we have no bootconfig option */
> >         data = get_boot_config_from_initrd(&size);
> > +       /* If there is no bootconfig in initrd, try embedded one. */
> > +       if (!data)
> > +               data = xbc_get_embedded_bootconfig(&size);
> >
> >         strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> >         err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > @@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
> >         }
> >
> >         if (size >= XBC_DATA_MAX) {
> > -               pr_err("bootconfig size %d greater than max size %d\n",
> > -                       size, XBC_DATA_MAX);
> > +               pr_err("bootconfig size %ld greater than max size %d\n",
> > +                       (long)size, XBC_DATA_MAX);
> >                 return;
> >         }
> >
> > @@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
> >                                 msg, pos);
> >         } else {
> >                 xbc_get_info(&ret, NULL);
> > -               pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> > +               pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> >                 /* keys starting with "kernel." are passed via cmdline */
> >                 extra_command_line = xbc_make_cmdline("kernel");
> >                 /* Also, "init." keys are init arguments */
> > diff --git a/lib/.gitignore b/lib/.gitignore
> > index e5e217b8307b..30a2a5db7033 100644
> > --- a/lib/.gitignore
> > +++ b/lib/.gitignore
> > @@ -6,3 +6,4 @@
> >  /oid_registry_data.c
> >  /test_fortify.log
> >  /test_fortify/*.log
> > +/default.bconf
> 
> 
> I think lib/.gitignore is alphabetically sorted.
> 
> Please insert the new one
> to the proper line.

Ah, OK. Let me fix that.

> > diff --git a/lib/Makefile b/lib/Makefile
> > index 353bc09ce38d..dd9f3ebb62ca 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -276,6 +276,16 @@ $(foreach file, $(libfdt_files), \
> >         $(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
> >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> >
> > +ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> > +$(obj)/bootconfig.o: $(obj)/default.bconf
> > +
> > +targets += default.bconf
> 
> 
> I did not test this patch, but presumably
> "make clean" will miss to clean up default.bconf
> 
> The 'targets' must exist outside the ifeq-block.
> Move the 'endif' up.
> 
> 
> ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> $(obj)/bootconfig.o: $(obj)/default.bconf
> endif
> 
> targets += default.bconf
> 
> ...

You're right! I didn't know this behavior. Thanks for the notice.
I misunderstood that the files in targets always be built...

After moving the 'targets' out of ifeq-block, I confirmed that the
default.bconf was not generated when CONFIG_EMBED_BOOT_CONFIG is not
set, and it is cleaned up when CONFIG_EMBED_BOOT_CONFIG=y.
Thanks!

> 
> > +filechk_defbconf = cat /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE)
> > +$(obj)/default.bconf: FORCE
> > +       $(call filechk,defbconf)
> 
> 
> This will work, but users will be confused when they
> try to build out-of-tree with the O= option.
> 
> If CONFIG_EMBED_BOOT_CONFIG_FILE is a relative path,
> it is actually relative to the object tree, not the source tree.

Yes, that's right. I would like to fix this issue.

> I am not sure if that is the expected behavior, but it is not documented
> anywhere.
> 
> 
> If you want to search both in the objtree and srctree,
> you can write like follows:   [UNTESTED]
> 
> 
> filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
> $(obj)/default.bconf: $(CONFIG_EMBED_BOOT_CONFIG_FILE) FORCE
>         $(call filechk,defbconf)

Great! let me check it works.

Thank you,

> 
> 
> 
> 
> > +
> > +endif
> > +
> >  lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
> >
> >  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index 74f3201ab8e5..3a3bf3a208e3 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -12,6 +12,29 @@
> >  #include <linux/kernel.h>
> >  #include <linux/memblock.h>
> >  #include <linux/string.h>
> > +
> > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > +asm (
> > +"      .pushsection .init.data, \"aw\"                 \n"
> > +"      .global embedded_bootconfig_data                \n"
> > +"embedded_bootconfig_data:                             \n"
> > +"      .incbin \"lib/default.bconf\"                   \n"
> > +"      .global embedded_bootconfig_data_end            \n"
> > +"embedded_bootconfig_data_end:                         \n"
> > +"      .popsection                                     \n"
> > +);
> > +
> > +extern __visible char embedded_bootconfig_data[];
> > +extern __visible char embedded_bootconfig_data_end[];
> > +
> > +char * __init xbc_get_embedded_bootconfig(size_t *size)
> > +{
> > +       *size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> > +       return (*size) ? embedded_bootconfig_data : NULL;
> > +}
> > +
> > +#endif
> > +
> >  #else /* !__KERNEL__ */
> >  /*
> >   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada


-- 
Masami Hiramatsu <mhiramat@kernel.org>
