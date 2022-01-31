Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74E4A4640
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbiAaLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378623AbiAaLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643629373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOXTBxgzYYVn2QXCw8QZ7CKKTkbQpmyv4faAp7utGos=;
        b=eum+H/QbqYfhlRdjqS5ibpZtIdcmMuJvweyl3eOjrDinT+a+Y0RJI3G+egjTZ0C8RILoiN
        t/Fxb1suqrlMrRfcLZ1eiHtMjR7owifmcJiutHiXFzYiRRGmrCqwfiNmONJVtGt5RpqsHv
        V0EK4+aN8v0jt5E2Q0onng1+VWgVFaw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-n2qmrTTxNcGemT-P4jGXng-1; Mon, 31 Jan 2022 06:42:51 -0500
X-MC-Unique: n2qmrTTxNcGemT-P4jGXng-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso5696888wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tOXTBxgzYYVn2QXCw8QZ7CKKTkbQpmyv4faAp7utGos=;
        b=X50Wu1RQK7+t+FfHxqjJqS7KQ4jIfmy2OCxEHiRZb6n45q5ewHGuTBIqEHHSG8mtUn
         sP//xXOcwNW4tWbIWWT1SD6GNnohHHX9nw9BorZEbUG2Ywh0HEfly9Cac6vll+EPeWcz
         EsSE+dwEicpy3onffiOgXcCtb0oRDQ1Qycdyyxtyr7Xc99Ob8NiLt6RknL5nMJPiXO7u
         O7gDK5XXa5e9HF5a+eMA3rh0TAIBExaLNrQJkvHieiswOy+oefK5fkgFu8B2OIkiUZAl
         LwmtCWJRxljXCx7hIeO2DXAnE80fL6Nv29EIeRaqBiA7PTOiwZFm51lVIM3M0WEUFRVN
         06+A==
X-Gm-Message-State: AOAM532x0PAuRTlgeD+zZezqnrR1bi0d66GEfVKxB0ubUJjtTCS8WvOj
        0b4B7LjrNcluqf8Q164hcAzj1zHI9p074D29EsZNWHfFi5VdDJly9RkCT9sjdZxowTKFOFEo48n
        6++reBQ1AiGVjmik4Gv6VbD8l
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr16978180wrx.79.1643629370769;
        Mon, 31 Jan 2022 03:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjql6TSVUvnRyPm35redu5/e4PWa1U/B9bmeapBfHVIbbP+l6wLhWfKJGgA94bnq+AKH3PpA==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr16978162wrx.79.1643629370542;
        Mon, 31 Jan 2022 03:42:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id k12sm11958920wrd.110.2022.01.31.03.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 03:42:50 -0800 (PST)
Message-ID: <10293d6c-c2d6-2277-0634-bdd237fc23de@redhat.com>
Date:   Mon, 31 Jan 2022 12:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
References: <20220128152620.168715-1-david@redhat.com>
 <20220128152620.168715-3-david@redhat.com> <20220131112909.GB18027@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220131112909.GB18027@linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...] having accidentally skipped two comments.


> 
>> There are three scenarios to handle:
> ...
> ...
> 
>> @@ -225,6 +226,9 @@ static int memory_block_offline(struct memory_block *mem)
>>  	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
>>  	int ret;
>>  
>> +	if (!mem->zone)
>> +		return -EBUSY;
> 
> Should not we return -EINVAL? I mean, -EBUSY reads like this might be a
> temporary error which might get fixed later on, but that isn't the case.

We should, and I could have sworn I fixed that up last-minute.

>> +static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
>> +						     int nid)
>> +{
>> +	const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>> +	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>> +	struct zone *zone, *matching_zone = NULL;
>> +	pg_data_t *pgdat = NODE_DATA(nid);
> 
> I was about to complain because in init_memory_block() you call
> early_node_zone_for_memory_block() with nid == NUMA_NODE_NODE, but then
> I saw that NODE_DATA on !CONFIG_NUMA falls to contig_page_data.
> So, I guess we cannot really reach this on CONFIG_NUMA machines with nid
> being NUMA_NO_NODE, right? (do we want to add a check just in case?)
> 
>> +#ifdef CONFIG_NUMA
>> +void memory_block_set_nid(struct memory_block *mem, int nid,
>> +			  enum meminit_context context)
> 
> But we also set the zone? (Only for boot memory)

Yes, it's derived from the node internally, though, and not supplied
explicitly. Renaming it could be misleading IMHO.

-- 
Thanks,

David / dhildenb

