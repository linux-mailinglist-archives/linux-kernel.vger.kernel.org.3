Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98578486C07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbiAFVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiAFVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:41:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5867C06118A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:41:17 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id j15so2048378ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VE61gMKhpnWZvU6qcog2kgqC/TE+2QO5LS6iHCKhdqo=;
        b=X5251x9gOvT9jJO0fIYrghZ2dmsDZAjI/XaWW0c5hgerIpNSgvl0jSew1p/PD5Wl19
         Vty9fxDz85jiNwo2PyrzeAVr0Qh4AvnoRBKBwKjqqN+gzpApKSZBr6PBW1Haplrbva6W
         fgVBMIb7yopx0RKQtKxR50gNsFKTWHXlfqc8oQFDrabFDnXtqIegt0iG6irvi38YWFd4
         cgfZmbJs9Pm7/xTPZRLe5dj3S3L3BXmcfUDx4bs89c9lfEzBCjKIC2rQMHR8y1knN7k1
         n9W9uyTNFGgs6Rt4Z59saMbeT0VmyuJ8EgZ8HHnKRgS+SJ6qUqkzzObvE1zCp+mjQO+F
         5N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VE61gMKhpnWZvU6qcog2kgqC/TE+2QO5LS6iHCKhdqo=;
        b=VkZIrsjQyUSBSdZ0vfWPVbhcQX7XdAMbfOyMyA8Xl7LaTaNaopITF0D/9wScOlSzvN
         xifBRL/X1OHFVCrV6jKnKgDTsXxKsTdUSQAZQY3coaul8K2lpmhi8oiEpYgf1I5oYXQX
         8XMTXo4DGIzied4RqNcjM4N50wUiKPTD1njTZ7Wq+8gKuTJg8QHhmzkgpxHPtoIj/owK
         IXMvb/XY3AwuOh5WauIjNbCEZwYkXTD9x7u3CUx+OCQN1XCj6RVWY6snaE3X1Lh/dmea
         Wo9BHHyWeVv6USAgKX9f01Yy8WubwbIvO3H1EQTxHZh8ah1gTm0vbp/Y0Yd+gHxoh9GI
         dMOQ==
X-Gm-Message-State: AOAM531BlRcg9sblUwbxZU/ZuhwZkl4M8I/4qSyMYYzsVjTG5w7B699m
        VR1nMLl2cdibtF6C/ajIn1Cmvg==
X-Google-Smtp-Source: ABdhPJy/UG+ITMyG2/Mn4Uwf8UspkeO6+lrYf7WWF5pbE5NdbTB0zBoFHkgaWyjBjeOtQvNFfxzAEw==
X-Received: by 2002:a05:6e02:1945:: with SMTP id x5mr2005197ilu.288.1641505277173;
        Thu, 06 Jan 2022 13:41:17 -0800 (PST)
Received: from google.com ([2620:15c:183:200:2e0a:5e5e:fac:e07b])
        by smtp.gmail.com with ESMTPSA id r1sm1688447ilo.38.2022.01.06.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:41:16 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:41:12 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Yddh+APQGg8dKRgw@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:12:16PM +0100, Michal Hocko wrote:
> On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> > +{
> > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> > +
> > +	return current->reclaim_state->mm_walk;
> > +}
> > +
> > +static void free_mm_walk(struct lru_gen_mm_walk *walk)
> > +{
> > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > +		kvfree(walk);
> > +}
> 
> Do I get it right that you are allocating from the reclaim context? What
> prevents this to completely deplete the memory as the reclaim context is
> PF_MEMALLOC?

Yes, and in general the same reason zram/zswap/etc. allocate memory in
the reclaim context: to make more free memory.

In this case, lru_gen_mm_walk is small (160 bytes); it's per direct
reclaimer; and direct reclaimers rarely come here, i.e., only when
kswapd can't keep up in terms of the aging, which is similar to the
condition where the inactive list is empty for the active/inactive
lru.
