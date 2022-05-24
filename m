Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC953225E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiEXFRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiEXFRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:17:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92473552
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:16:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z25so2807632pfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQCOa3IH60VXmxlz7qxuQA0xwwvIVCrbt/GEpedjsGY=;
        b=QBGQx2+Cy7tW9UqeW8jJmQslZMNcie20t35LOpCM8ZuvqWrvfO1vkTmMFXVSRqOEZs
         LE7bW0Af5q6tcuvF6B6z0KQyIz8IRXLlpeQNZEkeln6oWA5pCBL9gX8eqQmiayqao/Uo
         4CNzMTK3W7qgKlSBO1Dy8Uga2So9FKj9uaiHqBgDY8GAtoI9qv4Nk65CLgfe4TEhIi3t
         EsYdcRdIK5RAMJaPYETYeet58NfE6x9NPcEWP0AHqGHe5HDyi3eKxLCJJUTq63+OHxhc
         RUytoZt7ZLQbP7CC6gyewugxCbXmK6mTpl/9w+/NDZKUKgjwFsALar+ZG9R0xw3ZTy+s
         ysCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tQCOa3IH60VXmxlz7qxuQA0xwwvIVCrbt/GEpedjsGY=;
        b=aQ7eVBgaIFiySwIwxgg3jyCDwt7SGtIudHqfeOEguReH1J094zx4Uw5l5PMTB4p48j
         X0bCrSuuPqf/kD5iEAjZA1YoDKqZuMd/jqVyU2KvJDSWODgS2Vw4swYMK0JpxvpV4vX4
         YHwFuszGA8NhWFfTqWrTnLBpqDTAFoDCLmthFFnePpNP2jdnKCk+37CKoV7apqoCtpLb
         5jJNtYmIpFqfJsc9WAPjsf4HlaZdKPr/pR3u06CrUkWCNKMtsGAFy8JNRBxLrBnBwgxR
         AP96RfvOaacq8vWTnguHZvJcx/75YXf63iZMHBy3/Zn+j3qxua1TaexOh37S8AESLmqy
         iSaA==
X-Gm-Message-State: AOAM530RjIzPhyLBowMSmnR/1gX6LPDpS7xdWrUwFyQwpA2GeeuEiOmB
        qQIQUZmoZ7cl9lJ5HulpFwWuD+cSUZM=
X-Google-Smtp-Source: ABdhPJynhhKAV8KX3bjL9ZF39qlEkLQJx+w7nBKe6sQVHWsJkxRMNlqlYW3LIUReDgG6NIiZY9i2/A==
X-Received: by 2002:a65:5385:0:b0:3fa:52e3:6468 with SMTP id x5-20020a655385000000b003fa52e36468mr7333773pgq.366.1653369419350;
        Mon, 23 May 2022 22:16:59 -0700 (PDT)
Received: from google.com (c-67-188-95-58.hsd1.ca.comcast.net. [67.188.95.58])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b0050dc76281b5sm8500767pfp.143.2022.05.23.22.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:16:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 23 May 2022 22:16:58 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YoxqSud9fvNXqo89@google.com>
References: <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
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

On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> On 5/23/22 09:33, Minchan Kim wrote:
> ...
> > > So then:
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 0e42038382c1..b404f87e2682 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > >          word_bitidx = bitidx / BITS_PER_LONG;
> > >          bitidx &= (BITS_PER_LONG-1);
> > > 
> > > -       word = bitmap[word_bitidx];
> > > +       /*
> > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> >                                               set_pfnblock_flags_mask would be better?
> > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > 
> > Thanks for proceeding and suggestion, John.
> > 
> > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> 
> Did it? [1] fixed something, but I'm not sure we can claim that that
> code is now safe against tearing in all possible cases, especially given
> the recent discussion here. Specifically, having this code do a read,
> then follow that up with calculations, seems correct. Anything else is

The load tearing you are trying to explain in the comment would be
solved by [1] since the bits will always align on a word and accessing
word size based on word aligned address is always atomic so there is
no load tearing problem IIUC.

Instead of the tearing problem, what we are trying to solve with
READ_ONCE is to prevent refetching when the function would be
inlined in the future.

> sketchy...
> 
> > 
> > The concern in our dicussion was aggressive compiler(e.g., LTO) or code refactoring
> > to make the code inline in *future* could potentially cause forcing refetching(i.e.,
> > re-read) tie bitmap[word_bitidx].
> > 
> > If so, shouldn't the comment be the one you helped before?
> 
> Well, maybe updated to something like this?
> 
> /*
>  * This races, without locks, with set_pageblock_migratetype(). Ensure

set_pageblock_migratetype is more upper level function so it would
be better fit to say set_pfnblock_flags_mask.
                                     
>  * a consistent (non-tearing) read of the memory array, so that results,

So tearing problem should't already happen by [1] so I am trying to
explain refetching(or re-read) problem in the comment.

>  * even though racy, are not corrupted--even if this function is

The value is already atomic so I don't think it could be corrupted
even though it would be inlined in the future.

Please correct me if I miss something.

>  * refactored and/or inlined.
>  */

