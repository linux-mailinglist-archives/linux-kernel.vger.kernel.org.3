Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9A47B8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhLUDS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLUDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:18:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5756C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:18:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso1867786pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zF5H6DehIVszQYzP+mlIB78fkVLV3DqTkKtHK6/WvHw=;
        b=JD2JMFwV4bXZjIynI84KgxQ1nwJuVEtfMvakfjcGsc9eRAim15bJI4Ffj8kwQzJUkT
         Z8tSX4k7jT3ZpHyOXIa8nhf4U3qPh+3f3Uz4y12c41crCnsnNWh60kFPn3EBV4dLyOLD
         QQEEvbJ7N2XOmLKaEOAUHxmHJCtXKq4iXHSDP0+X1U7sNNPdnAtgt9EHcN3/dpTKR5FW
         1ENTgf2sr8r8e0x303OCy2WT+zURjDcvrvrKgGgYLc+Koj91Rh0eky4EYDQDCuml40Y9
         vYc1vfYTUmWwWvafniJHK1YZ+or4Cm9xoSXo6UwNzq5Dh6PQbzecK7EWgkpUXXaZNN8x
         D/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zF5H6DehIVszQYzP+mlIB78fkVLV3DqTkKtHK6/WvHw=;
        b=3moPNRCBsSWlJzwSPEcRihBLy+C2oFVdCNtdKZIyXrwjrJAxIMvQofIE+oSfRvSiED
         z1OPlny+iJwy9gyPkrmuHuc5AoOmTsGuvP9xrEAKwhBP9z90/vakly0ilZRD8UCVmBgr
         pEWolFX2L/EgkJm+TP3kNVSEhuJSyBwHWNNjB0w9lgbn6fKODu3GCjQ9kh1GlDoevcv2
         VG4bjTJEaUxILHqwoFiHGhlTnX0LXDMN3VT+1UCu7V1+j0dBLyBJip8CFDWIwzMifOLI
         +lEihcDE+VpPVYU4U5vlMOLgKzgnsvdG+nhIfDvQyl10dxG/47n+u7wP8Xa8mZM3mL+B
         758g==
X-Gm-Message-State: AOAM530uuwQauq/Rrz9NFOq0ZBwhpZwC5SGI3YnnRNURuBC6LWiCmran
        TmSkdvl679GwGuDnE75dsgdAOiTPUFE=
X-Google-Smtp-Source: ABdhPJxBY34JSnamrDlppZAi/FaEqCknbEf3GEQf58f4P1MPKK0wOaR0FjDePYJHsKWBGtTULv1B5w==
X-Received: by 2002:a17:902:e5ce:b0:142:780:78db with SMTP id u14-20020a170902e5ce00b00142078078dbmr1053664plf.12.1640056705062;
        Mon, 20 Dec 2021 19:18:25 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id w15sm726357pjq.24.2021.12.20.19.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 19:18:23 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:17:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Martin Wilck <martin.wilck@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YcFHZVHbIG3ujDlC@google.com>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
 <YbP6Q9J++OVKqPfn@google.com>
 <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 08:52:30AM -0800, Luis Chamberlain wrote:
> On Fri, Dec 10, 2021 at 05:09:23PM -0800, Dmitry Torokhov wrote:
> > On Fri, Dec 10, 2021 at 04:11:21PM -0800, Luis Chamberlain wrote:
> > > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index cd23faa163d1..d90774ff7610 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
> > > >  
> > > >  endchoice
> > > >  
> > > > +config MODULE_DECOMPRESS
> > > > +	bool "Support in-kernel module decompression"
> > > > +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> > > > +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> > > > +	select XZ_DEC if MODULE_COMPRESS_XZ
> > > 
> > > What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
> > > These are not mutually exclusive.
> > 
> > They are mutually exclusive, the kernel uses the same (one) compression
> > method for all kernel modules that it generates (i.e we do not compress
> > drivers/usb/... with gzip while drivers/net/... with xz).
> 
> Ah yes I failed to see the choice/prompt for it.
> 
> > The idea here is to allow the kernel consume the same format that was
> > used when generating modules. Supporting multiple formats at once is
> > overkill IMO.
> 
> Indeed.
> 
> > > > +	help
> > > > +
> > > > +	  Support for decompressing kernel modules by the kernel itself
> > > > +	  instead of relying on userspace to perform this task. Useful when
> > > > +	  load pinning security policy is enabled.
> > > 
> > > Shouldn't kernel decompression be faster too? If so, what's the
> > > point of doing it in userspace?
> > 
> > Make the kernel smaller?
> 
> Yes this I buy.
> 
> > Have more flexibility with exotic compression
> > formats?
> 
> I just have a hunch that doing module decompression in the kernel will
> speed things quite a bit... any chance you can provide some before and
> after systemd-analyze ?

If you insist I can try running it, but it should be slower unless your
memory controller is so slow that reading file from disk and dealing
with page by page decompression is quicker than copying already
decompressed data from userspace. We still reading and uncompressing
file in kmod (to make sure the format is valid) and we can uncompress
using large buffers (we are not concerned with using unswappable kernel
memory).

Maybe in the future when we have streaming and accelerated in-kernel
decompression API we could optimize for that in kmod and see some
savings on very large modules.

Thanks.

-- 
Dmitry
