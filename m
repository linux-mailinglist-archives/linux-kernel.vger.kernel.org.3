Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF414565788
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiGDNjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGDNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:39:38 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F210A5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=ZuSDtg49kLYvNdQDHtIgVQE+CHgjZQqn81sL6zDFFkE=; b=L7MDoy5Caa1DaV9jEC4sssNR55
        vd6teVzYL4swnRjjgHtw6RdXIKMGwGGKV9X0g5ICcu2FOHBYYmb9evyQf2jVTHo62BfnElY7YOv5Z
        hk55Do48g2mG50tu+Yc2VIjn9XvbmincbH7of5a4P4VR9qbYM7AM5ofFZZNV/UzdVABFs8dh9UADf
        Wz3OY1uJAeJ4V0ffusGiksd1sdvQu8yI7jRE9lihBcSMEoYdN7xKLNlWVkfoMb+uDpbKw2V74rlhY
        eL3DYWw1psC210QO/ztoFqLFsvd6msehn44JpOqAOGDKnwoDDUP4Z8aX1kPiVpRAk3E8vwEFR/vdl
        xYY32sC0Mo7U5bKDalvzGlovKa86R+WtxmAQlMx6jcGBGbSNUZ3bKYIuKvlx/CdYBw9FfjnXhK9+N
        7S9bilgaaMkUKQSRupw34rS70Culbjuc+1d77p2c8r8IGJpAMliBRPebnTdf0ysRoIulE06TNlGst
        oLFdHEEG4kf2fhzWQFBwoGRCTRnevfFA7XscGWLEQQMKg9osuzcKpfJLHGN+S6qGmXrocoA+hssOO
        eT9TdNaqX5ybNCsBEpmSJYU1aHp0+QyfV8Mlm9ulwLsYHNd0hty7VjLdlw8aPZ6l8iqTuQgCBYj0/
        AYvbpBs7pDN8Un5lLnMuict8nUifr6bxjSeeHcRC8=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Mon, 04 Jul 2022 15:39:32 +0200
Message-ID: <1877940.0u7pHPiiHj@silver>
In-Reply-To: <20220704130631.eq5txpq62gwvbvts@moria.home.lan>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <2335194.JbyEHpbE5P@silver>
 <20220704130631.eq5txpq62gwvbvts@moria.home.lan>
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

On Montag, 4. Juli 2022 15:06:31 CEST Kent Overstreet wrote:
> On Mon, Jul 04, 2022 at 01:12:51PM +0200, Christian Schoenebeck wrote:
> > On Montag, 4. Juli 2022 05:38:46 CEST Dominique Martinet wrote:
> > > +Christian, sorry I just noticed you weren't in Ccs again --
> > > the patches are currently there if you want a look:
> > > https://evilpiepirate.org/git/bcachefs.git/log/?h=9p_mempool
> > 
> > I wonder whether it would make sense to update 9p section in MAINTAINERS
> > to
> > better reflect current reality, at least in a way such that contributors
> > would CC me right away?
> > 
> > Eric, Latchesar, what do you think?
> > 
> > > > @@ -270,10 +276,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type,
> > > > unsigned int max_size)>
> > > > 
> > > >  	if (!req)
> > > >  	
> > > >  		return ERR_PTR(-ENOMEM);
> > > > 
> > > > -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> > > > -		goto free_req;
> > > > -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> > > > -		goto free;
> > > > +	p9_fcall_init(c, &req->tc, 0, alloc_msize);
> > > > +	p9_fcall_init(c, &req->rc, 1, alloc_msize);
> > > 
> > > mempool allocation never fails, correct?
> > > 
> > > (don't think this needs a comment, just making sure here)
> > > 
> > > This all looks good to me, will queue it up in my -next branch after
> > > running some tests next weekend and hopefully submit when 5.20 opens
> > > with the code making smaller allocs more common.
> > 
> > Hoo, Dominique, please hold your horses. I currently can't keep up with
> > reviewing and testing all pending 9p patches right now.
> > 
> > Personally I would hold these patches back for now. They would make sense
> > on current situation on master, because ATM basically all 9p requests
> > simply allocate exactly 'msize' for any 9p request.
> 
> Err, why?
> 
> These patches are pretty simple, and they fix a bug that's affecting users
> right now (and has been for ages)

So simple that it already had one obvious bug (at least). But as it seems that 
Dominique already supports your patch, I refrain from enumerating more 
reasons.

> > However that's exactly what I was going to address with my already posted
> > patches (relevant patches regarding this issue here being 9..12):
> > https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> > And in the cover letter (section "STILL TODO" ... "3.") I was suggesting
> > to
> > subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size
> > categories? Because that's what my already posted patches do anyway.
> 
> Yeah that sounds like you're just reimplementing kmalloc.

Quite exaggerated statement.

Best regards,
Christian Schoenebeck


