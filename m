Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711F47C902
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhLUV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhLUV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:59:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B31C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+4Ws11cCOShfPLDoD9VDY42VAMzL3C2Yd9cv+H3CTvo=; b=c2GXpZ9+pMx00kEGucUejipl28
        RsmZT27Bjws9/9VMykSBbHqCDDdNo8iz0LixmxdV5xjAcLT/OZGzB0b20uG1APQvYrWvJhkQhzB9q
        IZW1vh5lewTC7QpWFXHcDm+mHD7rqICVuwFngkyJJtoPkunzkwRjkDDBY3EBhIpfMvMd5po1+UPAg
        pKqxuSp3gBbPK3SJPat75JS+X/ncKQ70AsIIfzkcvBkFVi6Q6qYqbeCswalPhX3yrasxn++2Kn+KV
        tHnIxL0zqugrGnYPsf5crSC85JgwkGxMWEpSV4E5YCKGiW+W3SkuIETO+GxY9Mjo1SZrqK+OhjJH5
        1JkOgZaQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mznAg-008aE8-Io; Tue, 21 Dec 2021 21:59:46 +0000
Date:   Tue, 21 Dec 2021 13:59:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Martin Wilck <martin.wilck@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YcJOUvQJJGSHmlCE@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
 <YbP6Q9J++OVKqPfn@google.com>
 <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
 <YcFHZVHbIG3ujDlC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcFHZVHbIG3ujDlC@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 07:17:57PM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 20, 2021 at 08:52:30AM -0800, Luis Chamberlain wrote:
> > On Fri, Dec 10, 2021 at 05:09:23PM -0800, Dmitry Torokhov wrote:
> > > On Fri, Dec 10, 2021 at 04:11:21PM -0800, Luis Chamberlain wrote:
> > > > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > index cd23faa163d1..d90774ff7610 100644
> > > > > --- a/init/Kconfig
> > > > > +++ b/init/Kconfig
> > > > > @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
> > > > >  
> > > > >  endchoice
> > > > >  
> > > > > +config MODULE_DECOMPRESS
> > > > > +	bool "Support in-kernel module decompression"
> > > > > +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> > > > > +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> > > > > +	select XZ_DEC if MODULE_COMPRESS_XZ
> > > > 
> > > > What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
> > > > These are not mutually exclusive.
> > > 
> > > They are mutually exclusive, the kernel uses the same (one) compression
> > > method for all kernel modules that it generates (i.e we do not compress
> > > drivers/usb/... with gzip while drivers/net/... with xz).
> > 
> > Ah yes I failed to see the choice/prompt for it.
> > 
> > > The idea here is to allow the kernel consume the same format that was
> > > used when generating modules. Supporting multiple formats at once is
> > > overkill IMO.
> > 
> > Indeed.
> > 
> > > > > +	help
> > > > > +
> > > > > +	  Support for decompressing kernel modules by the kernel itself
> > > > > +	  instead of relying on userspace to perform this task. Useful when
> > > > > +	  load pinning security policy is enabled.
> > > > 
> > > > Shouldn't kernel decompression be faster too? If so, what's the
> > > > point of doing it in userspace?
> > > 
> > > Make the kernel smaller?
> > 
> > Yes this I buy.
> > 
> > > Have more flexibility with exotic compression
> > > formats?
> > 
> > I just have a hunch that doing module decompression in the kernel will
> > speed things quite a bit... any chance you can provide some before and
> > after systemd-analyze ?
> 
> If you insist I can try running it, 

If you can run the test, yes it would be appreciated.

> but it should be slower unless your
> memory controller is so slow that reading file from disk and dealing
> with page by page decompression is quicker than copying already
> decompressed data from userspace. 

With userspace decompression I'd imagine we also have more context switches.

> We still reading and uncompressing
> file in kmod (to make sure the format is valid)

I don't understand, that seems wasteful.

> and we can uncompress
> using large buffers (we are not concerned with using unswappable kernel
> memory).
> 
> Maybe in the future when we have streaming and accelerated in-kernel
> decompression API we could optimize for that in kmod and see some
> savings on very large modules.

That would be very nice.

  Luis
