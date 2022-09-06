Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2950C5AF38D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIFS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIFS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:26:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25AE09AF8D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:26:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080E41042;
        Tue,  6 Sep 2022 11:26:23 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130353F534;
        Tue,  6 Sep 2022 11:26:14 -0700 (PDT)
Message-ID: <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
Date:   Tue, 6 Sep 2022 19:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
 <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-06 18:36, John Garry wrote:
>>>>
>>>> iommu_probe_device
>>>>    ops->probe_finalize(dev);
>>>>      intel_iommu_probe_finalize
>>>>         iommu_setup_dma_ops
>>>>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>>>>             iova_domain_init_rcaches
>>>>               {
>>>>               ...
>>>>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>>>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>>>>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>>>>                  ret = -ENOMEM;
>>>>                        goto out_err;
>>>>
>>>> Do you mean iova_magazine_alloc() is impossible to fail ?
>>>
>>> No, iova_magazine_alloc() may fail and return NULL. But if it does 
>>> then we set iovad rcache pointer = NULL in the error path and don't 
>>> use the rcache.
>>>
>>> However we have a !iovad->rcache check on the "fast" alloc but not 
>>> "insert". I need to check why that is again.
>>
>> Right, if you find a good reason to respin the patch then perhaps also 
>> tweaking the commit message to clarify that it's impossible to have a 
>> NULL rcache *at any point where those checks are made* might avoid all 
>> possible doubt, however I'd hope that it's clear enough that the 
>> transient case while iova_domain_init_rcaches() is in the process of 
>> failing really doesn't need consideration in its own right.
> 
> Yeah, I would think so. But I still don't mind tweaking it to be extra 
> clear.
> 
>>
>> I guess the check in iova_rcache_get() was maybe with the intent of 
>> allowing alloc_iova_fast() to seamlessly fall back to standard 
>> allocation, so an API user can treat iova_domain_init_rcaches() 
>> failure as non-fatal?
> 
> The 2x users treat iova_domain_init_rcaches() as fatal:
> - dma-iommu falls back to platform ops in iommu_setup_dma_ops()
> 
> Caveat: on the chance that the IOVA domain init fails due to the rcache 
> init failing, then, if there were another device in the group which 
> probes later, its probe would be ok as the start_pfn is set. Not Good.

Yeah, there's a lot not to like about iommu_dma_init_domain() - I've 
been banking on it all getting cleaned up when I get to refactoring that 
area of probing (remember the issue you reported years ago with PCI 
groups being built in the wrong order? All related...), but in fact 
since the cookie management got pulled into core code, we can probably 
tie the IOVA domain setup to that right now without much other 
involvement. That could be a cheap win, so I'll give it a go soon.

> - vdpa just fails to create the domain in vduse_domain_create()
> 
>> That makes a fair amount of sense, but does mean that we're missing 
>> the equivalent in iova_rcache_insert() for it to actually work. Or we 
>> just remove it and tighten up the documentation to say that's not valid 
> 
> I'd be more inclined to remove it. I would rather remove fathpath checks 
> as much as possible and have robust error handling in the domain init.
> 
> Afterall I do have the "remove check" craze going.

Sure, like I say I'm happy to be consistent either way. If I do end up 
reinstating such a check I think I'd prefer to have it explicit in 
{alloc,free}_iova_fast() anyway, rather than buried in internal 
implementation details.

Cheers,
Robin.
