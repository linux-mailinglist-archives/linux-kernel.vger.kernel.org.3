Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A2B4ED9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiCaMbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiCaMa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:30:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C13E65789;
        Thu, 31 Mar 2022 05:29:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713D223A;
        Thu, 31 Mar 2022 05:29:10 -0700 (PDT)
Received: from [10.57.73.181] (unknown [10.57.73.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9B9A3F718;
        Thu, 31 Mar 2022 05:29:06 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
To:     Ali Saidi <alisaidi@amazon.com>, leo.yan@linaro.org
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@kernel.org, kjain@linux.ibm.com,
        lihuafei1@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
 <20220329143214.12707-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4710b4b2-5dcd-00a4-3976-1bd5340f401d@arm.com>
Date:   Thu, 31 Mar 2022 13:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220329143214.12707-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It seems I gave the Review tags a bit too early this time. Apologies for
the inconvenience. Indeed there was more interesting discussions to be
had :)

(Probably best to remove by tags for the next re-spin)

On 29/03/2022 15:32, Ali Saidi wrote:
> [...]
>
>> I still think we should consider to extend the memory levels to
>> demonstrate clear momory hierarchy on Arm archs, I personally like the
>> definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
>> though these cache levels are not precise like L1/L2/L3 levels, they can
>> help us to map very well for the cache topology on Arm archs and without
>> any confusion.  We could take this as an enhancement if you don't want
>> to bother the current patch set's upstreaming.
> I'd like to do this in a separate patch, but I have one other proposal. The
> Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
> it's also in the L2. Given that the Graviton systems and afaik the Ampere
> systems don't have any cache between the L2 and the SLC, thus anything from
> PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
> should just set L2 for these cases? German, are you good with this for now? 

Sorry for the delay. I'd like to also check this with someone. I'll try
to get back asap. In the meantime, if this approach is also OK with Leo,
I think it would be fine by me.

Thanks,
German

>>>>>> For this data source type and below types, though they indicate
>>>>>> the snooping happens, but it doesn't mean the data in the cache line
>>>>>> is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
>>>>>> think this will mislead users when report the result.
>>>>> I'm of the opposite opinion. If the data wasn't modified, it will likely be
>>>>> found in the lower-level shared cache and the transaction wouldn't require a
>>>>> cache-to-cache transfer of the modified data, so the most common case when we
>>>>> source a line out of another cores cache will be if it was "modifiable" in that
>>>>> cache. 
>>>> Let's still use MOSI protocol as example.  I think there have two
>>>> cases: on case is the peer cache line is in 'Shared' state and another
>>>> case is the peer cache line is in 'Owned' state.
>>>>
>>>> Quotes the wiki page for these two cases:
>>>>
>>>> "When the cache block is in the Shared (S) state and there is a
>>>> snooped bus read (BusRd) transaction, then the block stays in the same
>>>> state and generates no more transactions as all the cache blocks have
>>>> the same value including the main memory and it is only being read,
>>>> not written into."
>>>>
>>>> "While in the Owner (O) state and there is a snooped read request
>>>> (BusRd), the block remains in the same state while flushing (Flush)
>>>> the data for the other processor to read from it."
>>>>
>>>> Seems to me, it's reasonable to set HTIM flag when the snooping happens
>>>> for the cache line line is in the Modified (M) state.
>>>>
>>>> Again, my comment is based on the literal understanding; so please
>>>> correct if have any misunderstanding at here.
>>> Per the CMN TRM, "The SLC allocation policy is exclusive for data lines, except
>>> where sharing patterns are detected," so if a line is shared among caches it
>>> will likely also be in the SLC (and thus we'd get an L3 hit). 
>>>
>>> If there is one copy of the cache line and that cache line needs to transition
>>> from one core to another core, I don't believe it matters if it was truly
>>> modified or not because the core already had permission to modify it and the
>>> transaction is just as costly (ping ponging between core caches). This is the
>>> one thing I really want to be able to uniquely identify as any cacheline doing
>>> this that isn't a lock is a place where optimization is likely possible. 
>> I understood that your point that if big amount of transitions within
>> multiple cores hit the same cache line, it would be very likely caused
>> by the cache line's Modified state so we set PERF_MEM_SNOOP_HITM flag
>> for easier reviewing.
> And that from a dataflow perspective if the line is owned (and could be
> modifiable) vs. was actually modified is really the less interesting bit. 
>
>> Alternatively, I think it's good to pick up the patch series "perf c2c:
>> Sort cacheline with all loads" [1], rather than relying on HITM tag, the
>> patch series extends a new option "-d all" for perf c2c, so it displays
>> the suspecious false sharing cache lines based on load/store ops and
>> thread infos.  The main reason for holding on th patch set is due to we
>> cannot verify it with Arm SPE at that time point, as the time being Arm
>> SPE trace data was absent both store ops and data source packets.
> Looking at examples I don't, at least from my system, data-source isn't set for
> stores, only for loads. 
>
>> I perfer to set PERF_MEM_SNOOP_HIT flag in this patch set and we can
>> upstream the patch series "perf c2c: Sort cacheline with all loads"
>> (only needs upstreaming patches 01, 02, 03, 10, 11, the rest patches
>> have been merged in the mainline kernel).
>>
>> If this is fine for you, I can respin the patch series for "perf c2c".
>> Or any other thoughts?
> I think this is a nice option to have in the tool-box, but from my point of
> view, I'd like someone who is familiar with c2c output on x86 to come to an
> arm64 system and be able to zero in on a ping-ponging line like they would
> otherwise. Highlighting a line that is moving between cores frequently which is
> likely in the exclusive state by tagging it an HITM accomplishes this and will
> make it easier to find these cases.  Your approach also has innaccurancies and
> wouldn't be able to differentiate between core X accessing a line a lot followed
> by core Y acessing a line alot vs the cores ping-ponging.  Yes, I agree that we
> will "overcount" HITM, but I don't think this is particularly bad and it does
> specifically highlight the core-2-core transfers that are likely a performance
> issue easily and it will result in easier identification of areas of false or
> true sharing and improve performance.
>
> Thanks,
> Ali
