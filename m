Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174905374DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiE3HJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiE3HJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:09:24 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A169731
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:09:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f34so4508163ybj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jww0J4oPGMUYRvhfGts833A8mLP641a6hSl8oJ1qUcs=;
        b=ABChcYJYfb3PvHlpo7305eF3DUDHI2i4Zmtzt6SuvdHbgRd5goM0L2hEzAmjhBvb/9
         GkMgIKwTvmt3/pHAVz2yPqmZ6Ns6+2Nfiticl5KMGN9C29c/NLn4GSE0wSn+huEU4uF+
         Ij6gdx45XzJhwQfnk1EEIDfIbLWNd3dORFfQmO5Nh3g9xHC1Orz2AbRVnS7QWlS2+vun
         K9jVEGl1IECfzURNz1HZBqj8gX4ryXNJA39KLCZdGj9dNpoyxW3aWWBSthy6Me8n+wkQ
         SKH9qnzS7w5fPn8XGZBt0uvAExoJSBM2A+szQc/ZanaT4XhsRjpErVoMkInYglI3b7d4
         BtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jww0J4oPGMUYRvhfGts833A8mLP641a6hSl8oJ1qUcs=;
        b=jAzQL06eAHtT1VwFuQ/6aOXb1d05nHimbH8LzVfyMwTVeCiCJpJ8MNpb1DTKE+fK2l
         xFtz3EQIudyxIN6S72TOUuyxbo1p7YxTWS8ahKh/FlE3Gwgo2e6Irn5u4AWGMtfw3nQV
         8r+jKlXtXsifeonx8g2Qjw9wOW+GzfLmW9qXkicUL5aM0TPP2cUF1cmprvPpNfUbsU8E
         ELZjxJ91l87ksncJ8HgE1zWAjuDkb2b20xMoXmdsJ29InTA9YAfcx4Ga63JtDvdpbMAa
         yQxKFvZRvcZwhNzzEch70Mpjr48VSmJ+9oxlzWI3FiJWy9zWUldHW4U9WtxdKtO3cle6
         NoXw==
X-Gm-Message-State: AOAM530G4wtQTtk1cJJV2M01MovItJ3Wl3a48xDbTO5WIjz/qOJBqjQm
        IfZzfeLlTGzPy8GsMWO28JMZPGNYDvR2OC6laOzw4A==
X-Google-Smtp-Source: ABdhPJxYHL7g2oEnoKpPxjrJ2ol8xxaxgeuoFB+805LFBauxb9YgatoZECAadZvhb/SFstbxsts621Xia0yPU0xlDzI=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr53535766ybh.6.1653894556570; Mon, 30 May
 2022 00:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220530053326.41682-1-songmuchun@bytedance.com> <0563a019-09e3-a176-d4c1-c240f3cf62d0@redhat.com>
In-Reply-To: <0563a019-09e3-a176-d4c1-c240f3cf62d0@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 30 May 2022 15:08:40 +0800
Message-ID: <CAMZfGtUMfNjOGJ3j4tgha6SxFymNGDo3CW5NO73ZsMby42BPjg@mail.gmail.com>
Subject: Re: [PATCH] mm: memory_hotplug: fix memory error handling
To:     David Hildenbrand <david@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        cheloha@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 2:56 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.05.22 07:33, Muchun Song wrote:
> > The device_unregister() is supposed to be used to unregister devices if
> > device_register() has succeed.  And device_unregister() will put device.
> > The caller should not do it again, otherwise, the first call of
> > put_device() will drop the last reference count, then the next call
> > of device_unregister() will UAF on device.
> >
> > Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/base/memory.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index 7222ff9b5e05..084d67fd55cc 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
> >       }
> >       ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> >                             GFP_KERNEL));
> > -     if (ret) {
> > -             put_device(&memory->dev);
> > +     if (ret)
> >               device_unregister(&memory->dev);
> > -     }
> > +
> >       return ret;
> >  }
> >
>
> See
>
> https://lkml.kernel.org/r/d44c63d78affe844f020dc02ad6af29abc448fc4.1650611702.git.christophe.jaillet@wanadoo.fr
>

I see. Good job by Christophe. Thanks David.
