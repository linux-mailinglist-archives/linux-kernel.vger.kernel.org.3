Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13154904EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiAQJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiAQJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:34:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429AFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:34:02 -0800 (PST)
Date:   Mon, 17 Jan 2022 10:33:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642412040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUwYyjGRaOG1n9rddzpFHQxZYYxv3VHs0gt0bcZZRuA=;
        b=WBCWSuzouFzebECmDhPjNM+D2l6VhV19Ryfp5UsxS9uY+IYnSKT1xCzbIlcccbeyUXzptm
        GspzC/IfdPLjYppxaEsoROdlsitjTlxgAxMaohEGWn1V7+A+nXGO+qeKgE0gYpawEOoQGm
        1uGGOer9ERclfF/i+6TvvWeGAQt+IAZMaPRgHmrQ2QGb4pLGfK4a2vklBpBi3gtx99FqVf
        cKXEiSlqCvF9oR4KQx8gVXCZm9NJJ2Wf0csezAo5K9d5ZNqJJ0rCJGR5lUzS+6+60O35Y2
        GCRaA7Hrx3HbSHGEAkcDoi9iWcXqXbT8tbR+Hnx22GSvk9tjwRnOJQoTb1ccQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642412040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUwYyjGRaOG1n9rddzpFHQxZYYxv3VHs0gt0bcZZRuA=;
        b=7ZpD5/huBQf6jeg4H2LeNre/AS5SE5cxbG3mRUmUd3MNrgOCHLvXnx41x1VfolCJMnI8jd
        GBDh9Id+n29bqnDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
Message-ID: <YeU4B46F+oFUBRLE@linutronix.de>
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-17 16:32:46 [+0800], Xin Long wrote:
> another issue. From the code analysis, this issue does exist on the
> upstream kernel, though I couldn't build an upstream RT kernel for the
> testing.

This should also reproduce in v5.16 since the commit in question is
there.

> > >         CPU0                        CPU1
> > >         ----                        ----
> > >   cpus_read_lock()
> > >                                    kn->active++
> > >                                    cpus_read_lock() [a]
> > >   wait until kn->active == 0
> > >
> > > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> > > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> > > would be detected:

The cpu_hotplug_lock is a per-CPU RWSEM. The lock in [a] will block if
there is a writer pending.

> > >   ======================================================
> > >   WARNING: possible circular locking dependency detected
> > >   ------------------------------------------------------
> > >   dmsetup/1832 is trying to acquire lock:
> > >   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
> > >
> > >   but task is already holding lock:
> > >   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> > >

I tried to create & destroy a cryptarget which creates/destroy a cache
via bio_put_slab(). Either the callchain is different or something else
is but I didn't see a lockdep warning.

Sebastian
