Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FF465669
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352849AbhLAT2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352723AbhLAT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C4C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:24:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so509975pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Qy0B/I9VMxoVA8/E+ZvO4RymVFXP/tOxtvlq632/LU=;
        b=iEjOLTh4MkN/yo3UpQc7/+JIdLqX74uhzS8IjUnmxBijQjNYZJYSY3MyxcadijNtJe
         SixtSC9+Jt0bXEN5OS+JN2+VExrakKP01aHz9RIiwxTU14XMBgNbVpY6zGJzFth4JDz2
         3yGFnGQhoXJiohbolqWK9qzRCJUoEFSoX7qnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Qy0B/I9VMxoVA8/E+ZvO4RymVFXP/tOxtvlq632/LU=;
        b=CBNS7Qoyfa/BGIUsVI1eI3uLdirHiys8zm5iKsdL9Wry1GuWTJjC/1hPISsnRW0qwi
         Q2UOE2wzytL13tVBJUkmXrO+2/6cMvNGmY3Yhao7xNh4oFjunXfvAvkuRD8CAng8tKc1
         6O7afwKlxZXnnyqleEFqManaWLFke8iIFAzwzIz9iFCGgTBpHaGDd9nKyF3tnABXoMyT
         CvU4owlqSkO5gFcuzbK2dW/H4IPlepnsPvdAZ94W8kl/0ETZAxBolcbbha1OGcAooSUA
         G5SFZI3JpDsDQ9YhIp2UfTgCzThjuHhE5/A8L2wwQ/hLbL988uyjwXSYhd+if67dOh1X
         Bs+g==
X-Gm-Message-State: AOAM533tiMEDkXZit8BnGxNxSCoSHrqMQ+E8/ztFEh/mJ9zKY/CwhqfX
        F1muaMu/ewq23qmhDk9DVX72ZA==
X-Google-Smtp-Source: ABdhPJwjNUfQa9zE5mvEopHiUn6DwKZ0A3G84q7L+9KKXfjVNHgz21YJ+w4OqsknJDtWIFOKVQQPGg==
X-Received: by 2002:a17:902:f092:b0:141:ccb6:897 with SMTP id p18-20020a170902f09200b00141ccb60897mr9802520pla.89.1638386676775;
        Wed, 01 Dec 2021 11:24:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm599415pfc.151.2021.12.01.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:24:36 -0800 (PST)
Date:   Wed, 1 Dec 2021 11:24:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <202112011112.83416FCA2C@keescook>
References: <YaMYJv539OEBz5B/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaMYJv539OEBz5B/@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 09:48:22PM -0800, Dmitry Torokhov wrote:
> Current scheme of having userspace decompress kernel modules before
> loading them into the kernel runs afoul of LoadPin security policy, as
> it loses link between the source of kernel module on the disk and binary
> blob that is being loaded into the kernel. To solve this issue let's
> implement decompression in kernel, so that we can pass a file descriptor
> of compressed module file into finit_module() which will keep LoadPin
> happy.

Yeah, adding module signing for this case seems like needless overhead
when there is an existing fd association back down to a dm-verity
device, etc.

> To let userspace know what compression/decompression scheme kernel
> supports it will create /sys/module/compression attribute. kmod can read
> this attribute and decide if it can pass compressed file to
> finit_module(). New MODULE_INIT_COMPRESSED_DATA flag indicates that the
> kernel should attempt to decompress the data read from file descriptor
> prior to trying load the module.

Cool; this seems reasonable.

> To simplify things kernel will only implement single decompression
> method matching compression method selected when generating modules.
> This patch implements gzip and xz; more can be added later,
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> I am also attaching a patch to kmod to make use of this new facility.
> 
> Thanks!
> 
>  include/uapi/linux/module.h |   1 +
>  init/Kconfig                |  12 ++
>  kernel/Makefile             |   1 +
>  kernel/module-internal.h    |  18 +++
>  kernel/module.c             |  35 +++--
>  kernel/module_decompress.c  | 271 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 327 insertions(+), 11 deletions(-)
> 
> diff --git a/include/uapi/linux/module.h b/include/uapi/linux/module.h
> index 50d98ec5e866..becab4a1c5db 100644
> --- a/include/uapi/linux/module.h
> +++ b/include/uapi/linux/module.h
> @@ -5,5 +5,6 @@
>  /* Flags for sys_finit_module: */
>  #define MODULE_INIT_IGNORE_MODVERSIONS	1
>  #define MODULE_INIT_IGNORE_VERMAGIC	2
> +#define MODULE_INIT_COMPRESSED_DATA	4

bikeshedding: adding "_DATA" seems redundant/misleading? The entire
module is compressed, so maybe call it just MODULE_INIT_COMPRESSED ?

>  
>  #endif /* _UAPI_LINUX_MODULE_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 03d3c21e28a3..a3f37ae7436d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2309,6 +2309,18 @@ config MODULE_COMPRESS_ZSTD
>  
>  endchoice
>  
> +config MODULE_DECOMPRESS
> +	bool "Support in-kernel module decompression"
> +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> +	select XZ_DEC if MODULE_COMPRESS_XZ
> +	help
> +
> +	  Support for decompressing kernel modules by the kernel itself
> +	  instead of relying on userspace to perform this task. Useful when
> +	  load pinning security policy is enabled.
> +
> +	  If unsure, say N.
> +
>  config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
>  	bool "Allow loading of modules with missing namespace imports"
>  	help
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 186c49582f45..56f4ee97f328 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -67,6 +67,7 @@ obj-y += up.o
>  endif
>  obj-$(CONFIG_UID16) += uid16.o
>  obj-$(CONFIG_MODULES) += module.o
> +obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
>  obj-$(CONFIG_MODULE_SIG) += module_signing.o
>  obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
>  obj-$(CONFIG_KALLSYMS) += kallsyms.o
> diff --git a/kernel/module-internal.h b/kernel/module-internal.h
> index 33783abc377b..3c1143d2c8c7 100644
> --- a/kernel/module-internal.h
> +++ b/kernel/module-internal.h
> @@ -22,6 +22,11 @@ struct load_info {
>  	bool sig_ok;
>  #ifdef CONFIG_KALLSYMS
>  	unsigned long mod_kallsyms_init_off;
> +#endif
> +#ifdef CONFIG_MODULE_DECOMPRESS
> +	struct page **pages;
> +	unsigned int max_pages;
> +	unsigned int used_pages;
>  #endif
>  	struct {
>  		unsigned int sym, str, mod, vers, info, pcpu;
> @@ -29,3 +34,16 @@ struct load_info {
>  };
>  
>  extern int mod_verify_sig(const void *mod, struct load_info *info);
> +
> +#ifdef CONFIG_MODULE_DECOMPRESS
> +int module_decompress(struct load_info *info, const void *buf, size_t size);
> +void module_decompress_cleanup(struct load_info *info);
> +#else
> +int module_decompress(struct load_info *info, const void *buf, size_t size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +void module_decompress_cleanup(struct load_info *info)
> +{
> +}
> +#endif
> diff --git a/kernel/module.c b/kernel/module.c
> index 84a9141a5e15..eeab85ea1627 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3174,9 +3174,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>  	return err;
>  }
>  
> -static void free_copy(struct load_info *info)
> +static void free_copy(struct load_info *info, int flags)

Since struct load_info is already being modified, how about adding flags
there instead, then it doesn't need to be plumbed down into each of
these functions?

>  {
> -	vfree(info->hdr);
> +	if (flags & MODULE_INIT_COMPRESSED_DATA)
> +		module_decompress_cleanup(info);
> +	else
> +		vfree(info->hdr);
>  }
>  
>  static int rewrite_section_headers(struct load_info *info, int flags)
> @@ -4125,7 +4128,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	}
>  
>  	/* Get rid of temporary copy. */
> -	free_copy(info);
> +	free_copy(info, flags);
>  
>  	/* Done! */
>  	trace_module_load(mod);
> @@ -4174,7 +4177,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	module_deallocate(mod, info);
>   free_copy:
> -	free_copy(info);
> +	free_copy(info, flags);
>  	return err;
>  }
>  
> @@ -4201,7 +4204,8 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
>  SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>  {
>  	struct load_info info = { };
> -	void *hdr = NULL;
> +	void *buf = NULL;
> +	int len;
>  	int err;
>  
>  	err = may_init_module();
> @@ -4211,15 +4215,24 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>  	pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);
>  
>  	if (flags & ~(MODULE_INIT_IGNORE_MODVERSIONS
> -		      |MODULE_INIT_IGNORE_VERMAGIC))
> +		      |MODULE_INIT_IGNORE_VERMAGIC
> +		      |MODULE_INIT_COMPRESSED_DATA))
>  		return -EINVAL;
>  
> -	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
> +	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
>  				       READING_MODULE);
> -	if (err < 0)
> -		return err;
> -	info.hdr = hdr;
> -	info.len = err;
> +	if (len < 0)
> +		return len;
> +
> +	if (flags & MODULE_INIT_COMPRESSED_DATA) {
> +		err = module_decompress(&info, buf, len);
> +		vfree(buf); /* compressed data is no longer needed */
> +		if (err)
> +			return err;
> +	} else {
> +		info.hdr = buf;
> +		info.len = len;
> +	}
>  
>  	return load_module(&info, uargs, flags);
>  }
> diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
> new file mode 100644
> index 000000000000..590ca00aa098
> --- /dev/null
> +++ b/kernel/module_decompress.c

I think most of this can be dropped. I think using
crypto_comp_decompress() would make much more sense.

-- 
Kees Cook
