Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AF4CB9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiCCIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCCIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B4F61768D2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646297678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMHQsaI/XgvBZMN3rOmZW/YLSLkO6uZDE1Vto8Q0Lws=;
        b=b59O1xZJRDjTGY+6uLZ7AvvDk/UuNY0qnFiZ123fufSDuh59zOo8krxSaJ5UMpLvgii8b2
        9JEU0MZklwbSLdn/8HxwGKRA3Q2vkJ+A23hagLB2dtjclza7G3MkYOwmdtdSpKsyc5LMkD
        maOlfrji7NQ+uNOLebSdBsdjbG0IQj0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-Yl7tqKuHP9uEgmpLxIF_nw-1; Thu, 03 Mar 2022 03:54:37 -0500
X-MC-Unique: Yl7tqKuHP9uEgmpLxIF_nw-1
Received: by mail-wr1-f70.google.com with SMTP id b7-20020a05600003c700b001efac398af7so1769516wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hMHQsaI/XgvBZMN3rOmZW/YLSLkO6uZDE1Vto8Q0Lws=;
        b=FvhBwYdSDpDRZa83b9HZYYE365yDVNm2mb02SMVz/lFoq3Zo1jnMDILdwnTf/2/i9n
         OC64QBgiUYhzxgB54bJ4MYi/T/8CXG9zT1xOIriVwhWzlYzItjj1DWodTBXeHYxQ3+IN
         782A6mh+cO/LvjTGcCabM5wPf3ek9oCC/RMCREGYIRhH1xWwpfSt2ociStt0va1nGnCl
         25xvk9IidpUfakSn4sTbdyuAZ92Ta/LuWDfVUiBkNX/SsCbjwj6Zi5bgjkKyWvTZ3IhZ
         ME179yzQbEUXlf0SFR29aZUVM4PSFsZlVvg3WlnmamKdHhaWfW/bOpeNtexwp1XMoNpT
         xjUA==
X-Gm-Message-State: AOAM530Mtr6JTtLgsOTL6OC0nN9rMd6H3J/2813PkEvT3giZXAAHi5fG
        cr1nU28n9g7nXr0nMfjJ+57APjstOM6tD2bL7zf6nu//c3cGOMi9u3FzLiV+c8jUryjFjSaBcKL
        l3BUM6DZXBFOukg4mgzK1eV+V
X-Received: by 2002:a05:600c:17d8:b0:381:5277:8720 with SMTP id y24-20020a05600c17d800b0038152778720mr2853136wmo.118.1646297676673;
        Thu, 03 Mar 2022 00:54:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4YYvTJS5a0QkyJaD07Wwl+ZIbitE+uUkpmgjtuounDeL9AUkexDVyMpBAc3sLSumzLH1l7w==
X-Received: by 2002:a05:600c:17d8:b0:381:5277:8720 with SMTP id y24-20020a05600c17d800b0038152778720mr2853119wmo.118.1646297676343;
        Thu, 03 Mar 2022 00:54:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:3600:f39a:d830:baab:42f0? (p200300cbc7063600f39ad830baab42f0.dip0.t-ipconnect.de. [2003:cb:c706:3600:f39a:d830:baab:42f0])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm4820850wmq.2.2022.03.03.00.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:54:35 -0800 (PST)
Message-ID: <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
Date:   Thu, 3 Mar 2022 09:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.22 02:56, Hugh Dickins wrote:
> The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> vmscan.c's free_unref_page_list() callers rely on that not to generate
> bad_page() alerts.  So __page_cache_release() and release_pages() (and
> the presumably copy-and-pasted put_zone_device_private_or_public_page())
> are redundant and misleading to make a special point of clearing it (as
> the "__" implies, it could only safely be used on the freeing path).
> 
> Delete __ClearPageWaiters().  Remark on this in one of the "possible"
> comments in wake_up_page_bit(), and delete the superfluous comments.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> We've used this since 2018, and I see Yu Zhao posted similar in 2020:
> https://lore.kernel.org/linux-mm/20200818184704.3625199-3-yuzhao@google.com/
> I couldn't join in at that time, but think its reception was over-cautious.
> 
>  include/linux/page-flags.h |  2 +-
>  mm/filemap.c               | 22 +++++++---------------
>  mm/memremap.c              |  2 --
>  mm/swap.c                  |  4 ----
>  4 files changed, 8 insertions(+), 22 deletions(-)
> 
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -481,7 +481,7 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
>  	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
>  
>  __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> -PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
> +PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
>  PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
>  PAGEFLAG(Referenced, referenced, PF_HEAD)
>  	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1179,24 +1179,16 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
>  	}
>  
>  	/*
> -	 * It is possible for other pages to have collided on the waitqueue
> -	 * hash, so in that case check for a page match. That prevents a long-
> -	 * term waiter
> +	 * It's possible to miss clearing waiters here, when we woke our page
> +	 * waiters, but the hashed waitqueue has waiters for other pages on it.
>  	 *
> -	 * It is still possible to miss a case here, when we woke page waiters
> -	 * and removed them from the waitqueue, but there are still other
> -	 * page waiters.
> +	 * That's okay, it's a rare case. The next waker will clear it. Or,
> +	 * it might be left set until the page is freed: when it's masked off
> +	 * with others in PAGE_FLAGS_CHECK_AT_PREP, by free_pages_prepare().
>  	 */

Does that also apply to ZONE_DEVICE pages via free_zone_device_page()?


-- 
Thanks,

David / dhildenb

