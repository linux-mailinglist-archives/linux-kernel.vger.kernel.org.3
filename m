Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E346E78E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhLIL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhLIL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:29:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113CC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:26:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u17so3630411plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=RGeadJA8gWc8MMZddmbtqYIz9/bVSraQHXfB9yZL+Ro=;
        b=GOGWLlgErncB0GSsat6CgEwbi5nx/KdwDWh+BgaCT6QaaA9Nt0/n11fwWfeQVV8Z6I
         geY3QA3RgFtmn7qKheCiUunC9JOWLdrmhi5Zo4+hPhffAmGAqMFN4xhCIUVNPvIXFcOU
         8Tw9M/iUUZM7cVF9gbe22t4Bb7vj6i4FNpA/oedO9lUSavYfL5dT5CzHN9+7ZAN9Ycmd
         DVLXPthFkDl7yQ3wiAwjhHAo7i5mYNpKxDOk77phjbDXxkrYQVGTCp6LwHaITN8I5Adj
         Go3m+fQKWJn4FTTj4j68g+T+Q5VNDp6SPGS8M9xMXjAgew4SKoEZu3I085eWOYnjeB8S
         WCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RGeadJA8gWc8MMZddmbtqYIz9/bVSraQHXfB9yZL+Ro=;
        b=vnsRCZqsGVDS/vb+cgVLHoyaFUZHjxXAPDvBs3OAELc7gODIqygF7qGdumE2Bj8kP4
         DJtxxCJRPnyheKmY+SoeXz1HvGGEzHOksx9lZfX53jThLe3/n08ORd8n2tCK1D2UJ4wR
         pJGSpcC+MOpDitqWvKA/HnGlX6dmj/z7xKS2QDFG/GYTQAQCxMvVRtTnwoY5Tu/7D4Kc
         m6jXFDdRvb1Jz/Juz2IR9bPUUvSkEuFxIxbpfDGxzQGfxfirZO/43Ip1OqMtange9rnI
         hi5lPZct66b6SIyN2uAg4YgKeH0Vj+2/FKId1T+9AwqUM/h9mK/bVVRefO+x4+AxEI5e
         2JNQ==
X-Gm-Message-State: AOAM531CTV+CG30azGukYf6iTUHYWhcR+WzYeobttCMWol/Iuva7i3pM
        hjAIkkSkwkMxR4mtLezL6P0=
X-Google-Smtp-Source: ABdhPJzdp3Rzklx/x0ECcOM1y9XG2EsWdVgW2PP7h2t/AOOmWbF3//zU0f7gpEUM7092rXa4fwON/w==
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr67087984plf.72.1639049184479;
        Thu, 09 Dec 2021 03:26:24 -0800 (PST)
Received: from [30.240.97.54] ([205.204.117.110])
        by smtp.gmail.com with ESMTPSA id pc10sm6609618pjb.9.2021.12.09.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:26:24 -0800 (PST)
Message-ID: <9f4e8334-9aaf-5ec4-3af9-884160110689@gmail.com>
Date:   Thu, 9 Dec 2021 19:26:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v1 1/2] virtio-mem: prepare page onlining code for
 granularity smaller than MAX_ORDER - 1
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20211126134209.17332-1-david@redhat.com>
 <20211126134209.17332-2-david@redhat.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211126134209.17332-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for working on this!

On 2021/11/26 21:42, David Hildenbrand wrote:
> Let's prepare our page onlining code for subblock size smaller than
> MAX_ORDER - 1: we'll get called for a MAX_ORDER - 1 page but might have
> some subblocks in the range plugged and some unplugged. In that case,
> fallback to subblock granularity to properly only expose the plugged
> parts to the buddy.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/virtio/virtio_mem.c | 86 ++++++++++++++++++++++++++-----------
>   1 file changed, 62 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 96e5a8782769..03e1c5743699 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -20,6 +20,7 @@
>   #include <linux/mutex.h>
>   #include <linux/bitmap.h>
>   #include <linux/lockdep.h>
> +#include <linux/log2.h>
>   
>   #include <acpi/acpi_numa.h>
>   
> @@ -1228,28 +1229,46 @@ static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
>   		page_ref_inc(pfn_to_page(pfn + i));
>   }
>   
> -static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> +static void virtio_mem_online_page(struct virtio_mem *vm,
> +				   struct page *page, unsigned int order)
>   {
> -	const unsigned long addr = page_to_phys(page);
> -	unsigned long id, sb_id;
> -	struct virtio_mem *vm;
> +	const unsigned long start = page_to_phys(page);
> +	const unsigned long end = start + PFN_PHYS(1 << order);
> +	unsigned long addr, next, id, sb_id, count;
>   	bool do_online;
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
> -		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
> -			continue;
> +	/*
> +	 * We can get called with any order up to MAX_ORDER - 1. If our
> +	 * subblock size is smaller than that and we have a mixture of plugged
> +	 * and unplugged subblocks within such a page, we have to process in
> +	 * smaller granularity. In that case we'll adjust the order exactly once
> +	 * within the loop.
> +	 */
> +	for (addr = start; addr < end; ) {
> +		next = addr + PFN_PHYS(1 << order);
>   
>   		if (vm->in_sbm) {
> -			/*
> -			 * We exploit here that subblocks have at least
> -			 * MAX_ORDER_NR_PAGES size/alignment - so we cannot
> -			 * cross subblocks within one call.
> -			 */
>   			id = virtio_mem_phys_to_mb_id(addr);
>   			sb_id = virtio_mem_phys_to_sb_id(vm, addr);
> -			do_online = virtio_mem_sbm_test_sb_plugged(vm, id,
> -								   sb_id, 1);
> +			count = virtio_mem_phys_to_sb_id(vm, next - 1) - sb_id + 1;
> +
> +			if (virtio_mem_sbm_test_sb_plugged(vm, id, sb_id, count)) {
> +				/* Fully plugged. */
> +				do_online = true;
> +			} else if (count == 1 ||
> +				   virtio_mem_sbm_test_sb_unplugged(vm, id, sb_id, count)) {
> +				/* Fully unplugged. */
> +				do_online = false;
> +			} else {
> +				/*
> +				 * Mixture, process sub-blocks instead. This
> +				 * will be at least the size of a pageblock.
> +				 * We'll run into this case exactly once.
> +				 */
> +				order = ilog2(vm->sbm.sb_size) - PAGE_SHIFT;
> +				do_online = virtio_mem_sbm_test_sb_plugged(vm, id, sb_id, 1);
> +				continue;
> +			}
>   		} else {
>   			/*
>   			 * If the whole block is marked fake offline, keep
> @@ -1260,18 +1279,38 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>   				    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
>   		}
>   
> +		if (do_online)
> +			generic_online_page(pfn_to_page(PFN_DOWN(addr)), order);
> +		else
> +			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
> +						    false);
Should we just use PHYS_PFN() here? addr is obviously PFN aligned. 
Anyway, it doesn't matter.

LGTM.
Reviewed-by: Eric Ren <renzhengeek@gmail.com>
> +		addr = next;
> +	}
> +}
> +
> +static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> +{
> +	const unsigned long addr = page_to_phys(page);
> +	struct virtio_mem *vm;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
>   		/*
> -		 * virtio_mem_set_fake_offline() might sleep, we don't need
> -		 * the device anymore. See virtio_mem_remove() how races
> +		 * Pages we're onlining will never cross memory blocks and,
> +		 * therefore, not virtio-mem devices.
> +		 */
> +		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
> +			continue;
> +
> +		/*
> +		 * virtio_mem_set_fake_offline() might sleep. We can safely
> +		 * drop the RCU lock at this point because the device
> +		 * cannot go away. See virtio_mem_remove() how races
>   		 * between memory onlining and device removal are handled.
>   		 */
>   		rcu_read_unlock();
>   
> -		if (do_online)
> -			generic_online_page(page, order);
> -		else
> -			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
> -						    false);
> +		virtio_mem_online_page(vm, page, order);
>   		return;
>   	}
>   	rcu_read_unlock();
> @@ -2438,8 +2477,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
>   	/*
>   	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
>   	 * pageblock_nr_pages pages. This:
> -	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
> -	 *   and fake page onlining code (virtio_mem_fake_online).
> +	 * - Simplifies our fake page onlining code (virtio_mem_fake_online).
>   	 * - Is required for now for alloc_contig_range() to work reliably -
>   	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>   	 */

