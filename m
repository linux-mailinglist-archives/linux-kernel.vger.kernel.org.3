Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDE4AC028
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389073AbiBGNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380484AbiBGN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:28:35 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 05:28:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E05F5C043181;
        Mon,  7 Feb 2022 05:28:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CC511D4;
        Mon,  7 Feb 2022 05:20:28 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223483F70D;
        Mon,  7 Feb 2022 05:20:25 -0800 (PST)
Message-ID: <65cde84a-8f8b-ac57-9b66-2b8d6378dbfa@arm.com>
Date:   Mon, 7 Feb 2022 13:20:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] add pmu to amlogic meson sm1
Content-Language: en-GB
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Mordaunt <crawford.benjamin15@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
 <20220206144343.2194-1-crawford.benjamin15@gmail.com>
 <42c51f9d-d122-2d09-cdcd-f733cbc60d5b@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <42c51f9d-d122-2d09-cdcd-f733cbc60d5b@baylibre.com>
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

On 2022-02-07 08:14, Neil Armstrong wrote:
> Hi,
> 
> On 06/02/2022 15:43, Benjamin Mordaunt wrote:
>> ---
>> The dts for meson sm1 appears to omit the SoC's PMU,
>> which is essential for accessing perf events regarding
>> e.g. cache on e.g. the Odroid C4 platform. Add it.
>>
>>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi 
>> b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 3d8b1f4f2..4147eecd2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -6,6 +6,8 @@
>>   #include "meson-g12-common.dtsi"
>>   #include <dt-bindings/clock/axg-audio-clkc.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/meson-sm1-power.h>
>>   #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>>   #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>> @@ -90,7 +92,16 @@ l2: l2-cache0 {
>>               compatible = "cache";
>>           };
>>       };
>> -
>> +
>> +    arm-pmu {
>> +        compatible = "arm,cortex-a55-pmu";
>> +        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
>> +                 <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
>> +                 <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>> +                 <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> +    };
>> +
>>       cpu_opp_table: opp-table {
>>           compatible = "operating-points-v2";
>>           opp-shared;
> 
> Please see Marc's comments about PMU support:
> http://lore.kernel.org/r/8735pcq63o.wl-maz@kernel.org

If SM1 actually has distinct per-core interrupts as the patch implies 
then it's fine - it's only G12B and anything else that combines multiple 
PMU IRQs into a single SPI which are unsupportable.

Robin.
