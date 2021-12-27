Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1069B47FA02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhL0D7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhL0D7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:59:37 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA64C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 19:59:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l17so12575769qtk.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 19:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=w0TpoHfRoDQ+4/03uti72NNxw61oie+s3OIX8ISzosQ=;
        b=h95hLNMF1hxHjwOcuy1djdgp5vD9wFjjaLLgswEeErKS+gXo8ypYWC/ShjNHMyNGXP
         qlSNjiB13iRTmaIIGfLLcPIUeTxI0YBKiWSvQzuWf6iZAs15kHab7nWBlxR5ofsIZcsb
         qosHP8+y1RE5Y/fajuPT+uHK0K61oUhJiWuXNFhULBmS2JHte0bBEk7jPS1v9aw6+pwr
         O8u7CjPZn9ZnLfTMGOmd6HjcUVsBkYDe9SWqa7YqbIhtTy8QfeuU8jaOG1wVqTQyssce
         HOQLSQoiwHvRj0x8qEHux4eVuuypEofeLKGFNXbDCPMl90CoBBOxRhpW2zGZeDpSdNlm
         JlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0TpoHfRoDQ+4/03uti72NNxw61oie+s3OIX8ISzosQ=;
        b=3olBGY/HlojqhgRA5+3jbhnOroSU+/+/9vzkoBKNY3d7i8w8uILHGEbZ96vC5N/LjO
         vYn2QVvDB+xgGaa8oMEyBoOxGQ77GWtZ5tbKzlyLK+Y48Ci3RhjQX/AUrQ0N8uNy9IWw
         uVAdX6L650PDcKl8OdjnhfbFZ/fSGacqsjdDuuiHqmpg1VeKmcghVAGe+C11E2Bt0WQ8
         If7xYpFy3+BUfGFomoFpFETSzeD5ilnle+BnfWEclrir6rUddF8U6jk0MYoQ/MgtNde6
         f5QWmW1ZdIP7qNFHIURBk6S2DWFFMjXZhigH8aNc/Zy1PqqEUeP7BcUyuPIpQWOp/k58
         yj2w==
X-Gm-Message-State: AOAM530oqch7oQjrPLeEQOsCifFi3nuOSQ661/YmZ4pvw15OZiRZ3Urt
        mzeoUtU81jCqB3leToIerCI=
X-Google-Smtp-Source: ABdhPJyZt3oRgN6pJyvHmUAp8htm6pm/m9v7Dx8x7Yo/J6OQK2iX6woCT4CL2IiX0IWZN+Me7FzbVg==
X-Received: by 2002:ac8:7b2f:: with SMTP id l15mr13404743qtu.654.1640577576525;
        Sun, 26 Dec 2021 19:59:36 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3sm12697688qko.78.2021.12.26.19.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 19:59:35 -0800 (PST)
Message-ID: <61c93a27.1c69fb81.627b0.8bf6@mx.google.com>
X-Google-Original-Message-ID: <20211227035933.GA578235@cgel.zte@gmail.com>
Date:   Mon, 27 Dec 2021 03:59:33 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, yang.yang29@zte.com.cn,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/vmstat: add events for THP max_ptes_* exceeds
References: <20211225094036.574157-1-yang.yang29@zte.com.cn>
 <87k0fq7n0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0fq7n0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 11:19:32AM +0800, Huang, Ying wrote:
> cgel.zte@gmail.com writes:
> 
> > From: Yang Yang <yang.yang29@zte.com.cn>
> >
> > There are interfaces to adjust max_ptes_none, max_ptes_swap,
> > max_ptes_shared values, see
> > /sys/kernel/mm/transparent_hugepage/khugepaged/.
> >
> > But system administrator maynot know which value is the best. So
> > Add those events to support adjusting max_ptes_* to suitable values.
> >
> > For example, if default max_ptes_swap value causes too much failures,
> > and system uses zram whose IO is fast, administrator could increase
> > max_ptes_swap until THP_SCAN_EXCEED_SWAP_PTE not increase anymore.
> >
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  include/linux/vm_event_item.h | 3 +++
> >  mm/khugepaged.c               | 7 +++++++
> >  mm/vmstat.c                   | 3 +++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index a185cc75ff52..7b2363388bfa 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -98,6 +98,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  		THP_SPLIT_PAGE_FAILED,
> >  		THP_DEFERRED_SPLIT_PAGE,
> >  		THP_SPLIT_PMD,
> > +		THP_SCAN_EXCEED_NONE_PTE,
> > +		THP_SCAN_EXCEED_SWAP_PTE,
> > +		THP_SCAN_EXCEED_SHARED_PTE,
> 
> "SCAN" appears too general, how about
> 
>   THP_COLLAPSE_EXCEED_SWAP_PTE
> 
> ?
>
Thanks for your suggesting.

But I think SCAN is easy to understand, it is SCAN behaviour cause the event,
and we know this event is comes from SCAN_EXCEED_*_PTE.

> Best Regards,
> Huang, Ying
> 
> [snip]
