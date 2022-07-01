Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109C563315
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiGAMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiGAMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:01:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19B8583F2C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:01:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4AB113E;
        Fri,  1 Jul 2022 05:01:39 -0700 (PDT)
Received: from [10.57.85.162] (unknown [10.57.85.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E838D3F792;
        Fri,  1 Jul 2022 05:01:36 -0700 (PDT)
Message-ID: <1eeeec76-5271-f915-e3fd-f15095efb981@arm.com>
Date:   Fri, 1 Jul 2022 13:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, Feng Tang <feng.tang@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
 <20220701035622.GB14806@shbuild999.sh.intel.com>
 <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-01 12:33, John Garry wrote:
> On 01/07/2022 04:56, Feng Tang wrote:
>>>> inclination.
>>>>
>>> ok, what you are saying sounds reasonable. I just remember that when we
>>> analyzed the longterm aging issue that we concluded that the FQ size 
>>> and its
>>> relation to the magazine size was a factor and this change makes me a 
>>> little
>>> worried about new issues. Better the devil you know and all that...
>>>
>>> Anyway, if I get some time I might do some testing to see if this 
>>> change has
>>> any influence.
>>>
>>> Another thought is if we need even store the size in the 
>>> iova_magazine? mags
>>> in the depot are always full. As such, we only need worry about mags 
>>> loaded
>>> in the cpu rcache and their sizes, so maybe we could have something like
>>> this:
>>>
>>> struct iova_magazine {
>>> -       unsigned long size;
>>>         unsigned long pfns[IOVA_MAG_SIZE];
>>> };
>>>
>>> @@ -631,6 +630,8 @@ struct iova_cpu_rcache {
>>>         spinlock_t lock;
>>>         struct iova_magazine *loaded;
>>>         struct iova_magazine *prev;
>>> +       int loaded_size;
>>> +       int prev_size;
>>> };
>>>
>>> I haven't tried to implement it though..
>> I have very few knowledge of iova, so you can chose what's the better
>> solution. I just wanted to raise the problem and will be happy to see
>> it solved:)
> 
> I quickly tested your patch for performance and saw no noticeable 
> difference, which is no surprise.
> 
> But I'll defer to Robin if he thinks that your patch is a better 
> solution - I would guess that he does. For me personally I would prefer 
> that this value was not changed, as I mentioned before.

This idea is interesting, but it would mean a bit more fiddly work to 
keep things in sync when magazines are allocated, freed and swapped 
around. It seems like the kind of non-obvious thing that might make 
sense if it gave a significant improvement in cache locality or 
something like that, but for simply fixing an allocation size it feels a 
bit too wacky.

 From my perspective, indeed I'd rather do the simple thing for now to 
address the memory wastage issue directly, then we can do the deeper 
performance analysis on top to see if further tweaking of magazine sizes 
and/or design is justified.

Cheers,
Robin.
