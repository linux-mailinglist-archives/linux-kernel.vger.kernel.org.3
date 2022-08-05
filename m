Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875558ADB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiHEPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHEPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C7252476
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659714741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJd5vUiMu1Gz3OoROmpTft8Oc5UhIyzSv8pitRPvQWw=;
        b=cmD1P3EVcs/WCdoNyK4kl5960uZK9Txg+Sl9dd4dyKQ7G1lLPJAwQyJf7R89XYEmoxhQ6W
        6tfsYYS23UZUiqDpv+11n9gc7BlUfyqloCkX/xryVY3UN59e0OCSHinF4En0/X2jUWybIE
        Nm/kP7IDhDfQ/kGPpy5N34T3HavYtqM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-tMfgCsr5P4CS20nfcYExow-1; Fri, 05 Aug 2022 11:52:20 -0400
X-MC-Unique: tMfgCsr5P4CS20nfcYExow-1
Received: by mail-qt1-f200.google.com with SMTP id u12-20020a05622a17cc00b0031ede432916so2188043qtk.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XJd5vUiMu1Gz3OoROmpTft8Oc5UhIyzSv8pitRPvQWw=;
        b=BFiBjV6vI96XxFO0QjHuYeknXVPIwtDmsWWHNgaTt3vGtV61hKT5V+sw6Y5LYRhkh/
         Hm2Vj+8IgU9tVyWWb828AeaOvT0e1ZYvQVYvlClrQhePZ+NxPFs5vsrIuywNBzcAC0pO
         BknEHKTt/czlxv5Ynq1WxdmayGg3oWHvwTYWR4diD6FjvSCw+PlO4wSRO7bPNKj8VROT
         OrruZJ3G8JkSxmiC/1APaOHMI1IT8rR5qX+GBomB1Y/4bkXuJRpPYvLWpQZ22EF6UsV/
         8GVGcwVsRvBC6YVtPlfCmBFK5DiCojQ5bDTEVtfsIdpTtHLGrE1itTHJtepAr4kLCK9Q
         EUKw==
X-Gm-Message-State: ACgBeo2uYsQuzjH+mb1Fb4DKNkokg15SZhJBC/xjrfQ9F70KxWA2PtLK
        BlA/0CBvauFavE7gSQCmCv4vX/EkYTv61fQOrp9GLV8OFnk77c+jZ/cw6xXfTk+sKTGB8bcYjZb
        8o1Azm9D7pqj5W5+kQeK7mr/K
X-Received: by 2002:a05:620a:29ce:b0:6a7:1379:62d4 with SMTP id s14-20020a05620a29ce00b006a7137962d4mr5775583qkp.604.1659714740347;
        Fri, 05 Aug 2022 08:52:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5JFGGRynPG//0bT7lkXw3mUchQmJr4xYcUMTVvohUPZtgG4jRRHPvVUMuI86q1KrBB0jSOcA==
X-Received: by 2002:a05:620a:29ce:b0:6a7:1379:62d4 with SMTP id s14-20020a05620a29ce00b006a7137962d4mr5775564qkp.604.1659714740118;
        Fri, 05 Aug 2022 08:52:20 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bk4-20020a05620a1a0400b006b89a19a32dsm3074109qkb.69.2022.08.05.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:52:19 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:52:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Shi <shy828301@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
Message-ID: <Yu08snXjGZ6V94bp@xz-m1.local>
References: <20220803220329.46299-1-peterx@redhat.com>
 <20220804154050.e6ab9f8c38e2445acc5b57b1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804154050.e6ab9f8c38e2445acc5b57b1@linux-foundation.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:40:50PM -0700, Andrew Morton wrote:
> On Wed,  3 Aug 2022 18:03:29 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > These bits should only be valid when the ptes are present.  Introducing two
> > booleans for it and set it to false when !pte_present().
> 
> Please (always) describe the user visible runtime effects of the bug
> which is being fixed?

Will do in the future.

For this specific one I'll add some more details:

  The bug is found during code reading and no real world issue reported,
  but logically such an error can cause incorrect readings for either smaps
  or smaps_rollup output on quite a few fields.

  For example, it could cause over-estimate on values like Shared_Dirty,
  Private_Dirty, Referenced; or it could also cause under-estimate on
  values like LazyFree, Shared_Clean, Private_Clean.

Meanwhile I think I overlooked the pmd handling which seems to have the
same issue but done in another commit..  Will repost soon.

Thanks,

> 
> 
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> >  	struct vm_area_struct *vma = walk->vma;
> >  	bool locked = !!(vma->vm_flags & VM_LOCKED);
> >  	struct page *page = NULL;
> > -	bool migration = false;
> > +	bool migration = false, young = false, dirty = false;
> >  
> >  	if (pte_present(*pte)) {
> >  		page = vm_normal_page(vma, addr, *pte);
> > +		young = pte_young(*pte);
> > +		dirty = pte_dirty(*pte);
> >  	} else if (is_swap_pte(*pte)) {
> >  		swp_entry_t swpent = pte_to_swp_entry(*pte);
> >  
> > @@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> >  	if (!page)
> >  		return;
> >  
> > -	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
> > -		      locked, migration);
> > +	smaps_account(mss, page, false, young, dirty, locked, migration);
> >  }
> >  
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -- 
> > 2.32.0
> 

-- 
Peter Xu

