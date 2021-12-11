Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36DE470F45
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbhLKAPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbhLKAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:14:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EDC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z950PYmZjozMauJWN95yjblekf6k1s+LeUA7vpTPbc0=; b=cdPbHzLTwvUCCPaOeax3hPYx1c
        +Ig+IovKOkTwfcaAfJMZ10de+GbZKM7O0Vpyi53tAGd/fB83cMhL5I/aHGkzk4fEGxb1A2SgyfUu6
        gEyA6q57aa1edzbjDb2f5iB+35LJjiatoUDbe/8WYgfcvX1GmC+z/Eb7LnoaqZqITlDqlyex8zcHj
        HU7TuJ27Ja5Us4cXDJDASqtuClY49CaFdSMbwAlwrcuR2z4VjRhtApwRTolyESBfTLUIUCtZRkvUz
        FIKxCP/8f5xc9en++OuhbiZWRUaGviHJYRrwQZbV588H0kqWNZcVGyaqRDffWw95mGmcf+WKTTSc+
        ZJ+qNegw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvpyz-004LBK-Mg; Sat, 11 Dec 2021 00:11:21 +0000
Date:   Fri, 10 Dec 2021 16:11:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbLvDWdyFivlj7pP@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index cd23faa163d1..d90774ff7610 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
>  
>  endchoice
>  
> +config MODULE_DECOMPRESS
> +	bool "Support in-kernel module decompression"
> +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> +	select XZ_DEC if MODULE_COMPRESS_XZ

What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
These are not mutually exclusive.

> +	help
> +
> +	  Support for decompressing kernel modules by the kernel itself
> +	  instead of relying on userspace to perform this task. Useful when
> +	  load pinning security policy is enabled.

Shouldn't kernel decompression be faster too? If so, what's the
point of doing it in userspace?

> diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
> new file mode 100644
> index 000000000000..590ca00aa098
> --- /dev/null
> +++ b/kernel/module_decompress.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2021 Google LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/highmem.h>
> +#include <linux/kobject.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/vmalloc.h>
> +
> +#include "module-internal.h"
> +
> +static int module_extend_max_pages(struct load_info *info, unsigned int extent)
> +{
> +	struct page **new_pages;
> +
> +	new_pages = kvmalloc_array(info->max_pages + extent,
> +				   sizeof(info->pages), GFP_KERNEL);
> +	if (!new_pages)
> +		return -ENOMEM;
> +
> +	memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
> +	kvfree(info->pages);
> +	info->pages = new_pages;
> +	info->max_pages += extent;
> +
> +	return 0;
> +}
> +
> +static struct page *module_get_next_page(struct load_info *info)
> +{
> +	struct page *page;
> +	int error;
> +
> +	if (info->max_pages == info->used_pages) {
> +		error = module_extend_max_pages(info, info->used_pages);
> +		if (error)
> +			return ERR_PTR(error);
> +	}
> +
> +	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
> +	if (!page)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->pages[info->used_pages++] = page;
> +	return page;
> +}
> +
> +#ifdef CONFIG_MODULE_COMPRESS_GZIP
> +#include <linux/zlib.h>
> +#define MODULE_COMPRESSION	gzip
> +#define MODULE_DECOMPRESS_FN	module_gzip_decompress

So gzip is assumed if your kernel has both gzip and xz. That seems odd.

<-- snip -->

> +#elif CONFIG_MODULE_COMPRESS_XZ
> +#include <linux/xz.h>
> +#define MODULE_COMPRESSION	xz
> +#define MODULE_DECOMPRESS_FN	module_xz_decompress
> +#else

<-- snip -->

> +#error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"

Using "depends on" logic on the kconfig symbol would resolve this and
make this not needed.

Why can't we just inspect the module and determine? Or, why not just add
a new kconfig symbol under MODULE_DECOMPRESS which lets you specify the
MODULE_COMPRESSION_TYPE. This way this is explicit.

> +module_init(module_decompress_sysfs_init);

This seems odd, altough it works, can you use late_initcall instead()?

  Luis
