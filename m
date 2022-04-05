Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A14F46FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383787AbiDEUzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452429AbiDEPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A453701C;
        Tue,  5 Apr 2022 07:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD520616D0;
        Tue,  5 Apr 2022 14:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC47C385A0;
        Tue,  5 Apr 2022 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649170553;
        bh=+wsa2KupAHEAkaJ6uGblvMqbej2o+NeI2jwDd8b2QR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d6d9V8yW4T+WsjbhuU0OTx8kSn0SLRe3XsjGeKmKK46+wPxSrj3/QRhEEV6ZDWfLz
         7wPYjp8irrCdZLmD/iIXH5LHr+7ctzP8IvPnW32MYfGBuQus3t+cIlRhF+JFFQeFTn
         Mmf6MKd49IAGmTNg5lf8Ojd98dtZDUEzb3H4JVLDlwnbcSYwVKQ/8Z0TZhL/UtjR5Q
         tiJMr9+5Wu4n0HQ3EsgMoYIA6dVndFdfsXn2oX0/MEtbELNDgDtvg6Dv8DucmFtLIQ
         M7VwJEQn5z3mDqGpTcK1YC+spTHrnmexvHpd8lbgVABLJE1dJLk1YvEib8KNZIa3ke
         xIs/sLUtztryg==
Date:   Tue, 5 Apr 2022 23:55:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220405235548.38344aba5a7fcb059924c367@kernel.org>
In-Reply-To: <164871509158.178991.12705786877340857725.stgit@devnote2>
References: <164871505771.178991.7870442736805590948.stgit@devnote2>
        <164871509158.178991.12705786877340857725.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Have you already picked this series?

Actually, kernel test robot reported an issue in this patch today.
Here is the patch. Should I send v8 including this?

Thank you,

diff --git a/init/main.c b/init/main.c
index 62dddc4206b4..f7fe7cbb1df8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -313,7 +313,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(u32 *_size)
+static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	return NULL;
 }

On Thu, 31 Mar 2022 17:24:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This allows kernel developer to embed a default bootconfig file in
> the kernel instead of embedding it in the initrd. This will be good
> for who are using the kernel without initrd, or who needs a default
> bootconfigs.
> This needs to set two kconfigs: CONFIG_BOOT_CONFIG_EMBED=y and set
> the file path to CONFIG_BOOT_CONFIG_EMBED_FILE.
> 
> Note that you still need 'bootconfig' command line option to load the
> embedded bootconfig. Also if you boot using an initrd with a different
> bootconfig, the kernel will use the bootconfig in the initrd, instead
> of the default bootconfig.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v7:
>   - Change kconfig option name to share the common prefix so that
>     we can search it easier.
>   - Make embedded_bootconfig_data readonly.
>   - Select CONFIG_BLK_DEV_INITRD only if CONFIG_BOOT_CONFIG_EMBED=n
>   - Remove redundant default settings for new Kconfig options.
>  Changes in v6:
>   - Split out the .incbin asm part as bootconfig-data.S according to
>     Masahiro's comment.
>  Changes in v5:
>   - Fix .gitignore to be sorted alphabetically.
>   - Make default.bconf is cleaned up correctly.
>   - Allow user to specify relative path to CONFIG_EMBED_BOOT_CONFIG_FILE.
>     (Thanks Masahiro!)
>  Changes in v4:
>   - Avoid updating the default.bconf if the file is not changed.
> ---
>  MAINTAINERS                |    1 +
>  include/linux/bootconfig.h |   10 ++++++++++
>  init/Kconfig               |   21 ++++++++++++++++++++-
>  init/main.c                |   20 +++++++++++---------
>  lib/.gitignore             |    1 +
>  lib/Makefile               |    8 ++++++++
>  lib/bootconfig-data.S      |   10 ++++++++++
>  lib/bootconfig.c           |   13 +++++++++++++
>  8 files changed, 74 insertions(+), 10 deletions(-)
>  create mode 100644 lib/bootconfig-data.S
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b555a5e8704f..9b4910685412 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7350,6 +7350,7 @@ S:	Maintained
>  F:	Documentation/admin-guide/bootconfig.rst
>  F:	fs/proc/bootconfig.c
>  F:	include/linux/bootconfig.h
> +F:	lib/bootconfig-data.S
>  F:	lib/bootconfig.c
>  F:	tools/bootconfig/*
>  F:	tools/bootconfig/scripts/*
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index a4665c7ab07c..1611f9db878e 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
>  /* XBC cleanup data structures */
>  void __init xbc_exit(void);
>  
> +/* XBC embedded bootconfig data in kernel */
> +#ifdef CONFIG_BOOT_CONFIG_EMBED
> +const char * __init xbc_get_embedded_bootconfig(size_t *size);
> +#else
> +static inline const char *xbc_get_embedded_bootconfig(size_t *size)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif
> diff --git a/init/Kconfig b/init/Kconfig
> index 97463a33baa7..756872d17fe1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1351,7 +1351,7 @@ endif
>  
>  config BOOT_CONFIG
>  	bool "Boot config support"
> -	select BLK_DEV_INITRD
> +	select BLK_DEV_INITRD if !BOOT_CONFIG_EMBED
>  	help
>  	  Extra boot config allows system admin to pass a config file as
>  	  complemental extension of kernel cmdline when booting.
> @@ -1361,6 +1361,25 @@ config BOOT_CONFIG
>  
>  	  If unsure, say Y.
>  
> +config BOOT_CONFIG_EMBED
> +	bool "Embed bootconfig file in the kernel"
> +	depends on BOOT_CONFIG
> +	help
> +	  Embed a bootconfig file given by BOOT_CONFIG_EMBED_FILE in the
> +	  kernel. Usually, the bootconfig file is loaded with the initrd
> +	  image. But if the system doesn't support initrd, this option will
> +	  help you by embedding a bootconfig file while building the kernel.
> +
> +	  If unsure, say N.
> +
> +config BOOT_CONFIG_EMBED_FILE
> +	string "Embedded bootconfig file path"
> +	depends on BOOT_CONFIG_EMBED
> +	help
> +	  Specify a bootconfig file which will be embedded to the kernel.
> +	  This bootconfig will be used if there is no initrd or no other
> +	  bootconfig in the initrd.
> +
>  choice
>  	prompt "Compiler optimization level"
>  	default CC_OPTIMIZE_FOR_PERFORMANCE
> diff --git a/init/main.c b/init/main.c
> index 266d61bc67b0..62dddc4206b4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -266,7 +266,7 @@ static int __init loglevel(char *str)
>  early_param("loglevel", loglevel);
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -static void * __init get_boot_config_from_initrd(u32 *_size)
> +static void * __init get_boot_config_from_initrd(size_t *_size)
>  {
>  	u32 size, csum;
>  	char *data;
> @@ -410,14 +410,16 @@ static int __init warn_bootconfig(char *str)
>  static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> -	const char *msg;
> -	int pos;
> -	u32 size;
> -	char *data, *err;
> -	int ret;
> +	const char *msg, *data;
> +	int pos, ret;
> +	size_t size;
> +	char *err;
>  
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
>  	data = get_boot_config_from_initrd(&size);
> +	/* If there is no bootconfig in initrd, try embedded one. */
> +	if (!data)
> +		data = xbc_get_embedded_bootconfig(&size);
>  
>  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -436,8 +438,8 @@ static void __init setup_boot_config(void)
>  	}
>  
>  	if (size >= XBC_DATA_MAX) {
> -		pr_err("bootconfig size %d greater than max size %d\n",
> -			size, XBC_DATA_MAX);
> +		pr_err("bootconfig size %ld greater than max size %d\n",
> +			(long)size, XBC_DATA_MAX);
>  		return;
>  	}
>  
> @@ -450,7 +452,7 @@ static void __init setup_boot_config(void)
>  				msg, pos);
>  	} else {
>  		xbc_get_info(&ret, NULL);
> -		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> +		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
>  		/* keys starting with "kernel." are passed via cmdline */
>  		extra_command_line = xbc_make_cmdline("kernel");
>  		/* Also, "init." keys are init arguments */
> diff --git a/lib/.gitignore b/lib/.gitignore
> index e5e217b8307b..54596b634ecb 100644
> --- a/lib/.gitignore
> +++ b/lib/.gitignore
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /crc32table.h
>  /crc64table.h
> +/default.bconf
>  /gen_crc32table
>  /gen_crc64table
>  /oid_registry_data.c
> diff --git a/lib/Makefile b/lib/Makefile
> index 08053df16c7c..95268d6c75b7 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -280,6 +280,14 @@ $(foreach file, $(libfdt_files), \
>  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
>  
>  obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
> +obj-$(CONFIG_BOOT_CONFIG_EMBED) += bootconfig-data.o
> +
> +$(obj)/bootconfig-data.o: $(obj)/default.bconf
> +
> +targets += default.bconf
> +filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
> +$(obj)/default.bconf: $(CONFIG_BOOT_CONFIG_EMBED_FILE) FORCE
> +	$(call filechk,defbconf)
>  
>  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
>  obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
> diff --git a/lib/bootconfig-data.S b/lib/bootconfig-data.S
> new file mode 100644
> index 000000000000..ef85ba1a82f4
> --- /dev/null
> +++ b/lib/bootconfig-data.S
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Embed default bootconfig in the kernel.
> + */
> +	.section .init.rodata, "aw"
> +	.global embedded_bootconfig_data
> +embedded_bootconfig_data:
> +	.incbin "lib/default.bconf"
> +	.global embedded_bootconfig_data_end
> +embedded_bootconfig_data_end:
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 74f3201ab8e5..c59d26068a64 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -12,6 +12,19 @@
>  #include <linux/kernel.h>
>  #include <linux/memblock.h>
>  #include <linux/string.h>
> +
> +#ifdef CONFIG_BOOT_CONFIG_EMBED
> +/* embedded_bootconfig_data is defined in bootconfig-data.S */
> +extern __visible const char embedded_bootconfig_data[];
> +extern __visible const char embedded_bootconfig_data_end[];
> +
> +const char * __init xbc_get_embedded_bootconfig(size_t *size)
> +{
> +	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> +	return (*size) ? embedded_bootconfig_data : NULL;
> +}
> +#endif
> +
>  #else /* !__KERNEL__ */
>  /*
>   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
