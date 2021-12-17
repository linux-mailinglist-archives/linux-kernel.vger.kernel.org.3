Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D76479575
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhLQU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:28:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235287AbhLQU2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:28:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B61A12FC;
        Fri, 17 Dec 2021 12:28:51 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07A963F5A1;
        Fri, 17 Dec 2021 12:28:51 -0800 (PST)
Message-ID: <a6067bf9-5d68-8112-cf42-4928548d8f94@arm.com>
Date:   Fri, 17 Dec 2021 14:28:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
 <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
 <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
 <20211217190345.kskfhnelqg3yx4j7@bogus>
 <CAL_JsqJSz7D_KO_ueQum51erBHotMkAt+qJfTTctkxSvySWq1w@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAL_JsqJSz7D_KO_ueQum51erBHotMkAt+qJfTTctkxSvySWq1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/17/21 13:26, Rob Herring wrote:
> On Fri, Dec 17, 2021 at 1:03 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Fri, Dec 17, 2021 at 12:14:22PM -0600, Rob Herring wrote:
>>> On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 2021-12-16 23:31, Rob Herring wrote:
>>>>> Use the minimum CPU h/w id of the CPUs associated with the cache for the
>>>>> cache 'id'. This will provide a stable id value for a given system. As
>>
>> I am trying to follow the code. IIUC, the level one(I$ and D$) are skipped
>> in this logic and the private unified cache if any will get the cpu hwid as
>> the cache id which is all fine. But what happens if there are 2 levels of
>> unified private cache ? I am assuming we only care about shared caches for
>> MPAM and ignore private caches which sounds OK but I just wanted to confirm.
> 
> The cacheinfo 'id' is only unique to the level and type. It's the
> type, level, and ID that gives a unique identifier:
> 
>   * struct cacheinfo - represent a cache leaf node
>   * @id: This cache's id. It is unique among caches with the same (type, level).
> 
> Maybe ACPI's ID expects/allows globally unique cache IDs?

Yes, but the spec is IMHO written in a way that they may only be unique 
for a subset of the caches! The rest might not have an ID at all, 
particularly for !arm machines.


> 
>>>>> we need to check all possible CPUs, we can't use the shared_cpu_map
>>>>> which is just online CPUs. There's not a cache to CPUs mapping in DT, so
>>>>> we have to walk all CPU nodes and then walk cache levels.
>>
>> I would have preferred to add the cache IDs in DT similar to ACPI but I see
>> you have certain concerns with that which are valid as well.
>>
>>>>
>>>> I believe another expected use of the cache ID exposed in sysfs is to
>>>> program steering tags for cache stashing (typically in VFIO-based
>>>> userspace drivers like DPDK so we can't realistically mediate it any
>>>> other way). There were plans afoot last year to ensure that ACPI PPTT
>>>> could provide the necessary ID values for arm64 systems which will
>>>> typically be fairly arbitrary (but unique) due to reflecting underlying
>>>> interconnect routing IDs. Assuming that there will eventually be some
>>>> interest in cache stashing on DT-based systems too, we probably want to
>>>> allow for an explicit ID property on DT cache nodes in a similar manner.
>>>
>>> If you have a suggestion for ID values that correspond to the h/w,
>>> then we can add them. I'd like a bit more than just trusting that ID
>>> is something real.
>>>
>>
>> I agree, probably architecture must do better job at defining these. But
>> generated IDs IMO might cause issues especial if we have to change the
>> logic without breaking the backward compatibility.
>>
>>> While the ACPI folks may be willing to take an arbitrary index, it's
>>> something we (mostly) avoid for DT.
>>>
>>
>> Not sure if we can call that *arbitrary* 😄, in that case we can imagine
>> the same at several places in the firmware.
> 
> By arbitrary, I mean made up by the binding/dts author or
> documentation convention (UART0, UART1, etc.). Certainly things like
> clock IDs are often made up number spaces, but I don't see how we
> avoid that. DT had 'cell-index' which I still see attempted. But that
> property traces back to h/w having a single power ctrl register and
> cell-index was the bit index for the register. If only h/w was still
> that simple.
> 
> Rob
> 

