Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D174DD24F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiCRBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiCRBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BC6272F24;
        Thu, 17 Mar 2022 18:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61788615F8;
        Fri, 18 Mar 2022 01:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF22C340E9;
        Fri, 18 Mar 2022 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647566088;
        bh=PjCYq684cE8WpxvhQSO64ZVBTF5dnWDDGIPDDhW8hN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b67MYZColaU56bN2ydXx8eExS69Ta6+sbNFTInMV0ZmP+cyeS5+dQDjW6o+lrFGwk
         WcicEBCmooiNEkZYVarbo9e8B7ZW2a3fZFQ7ZT8AH3SdmlAa4CfW9JZSRfCL6YtTgu
         d1bE/SKDrvz2VWgvKzIfPZf0zN/pLdlAaEa0atiEPPSQosm3Wdt61XTgbesXU82xW/
         Mwbr9U/rCmJwYjqLaOuBGhJ1oI1obKlX+uxZlb94/mraVcO2uTtuCKEvmhX4qbIVpP
         /VsE34PAV6NtAg37/kJnZnFFJED93FnSIX/GsHoT8C9MwtmIICEz4W173ulDPMCLsj
         B2z6AkRvSyLoA==
Date:   Fri, 18 Mar 2022 10:14:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220318101445.fdb151efe58c6c3a1c572500@kernel.org>
In-Reply-To: <20220316191649.GA11547@pswork>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
        <164724892075.731226.14103557516176115189.stgit@devnote2>
        <20220316191649.GA11547@pswork>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 20:16:49 +0100
Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:

> Hello Masami Hiramatsu,
> 
> On Mon, Mar 14, 2022 at 06:08:41PM +0900, Masami Hiramatsu wrote:
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
> >  include/linux/bootconfig.h |   10 ++++++++++
> >  init/Kconfig               |   21 +++++++++++++++++++++
> >  init/main.c                |   13 ++++++++-----
> >  lib/.gitignore             |    1 +
> >  lib/Makefile               |   12 ++++++++++++
> >  lib/bootconfig.c           |   23 +++++++++++++++++++++++
> >  6 files changed, 75 insertions(+), 5 deletions(-)
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
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  #endif
> > diff --git a/init/Kconfig b/init/Kconfig
> > index e9119bf54b1f..70440804874d 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1357,6 +1357,27 @@ config BOOT_CONFIG
> >  
> >  	  If unsure, say Y.
> >  
> > +config EMBED_BOOT_CONFIG
> > +	bool "Embed bootconfig file in the kernel"
> > +	depends on BOOT_CONFIG
> > +	default n
> > +	help
> > +	  Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> > +	  kernel. Usually, the bootconfig file is loaded with the initrd
> > +	  image. But if the system doesn't support initrd, this option will
> > +	  help you by embedding a bootconfig file while building the kernel.
> > +
> > +	  If unsure, say N.
> > +
> > +config EMBED_BOOT_CONFIG_FILE
> > +	string "Embedded bootconfig file path"
> > +	default ""
> > +	depends on EMBED_BOOT_CONFIG
> > +	help
> > +	  Specify a bootconfig file which will be embedded to the kernel.
> > +	  This bootconfig will be used if there is no initrd or no other
> > +	  bootconfig in the initrd.
> > +
> >  choice
> >  	prompt "Compiler optimization level"
> >  	default CC_OPTIMIZE_FOR_PERFORMANCE
> > diff --git a/init/main.c b/init/main.c
> > index 421050be5039..3803bf2e22ea 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
> >  early_param("loglevel", loglevel);
> >  
> >  #ifdef CONFIG_BLK_DEV_INITRD
> > -static void * __init get_boot_config_from_initrd(u32 *_size)
> > +static void * __init get_boot_config_from_initrd(size_t *_size)
> >  {
> >  	u32 size, csum;
> >  	char *data;
> > @@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
> >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> >  	const char *msg;
> >  	int pos;
> > -	u32 size;
> > +	size_t size;
> >  	char *data, *err;
> >  	int ret;
> >  
> >  	/* Cut out the bootconfig data even if we have no bootconfig option */
> >  	data = get_boot_config_from_initrd(&size);
> > +	/* If there is no bootconfig in initrd, try embedded one. */
> > +	if (!data)
> > +		data = xbc_get_embedded_bootconfig(&size);
> >  
> >  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> >  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > @@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
> >  	}
> >  
> >  	if (size >= XBC_DATA_MAX) {
> > -		pr_err("bootconfig size %d greater than max size %d\n",
> > -			size, XBC_DATA_MAX);
> > +		pr_err("bootconfig size %ld greater than max size %d\n",
> > +			(long)size, XBC_DATA_MAX);
> >  		return;
> >  	}
> >  
> > @@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
> >  				msg, pos);
> >  	} else {
> >  		xbc_get_info(&ret, NULL);
> > -		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> > +		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> >  		/* keys starting with "kernel." are passed via cmdline */
> >  		extra_command_line = xbc_make_cmdline("kernel");
> >  		/* Also, "init." keys are init arguments */
> > diff --git a/lib/.gitignore b/lib/.gitignore
> > index e5e217b8307b..30a2a5db7033 100644
> > --- a/lib/.gitignore
> > +++ b/lib/.gitignore
> > @@ -6,3 +6,4 @@
> >  /oid_registry_data.c
> >  /test_fortify.log
> >  /test_fortify/*.log
> > +/default.bconf
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 300f569c626b..8183785ee99d 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -279,6 +279,18 @@ $(foreach file, $(libfdt_files), \
> >  	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
> >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> >  
> > +ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> > +# Since the specified bootconfig file can be switched, we forcibly update the
> > +# default.bconf file always.
> > +$(obj)/default.bconf: FORCE
> > +	$(call cmd,defbconf)
> > +
> > +quiet_cmd_defbconf = GEN     $@
> > +      cmd_defbconf = cat < /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE) > $@
> > +clean-files	+= default.bconf
> > +$(obj)/bootconfig.o: $(obj)/default.bconf
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
> > +"	.pushsection .init.data, \"aw\"			\n"
> > +"	.global embedded_bootconfig_data		\n"
> > +"embedded_bootconfig_data:				\n"
> > +"	.incbin \"lib/default.bconf\"			\n"
> > +"	.global embedded_bootconfig_data_end		\n"
> > +"embedded_bootconfig_data_end:				\n"
> > +"	.popsection					\n"
> > +);
> > +
> > +extern __visible char embedded_bootconfig_data[];
> > +extern __visible char embedded_bootconfig_data_end[];
> > +
> > +char * __init xbc_get_embedded_bootconfig(size_t *size)
> > +{
> > +	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> > +	return (*size) ? embedded_bootconfig_data : NULL;
> > +}
> > +
> > +#endif
> > +
> >  #else /* !__KERNEL__ */
> >  /*
> >   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> >
> 
> Thanks tested the implemation, it works as expected.

Great!

> 
> Also noted that a change in default.bconf requries a clean build, is it
> expected behaviour?

default.bconf will be always updated if CONFIG_EMBED_BOOT_CONFIG=y. So you can
do incremental build. (I tested it with the incremental build environment)

Thank you,

> 
> Thanks and Regards,
> Padmanabha.S


-- 
Masami Hiramatsu <mhiramat@kernel.org>
