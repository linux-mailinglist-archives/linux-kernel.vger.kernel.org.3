Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FA482D97
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 04:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiACC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 21:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiACC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 21:58:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C99C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 18:58:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 196so28301117pfw.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 18:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVgsBWp5ZjtwwmJt5kRoylS+HiSFvZfG39ptL/0/1ns=;
        b=oiLEZJ0mV70bDxYjVGgUPl5CGniBtHPJd3skQpvy/JGh79+RWrTJqNobY2RJsTW90L
         CSOpVY8j6DWE/KNjksWDefqnGNG8bxoKvok/OKwJSS3DsrhTqX+QtDywdxF3/MjqCTYg
         InOYg+M30Agi6GU2+GnRo2ZLZWoGbmvt9PPo+sodBIeS7ybo2GKqCjyZ0I2IyHrcCAQ3
         WlNTS/S5FGQm0Rge6EH9MYaJOX+gdMlDeIPEM/XvjGScYA5XABEdSKhBDhni8jiFCokh
         kQvHLt6S63gaGHCM/wyYvImu+HfVr/IzWIPc0Um7wDbwQVSuPflwvqgZTBOdvf/fkUzS
         AOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVgsBWp5ZjtwwmJt5kRoylS+HiSFvZfG39ptL/0/1ns=;
        b=ecIwXKaEMtpqvAKDiDf1wi9fUSHqRB+T8IWphnkr9jjZkhmHyDxbhN75ugFOhgKn4N
         raoyZTgnMmFqgf82IWArROpAfs1URYcOyOaQXEFXKcSo1zr0zMSRaiUcuEB4GrsWugqV
         dqqbInz+Yx+bkpWeEzQTCv5HOz9mS8+l6wrjwji3IRRG0xs3xXeMrForgLAQQNxjB6Zb
         78DpJSJaOrn1r7RcCZZ8NVjSRTbPtxpoE+AJA142B1nL0qxVPxSVBGAlIQzPAsH9zoyK
         L+lzGqzkuwPjvwALXo1s2JeoW0lqJ063FZEAh2NpEcDbYJ58ONTqzUQWG8DG1wqWPS2z
         sEtw==
X-Gm-Message-State: AOAM530dL76FhTraPNpvBholbcxosCFo4W87PPfMj9H8Jv7tKRLf4RE3
        VtN90xSQbGL0jEW9IU4Vl4WY1vOb5mA=
X-Google-Smtp-Source: ABdhPJyptkrrI1UE1dGqlPh4SXk1LBrRpnOKrS2DCl2c6/X317cqtOOiWOSAi9/IPegbizDGWSUPFg==
X-Received: by 2002:a63:f244:: with SMTP id d4mr39379649pgk.65.1641178699160;
        Sun, 02 Jan 2022 18:58:19 -0800 (PST)
Received: from google.com ([2620:15c:202:201:eced:8562:1343:24f1])
        by smtp.gmail.com with ESMTPSA id m6sm30209294pgb.31.2022.01.02.18.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 18:58:17 -0800 (PST)
Date:   Sun, 2 Jan 2022 18:58:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Martin Wilck <martin.wilck@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YdJmRzDwruE5jt8W@google.com>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
 <YbP6Q9J++OVKqPfn@google.com>
 <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
 <YcFHZVHbIG3ujDlC@google.com>
 <YcJOUvQJJGSHmlCE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcJOUvQJJGSHmlCE@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Happy New Year!

On Tue, Dec 21, 2021 at 01:59:46PM -0800, Luis Chamberlain wrote:
> On Mon, Dec 20, 2021 at 07:17:57PM -0800, Dmitry Torokhov wrote:
> > On Mon, Dec 20, 2021 at 08:52:30AM -0800, Luis Chamberlain wrote:
> > > On Fri, Dec 10, 2021 at 05:09:23PM -0800, Dmitry Torokhov wrote:
> > > > On Fri, Dec 10, 2021 at 04:11:21PM -0800, Luis Chamberlain wrote:
> > > > > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > > index cd23faa163d1..d90774ff7610 100644
> > > > > > --- a/init/Kconfig
> > > > > > +++ b/init/Kconfig
> > > > > > @@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
> > > > > >  
> > > > > >  endchoice
> > > > > >  
> > > > > > +config MODULE_DECOMPRESS
> > > > > > +	bool "Support in-kernel module decompression"
> > > > > > +	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
> > > > > > +	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> > > > > > +	select XZ_DEC if MODULE_COMPRESS_XZ
> > > > > 
> > > > > What if MODULE_COMPRESS_GZIP and MODULE_COMPRESS_XZ are enabled?
> > > > > These are not mutually exclusive.
> > > > 
> > > > They are mutually exclusive, the kernel uses the same (one) compression
> > > > method for all kernel modules that it generates (i.e we do not compress
> > > > drivers/usb/... with gzip while drivers/net/... with xz).
> > > 
> > > Ah yes I failed to see the choice/prompt for it.
> > > 
> > > > The idea here is to allow the kernel consume the same format that was
> > > > used when generating modules. Supporting multiple formats at once is
> > > > overkill IMO.
> > > 
> > > Indeed.
> > > 
> > > > > > +	help
> > > > > > +
> > > > > > +	  Support for decompressing kernel modules by the kernel itself
> > > > > > +	  instead of relying on userspace to perform this task. Useful when
> > > > > > +	  load pinning security policy is enabled.
> > > > > 
> > > > > Shouldn't kernel decompression be faster too? If so, what's the
> > > > > point of doing it in userspace?
> > > > 
> > > > Make the kernel smaller?
> > > 
> > > Yes this I buy.
> > > 
> > > > Have more flexibility with exotic compression
> > > > formats?
> > > 
> > > I just have a hunch that doing module decompression in the kernel will
> > > speed things quite a bit... any chance you can provide some before and
> > > after systemd-analyze ?
> > 
> > If you insist I can try running it, 
> 
> If you can run the test, yes it would be appreciated.

OK, so I finally got around to doing it and the differences are pretty
much noise, as I expected:

5.16.0-rc7:         Startup finished in 5.022s (firmware) + 6.106s (loader) + 1.370s (kernel) + 5.685s (initrd) + 10.842s (userspace) = 29.026s
5.16.0-rc7-patched: Startup finished in 4.958s (firmware) + 6.701s (loader) + 1.382s (kernel) + 5.278s (initrd) + 10.822s (userspace) = 29.145s
5.16.0-rc7-patched: Startup finished in 4.953s (firmware) + 5.912s (loader) + 1.385s (kernel) + 5.327s (initrd) + 10.457s (userspace) = 28.036s

Also see attached.

> 
> > but it should be slower unless your
> > memory controller is so slow that reading file from disk and dealing
> > with page by page decompression is quicker than copying already
> > decompressed data from userspace. 
> 
> With userspace decompression I'd imagine we also have more context switches.

We have plenty of rescheduling points when we allocate new pages, so I
expect we'll be getting preempted while in kernel as well if needed.

> 
> > We still reading and uncompressing
> > file in kmod (to make sure the format is valid)
> 
> I don't understand, that seems wasteful.

This way we can make sure we are not feeding kernel garbage and abort
early. Yes, we could just check signature and hope that the data is good
(and if it is not the kernel will reject it) but this is not a hot path
at all and amount of data we decompress is relatively small, so I do not
think trying to optimize this makes much sense (as shown by the numbers
above).

> 
> > and we can uncompress
> > using large buffers (we are not concerned with using unswappable kernel
> > memory).
> > 
> > Maybe in the future when we have streaming and accelerated in-kernel
> > decompression API we could optimize for that in kmod and see some
> > savings on very large modules.
> 
> That would be very nice.

Again, practical benefit of doing this is pretty much close to 0 in this
particular case.

Thanks.

-- 
Dmitry
