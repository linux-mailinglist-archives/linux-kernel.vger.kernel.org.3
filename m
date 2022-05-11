Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2C52410B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349348AbiEKX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349327AbiEKX2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:28:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF82E1F15B2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:28:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so3229036pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wE4fM5nUVTqmCaQXZXpkbCTeK+S09eBBfW0cqX/Y51o=;
        b=brQstMvvcVFVEOo7KS1GQjsrPzJKSSMUIv8IJ6jrjVfyKj6in5WrTNF3lzQFg2y6Wi
         a44TJXIeuy5CLKYJAI80ISkbM5pXFjt19COwyCysbPRExE6la0Hax22Pi87Nd2Hf/AnX
         HkXNj5aMYNujgLAbHL8jbcpRsJ95wrz0PEwnb086b7x2njW78b/yWJItesR/1WxYrzGy
         nVQiCOb0ppp0nIVaTxstVk00lcy/O9JbUffqXll8YFKx+EaInMQzy9Iittv1cb5ANHQk
         d5BLkn5n9Z8Eikajk8T1JOEuR6oxi7zizVjIQAoAEhlczm7XGK2UczP0fmBV2KRcSBL3
         Rwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wE4fM5nUVTqmCaQXZXpkbCTeK+S09eBBfW0cqX/Y51o=;
        b=xopgJb6OroG4x91U4HXnyIhwN0rOx8vnoCK4Gpwq1P2HIKnXeOsH3FGztbKOSbd09l
         3rzkKGcgFVCuqH7g9SwVhTH7KeA2Nv/WL/lC6AQYKg+iH3TWHRC0FPVneWfDhydWD6hC
         OuEJMfRBUyYgP/cMJBlfDApSPXjIw8mSTW605hOSOmyEwIO/MoKFD0cyKZL26gmGmn7q
         yLm3x/K9tpJdtXhlZyEuFlEHHSBIsbaFj5wZQT1SL+6VHU9SA1XCsJUMAYG5m4VOmg3X
         /pEySMuN7QDCpHeR7jt+vLYitoReWNbz0ls3yDCoj7x9aovgCZP2vhVYd9an+XqpQy3y
         zXJw==
X-Gm-Message-State: AOAM530p0HL2tXtyRmapmigV1sLNImSklYBg1wFOJAc8plnEa/7PvGq6
        lbitkX1Pv0LwHpm4BcpHVkg=
X-Google-Smtp-Source: ABdhPJzwqjxHOvferZVeyxYIdBt80+H2fYljXcefKzwrwfcYaMlp0arWX/ucyrB0VOQdrSrJzvgAPg==
X-Received: by 2002:a63:4b42:0:b0:3c6:3c00:2608 with SMTP id k2-20020a634b42000000b003c63c002608mr22802358pgl.231.1652311684197;
        Wed, 11 May 2022 16:28:04 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b0015e8d4eb21asm2466715plh.100.2022.05.11.16.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:28:03 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 16:28:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnxGgo9iCsnOOBHE@google.com>
References: <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <YnxDhdb4YCo19Qx0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnxDhdb4YCo19Qx0@google.com>
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

On Wed, May 11, 2022 at 04:15:17PM -0700, Minchan Kim wrote:
> On Wed, May 11, 2022 at 04:13:10PM -0700, John Hubbard wrote:
> > On 5/11/22 16:08, Minchan Kim wrote:
> > > > OK, so the code checks the wrong item each time. But the code really
> > > > only needs to know "is either _CMA or _ISOLATE set?". And so you
> > > 
> > > Yes.
> > > 
> > > > can just sidestep the entire question by writing it like this:
> > > > 
> > > > int mt = get_pageblock_migratetype(page);
> > > > 
> > > > if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
> > > > 	return false;
> > > 
> > > I am confused. Isn't it same question?
> > > 
> > >                                                      set_pageblock_migratetype(MIGRATE_ISOLATE)
> > > if (get_pageblock_migrate(page) & MIGRATE_CMA)
> > > 
> > >                                                      set_pageblock_migratetype(MIGRATE_CMA)
> > > 
> > > if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> > 
> > Well no, because the "&" operation is a single operation on the CPU, and
> > isn't going to get split up like that.
> 
> Oh, if that's true, yeah, I could live with it.
> 
> Thanks, let me post next revision with commenting about that.

This is delta to confirm before posting next revision.

Are you okay with this one?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cbf79eb790e0..7b2df6780552 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1626,14 +1626,14 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 static inline bool is_pinnable_page(struct page *page)
 {
 #ifdef CONFIG_CMA
+       int mt = get_pageblock_migratetype(page);
+
        /*
-        * use volatile to use local variable mt instead of
-        * refetching mt value.
+        * "&" operation would prevent compiler split up
+        * get_pageblock_migratetype two times for each
+        * condition check: refetching mt value two times.
         */
-       int __mt = get_pageblock_migratetype(page);
-       int mt = __READ_ONCE(__mt);
-
-       if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+       if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
                return false;
 #endif

