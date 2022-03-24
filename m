Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45224E5CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbiCXBhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiCXBhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:37:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8635192D28
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:36:11 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kj22so2677023qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=z23EK6bmijRWCIbIIPvtCGbQMz4T1SuXzfcC7h1UfEU=;
        b=U/iDlSVzMUIjIocEGBfq+v21Z6TfT10tE5Ey03HeWs5ZMs+4ezUhLjsgONBk7g6N+t
         dxCAqRGWH5EvY0q3ZbP6jQu0zOyqnAtA/hjHnXI+3GAX+q1ErYNHIFSmCfKJmGIYw5gs
         Pl8fuFQ24KCeNrb/Bx4xgkMhghsm+eD5E/ZzZ3cEzYEgjEaWzHjiEJIddZeVJXLL37NB
         ErS1fdg0TGKELsjU4ELRwoRj3G29qzagygZ4YNd1MWySKnE0y78jheVib7p6iDiFfazd
         GPht5op15Hn1zhaJNZC0yMtEgXflvPAEDcim//Jp9ztLmxa61ayN+1w04qPZsfuzcERX
         ZanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=z23EK6bmijRWCIbIIPvtCGbQMz4T1SuXzfcC7h1UfEU=;
        b=d+UOzHtz5J1houqm4mf5x/BcJufObjPcHNlzS3lSTVQ4UhAeLWaNCnViD9WifNoCDH
         lDiquzKBIMJrO8rxUG275olVDqAGgTu1rSb1YxZxH7rxHwWw3bxyNs6f370d1eF7h+tO
         5JmjyCxr1gwpIL7ltqHUzN81+zr7w45PXWMhaymPvATPAFjyPY/qj7ksZ1sl64Lr46CS
         xRkFrZZceWGiyGhLkasLvIxxJyFgBlfnYGSUtmcQV+niQG1Rfy0rw57qq5X0QwZthvfK
         AuylGeqguijJod6mtkS8xr8if3Nz/gXrsyVhirZUphS6xfTzk4gSirrYlKysza2GX1LT
         M/ew==
X-Gm-Message-State: AOAM530B8xhwqfJFsYZOCJM0lF5sthEAFo25+iP1GFLqHdpolgP+EI/7
        o2aKXB9JOJQMx9C9KhCaLlk=
X-Google-Smtp-Source: ABdhPJzHwl0Gnj2Twh7pxTOQ8Y73UhfXBEPugeqapQ0ovJ/sUWGw8ImAdTeiZW9hKwPBvc9C42pE9Q==
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id g4-20020a0562141cc400b0043535c3f0f1mr2521904qvd.0.1648085770715;
        Wed, 23 Mar 2022 18:36:10 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d19-20020a05622a05d300b002e1e720ddcesm1334805qtb.4.2022.03.23.18.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 18:36:10 -0700 (PDT)
Message-ID: <623bcb0a.1c69fb81.ae484.a006@mx.google.com>
X-Google-Original-Message-ID: <20220324013606.GA2347048@cgel.zte@gmail.com>
Date:   Thu, 24 Mar 2022 01:36:06 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, yang.yang29@zte.com.cn,
        dave.hansen@linux.intel.com, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v2] mm/vmstat: add events for ksm cow
References: <20220323075714.2345743-1-yang.yang29@zte.com.cn>
 <614b33de-cdf0-73d2-08e3-196363d816d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614b33de-cdf0-73d2-08e3-196363d816d2@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 07:43:04PM +0100, David Hildenbrand wrote:
> On 23.03.22 08:57, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> > to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> > get to know how much memory ksm saved by reading
> > /sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
> > of ksm cow, and this is important of some delay sensitive tasks.
> > 
> > So add ksm cow events to help users evaluate whether or how to use ksm.
> > 
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> > Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> > v2:
> > - fix compile error when CONFIG_KSM is not set
> > ---
> >  include/linux/vm_event_item.h |  2 ++
> >  mm/memory.c                   | 20 +++++++++++++++++---
> >  mm/vmstat.c                   |  2 ++
> >  3 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index 16a0a4fd000b..6f32be04212f 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -131,6 +131,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  		SWAP_RA_HIT,
> >  #ifdef CONFIG_KSM
> >  		KSM_SWPIN_COPY,
> > +		KSM_COW_SUCCESS,
> > +		KSM_COW_FAIL,
> >  #endif
> >  #endif
> >  #ifdef CONFIG_X86
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 4111f97c91a0..c24d5f04fab5 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3257,6 +3257,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  	__releases(vmf->ptl)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> > +	vm_fault_t ret = 0;
> > +	bool ksm = 0;
> >  
> >  	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> >  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -3294,6 +3296,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  	 */
> >  	if (PageAnon(vmf->page)) {
> >  		struct page *page = vmf->page;
> > +		ksm = PageKsm(page);
> >  
> >  		/*
> >  		 * We have to verify under page lock: these early checks are
> > @@ -3302,7 +3305,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  		 *
> >  		 * PageKsm() doesn't necessarily raise the page refcount.
> >  		 */
> > -		if (PageKsm(page) || page_count(page) > 3)
> > +		if (ksm || page_count(page) > 3)
> >  			goto copy;
> >  		if (!PageLRU(page))
> >  			/*
> > @@ -3316,7 +3319,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  			goto copy;
> >  		if (PageSwapCache(page))
> >  			try_to_free_swap(page);
> > -		if (PageKsm(page) || page_count(page) != 1) {
> > +		if (ksm || page_count(page) != 1) {
> 
> I think we really want to recheck here, after locking the page.
> Consequently, just do a PageKsm() check below.
> 
> >  			unlock_page(page);
> >  			goto copy;
> >  		}
> > @@ -3339,7 +3342,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  	get_page(vmf->page);
> >  
> >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > -	return wp_page_copy(vmf);
> > +	ret = wp_page_copy(vmf);
> > +
> > +#ifdef CONFIG_KSM
> > +	if (ksm) {
> > +		if (unlikely(ret & VM_FAULT_ERROR))
> > +			count_vm_event(KSM_COW_FAIL);
> > +		else
> > +			count_vm_event(KSM_COW_SUCCESS);
> > +	}
> > +#endif
> 
> Do we really care if we failed or not? I mean, the failure case will
> usually make your app crash either way ... due to OOM.
>
I think we need failed count. Because ksm cow oom is a little different
from general OOM. User may wonder I am not allocing new memory, why it
cause OOM? And OOM may have big impact for some kind of tasks, so we
better let user know that, do we?
>
> Doing
> 
> #ifdef CONFIG_KSM
> if (PageKsm(page))
> 	count_vm_event(COW_KSM);
> #endif
> 
> before the wp_page_copy(vmf) should be good enough, no?
> 
> Should be good enough IMHO.
> 
> -- 
> Thanks,
> 
> David / dhildenb
