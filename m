Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667658AEFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiHERhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHERhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:37:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FB1EC60
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:37:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E0E55BF40;
        Fri,  5 Aug 2022 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659721037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMP2kDKbfbQJ6BZX8Kb8O2013nxbES9eYTQ7jcxrBBk=;
        b=Sf2Q62GhWFIRURhnc5pIZ7qXov0ZXsC/IfXej/lEch4ffj9yhcJ3UhUg6jsQ4szv/ys/RZ
        h0fPOGe/XqRPM3M91lR8A5NNqVULkkPmPvpbATLBOxnkPqNoOpmZnzt1yQSnTBnQnXNmXQ
        dUJNzwx4/a8Q6xcevNx7XXG+Z1KU+1E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C5B713A9C;
        Fri,  5 Aug 2022 17:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKDpF01V7WKeCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 05 Aug 2022 17:37:17 +0000
Date:   Fri, 5 Aug 2022 19:37:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
References: <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
 <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-08-22 20:34:32, Baoquan He wrote:
> On 08/04/22 at 02:01pm, Michal Hocko wrote:
> ...snip...
> > > > > > > > Thinking about it. We should get a warning when the actual allocation
> > > > > > > > from the pool fails no? That would be more useful information than the
> > > > > > > > pre-allocation failure when it is not really clear whether anybody is
> > > > > > > > ever going to consume it.
> > > > > > > 
> > > > > > > Hi Michal,
> > > > > > > 
> > > > > > > You haven't told on which ARCH you met this issue, is it x86_64?
> > > > > > 
> > > > > > yes x86_64, so a small 16MB DMA zone.
> > > > > 
> > > > > Yeah, the 16M DMA zone is redicilous and exists only for hardly seen
> > > > > ISA-style devices support. Haven't prepared the log well.
> > > > 
> > > > Agreed on that! I would essentially suggest to completely ignore pool
> > > > pre-allocation failures for the small DMA zone. There is barely anything
> > > > to be ever consuming it.
> > > 
> > > I would personally suggest to keep it. W/o that, we even don't know the
> > > issue we are talking about now. I see below commit as a workaround, and
> > > have been trying to fix it finally with a better solution.
> > > 
> > > commit c4dc63f0032c ("mm/page_alloc.c: do not warn allocation failure on zone DMA if no managed pages")
> > 
> > This will not help in any case but an empty DMA zone. As you can see
> > this is not the case in my example.
> 
> Yeah, it's different case.
> 
> > 
> > > After attempts, I realize it's time to let one zone DMA or DMA32 cover
> > > the whole low 4G memory on x86_64. That's the real fix. The tiny 16M DMA
> > > on 64bit system is root cause.
> > 
> > Yes, I would agree with that. This means DMA zone is gone completely.
> >  
> > [...]
> > > > This also mostly papers over this particular problem by allocating
> > > > allocating two pools for the same range.
> > > 
> > > No, it doesn't paper over anything, and isn't a hack. Zone dma now covers
> > > low 4G, just zone DMA32 is empty. Any allocation request with GFP_DMA will
> > > be satisfied, while request with GFP_DMA32 will fall back to zone DMA.
> > 
> > This is breaking expectation of the DMA zone on x86. This is not
> > acceptable. You really want to do it other way around. Only have DMA32
> > zone and cover the whole 32b phys address range. DMA zone would be empty
> > which is something we can have already. This would make the crap HW fail
> > on allocations.
> 
> OK, I will consider it in the direction that only DMA32 zone cover the
> low 4G as you suggested. Do you have pointer about them? Really
> appreciate it.

Not sure I understand what you are asking.

[...]

> > the expected behavior should be to fail the allocation.
> 
> Could you tell why we should fail the allocation?

If we cannot guarantee DMA (low 16MB) then the allocation should fail
otherwise any HW that really requires that address range could fail in
unpredictable way. Sure you can try harder and check whether DMA32 zone
has any pages from that range but I am not really sure this is worth it.

> With my understanding, whether it is allocation request with GFP_DMA
> or GFP_DMA32, it's requesting memory for DMA buffer, or requesting
> memory under 32bit. If we only have zone DMA32 covering low 4G, and
> people requests meomry with GFP_DMA, we should try to satisfy it with
> memory from zone DMA32. Because people may not know the internal detail
> about memory from zone DMA or DMA32, and they just want to get a buffer
> for DMA transfering.

GFP_DMA is a misnomer. It doesn't really say that the allocation should
be done for actual DMA. GFP_DMA really says allocate from ZONE_DMA. It
is my understanding that all actual DMA users should use a dedicated dma
allocation APIs which should do the right thing wrt. address constrains.

> With your saying, if there's only DMA32 existing and cover the whole low
> 4G, any allocation request with GFP_DMA need be failed, we need search
> and change all those places where GFP_DMA is set.

Yes a mass review of GFP_DMA usage is certainly due and it would have to
preceed any other changes. This is likely the reason why no unification
has happened yet.
 
> > > See gfp_zone(), it will return ZONE_NORMAL to user even though
> > > user expects to get memory for DMA handling?
> > 
> > It's been quite some time since I've had gfp_zone cached in my brain. I
> > suspect it would require some special casing for GFP_DMA to always fail.
> > I would have to study the code again. We have discussed this at some
> > LSFMM few years back. Maybe you can find something at lwn.
> > 
> > In any case. This is a larger change. Do you agree that the warning is
> > pointless and __GFP_NOWARN is a very simple way to deal with it until we
> > sort out situation of the DMA zone on x86 which is a long standing
> > problem?
> 
> I understand the warning will be annoying and customer will complain
> about it. We can mute it for the time being, and may open it later
> when we get rid of the 16M DMA zone.
> 
> So, yes, I agree that there's nothing we can do currently except of
> muting it. I can add my tag when you update and post.

Thanks. I will wait for Christoph and his comments and post a full patch
next week.

-- 
Michal Hocko
SUSE Labs
