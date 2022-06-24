Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D22559483
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiFXID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFXIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:03:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB26B8FC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:03:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o18so1474495plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/aQkZT/+2YcvxV9aXxlZHqNRowREfHb6F3Nptk8s7o=;
        b=WhFGELdR/RtberGg47WTsERtwgZ9s5MslETlO9JE75M3s1+glUPLMpUnejl3c5px2D
         5QyuxWW2zAm2YD3ZkpOsjjoxZebMTOGuO8jIDzsg5rfrM+iLKHY70KgWdB2rLoxawTtq
         ue+RchUgEmZJ3S5t7mrddkmjodTw30lN2kFhtfiMz8qXceCH8ah+QWuxnhv3gIsiXfC4
         AAStOBtmWtU5nXN/gJPLdsCDRCb3tZtLgmcRD9SYetXjd+bf43lHYxjKS0IfZ12BSxGq
         Tm26xqgFKQBo5/jvvomJM3l11g7UMmFQhxKnDJnj9nqcFS738XZcvT9EyyN7kN6es61x
         28hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/aQkZT/+2YcvxV9aXxlZHqNRowREfHb6F3Nptk8s7o=;
        b=5sK0bPglaT/06qT4bq4MZ5hjMNxITnVhYQm3IW1O5K63YIT1XtPdi0syuPymbmquzJ
         Arv5rDnZfzqnmN8RnbOBKURh+yjaVdeVvTxm7FgWtj17oVC6bM85/s7Cv1NnQpNlpYSG
         4kadcddTtntbrYgsVV0dKAAelvuTsjnbNFfIxF9cER/2hVhUvjrOpRFSZnORfMBE8Sg6
         ZG7xc6avlss5cxMtkhWO9SC9teVlKnOt/8s46bz59YJ5IhF3pVfQc/HH2EcYg4BOfXmL
         w9RFpiL4m4BkMq6gsxaHXJobNP1xV9Dp37xb1DmCYfXjLL5kzAVhiJaln5Al3QG6NhhE
         tD3g==
X-Gm-Message-State: AJIora/tLU+gj/TZUenLN2ff/8wGrsUsOdCOl+gBTfaz9pSV7OSaEExP
        c4LJcKz2pQIjv3AM+AtQ3oeRFQ==
X-Google-Smtp-Source: AGRyM1tvcvz9tpwEpWJiZAV/av7x9hQWUyoitwq7CE0hDgBShRrgeY97PjrKG7XJAFAr/1witvlPXg==
X-Received: by 2002:a17:90b:224a:b0:1ec:d128:a82d with SMTP id hk10-20020a17090b224a00b001ecd128a82dmr2643657pjb.3.1656057826594;
        Fri, 24 Jun 2022 01:03:46 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z29-20020a63191d000000b0040c9774b332sm927606pgl.48.2022.06.24.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:03:46 -0700 (PDT)
Date:   Fri, 24 Jun 2022 16:03:42 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Message-ID: <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:25:48AM +0800, Miaohe Lin wrote:
> On 2022/6/24 7:51, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > I found a weird state of 1GB hugepage pool, caused by the following
> > procedure:
> > 
> >   - run a process reserving all free 1GB hugepages,
> >   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
> >     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
> >   - kill the reserving process.
> > 
> > , then all the hugepages are free *and* surplus at the same time.
> > 
> >   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >   3
> >   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
> >   3
> >   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
> >   0
> >   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
> >   3
> > 
> > This state is resolved by reserving and allocating the pages then
> > freeing them again, so this seems not to result in serious problem.
> > But it's a little surprizing (shrinking pool suddenly fails).
> > 
> > This behavior is caused by hstate_is_gigantic() check in
> > return_unused_surplus_pages(). This was introduced so long ago in 2008
> > by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> > it seems to me that this check is no longer unnecessary. Let's remove it.
> 
> s/unnecessary/necessary/
> 
> > 
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> >  mm/hugetlb.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a57e1be41401..c538278170a2 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2432,10 +2432,6 @@ static void return_unused_surplus_pages(struct hstate *h,
> >  	/* Uncommit the reservation */
> >  	h->resv_huge_pages -= unused_resv_pages;
> >  
> > -	/* Cannot return gigantic pages currently */
> > -	if (hstate_is_gigantic(h))
> > -		goto out;
> > -
> 
> IIUC it might be better to do the below check:
> 	/*
> 	 * Cannot return gigantic pages currently if runtime gigantic page
> 	 * allocation is not supported.
> 	 */
> 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 		goto out;
>

The change looks good to me. However, the comments above is unnecessary
since gigantic_page_runtime_supported() is straightforward.

Thanks.
 
> But I might be miss something.
> 
> Thanks.
> 
> >  	/*
> >  	 * Part (or even all) of the reservation could have been backed
> >  	 * by pre-allocated pages. Only free surplus pages.
> > 
> 
> 
