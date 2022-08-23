Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9559D2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiHWHuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiHWHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:50:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8717D6527F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C19E5CCE3;
        Tue, 23 Aug 2022 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661241003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tzmy0pSRA+QcMUPJOK7gtyRNCVOK3XUksuGeis4aWYQ=;
        b=ljEkiY86MjjLOgZw3r4zwArfDh9x+EugKc3nklnhxtgiyl2xRF0BGMBBzNevIlb4OuE1FO
        pqQI97UslW1TpgcxkONLllvJdX6U3FVhriy4EWb08JOb1SJkuZptQNoCH1ufhJ4cwfCVyg
        TcsSGGvuID1+pBiZj9PbJdhPvkCI9wc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EED2F13AB7;
        Tue, 23 Aug 2022 07:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xGhFOqqGBGNkRQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 Aug 2022 07:50:02 +0000
Date:   Tue, 23 Aug 2022 09:50:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-ID: <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-08-22 14:12:07, Andrew Morton wrote:
> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> 
> > The page on pcplist could be used, but not counted into memory free or
> > avaliable, and pcp_free is only showed by show_mem() for now. Since commit
> > d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> > significant decrease in the display of free memory, with a large number
> > of cpus and zones, the number of pages in the percpu list can be very
> > large, so it is better to let user to know the pcp count.
> > 
> > On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
> > maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
> > After the patch, the lists can hold 324MB. It has been observed to be 114MB
> > in the idle state after system startup in practice(increased 80 MB).
> > 
> 
> Seems reasonable.

I have asked in the previous incarnation of the patch but haven't really
received any answer[1]. Is this a _real_ problem? The absolute amount of
memory could be perceived as a lot but is this really noticeable wrt
overall memory on those systems?

Also the patch is accounting these pcp caches as free memory but that
can be misleading as this memory is not readily available for use in
general. E.g. MemAvailable is documented as:
	An estimate of how much memory is available for starting new
	applications, without swapping.
but pcp caches are drained only after direct reclaim fails which can
imply a lot of reclaim and runtime disruption.

[1] http://lkml.kernel.org/r/YwMv1A1rVNZQuuOo@dhcp22.suse.cz

> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 033f1e26d15b..f89928d3ad4e 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5853,6 +5853,26 @@ static unsigned long nr_free_zone_pages(int offset)
> >  	return sum;
> >  }
> >  
> > +static unsigned long nr_free_zone_pcplist_pages(struct zone *zone)
> > +{
> > +	unsigned long sum = 0;
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu)
> > +		sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> > +	return sum;
> > +}
> > +
> > +static unsigned long nr_free_pcplist_pages(void)
> > +{
> > +	unsigned long sum = 0;
> > +	struct zone *zone;
> > +
> > +	for_each_zone(zone)
> > +		sum += nr_free_zone_pcplist_pages(zone);
> > +	return sum;
> > +}
> 
> Prevention of races against zone/node hotplug?

Memory hotplug doesn't remove nodes nor its zones.

-- 
Michal Hocko
SUSE Labs
