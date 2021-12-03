Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6F467FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359667AbhLCWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 17:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343898AbhLCWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 17:46:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC77C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 14:43:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i12so4194288pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmYifbLGwqLgym0oSL2qVAxGB2P0Q3oKi0tEXLbFFBY=;
        b=TxiZfUoAR2bg5aoZKx4d7ryFP0k11M0RRfUmuX3Gei4Rbd9RiGIGHbOH3BVVrI39RA
         dAA8ykWUoCp5BKU18FWadAS9rjjEOw68u+Nv7z8iGRxKpeslXUcEwImK8IaYJqtez4Zl
         4Zx85nCwE0mgLI8CsAb4liyNMAn8tb7qMf/2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmYifbLGwqLgym0oSL2qVAxGB2P0Q3oKi0tEXLbFFBY=;
        b=Y7VOz1h57YnOGx/tXlNHsiL3xt2B1opyNqdFESC6Nrxq3ED7AsPkmz1bAAcLu60h8z
         44NaNwAlZJPrCnH1X/L5XHNUQ4rIN59d0Xbx7k8JqKLuyl6nUU4dg0aptS7+w9dmk3ix
         Y7WgKbnPJv6Osczy2O51jxPEn45Zl+4c6X+DMd7EQ+VY2/GOPw+J0871Nqzn1eoOpTS/
         2mJvdwS9+gw1s0mzCgQV/f42/dHHnd7f1uQBdn6sGLHC5jX3AWwHa7Kdl13mNarR6bGs
         P7SN4LW1miriGjZ/J4G2bvPmTaI3XiKFIL5+Kg4zxJ/WSs5eNdFd5ivWOSzIM6ZQrcGW
         ZJfg==
X-Gm-Message-State: AOAM530yoiA5aDp3rdloq6dVtCyFp9xLmN6k1vcmqDH4FrclkRYTiKtO
        grzYu7SoA/8fvt92bJpT7c+ldA==
X-Google-Smtp-Source: ABdhPJywlcC0fEnqgj2OSMlQxPTmNufUhmu/pZo3pN7KcH0xCLDIjIxCrMCJ+EFItl2GrFZyqJap9g==
X-Received: by 2002:a05:6a00:24cd:b0:49f:a4d8:3d43 with SMTP id d13-20020a056a0024cd00b0049fa4d83d43mr22001716pfv.49.1638571402607;
        Fri, 03 Dec 2021 14:43:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm3158747pjh.1.2021.12.03.14.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:43:22 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:43:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112031441.200FE4975@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <E1A4953A-8801-48FA-A744-63DA548C5924@chromium.org>
 <20211203191611.GB450223@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203191611.GB450223@lapt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:16:11AM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 08:37:59AM -0800, Kees Cook wrote:
> > 
> > 
> > On December 3, 2021 4:30:35 AM PST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > >> It's common practice to cast small variable arguments to the find_*_bit()
> > >
> > >It's a bad practice and should be fixed accordingly, no?
> > 
> > There's an argument to be made that the first arg should be void * but that's a pretty invasive change at this point (and orthogonal to this fix).
> 
> What for? To save at most 7 bytes of alignment overhead for bitmaps
> like char bitmap[sizeof(unsigned long) + 1]?

I just meant to simplify the calling conventions. Right now everyone has
to cast to unsigned long *, which doesn't seem right: alignment and
strides can be done in the routine. But, I have no strong opinion about
this; it's just something I noticed while looking at it.

-- 
Kees Cook
