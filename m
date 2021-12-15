Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCFD475BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbhLOPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbhLOPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:23:08 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55429C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:23:08 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id DF8EDB0023A; Wed, 15 Dec 2021 16:23:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id DE388B0006D;
        Wed, 15 Dec 2021 16:23:04 +0100 (CET)
Date:   Wed, 15 Dec 2021 16:23:04 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Do we really need SLOB nowdays?
In-Reply-To: <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2112151621300.434315@gentwo.de>
References: <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <YWw1n6y/AGED14HD@casper.infradead.org> <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de> <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <YXqSoo+b9RTclW/2@casper.infradead.org> <20211210110835.GA632811@odroid> <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz> <20211215062904.GA1150813@odroid> <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021, Vlastimil Babka wrote:

> > SLOB:
> >
> > 	Memory required to boot: 6950K
> >
> > 		Slab:                368 kB
> >
> > SLUB:
> > 	Memory required to boot: 6800K
> >
> > 		Slab:                552 kB
> >
> > SLUB with slab merging:
> >
> > 		Slab:                536 kB
>
> 168kB different on a system with less than 8MB memory looks rather
> significant to me to simply delete SLOB, I'm afraid.

This looks more like a bug/difference in SLAB accounting of SLOB.

How could SLOB require more memory to boot but use less SLAB memory?

This looks to me like a significant reason enough to remove SLOB since
SLUB works with less memory than SLOB.

