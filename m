Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554D4ADE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbiBHQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbiBHQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:36:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978C1C061576;
        Tue,  8 Feb 2022 08:36:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA6E1FB;
        Tue,  8 Feb 2022 08:36:36 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C50773F70D;
        Tue,  8 Feb 2022 08:36:34 -0800 (PST)
Message-ID: <4b1d6f80-db33-b2ea-7214-34b87a7e734c@arm.com>
Date:   Tue, 8 Feb 2022 16:36:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] add pmu to amlogic meson sm1
Content-Language: en-GB
To:     Benjamin Mordaunt <crawford.benjamin15@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
 <20220206144343.2194-1-crawford.benjamin15@gmail.com>
 <42c51f9d-d122-2d09-cdcd-f733cbc60d5b@baylibre.com>
 <65cde84a-8f8b-ac57-9b66-2b8d6378dbfa@arm.com>
 <CANtEDzSVxnUsC05Vhr5gG3KRBAX_X564ZiY2nBSoBFoy54RQ5w@mail.gmail.com>
 <a7adf12d-f949-9a95-9c6a-b73017107dc7@arm.com>
 <CANtEDzQDOiLKWW7c1VwnhjE-kjZ3tWYVKxBA4j1twOOjyEPcwQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CANtEDzQDOiLKWW7c1VwnhjE-kjZ3tWYVKxBA4j1twOOjyEPcwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-08 16:02, Benjamin Mordaunt wrote:
> Okay so this does appear to be behaving with some issues (unless I've
> just got 2 of the interrupt numbers wrong, but it seems unlikely at
> this stage).
> 
> CPUs 0 and 1 seem to be behaving somewhat sensibly, while `perf stat`
> reports `<not supported>` for caches and branches with CPUs 2 and 3.
> Would this suggest this implementation is indeed broken?

Taking a closer look, the interrupts for CPUs 2 and 3 here are clearly 
wrong since they already belong to some audio controllers in the DTSI. I 
looked up documentation and found an S905D3 manual from Khadas which 
documents SPI 137 (GIC interrupt 169) as "|PMUIRQ_a[3:0]", which I can't 
read as anything other than "logical OR of all 4 PMU IRQs". Not sure 
about SPI 138 but I'd guess it's something that just happens to fire in 
a manner that appears to sort of work for the PMU.

Sadly it looks like Neil's instinct was right and this one is also in 
fact dead, sorry :(

Robin.

> 
> Thanks,
> Ben
> 
> 
> On Mon, Feb 7, 2022 at 1:47 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-02-07 13:33, Benjamin Mordaunt wrote:
>>> The S905X3’s (Odroid C4) datasheet appears to report 4 individual PMUIRQs,
>>> much in the same way as GX. If that is indeed the case, I think this patch
>>> applies. Otherwise, is the datasheet wrong if Marc’s comments apply?
>>
>> A fairly solid test would be to run a sampling event (e.g. `perf stat`)
>> taskset to a single CPU and observe the corresponding IRQ count increase
>> in /proc/interrupts, for each core in turn. If that behaves as expected
>> then chances are everything is indeed sane.
>>
>> Couple of nitpicks for the patch itself - you're almost there, but
>> you've got spurious tabs on the blank lines, plus you need a proper
>> commit message and your sign-off above the "---" line - anything you add
>> below there is treated as additional commentary for reviewers' benefit
>> and will be discarded by `git am`.
>>
>> Cheers,
>> Robin.
>>
>>>
>>> / Ben
>>>
>>> On Mon, 7 Feb 2022 at 13:20, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>>> On 2022-02-07 08:14, Neil Armstrong wrote:
>>>>> Hi,
>>>>>
>>>>> On 06/02/2022 15:43, Benjamin Mordaunt wrote:
>>>>>> ---
>>>>>> The dts for meson sm1 appears to omit the SoC's PMU,
>>>>>> which is essential for accessing perf events regarding
>>>>>> e.g. cache on e.g. the Odroid C4 platform. Add it.
>>>>>>
>>>>>>     arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
>>>>>>     1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>>>> b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>>>> index 3d8b1f4f2..4147eecd2 100644
>>>>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>>>> @@ -6,6 +6,8 @@
>>>>>>     #include "meson-g12-common.dtsi"
>>>>>>     #include <dt-bindings/clock/axg-audio-clkc.h>
>>>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>>     #include <dt-bindings/power/meson-sm1-power.h>
>>>>>>     #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>>>>>>     #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>>>>>> @@ -90,7 +92,16 @@ l2: l2-cache0 {
>>>>>>                 compatible = "cache";
>>>>>>             };
>>>>>>         };
>>>>>> -
>>>>>> +
>>>>>> +    arm-pmu {
>>>>>> +        compatible = "arm,cortex-a55-pmu";
>>>>>> +        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                 <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                 <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                 <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +        interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>>>>>> +    };
>>>>>> +
>>>>>>         cpu_opp_table: opp-table {
>>>>>>             compatible = "operating-points-v2";
>>>>>>             opp-shared;
>>>>>
>>>>> Please see Marc's comments about PMU support:
>>>>> http://lore.kernel.org/r/8735pcq63o.wl-maz@kernel.org
>>>>
>>>> If SM1 actually has distinct per-core interrupts as the patch implies
>>>> then it's fine - it's only G12B and anything else that combines multiple
>>>> PMU IRQs into a single SPI which are unsupportable.
>>>>
>>>> Robin.
>>>>
>>>
