Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499455A96AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiIAMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiIAMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:24:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9453C1223B2;
        Thu,  1 Sep 2022 05:24:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6248BD6E;
        Thu,  1 Sep 2022 05:24:32 -0700 (PDT)
Received: from [10.57.18.92] (unknown [10.57.18.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9643F7B4;
        Thu,  1 Sep 2022 05:24:53 -0700 (PDT)
Message-ID: <ccacc117-0be8-2cd3-480b-dcbca5485d6f@arm.com>
Date:   Thu, 1 Sep 2022 13:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
Content-Language: en-GB
To:     Dongli Zhang <dongli.zhang@oracle.com>, Yu Zhao <yuzhao@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
 <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
 <CAOUHufYHh3B6A8_pAusnW5==r3VhPxy6bOoUHbxe0qvhNGovqA@mail.gmail.com>
 <982a4b95-0ab5-f18e-cbaf-1f503a35ada7@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <982a4b95-0ab5-f18e-cbaf-1f503a35ada7@oracle.com>
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

On 2022-09-01 03:18, Dongli Zhang wrote:
> Hi Yu,
> 
> On 8/31/22 5:24 PM, Yu Zhao wrote:
>> On Wed, Aug 31, 2022 at 4:20 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>
>>> Hi Yu,
>>>
>>> As we discussed in the past, the swiotlb panic on purpose
>>
>> We should not panic() at all, especially on a platform that has been
>> working well since at least 4.14.
>>
>> Did you check out this link I previously shared with you?
>> https://urldefense.com/v3/__https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld*pnerc4J2Ag990WwAA@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!PXzSLurBv7VqxI1451TV4zO3_-BYj4grk-HYBsXzSnA6nZcXaBzdsQ-rF2DAqlICSRPMt-efYv_Uu2A2CQ$
> 
> Thanks for sharing! I used to read that in the past. To be honest I am still
> confused on when to use BUG/panic and when to not, as I still see many usage in
> some patches.
> 
> Just about swiotlb, it may panic in many cases during boot, e.g.,:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1955655

That's really a different thing, but frankly that panic is also bogus 
anyway - there is no good reason to have different behaviour for failing 
to allocate a buffer slot because the buffer is full vs. failing to 
allocate a buffer slot because there is no buffer. If we can fail 
gracefully some of the time we should fail gracefully all of the time. 
Yes, there's a slight difference in that one case has a chance of 
succeeding if retried in future while the other definitely doesn't, but 
it's not SWIOTLB's place to decide that the entire system is terminally 
unusable just because some device can't make a DMA mapping.

Similarly for the other panics at init time, which seem to have 
originated from a mechanical refactoring of the memblock API with the 
expectation of preserving the existing behaviour at the time. Those have 
then just been moved around without anyone thinking to question why 
they're there, and if memblock *does* now return usable error 
information, why don't we start handling that error properly like we do 
in other init paths?

Really there is no reason to panic anywhere in SWIOTLB. This is old 
code, things have moved on over the last 20 years, and we can and should 
do much better. I'll add this to my list of things to look at for 
cleanup once I find a bit of free time, unless anyone else fancies 
taking it on.

Thanks,
Robin.
