Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6349D051
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiAZREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236906AbiAZREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643216694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwa98kLwm7nYqRC6cI7ESxbaB6AVzjv7cFEbXLzP3ak=;
        b=KIh7+YJkDBEWlz9PyVNUdJOj7Z2iexOgvWybMyi+qO44ley8Fw8YuhdbcW5M4VVHzsxZol
        L7QGMe6b9o0Z6IdM1UV5NOdM1e2j38wBtOmiwLFCbhHKq0T3ASmynDMYvhh5YJPyavSbE9
        yi4PeaoaOM+uoeh7+zynY8HvLFL5A5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-6cjBItxYP8qDuAUGM-wP6Q-1; Wed, 26 Jan 2022 12:04:52 -0500
X-MC-Unique: 6cjBItxYP8qDuAUGM-wP6Q-1
Received: by mail-wm1-f71.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so2789366wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gwa98kLwm7nYqRC6cI7ESxbaB6AVzjv7cFEbXLzP3ak=;
        b=2SEcBeNnWg1Mb2OMx6Pf1ckDVhACxxp6l0AvBb76OIkKVEgypMMdsTuxDTBQxUaaCq
         l7d7eqyQCW07kCWYoYN6DXIqWSCBLMtG2O2ovjIrY4aDTDpconMzn4WsqTTdFZA2eQBQ
         wapIGhr6kC68XmB7aeKqffzKFAy5TsM83pxl8ldt/xQiegPI+HtnI9eYMrVepkIwUfMp
         6Q2NmuIQCNNdQSkUee5x/SAEeonGaWqHUAoBju4BGFKIhNSpaCEFh0TnpjS5qfHXFT1h
         x+7zY4JFwwH53foKAA7IE6S9gzQFFzi2MuKerD2Rlq851J3XP2xdKDOMlQieyNhdQb3L
         ijhw==
X-Gm-Message-State: AOAM531WFVR3Z9r2nN+SRFn59g9lYjr4iCD4JvOixc2bDhJDq6gdh/1k
        mK4YFOVWbtAZ/mY0kSCgoOwFS8D97xzb1v5mH6UT/eEIlJ986lJ3x2OP1o3Cd1Qw2ROaIuwe3Zl
        cDUG4ewYEkHQloPT7oWTvu9i+
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr8239520wmq.44.1643216691630;
        Wed, 26 Jan 2022 09:04:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjYRe8qd4oL3XeIOjwZ0wQOG++PDBifi1p0jHOTEAgc1zZH/Pn7uUsMrNVjFv7dXnGTuRIdg==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr8239502wmq.44.1643216691405;
        Wed, 26 Jan 2022 09:04:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id t4sm20135457wro.71.2022.01.26.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:04:50 -0800 (PST)
Message-ID: <5d02ea0e-aca6-a64b-23de-bc9307572d17@redhat.com>
Date:   Wed, 26 Jan 2022 18:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] mm/memory_hotplug: Export shrink span functions for
 zone and node
Content-Language: en-US
To:     Jonghyeon Kim <tome01@ajou.ac.kr>, dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        akpm@linux-foundation.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220126170002.19754-1-tome01@ajou.ac.kr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220126170002.19754-1-tome01@ajou.ac.kr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 18:00, Jonghyeon Kim wrote:
> Export shrink_zone_span() and update_pgdat_span() functions to head
> file. We need to update real number of spanned pages for NUMA nodes and
> zones when we add memory device node such as device dax memory.
> 

Can you elaborate a bit more what you intend to fix?

Memory onlining/offlining is reponsible for updating the node/zone span,
and that's triggered when the dax/kmem mamory gets onlined/offlined.

> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> ---
>  include/linux/memory_hotplug.h | 3 +++
>  mm/memory_hotplug.c            | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index be48e003a518..25c7f60c317e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -337,6 +337,9 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  extern void remove_pfn_range_from_zone(struct zone *zone,
>  				       unsigned long start_pfn,
>  				       unsigned long nr_pages);
> +extern void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> +			     unsigned long end_pfn);
> +extern void update_pgdat_span(struct pglist_data *pgdat);
>  extern bool is_memblock_offlined(struct memory_block *mem);
>  extern int sparse_add_section(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9627dc784c..38f46a9ef853 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -389,7 +389,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>  	return 0;
>  }
>  
> -static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> +void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  			     unsigned long end_pfn)
>  {
>  	unsigned long pfn;
> @@ -428,8 +428,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(shrink_zone_span);

Exporting both as symbols feels very wrong. This is memory
onlining/offlining internal stuff.



-- 
Thanks,

David / dhildenb

