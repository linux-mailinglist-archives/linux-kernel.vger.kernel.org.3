Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833CB55C498
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbiF1Kh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiF1KhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:37:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AE31531
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:37:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c205so11617534pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bA/LvK4VSTipcL5wV6o8JEN/FGRXth+GfF/ix8DPlqk=;
        b=1nsW17eI0m+TEU/Df0xZQtSTzWNuPJPL+cLBH9mby00SGpNKYQRzuIOAEoEMoc+VKe
         iCAT0u1uqqmmGT4PwhCCk+O+G7OnqLCTQOTw7/mKjzMdIPZtT7TSe8vLV+dHBc16dL6X
         C4Pw5FCCR16UdzC0sWtGpp9sE9mn8xU85ECfUiu9azx1vbpEeuGGP5pJeB3i4pGHRxAc
         r4hcwChYJc+B/j/LDiDB16YmSmGUhWwh2berMI2z/BtIDEyeFfyHsYa8H/sl1mWeI0Re
         TtGn2m1sQAYM2Dpy7yReXWCYc6jBYjubil8OCQZNk797m47PzWLQqpVtvB6NLN42AsPy
         zT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bA/LvK4VSTipcL5wV6o8JEN/FGRXth+GfF/ix8DPlqk=;
        b=wPzMGHL4qumLlB1MQ68ps7w6A8V5JvTt8oj8FD8xYZxz8EuZ8bWl5UfwYU6hYlIWtQ
         MosqVK3R0pJTFFrXUmM4kFZQb1IG42YYmAx9EoH0mMQ2ZT6MMGbMY/t988ql59EZutgw
         uHcIKjcMTojub25uOxm0qvZgNdNEj0vEHI85W1GutbbQiQ9KSPB82OoJf7LX0KgrhtnV
         ptFRyCCaJg6XvpqELfzZd8fiRFEMxohTE+pq7fbzrmbyNbWgDm1DdOdzRoAiM6K2MbsQ
         ka6i0KnGyl/7XpMDCycwEL+jm34QJwL0CeX+Ybl4hNi28/1KZebQ1ETqHfililWzb4wh
         nCSg==
X-Gm-Message-State: AJIora9Tq72pKrTXxHZux6PrmKWgG/zN9W28T3aF0PvDYHqvRXEejTaR
        /wdYlzRrSxJV4/NyohSyBxhtxg==
X-Google-Smtp-Source: AGRyM1sgdtMMGgOPriW4iR/+QS0YLrSxxcIGWj1Rf59BTEslFGmjr3RopsGIwcWviAn2MFtjl1Oucg==
X-Received: by 2002:a63:1259:0:b0:40d:d290:24ef with SMTP id 25-20020a631259000000b0040dd29024efmr13117043pgs.141.1656412643393;
        Tue, 28 Jun 2022 03:37:23 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0016b865ea2d6sm2670238pla.82.2022.06.28.03.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:37:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:37:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism
 of raw error pages
Message-ID: <YrrZ3hZlqEb3rlM0@FVFYT0MHHV2J>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
 <Yrl3qT3V6s9pLuvr@FVFYT0MHHV2J.usts.net>
 <20220628024121.GF2159330@hori.linux.bs1.fc.nec.co.jp>
 <YrqfJ5wHXIEdu4BM@FVFYT0MHHV2J.usts.net>
 <20220628081754.GA2206088@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628081754.GA2206088@hori.linux.bs1.fc.nec.co.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:17:55AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 28, 2022 at 02:26:47PM +0800, Muchun Song wrote:
> > On Tue, Jun 28, 2022 at 02:41:22AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > > On Mon, Jun 27, 2022 at 05:26:01PM +0800, Muchun Song wrote:
> > > > On Fri, Jun 24, 2022 at 08:51:48AM +0900, Naoya Horiguchi wrote:
> > > > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ...
> > > > > +	} else {
> > > > > +		/*
> > > > > +		 * Failed to save raw error info.  We no longer trace all
> > > > > +		 * hwpoisoned subpages, and we need refuse to free/dissolve
> > > > > +		 * this hwpoisoned hugepage.
> > > > > +		 */
> > > > > +		set_raw_hwp_unreliable(hpage);
> > > > > +		return ret;
> > > > > +	}
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +inline int hugetlb_clear_page_hwpoison(struct page *hpage)
> > > > > +{
> > > > > +	struct llist_head *head;
> > > > > +	struct llist_node *t, *tnode;
> > > > > +
> > > > > +	if (raw_hwp_unreliable(hpage))
> > > > > +		return -EBUSY;
> > > > 
> > > > IIUC, we use head page's PageHWPoison to synchronize hugetlb_clear_page_hwpoison()
> > > > and hugetlb_set_page_hwpoison(), right? If so, who can set hwp_unreliable here?
> > > 
> > > Sorry if I might miss your point, but raw_hwp_unreliable is set when
> > > allocating raw_hwp_page failed.  hugetlb_set_page_hwpoison() can be called
> > 
> > Sorry. I have missed this. Thanks for your clarification.
> > 
> > > multiple times on a hugepage and if one of the calls fails, the hwpoisoned
> > > hugepage becomes unreliable.
> > > 
> > > BTW, as you pointed out above, if we switch to passing GFP_ATOMIC to kmalloc(),
> > > the kmalloc() never fails, so we no longer have to implement this unreliable
> > 
> > No. kmalloc() with GFP_ATOMIC can fail unless I miss something important.
> 
> OK, I've interpretted the comment about GFP_ATOMIC wrongly.
> 
>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>  * watermark is applied to allow access to "atomic reserves".
>  
> 
> > > flag, so things get simpler.
> > > 
> > > > 
> > > > > +	ClearPageHWPoison(hpage);
> > > > > +	head = raw_hwp_list_head(hpage);
> > > > > +	llist_for_each_safe(tnode, t, head->first) {
> > > > 
> > > > Is it possible that a new item is added hugetlb_set_page_hwpoison()  and we do not
> > > > traverse it (we have cleared page's PageHWPoison)? Then we ignored a real hwpoison
> > > > page, right?
> > > 
> > > Maybe you are mentioning the race like below. Yes, that's possible.
> > >
> > 
> > Sorry, ignore my previous comments, I'm thinking something wrong.
> > 
> > >   CPU 0                            CPU 1
> > > 
> > >                                    free_huge_page
> > >                                      lock hugetlb_lock
> > >                                      ClearHPageMigratable
> > 				       remove_hugetlb_page()
> > 				       // the page is non-HugeTLB now
> 
> Oh, I missed that.
> 
> > >                                      unlock hugetlb_lock
> > >   get_huge_page_for_hwpoison
> > >     lock hugetlb_lock
> > >     __get_huge_page_for_hwpoison
> > 
> > 	// cannot reach here since it is not a HugeTLB page now.
> > 	// So this race is impossible. Then we fallback to normal
> > 	// page handling. Seems there is a new issue here.
> > 	//
> > 	// memory_failure()
> > 	//	try_memory_failure_hugetlb()
> > 	//	if (hugetlb)
> > 	//		goto unlock_mutex;
> > 	//	if (TestSetPageHWPoison(p)) {
> > 	//	// This non-HugeTLB page's vmemmap is still optimized.
> > 	
> > Setting COMPOUND_PAGE_DTOR after hugetlb_vmemmap_restore() might fix this
> > issue, but we will encounter this race as you mentioned below.
> 
> I don't have clear ideas about this now (I don't test vmemmap-optimized case
> yet), so I will think more about this case. Maybe memory_failure() need
> detect it because memory_failure() heaviliy depends on the status of struct
> page.
>

Because HVO (HugeTLB Vmemmap Optimization) will map all tail vmemmap pages
with read-only, we cannot write any data to some tail struct pages. It is
a new issue unrelated to this patch.

Thanks.
 
> Thanks,
> Naoya Horiguchi
> 
> > 
> > Thanks.
> > 	
> > >       hugetlb_set_page_hwpoison
> > >         allocate raw_hwp_page
> > >         TestSetPageHWPoison
> > >                                      update_and_free_page
> > >                                        __update_and_free_page
> > >                                          if (PageHWPoison)
> > >                                            hugetlb_clear_page_hwpoison
> > >                                              TestClearPageHWPoison
> > >                                              // remove all list items
> > >         llist_add
> > >     unlock hugetlb_lock
> > > 
> > > 
> > > The end result seems not critical (leaking raced raw_hwp_page?), but
> > > we need fix.
