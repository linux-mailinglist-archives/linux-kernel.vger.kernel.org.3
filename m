Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AA54771F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiFKS35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiFKS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A9331DF6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654972193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcxlPosDuNYZLF+xkyfBuM18/wNn6c4mtAX4pgyPBoM=;
        b=ePeFudFCCDGY04ZeegNWbbFJghLadIh6+WKyk8exsido+JdRHV4+Y2yrX+dw7y39z7XnyY
        UWUe49kNumxWFaq/Z73TP8uv79OhRmyGNZ6vqsEWCVxX3Gw7DNCVnSYTastVcgiujNEixZ
        LnKOBUpO9j6DgN+7UGvNkymEoynvD8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-PF_55YNENt67CvBYqOhIhg-1; Sat, 11 Jun 2022 14:29:51 -0400
X-MC-Unique: PF_55YNENt67CvBYqOhIhg-1
Received: by mail-wm1-f69.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso3235385wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pcxlPosDuNYZLF+xkyfBuM18/wNn6c4mtAX4pgyPBoM=;
        b=GVtdEFQr7GAy2VguElSW8zo0zGrNNohSfM534kmR0Z2j70NajUwqCO5xetIC42m9Im
         YwB/H/KmkBZ/jPiYUnn7Wqqt+ODyLFDcQscaBFYquIwkFVGsfWgoEHqW9hWP05Q5rawn
         HOXxKPtIPtS71ujz55l6UP8QB9zpYKoZXOJt2WhnvOC4kw70HZ94pOiwO7EMZDq7X/7v
         u+aQyuDLHAzIW6QVZ4S+GdGWHPcWiXSPf9xht/ypaDHoOFNutA0uKX5TmoIDaxz3gfcs
         bpxItgiW5jU60z0tot+jRnCbeFd5/I6hO+NySFEaWgBKDDxXkopaOhnRKENIq9Lft8RW
         0gQA==
X-Gm-Message-State: AOAM533juM7vBbsguMvI02zbGMa3O0eH9t/Uu9UQf1PQ2fC//wUrUTbO
        Qv5cUSzdrqMqBhoIHdH0xHlv+A7a31i0Zp/2xYM89H0gkPpXfTrZi4SKTysjf5/a4tDDQX7wq4y
        IviS83I7e9thX3bsZc/v10XX0
X-Received: by 2002:a05:600c:3790:b0:39c:7dc2:aea0 with SMTP id o16-20020a05600c379000b0039c7dc2aea0mr6010385wmr.112.1654972190627;
        Sat, 11 Jun 2022 11:29:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrYrnw+ck5JXVgLSNaYccrM3xEoJFNJyTxJ1A7dw5yPRd/CG4ZB1PEvF7LgsNSXQjVrBQLWQ==
X-Received: by 2002:a05:600c:3790:b0:39c:7dc2:aea0 with SMTP id o16-20020a05600c379000b0039c7dc2aea0mr6010368wmr.112.1654972190341;
        Sat, 11 Jun 2022 11:29:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:c400:dc43:2462:b7e5:dd7e? (p200300cbc719c400dc432462b7e5dd7e.dip0.t-ipconnect.de. [2003:cb:c719:c400:dc43:2462:b7e5:dd7e])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b0039c8a22554bsm728282wms.27.2022.06.11.11.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 11:29:49 -0700 (PDT)
Message-ID: <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
Date:   Sat, 11 Jun 2022 20:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, jhubbard@nvidia.com, joaodias@google.com,
        jgg@ziepe.ca
References: <165490039431.944052.12458624139225785964.stgit@omen>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
In-Reply-To: <165490039431.944052.12458624139225785964.stgit@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.22 00:35, Alex Williamson wrote:
> The commit referenced below subtly and inadvertently changed the logic
> to disallow pinning of zero pfns.  This breaks device assignment with
> vfio and potentially various other users of gup.  Exclude the zero page
> test from the negation.

I wonder which setups can reliably work with a long-term pin on a shared
zeropage. In a MAP_PRIVATE mapping, any write access via the page tables
will end up replacing the shared zeropage with an anonymous page.
Something similar should apply in MAP_SHARED mappings, when lazily
allocating disk blocks.

In the future, we might trigger unsharing when taking a R/O pin for the
shared zeropage, just like we do as of now upstream for shared anonymous
pages (!PageAnonExclusive). And something similar could then be done
when finding a !anon page in a MAP_SHARED mapping.

> 
> Fixes: 1c563432588d ("mm: fix is_pinnable_page against a cma page")

Having that said, it indeed looks like that was an unintended change.

Acked-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> At least I assume this was inadvertent...  If there's a better fix,
> please run with it as I'm out of the office the 1st half of next
> week and would like to see this fixed ASAP.  Thanks!
> 
>  include/linux/mm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..781fae17177d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1600,7 +1600,7 @@ static inline bool is_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
> +	return !is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page));
>  }
>  #else
>  static inline bool is_pinnable_page(struct page *page)
> 
> 


-- 
Thanks,

David / dhildenb

