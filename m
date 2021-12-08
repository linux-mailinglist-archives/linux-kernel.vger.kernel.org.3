Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32C546CD29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhLHF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhLHF3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:29:07 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C9C061574;
        Tue,  7 Dec 2021 21:25:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z9so1295676qtj.9;
        Tue, 07 Dec 2021 21:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cMyYyUng6q+a+XE8y770vuGzp8LDZiAkoL9K7eZKjGM=;
        b=iXx8s/BMi/puQ+T+2G6a33w5emiFE6AzeQzM4j4uvbcRBUmIrUXE4AR2nCOFrfps+y
         DIA2w7/wIZCl/MYlfvIsTimV1IgeYcin0/2wJ37kkPtSK0mYxpCotAV+THLrTw8ZQ6QM
         HSPtLIq7kD7twPaHyFLZNjdDOeCXdUgWFUBT25IbivvafoOenTUqae6Nq8w1F7HKQNCU
         NJPL3GVWl/OgQD/ya/T4j7Y/YKbqOyljyIUequR44qrpJdulcIYBrvXxLq9ekfIx36aE
         GdWF0s3xHH4dVwV6XBOd5M/E9qqUNpJ+y5SQWOzyT5DoCMGnRJCrixCQH0hieDaJpbML
         L6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMyYyUng6q+a+XE8y770vuGzp8LDZiAkoL9K7eZKjGM=;
        b=jZ0EpNR212PKWkbxON3nSoZWUhYVYLRYnytj3ibEBW3eKFv4487pEwKu/Fa5bOVo1e
         IooWJHtx9ZQOaunb76lx9JOO8uwl/glaby2WxsoSzWa2jjjPO8wqdwrnBjq5ArWMk3nf
         D5boVhUkPRC2b2mTCy1BxmUuw2sCdE76p1QAFMQE+mNNHGa3BQAeY4Wi11rPq6ZkWOXx
         gwpOGcpvCydPFgbhRGTUw2efWF4xuB/CLXEadVY9mVAXZlYWh/FjEPxGlZuqoDFBQv/j
         2sYdbPreCZ/OcvAWO6K4USi/TJqFu+GX9mc6xFd9eYTghYPNXoVu8068b27bNcsExE4h
         p2Gg==
X-Gm-Message-State: AOAM5305o8hXndfQQqaT+EuDY/Ifdn1HImjSFo1z6OM3oaw5x9eybtns
        jPcWfEwePzUW3y3MSb6jIqU=
X-Google-Smtp-Source: ABdhPJxrtBWgEIQ5LKCWHIyTyP5VNoFUU8Kt+t+xwggfHwMLHdSp4pkgVEt5FeAHOcJPRRciB6n1og==
X-Received: by 2002:a05:622a:11c9:: with SMTP id n9mr4971930qtk.385.1638941134698;
        Tue, 07 Dec 2021 21:25:34 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id i23sm902395qkl.101.2021.12.07.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:25:34 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:25:32 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <20211208052532.GA11482@lapt>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
 <202112031450.EFE7B7B4A@keescook>
 <20211207233930.GA3955@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207233930.GA3955@lapt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:39:33PM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 03:01:30PM -0800, Kees Cook wrote:
> > On Fri, Dec 03, 2021 at 10:26:38AM -0800, Yury Norov wrote:
> > > On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > > > > It's common practice to cast small variable arguments to the find_*_bit()
> > > 
> > > Not that common - I found 19 examples of this cast, and most of them
> > > are in drivers.
> > 
> > I find 51 (most are in the for_each_* wrappers):
> > 
> > $ RE=$(echo '\b('$(echo $(grep -E '^(unsigned long find|#define for_each)_' include/linux/find.h | cut -d'(' -f1 | awk '{print $NF}') | tr ' ' '|')')\(.*\(unsigned long \*\)')
> > $ git grep -E "$RE" | wc -l
> > 51
> > 
> > > > > This leads to the find helper dereferencing a full unsigned long,
> > > > > regardless of the size of the actual variable. The unwanted bits
> > > > > get masked away, but strictly speaking, a read beyond the end of
> > > > > the target variable happens. Builds under -Warray-bounds complain
> > > > > about this situation, for example:
> > > > > 
> > > > > In file included from ./include/linux/bitmap.h:9,
> > > > >                  from drivers/iommu/intel/iommu.c:17:
> > > > > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > > > > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> > > > >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > > >       |                                     ^~~~~
> > > > > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> > > > >  2115 |         int pds, max_pde;
> > > > >       |                  ^~~~~~~
> > > 
> > > The driver should be fixed. I would suggest using one of ffs/fls/ffz from
> > > include/asm/bitops.h
> > 
> > I don't think it's a good API design to make developers choose between
> > functions based on the size of their target.
> 
> Bitmap functions work identically for all sizes from 0 to INT_MAX - 1. 
> Users don't 'choose between functions based on the size of their target'.
> 
> Can you explain more what you mean?
> 
> > This also doesn't work well
> > for the main problem which is the for_each_* usage.
> 
> for_each_*_bit() requires a pointer to an array of unsigned longs. If
> it's provided with something else, this is an error on a caller side.
> 
> > The existing API is totally fine: it already diverts the constant
> > expression small sizes to ffs/etc, and this change is only to that
> > part.
> 
> If you want to allow passing types other than unsigned long *, you need
> to be consistent and propagate this change to other bitmap functions.
> This is much more work than just fixing at most 48 wrong callers.
> (48 because I inspected some callers manually, and they are fine.)
> 
> > It's just changing the C description of how to get at the desired
> > bits, so that -Warray-bounds doesn't (correctly) get upset about the
> > wider-than-underlying-type OOB read.
> 
> As you said, -Warray-bounds _correctly_ gets upset about the dangerous
> typecasting. What suggested here is an attempt to shut down the
> compiler warning with the cost of complication of the code and
> possible maintenance issues. The correct example of handling tiny
> bitmaps can be found for example in drivers/mtd/nand/raw/ams-delta.c:
> 
>         static void gpio_nand_io_write(struct gpio_nand *priv, u8 byte)
>         {
>                 struct gpio_descs *data_gpiods = priv->data_gpiods;
>                 DECLARE_BITMAP(values, BITS_PER_TYPE(byte)) = { byte, };
> 
>                 ...
>         }

Or use memweight(), if it's more appropriate.
 
> > This is one of the last issues with -Warray-bounds, which has proven to
> > be an effective compiler flag for finding real bugs. Since this patch
> > doesn't change performance, doesn't change the resulting executable
> > instructions, doesn't require any caller changes, and helps gain global
> > -Warray-bounds coverage, I'm hoping to convince you of its value. :)
> 
> I'm all for enabling -Warray-bounds, but the warnings that it spots
> only convinced me that bitmap API is used wrongly, and it should be
> fixed. Can you please share the list of bitmap-related issues found
> with -Warray-bounds that concerned you? I'll take a look and try to
> make a patch that fixes it.
> 
> Thanks,
> Yury
