Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580924791E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhLQQwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhLQQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:51:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F767B828FF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB3CC36AE1;
        Fri, 17 Dec 2021 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639759911;
        bh=tuQrVEIodDfTP/WIeUxfIZy0X9WpU5zJkldM4Fk5eCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+6n4O1OOPNczcbNWZxVZ3pF37qVcJ2KwXhaxcVrDGJkpQ6GF/Yhs68GXX8lzQF0e
         UPywYr8tXGnjwMN7F7kDxF3A4j4/fROKAYwV3KblL01gCtAMmGVZZ+cmVjkOL02NGt
         muAgEU/Fcu4oSmzZClLFzvfP3WeR85wqfqJm/VisMCkRyzxzpsodrz5KdFUq4GxH0w
         f3vT8EW+Tvzyeb9dAbwSlQvJzgNr7UeMKV8/JsJeeusXRMwMVpizR2Ki92GSArZ19D
         Pzo2e5fe1J3OR03v9y7e6/VtE+C/7cwecasJa+KHybXFoa87zuOZTPdjFeB5N1Z6lO
         AZTV1n6Pnz+Xg==
Date:   Fri, 17 Dec 2021 08:51:49 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     "Yang.Lee" <yang.lee@linux.alibaba.com>
Cc:     chao <chao@kernel.org>,
        linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVEM=?= =?utf-8?Q?H?= -next] f2fs:
 Simplify bool conversion
Message-ID: <YbzAJWlnSHrnR4/X@google.com>
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
 <YbuTLr/HJO3IMI6u@google.com>
 <fc89c7e6-ced2-40e1-9d01-496a3b60b268.yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc89c7e6-ced2-40e1-9d01-496a3b60b268.yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, Yang.Lee wrote:
> "Why not this?
>   sbi->gc_urgent_high_limited = t;"
> 
> Since 't' is an unsigned long type and 'gc_urgent_high_limited' is a bool type, the assignment operation will cause a new warning.

Huh, that doesn't allow auto casting as well.

> 
> 
> ------------------------------------------------------------------
> 发件人：Jaegeuk Kim <jaegeuk@kernel.org>
> 发送时间：2021年12月17日(星期五) 03:27
> 收件人：Yang Li <yang.lee@linux.alibaba.com>
> 抄　送：chao <chao@kernel.org>; linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>; linux-kernel <linux-kernel@vger.kernel.org>; Abaci Robot <abaci@linux.alibaba.com>
> 主　题：Re: [PATCH -next] f2fs: Simplify bool conversion
> 
> On 12/15, Yang Li wrote:
> > Fix the following coccicheck warning:
> > ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >  fs/f2fs/sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 9e1cf44642ae..530c36b89bf1 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -488,7 +488,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >  
> >   if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
> >    spin_lock(&sbi->gc_urgent_high_lock);
> > -  sbi->gc_urgent_high_limited = t == 0 ? false : true;
> > +  sbi->gc_urgent_high_limited = t != 0;
> 
> Why not this?
>   sbi->gc_urgent_high_limited = t;
> 
> >    sbi->gc_urgent_high_remaining = t;
> >    spin_unlock(&sbi->gc_urgent_high_lock);
> >  
> > -- 
> > 2.20.1.7.g153144c
> 
