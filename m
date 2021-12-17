Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB63947960B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhLQVN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:13:58 -0500
Received: from foss.arm.com ([217.140.110.172]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236219AbhLQVN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:13:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC88511FB;
        Fri, 17 Dec 2021 13:13:56 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63DA93F73B;
        Fri, 17 Dec 2021 13:13:54 -0800 (PST)
Message-ID: <d23b1c54-4047-79b3-d283-b584b6dd1e1c@arm.com>
Date:   Fri, 17 Dec 2021 21:13:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
 <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
 <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
 <836fd983-463c-040d-beb3-fee3faf215d6@arm.com>
 <CAL_JsqJM=dDxqEnnwbRLiemLS0XUqEe6RBZViLem8qoiDbPPjw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAL_JsqJM=dDxqEnnwbRLiemLS0XUqEe6RBZViLem8qoiDbPPjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 19:35, Rob Herring wrote:
> On Fri, Dec 17, 2021 at 1:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-12-17 18:14, Rob Herring wrote:
>>> On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 2021-12-16 23:31, Rob Herring wrote:
>>>>> Use the minimum CPU h/w id of the CPUs associated with the cache for the
>>>>> cache 'id'. This will provide a stable id value for a given system. As
>>>>> we need to check all possible CPUs, we can't use the shared_cpu_map
>>>>> which is just online CPUs. There's not a cache to CPUs mapping in DT, so
>>>>> we have to walk all CPU nodes and then walk cache levels.
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
>>> While the ACPI folks may be willing to take an arbitrary index, it's
>>> something we (mostly) avoid for DT.
>>
>> Not really. On the CHI side there are two fields - StashNID, which could
>> be any node ID value depending on the interconnect layout, plus
>> (optionally) StashLPID to address a specific cache within that node if
>> it's something like a CPU cluster. However, how a PCIe TLP steering tag
>> translates to those fields in the resulting CHI flit is largely up to
>> the root complex.
> 
> Knowing next to nothing about CHI, this means pretty much nothing to me. :(
> 
> I would guess there is a bit more to supporting CHI in DT systems than
> just a cache ID.

I use CHI as an example because it's what I'm familiar with, and my 
involvement in cache stashing discussions has been in the context of Arm 
CMN interconnects which are CHI-based. Other folks who build their own 
interconnects may have different details of how exactly they support 
cache stashing, but the overall point is that the required IDs are 
typically going to boil down to some amount (likely around 8-16 bits or 
so) of address-like information in a system-specific format which can't 
be reasoned about beyond that.

>> I think it's going to be more like a "reg" property than a nice
>> validatable index.
>>
>>>> That said, I think it does make sense to have some kind of
>>>> auto-generated fallback scheme *as well*, since I'm sure there will be
>>>> plenty systems which care about MPAM but don't support stashing, and
>>>> therefore wouldn't have a meaningful set of IDs to populate their DT
>>>> with. Conversely I think that might also matter for ACPI too - one point
>>>> I remember from previous discussions is that PPTT may use a compact
>>>> representation where a single entry represents all equivalent caches at
>>>> that level, so I'm not sure we can necessarily rely on IDs out of that
>>>> path being unique either.
>>>
>>> AIUI, cache ids break the compact representation.
>>
>> Right, firmware authors can't use it if they do want to specify IDs, but
>> that also means that if we find we *are* consuming a compact PPTT, then
>> chances are we're not getting meaningful IDs out of it for MPAM to rely on.
> 
> Sounds like broken firmware is in our future. ;) Or ACPI can default
> to the same id scheme.

I don't really see this being an opportunity for firmware to be any more 
broken than usual. Systems that support cache stashing will need to 
provide the correct hardware IDs for targetable caches via their 
firmware tables, which it seems that MPAM's notion of cache IDs will 
have to coexist with. Systems that do not support cache stashing may not 
even have a meaningful notion of hardware IDs for caches, and thus 
cannot be expected to provide any in firmware. Linux will need to cope 
with both situations.

Thanks,
Robin.
