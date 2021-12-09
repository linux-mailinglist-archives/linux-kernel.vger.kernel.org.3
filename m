Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3C46E90F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhLIN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhLIN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639056216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oed7lLRL08D6q6NEjF2RyvqepJmm1wTl9PlhyX8qLd0=;
        b=g/JzvfFzdfz/tBRn8GHGwF6zComZnAL1F8JHc3Km0xr2Ikbw0ipjKlxxCr1TCOnyOggwEh
        oCXzMUyPoYdlan+fl692u/6ZpA+j1MhfojFJGyZ3nq9UZWwRa4AnoepSS0LwhhuIqWxI7r
        oWjaRbkhBiehTlPB9GRBYO6uMkIgF+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-Viiw5QZjPaqyCXaTk-Le8A-1; Thu, 09 Dec 2021 08:23:31 -0500
X-MC-Unique: Viiw5QZjPaqyCXaTk-Le8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F94801B31;
        Thu,  9 Dec 2021 13:23:28 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A7719D9D;
        Thu,  9 Dec 2021 13:23:17 +0000 (UTC)
Date:   Thu, 9 Dec 2021 21:23:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Message-ID: <20211209132314.GC3050@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
 <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
 <20211209130210.GB3050@MiWiFi-R3L-srv>
 <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/21 at 02:10pm, David Hildenbrand wrote:
......
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index c5952749ad40..ac0ea42a4e5f 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
> >>>  	spin_unlock_irqrestore(&zone->lock, flags);
> >>>  	return ret;
> >>>  }
> >>> +
> >>> +bool has_managed_dma(void)
> >>> +{
> >>> +	struct zone *zone;
> >>> +
> >>> +	for_each_managed_zone(zone) {
> >>> +		if (zone_is_dma(zone))
> >>> +			return true;
> >>> +	}
> >>> +	return false;
> >>> +}
> >>
> >> Wouldn't it be "easier/faster" to just iterate online nodes and directly
> >> obtain the ZONE_DMA, checking if there are managed pages?
> > 
> > Thanks, Dave.
> > 
> > Please check for_each_managed_zone(), it is iterating online nodes and
> > it's each managed zone. 
> > 
> > Is below what you are suggesting? The only difference is I introduced
> > for_each_managed_zone() which can be reused later if needed. Not sure if
> > I got your suggestion correctly.
> > 
> > bool has_managed_dma(void)
> > {
> >         struct pglist_data *pgdat;
> >         struct zone *zone;
> >         enum zone_type i, j;
> > 
> >         for_each_online_pgdat(pgdat) {
> >                 for (i = 0; i < MAX_NR_ZONES - 1; i++) {          
> >                         struct zone *zone = &pgdat->node_zones[i];
> >                         if (zone_is_dma(zone))                                                                                                    
> >                                 return true;
> >                 }
> >         }
> >         return false;
> > 
> > }
> 
> 
> Even simpler, no need to iterate over zones at all, only over nodes:
> 
> #ifdef CONFIG_ZONE_DMA
> bool has_managed_dma(void)
> {
> 	struct pglist_data *pgdat;
> 
> 	for_each_online_pgdat(pgdat) {
> 		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
> 
> 		if (managed_zone(zone)
> 			return true;
> 	}
> 	return false;
> }
> #endif /* CONFIG_ZONE_DMA */
> 
> Without CONFIG_ZONE_DMA, simply provide a dummy in the header that
> returns false.

Yeah, it only iterates the number of nodes times. I will take this in
v3. Thanks, David.

