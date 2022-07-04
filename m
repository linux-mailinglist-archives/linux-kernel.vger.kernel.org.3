Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5C565683
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiGDNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiGDNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:06:27 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDB644E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:06:24 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 43E36C01C; Mon,  4 Jul 2022 15:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656939983; bh=cxLipKId9//KpoYaYTVtTMphD/C/dvBBPxKmF4PDz5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPCPiQCv3Kp1oiXMgLagjXjT9EMRQN/rARGNp+zZWdNK3pYhQwXm4dPiUUdhv/RZu
         SCS/CEj8V0HQQTdPSBsaTBpkhIXHBvcah6cvk7Ogh4hs/acJoVuKucp6FMLBvh2U/t
         qjCOlXPokhH8mAXnUoi6gcGwZD3nSZkwycegEgu0+Oj85/hiyIZPMjZCCM5BGgACxY
         1dzKVOT32dM949ZPebvp/ISP0H2YC90VM1hZJh+TdZYG42gfaDfwwaFhQph27fX48O
         gTdd6YidcpaAYDK6zrudfzi2aNPXs/yR3zdUKkmFNXLNWMmGNbeT7d8NbUWz99KUOD
         NeYiHdMJ7rX5A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8E36AC009;
        Mon,  4 Jul 2022 15:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656939982; bh=cxLipKId9//KpoYaYTVtTMphD/C/dvBBPxKmF4PDz5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOInZ1wThYJWs6BruA7q6Jjsz1GxvxBtRETt/n1Aeo4Bhm5s7hLyPfq0qeyqJFhTh
         ihsOdRz8G98jdGxbycPKii11c07Tk8qE1PC64ilxZpx9oW3yWyxvwpLfg96+uDjaf6
         V6Uk4V4BQYL3Ip9fB+0J0QeXJMVKfQpaX8OQtpPpFRmlkmbTFx/xeoTiKmFPHbDBKU
         e/JEqRnm7kS5oXc5K1/ietCmp9aMd9DWeFmZlxiteLmNjvOdNgqJPbjSPh4QerES4e
         48slT9ewiT6DRXpMmQEPD5d82wurelk70jAUxQMiQ1GSj93kXrWHgSsiFqC50ka5Eo
         wbQx4Ob4DH2qQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 006f3d3d;
        Mon, 4 Jul 2022 13:06:15 +0000 (UTC)
Date:   Mon, 4 Jul 2022 22:06:00 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <YsLluKb1v5SqN2xD@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
 <YsJgxoTyYxX1NwyW@codewreck.org>
 <2335194.JbyEHpbE5P@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2335194.JbyEHpbE5P@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Jul 04, 2022 at 01:12:51PM +0200:
> On Montag, 4. Juli 2022 05:38:46 CEST Dominique Martinet wrote:
> > +Christian, sorry I just noticed you weren't in Ccs again --
> > the patches are currently there if you want a look:
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=9p_mempool
> 
> I wonder whether it would make sense to update 9p section in MAINTAINERS to 
> better reflect current reality, at least in a way such that contributors would 
> CC me right away?

I almost suggested that, but Al Viro didn't cc Eric/Latchesar on the
previous series so I'm not sure how much people rely on MAINTAINERS and
how much of it is muscle memory...
Well, can't hurt to try at least -- giving Eric and Latchesar a chance
to reply.



Replying out of order

> However that's exactly what I was going to address with my already posted 
> patches (relevant patches regarding this issue here being 9..12):
> https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> And in the cover letter (section "STILL TODO" ... "3.") I was suggesting to 
> subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size 
> categories? Because that's what my already posted patches do anyway.

Yes, I hinted at that by asking if it'd be worth a second mempool for 8k
buffers, but I'm not sure it is -- I think kmalloc will just be as fast
for these in practice? That would need checking.

But I also took a fresh look just now and didn't remember we had so many
different cases there, and that msize is no longer really used -- now
this is just a gut feeling, but I think we'd benefit from rounding up to
some pooled sizes e.g. I assume it'll be faster to allocate 1MB from the
cache three times than try to get 500k/600k/1MB from kmalloc.

That's a lot of assuming though and this is going to need checking...


> Hoo, Dominique, please hold your horses. I currently can't keep up with 
> reviewing and testing all pending 9p patches right now.
> 
> Personally I would hold these patches back for now. They would make sense on 
> current situation on master, because ATM basically all 9p requests simply 
> allocate exactly 'msize' for any 9p request.

So I think they're orthogonal really:
what mempool does is that it'll reserve the minimum amount of memory
required for x allocations (whatever min is set during init, so here 4
parallel RPCs) -- if normal allocation goes through it'll go through
normal slab allocation first, and if that fails we'll get a buffer from
the pool instead, and if there is none left it'll wait for a previous
request to be freed up possibly throttling the number of parallel
requests down but never failing like we currently do.

What will happen with your patches is we'll get less large buffers
allocated so we can reduce the reserved amount of buffers, but there
will still be some so Kent is still going to be just as likely to see
high order allocation failures. The memory pressure and difficulty to
allocate high order pages doesn't necessarily comes from other 9p
requests so just having less msize-sized buffers might help a bit but I
don't think it'll be enough (I remember some similar failures with
lustre and 256k allocs, and it's just buffer cache and whats
not... because we're doing these allocs with NOFS these can't be
reclaimed)
With this the worst that can happen is some RPCs will be delayed, and
the patch already falls back to allocating a msize buffer from pool even
if less is requrested if that kmalloc failed, so I think it should work
out ok as a first iteration.

(I appreciate the need for testing, but this feels much less risky than
the iovec series we've had recently... Famous last words?)


For later iterations we might want to optimize with multiple sizes of
pools and pick the closest majoring size or something, but I think
that'll be tricky to get right so I'd rather not rush such an
optimization.


> How about I address the already discussed issues and post a v5 of those 
> patches this week and then we can continue from there?

I would have been happy to rebase your patches 9..12 on top of Kent's
this weekend but if you want to refresh them this week we can continue
from there, sure.

--
Dominique
