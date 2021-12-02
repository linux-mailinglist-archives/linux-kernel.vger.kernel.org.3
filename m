Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C488466A28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376682AbhLBTME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376361AbhLBTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:12:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:08:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m24so385971pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hDOoMBGSN6kabG9MIsrdbw1zEiInbB097CJy1sxekA=;
        b=fRdahR+cm2DQ61b0GVnE9C2akBv5/+imaMxGdjBCmOdwU1Je3To8WFoP3teXAsMszj
         /24+VNRBMfuyVZ74nVKJgYJaBo/w7nWrdBElFwuH+HSXjBuCqlruUQjhH0bwHM60TGI3
         9PrvHDdqrDhFfT0kv1EJq+1qblKeewWtDwwe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hDOoMBGSN6kabG9MIsrdbw1zEiInbB097CJy1sxekA=;
        b=A1Sb9fmM13EwoetW+7qinu1wqVf45oa7/jDI4XBrtYGmr8eZcNLDP+pE0FfHbEAKb8
         WcrdzHoDh70rfmJhW67t7Xn3MxDEYfsdxI2nS3Y6p2InJFj/r1/0lR7NWq1gWq33+IIF
         q65wQ90ihbV6kXfXqi1FbMobZFxNKrFIUL6ulo+598/maq7rZdYXCfhc4IJwAew6rSxx
         +J+iWA/d0Cj8reX88JhJWvfcynfSOqQrwyNQHmbdS83u5OLmSzNo8qgfl9B3AfuLrUND
         C13VrG+HGKHyvnbTkPXDyn2Ar7aGvv7tuFTwDl+W3nn3eBvkW2haRnIC4mUozlrX6Bga
         7w7g==
X-Gm-Message-State: AOAM533A3EnqWNDUldFQcPPetFdkHwb6eFl8M32o2ZRGmIsZ4o5Ppyic
        tFVIoa0Tb7LxOTF5rUe6lWiy7w==
X-Google-Smtp-Source: ABdhPJzR7Cx57RXSCzSLhVy8YTHO2hrexUvipOpFPVgN8+TxWM0fTP8EXYPzrQJo7/Ae/wnpdM5ccA==
X-Received: by 2002:a17:90b:4a43:: with SMTP id lb3mr8107258pjb.222.1638472116294;
        Thu, 02 Dec 2021 11:08:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j34sm347058pgj.42.2021.12.02.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:08:35 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:08:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <202112021105.C9E64318F@keescook>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
 <YajviIws7csNbTxU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajviIws7csNbTxU@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 06:08:40PM +0200, Leon Romanovsky wrote:
> On Thu, Dec 02, 2021 at 03:29:47PM +0000, Matthew Wilcox wrote:
> > On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> > > The problem is that this WARN_ON() is triggered by the users.
> > 
> > ... or the problem is that you don't do a sanity check between the user
> > and the MM system.  I mean, that's what this conversation is about --
> > is it a bug to be asking for this much memory in the first place?
> 
> We do a lot of checks, and in this case, user provided valid input.
> He asked size that doesn't cross his address space.
> https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/infiniband/core/umem_odp.c#L67
> 
> 		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
> 		if (check_add_overflow(umem_odp->umem.address,
> 				       (unsigned long)umem_odp->umem.length,
> 				       &end))
> 			return -EOVERFLOW;
> 
> There is a feature called ODP (on-demand-paging) which is supported
> in some RDMA NICs. It allows to the user "export" their whole address
> space to the other RDMA node without pinning the pages. And once the
> other node sends data to not-pinned page, the RDMA NIC will prefetch
> it.

I think we have two cases:

- limiting kvmalloc allocations to INT_MAX
- issuing a WARN when that limit is exceeded

The argument for the having the WARN is "that amount should never be
allocated so we want to find the pathological callers".

But if the actual issue is that >INT_MAX is _acceptable_, then we have
to do away with the entire check, not just the WARN.

-- 
Kees Cook
