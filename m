Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731D948C2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352708AbiALLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352711AbiALLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641985301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/XZEAdk6QhvWrbmCBXkp2EEmuq+KMqsHqxGoGIR2UA=;
        b=gDKZgegZNFgx+n0cfX0mkQlNnH7cGccrxGMkLGvVBKDcR1fLslh/6vpvGhvIuxth4Hi4fg
        z3QQuXp8CxKi+yJg1j2eu/kDo0Zjz9qVQzV0iV5UFNBcxOare7VozVwmqKCz2KWwQfCVWw
        M3rOJl5XITk6jqK16aYeeT4CwQwB2uQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-_6pklw1jNLSo8mDEh8_8Yg-1; Wed, 12 Jan 2022 06:01:40 -0500
X-MC-Unique: _6pklw1jNLSo8mDEh8_8Yg-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso1927625edd.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8/XZEAdk6QhvWrbmCBXkp2EEmuq+KMqsHqxGoGIR2UA=;
        b=FgUKgnyy7thdYCwIJUFAqWxCkAhVPHJh8kYsNRodVHRV4+dbxGtSb9tba4lyCLZe1b
         f3wMMsQtZGDNMljvLMumW5SIb/aDaBLok6QZKENEqN1v3GhuAH4Q9pGoYk2TRzxfVfc0
         Wy6qs9jTUlfQekcJgpRVy7brOFFAqnS3lR4Oj5Du5mlhqRzR+8Qredj20TS+4gAB29Tz
         V/eko0sJXySrxBdjRuFdz4lM7I+y+/n6sEyTu0h6ZWMWTU5PHWxFmI90W4g9sfBbXwQO
         y+U4T5tzt7m2/cYvs5kjSj4ctnRKNZpLBNvUVlac4BtWKMFYQjD2v4CL8SWTTz00X5tD
         lzFg==
X-Gm-Message-State: AOAM533Ian3DvC9H9jTV6sUoF5ukGX4MNWDCIX4/dZbuxbFd8WD8OI0u
        vNK01Q9FfAvqY1sHMCp7C11JDIy1gguFBKANQZFVxIj7ky/c28lWATr8hKIuxEDbM/jfrOTXW1N
        +CwQSOWRBGJWC4yLBpQFE10+O
X-Received: by 2002:a05:6402:4405:: with SMTP id y5mr8374669eda.179.1641985298938;
        Wed, 12 Jan 2022 03:01:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWWf+6A4h9fD+VcApry/1ctZSaWE5x9A2DNgQ1rynCwOFlVNP1wLYNq0HbTcp/3NUGR7KzoA==
X-Received: by 2002:a05:6402:4405:: with SMTP id y5mr8374660eda.179.1641985298747;
        Wed, 12 Jan 2022 03:01:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id 13sm4394200ejh.225.2022.01.12.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:01:38 -0800 (PST)
Message-ID: <a5e029e8-f646-a414-f4f4-ba573171642f@redhat.com>
Date:   Wed, 12 Jan 2022 12:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 2/8] mm: compaction: handle non-lru compound pages
 properly in isolate_migratepages_block().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-3-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In isolate_migratepages_block(), a !PageLRU tail page can be encountered
> when the page is larger than a pageblock. Use compound head page for the
> checks inside and skip the entire compound page when isolation succeeds.
> 

This will currently never happen, due to the way we always isolate
MAX_ORDER -1 ranges, correct?

Better note that in the patch description, because currently it reads
like it's an actual fix "can be encountered".

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b4e94cda3019..ad9053fbbe06 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		 * Skip any other type of page
>  		 */
>  		if (!PageLRU(page)) {
> +			struct page *head = compound_head(page);
>  			/*
>  			 * __PageMovable can return false positive so we need
>  			 * to verify it under page_lock.
>  			 */
> -			if (unlikely(__PageMovable(page)) &&
> -					!PageIsolated(page)) {
> +			if (unlikely(__PageMovable(head)) &&
> +					!PageIsolated(head)) {
>  				if (locked) {
>  					unlock_page_lruvec_irqrestore(locked, flags);
>  					locked = NULL;
>  				}
>  
> -				if (!isolate_movable_page(page, isolate_mode))
> +				if (!isolate_movable_page(head, isolate_mode)) {
> +					low_pfn += (1 << compound_order(head)) - 1 - (page - head);
> +					page = head;
>  					goto isolate_success;
> +				}
>  			}
>  
>  			goto isolate_fail;


-- 
Thanks,

David / dhildenb

