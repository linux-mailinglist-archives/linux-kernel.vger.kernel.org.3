Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA1518BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiECSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiECSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:16:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FFC2A711
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:12:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r9so16013396pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dKIuxMgRzCN0s4ErL9JgFNMq2X+Ef4jnXFwKxL5k4PQ=;
        b=BvvJ/00Vit2o14459c+ji2mprazMSjL9AzgP+FRCHfTzdyqMA+OscVE6XO0vNHJ/Db
         CKUOXdT+gUJZguVJ7TqthJXUN9+RJtKZSPfbSeTNO53nHFTWJ63El0Lo6vJFUXy+PTg/
         9OE+8LDjnbQ9bkXc/SD4lj1A8M1eXBVXan41qP6PdWbxmIc3PS/dPRiPwKWg9B/amN9m
         zBGsRT9X6+v7Wpx72SReVeVLZEJ6+r+6ex4xfN0mrpi8VMGmgBq4vnbDb4b1t7T6SDs8
         W+OUgMSaeqfqXy4vOpQ0k+2veek2A2VSGlI2FwQDkZ/5P3d5wFD7dcHlgtroHCbHoBU2
         FCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dKIuxMgRzCN0s4ErL9JgFNMq2X+Ef4jnXFwKxL5k4PQ=;
        b=76aLRgprflIUl90vv814TfV8tuJNzHdrqqndoDMuQS8ISbjuy2/Dn9ttnxXyN3E9HG
         th0Y3MqCaPycyGpyi7PqvQ5nWPqPSnDVaJi9/gzAhhZZTuCvWe/8650Fn/Y0Fku9tnsz
         p89Y6gRf9MMPlP6uJiHZ5gvHBp5C3qkiKSGktFI33rrX2A7oRO13A0PCP7BDGiYBYlJb
         F7Ig+VNqf1csuxNE/SK1NnJ4o6kHtuIV+fLjdb/FyMllZB3+WulFHw4bjatIeabYpRrX
         n/pr72DukCaSfX48bizK3OAdMQadkRM3MtdSs/jNCZozBb1Xc4zDslULlOvtWelPCaFV
         8YbA==
X-Gm-Message-State: AOAM532942ds6T91DW2ZghFTxSnMa5HbGaTNhOoizPXJGtnli2yuQojO
        HvQeJNbLgNWjX4yK5uOELthGm6qYRpI=
X-Google-Smtp-Source: ABdhPJyPezVlSkQ0M3+sOvhGQESyBuSlF6MT14lYNffcAkSrqTf2tLlWGqDSld0sKSz6HAmjQUn8Vw==
X-Received: by 2002:a17:90b:17d0:b0:1dc:7697:1e92 with SMTP id me16-20020a17090b17d000b001dc76971e92mr5890518pjb.154.1651601567869;
        Tue, 03 May 2022 11:12:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8998:54e:9def:1e7c])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b0015e8d4eb2ebsm6477524plc.309.2022.05.03.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:12:47 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 May 2022 11:12:45 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnFwnToAUDBu1vKv@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnFkZmvW2thpIn8o@google.com>
 <f271ca5e-c573-1c48-35a7-b59e9f2e122e@redhat.com>
 <YnFvmc+eMoXvLCWf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFvmc+eMoXvLCWf@google.com>
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

On Tue, May 03, 2022 at 11:08:25AM -0700, Minchan Kim wrote:
< snip >

Ccing Paul really this time.

Attach original code for Paul.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..f59bbe3296e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,10 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+	int mt = get_pageblock_migratetype(page);
+
+	return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
+		mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
--
2.36.0.464.gb9c8b46e94-goog


> > >>>
> > >>> A thing to get some attention is whether we need READ_ONCE or not
> > >>> for the local variable mt.
> > >>>
> > >>
> > >> Hmm good point. Staring at __get_pfnblock_flags_mask(), I don't think
> > >> there is anything stopping the compiler from re-reading the value. But
> > >> we don't care if we're reading MIGRATE_CMA or MIGRATE_ISOLATE, not
> > >> something in between.
> > > 
> > > How about this?
> > > 
> > >      CPU A                                                      CPU B
> > > 
> > > is_pinnable_page
> > >   ..
> > >   ..                                                set_pageblock_migratetype(MIGRATE_ISOLATE)
> > >   mt == MIGRATE_CMA
> > >     get_pageblock_miratetype(page)
> > >         returns MIGRATE_ISOLATE
> > >   mt == MIGRATE_ISOLATE                             set_pageblock_migratetype(MIGRATE_CMA)
> > >     get_pageblock_miratetype(page)
> > >         returns MIGRATE_CMA
> > >  
> > > So both conditions fails to detect it.
> > 
> > I think you're right. That's nasty.
> 
> Ccing Paul to borrow expertise. :)
> 
> int mt = get_pageblock_migratetype(page);
> 
> if (mt == MIGRATE_CMA)
>   return true;
> 
> if (mt == MIGRATE_ISOLATE)
>   return true;
> 
> I'd like to keep use the local variable mt's value in folloing
> conditions checks instead of refetching the value from
> get_pageblock_migratetype.
> 
> What's the right way to achieve it?
> 
> Thanks in advance!

Paul, could you give any hint?
