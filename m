Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623AF47921C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhLQQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:57:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbhLQQ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:57:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D84C1042;
        Fri, 17 Dec 2021 08:57:14 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBED83F774;
        Fri, 17 Dec 2021 08:57:12 -0800 (PST)
Message-ID: <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
Date:   Fri, 17 Dec 2021 16:57:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20211216233125.1130793-1-robh@kernel.org>
 <20211216233125.1130793-3-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211216233125.1130793-3-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2021-12-16 23:31, Rob Herring wrote:
> Use the minimum CPU h/w id of the CPUs associated with the cache for the
> cache 'id'. This will provide a stable id value for a given system. As
> we need to check all possible CPUs, we can't use the shared_cpu_map
> which is just online CPUs. There's not a cache to CPUs mapping in DT, so
> we have to walk all CPU nodes and then walk cache levels.

I believe another expected use of the cache ID exposed in sysfs is to 
program steering tags for cache stashing (typically in VFIO-based 
userspace drivers like DPDK so we can't realistically mediate it any 
other way). There were plans afoot last year to ensure that ACPI PPTT 
could provide the necessary ID values for arm64 systems which will 
typically be fairly arbitrary (but unique) due to reflecting underlying 
interconnect routing IDs. Assuming that there will eventually be some 
interest in cache stashing on DT-based systems too, we probably want to 
allow for an explicit ID property on DT cache nodes in a similar manner.

That said, I think it does make sense to have some kind of 
auto-generated fallback scheme *as well*, since I'm sure there will be 
plenty systems which care about MPAM but don't support stashing, and 
therefore wouldn't have a meaningful set of IDs to populate their DT 
with. Conversely I think that might also matter for ACPI too - one point 
I remember from previous discussions is that PPTT may use a compact 
representation where a single entry represents all equivalent caches at 
that level, so I'm not sure we can necessarily rely on IDs out of that 
path being unique either.

Robin.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Loop with for_each_possible_cpu instead of for_each_of_cpu_node as
>     we will need the logical cpu numbers.
> ---
>   drivers/base/cacheinfo.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 66d10bdb863b..21accddf8f5f 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -136,6 +136,36 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
>   	return of_property_read_bool(np, "cache-unified");
>   }
>   
> +static void cache_of_set_id(struct cacheinfo *this_leaf, struct device_node *np)
> +{
> +	int cpu;
> +	unsigned long min_id = ~0UL;
> +
> +	for_each_possible_cpu(cpu) {
> +		u64 id;
> +		struct device_node *cache_node, *cpu_node;
> +
> +		cache_node = cpu_node = of_get_cpu_node(cpu, NULL);
> +		id = of_get_cpu_hwid(cpu_node, 0);
> +		while ((cache_node = of_find_next_cache_node(cache_node))) {
> +			if (cache_node == np) {
> +				if (id < min_id) {
> +					min_id = id;
> +					of_node_put(cache_node);
> +					break;
> +				}
> +			}
> +			of_node_put(cache_node);
> +		}
> +		of_node_put(cpu_node);
> +	}
> +
> +	if (min_id != ~0UL) {
> +		this_leaf->id = min_id;
> +		this_leaf->attributes |= CACHE_ID;
> +	}
> +}
> +
>   static void cache_of_set_props(struct cacheinfo *this_leaf,
>   			       struct device_node *np)
>   {
> @@ -151,6 +181,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
>   	cache_get_line_size(this_leaf, np);
>   	cache_nr_sets(this_leaf, np);
>   	cache_associativity(this_leaf);
> +	cache_of_set_id(this_leaf, np);
>   }
>   
>   static int cache_setup_of_node(unsigned int cpu)
