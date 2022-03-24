Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D514E5C95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbiCXBHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiCXBHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D044694B8;
        Wed, 23 Mar 2022 18:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF5A2618F2;
        Thu, 24 Mar 2022 01:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7653C340E8;
        Thu, 24 Mar 2022 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083951;
        bh=eT+uo3aj/NOTYApfefYr2IrTVvK0p3ziJpTCo8Q14bo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rxhlDFNBFfUlArArBkoUJmJR3mvpnrSnWBAHVHVQPnweap0JJ2drbJbwaxvM9oqkN
         aY2bkkXRD2kvwsAohDR65YUyN9qlAPvQvBN+DAkbDdLrFN3YePRs+bG5Y9ivwElIQ2
         U5ZcJewRyRbkxgTuSDgyNUe1dX81mad3Z/Nw/hl+2d8vLUTOZ94DEdgqIwuPvfkmZT
         7kXt9SuVooM4HkNYeLvMksVLnrVHMpFeyDJ0Z3x+xvbonP0LHEkv1WGJs21uj6wpIT
         OavlQKpWMWjpD7z1RcH0gfLZVOyEX1EflQ2Tc8oqj2tCmUYSesFaxZxFu7cEVf1Gi4
         ABDL260kiv8iw==
Date:   Thu, 24 Mar 2022 10:05:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220324100546.10137147938805e40352fab3@kernel.org>
In-Reply-To: <20220323155618.GA11364@pswork>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
        <164724892075.731226.14103557516176115189.stgit@devnote2>
        <20220316191649.GA11547@pswork>
        <20220318101445.fdb151efe58c6c3a1c572500@kernel.org>
        <20220321183500.GA4065@pswork>
        <20220322120311.690f237b63ddfd9c0e4f78ec@kernel.org>
        <20220322190219.GA26859@pswork>
        <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
        <20220323155618.GA11364@pswork>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 16:56:18 +0100
Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:

> On Wed, Mar 23, 2022 at 09:16:17AM +0900, Masami Hiramatsu wrote:
> > On Tue, 22 Mar 2022 20:02:19 +0100
> > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > 
> > > Hello Masami Hiramatsu,
> > > 
> > > On Tue, Mar 22, 2022 at 12:03:11PM +0900, Masami Hiramatsu wrote:
> > > > On Mon, 21 Mar 2022 19:35:00 +0100
> > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > 
> > > > > Hello Masami Hiramatsu,
> > > > > 
> > > > > On Fri, Mar 18, 2022 at 10:14:45AM +0900, Masami Hiramatsu wrote:
> > > > > > On Wed, 16 Mar 2022 20:16:49 +0100
> > > > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > > > 
> > > > > > > Hello Masami Hiramatsu,
> > > > > > > 
> > > > > > > On Mon, Mar 14, 2022 at 06:08:41PM +0900, Masami Hiramatsu wrote:
> > > > > > > > This allows kernel developer to embed a default bootconfig file in
> > > > > > > > the kernel instead of embedding it in the initrd. This will be good
> > > > > > > > for who are using the kernel without initrd, or who needs a default
> > > > > > > > bootconfigs.
> > > > > > > > This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
> > > > > > > > the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.
> > > > > > > > 
> > > > > > > > Note that you still need 'bootconfig' command line option to load the
> > > > > > > > embedded bootconfig. Also if you boot using an initrd with a different
> > > > > > > > bootconfig, the kernel will use the bootconfig in the initrd, instead
> > > > > > > > of the default bootconfig.
> > > > > > > > 
> > > > > > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > > ---
> > > > > > > >  include/linux/bootconfig.h |   10 ++++++++++
> > > > > > > >  init/Kconfig               |   21 +++++++++++++++++++++
> > > > > > > >  init/main.c                |   13 ++++++++-----
> > > > > > > >  lib/.gitignore             |    1 +
> > > > > > > >  lib/Makefile               |   12 ++++++++++++
> > > > > > > >  lib/bootconfig.c           |   23 +++++++++++++++++++++++
> > > > > > > >  6 files changed, 75 insertions(+), 5 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > > > > > > > index a4665c7ab07c..5dbda5e3e9bb 100644
> > > > > > > > --- a/include/linux/bootconfig.h
> > > > > > > > +++ b/include/linux/bootconfig.h
> > > > > > > > @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
> > > > > > > >  /* XBC cleanup data structures */
> > > > > > > >  void __init xbc_exit(void);
> > > > > > > >  
> > > > > > > > +/* XBC embedded bootconfig data in kernel */
> > > > > > > > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > > > > > > > +char * __init xbc_get_embedded_bootconfig(size_t *size);
> > > > > > > > +#else
> > > > > > > > +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> > > > > > > > +{
> > > > > > > > +	return NULL;
> > > > > > > > +}
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > > > > index e9119bf54b1f..70440804874d 100644
> > > > > > > > --- a/init/Kconfig
> > > > > > > > +++ b/init/Kconfig
> > > > > > > > @@ -1357,6 +1357,27 @@ config BOOT_CONFIG
> > > > > > > >  
> > > > > > > >  	  If unsure, say Y.
> > > > > > > >  
> > > > > > > > +config EMBED_BOOT_CONFIG
> > > > > > > > +	bool "Embed bootconfig file in the kernel"
> > > > > > > > +	depends on BOOT_CONFIG
> > > > > > > > +	default n
> > > > > > > > +	help
> > > > > > > > +	  Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> > > > > > > > +	  kernel. Usually, the bootconfig file is loaded with the initrd
> > > > > > > > +	  image. But if the system doesn't support initrd, this option will
> > > > > > > > +	  help you by embedding a bootconfig file while building the kernel.
> > > > > > > > +
> > > > > > > > +	  If unsure, say N.
> > > > > > > > +
> > > > > > > > +config EMBED_BOOT_CONFIG_FILE
> > > > > > > > +	string "Embedded bootconfig file path"
> > > > > > > > +	default ""
> > > > > > > > +	depends on EMBED_BOOT_CONFIG
> > > > > > > > +	help
> > > > > > > > +	  Specify a bootconfig file which will be embedded to the kernel.
> > > > > > > > +	  This bootconfig will be used if there is no initrd or no other
> > > > > > > > +	  bootconfig in the initrd.
> > > > > > > > +
> > > > > > > >  choice
> > > > > > > >  	prompt "Compiler optimization level"
> > > > > > > >  	default CC_OPTIMIZE_FOR_PERFORMANCE
> > > > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > > > index 421050be5039..3803bf2e22ea 100644
> > > > > > > > --- a/init/main.c
> > > > > > > > +++ b/init/main.c
> > > > > > > > @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
> > > > > > > >  early_param("loglevel", loglevel);
> > > > > > > >  
> > > > > > > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > > > > > > -static void * __init get_boot_config_from_initrd(u32 *_size)
> > > > > > > > +static void * __init get_boot_config_from_initrd(size_t *_size)
> > > > > > > >  {
> > > > > > > >  	u32 size, csum;
> > > > > > > >  	char *data;
> > > > > > > > @@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
> > > > > > > >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > > > > > > >  	const char *msg;
> > > > > > > >  	int pos;
> > > > > > > > -	u32 size;
> > > > > > > > +	size_t size;
> > > > > > > >  	char *data, *err;
> > > > > > > >  	int ret;
> > > > > > > >  
> > > > > > > >  	/* Cut out the bootconfig data even if we have no bootconfig option */
> > > > > > > >  	data = get_boot_config_from_initrd(&size);
> > > > > > > > +	/* If there is no bootconfig in initrd, try embedded one. */
> > > > > > > > +	if (!data)
> > > > > > > > +		data = xbc_get_embedded_bootconfig(&size);
> > > > > > > >  
> > > > > > > >  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > > > > > >  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > > > > > > > @@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > >  	if (size >= XBC_DATA_MAX) {
> > > > > > > > -		pr_err("bootconfig size %d greater than max size %d\n",
> > > > > > > > -			size, XBC_DATA_MAX);
> > > > > > > > +		pr_err("bootconfig size %ld greater than max size %d\n",
> > > > > > > > +			(long)size, XBC_DATA_MAX);
> > > > > > > >  		return;
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > > @@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
> > > > > > > >  				msg, pos);
> > > > > > > >  	} else {
> > > > > > > >  		xbc_get_info(&ret, NULL);
> > > > > > > > -		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> > > > > > > > +		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> > > > > > > >  		/* keys starting with "kernel." are passed via cmdline */
> > > > > > > >  		extra_command_line = xbc_make_cmdline("kernel");
> > > > > > > >  		/* Also, "init." keys are init arguments */
> > > > > > > > diff --git a/lib/.gitignore b/lib/.gitignore
> > > > > > > > index e5e217b8307b..30a2a5db7033 100644
> > > > > > > > --- a/lib/.gitignore
> > > > > > > > +++ b/lib/.gitignore
> > > > > > > > @@ -6,3 +6,4 @@
> > > > > > > >  /oid_registry_data.c
> > > > > > > >  /test_fortify.log
> > > > > > > >  /test_fortify/*.log
> > > > > > > > +/default.bconf
> > > > > > > > diff --git a/lib/Makefile b/lib/Makefile
> > > > > > > > index 300f569c626b..8183785ee99d 100644
> > > > > > > > --- a/lib/Makefile
> > > > > > > > +++ b/lib/Makefile
> > > > > > > > @@ -279,6 +279,18 @@ $(foreach file, $(libfdt_files), \
> > > > > > > >  	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
> > > > > > > >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> > > > > > > >  
> > > > > > > > +ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> > > > > > > > +# Since the specified bootconfig file can be switched, we forcibly update the
> > > > > > > > +# default.bconf file always.
> > > > > > > > +$(obj)/default.bconf: FORCE
> > > > > > > > +	$(call cmd,defbconf)
> > > > > > > > +
> > > > > > > > +quiet_cmd_defbconf = GEN     $@
> > > > > > > > +      cmd_defbconf = cat < /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE) > $@
> > > > > > > > +clean-files	+= default.bconf
> > > > > > > > +$(obj)/bootconfig.o: $(obj)/default.bconf
> > > > > > > > +endif
> > > > > > > > +
> > > > > > > >  lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
> > > > > > > >  
> > > > > > > >  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> > > > > > > > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > > > > > > > index 74f3201ab8e5..3a3bf3a208e3 100644
> > > > > > > > --- a/lib/bootconfig.c
> > > > > > > > +++ b/lib/bootconfig.c
> > > > > > > > @@ -12,6 +12,29 @@
> > > > > > > >  #include <linux/kernel.h>
> > > > > > > >  #include <linux/memblock.h>
> > > > > > > >  #include <linux/string.h>
> > > > > > > > +
> > > > > > > > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > > > > > > > +asm (
> > > > > > > > +"	.pushsection .init.data, \"aw\"			\n"
> > > > > > > > +"	.global embedded_bootconfig_data		\n"
> > > > > > > > +"embedded_bootconfig_data:				\n"
> > > > > > > > +"	.incbin \"lib/default.bconf\"			\n"
> > > > > > > > +"	.global embedded_bootconfig_data_end		\n"
> > > > > > > > +"embedded_bootconfig_data_end:				\n"
> > > > > > > > +"	.popsection					\n"
> > > > > > > > +);
> > > > > > > > +
> > > > > > > > +extern __visible char embedded_bootconfig_data[];
> > > > > > > > +extern __visible char embedded_bootconfig_data_end[];
> > > > > > > > +
> > > > > > > > +char * __init xbc_get_embedded_bootconfig(size_t *size)
> > > > > > > > +{
> > > > > > > > +	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> > > > > > > > +	return (*size) ? embedded_bootconfig_data : NULL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  #else /* !__KERNEL__ */
> > > > > > > >  /*
> > > > > > > >   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> > > > > > > >
> > > > > > > 
> > > > > > > Thanks tested the implemation, it works as expected.
> > > > > > 
> > > > > > Great!
> > > > > > 
> > > > > > > 
> > > > > > > Also noted that a change in default.bconf requries a clean build, is it
> > > > > > > expected behaviour?
> > > > > > 
> > > > > > default.bconf will be always updated if CONFIG_EMBED_BOOT_CONFIG=y. So you can
> > > > > > do incremental build. (I tested it with the incremental build environment)
> > > > > >
> > > > > 
> > > > > Thanks, your observation made me to further experiment ther incremental build.
> > > > > 
> > > > > Below are the observations I have:
> > > > > 
> > > > > When I use GCC for a build; yes, the modified default.conf was observed on
> > > > > the target.
> > > > > 
> > > > > But when I use clang; either with FULL or THIN LTO, the modified
> > > > > default.conf doesnt get reflected on the target.
> > > > 
> > > > Hmm, curious. So you just add 'CC=clang' on the make command line, right?
> > > Yes, CC=clang ARCH=arm64 LLVM=1. As specified here:
> > > https://docs.kernel.org/kbuild/llvm.html.
> > > 
> > > > Can you confirm that following line in your build log,
> > > > 
> > > >   GEN     lib/default.bconf
> > > >
> > > Yes, I do see above line. Indeed lib/default.bconf will get incremental
> > > change.
> > > 
> > >   GEN     lib/default.bconf
> > >   CC      lib/bootconfig.o
> > >   AR      lib/lib.a
> > > 
> > > > and the timestamp of lib/bootconfig.o is built after lib/default.bconf file?
> > > > 
> > > Yes, verified timestamp for all above artifacts including vmlinux.o.
> > > 
> > > ex:
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 22K Mar 22 14:50
> > > ../out/lib/bootconfig.o
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 355 Mar 22 14:50
> > > ../out/lib/default.bconf
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 54M Mar 22 14:50 ../out/vmlinux.o
> > > 
> > > As said incremnetal change was refelected in artifact default.bconf.
> > > But not in vmlinux.o/vmlinux, used below command to verify.
> > 
> > Interesting! This sounds clang's issue, because the make command rebuilds
> > the object file including new default.bconf, but the linker (lld?)
> > doesn't link it again correctly.
> > 
> > > 
> > > llvm-objdump  -s -j .init.data ../out/vmlinux
> > > 
> > > On target too, /proc/bootconfig shows old data.
> > > 
> > > > And is that related to CONFIG_LTO? What happen if CONFIG_LTO=n?
> > > > 
> > > Yes;  CONFIG_LTO_NONE=y  issue not observed even with LLVM binutils.
> > 
> > And this issue is related to LTO. Maybe LTO ignores the '.init.data'
> > section update. (Perhaps, LTO only checks the function code hash or
> > something like that instead of the timestamp, and ignore whole object
> > file if all of them are not updated.)
> Thanks for the reasoning, seems to be. The same symptom observed with
> /proc/config.gz too.

Thanks for confirmation of config.gz. Yes, that is also using ".incbin"
directive in inline-asm. I think that is the key.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
