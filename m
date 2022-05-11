Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B1523B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiEKRUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240438AbiEKRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:20:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA781FB2DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:20:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i24so2548852pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvrrCmsT4kYaIKj/5+VF7hRBFaS48EOWbufXibsxk2M=;
        b=NcY4Vwg9dDK4XWd2rf/E+ImolrfjjHnUpJ7j5YJttBqUm3aP2cHo7rmGKdjODdBolv
         zshhdYw1j6BcLLuXmEr1VplGskYl14IU5UYGI9QcVDlBWwyRNK6u7Jiae50MA5ijGUU8
         dbIv9jSeLtldO/J1LSxoN7fn1Et0Q7aDnTYXt0SvrA9b/x1bqAXfWnTtK5pgylZ5Spkn
         HZC4Mfr6UDIAhrNLkENopPbUIPGBOypIwGHKvLmCvdIiDZbIG4XkqbO0vbiWuglvwhYB
         6JoHMfJS4R5xECebL/9rVoddoZGCTARnGjNDZrCO11dF4u9/Y/PyHJQOXWPkYPVNrzl0
         NYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WvrrCmsT4kYaIKj/5+VF7hRBFaS48EOWbufXibsxk2M=;
        b=TcXsUXqrtUNxtMOL7UXUSgpYvD434DE7I+37fHWOfvsztJQEacWK5wf6/u5M9rnS8S
         UZgXf9EjTP8fvgSr9xsb/vO5liBx8R/lGRAln0OYIkqw9im3eiBKX6lDJDrz+NsC1JC1
         8Ss5tXrueWe0KlXk+QrysOyWcPBRpJ3mxiPQbXcpXRVOE9x7bquYlngm/0Q+mq40HUdV
         OFoM+JT7G8JcmXsJJHtL0kBRzveVNT2fExAJw8vEsTrI5DktgNdM8BzvA0FbhmrEwMeD
         36mH1AXN5zMs75Map+T/tNZamZ4B8YyCKvhZfQ+EJnVJ63fOX8SWU/RJ8w37N3gntH57
         OfHA==
X-Gm-Message-State: AOAM5306guk2hCXESEZ+o8xRIVcTcq2e0KCFG4LPp96s/cO4LOhkSgcX
        MZYy5Hay1tMDDMI0dqVUWjbWciKQiiE=
X-Google-Smtp-Source: ABdhPJw/tUIey7/DtkxaROD+L0I0ipkS3QnOBskNEtJEcyfjNig3z0ft8h3vD4RxBFlBLhdCV8XqCg==
X-Received: by 2002:a05:6a02:10d:b0:381:f4c8:ad26 with SMTP id bg13-20020a056a02010d00b00381f4c8ad26mr21598387pgb.135.1652289627243;
        Wed, 11 May 2022 10:20:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b00512c63bfaf0sm1127539pfa.62.2022.05.11.10.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:20:26 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 10:20:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly v2
Message-ID: <YnvwWPe+0xQA3fto@google.com>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
 <Ynk6O4WAut0Ejl7Z@google.com>
 <20220510092733.GE3441@techsingularity.net>
 <YnqrMckyHH3qvkdv@google.com>
 <20220511124700.GF3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511124700.GF3441@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:47:00PM +0100, Mel Gorman wrote:
> On Tue, May 10, 2022 at 11:13:05AM -0700, Minchan Kim wrote:
> > > Yes, but as reclaim is not fundamentally altered the main difference
> > > in behavious is that work is done inline instead of being deferred to a
> > > workqueue. That means in some cases, system CPU usage of a task will be
> > > higher because it's paying the cost directly.
> > 
> > Sure but the reclaim path is already expensive so I doubt we could
> > see the sizable measurement on the system CPU usage.
> > 
> 
> It would be difficult to distinguish from the noise.
> 
> > What I wanted to see was whether we have regression due to adding
> > spin_lock/unlock instructions in hot path. Due to squeeze it to
> > a cacheline, I expected the regression would be just marginal.
> > 
> 
> Ah, yes, I did test for this. page-fault-test hits the relevant paths
> very heavily and did show minor differences.
> 
>                                      5.18.0-rc1               5.18.0-rc1
>                                         vanilla         mm-pcpdrain-v2r1
> Hmean     faults/sec-1   886331.5718 (   0.00%)   885462.7479 (  -0.10%)
> Hmean     faults/sec-3  2337706.1583 (   0.00%)  2332130.4909 *  -0.24%*
> Hmean     faults/sec-5  2851594.2897 (   0.00%)  2844123.9307 (  -0.26%)
> Hmean     faults/sec-7  3543251.5507 (   0.00%)  3516889.0442 *  -0.74%*
> Hmean     faults/sec-8  3947098.0024 (   0.00%)  3916162.8476 *  -0.78%*
> Stddev    faults/sec-1     2302.9105 (   0.00%)     2065.0845 (  10.33%)
> Stddev    faults/sec-3     7275.2442 (   0.00%)     6033.2620 (  17.07%)
> Stddev    faults/sec-5    24726.0328 (   0.00%)    12525.1026 (  49.34%)
> Stddev    faults/sec-7     9974.2542 (   0.00%)     9543.9627 (   4.31%)
> Stddev    faults/sec-8     9468.0191 (   0.00%)     7958.2607 (  15.95%)
> CoeffVar  faults/sec-1        0.2598 (   0.00%)        0.2332 (  10.24%)
> CoeffVar  faults/sec-3        0.3112 (   0.00%)        0.2587 (  16.87%)
> CoeffVar  faults/sec-5        0.8670 (   0.00%)        0.4404 (  49.21%)
> CoeffVar  faults/sec-7        0.2815 (   0.00%)        0.2714 (   3.60%)
> CoeffVar  faults/sec-8        0.2399 (   0.00%)        0.2032 (  15.28%)
> 
> There is a small hit in the number of faults per second but it's within
> the noise and the results are more stable with the series so I'd mark it
> down as a small but potentially measurable impact.

Thanks for sharing. It would be great to have in the description, too.

> 
> > > 
> > > The workloads I used just hit reclaim directly to make sure it's
> > > functionally not broken. There is no change in page aging decisions,
> > > only timing of drains. I didn't check interference of a heavy workload
> > > interfering with a CPU-bound workload running on NOHZ CPUs as I assumed
> > > both you and Nicolas had a test case ready to use.
> > 
> > The my workload is not NOHZ CPUs but run apps under heavy memory
> > pressure so they goes to direct reclaim and be stuck on drain_all_pages
> > until work on workqueue run.
> > 
> > unit: nanosecond
> > max(dur)        avg(dur)                count(dur)
> > 166713013       487511.77786438033      1283
> > 
> > From traces, system encountered the drain_all_pages 1283 times and
> > worst case was 166ms and avg was 487us.
> > 
> > The other problem was alloc_contig_range in CMA. The PCP draining
> > takes several hundred millisecond sometimes though there is no
> > memory pressure or a few of pages to be migrated out but CPU were
> > fully booked.
> > 
> > Your patch perfectly removed those wasted time.
> > 
> 
> Those stalls are painful and it's a direct impact where a workload does
> not make progress. The NOHZ stall is different in that it's worried
> about interference. Both problems should have the same solution.
> 
> Do you mind if I quote these paragraphs in the leader to v3?

Please have it in the description.

> 
> > > Which ones are of concern?
> > > 
> > > Some of the page->lru references I left alone in the init paths simply
> > > because in those contexts, the page wasn't on a buddy or PCP list. In
> > > free_unref_page_list the page is not on the LRU, it's just been isolated
> > > from the LRU. In alloc_pages_bulk, it's not on a buddy, pcp or LRU list
> > > and is just a list placeholder so I left it alone. In
> > > free_tail_pages_check the context was a page that was likely previously
> > > on a LRU.
> > 
> > Just nits: all are list macros.
> > 
> > free_pcppages_bulk's list_last_entry should be pcp_list.
> > 
> > mark_free_pages's list_for_each_entry should be buddy_list
> > 
> > __rmqueue_pcplist's list_first_enty should be pcp_list.
> > 
> 
> Ah, you're completely correct.
> 
> > > 
> > > > since I have
> > > > tested these patchset in my workload and didn't spot any other
> > > > problems.
> > > > 
> > > 
> > > Can you describe this workload, is it available anywhere and does it
> > > require Android to execute?
> > 
> > I wrote down above. It runs on Android but I don't think it's
> > android specific issue but anyone could see such a long latency
> > from PCP draining once one of cores are monopolized by higher
> > priority processes or too many pending kworks.
> > 
> 
> Yeah, I agree it's not an Android-specific problem. It could be detected by
> tracing the time spent in drain_all_pages for any arbitrary workload. The
> BCC funclatency tool could measure it.
> 
> > > 
> > > If you have positive results, it would be appreciated if you could post
> > > them or just note in a Tested-by/Acked-by that it had a measurable impact
> > > on the reclaim/cma path.
> > 
> > Sure.
> > 
> > All patches in this series.
> > 
> > Tested-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > 
> 
> Thanks, I've added that to all the patches. I'll wait another day for
> more feedback before sending out a v3. The following is the diff between
> v2 and v3 based on your feedback.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4ac39d30ec8f..0f5a6a5b0302 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1497,7 +1497,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		do {
>  			int mt;
>  
> -			page = list_last_entry(list, struct page, lru);
> +			page = list_last_entry(list, struct page, pcp_list);
>  			mt = get_pcppage_migratetype(page);
>  
>  			/* must delete to avoid corrupting pcp list */
> @@ -3276,7 +3276,7 @@ void mark_free_pages(struct zone *zone)
>  
>  	for_each_migratetype_order(order, t) {
>  		list_for_each_entry(page,
> -				&zone->free_area[order].free_list[t], lru) {
> +				&zone->free_area[order].free_list[t], buddy_list) {
>  			unsigned long i;
>  
>  			pfn = page_to_pfn(page);
> @@ -3761,7 +3761,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  			}
>  		}
>  
> -		page = list_first_entry(list, struct page, lru);
> +		page = list_first_entry(list, struct page, pcp_list);
>  		list_del(&page->pcp_list);
>  		pcp->count -= 1 << order;
>  	} while (check_new_pcp(page, order));

Looks good to me. Please stick the my Tested-by/Acked-by.

Thanks, Mel.
