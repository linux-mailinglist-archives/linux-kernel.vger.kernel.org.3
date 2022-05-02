Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2B517674
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386832AbiEBS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiEBS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:26:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A616597
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:23:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 15so12268761pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soDrUCknMyVVYvPemA56PqNhiuKbCg1Of1bAYvzc04U=;
        b=oTUjwX3W6oKX63IESDbFmRou3OK04x5xQm2299xh4kb56hLaAlhHqWKqmHjkQ9s1uO
         wiIBW9rDjKFSPCo0CnXwM18i658p8tSKW5tASbbgwFbtw/XwhJqm67p8ax+nhqQRLktI
         yCs9E5sk4JbOzsRXMj1/3iVyPgMTyl074NjUksuM2nG0HM1/Lxn2PPoZ/d3MFnV7Agjs
         YjUvXkqg3jUazRc72iAh6aUOe842coqldh4mD8I64oZxhGRB5Wm0Tb/jQTQDO+L7e97J
         YW0Am1f+76DXlBdHTABOv4Q0PU+gClsSUIk9Ax9Olz3XlpA5C4CBTZwRMIYkRa337vJB
         j7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=soDrUCknMyVVYvPemA56PqNhiuKbCg1Of1bAYvzc04U=;
        b=11c5SsUWfWuxFVKlj1/qdrgdiR+/wrkthFoJ+d4ISxbpavgjlyVTpYONEh7kdU4bEp
         l+XjjQWXlZGsLFyDRKtOSazSiPMvYweJYfLxA8TfUt2tPE26MWRJDwCBdNMw9q3WhpJn
         X47oYuQCTPeMmoZf0QAzutQk/txuS1mABQJ1uI7AWO9n6G1x8pvV2VhgWN4Q2jxo36i/
         8K87PFbYU7aQ67lZfWVbzW8sufK9vIHnOMRGuPUO2y7X/91BhFSDaJHF/DTpXrYH4eKt
         o3vEo4GSfGd3YphViVvksK+j9hUSxWwI8w+a2KD9yzWJsScXxHvcw74bGbpx4y97RNL3
         1+bw==
X-Gm-Message-State: AOAM532EJyqn3N3uN5G62OEdnge6X0GpOvohBY2JBh5uP2wGCdcdZe7D
        BSjSrqDQ/qkrxMQFAeIJVlQ=
X-Google-Smtp-Source: ABdhPJz+9+THi46rJXa+pHftSq0aA4FbZmNR0Ighom5c0vLQg5T7qstU/SjJr8YZj1NwnliWCxVndg==
X-Received: by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP id q16-20020a056a00089000b004f6686ea8a9mr12290094pfj.83.1651515791589;
        Mon, 02 May 2022 11:23:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4d84:d37e:584f:bdbc])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b0015e8d4eb1ecsm4968964plj.54.2022.05.02.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:22:49 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 2 May 2022 11:22:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnAhaRNjmIhtGUjk@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
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

On Mon, May 02, 2022 at 08:02:31PM +0200, David Hildenbrand wrote:
> On 02.05.22 19:35, Minchan Kim wrote:
> > Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> > so current is_pinnable_page could miss CMA pages which has MIGRATE_
> > ISOLATE. It ends up putting CMA pages longterm pinning possible on
> > pin_user_pages APIs so CMA allocation fails.
> > 
> > The CMA allocation path protects the migration type change race
> > using zone->lock but what GUP path need to know is just whether the
> > page is on CMA area or not rather than exact type. Thus, we don't
> > need zone->lock but just checks the migratype in either of
> > (MIGRATE_ISOLATE and MIGRATE_CMA).
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/mm.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 6acca5cecbc5..f59bbe3296e3 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1625,8 +1625,10 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> >  #ifdef CONFIG_MIGRATION
> >  static inline bool is_pinnable_page(struct page *page)
> >  {
> > -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> > -		is_zero_pfn(page_to_pfn(page));
> > +	int mt = get_pageblock_migratetype(page);
> > +
> > +	return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
> > +		mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
> >  }
> >  #else
> >  static inline bool is_pinnable_page(struct page *page)
> 
> That implies that other memory ranges that are currently isolated
> (memory offlining, alloc_contig_range()) cannot be pinned. That might
> not be a bad thing, however, I think we could end up failing to pin
> something that's temporarily unmovable (due to temporary references).

Sure.

> 
> However, I assume we have the same issue right now already with
> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these

ZONE_MOVALBE is also changed dynamically?

> there are temporarily unmovable and we fail to migrate. But it would now
> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...

Didn't parse your last mention.

