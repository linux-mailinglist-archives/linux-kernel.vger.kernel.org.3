Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641AA468028
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376375AbhLCXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhLCXE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:04:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4FC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:01:31 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so4512111pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7eG/LpBpIoDnmkkVRB1Vl+hz0IOd/cbgCmXoaPwHfQ=;
        b=Kqdt+V2+8MMJ+dlp+a/a0oLuuQr8cvKUDrkpYQuwEiuxsngWfr17BQf4DOTq2Lh4fu
         N8ITGCBtg143Ru+FsXq4bDQwC1z6lwkwdx2wZwDqAO0/zpvj8+pD2B7RW86gbi69lZmF
         UvVbp8QJPz8k/E0XNi5H5DmyRVDDL+cUFAv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7eG/LpBpIoDnmkkVRB1Vl+hz0IOd/cbgCmXoaPwHfQ=;
        b=D1XtZcDKDZX4kwJggAa2KXOjlFvo3ynzaN7ijHi2q/2MTYRHpPHW/OF7sUGV2ANWtF
         CPybNE3yrNPRF6VmcH4stMZev+int7xx3ie/f1itJ9PDdFNz3wtUVeNBhqH0SkyGX3nc
         WNZHvUeJdj4wKw4f0cb2GUjPvnN6b4m5/PgOckO5Icn+4zOsTeJgalh58ClK/tprFn97
         42kdUuvNgIZG1XWX2MSBy+As5Ir5T2aeH1XMawnQsKAY2KRLJ5TZkUaLIlhAackhi4+m
         IU+apc9lypzSVp2zD6XzsihEl0PY2SIm9ooRDVVMdQOmjT7wsvgKKELhd6/dU16uoDO3
         Dozw==
X-Gm-Message-State: AOAM533p7ewA+R1/h/ORUE4fRwerb4nO7g5LUe2JJN06fjnrEClsgkHM
        ZY6xcxlqBETN5mRIDx9XzrJOLQ==
X-Google-Smtp-Source: ABdhPJxfq+pZGUTD+G+gefYGdCFsLh79Rg82YRWjEdarh3PeOrocMsXVVva9firtbRXWQagQJ2vS1w==
X-Received: by 2002:a63:5f8d:: with SMTP id t135mr6624293pgb.610.1638572491418;
        Fri, 03 Dec 2021 15:01:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc10sm3567730pjb.9.2021.12.03.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:01:31 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:01:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112031450.EFE7B7B4A@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203182638.GA450223@lapt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:26:38AM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > > It's common practice to cast small variable arguments to the find_*_bit()
> 
> Not that common - I found 19 examples of this cast, and most of them
> are in drivers.

I find 51 (most are in the for_each_* wrappers):

$ RE=$(echo '\b('$(echo $(grep -E '^(unsigned long find|#define for_each)_' include/linux/find.h | cut -d'(' -f1 | awk '{print $NF}') | tr ' ' '|')')\(.*\(unsigned long \*\)')
$ git grep -E "$RE" | wc -l
51

> > > This leads to the find helper dereferencing a full unsigned long,
> > > regardless of the size of the actual variable. The unwanted bits
> > > get masked away, but strictly speaking, a read beyond the end of
> > > the target variable happens. Builds under -Warray-bounds complain
> > > about this situation, for example:
> > > 
> > > In file included from ./include/linux/bitmap.h:9,
> > >                  from drivers/iommu/intel/iommu.c:17:
> > > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> > >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > >       |                                     ^~~~~
> > > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> > >  2115 |         int pds, max_pde;
> > >       |                  ^~~~~~~
> 
> The driver should be fixed. I would suggest using one of ffs/fls/ffz from
> include/asm/bitops.h

I don't think it's a good API design to make developers choose between
functions based on the size of their target. This also doesn't work well
for the main problem which is the for_each_* usage.

The existing API is totally fine: it already diverts the constant
expression small sizes to ffs/etc, and this change is only to that
part. It's just changing the C description of how to get at the desired
bits, so that -Warray-bounds doesn't (correctly) get upset about the
wider-than-underlying-type OOB read.

This is one of the last issues with -Warray-bounds, which has proven to
be an effective compiler flag for finding real bugs. Since this patch
doesn't change performance, doesn't change the resulting executable
instructions, doesn't require any caller changes, and helps gain global
-Warray-bounds coverage, I'm hoping to convince you of its value. :)

-Kees

-- 
Kees Cook
