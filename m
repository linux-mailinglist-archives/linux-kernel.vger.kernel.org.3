Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000A576374
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiGOONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGOONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:13:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3726BC37
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:13:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so2940363wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=riEJIfBpfcy57tk6eBP6zBDihsAq9M9ciWKjQSWTHns=;
        b=N3qh55mWYG1MkCB5nWXF2U09nYYX5u0cooSnIAkTzZPECYivn+J9EbY8MvkWYlRG4f
         tBIoH7tt0p+hFeC2pUWGpBDm8PQMZCj6FfsRjKUv7YPdwHiOGcj1KXm3XjPT8OlmS3hc
         n8CylkNMOmB/jU1JFjFhH1Lp+qr0vwwDTjYSFyApmCsOK670NxDDyR6ZBFs0w3wFuBUi
         pPWia79Tkl2dAqnYmtgBvXvy/TvYOLjMSlANbPpVU9j5Hrt0ULjPK1s1mIMBKKjoHn4I
         jLZgqrqt/1UYC3iWMgZJZiRIfun6txB8ymQrPrZa3ef8cHWVyYxdXq09Ju8lzcEmlTw5
         Pfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=riEJIfBpfcy57tk6eBP6zBDihsAq9M9ciWKjQSWTHns=;
        b=nSgQIiLrvU6TDqJ0IlF/k+jxPMOxyS4MwWp+ytEl1gAWn2g2kWbriHYJJSdHm0IbC3
         bGGx9xMlWhN8Kzw2ipyHqi1VihIv31OeXqe4eTvK6y3GHZ1O95VAcfhTs6te/kiwSTP3
         7MZX/b8uyp+h9eWNN5sl+kqUQy8Z7OU9jsJuTmxuKM/3A6YnXBIE6bwq0F/LpsCga7P1
         GUGmsByVBPRrg23AhjCPfrF2b8VoMtENxSxtCMVhbFGUKmUp8GCApCNNHOK4mHjcdsRZ
         YZSa7wRHftb8k/E/cc+BjWHVkFgR9+q0Uy1rbd7vYJ1CHUlJJclqAjscZjkOHa+AX2XM
         JuSA==
X-Gm-Message-State: AJIora+Dq2Unk3cFxZfNznJfK5Hv/BUOXc7vcJTXcHdViNiMQFvC8qev
        GMq6Bb77o/8eqpZIw9vcB64EUkHsIYJ+kg==
X-Google-Smtp-Source: AGRyM1v2MFrUcnY3vJQMzm0gPXoQLK1rF1PKQ5KZzsadM6EF94IHEeXLuKtzZlBXGzCTe6LSEy8v+Q==
X-Received: by 2002:a7b:c442:0:b0:3a3:bdb:e84c with SMTP id l2-20020a7bc442000000b003a30bdbe84cmr3771592wmi.101.1657894397744;
        Fri, 15 Jul 2022 07:13:17 -0700 (PDT)
Received: from C02FT09GML7L ([2a01:4b00:8019:4b00:1b0:435a:f49:c81])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c425500b003a2cf5eb900sm5175095wmm.40.2022.07.15.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 07:13:17 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:13:13 +0100
From:   William Lam <william.lam@bytedance.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: include compound page count for scanning
 in pageblock isolation
Message-ID: <YtF1+bv0gPB7pqNL@C02FT09GML7L>
References: <20220711202806.22296-1-william.lam@bytedance.com>
 <874jzin30k.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jzin30k.fsf@stealth>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:23:07AM +0100, Punit Agrawal wrote:
> Hi William,
> 
> William Lam <william.lam@bytedance.com> writes:
> 
> > The number of scanned pages can be lower than the number of isolated
> > pages when isolating mirgratable or free pageblock. The metric is being
> > reported in trace event and also used in vmstat.
> >
> > This behaviour is confusing since currently the count for isolated pages
> > takes account of compound page but not for the case of scanned pages.
> > And given that the number of isolated pages(nr_taken) reported in
> > mm_compaction_isolate_template trace event is on a single-page basis,
> > the ambiguity when reporting the number of scanned pages can be removed
> > by also including compound page count.
> 
> A minor suggestion - It maybe useful to include an example trace output
> to highlight the issue.
> 

some example output from trace where it shows nr_taken can be greater
than nr_scanned:

Produced by kernel v5.19-rc6
kcompactd0-42      [001] .....  1210.268022: mm_compaction_isolate_migratepages: range=(0x107ae4 ~ 0x107c00) nr_scanned=265 nr_taken=255
[...]
kcompactd0-42      [001] .....  1210.268382: mm_compaction_isolate_freepages: range=(0x215800 ~ 0x215a00) nr_scanned=13 nr_taken=128
kcompactd0-42      [001] .....  1210.268383: mm_compaction_isolate_freepages: range=(0x215600 ~ 0x215680) nr_scanned=1 nr_taken=128

mm_compaction_isolate_migratepages does not seem to have this behaviour,
but for the reason of consistency, nr_scanned should also be taken care
of in that side.

> >
> > Signed-off-by: William Lam <william.lam@bytedance.com>
> > ---
> >  mm/compaction.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 1f89b969c12b..1b51cf2d32b6 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -616,6 +616,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  			break;
> >  		set_page_private(page, order);
> >  
> > +		nr_scanned += isolated - 1;
> >  		total_isolated += isolated;
> >  		cc->nr_freepages += isolated;
> >  		list_add_tail(&page->lru, freelist);
> > @@ -1101,6 +1102,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >  isolate_success_no_list:
> >  		cc->nr_migratepages += compound_nr(page);
> >  		nr_isolated += compound_nr(page);
> > +		nr_scanned += compound_nr(page) - 1;
> >  
> >  		/*
> >  		 * Avoid isolating too much unless this block is being
> > @@ -1504,6 +1506,7 @@ fast_isolate_freepages(struct compact_control *cc)
> >  			if (__isolate_free_page(page, order)) {
> >  				set_page_private(page, order);
> >  				nr_isolated = 1 << order;
> > +				nr_scanned += nr_isolated - 1;
> >  				cc->nr_freepages += nr_isolated;
> >  				list_add_tail(&page->lru, &cc->freepages);
> >  				count_compact_events(COMPACTISOLATED, nr_isolated);
> 
> Regardless of the comment above -
> 
> Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
