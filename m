Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115DD57B2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiGTIV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGTIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:21:24 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CADFA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658305283; x=1689841283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DyE1S6/M8cxx8TUOX92GSOdQu0Ro177cj6dL0LTcF6U=;
  b=EzLT/G5s6g+tXOdyPGMxoZOeDnlDbU/80bGw79tchS7t1rZevNXTTmkC
   gMTdFpGmt8MkRPAHRaUUrNAIvjhss8hYJTuaBGOduAHB4OBwv002D73DW
   34yPfSODvbhtHmwr/LWINCpobpgg8EcYAR8nb2+REK6HxEK1grYe8Po3i
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 01:21:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 01:21:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 01:21:21 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 01:21:16 -0700
Date:   Wed, 20 Jul 2022 13:51:12 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>,
        <pasha.tatashin@soleen.com>, <sjpark@amazon.de>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <dhowells@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <david@redhat.com>,
        <minchan@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <20220720082112.GA14437@hu-pkondeti-hyd.qualcomm.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

On Tue, Jul 19, 2022 at 08:42:42PM +0530, Charan Teja Kalla wrote:
> Thanks Michal!!
> 
> On 7/18/2022 8:24 PM, Michal Hocko wrote:
> >>>> The above mentioned race is just one example __but the problem persists
> >>>> in the other paths too involving page_ext->flags access(eg:
> >>>> page_is_idle())__. Since offline waits till the last reference on the
> >>>> page goes down i.e. any path that took the refcount on the page can make
> >>>> the memory offline operation to wait. Eg: In the migrate_pages()
> >>>> operation, we do take the extra refcount on the pages that are under
> >>>> migration and then we do copy page_owner by accessing page_ext. For
> >>>>
> >>>> Fix those paths where offline races with page_ext access by maintaining
> >>>> synchronization with rcu lock.
> >>> Please be much more specific about the synchronization. How does RCU
> >>> actually synchronize the offlining and access? Higher level description
> >>> of all the actors would be very helpful not only for the review but also
> >>> for future readers.
> >> I will improve the commit message about this synchronization change
> >> using RCU's.
> > Thanks! The most imporant part is how the exclusion is actual achieved
> > because that is not really clear at first sight
> > 
> > CPU1					CPU2
> > lookup_page_ext(PageA)			offlining
> > 					  offline_page_ext
> > 					    __free_page_ext(addrA)
> > 					      get_entry(addrA)
> > 					      ms->page_ext = NULL
> > 					      synchronize_rcu()
> > 					      free_page_ext
> > 					        free_pages_exact (now addrA is unusable)
> > 					
> >   rcu_read_lock()
> >   entryA = get_entry(addrA)
> >     base + page_ext_size * index # an address not invalidated by the freeing path
> >   do_something(entryA)
> >   rcu_read_unlock()
> > 
> > CPU1 never checks ms->page_ext so it cannot bail out early when the
> > thing is torn down. Or maybe I am missing something. I am not familiar
> > with page_ext much.
> 
> 
> Thanks a lot for catching this Michal. You are correct that the proposed
> code from me is still racy. I Will correct this along with the proper
> commit message in the next version of this patch.
> 

Trying to understand your discussion with Michal. What part is still racy? We
do check for mem_section::page_ext and bail out early from lookup_page_ext(),
no?

Also to make this scheme explicit, we can annotate page_ext member with __rcu
and use rcu_assign_pointer() on the writer side.

struct page_ext *lookup_page_ext(const struct page *page)
{
        unsigned long pfn = page_to_pfn(page);
        struct mem_section *section = __pfn_to_section(pfn);
        /*
         * The sanity checks the page allocator does upon freeing a
         * page can reach here before the page_ext arrays are
         * allocated when feeding a range of pages to the allocator
         * for the first time during bootup or memory hotplug.
         */
        if (!section->page_ext)
                return NULL;
        return get_entry(section->page_ext, pfn);
}

Thanks,
Pavan
