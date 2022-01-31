Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9C4A4008
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358109AbiAaKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358090AbiAaKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:21:35 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F4C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:21:35 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id y192so7920368vkc.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Lm3cgz6DtmL9tpisEfrfuo7Wj8QCaI1ocVGLYB2Y2U=;
        b=Lind02/Njzrr7eWAupL32iIHm4GhlbxdTkXaEnTW2OV0dgNWX/rudjG6+pcPbPpIFq
         C69XJIFu0uAQHgKg9yzKqDEaKe2dTryF/XVS7u5Fs51eNy1ypgdGDsx2HWFQUKmKA/Qj
         gsFWvFnWm3m6cKgmcrNeOadSQiHcKT9p9vJ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Lm3cgz6DtmL9tpisEfrfuo7Wj8QCaI1ocVGLYB2Y2U=;
        b=kPLfGQlL26OEgNI8LOSezyCHYD5cZSVSRQPYZkpA6uuddRd/JsP3SCdqeBN6OPavuy
         iQTbNi0Sy0i459D3obzj9CZvEZxE6IT0fQCCu7UwnoAEJo6Kpa/kN4nSiT78s44sO8Uz
         zOdrDPoh1csJCnGyDqwX6vPEhAWt/D1lySF49xOABq55rVo8NhtPZJdYL3yhTR1YfYo1
         goI3O0n44IFustb2zM5ZO1QPKkMx7jUFYAJjTmuizy7V8W0dH9/BLlQ/EKi+aBkWTUY+
         H84xzZVqloCTzO6kO9iwu+XqkZHzLjDq+saJfbE56minJMfMNHSv7mStESI/MPMGxECz
         Mmkg==
X-Gm-Message-State: AOAM531cgwS4D/1DfVT4eXG+tPyv5EZv5sUv2NmIvFGP2c0VWwsjJt5G
        IOrRtmD2srfCHlh1Skh+i69aSLzgStEd646xnSwT2g==
X-Google-Smtp-Source: ABdhPJwOQtCABzU+9UXwt+UwQamDQBcR3aBXOuhKxfwoBl2Am0C/bqSbVLQ7zPuyDB0UYMDY2raQ+Hlv8DNEyXB5kK8=
X-Received: by 2002:a1f:a753:: with SMTP id q80mr8215440vke.1.1643624494313;
 Mon, 31 Jan 2022 02:21:34 -0800 (PST)
MIME-Version: 1.0
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown> <YfdlbxezYSOSYmJf@casper.infradead.org>
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>
In-Reply-To: <164360446180.18996.6767388833611575467@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Jan 2022 11:21:23 +0100
Message-ID: <CAJfpeguPJLpJcyC2_FU3pVNk0FhiKJvVuMdQR_wZAgY0Wnsqzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 05:47, NeilBrown <neilb@suse.de> wrote:

> > > +++ b/fs/fuse/file.c
> > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
> > >
> > >     if (fuse_is_bad(inode))
> > >             return;
> > > +   if (fc->num_background >= fc->congestion_threshold)
> > > +           return;
> >
> > This seems like a bad idea to me.  If we don't even start reads on
> > readahead pages, they'll get ->readpage called on them one at a time
> > and the reading thread will block.  It's going to lead to some nasty
> > performance problems, exactly when you don't want them.  Better to
> > queue the reads internally and wait for congestion to ease before
> > submitting the read.
> >
>
> Isn't that exactly what happens now? page_cache_async_ra() sees that
> inode_read_congested() returns true, so it doesn't start readahead.
> ???

I agree.

Fuse throttles async requests even before allocating them, which
precludes placing them on any queue.  I guess it was done to limit the
amount of kernel memory pinned by a task (sync requests allow just one
request per task).

This has worked well, and I haven't heard complaints about performance
loss due to readahead throttling.

Thanks,
Miklos
