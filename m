Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E264BCB60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 01:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiBTAkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 19:40:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBTAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:40:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D155BD2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:40:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so1875270pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tw8RZzbeX9t9efzXQPIpRkW11f9vjCrn+5xc7rNgm3I=;
        b=jcy+QNQ+y3GSI5OS6OAdyoGiwSBaSk8A0F/5b4kP86a31nh3X9W0ynEVYnMLFq32jN
         jeXsxHLMnPmdZyc6eiudjOq/4s+5BVK7qRgw5secQmayB02ERmKLPkJCTDcRaK7SjYP1
         gaqlTgzliin8LjfyccQVYLv/03CMTpE8Uh3Vgwoc7mxWFBHxoX3TB+dB4ZJPMsnOKohd
         tJcr4XpXd3m1JdeTkMLpNLQnbg0PFeQz+tOTM6hRkRuW1JQYzvs0uP2Yc7HVNs9Qt5tb
         HPeq61244eZB384qEv5GDPNHDhdE9R05c6+qb05hX9rH/lFRVwgA//Xs+p31trMYCGPV
         p3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tw8RZzbeX9t9efzXQPIpRkW11f9vjCrn+5xc7rNgm3I=;
        b=zm208B+zAdggBZnjO4X6f04rPkzSTPyUXPTEdjQgP6fOUHj9tYPab4hqVZMfWSGoms
         EbVZadWm8Oel9/Wn6V1aHKkOIYBQnBMXbOB7LTwCNAYNGAIdJU91ml7TwAClBFpbINA1
         kMzlVWGhSaR93YoMDzWfVzPpA3YvL/UbidnWJFyZXpKjQs2oBZWShXkulkXyCCFMBymQ
         a1kbRspPn9Cb5Rgo/aiKX9j3DyWX0ZnkxQF1xBzC4+Is5UcnrdBMC+E+EQIAHarLtbIx
         ZSsM3ESPxFe6ue0sISjmFz62b5WOqpJVDRmPBI2HwrDrVm4MVbO9GWKgoideLbIhrlmw
         +XAQ==
X-Gm-Message-State: AOAM5325h+ccUD1VQlyjVvgnHg58ex9vFARDCyqO2uahp0c8ozN4E6/9
        NrR1fLWVvrCJbBKRsGL/X5Y=
X-Google-Smtp-Source: ABdhPJwakSOU376iWNt62bLbZa4QyGu3LCtLZAGqtP7NNP7JpLC55aLyTAEFmhqSQArxLqD1BvU5bg==
X-Received: by 2002:a17:902:ea0a:b0:14f:206c:e3df with SMTP id s10-20020a170902ea0a00b0014f206ce3dfmr13265550plg.145.1645317617494;
        Sat, 19 Feb 2022 16:40:17 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a108:7030:d9de:a46b])
        by smtp.gmail.com with ESMTPSA id e15sm7654954pfv.104.2022.02.19.16.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 16:40:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 19 Feb 2022 16:40:14 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
Message-ID: <YhGN7nhqRMuEC5Rg@google.com>
References: <20220219174940.2570901-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219174940.2570901-1-surenb@google.com>
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

On Sat, Feb 19, 2022 at 09:49:40AM -0800, Suren Baghdasaryan wrote:
> When page allocation in direct reclaim path fails, the system will
> make one attempt to shrink per-cpu page lists and free pages from
> high alloc reserves. Draining per-cpu pages into buddy allocator can
> be a very slow operation because it's done using workqueues and the
> task in direct reclaim waits for all of them to finish before

Yes, drain_all_pages is serious slow(100ms - 150ms on Android)
especially when CPUs are fully packed. It was also spotted in CMA
allocation even when there was on no memory pressure.

> proceeding. Currently this time is not accounted as psi memory stall.

Good spot.

> 
> While testing mobile devices under extreme memory pressure, when
> allocations are failing during direct reclaim, we notices that psi
> events which would be expected in such conditions were not triggered.
> After profiling these cases it was determined that the reason for
> missing psi events was that a big chunk of time spent in direct
> reclaim is not accounted as memory stall, therefore psi would not
> reach the levels at which an event is generated. Further investigation
> revealed that the bulk of that unaccounted time was spent inside
> drain_all_pages call.
> 
> Annotate drain_all_pages and unreserve_highatomic_pageblock during
> page allocation failure in the direct reclaim path so that delays
> caused by these calls are accounted as memory stall.
> 
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..7fd0d392b39b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>  	 * Shrink them and try again
>  	 */
>  	if (!page && !drained) {
> +		unsigned long pflags;
> +
> +		psi_memstall_enter(&pflags);
>  		unreserve_highatomic_pageblock(ac, false);
>  		drain_all_pages(NULL);
> +		psi_memstall_leave(&pflags);

Instead of annotating the specific drain_all_pages, how about
moving the annotation from __perform_reclaim to
__alloc_pages_direct_reclaim?
