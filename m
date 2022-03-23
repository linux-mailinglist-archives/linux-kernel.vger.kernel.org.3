Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4C4E55C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbiCWP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245303AbiCWP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:57:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969747A9A2;
        Wed, 23 Mar 2022 08:56:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b15so2386556edn.4;
        Wed, 23 Mar 2022 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0aWaZxBTzYpNIUBH9wQAOnNCPts4qWbCBV5YqOTvja0=;
        b=IgaE3lrjA8Bffchqyozx0JLt1zJzBjaTu/e56bzPTfGHd0j+mJvesHSRXjmgSQhn2b
         7vsb0mx+Z47knytiHqGNld/811DI7bColRAyM+kDxX6tlx7mgyjRQZMFMab/zWuRK7cp
         vMDRmjhNS99ceIa1whpT/ripktHeL39u9ZnUGyAc/GGM9VuoRjEgKRq8TECUp4xhtcwK
         9t9apvw51xk98n5LzfZQbUH7qN73UxivlNNt3B/ixYXgHPkPII9Vd6aTmyNl5ZilHaT/
         C2wL7iYq1cDqkTbfmh8Y3euFsElCpCJdzBcvwVjBLUu0mfOmPIvcIkFjOTK/b/Lt47R6
         Cwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0aWaZxBTzYpNIUBH9wQAOnNCPts4qWbCBV5YqOTvja0=;
        b=AsMTlbpHjhExcYONO5M1yyT+ANWC3/ClVnYBpFobYfwojKR4NIyU5SnUuwhoMW/zby
         euiPHG3vbQfzZKkOt59en/Vb3rFxFCsF92DIfpB8OH2a/8Ft8bmSq1OASA316TDmp8sG
         Q97CypO3daE+A7RtkDJOWDiJhYMoZT36gVj7kHTSyUKEHvHiON0s6+YMrOAQvRSiyiuf
         VLEZiuJEK4cDHGSs+hVXpYyaOBsxLiSktfOgmeUrj8nooa+JIR/VOO82Ro7P+lcYLhA+
         rAWCJLN/ovXcBzaXSHGtTKAMSLMY3Mg2wQFpDw3XCja4fMCtswB6ixWfqqoTtn30VFf1
         6mzA==
X-Gm-Message-State: AOAM5317pPYZtKdL7VbvtHlVl1bH/zuLZPXbdY+bM2tiFT0jZjOIoX++
        VnExspZzJVC28ihGPe1nv/8=
X-Google-Smtp-Source: ABdhPJwTd6qV2FZLwCrjso3bxDjo+1Gas5YUbwNfO5ahMgWzVnPxRjagrsB/ofAuJqYy70/vLMIWXA==
X-Received: by 2002:aa7:d6ca:0:b0:419:2804:d094 with SMTP id x10-20020aa7d6ca000000b004192804d094mr939569edr.388.1648050979869;
        Wed, 23 Mar 2022 08:56:19 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm147440edd.48.2022.03.23.08.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:56:19 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:56:18 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-ID: <20220323155618.GA11364@pswork>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
 <164724892075.731226.14103557516176115189.stgit@devnote2>
 <20220316191649.GA11547@pswork>
 <20220318101445.fdb151efe58c6c3a1c572500@kernel.org>
 <20220321183500.GA4065@pswork>
 <20220322120311.690f237b63ddfd9c0e4f78ec@kernel.org>
 <20220322190219.GA26859@pswork>
 <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:16:17AM +0900, Masami Hiramatsu wrote:
> On Tue, 22 Mar 2022 20:02:19 +0100
> Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> 
> > Hello Masami Hiramatsu,
> > 
> > On Tue, Mar 22, 2022 at 12:03:11PM +0900, Masami Hiramatsu wrote:
> > > On Mon, 21 Mar 2022 19:35:00 +0100
> > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > 
> > > > Hello Masami Hiramatsu,
> > > > 
> > > > On Fri, Mar 18, 2022 at 10:14:45AM +0900, Masami Hiramatsu wrote:
> > > > > On Wed, 16 Mar 2022 20:16:49 +0100
> > > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > > 
> > > > > > Hello Masami Hiramatsu,
> > > > > > 
> > > > > > On Mon, Mar 14, 2022 at 06:08:41PM +0900, Masami Hiramatsu wrote:
> > > > > > > This allows kernel developer to embed a default bootconfig file in
> > > > > > > the kernel instead of embedding it in the initrd. This will be good
> > > > > > > for who are using the kernel without initrd, or who needs a default
> > > > > > > bootconfigs.
> > > > > > > This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
> > > > > > > the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.
> > > > > > > 
> > > > > > > Note that you still need 'bootconfig' command line option to load the
> > > > > > > embedded bootconfig. Also if you boot using an initrd with a different
> > > > > > > bootconfig, the kernel will use the bootconfig in the initrd, instead
> > > > > > > of the default bootconfig.
> > > > > > > 
> > > > > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > ---
> > > > > > >  include/linux/bootconfig.h |   10 ++++++++++
> > > > > > >  init/Kconfig               |   21 +++++++++++++++++++++
> > > > > > >  init/main.c                |   13 ++++++++-----
> > > > > > >  lib/.gitignore             |    1 +
> > > > > > >  lib/Makefile               |   12 ++++++++++++
> > > > > > >  lib/bootconfig.c           |   23 +++++++++++++++++++++++
> > > > > > >  6 files changed, 75 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > > > > > > index a4665c7ab07c..5dbda5e3e9bb 100644
> > > > > > > --- a/include/linux/bootconfig.h
> > > > > > > +++ b/include/linux/bootconfig.h
> > > > > > > @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
> > > > > > >  /* XBC cleanup data structures */
> > > > > > >  void __init xbc_exit(void);
> > > > > > >  
> > > > > > > +/* XBC embedded bootconfig data in kernel */
> > > > > > > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > > > > > > +char * __init xbc_get_embedded_bootconfig(size_t *size);
> > > > > > > +#else
> > > > > > > +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> > > > > > > +{
> > > > > > > +	return NULL;
> > > > > > > +}
> > > > > > > +#endif
> > > > > > > +
> > > > > > >  #endif
> > > > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > > > index e9119bf54b1f..70440804874d 100644
> > > > > > > --- a/init/Kconfig
> > > > > > > +++ b/init/Kconfig
> > > > > > > @@ -1357,6 +1357,27 @@ config BOOT_CONFIG
> > > > > > >  
> > > > > > >  	  If unsure, say Y.
> > > > > > >  
> > > > > > > +config EMBED_BOOT_CONFIG
> > > > > > > +	bool "Embed bootconfig file in the kernel"
> > > > > > > +	depends on BOOT_CONFIG
> > > > > > > +	default n
> > > > > > > +	help
> > > > > > > +	  Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> > > > > > > +	  kernel. Usually, the bootconfig file is loaded with the initrd
> > > > > > > +	  image. But if the system doesn't support initrd, this option will
> > > > > > > +	  help you by embedding a bootconfig file while building the kernel.
> > > > > > > +
> > > > > > > +	  If unsure, say N.
> > > > > > > +
> > > > > > > +config EMBED_BOOT_CONFIG_FILE
> > > > > > > +	string "Embedded bootconfig file path"
> > > > > > > +	default ""
> > > > > > > +	depends on EMBED_BOOT_CONFIG
> > > > > > > +	help
> > > > > > > +	  Specify a bootconfig file which will be embedded to the kernel.
> > > > > > > +	  This bootconfig will be used if there is no initrd or no other
> > > > > > > +	  bootconfig in the initrd.
> > > > > > > +
> > > > > > >  choice
> > > > > > >  	prompt "Compiler optimization level"
> > > > > > >  	default CC_OPTIMIZE_FOR_PERFORMANCE
> > > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > > index 421050be5039..3803bf2e22ea 100644
> > > > > > > --- a/init/main.c
> > > > > > > +++ b/init/main.c
> > > > > > > @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
> > > > > > >  early_param("loglevel", loglevel);
> > > > > > >  
> > > > > > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > > > > > -static void * __init get_boot_config_from_initrd(u32 *_size)
> > > > > > > +static void * __init get_boot_config_from_initrd(size_t *_size)
> > > > > > >  {
> > > > > > >  	u32 size, csum;
> > > > > > >  	char *data;
> > > > > > > @@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
> > > > > > >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > > > > > >  	const char *msg;
> > > > > > >  	int pos;
> > > > > > > -	u32 size;
> > > > > > > +	size_t size;
> > > > > > >  	char *data, *err;
> > > > > > >  	int ret;
> > > > > > >  
> > > > > > >  	/* Cut out the bootconfig data even if we have no bootconfig option */
> > > > > > >  	data = get_boot_config_from_initrd(&size);
> > > > > > > +	/* If there is no bootconfig in initrd, try embedded one. */
> > > > > > > +	if (!data)
> > > > > > > +		data = xbc_get_embedded_bootconfig(&size);
> > > > > > >  
> > > > > > >  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > > > > >  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > > > > > > @@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
> > > > > > >  	}
> > > > > > >  
> > > > > > >  	if (size >= XBC_DATA_MAX) {
> > > > > > > -		pr_err("bootconfig size %d greater than max size %d\n",
> > > > > > > -			size, XBC_DATA_MAX);
> > > > > > > +		pr_err("bootconfig size %ld greater than max size %d\n",
> > > > > > > +			(long)size, XBC_DATA_MAX);
> > > > > > >  		return;
> > > > > > >  	}
> > > > > > >  
> > > > > > > @@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
> > > > > > >  				msg, pos);
> > > > > > >  	} else {
> > > > > > >  		xbc_get_info(&ret, NULL);
> > > > > > > -		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> > > > > > > +		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> > > > > > >  		/* keys starting with "kernel." are passed via cmdline */
> > > > > > >  		extra_command_line = xbc_make_cmdline("kernel");
> > > > > > >  		/* Also, "init." keys are init arguments */
> > > > > > > diff --git a/lib/.gitignore b/lib/.gitignore
> > > > > > > index e5e217b8307b..30a2a5db7033 100644
> > > > > > > --- a/lib/.gitignore
> > > > > > > +++ b/lib/.gitignore
> > > > > > > @@ -6,3 +6,4 @@
> > > > > > >  /oid_registry_data.c
> > > > > > >  /test_fortify.log
> > > > > > >  /test_fortify/*.log
> > > > > > > +/default.bconf
> > > > > > > diff --git a/lib/Makefile b/lib/Makefile
> > > > > > > index 300f569c626b..8183785ee99d 100644
> > > > > > > --- a/lib/Makefile
> > > > > > > +++ b/lib/Makefile
> > > > > > > @@ -279,6 +279,18 @@ $(foreach file, $(libfdt_files), \
> > > > > > >  	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
> > > > > > >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> > > > > > >  
> > > > > > > +ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
> > > > > > > +# Since the specified bootconfig file can be switched, we forcibly update the
> > > > > > > +# default.bconf file always.
> > > > > > > +$(obj)/default.bconf: FORCE
> > > > > > > +	$(call cmd,defbconf)
> > > > > > > +
> > > > > > > +quiet_cmd_defbconf = GEN     $@
> > > > > > > +      cmd_defbconf = cat < /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE) > $@
> > > > > > > +clean-files	+= default.bconf
> > > > > > > +$(obj)/bootconfig.o: $(obj)/default.bconf
> > > > > > > +endif
> > > > > > > +
> > > > > > >  lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
> > > > > > >  
> > > > > > >  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> > > > > > > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > > > > > > index 74f3201ab8e5..3a3bf3a208e3 100644
> > > > > > > --- a/lib/bootconfig.c
> > > > > > > +++ b/lib/bootconfig.c
> > > > > > > @@ -12,6 +12,29 @@
> > > > > > >  #include <linux/kernel.h>
> > > > > > >  #include <linux/memblock.h>
> > > > > > >  #include <linux/string.h>
> > > > > > > +
> > > > > > > +#ifdef CONFIG_EMBED_BOOT_CONFIG
> > > > > > > +asm (
> > > > > > > +"	.pushsection .init.data, \"aw\"			\n"
> > > > > > > +"	.global embedded_bootconfig_data		\n"
> > > > > > > +"embedded_bootconfig_data:				\n"
> > > > > > > +"	.incbin \"lib/default.bconf\"			\n"
> > > > > > > +"	.global embedded_bootconfig_data_end		\n"
> > > > > > > +"embedded_bootconfig_data_end:				\n"
> > > > > > > +"	.popsection					\n"
> > > > > > > +);
> > > > > > > +
> > > > > > > +extern __visible char embedded_bootconfig_data[];
> > > > > > > +extern __visible char embedded_bootconfig_data_end[];
> > > > > > > +
> > > > > > > +char * __init xbc_get_embedded_bootconfig(size_t *size)
> > > > > > > +{
> > > > > > > +	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> > > > > > > +	return (*size) ? embedded_bootconfig_data : NULL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +#endif
> > > > > > > +
> > > > > > >  #else /* !__KERNEL__ */
> > > > > > >  /*
> > > > > > >   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> > > > > > >
> > > > > > 
> > > > > > Thanks tested the implemation, it works as expected.
> > > > > 
> > > > > Great!
> > > > > 
> > > > > > 
> > > > > > Also noted that a change in default.bconf requries a clean build, is it
> > > > > > expected behaviour?
> > > > > 
> > > > > default.bconf will be always updated if CONFIG_EMBED_BOOT_CONFIG=y. So you can
> > > > > do incremental build. (I tested it with the incremental build environment)
> > > > >
> > > > 
> > > > Thanks, your observation made me to further experiment ther incremental build.
> > > > 
> > > > Below are the observations I have:
> > > > 
> > > > When I use GCC for a build; yes, the modified default.conf was observed on
> > > > the target.
> > > > 
> > > > But when I use clang; either with FULL or THIN LTO, the modified
> > > > default.conf doesnt get reflected on the target.
> > > 
> > > Hmm, curious. So you just add 'CC=clang' on the make command line, right?
> > Yes, CC=clang ARCH=arm64 LLVM=1. As specified here:
> > https://docs.kernel.org/kbuild/llvm.html.
> > 
> > > Can you confirm that following line in your build log,
> > > 
> > >   GEN     lib/default.bconf
> > >
> > Yes, I do see above line. Indeed lib/default.bconf will get incremental
> > change.
> > 
> >   GEN     lib/default.bconf
> >   CC      lib/bootconfig.o
> >   AR      lib/lib.a
> > 
> > > and the timestamp of lib/bootconfig.o is built after lib/default.bconf file?
> > > 
> > Yes, verified timestamp for all above artifacts including vmlinux.o.
> > 
> > ex:
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 22K Mar 22 14:50
> > ../out/lib/bootconfig.o
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 355 Mar 22 14:50
> > ../out/lib/default.bconf
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 54M Mar 22 14:50 ../out/vmlinux.o
> > 
> > As said incremnetal change was refelected in artifact default.bconf.
> > But not in vmlinux.o/vmlinux, used below command to verify.
> 
> Interesting! This sounds clang's issue, because the make command rebuilds
> the object file including new default.bconf, but the linker (lld?)
> doesn't link it again correctly.
> 
> > 
> > llvm-objdump  -s -j .init.data ../out/vmlinux
> > 
> > On target too, /proc/bootconfig shows old data.
> > 
> > > And is that related to CONFIG_LTO? What happen if CONFIG_LTO=n?
> > > 
> > Yes;  CONFIG_LTO_NONE=y  issue not observed even with LLVM binutils.
> 
> And this issue is related to LTO. Maybe LTO ignores the '.init.data'
> section update. (Perhaps, LTO only checks the function code hash or
> something like that instead of the timestamp, and ignore whole object
> file if all of them are not updated.)
Thanks for the reasoning, seems to be. The same symptom observed with
/proc/config.gz too.

Thank you,
Padmanabha.S
> 
> I've added clang build maintainers. I need their help to solve this issue.
> 
> Thank you,
> 
> > 
> > Thanks and Regards,
> > Padmanabha.S
> > > Thank you,
> > > 
> > > > 
> > > > PS: Using: GCC version 8.2.1 20180802, LLVM version 13.0.2git.
> > > > 
> > > > Thank you,
> > > > Padmanabha.S
> > > > > Thank you,
> > > > > 
> > > > > > 
> > > > > > Thanks and Regards,
> > > > > > Padmanabha.S
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
