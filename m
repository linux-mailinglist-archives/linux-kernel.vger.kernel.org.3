Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6046B588F06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiHCO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiHCO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47CA421E2D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659538772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IiOpIOT56UAFfF/uOz1KV/1j52LaKkbc+hyWGOtmjJw=;
        b=D+Nsd9++ixjZx1LNoF3646pNBz8ItQAy1Lpsj8+ETaIDwNpMb2o0YMx2JNAkmEVZ6wgwGr
        tzITUVe88jbh68V0pfjzbhkSxP0fzvy9HkAW+RAAH9UvryaAPlp5wl+RPzrsLW6wbB2zoz
        y32ohYW3xKLMx/kIgLAERGR4VnbewG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-fbIxTTfEP1myDzNCSqOgOQ-1; Wed, 03 Aug 2022 10:59:31 -0400
X-MC-Unique: fbIxTTfEP1myDzNCSqOgOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E759811E87;
        Wed,  3 Aug 2022 14:59:31 +0000 (UTC)
Received: from localhost (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 069331121315;
        Wed,  3 Aug 2022 14:59:29 +0000 (UTC)
Date:   Wed, 3 Aug 2022 22:59:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
References: <20220325122559.14251-1-mhocko@kernel.org>
 <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YupFSpXOrcfXJNya@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/22 at 11:52am, Michal Hocko wrote:
> On Fri 25-03-22 17:54:33, Michal Hocko wrote:
> > On Fri 25-03-22 17:48:56, Christoph Hellwig wrote:
> > > On Fri, Mar 25, 2022 at 01:58:42PM +0100, Michal Hocko wrote:
> > > > Dang, I have just realized that I have misread the boot log and it has
> > > > turned out that a674e48c5443 is covering my situation because the
> > > > allocation failure message says:
> > > >
> > > > Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:636kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > > 
> > > As in your report is from a kernel that does not have a674e48c5443
> > > yet?
> > 
> > yes. I just mixed up the early boot messages and thought that DMA zone
> > ended up with a single page. That message was saying something else
> > though.
> 
> OK, so I have another machine spewing this warning. Still on an older
> kernel but I do not think the current upstream would be any different in
> that regards. This time the DMA zone is populated and consumed from
> large part and the pool size request is just too large for it:
> 
> [   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
> [   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
> [   14.017434][    T1] Hardware name: XXXX
> [   14.017437][    T1] Call Trace:
> [   14.017444][    T1]  <TASK>
> [   14.017449][    T1]  dump_stack_lvl+0x45/0x57
> [   14.017469][    T1]  warn_alloc+0xfe/0x160
> [   14.017490][    T1]  __alloc_pages_slowpath.constprop.112+0xc27/0xc60
> [   14.017497][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017509][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017512][    T1]  __alloc_pages+0x2d5/0x320
> [   14.017517][    T1]  alloc_page_interleave+0xf/0x70
> [   14.017531][    T1]  atomic_pool_expand+0x4a/0x200
> [   14.017541][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017544][    T1]  __dma_atomic_pool_init+0x44/0x90
> [   14.017556][    T1]  dma_atomic_pool_init+0xad/0x13f
> [   14.017560][    T1]  ? __dma_atomic_pool_init+0x90/0x90
> [   14.017562][    T1]  do_one_initcall+0x41/0x200
> [   14.017581][    T1]  kernel_init_freeable+0x236/0x298
> [   14.017589][    T1]  ? rest_init+0xd0/0xd0
> [   14.017596][    T1]  kernel_init+0x16/0x120
> [   14.017599][    T1]  ret_from_fork+0x22/0x30
> [   14.017604][    T1]  </TASK>
> [...]
> [   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
> [   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
> 
> So the DMA zone has only 160kB free while the pool would like to use 4MB
> of it which obviously fails. I haven't tried to check who is consuming
> the DMA zone memory and why but this shouldn't be all that important
> because the pool clearly cannot allocate and there is not much the
> user/admin can do about that. Well, the pool could be explicitly
> requested smaller but is that really what we expect them to do?
>   
> > > > I thought there are only few pages in the managed by the DMA zone. This
> > > > is still theoretically possible so I think __GFP_NOWARN makes sense here
> > > > but it would require to change the patch description.
> > > > 
> > > > Is this really worth it?
> > > 
> > > In general I think for kernels where we need the pool and can't allocate
> > > it, a warning is very useful.  We just shouldn't spew it when there is
> > > no need for the pool to start with.
> > 
> > Well, do we have any way to find that out during early boot?
> 
> Thinking about it. We should get a warning when the actual allocation
> from the pool fails no? That would be more useful information than the
> pre-allocation failure when it is not really clear whether anybody is
> ever going to consume it.

Hi Michal,

You haven't told on which ARCH you met this issue, is it x86_64?
If yes, I have one patch queued to fix it in another way which I have
been trying to take in mind.

Thanks
Baoquan

