Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110A5657F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiGDN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiGDN46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:56:58 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820BCE30
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=PHZLOKqVexXpNMBlmQrkg97tWjTZZ5TZCu+Fx+IMbto=; b=tD/DC5wyjqIM8VotuVGbJy0+YY
        H3WbZmLA13uLtM9uun3S0tHNrAhp6ytv6Z2H3d/H3MEzLS5OG9aH2Xo1d9etZaXdOPHlNNf2bU/9c
        BQhQTZk+3zZz9f5kIHFEar3hCs15kiKVlHypW0T+7FRKFaHg4P5whDMKoZXR+c6zjj1csCt1mj5hs
        3z72arWezxQ/s/Ln2BUDyDPogHx/j6bdtO4bppXPcHrRstc9jQYkKgQlfGiHpROxyEvrDv5RS6qn+
        xCXgkPKbE6E3+uW/G0Wimg1GCinYisHgnEctjRSRgLakiNy6bJ8Wg9j7EqwmZ6TlsxvO+cciKeqTU
        fwcxLq7tXDQ/Cq8Bm3RRF/2X6x7w8DIwQqwWS+i+SL8B7/dgwvukXITCPAQnqUzg7P0+LJajLBOFx
        ggpBiTxkDJjBVGTKfTv4WAUfyqzXr7L7ceNkSrJ5x79GSoYlehQ48PU/ctjAzwfeojm+MFqXdP8zs
        z9lY06Q2KcwAZYWRuOPPq7v1Xzlt3K7GH9i7ETg/PkwZAUcPNZe+Pdrpq+9OuD/mfhlErrPx+2VD3
        +7YGC/d9/Rhk7IwHY/8nvvLSKAYdV3Y1DIJTp2f4J/eMX488Mhg9KmASplxeOyO3C+SA8iz0B3Qez
        FSv31ulf93OfzBypolUJBvo/Kq4xQwGwVsOEBztZc=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Mon, 04 Jul 2022 15:56:55 +0200
Message-ID: <72042449.h6Bkk5LDil@silver>
In-Reply-To: <YsLluKb1v5SqN2xD@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <2335194.JbyEHpbE5P@silver>
 <YsLluKb1v5SqN2xD@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 4. Juli 2022 15:06:00 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Mon, Jul 04, 2022 at 01:12:51PM +0200:
> > On Montag, 4. Juli 2022 05:38:46 CEST Dominique Martinet wrote:
[...]
> > However that's exactly what I was going to address with my already posted
> > patches (relevant patches regarding this issue here being 9..12):
> > https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> > And in the cover letter (section "STILL TODO" ... "3.") I was suggesting
> > to
> > subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size
> > categories? Because that's what my already posted patches do anyway.
> 
> Yes, I hinted at that by asking if it'd be worth a second mempool for 8k
> buffers, but I'm not sure it is -- I think kmalloc will just be as fast
> for these in practice? That would need checking.
> 
> But I also took a fresh look just now and didn't remember we had so many
> different cases there, and that msize is no longer really used -- now
> this is just a gut feeling, but I think we'd benefit from rounding up to
> some pooled sizes e.g. I assume it'll be faster to allocate 1MB from the
> cache three times than try to get 500k/600k/1MB from kmalloc.
> 
> That's a lot of assuming though and this is going to need checking...

Yeah, that's the reason why omitted this aspect so far, because I also thought 
it deserves actual benchmarking how much cache granularity really makes sense, 
instead of blindly subdividing them into random separate cache size 
categories.

> > Hoo, Dominique, please hold your horses. I currently can't keep up with
> > reviewing and testing all pending 9p patches right now.
> > 
> > Personally I would hold these patches back for now. They would make sense
> > on current situation on master, because ATM basically all 9p requests
> > simply allocate exactly 'msize' for any 9p request.
> 
> So I think they're orthogonal really:
> what mempool does is that it'll reserve the minimum amount of memory
> required for x allocations (whatever min is set during init, so here 4
> parallel RPCs) -- if normal allocation goes through it'll go through
> normal slab allocation first, and if that fails we'll get a buffer from
> the pool instead, and if there is none left it'll wait for a previous
> request to be freed up possibly throttling the number of parallel
> requests down but never failing like we currently do.

Understood.

> With this the worst that can happen is some RPCs will be delayed, and
> the patch already falls back to allocating a msize buffer from pool even
> if less is requrested if that kmalloc failed, so I think it should work
> out ok as a first iteration.
> 
> (I appreciate the need for testing, but this feels much less risky than
> the iovec series we've had recently... Famous last words?)

Got it, consider my famous last words dropped. ;-)

> For later iterations we might want to optimize with multiple sizes of
> pools and pick the closest majoring size or something, but I think
> that'll be tricky to get right so I'd rather not rush such an
> optimization.
> 
> > How about I address the already discussed issues and post a v5 of those
> > patches this week and then we can continue from there?
> 
> I would have been happy to rebase your patches 9..12 on top of Kent's
> this weekend but if you want to refresh them this week we can continue
> from there, sure.

I'll rebase them on master and address what we discussed so far. Then we'll 
see.

Best regards,
Christian Schoenebeck


