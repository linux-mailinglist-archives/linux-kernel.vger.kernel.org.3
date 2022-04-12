Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB44FE9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiDLV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDLV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:26:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D61890CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:07:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso2899411pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=e4KXnzriWpYspaOZ09MkDyywUqOfHTHfFcJ2WOtKnA8=;
        b=nxJGtS/S9cqrCOMKi/RD3qjJjmjzcw8ZFvUyNF8GU2WB8TzCwce3iq1mtQhJQkVcuY
         cU4sC7lxci95hoxbboWTTyiACoLTl4ZlmAgK7YlJO9JPdnYTT/4W2Sy8RKqHEpfLLPpv
         il0rBqUN0gZgMnDgXdu2ucs7pzx0nBo7a/jNXjFTwK3JE7TLQnhmg/tt9/iOf2vuPXw/
         m1amfCdPx8eVZum4G3go9oQW90em8vHbDOcxJChfV6E23zKGFZdqd//s6E93NI8WBx9K
         Ku+r6y0dLsVyH8KgOiDCos2yrQZ4swIUxbXUiDKAmZZDvOlVb0IGg9J+idxxw5fm9Egl
         GxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=e4KXnzriWpYspaOZ09MkDyywUqOfHTHfFcJ2WOtKnA8=;
        b=emC+V04uTpUJTDlfe2NioXIZ6gE1O2rdLvOu/g5fX2wb+ow+0xiysEUbfPQ/fj2Jv8
         IuLV1Vd6dBTK+gu5MPRSQY295w/8PYeokEDH4Um7H/nEvNwPWlqGpja1Rc5Ym9WLOGvk
         HQMMuB01ytBuRqf4GH7OsYNDO0o5inJokJ1gAzaIQL4P4/PAWVcdW1xBEdKf0BUTVZHa
         7pj0/ZKZYBBt0hPJqOa7rgBkADMifx7Vrsp+79webZylvhJ2nQcrlDQdptqWwnuIeuns
         IDLrX0AOlD4+utzvf9b1tNJhn4wYByVlSH1AJq/dM/LVi7BVD4AISqI7x6d2zNGzCLsw
         J9ww==
X-Gm-Message-State: AOAM531PvVAM7rpfwLrmIRTI4axSnp3i43799+LKrk0GiAd0fFnUB44C
        IprHWx6WK4wBA+H1ZHKEwI74Dw==
X-Google-Smtp-Source: ABdhPJzdG9DcZCs8IcExT1sgDRqLnciztc+HE5MrYSFm2YOZlpWBB11ghXDUZQS2IsPsSzTV3fP5gQ==
X-Received: by 2002:a17:90a:bb0d:b0:1bd:3baf:c8b4 with SMTP id u13-20020a17090abb0d00b001bd3bafc8b4mr7106917pjr.15.1649797552072;
        Tue, 12 Apr 2022 14:05:52 -0700 (PDT)
Received: from [2620:15c:29:204:a975:d8d:75b4:4882] ([2620:15c:29:204:a975:d8d:75b4:4882])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79a51000000b00505fe866b3fsm3375631pfj.162.2022.04.12.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:05:51 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:05:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
In-Reply-To: <20220412135912.93175db2ab4e83f4bb060dbf@linux-foundation.org>
Message-ID: <6daaaf5c-529d-f3eb-7486-a72cabb6e396@google.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com> <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com> <20220412135912.93175db2ab4e83f4bb060dbf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022, Andrew Morton wrote:

> On Tue, 12 Apr 2022 13:16:23 -0700 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> wrote:
> 
> > Check if pfn is valid before or not before moving it to freelist.
> > 
> > There are possible scenario where a pageblock can have partial physical
> > hole and partial part of System RAM. This happens when base address in RAM
> > partition table is not aligned to pageblock size.
> > 
> > ...
> >
> > 
> > Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
> 
> I made that 859a85ddf90e714092dea71a0e54c7b9896621be and added
> cc:stable.  I'll await reviewer input before proceeding further.
> 

Acked-by: David Rientjes <rientjes@google.com>

> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
> >  	int pages_moved = 0;
> >  
> >  	for (pfn = start_pfn; pfn <= end_pfn;) {
> > +		if (!pfn_valid(pfn)) {
> 
> Readers will wonder how we can encounter an invalid pfn here.  A small
> comment might help clue them in.
> 

Sudarshan can correct me if I'm wrong, but this has to do with the 
pageblock alignment of the caller that assumes all pages in the range has 
an underlying struct page that we can access but that fails to hold true 
when we have a memory hole.  A comment would definitely help:

	/* Pageblock alignment may cause us to try to access into a hole */

> > +			pfn++;
> > +			continue;
> > +		}
> > +
> >  		page = pfn_to_page(pfn);
> >  		if (!PageBuddy(page)) {
> >  			/*
> 
> 
> 
