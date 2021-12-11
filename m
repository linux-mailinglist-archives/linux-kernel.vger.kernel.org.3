Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D310470FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbhLKBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbhLKBND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:13:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69CBC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:09:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id m15so9423986pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wl0Q8FNH1P1Inc1QDlQKNhv1kqeOIcoAVwIbFAygvrc=;
        b=ploqPEhv3yaWkzeSdAWKn+/DeS7TvE8Aj0+cZJbjmEvmUi03KpMf/rz7LucS78MZRF
         nhanonQlX17S/PrH2oYMMxQX+I0dSRI8ZKpkVmJHBVFpvJbmnHuhUp+HDBZDECCL8e8y
         VGwQTB4kc+ZAxB1rRBxQ+Z+d7niFxsqQhYz5v/uplQeyHx+iKzGxYnOJAD+auLS8gFDv
         woiXFJWzsSqFXf9tCAbIv5DA0lHzIj6IcQYBEX1wKLjPpRxqOtuoFQ/4+kjbfh1+MUuy
         R7so3DbZoWE9KttqD41ZvnrtTdAS4lbZVrb5ZnqTlbl4KtHQpmz5gn07a/KR56zWEhgG
         tXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wl0Q8FNH1P1Inc1QDlQKNhv1kqeOIcoAVwIbFAygvrc=;
        b=ZuYkQeKaM1kW6Cq1YoQKQ1VM/IgRx3fdPQYiomLhslW+ka9MnD4SPhDit6LbZKIlIX
         adc1X0BH5+4YVCATpeZFMi3GgcfDZ1QTEKc8h7RZ0eCX3kylylrO6nxyri9HkdUAZFPk
         zNqwsYEHFA68BYXl3So6Vzkg8qrOWTnsqFZRQOecrek7KQkDXJB5KneYkXOH1OVGWEpJ
         0jaFZqEADjouAk5mwaojUknK/b9WYYVGxPmtAIUyUKn30FplFn7RV2OANh3KSfs6W2pI
         q/KyGIkUi5ez+yrm0DOa+IzQJg3r4VYfnAM6C5wHgq4mdqF6MgpskOR9abbKLZshq23U
         YdTQ==
X-Gm-Message-State: AOAM532BGZwDySCbgoXE3A3rkmVlDQlTREhdQQp1ya3G6l4mLm/HCXGm
        rrWt2+qR0eotO1cqrro7y0A=
X-Google-Smtp-Source: ABdhPJzlMHxKQUTpctb0ReYiAE+W/sfhEI2FgJwY+8Ah0s/RFQMbign6xyRPN3QnMx2VSkGbbVOizg==
X-Received: by 2002:a05:6a00:1681:b0:4a8:2462:ba0a with SMTP id k1-20020a056a00168100b004a82462ba0amr21086375pfc.75.1639184967066;
        Fri, 10 Dec 2021 17:09:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:749:db5e:6dc8:be24])
        by smtp.gmail.com with ESMTPSA id c11sm176778pji.42.2021.12.10.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 17:09:25 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:09:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbP6Q9J++OVKqPfn@google.com>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 04:11:21PM -0800, Luis Chamberlain wrote:
> On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index cd23faa163d1..d90774ff7610 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
> >  
> >  endchoice
> >  
> > +config MODULE_DECOMPRESS
> > +	bool "Support in-kernel module decompression"
> > +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> > +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> > +	select XZ_DEC if MODULE_COMPRESS_XZ
> 
> What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
> These are not mutually exclusive.

They are mutually exclusive, the kernel uses the same (one) compression
method for all kernel modules that it generates (i.e we do not compress
drivers/usb/... with gzip while drivers/net/... with xz).

The idea here is to allow the kernel consume the same format that was
used when generating modules. Supporting multiple formats at once is
overkill IMO.

> 
> > +	help
> > +
> > +	  Support for decompressing kernel modules by the kernel itself
> > +	  instead of relying on userspace to perform this task. Useful when
> > +	  load pinning security policy is enabled.
> 
> Shouldn't kernel decompression be faster too? If so, what's the
> point of doing it in userspace?

Make the kernel smaller? Have more flexibility with exotic compression
formats?

> 
> > diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
> > new file mode 100644
> > index 000000000000..590ca00aa098
> > --- /dev/null
> > +++ b/kernel/module_decompress.c
> > @@ -0,0 +1,271 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright 2021 Google LLC.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/highmem.h>
> > +#include <linux/kobject.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/vmalloc.h>
> > +
> > +#include "module-internal.h"
> > +
> > +static int module_extend_max_pages(struct load_info *info, unsigned int extent)
> > +{
> > +	struct page **new_pages;
> > +
> > +	new_pages = kvmalloc_array(info->max_pages + extent,
> > +				   sizeof(info->pages), GFP_KERNEL);
> > +	if (!new_pages)
> > +		return -ENOMEM;
> > +
> > +	memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
> > +	kvfree(info->pages);
> > +	info->pages = new_pages;
> > +	info->max_pages += extent;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct page *module_get_next_page(struct load_info *info)
> > +{
> > +	struct page *page;
> > +	int error;
> > +
> > +	if (info->max_pages == info->used_pages) {
> > +		error = module_extend_max_pages(info, info->used_pages);
> > +		if (error)
> > +			return ERR_PTR(error);
> > +	}
> > +
> > +	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
> > +	if (!page)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	info->pages[info->used_pages++] = page;
> > +	return page;
> > +}
> > +
> > +#ifdef CONFIG_MODULE_COMPRESS_GZIP
> > +#include <linux/zlib.h>
> > +#define MODULE_COMPRESSION	gzip
> > +#define MODULE_DECOMPRESS_FN	module_gzip_decompress
> 
> So gzip is assumed if your kernel has both gzip and xz. That seems odd.

No, gzuo is used when CONFIG_MODULE_COMPRESS_GZIP is enabled. That means
that CONFIG_MODULE_COMPRESS_XZ is not enabled.

> 
> <-- snip -->
> 
> > +#elif CONFIG_MODULE_COMPRESS_XZ
> > +#include <linux/xz.h>
> > +#define MODULE_COMPRESSION	xz
> > +#define MODULE_DECOMPRESS_FN	module_xz_decompress
> > +#else
> 
> <-- snip -->
> 
> > +#error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
> 
> Using "depends on" logic on the kconfig symbol would resolve this and
> make this not needed.
> 
> Why can't we just inspect the module and determine? Or, why not just add
> a new kconfig symbol under MODULE_DECOMPRESS which lets you specify the
> MODULE_COMPRESSION_TYPE. This way this is explicit.

It is a possibility, I just wanted to decompression scheme match
compression one so there is less potential for misconfiguration.

> 
> > +module_init(module_decompress_sysfs_init);
> 
> This seems odd, altough it works, can you use late_initcall instead()?

Yes, I can change this.

Thanks.

-- 
Dmitry
