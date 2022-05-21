Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1E52FECB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiEUSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiEUSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:25:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C96543E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:25:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y41so10275028pfw.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h0wJDcwRs4mXeTep4IuVQMZLPWQneg1C4iNScMcuJoI=;
        b=EnB2MD2GnrEfsaOFYP68a6RoD2AQxuP3Y0NjVpXsoFaLY9QdgcfhUumcUTJhlrr87c
         xxTazCcm6eHZnBGfE27GOOICbHpOIX4jt3mNfRPEOmH5eMKADUw1Sv4Q8x1nWoMYoNsY
         XFNIGAAjHVSCChm0n0wFvaaKt8C+OaFpQ+JuoIyiAbKjYo/pTNX14Jeb8VorxLcZam/G
         0E5G5ugzq6smA8Ngddc46NIW+d4sBFEKqUcRY9UBuceiaxJzeVnhs81r8LrqxJgXmdVq
         VENfBAtEXYYJvkAmKpIJacDOItJE6s20phWBP64SUxBa9dixjaZ3K388Vv3NnLKVRchh
         0G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h0wJDcwRs4mXeTep4IuVQMZLPWQneg1C4iNScMcuJoI=;
        b=rGQZ/uTdghgdz9d7wFsDEq/m+sQn+ZpA2B7g8bEjpEQb85C08HEh/h+DZ7cv8bySEK
         ou2hr/8W/qir0GqBJP5wJCOSuh+xgbwnJq16SQ0Rg/GTXVHVXDdo+EQqvpnu+rdLsO3E
         3jOVjlo91VnLKMNGyp2c9yXJ+7cuizK1zgNdbZIUi2cFd3Sh2Ui8TAu9+u5mO33IGQWp
         Y7SqPZe3OVOrV3+0WaCwN/ECCx3pZsSkCKWS//lNgle4ivhpZ0dZRBPVWnqdGFrUmBzo
         milu9Mxs6U/9HKnASkPqgpFzDeGpugZj6tacfe9SfOOXXFWA+df7ZwBe9B8DOCvK8CvJ
         jhTw==
X-Gm-Message-State: AOAM532cpvmz8aQMNVBz4BK+MQos+j0l7TZLTmvjJUFg7+//jgLeQIGy
        WH9IDy7SDRD3LBMfoyU2ruSZNKal4/I=
X-Google-Smtp-Source: ABdhPJyQrrZ+8SIhwCfj3TGOCDgRzsIamxuL/g0iUUnx1BAIMmFzoOfdMa2PV/xYNywoietvFXjKIQ==
X-Received: by 2002:a05:6a00:15c7:b0:510:48c9:f302 with SMTP id o7-20020a056a0015c700b0051048c9f302mr15695799pfu.23.1653157502732;
        Sat, 21 May 2022 11:25:02 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:ef57:ac0e:cc3e:9974])
        by smtp.gmail.com with ESMTPSA id r5-20020a655085000000b003f60df4a5d5sm1858737pgp.54.2022.05.21.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 11:25:02 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 21 May 2022 11:25:00 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-ID: <YokufHxnkHUk5UR6@google.com>
References: <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
 <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
 <YokEEAemXTwTSZh5@google.com>
 <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
 <YokVEZbOayed5hBb@google.com>
 <000a117a-694d-d3a9-a192-14d08d50c884@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a117a-694d-d3a9-a192-14d08d50c884@redhat.com>
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

On Sat, May 21, 2022 at 06:46:27PM +0200, David Hildenbrand wrote:

< snip >

> >> The general rules are:
> >>
> >> ZONE_MOVABLE: nobody is allowed to place unmovable allocations there; it
> >> could prevent memory offlining/unplug.
> >>
> >> CMA: nobody *but the designated owner* is allowed to place unmovable
> >> memory there; it could prevent the actual owner to allocate contiguous
> >> memory.
> > 
> > I am confused what's the meaning of designated owner and actuall owner
> > in your context.
> 
> designated==actual here. I just wanted to distinguish from someone
> current temporary owner of the page ("allocated it via a movable
> allocation") but the actual designated owner (e.g., hugetlb CMA)
> 
> The page/memory owner terminology is just confusing. Let's rephrase to:
> only the CMA area owner is allowed to place unmovable allocations there.

Yeah, the CMA area owner is much better.

> 
> > 
> > What I thought about the issue based on you explanation:
> > 
> > HugeTLB allocates its page by two types of allocation
> > 
> > 1. alloc_pages(GFP_MOVABLE)
> >  
> > It could allocate the hugetlb page from CMA area but longterm pin
> > should migrate them out of cma before the pinning so allowing
> > the pinning on the page is no problem and current code works like
> > that.
> > 
> >     check_and_migrate_movable_pages
> > 
> 
> Yes.
> 
> > 2. cma_alloc
> > 
> > The cma_alloc is used only for *gigantic page* and the hugetlbfs
> > is the very owner of the page. IOW, if the hugetlbfs was succeeded
> > to allocate the gigantic page by cma_alloc, there is no other
> > owner to be able to claim the page any longer so it's fine to
> > allow longterm pinning againt the gingantic page but current.
> > However, current code doesn't work like that due to
> > is_pinnable_page. IOW, hugetlbfs need a way to distinguish 
> > whether the page owner is hugetlbfs or not.
> > 
> > Are we on same page?
> 
> Yes, exactly. What I wanted to express is: for huge pages we have to
> make a smarter decision because there are cases where we want to
> migrate, and cases where we don't want to migrate.

Sure, maybe hugetlbfs could squeeze a bit in one of subpage of the
CMA compound page. "I am CMA allocated but allow to pinned for longterm"

Thanks.
