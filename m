Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03165A6111
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiH3KtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiH3Ksz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFFDEA7D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661856528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sz4srs09/QpWeixG0gmN9bILh9AJeJA7X0RTBdy8P7Y=;
        b=ccgaK4vLHvTdh6x39X6cUAACEqppGTB9eopomzx5f6iLlbXrpNKejwtL8dykZjWPQHI61p
        bffqD91hqaVE2pK/v2R11VXWsGWXrWZgVs/0vnATlyVeMsXHWfKxisrs3wmhyk9Wqc9HbZ
        VY8K6FzSEyq8WkzjDjFGeSjiVCPVRuM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-9y8loiVFNKu60_mEmdlSGQ-1; Tue, 30 Aug 2022 06:48:47 -0400
X-MC-Unique: 9y8loiVFNKu60_mEmdlSGQ-1
Received: by mail-wm1-f69.google.com with SMTP id m22-20020a7bca56000000b003a652939bd1so1850755wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Sz4srs09/QpWeixG0gmN9bILh9AJeJA7X0RTBdy8P7Y=;
        b=HfVomhEkJBLmHYEM+jwudyv76gdapL3FGYnybODv8uIZ+1iLiPSleokjV2EaGYaS8L
         Zx47OQMYwy/gUy4Ga7i7nsdgGl1XMhhT/fl1gNtsl/UVLBlMcj16cm3FYLlJp29Y4Jb2
         lJnbYQRGbZvzWyiIRl1Q8SFVdBczpVv8BkyY5dQ26DgRXfjsDQzrGF3gGfobmIDWohR2
         KHtmNysUvmVU9ZAPRsdY0sba0AC6wRgAxhUeLSl9Qqdsq7m4xhyJjah88kFWi2d6tMwO
         O59dEbVmnye8xEhX/Lj6pripQYhgcYSsrnGGuSPkbvjdU4/hPMvfdZkzJnBDhXpV/SlV
         oA5w==
X-Gm-Message-State: ACgBeo3HRqD1mPM0Ki5V018Y37APo6MV7+ko9qEn/Kz5S3RDvNXlnnlk
        bM3DDora8ejHRTlgvZsmNlvME4k77TsI9w0rnLXHCsx0CyIwJFgeagIxhSp6SReZDpBI3x/MgNq
        B/8OiLMByXaaX//Ba9uRqzEx8
X-Received: by 2002:a5d:5e89:0:b0:226:d149:25e3 with SMTP id ck9-20020a5d5e89000000b00226d14925e3mr8696814wrb.597.1661856526033;
        Tue, 30 Aug 2022 03:48:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5K0SsZxQvvhMWnX/ASH1Felv6+t/7b/gE74TKt0G5s+NX3VFZ2KHV3NfUz8w/YGJYCKedISQ==
X-Received: by 2002:a5d:5e89:0:b0:226:d149:25e3 with SMTP id ck9-20020a5d5e89000000b00226d14925e3mr8696804wrb.597.1661856525804;
        Tue, 30 Aug 2022 03:48:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b003a8434530bbsm9301002wmg.13.2022.08.30.03.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:48:45 -0700 (PDT)
Message-ID: <e7840af3-4d8f-5f3d-65fb-3e580ba8c7f1@redhat.com>
Date:   Tue, 30 Aug 2022 12:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: kill is_memblock_offlined()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220827112043.187028-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220827112043.187028-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.22 13:20, Kefeng Wang wrote:
> Directly check state of struct memory_block, no need a single function.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

