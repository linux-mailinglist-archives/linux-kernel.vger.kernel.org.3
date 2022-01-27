Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C49DE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiA0Jya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbiA0Jy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643277267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0wFqp3Iz9T9QxjW3uJ7c0ynmWlc66oSixHGm6orwMM=;
        b=dxMikxzR0xUIQNapZ+j2nlcm1mVxg8cL75zuhQTwWlXEl8CbKbm6HWzoo/fhKpqHyKEEOf
        zO9NO5+1Na9+016sryNo+amtk1jNo6ppIU/HwlOZ452hINOjLss3CZWnEJY+p1VjQ6Kqdd
        Xc1bBvQ+fCgNieXTt7nk97x9qocSdjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-iI2KHbwCO6mk_f7N3BRetg-1; Thu, 27 Jan 2022 04:54:26 -0500
X-MC-Unique: iI2KHbwCO6mk_f7N3BRetg-1
Received: by mail-wm1-f70.google.com with SMTP id n6-20020a05600c3b8600b00350f4349a19so732639wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=U0wFqp3Iz9T9QxjW3uJ7c0ynmWlc66oSixHGm6orwMM=;
        b=d7GRRZr+7phDXYD66Q2nT8i5qRS3opRuGcgKGe1BRpV9Y8ZFoXnzN4CPDYMfx8unov
         DjtshzfXV23Dx07/x4wSAxkJHUXQ2vbi2C9TaDko+FV92MNMYA9kDf6A9Y8zovEj8Gzl
         XEiT6Xlm2wpnz3aDPGq5YrPHzo0BQqyQI5BUCMkwQbJn77FT8j5bKAJ7SD0EhcdnNQPO
         zRmRcxHyOF+pA8LLF0e5WJgCw+v7g0TLeJegewKWIXLb/ay8KTlhgyBjbdnW7S7Jxfri
         FLPEufvkuYVWUwAisYEuagnVtoXAEFXS47qJjHkOqe6qAXGUCS5u4i+e+5aeFtSAKQYu
         fWXQ==
X-Gm-Message-State: AOAM530lvx04/jffna6MpaHqYFp1WeTFRviLI4zYKX4akxcN3EDzqpgF
        QI8kajCzSjCSs9HZou3FUubWeJRl8pxHk/I5scwQJnMQiR1mN7t7wpFmuTa+YIdzCwGW4E/Lx2o
        PA/I6SoEDGgIzx3sGi5zGyZ7j
X-Received: by 2002:adf:dc08:: with SMTP id t8mr2438033wri.40.1643277265218;
        Thu, 27 Jan 2022 01:54:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI0EwZBStHk78/yrgx0ni2w+70kobpre2dhjVtDfhYGvFroZDd44OWF4szeKVZc7CnH7v3fw==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr2438013wri.40.1643277264907;
        Thu, 27 Jan 2022 01:54:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id w6sm5136850wmi.15.2022.01.27.01.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 01:54:24 -0800 (PST)
Message-ID: <696b782f-0b50-9861-a34d-cf750d4244bd@redhat.com>
Date:   Thu, 27 Jan 2022 10:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, akpm@linux-foundation.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220126170002.19754-1-tome01@ajou.ac.kr>
 <5d02ea0e-aca6-a64b-23de-bc9307572d17@redhat.com>
 <20220127094142.GA31409@swarm08>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm/memory_hotplug: Export shrink span functions for
 zone and node
In-Reply-To: <20220127094142.GA31409@swarm08>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 10:41, Jonghyeon Kim wrote:
> On Wed, Jan 26, 2022 at 06:04:50PM +0100, David Hildenbrand wrote:
>> On 26.01.22 18:00, Jonghyeon Kim wrote:
>>> Export shrink_zone_span() and update_pgdat_span() functions to head
>>> file. We need to update real number of spanned pages for NUMA nodes and
>>> zones when we add memory device node such as device dax memory.
>>>
>>
>> Can you elaborate a bit more what you intend to fix?
>>
>> Memory onlining/offlining is reponsible for updating the node/zone span,
>> and that's triggered when the dax/kmem mamory gets onlined/offlined.
>>
> Sure, sorry for the lack of explanation of the intended fix.
> 
> Before onlining nvdimm memory using dax(devdax or fsdax), these memory belong to
> cpu NUMA nodes, which extends span pages of node/zone as a ZONE_DEVICE. So there
> is no problem because node/zone contain these additional non-visible memory
> devices to the system.
> But, if we online dax-memory, zone[ZONE_DEVICE] of CPU NUMA node is hot-plugged
> to new NUMA node(but CPU-less). I think there is no need to hold
> zone[ZONE_DEVICE] pages on the original node.
> 
> Additionally, spanned pages are also used to calculate the end pfn of a node.
> Thus, it is needed to maintain accurate page stats for node/zone.
> 
> My machine contains two CPU-socket consisting of DRAM and Intel DCPMM
> (DC persistent memory modules) with App-Direct mode.
> 
> Below are my test results.
> 
> Before memory onlining:
> 
> 	# ndctl create-namespace --mode=devdax
> 	# ndctl create-namespace --mode=devdax
> 	# cat /proc/zoneinfo | grep -E "Node|spanned" | paste - -
> 	Node 0, zone      DMA	        spanned  4095
> 	Node 0, zone    DMA32	        spanned  1044480
> 	Node 0, zone   Normal	        spanned  7864320
> 	Node 0, zone  Movable	        spanned  0
> 	Node 0, zone   Device	        spanned  66060288
> 	Node 1, zone      DMA	        spanned  0
> 	Node 1, zone    DMA32	        spanned  0
> 	Node 1, zone   Normal	        spanned  8388608
> 	Node 1, zone  Movable	        spanned  0
> 	Node 1, zone   Device	        spanned  66060288
> 
> After memory onlining:
> 
> 	# daxctl reconfigure-device --mode=system-ram --no-online dax0.0
> 	# daxctl reconfigure-device --mode=system-ram --no-online dax1.0
> 
> 	# cat /proc/zoneinfo | grep -E "Node|spanned" | paste - -
> 	Node 0, zone      DMA	        spanned  4095
> 	Node 0, zone    DMA32	        spanned  1044480
> 	Node 0, zone   Normal	        spanned  7864320
> 	Node 0, zone  Movable	        spanned  0
> 	Node 0, zone   Device	        spanned  66060288
> 	Node 1, zone      DMA	        spanned  0
> 	Node 1, zone    DMA32	        spanned  0
> 	Node 1, zone   Normal	        spanned  8388608
> 	Node 1, zone  Movable	        spanned  0
> 	Node 1, zone   Device	        spanned  66060288
> 	Node 2, zone      DMA	        spanned  0
> 	Node 2, zone    DMA32	        spanned  0
> 	Node 2, zone   Normal	        spanned  65011712
> 	Node 2, zone  Movable	        spanned  0
> 	Node 2, zone   Device	        spanned  0
> 	Node 3, zone      DMA	        spanned  0
> 	Node 3, zone    DMA32	        spanned  0
> 	Node 3, zone   Normal	        spanned  65011712
> 	Node 3, zone  Movable	        spanned  0
> 	Node 3, zone   Device	        spanned  0
> 
> As we can see, Node 0 and 1 still have zone_device pages after memory onlining.
> This causes problem that Node 0 and Node 2 have same end of pfn values, also 
> Node 1 and Node 3 have same problem.

Thanks for the information, that makes it clearer.

While this unfortunate, the node/zone span is something fairly
unreliable/unusable for user space. Nodes and zones can overlap just easily.

What counts are present/managed pages in the node/zone.

So at least I don't count this as something that "needs fixing",
it's more something that's nice to handle better if easily possible.

See below.

> 
>>> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
>>> ---
>>>  include/linux/memory_hotplug.h | 3 +++
>>>  mm/memory_hotplug.c            | 6 ++++--
>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>>> index be48e003a518..25c7f60c317e 100644
>>> --- a/include/linux/memory_hotplug.h
>>> +++ b/include/linux/memory_hotplug.h
>>> @@ -337,6 +337,9 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>>>  extern void remove_pfn_range_from_zone(struct zone *zone,
>>>  				       unsigned long start_pfn,
>>>  				       unsigned long nr_pages);
>>> +extern void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>> +			     unsigned long end_pfn);
>>> +extern void update_pgdat_span(struct pglist_data *pgdat);
>>>  extern bool is_memblock_offlined(struct memory_block *mem);
>>>  extern int sparse_add_section(int nid, unsigned long pfn,
>>>  		unsigned long nr_pages, struct vmem_altmap *altmap);
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 2a9627dc784c..38f46a9ef853 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -389,7 +389,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>>>  	return 0;
>>>  }
>>>  
>>> -static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>> +void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>  			     unsigned long end_pfn)
>>>  {
>>>  	unsigned long pfn;
>>> @@ -428,8 +428,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>  		}
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL_GPL(shrink_zone_span);
>>
>> Exporting both as symbols feels very wrong. This is memory
>> onlining/offlining internal stuff.
> 
> I agree with you that your comment. I will find another approach to avoid
> directly using onlining/offlining internal stuff while updating node/zone span.

IIRC, to handle what you intend to handle properly want to look into teaching
remove_pfn_range_from_zone() to handle zone_is_zone_device().

There is a big fat comment:

	/*
	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
	 * we will not try to shrink the zones - which is okay as
	 * set_zone_contiguous() cannot deal with ZONE_DEVICE either way.
	 */
	if (zone_is_zone_device(zone))
		return;


Similarly, try_offline_node() spells this out:

	/*
	 * If the node still spans pages (especially ZONE_DEVICE), don't
	 * offline it. A node spans memory after move_pfn_range_to_zone(),
	 * e.g., after the memory block was onlined.
	 */
	if (pgdat->node_spanned_pages)
		return;


So once you handle remove_pfn_range_from_zone() cleanly, you'll cleanly handle
try_offline_node() implicitly.

Trying to update the node span manually without teaching node/zone shrinking code how to
handle ZONE_DEVICE properly is just a hack that will only sometimes work. Especially, it
won't work if the range of interest is still surrounded by other ranges.

-- 
Thanks,

David / dhildenb

