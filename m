Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2155746E8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhLINGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233267AbhLINGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639054963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UP4nzdzXQnGWZmCcFZX+JugsVQelS/63DjQeD65Ya8=;
        b=IihG1CaZ5yi4IBLbDuSLBVjZvyHKyRxuHXu+7MuCamXIBed9jdtHJUg5JeQm8BiZfFtdGF
        Gu+h6CY2bKp/JtA8HDXQmBCycK/0l4ma1dbmlf9sFfvTDptZTAaxGob4cmbVs3sELBvtpX
        tBf9a0E9VZK1n34ViSbiPT5bQD1sSH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-v2AeLTDrPKK_kDEjnRtj-w-1; Thu, 09 Dec 2021 08:02:42 -0500
X-MC-Unique: v2AeLTDrPKK_kDEjnRtj-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D846123C;
        Thu,  9 Dec 2021 13:02:39 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2D35E272;
        Thu,  9 Dec 2021 13:02:12 +0000 (UTC)
Date:   Thu, 9 Dec 2021 21:02:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Message-ID: <20211209130210.GB3050@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
 <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/21 at 12:23pm, David Hildenbrand wrote:
> On 07.12.21 04:07, Baoquan He wrote:
> > In some places of the current kernel, it assumes that dma zone must have
> > managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> > E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> > at very early stage of boot, so that there's no managed pages at all in
> > DMA zone. This exception will always cause page allocation failure if page
> > is requested from DMA zone.
> > 
> > Here add function has_managed_dma() and the relevant helper functions to
> > check if there's DMA zone with managed pages. It will be used in later
> > patches.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/mmzone.h | 21 +++++++++++++++++++++
> >  mm/page_alloc.c        | 11 +++++++++++
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 58e744b78c2c..82d23e13e0e5 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_ZONE_DMA
> > +static inline bool zone_is_dma(struct zone *zone)
> > +{
> > +	return zone_idx(zone) == ZONE_DMA;
> > +}
> > +#else
> > +static inline bool zone_is_dma(struct zone *zone)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  /*
> >   * Returns true if a zone has pages managed by the buddy allocator.
> >   * All the reclaim decisions have to use this function rather than
> > @@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
> >  #endif
> >  }
> >  
> > +bool has_managed_dma(void);
> >  /**
> >   * is_highmem - helper function to quickly check if a struct zone is a
> >   *              highmem zone or not.  This is an attempt to keep references
> > @@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
> >  			; /* do nothing */		\
> >  		else
> >  
> > +#define for_each_managed_zone(zone)		        \
> > +	for (zone = (first_online_pgdat())->node_zones; \
> > +	     zone;					\
> > +	     zone = next_zone(zone))			\
> > +		if (!managed_zone(zone))		\
> > +			; /* do nothing */		\
> > +		else
> > +
> >  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
> >  {
> >  	return zoneref->zone;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c5952749ad40..ac0ea42a4e5f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
> >  	spin_unlock_irqrestore(&zone->lock, flags);
> >  	return ret;
> >  }
> > +
> > +bool has_managed_dma(void)
> > +{
> > +	struct zone *zone;
> > +
> > +	for_each_managed_zone(zone) {
> > +		if (zone_is_dma(zone))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> 
> Wouldn't it be "easier/faster" to just iterate online nodes and directly
> obtain the ZONE_DMA, checking if there are managed pages?

Thanks, Dave.

Please check for_each_managed_zone(), it is iterating online nodes and
it's each managed zone. 

Is below what you are suggesting? The only difference is I introduced
for_each_managed_zone() which can be reused later if needed. Not sure if
I got your suggestion correctly.

bool has_managed_dma(void)
{
        struct pglist_data *pgdat;
        struct zone *zone;
        enum zone_type i, j;

        for_each_online_pgdat(pgdat) {
                for (i = 0; i < MAX_NR_ZONES - 1; i++) {          
                        struct zone *zone = &pgdat->node_zones[i];
                        if (zone_is_dma(zone))                                                                                                    
                                return true;
                }
        }
        return false;

}

