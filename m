Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6B5AE811
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiIFM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbiIFM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:27:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCEA7FFAA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:23:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A2E41F9EC;
        Tue,  6 Sep 2022 12:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662466953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w88jYG1SC1kfMGHujv3S+yCLAncS2pWi2X4JA71CFvA=;
        b=s/v3dkLmpeqdj8gQ1oinBEv5gZjP5azJBEJvEJZFqeERhSdP4JmFPOchIaW17o5YUx8y4y
        BzO2Gi79ulwqQPJL3/alXByvVffAAGGQke6AWq3kVWFyv1rN2k0dJjgdk7V6e/FxlahL9b
        Jf/SPP6gV53eQTxDxr+LWoJkYuIylRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662466953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w88jYG1SC1kfMGHujv3S+yCLAncS2pWi2X4JA71CFvA=;
        b=LP4P4l4OMcApUJu9CsT6veq/r7BaW10KA+gXi3FDWGpCOCyTY2xc46TOZVLCAJEPRlZtg8
        Il2GzM5ks7URVXBg==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 74B0C2C141;
        Tue,  6 Sep 2022 12:22:30 +0000 (UTC)
Date:   Tue, 6 Sep 2022 13:22:26 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        hannes@cmpxchg.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        osalvador@suse.de, surenb@google.com, rppt@kernel.org,
        charante@codeaurora.org, jsavitz@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v3 1/2] mm: Cap zone movable's min wmark to small
 value
Message-ID: <20220906122226.ro7coxxiatvctyth@suse.de>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-2-mawupeng1@huawei.com>
 <20220905092619.2533krnnx632hswc@suse.de>
 <c69a00c8-99d5-7a55-0861-1559764bd26c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c69a00c8-99d5-7a55-0861-1559764bd26c@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:12:23PM +0800, mawupeng wrote:
> > I think there is a misunderstanding why the higher zones have a watermark
> > and why it might be large.
> > 
> > It's not about a __GFP_HIGH or PF_MEMALLOC allocations because it's known
> > that few of those allocations may be movable. It's because high memory
> > allocations indirectly pin pages in lower zones. User-mapped memory allocated
> > from ZONE_MOVABLE still needs page table pages allocated from a lower zone
> > so there is a ratio between the size of ZONE_MOVABLE and lower zones
> > that limits the total amount of memory that can be allocated. Similarly,
> > file backed pages that may be allocated from ZONE_MOVABLE still requires
> > pages from lower memory for the inode and other associated kernel
> > objects that are allocated from lower zones.
> > 
> > The intent behind the higher zones having a large min watermark is so
> > that kswapd reclaims pages from there first to *potentially* release
> > pages from lower memory. By capping pages_min for zone_movable, there is
> > the potential for lower memory pressure to be higher and to reach a point
> > where a ZONE_MOVABLE page cannot be allocated simply because there isn't
> > enough low memory available. Once the lower zones are all unreclaimable
> > (e.g. page table pages or the movable pages are not been reclaimed to free
> > the associated kernel structures), the system goes OOM.
> 
> This i do agree with you, lower zone is actually "more important" than the
> higher one.
> 

Very often yes.

> But higher min watermark for zone movable will not work since no memory
> allocation can use this reserve memory below min. Memory allocation
> with specify watermark modifier(__GFP_ATOMIC ,__GFP_HIGH ...) can use this
> in slowpath, however the standard movable memory allocation
> (gfp flag: GFP_HIGHUSER_MOVABLE) does not contain this.
> 

Then a more appropriate solution may be to alter how the gap between min
and low is calculated. That gap determines when kswapd is active but
allocations are still allowed.

> Second, lowmem_reserve_ratio is used to "reserve" memory for lower zone.
> And the second patch introduce per zone watermark_scale_factor to boost
> normal/movable zone's watermark which can trigger early kswapd for zone
> movable.
> 

The problem with the tunable is that this patch introduces a potentially
seriously problem that must then be corrected by a system administrator and
it'll be non-obvious what the root of the problem is or the solution. For
some users, they will only be able to determine is that OOM triggers
when there is plenty of free memory or kswapd is consuming a lot more
CPU than expected. They will not necessarily be able to determine that
watermark_scale_factor is the solution.

> > 
> > It's possible that there are safe adjustments that could be made that
> > would detect when there is no choice except to reclaim zone reclaimable
> > but it would be tricky and it's not this patch. This patch changelog states
> > 
> > 	However zone movable will get its min share in
> > 	__setup_per_zone_wmarks() which does not make any sense.
> > 
> > It makes sense, higher zones allocations indirectly pin pages in lower
> > zones and there is a bias in reclaim to free the higher zone pages first
> > on the *possibility* that lower zone pages get indirectly released later.
> > 
> 
> In our Test vm with 16G of mirrored memory(normal zone) and 256 of normal
> momory(Movable zone), the min share for normal zone is too few since the
> size of min watermark is calc by zone dma/normal while this will be shared
> by zones(include zone movable) based on managed pages.
> 
> Node 0, zone      DMA
>         min      39
>         low      743
>         high     1447
> Node 0, zone   Normal
>         min      180
>         low      3372
>         high     6564
> Node 1, zone  Movable
>         min      3728
>         low      69788
>         high     135848

The gap between min and low is massive so either adjust how that gap is
calculated or to avoid side-effects for other users, consider special
casing the gap for ZONE_MOVABLE with a comment explaining why it is
treated differently. To mitigate the risk further, it could be further
special cased to only apply when there is a massive ratio between
ALL_ZONES_EXCEPT_MOVABLE:ZONE_MOVABLE. Document in the changelog the
potential downside of more lowmem potentially getting pinned by MOVABLE
allocations leading to excessive kswapd activity or premature OOM.

-- 
Mel Gorman
SUSE Labs
