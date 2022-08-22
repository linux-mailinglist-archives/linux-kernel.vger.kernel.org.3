Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6A59CA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiHVVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiHVVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB034DB20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDB66130E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E194C433D6;
        Mon, 22 Aug 2022 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661202729;
        bh=Fob4wOawfexzSqxQdwOiADupO6h8B7U7Zo0u31z1Jh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgPNbyAFhac1cFIK1UmYPJEbzphu7GYXX3XxbTHNHnxsCcXK8tftvjtayw3CwiwzV
         Od9gAs/jNV9ItutoEOQ7/JtI2gEiUGfew9atrghdaW/Nx9G29fMQHlwTN96mTutPuj
         nvUZVccKsOtPeaHaVLMKOBJNm4tNbwH4Mrw8S7f8=
Date:   Mon, 22 Aug 2022 14:12:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-Id: <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
In-Reply-To: <20220822033354.952849-1-liushixin2@huawei.com>
References: <20220822023311.909316-1-liushixin2@huawei.com>
        <20220822033354.952849-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> The page on pcplist could be used, but not counted into memory free or
> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> significant decrease in the display of free memory, with a large number
> of cpus and zones, the number of pages in the percpu list can be very
> large, so it is better to let user to know the pcp count.
> 
> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
> After the patch, the lists can hold 324MB. It has been observed to be 114MB
> in the idle state after system startup in practice(increased 80 MB).
> 

Seems reasonable.

> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 033f1e26d15b..f89928d3ad4e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5853,6 +5853,26 @@ static unsigned long nr_free_zone_pages(int offset)
>  	return sum;
>  }
>  
> +static unsigned long nr_free_zone_pcplist_pages(struct zone *zone)
> +{
> +	unsigned long sum = 0;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +	return sum;
> +}
> +
> +static unsigned long nr_free_pcplist_pages(void)
> +{
> +	unsigned long sum = 0;
> +	struct zone *zone;
> +
> +	for_each_zone(zone)
> +		sum += nr_free_zone_pcplist_pages(zone);
> +	return sum;
> +}

Prevention of races against zone/node hotplug?


