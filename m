Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927944E8E33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiC1Gau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiC1Gas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:30:48 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F3113F;
        Sun, 27 Mar 2022 23:29:04 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 22S6SRsC026796;
        Mon, 28 Mar 2022 15:28:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 22S6SRsC026796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648448908;
        bh=K8VIBxox/wo7+85R/mKEH3OnsLngjJEfU+Eg7MUbWec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1J8JDAUGdI/Jfd0dh7B1/5tLwR3T5+cGzvo6daSsxtoe97jq0ZY24EWl1FW8Is6at
         ie30zfUK/RzioJTAPjMovX4SZd2DhMiJNFJPF6LT6khPPKjbTQybN0ULNYCmnXqk8F
         7hQ7dI9citoNuMRktTJhYpQ9vwQosAoU32VUofGxKju+8ji2wEAq2ZS8yox7ywAT4Q
         sNRequLeKmjyQWcilD4fesSvFWrPSN1Tjru/sP+osf5kP7jnukD0d8kxfwvCKpSSEG
         bEsggvFvNVPJ9Uzi2wxFHcjNkdhn3ht9nVh3M6GPXMN+UnNOa0wbqvUGg19ClURtTu
         HzT+y6FfAxIVQ==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so17715237pjb.5;
        Sun, 27 Mar 2022 23:28:27 -0700 (PDT)
X-Gm-Message-State: AOAM530z47oPft3kHR6t/Ob2MDswM4C0Ck+nL6c2o+14zGRNi9UakWEb
        +/WiUM+IA80ICTZVNZqMLTVOKgnF94yf+Rx8zBg=
X-Google-Smtp-Source: ABdhPJyC1NVt/dBwHO7m1cIHzShj0yluWOyX5dVnlVGxbHzsukb5MUghc6aV+ODXzFf0BTMGuJAasS50SYPVIIy6bZQ=
X-Received: by 2002:a17:902:b68c:b0:153:bd06:85ad with SMTP id
 c12-20020a170902b68c00b00153bd0685admr24643000pls.99.1648448906891; Sun, 27
 Mar 2022 23:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <164833878595.2575750.1483106296151574233.stgit@devnote2> <164833880897.2575750.113875316750095499.stgit@devnote2>
In-Reply-To: <164833880897.2575750.113875316750095499.stgit@devnote2>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 28 Mar 2022 15:27:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATv8aHMPazZ1TrLjT4T6SfFSpFJcQNJOVFdc4_noO61Kw@mail.gmail.com>
Message-ID: <CAK7LNATv8aHMPazZ1TrLjT4T6SfFSpFJcQNJOVFdc4_noO61Kw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bootconfig: Support embedding a bootconfig file in kernel
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

On Sun, Mar 27, 2022 at 8:53 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> This allows kernel developer to embed a default bootconfig file in
> the kernel instead of embedding it in the initrd. This will be good
> for who are using the kernel without initrd, or who needs a default
> bootconfigs.
> This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
> the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.
>
> Note that you still need 'bootconfig' command line option to load the
> embedded bootconfig. Also if you boot using an initrd with a different
> bootconfig, the kernel will use the bootconfig in the initrd, instead
> of the default bootconfig.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Avoid updating the default.bconf if the file is not changed.
> ---
>  include/linux/bootconfig.h |   10 ++++++++++
>  init/Kconfig               |   21 +++++++++++++++++++++
>  init/main.c                |   13 ++++++++-----
>  lib/.gitignore             |    1 +
>  lib/Makefile               |   10 ++++++++++
>  lib/bootconfig.c           |   23 +++++++++++++++++++++++
>  6 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index a4665c7ab07c..5dbda5e3e9bb 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
>  /* XBC cleanup data structures */
>  void __init xbc_exit(void);
>
> +/* XBC embedded bootconfig data in kernel */
> +#ifdef CONFIG_EMBED_BOOT_CONFIG
> +char * __init xbc_get_embedded_bootconfig(size_t *size);
> +#else
> +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  #endif
> diff --git a/init/Kconfig b/init/Kconfig
> index beb5b866c318..bff308a782f8 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1357,6 +1357,27 @@ config BOOT_CONFIG
>
>           If unsure, say Y.
>
> +config EMBED_BOOT_CONFIG
> +       bool "Embed bootconfig file in the kernel"
> +       depends on BOOT_CONFIG
> +       default n
> +       help
> +         Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> +         kernel. Usually, the bootconfig file is loaded with the initrd
> +         image. But if the system doesn't support initrd, this option will
> +         help you by embedding a bootconfig file while building the kernel.
> +
> +         If unsure, say N.
> +
> +config EMBED_BOOT_CONFIG_FILE
> +       string "Embedded bootconfig file path"
> +       default ""
> +       depends on EMBED_BOOT_CONFIG
> +       help
> +         Specify a bootconfig file which will be embedded to the kernel.
> +         This bootconfig will be used if there is no initrd or no other
> +         bootconfig in the initrd.
> +
>  choice
>         prompt "Compiler optimization level"
>         default CC_OPTIMIZE_FOR_PERFORMANCE
> diff --git a/init/main.c b/init/main.c
> index 4f3ba3b84e34..180511324c95 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
>  early_param("loglevel", loglevel);
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> -static void * __init get_boot_config_from_initrd(u32 *_size)
> +static void * __init get_boot_config_from_initrd(size_t *_size)
>  {
>         u32 size, csum;
>         char *data;
> @@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
>         static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
>         const char *msg;
>         int pos;
> -       u32 size;
> +       size_t size;
>         char *data, *err;
>         int ret;
>
>         /* Cut out the bootconfig data even if we have no bootconfig option */
>         data = get_boot_config_from_initrd(&size);
> +       /* If there is no bootconfig in initrd, try embedded one. */
> +       if (!data)
> +               data = xbc_get_embedded_bootconfig(&size);
>
>         strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>         err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
>         }
>
>         if (size >= XBC_DATA_MAX) {
> -               pr_err("bootconfig size %d greater than max size %d\n",
> -                       size, XBC_DATA_MAX);
> +               pr_err("bootconfig size %ld greater than max size %d\n",
> +                       (long)size, XBC_DATA_MAX);
>                 return;
>         }
>
> @@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
>                                 msg, pos);
>         } else {
>                 xbc_get_info(&ret, NULL);
> -               pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> +               pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
>                 /* keys starting with "kernel." are passed via cmdline */
>                 extra_command_line = xbc_make_cmdline("kernel");
>                 /* Also, "init." keys are init arguments */
> diff --git a/lib/.gitignore b/lib/.gitignore
> index e5e217b8307b..30a2a5db7033 100644
> --- a/lib/.gitignore
> +++ b/lib/.gitignore
> @@ -6,3 +6,4 @@
>  /oid_registry_data.c
>  /test_fortify.log
>  /test_fortify/*.log
> +/default.bconf


I think lib/.gitignore is alphabetically sorted.

Please insert the new one
to the proper line.





> diff --git a/lib/Makefile b/lib/Makefile
> index 353bc09ce38d..dd9f3ebb62ca 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -276,6 +276,16 @@ $(foreach file, $(libfdt_files), \
>         $(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
>  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
>
> +ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> +$(obj)/bootconfig.o: $(obj)/default.bconf
> +
> +targets += default.bconf


I did not test this patch, but presumably
"make clean" will miss to clean up default.bconf

The 'targets' must exist outside the ifeq-block.
Move the 'endif' up.


ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
$(obj)/bootconfig.o: $(obj)/default.bconf
endif

targets += default.bconf

...





> +filechk_defbconf = cat /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE)
> +$(obj)/default.bconf: FORCE
> +       $(call filechk,defbconf)


This will work, but users will be confused when they
try to build out-of-tree with the O= option.

If CONFIG_EMBED_BOOT_CONFIG_FILE is a relative path,
it is actually relative to the object tree, not the source tree.
I am not sure if that is the expected behavior, but it is not documented
anywhere.


If you want to search both in the objtree and srctree,
you can write like follows:   [UNTESTED]


filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
$(obj)/default.bconf: $(CONFIG_EMBED_BOOT_CONFIG_FILE) FORCE
        $(call filechk,defbconf)




> +
> +endif
> +
>  lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
>
>  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 74f3201ab8e5..3a3bf3a208e3 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -12,6 +12,29 @@
>  #include <linux/kernel.h>
>  #include <linux/memblock.h>
>  #include <linux/string.h>
> +
> +#ifdef CONFIG_EMBED_BOOT_CONFIG
> +asm (
> +"      .pushsection .init.data, \"aw\"                 \n"
> +"      .global embedded_bootconfig_data                \n"
> +"embedded_bootconfig_data:                             \n"
> +"      .incbin \"lib/default.bconf\"                   \n"
> +"      .global embedded_bootconfig_data_end            \n"
> +"embedded_bootconfig_data_end:                         \n"
> +"      .popsection                                     \n"
> +);
> +
> +extern __visible char embedded_bootconfig_data[];
> +extern __visible char embedded_bootconfig_data_end[];
> +
> +char * __init xbc_get_embedded_bootconfig(size_t *size)
> +{
> +       *size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> +       return (*size) ? embedded_bootconfig_data : NULL;
> +}
> +
> +#endif
> +
>  #else /* !__KERNEL__ */
>  /*
>   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
>


-- 
Best Regards
Masahiro Yamada
