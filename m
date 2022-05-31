Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A65389F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiEaCcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbiEaCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:32:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF795205F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:32:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84CF423A;
        Mon, 30 May 2022 19:32:14 -0700 (PDT)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CB83F66F;
        Mon, 30 May 2022 19:32:08 -0700 (PDT)
Message-ID: <a13e6456-4ec7-de5b-71a8-3693364fc01b@arm.com>
Date:   Tue, 31 May 2022 08:02:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: enable THP_SWAP for arm64
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5n?= =?UTF-8?Q?=29?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220527100644.293717-1-21cnbao@gmail.com>
 <b2694573-a696-8435-70eb-ebc9c06500a0@arm.com>
 <CAGsJ_4yF_5DvBuvNfsUcywv8uzXHy2x9saVdhXz8xh=wvt01iA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAGsJ_4yF_5DvBuvNfsUcywv8uzXHy2x9saVdhXz8xh=wvt01iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 15:23, Barry Song wrote:
> On Mon, May 30, 2022 at 7:07 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Hello Barry,
> 
> Hi Anshuman,
> thanks!
> 
>>
>> On 5/27/22 15:36, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> THP_SWAP has been proved to improve the swap throughput significantly
>>> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
>>> splitting THP after swapped out").
>> It will be useful to run similar experiments on arm64 platform to
>> demonstrate tangible benefit, else we might be just enabling this
>> feature just because x86 has it. Do you have some data points ?
>>
>>> As long as arm64 uses 4K page size, it is quite similar with x86_64
>>> by having 2MB PMD THP. So we are going to get similar improvement.
>>
>> This is an assumption without any data points (until now). Please
>> do provide some results.
> 
> Fair enough though I believe THP_SWP is arch-independent. Our testing
> will post data. Plus, we do need it for real use cases with some possible
> out-of-tree code for this moment. so this patch does not originate only
> because x86 has it :-)

I understand, but as you mentioned some data here will be helpful.

> 
>>
>>> For other page sizes such as 16KB and 64KB, PMD might be too large.
>>> Negative side effects such as IO latency might be a problem. Thus,
>>> we can only safely enable the counterpart of X86_64.
>>
>> Incorrect reasoning. Although sometimes it might be okay to enable
>> a feature on platforms with possible assumptions about its benefits,
>> but to claim 'similar improvement, safely, .. etc' while comparing
>> against x86 4K page config without data points, is not very helpful.
>>
>>> A corner case is that MTE has an assumption that only base pages
>>> can be swapped. We won't enable THP_SWP for ARM64 hardware with
>>> MTE support until MTE is re-arched.
>>
>> re-arched ?? Did you imply that MTE is reworked to support THP ?
> 
> I think at least MTE should be able to coexist with THP_SWP though
> I am not quite sure if MTE can be re-worked to fully support THP.

Understood but I just wanted the wording above in the commit message
to be changed to literally anything other than 're-arched'.
