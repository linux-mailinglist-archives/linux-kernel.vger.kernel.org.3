Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101BD47B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbhLTQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbhLTQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:52:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61551C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=veUDKqMKuSB4HBrVKjW4+6BqbEJvZQtvyOx4w1AWZFU=; b=CBSoc/Eg1ilESSqjlwU840PIWy
        hEm938JPDsjsqVc6TKwdb17rrFW7xgr/app4xiHNcv33aOt77a6xsE2XLX9kXLJKxQJr7j3f6/kXi
        XDFP/kQIPL9E+u8iu6bLUFkbcRmjRYKWz0tL5LqP44mxEiYUv0BhW/9k0hZox7UA1LwILZ+O75wE5
        vEMS0xD6TSwb9F6k2o8dyzKYXmCqrw0Wt/ozP7sDxZZgmJCcKabOFgbjErRw6zDTm6c066ZJ13vc3
        MvB+KQkArExN7zxSVCD4hZsMyQIbMBu3fR7qYzdoTaF7ZwwydcYjuaTzvA6t5k/kNbxLxcHdUSG4A
        cr8hGSGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzLtm-003Onc-9s; Mon, 20 Dec 2021 16:52:30 +0000
Date:   Mon, 20 Dec 2021 08:52:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Martin Wilck <martin.wilck@suse.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
 <YbP6Q9J++OVKqPfn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbP6Q9J++OVKqPfn@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:09:23PM -0800, Dmitry Torokhov wrote:
> On Fri, Dec 10, 2021 at 04:11:21PM -0800, Luis Chamberlain wrote:
> > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index cd23faa163d1..d90774ff7610 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
> > >  
> > >  endchoice
> > >  
> > > +config MODULE_DECOMPRESS
> > > +	bool "Support in-kernel module decompression"
> > > +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> > > +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> > > +	select XZ_DEC if MODULE_COMPRESS_XZ
> > 
> > What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
> > These are not mutually exclusive.
> 
> They are mutually exclusive, the kernel uses the same (one) compression
> method for all kernel modules that it generates (i.e we do not compress
> drivers/usb/... with gzip while drivers/net/... with xz).

Ah yes I failed to see the choice/prompt for it.

> The idea here is to allow the kernel consume the same format that was
> used when generating modules. Supporting multiple formats at once is
> overkill IMO.

Indeed.

> > > +	help
> > > +
> > > +	  Support for decompressing kernel modules by the kernel itself
> > > +	  instead of relying on userspace to perform this task. Useful when
> > > +	  load pinning security policy is enabled.
> > 
> > Shouldn't kernel decompression be faster too? If so, what's the
> > point of doing it in userspace?
> 
> Make the kernel smaller?

Yes this I buy.

> Have more flexibility with exotic compression
> formats?

I just have a hunch that doing module decompression in the kernel will
speed things quite a bit... any chance you can provide some before and
after systemd-analyze ?

  Luis
