Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E54B5B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiBNUqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:46:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBNUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:59 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F78245FD3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:44:00 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id r20so20396214vsn.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=17Bsz2tDR9cv+r6+yn7G+p/1ar4tciGH3rzRstCpvzk=;
        b=j+pDsEQOlVPYsxzQ1X2T7ellEP2v/3Rap3g71hqa2HH9Snz9hF+a/BLY2uP2SUiOAL
         KaCv200/N6QR02DB0RkW6K2XaSg047kyLVbW9kGPiOieblI3bV715SxDOnunt6rJsxa1
         JvJV6XVgw/jSyDHhPnZ8aUrYJ1EkuFG/Ual94yrXo8DkHc/MNs48epBWLHc8QYScxIo9
         k+M/cZX/QPlGKGhZrKa1R4RGfmv7K5uJAB8OPuH3jYezUe6iVk1q82ruEg8Ib/d1rymi
         rZhREHlJ2A0OK8+l+lGlHtYS2aFUVhOytLVkUgMoDXHWQdgUvo1kzklV1fwBgvuBky60
         rPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=17Bsz2tDR9cv+r6+yn7G+p/1ar4tciGH3rzRstCpvzk=;
        b=aqahGo0D4BGYH73GxtL5UGJ2n19rvU92QKudNBJTa7w/93fPpuWj6MQ088SLsDF4bT
         i/aIPGZ9PFFLuisrW1hD+cO5TttATqKt/kpen8GwO+n0TSNv05JIm+yJ7sB2UPEiUnZ7
         3bqAKBKuezoYHLz1dkqeOOitHi06xYz62dsoOUbOKVOQvOnjJtAswdRoN/a8lLXiziy0
         x52aD2MgHuWyVFTXhltdow+9m45hTW8yLsxMq+kw2AXBjbDMzgeQHBo4EqkRlG197mM/
         3daFEATxqvnCqvLFn//IX4TdeoGnFXfnzP1gaXB8en4gtiGc0AL+TNAIb7bcXY+MCoOe
         JWAw==
X-Gm-Message-State: AOAM531XANYhCpH6GaNpogTGgGELNdjaOrkr6QHhm9jSk+YwOrmWKXLX
        mpvJ51v9qkknAnqT+8zEG7eGyqMdzEf6B4D4ygNKYSBmVJJNJg==
X-Google-Smtp-Source: ABdhPJz0Oy/JgAUdiZIwNaa8W2W0mJGvuMr99W2I9UeRvepCocWgHMmOer0izZmus6n4NKI4NDsPxZZe9MeKAxdZ1p0=
X-Received: by 2002:a62:e907:: with SMTP id j7mr753345pfh.3.1644869401968;
 Mon, 14 Feb 2022 12:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20220212071111.148575-1-ztong0001@gmail.com> <20220214175905.GV785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220214175905.GV785175@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Feb 2022 12:09:54 -0800
Message-ID: <CAPcyv4jrh5Xr3AnOj-YrOr3i4HTm=wVBuaQ1VBAxCoszHjHdfA@mail.gmail.com>
Subject: Re: [PATCH] dax: make sure inodes are flushed before destroy cache
To:     Tong Zhang <ztong0001@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 9:59 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 11, 2022 at 11:11:11PM -0800, Tong Zhang wrote:
> > A bug can be triggered by following command
> >
> > $ modprobe nd_pmem && modprobe -r nd_pmem
> >
> > [   10.060014] BUG dax_cache (Not tainted): Objects remaining in dax_cache on __kmem_cache_shutdown()
> > [   10.060938] Slab 0x0000000085b729ac objects=9 used=1 fp=0x000000004f5ae469 flags=0x200000000010200(slab|head|node)
> > [   10.062433] Call Trace:
> > [   10.062673]  dump_stack_lvl+0x34/0x44
> > [   10.062865]  slab_err+0x90/0xd0
> > [   10.063619]  __kmem_cache_shutdown+0x13b/0x2f0
> > [   10.063848]  kmem_cache_destroy+0x4a/0x110
> > [   10.064058]  __x64_sys_delete_module+0x265/0x300
> >
> > This is caused by dax_fs_exit() not flushing inodes before destroy cache.
> > To fix this issue, call rcu_barrier() before destroy cache.
>
> I don't doubt that this fixes the bug.  However, I can't help but think this is
> hiding a bug, or perhaps a missing step, in the kmem_cache layer?  As far as I
> can see dax does not call call_rcu() and only uses srcu not rcu?  I was tempted
> to suggest srcu_barrier() but dax does not call call_srcu() either.

This rcu_barrier() is associated with the call_rcu() in destroy_inode().

While kern_unmount() does a full sycnrhonize_rcu() after clearing
->mnt_ns. Any pending destroy_inode() callbacks need to be flushed
before the kmem_cache is destroyed.

> So I'm not clear about what is really going on and why this fixes it.  I know
> that dax is not using srcu is a standard way so perhaps this helps in a way I
> don't quite grok?  If so perhaps a comment here would be in order?

Looks like a common pattern I missed that all filesystem exit paths implement.
