Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81806561572
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiF3Iwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiF3IwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:52:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF80C427E9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:52:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE561BF7;
        Thu, 30 Jun 2022 01:52:20 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF03E3F5A1;
        Thu, 30 Jun 2022 01:52:18 -0700 (PDT)
Message-ID: <2cf27cd6-5cb9-57e7-dc52-e39f37945343@arm.com>
Date:   Thu, 30 Jun 2022 09:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Joerg Roedel <jroedel@suse.de>
References: <20220630014715.73330-1-feng.tang@intel.com>
 <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
 <20220630023844.GA4668@shbuild999.sh.intel.com>
 <20220629194747.62effc10a994f67e26fe96af@linux-foundation.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220629194747.62effc10a994f67e26fe96af@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 03:47, Andrew Morton wrote:
> On Thu, 30 Jun 2022 10:38:44 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
>> Hi Andrew,
>>
>> Thanks for the review!
>>
>> On Wed, Jun 29, 2022 at 07:30:06PM -0700, Andrew Morton wrote:
>>> On Thu, 30 Jun 2022 09:47:15 +0800 Feng Tang <feng.tang@intel.com> wrote:
>>>
>>>> kmalloc's API family is critical for mm, with one shortcoming that
>>>> its object size is fixed to be power of 2. When user requests memory
>>>> for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
>>>> in worst case, there is around 50% memory space waste.
>>>>
>>>> We've met a kernel boot OOM panic, and from the dumped slab info:
>>>>
>>>>      [   26.062145] kmalloc-2k            814056KB     814056KB
>>>>
>>>> >From debug we found there are huge number of 'struct iova_magazine',
>>>> whose size is 1032 bytes (1024 + 8), so each allocation will waste
>>>> 1016 bytes. Though the issue is solved by giving the right(bigger)
>>>> size of RAM, it is still better to optimize the size (either use
>>>> a kmalloc friendly size or create a dedicated slab for it).
>>>
>>> Well that's nice, and additional visibility is presumably a good thing.
>>>
>>> But what the heck is going on with iova_magazine?  Is anyone looking at
>>> moderating its impact?
>>
>> Yes, I have a very simple patch at hand
>>
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -614,7 +614,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>    * dynamic size tuning described in the paper.
>>    */
>>   
>> -#define IOVA_MAG_SIZE 128
>> +#define IOVA_MAG_SIZE 127
> 
> Well OK.  Would benefit from a comment explaining the reasoning.
> 
> But we still have eleventy squillion of these things in flight.  Why?

They're storage for a per-CPU caching scheme - for n CPUs, there should 
currently be (2n + 32) * 6 in flight, since there's one set for each of 
6 sizes. The 32 really should be n or 2n as well since it's needlessly 
large for small systems and a bottleneck for large ones, but it needs 
some unpicking to allow for dynamic allocations.

Thanks,
Robin.
