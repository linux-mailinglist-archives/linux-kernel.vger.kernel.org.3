Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942855CA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbiF1Hvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbiF1Hvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:51:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397415FA4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:51:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so11835081pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RhhCdMFrXOyVbwNBJwgIj8iug7DrXKo78fkP+yWV9/Y=;
        b=gNGWT7I/yicYXCuI8JsWYEsjD5pkk40Sis6n7zlNSKTMPY6uP+0sWPxoqVF87OBm18
         4zrBQY/CiElcwAHTMbdDXoRLmbpA8JKax2J80daqZE/dHsYqLSR3WO0mS6sRGT7UFvS5
         GCcQPmMpA17XM0cUC97U/99r5pTd2AOqvP0XWjzAiETD76iA7AVnC/QmgTc/+R5zrs/X
         WjzFlMxclE5rOuIT8EngiMjHmg/tZQgKW9W7O+2KgoCetgyEakO9kxhnUgK7DyGH4sCm
         A7xRgtNof13SCfH/GKZFuyc1256XKjSijA1gtdKxi19qn7iw5LODQVtC6Vek5zHazRV3
         GolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RhhCdMFrXOyVbwNBJwgIj8iug7DrXKo78fkP+yWV9/Y=;
        b=fWuFBu45GlKanVDq5feahxzuYEy58QcShn6N5TGASeMtrztVwvjB49vLWQsKaKUAch
         KIUyFXB3og1RwEFSTyiD5YynLel74al7LeuSC7vObvzzWfCWdwS3b38G71KbWSiRzrSZ
         E/fSXrADSFIsiPWmHFGWuJ2967I/Y5pj5/KpL8bGWAcDUD5JpcaS8//MMfopNxlqXbB0
         h3aTKFkywQMRJ+4dIDHR+rrL/fayuWQ7DRb2sSWV2F8auVJl51XE4330RUK9hjgndTCS
         q/CyH+k4PpJZ8wom4z0FbDCJgGQ5Xtgvy1l3sgeNEYm0kIUnjX/c3gg1vZGmceiX+a2n
         naTA==
X-Gm-Message-State: AJIora+RMwKFw9MhIHs9LptmILYwIXj8IDD7PzOnxK6Tqn515TRaRPYJ
        N3ME27ZuRRuxfzyyJNO0XO/26A==
X-Google-Smtp-Source: AGRyM1s3qmyNDto++Gr3Fy/7D8TVYkU1wgwQuJxpKLKL5jqQPKzt6PVj7JkIdCUxbU+U7ObngKiNag==
X-Received: by 2002:a17:902:b597:b0:168:d8ce:4a63 with SMTP id a23-20020a170902b59700b00168d8ce4a63mr2409460pls.57.1656402698689;
        Tue, 28 Jun 2022 00:51:38 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b0016636256970sm8568952plb.167.2022.06.28.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:51:38 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:51:33 +0800
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
Message-ID: <YrqzBcD2zoAa4vVB@FVFYT0MHHV2J.usts.net>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
 <Yrl3qT3V6s9pLuvr@FVFYT0MHHV2J.usts.net>
 <20220628024121.GF2159330@hori.linux.bs1.fc.nec.co.jp>
 <YrqfJ5wHXIEdu4BM@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrqfJ5wHXIEdu4BM@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:26:47PM +0800, Muchun Song wrote:
> On Tue, Jun 28, 2022 at 02:41:22AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Mon, Jun 27, 2022 at 05:26:01PM +0800, Muchun Song wrote:
> > > On Fri, Jun 24, 2022 at 08:51:48AM +0900, Naoya Horiguchi wrote:
> > > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > 
> > > > When handling memory error on a hugetlb page, the error handler tries to
> > > > dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> > > > PageHWPoison flag is moved to the raw error page, so that's all right.
> > > > However, dissolve sometimes fails, then the error page is left as
> > > > hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
> > > > healthy pages, but that's not possible now because the information about
> > > > where the raw error pages is lost.
> > > > 
> > > > Use the private field of a few tail pages to keep that information.  The
> > > > code path of shrinking hugepage pool uses this info to try delayed dissolve.
> > > > In order to remember multiple errors in a hugepage, a singly-linked list
> > > > originated from SUBPAGE_INDEX_HWPOISON-th tail page is constructed.  Only
> > > > simple operations (adding an entry or clearing all) are required and the
> > > > list is assumed not to be very long, so this simple data structure should
> > > > be enough.
> > > > 
> > > > If we failed to save raw error info, the hwpoison hugepage has errors on
> > > > unknown subpage, then this new saving mechanism does not work any more,
> > > > so disable saving new raw error info and freeing hwpoison hugepages.
> > > > 
> > > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > 
> > > Thanks for your work on this. I have several quesions below.
> > > 
> > ...
> > 
> > > > @@ -1499,6 +1499,97 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > +/*
> > > > + * Struct raw_hwp_page represents information about "raw error page",
> > > > + * constructing singly linked list originated from ->private field of
> > > > + * SUBPAGE_INDEX_HWPOISON-th tail page.
> > > > + */
> > > > +struct raw_hwp_page {
> > > > +	struct llist_node node;
> > > > +	struct page *page;
> > > > +};
> > > > +
> > > > +static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
> > > > +{
> > > > +	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
> > > > +}
> > > > +
> > > > +static inline int raw_hwp_unreliable(struct page *hpage)
> > > > +{
> > > > +	return page_private(hpage + SUBPAGE_INDEX_HWPOISON_UNRELIABLE);
> > > > +}
> > > > +
> > > > +static inline void set_raw_hwp_unreliable(struct page *hpage)
> > > > +{
> > > > +	set_page_private(hpage + SUBPAGE_INDEX_HWPOISON_UNRELIABLE, 1);
> > > > +}
> > > 
> > > Why not use HPAGEFLAG(HwpoisonUnreliable, hwpoison_unreliable) directly?
> > > 
> > 
> > OK, that sounds better, I'll do it.
> > 
> > > > +
> > > > +/*
> > > > + * about race consideration
> > > > + */
> > > > +static inline int hugetlb_set_page_hwpoison(struct page *hpage,
> > > > +					struct page *page)
> > > > +{
> > > > +	struct llist_head *head;
> > > > +	struct raw_hwp_page *raw_hwp;
> > > > +	struct llist_node *t, *tnode;
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Once the hwpoison hugepage has lost reliable raw error info,
> > > > +	 * there is little mean to keep additional error info precisely,
> > > > +	 * so skip to add additional raw error info.
> > > > +	 */
> > > > +	if (raw_hwp_unreliable(hpage))
> > > > +		return -EHWPOISON;
> > > > +	head = raw_hwp_list_head(hpage);
> > > > +	llist_for_each_safe(tnode, t, head->first) {
> > > > +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> > > > +
> > > > +		if (p->page == page)
> > > > +			return -EHWPOISON;
> > > > +	}
> > > > +
> > > > +	ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
> > > > +	/* the first error event will be counted in action_result(). */
> > > > +	if (ret)
> > > > +		num_poisoned_pages_inc();
> > > > +
> > > > +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_KERNEL);
> > > 
> > > This function can be called in atomic context, GFP_ATOMIC should be used
> > > here.
> > 
> > OK, I'll use GFP_ATOMIC.
> > 
> > > 
> > > > +	if (raw_hwp) {
> > > > +		raw_hwp->page = page;
> > > > +		llist_add(&raw_hwp->node, head);
> > > 
> > > The maximum amount of items in the list is one, right?
> > 
> > The maximum is the number of subpages in the hugepage (512 for 2MB hugepage,
> > 262144 for 1GB hugepage).
> >
> 
> You are right. I have missed something yesterday.
>  
> > > 
> > > > +	} else {
> > > > +		/*
> > > > +		 * Failed to save raw error info.  We no longer trace all
> > > > +		 * hwpoisoned subpages, and we need refuse to free/dissolve
> > > > +		 * this hwpoisoned hugepage.
> > > > +		 */
> > > > +		set_raw_hwp_unreliable(hpage);
> > > > +		return ret;
> > > > +	}
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +inline int hugetlb_clear_page_hwpoison(struct page *hpage)
> > > > +{
> > > > +	struct llist_head *head;
> > > > +	struct llist_node *t, *tnode;
> > > > +
> > > > +	if (raw_hwp_unreliable(hpage))
> > > > +		return -EBUSY;
> > > 
> > > IIUC, we use head page's PageHWPoison to synchronize hugetlb_clear_page_hwpoison()
> > > and hugetlb_set_page_hwpoison(), right? If so, who can set hwp_unreliable here?
> > 
> > Sorry if I might miss your point, but raw_hwp_unreliable is set when
> > allocating raw_hwp_page failed.  hugetlb_set_page_hwpoison() can be called
> 
> Sorry. I have missed this. Thanks for your clarification.
> 
> > multiple times on a hugepage and if one of the calls fails, the hwpoisoned
> > hugepage becomes unreliable.
> > 
> > BTW, as you pointed out above, if we switch to passing GFP_ATOMIC to kmalloc(),
> > the kmalloc() never fails, so we no longer have to implement this unreliable
> 
> No. kmalloc() with GFP_ATOMIC can fail unless I miss something important.
> 
> > flag, so things get simpler.
> > 
> > > 
> > > > +	ClearPageHWPoison(hpage);
> > > > +	head = raw_hwp_list_head(hpage);
> > > > +	llist_for_each_safe(tnode, t, head->first) {
> > > 
> > > Is it possible that a new item is added hugetlb_set_page_hwpoison()  and we do not
> > > traverse it (we have cleared page's PageHWPoison)? Then we ignored a real hwpoison
> > > page, right?
> > 
> > Maybe you are mentioning the race like below. Yes, that's possible.
> >
> 
> Sorry, ignore my previous comments, I'm thinking something wrong.
> 
> >   CPU 0                            CPU 1
> > 
> >                                    free_huge_page
> >                                      lock hugetlb_lock
> >                                      ClearHPageMigratable
> 				       remove_hugetlb_page()
> 				       // the page is non-HugeTLB now
> >                                      unlock hugetlb_lock
> >   get_huge_page_for_hwpoison
> >     lock hugetlb_lock
> >     __get_huge_page_for_hwpoison
> 
> 	// cannot reach here since it is not a HugeTLB page now.
> 	// So this race is impossible. Then we fallback to normal
> 	// page handling. Seems there is a new issue here.
> 	//
> 	// memory_failure()
> 	//	try_memory_failure_hugetlb()
> 	//	if (hugetlb)
> 	//		goto unlock_mutex;
> 	//	if (TestSetPageHWPoison(p)) {
> 	//	// This non-HugeTLB page's vmemmap is still optimized.
> 	
> Setting COMPOUND_PAGE_DTOR after hugetlb_vmemmap_restore() might fix this
                                               ^^^
                                I mean hugetlb_vmemmap_alloc().

> issue, but we will encounter this race as you mentioned below.
> 
> Thanks.
> 	
> >       hugetlb_set_page_hwpoison
> >         allocate raw_hwp_page
> >         TestSetPageHWPoison
> >                                      update_and_free_page
> >                                        __update_and_free_page
> >                                          if (PageHWPoison)
> >                                            hugetlb_clear_page_hwpoison
> >                                              TestClearPageHWPoison
> >                                              // remove all list items
> >         llist_add
> >     unlock hugetlb_lock
> > 
> > 
> > The end result seems not critical (leaking raced raw_hwp_page?), but
> > we need fix.
> > 
> > > 
> > > > +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> > > > +
> > > > +		SetPageHWPoison(p->page);
> > > > +		kfree(p);
> > > > +	}
> > > > +	llist_del_all(head);
> > > 
> > > If the above issue exists, moving ClearPageHWPoison(hpage) to here could
> > > fix it. We should clear PageHWPoison carefully since the head page is
> > > also can be poisoned.
> > 
> > The reason why I put ClearPageHWPoison(hpage) before llist_for_each_safe()
> > was that raw error page can be the head page.  But this can be solved
> > with some additional code to remember whether raw_hwp_page list has an item
> > associated with the head page.
> >
> > Or another approach in my mind now is to call hugetlb_clear_page_hwpoison()
> > with taking mf_mutex.
> > 
> > > 
> > > Thanks.
> > 
> > Thank you for valuable feedbacks.
> > 
> > - Naoya Horiguchi
> > 
> > > 
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Called from hugetlb code with hugetlb_lock held.
> > > >   *
> > > > @@ -1533,7 +1624,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> > > >  		goto out;
> > > >  	}
> > > >  
> > > > -	if (TestSetPageHWPoison(head)) {
> > > > +	if (hugetlb_set_page_hwpoison(head, page)) {
> > > >  		ret = -EHWPOISON;
> > > >  		goto out;
> > > >  	}
> > > > @@ -1585,7 +1676,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
> > > >  	lock_page(head);
> > > >  
> > > >  	if (hwpoison_filter(p)) {
> > > > -		ClearPageHWPoison(head);
> > > > +		hugetlb_clear_page_hwpoison(head);
> > > >  		res = -EOPNOTSUPP;
> > > >  		goto out;
> > > >  	}
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 
> 
