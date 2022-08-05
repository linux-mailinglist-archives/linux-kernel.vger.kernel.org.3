Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737558AAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbiHEMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHEMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF4BF29CAB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659702881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ib0O7MHSJ2oohbcHnWP0JL7pMlC2ROClT094HDqHBVs=;
        b=d0p+4/ZBcpY5OQQsZ0Wv2dFuApR/VGor4aNS6TuFQzh+e/twQUhIbqCiQ7tIivF0zTZvy/
        aqFPJkSV1dc36QekD/XYeE+BYUBkevwfsV2iaZKweEkd878PvVZ1zXm2FE3O1DL4oY/FV7
        nXe3JFOC039Pt0sKO5+U06Oo2tNXSEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-B14gVHkzPDSsh4lXrH6L_w-1; Fri, 05 Aug 2022 08:34:37 -0400
X-MC-Unique: B14gVHkzPDSsh4lXrH6L_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66A30802E5D;
        Fri,  5 Aug 2022 12:34:37 +0000 (UTC)
Received: from localhost (ovpn-12-174.pek2.redhat.com [10.72.12.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C22640CF8E4;
        Fri,  5 Aug 2022 12:34:35 +0000 (UTC)
Date:   Fri, 5 Aug 2022 20:34:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
References: <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/22 at 02:01pm, Michal Hocko wrote:
...snip...
> > > > > > > Thinking about it. We should get a warning when the actual allocation
> > > > > > > from the pool fails no? That would be more useful information than the
> > > > > > > pre-allocation failure when it is not really clear whether anybody is
> > > > > > > ever going to consume it.
> > > > > > 
> > > > > > Hi Michal,
> > > > > > 
> > > > > > You haven't told on which ARCH you met this issue, is it x86_64?
> > > > > 
> > > > > yes x86_64, so a small 16MB DMA zone.
> > > > 
> > > > Yeah, the 16M DMA zone is redicilous and exists only for hardly seen
> > > > ISA-style devices support. Haven't prepared the log well.
> > > 
> > > Agreed on that! I would essentially suggest to completely ignore pool
> > > pre-allocation failures for the small DMA zone. There is barely anything
> > > to be ever consuming it.
> > 
> > I would personally suggest to keep it. W/o that, we even don't know the
> > issue we are talking about now. I see below commit as a workaround, and
> > have been trying to fix it finally with a better solution.
> > 
> > commit c4dc63f0032c ("mm/page_alloc.c: do not warn allocation failure on zone DMA if no managed pages")
> 
> This will not help in any case but an empty DMA zone. As you can see
> this is not the case in my example.

Yeah, it's different case.

> 
> > After attempts, I realize it's time to let one zone DMA or DMA32 cover
> > the whole low 4G memory on x86_64. That's the real fix. The tiny 16M DMA
> > on 64bit system is root cause.
> 
> Yes, I would agree with that. This means DMA zone is gone completely.
>  
> [...]
> > > This also mostly papers over this particular problem by allocating
> > > allocating two pools for the same range.
> > 
> > No, it doesn't paper over anything, and isn't a hack. Zone dma now covers
> > low 4G, just zone DMA32 is empty. Any allocation request with GFP_DMA will
> > be satisfied, while request with GFP_DMA32 will fall back to zone DMA.
> 
> This is breaking expectation of the DMA zone on x86. This is not
> acceptable. You really want to do it other way around. Only have DMA32
> zone and cover the whole 32b phys address range. DMA zone would be empty
> which is something we can have already. This would make the crap HW fail
> on allocations.

OK, I will consider it in the direction that only DMA32 zone cover the
low 4G as you suggested. Do you have pointer about them? Really
appreciate it.
> 
> > See my summary about zone DMA/DMA32 on ARCHes. Currently only x86_64
> > always has this burdensome tiny DMA zone. Other ARCH has made adjustment
> > to avoid that conditionally. The way I took in above patch is similar
> > with arm64 handling.
> 
> Yeah a historical baggage we have to live with or just stop pretending
> we really do support that ISA HW. Or make that dynamic and only set up
> DMA zone when there is a HW like that present.

Ok, I see, you don't like the handling on arm64 and mips either.

> 
> > The two pools for the same range has been there on arm64 and mips, we
> > can easily fix it by introducing has_managed_dma32() and checking it
> > before allocating atomic_pool_dma32 pool, just like I have done for
> > atomic_pool_dma there.
> > 
> > =============================
> > ARCH which has DMA32
> >         ZONE_DMA       ZONE_DMA32
> > arm64   0~X            empty or X~4G  (X is got from ACPI or DT. Otherwise it's 4G by default, DMA32 is empty)
> > ia64    None           0~4G
> > mips    empty or 0~16M X~4G  (zone DMA is empty on SGI_IP22 or SGI_IP28, otherwise 16M by default like i386)
> > riscv   None           0~4G
> > x86_64  16M            16M~4G
> > =============================
> > 
> > 
> > As for the only one DMA or DMA32 zone exist on x86_64 you suggested, I
> > made below draft change which only creates zone DMA32 to cover the whole
> > low 4G meomry, just like RISC-V and ia64 are doing. It works well on
> > one intel machine, no other change is required. However, I have one
> > concern, it possibly comes from my own misunderstanding, please help
> > point out where I got it wrong. If there's only DMA32 zone, and
> > CONFIG_ZONE_DMA is disabled, how does it handle GFP_DMA allocation
> > request?
> 
> the expected behavior should be to fail the allocation.

Could you tell why we should fail the allocation?

With my understanding, whether it is allocation request with GFP_DMA
or GFP_DMA32, it's requesting memory for DMA buffer, or requesting
memory under 32bit. If we only have zone DMA32 covering low 4G, and
people requests meomry with GFP_DMA, we should try to satisfy it with
memory from zone DMA32. Because people may not know the internal detail
about memory from zone DMA or DMA32, and they just want to get a buffer
for DMA transfering.

With your saying, if there's only DMA32 existing and cover the whole low
4G, any allocation request with GFP_DMA need be failed, we need search
and change all those places where GFP_DMA is set.

> 
> > See gfp_zone(), it will return ZONE_NORMAL to user even though
> > user expects to get memory for DMA handling?
> 
> It's been quite some time since I've had gfp_zone cached in my brain. I
> suspect it would require some special casing for GFP_DMA to always fail.
> I would have to study the code again. We have discussed this at some
> LSFMM few years back. Maybe you can find something at lwn.
> 
> In any case. This is a larger change. Do you agree that the warning is
> pointless and __GFP_NOWARN is a very simple way to deal with it until we
> sort out situation of the DMA zone on x86 which is a long standing
> problem?

I understand the warning will be annoying and customer will complain
about it. We can mute it for the time being, and may open it later
when we get rid of the 16M DMA zone.

So, yes, I agree that there's nothing we can do currently except of
muting it. I can add my tag when you update and post.

