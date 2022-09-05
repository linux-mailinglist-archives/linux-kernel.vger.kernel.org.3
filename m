Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F95ACEC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiIEJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiIEJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:26:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8A3C8D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:26:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E9C034E97;
        Mon,  5 Sep 2022 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662370002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8kMnmnEGb4e42SxoO/Da6t7aiL5oByguxcYDPvLWqc=;
        b=kuK7b0ryKFuxGuoMhxoUyORQGgCiC6SMlo9vNOEyeCmHfHSPBAdGZXbwqeBVUj/bmpmcb0
        xcdVq8PuKmDt8fqtDO5mfEBPiUhcbga0HBrv5LZTIO2SoaO2RTVMmxZy6SmufJlmzg5gE5
        NjLeQe0NWgLfxJv49RN96HONcf54TWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662370002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8kMnmnEGb4e42SxoO/Da6t7aiL5oByguxcYDPvLWqc=;
        b=OqiOjocKbpIsFjA31WBkCDhf/Wm1q28253HfVNCDZJHCPp8Smk3rRxvPxb7Mj4TpuQ2Cjb
        wgtovb1IVqwaZnDA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F8CB2C145;
        Mon,  5 Sep 2022 09:26:40 +0000 (UTC)
Date:   Mon, 5 Sep 2022 10:26:38 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        hannes@cmpxchg.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        osalvador@suse.de, surenb@google.com, rppt@kernel.org,
        charante@codeaurora.org, jsavitz@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v3 1/2] mm: Cap zone movable's min wmark to small
 value
Message-ID: <20220905092619.2533krnnx632hswc@suse.de>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-2-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220905032858.1462927-2-mawupeng1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:28:57AM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
> zone movable. However zone movable will get its min share in
> __setup_per_zone_wmarks() which does not make any sense.
> 
> And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
> don't need movable pages, so there is no need to assign min pages for zone
> movable.
> 
> Let's cap pages_min for zone movable to a small value here just link
> highmem pages.
> 

I think there is a misunderstanding why the higher zones have a watermark
and why it might be large.

It's not about a __GFP_HIGH or PF_MEMALLOC allocations because it's known
that few of those allocations may be movable. It's because high memory
allocations indirectly pin pages in lower zones. User-mapped memory allocated
from ZONE_MOVABLE still needs page table pages allocated from a lower zone
so there is a ratio between the size of ZONE_MOVABLE and lower zones
that limits the total amount of memory that can be allocated. Similarly,
file backed pages that may be allocated from ZONE_MOVABLE still requires
pages from lower memory for the inode and other associated kernel
objects that are allocated from lower zones.

The intent behind the higher zones having a large min watermark is so
that kswapd reclaims pages from there first to *potentially* release
pages from lower memory. By capping pages_min for zone_movable, there is
the potential for lower memory pressure to be higher and to reach a point
where a ZONE_MOVABLE page cannot be allocated simply because there isn't
enough low memory available. Once the lower zones are all unreclaimable
(e.g. page table pages or the movable pages are not been reclaimed to free
the associated kernel structures), the system goes OOM.

It's possible that there are safe adjustments that could be made that
would detect when there is no choice except to reclaim zone reclaimable
but it would be tricky and it's not this patch. This patch changelog states

	However zone movable will get its min share in
	__setup_per_zone_wmarks() which does not make any sense.

It makes sense, higher zones allocations indirectly pin pages in lower
zones and there is a bias in reclaim to free the higher zone pages first
on the *possibility* that lower zone pages get indirectly released later.

-- 
Mel Gorman
SUSE Labs
