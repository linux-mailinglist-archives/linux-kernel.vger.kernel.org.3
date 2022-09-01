Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C5A92BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiIAJIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiIAJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:07:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19D6912BC3B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:06:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EECD6E;
        Thu,  1 Sep 2022 02:06:07 -0700 (PDT)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B994B3F766;
        Thu,  1 Sep 2022 02:05:58 -0700 (PDT)
Message-ID: <11ee1311-7473-475b-faf5-e7f554830c6c@arm.com>
Date:   Thu, 1 Sep 2022 14:35:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: kill is_memblock_offlined()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220827112043.187028-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220827112043.187028-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/22 16:50, Kefeng Wang wrote:
> Directly check state of struct memory_block, no need a single function.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  drivers/base/memory.c          | 6 ------
>  include/linux/memory_hotplug.h | 2 --
>  mm/memory_hotplug.c            | 3 +--
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index bc60c9cd3230..9aa0da991cfb 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -869,12 +869,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  	}
>  }
>  
> -/* return true if the memory block is offlined, otherwise, return false */
> -bool is_memblock_offlined(struct memory_block *mem)
> -{
> -	return mem->state == MEM_OFFLINE;
> -}
> -
>  static struct attribute *memory_root_attrs[] = {
>  #ifdef CONFIG_ARCH_MEMORY_PROBE
>  	&dev_attr_probe.attr,
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 409196ef8038..de87545eabe9 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -11,7 +11,6 @@ struct page;
>  struct zone;
>  struct pglist_data;
>  struct mem_section;
> -struct memory_block;
>  struct memory_group;
>  struct resource;
>  struct vmem_altmap;
> @@ -352,7 +351,6 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  extern void remove_pfn_range_from_zone(struct zone *zone,
>  				       unsigned long start_pfn,
>  				       unsigned long nr_pages);
> -extern bool is_memblock_offlined(struct memory_block *mem);
>  extern int sparse_add_section(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2fd45ccbce45..9ae1f98548b1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1969,11 +1969,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  {
> -	int ret = !is_memblock_offlined(mem);
>  	int *nid = arg;
>  
>  	*nid = mem->nid;
> -	if (unlikely(ret)) {
> +	if (unlikely(mem->state != MEM_OFFLINE)) {
>  		phys_addr_t beginpa, endpa;
>  
>  		beginpa = PFN_PHYS(section_nr_to_pfn(mem->start_section_nr));
