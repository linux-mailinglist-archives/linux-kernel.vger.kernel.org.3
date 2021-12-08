Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88C346D824
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhLHQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:32:41 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49208
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236911AbhLHQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:32:38 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47C884029F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638980941;
        bh=/UnCaMOaE0r0Za7l2CYHdzK3LVhxC/oQzEtsFORObJY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Zc4/nsTcxt2u+zeiof2PwKLjKuyTQwdXz+BYy69EqE2KOpzGDeEaJV8kE0OW36r7m
         2qYZxYv49NAyIzRPHwh1MhSHK/TEMaFjDhZ7583z8UuuHXhxJ9cLQBnAH+Z4h/ViXG
         Vrp/DP/zlNSXZWGaqgMDj91vXTsa7XNKT+9TN2przmhRbqSZlDw0ns1D/qBVw2rbZZ
         FTTRHJI3c/8wAkWAk6Nh0qREG/fkF+4tfHGjeAbtfXqtE+Nvryh6xw7hdIjTeVRPLE
         NLunISjJxwthIsl8tI3SFa48C7UvU4GFpciN4/YEGfbb9b6Lip7B5eBpaaPyut7PEx
         T+HCdfmEngA3g==
Received: by mail-lf1-f71.google.com with SMTP id o11-20020a056512230b00b0041ca68ddf35so1279589lfu.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/UnCaMOaE0r0Za7l2CYHdzK3LVhxC/oQzEtsFORObJY=;
        b=PsWJ/N6Sw+knLXJz2qzMSNZ/QKe8X99qRgLbBnkleyK7HFAMqT+jEkEBVuoMgFLLNR
         DfR6D2e8yNztgfcjnAjvVBVFVheZr2FzOtWj9Avt+CdAyeWo0+flsBIWs1yn+IBCAq/I
         LwPjwXrH/MNeKRLoweIqDjDYjLF/nkfCwjMAym1K6G+3QjkDCR4RGU/PI0dbdLMB0LBn
         kMrfIfWWYu5JmoATdugrt+nLsbYFv2/o85/K9TtPzlIvijL37hxc9GtijPSQAN4DoikO
         5qa/qzgP8HtvUEnXUSF0fej8hvMRs41m29zp6ntU6FOCsMSRdH1jSSvd2D7HT4oQ50D5
         tH6Q==
X-Gm-Message-State: AOAM5338bvPYzfdeP8pe4cPeqDAgwBJz0B9r0KHQuXUvbyU1IDBZRLD3
        VoNRXyIylpBiiI8CBG8X3hjSVwdTNyJuMfdGRZjsIAGWu5JP+aNwYRwzioqgKRG/wdgr2OxNQ2A
        xyi9Z++/H3k7V3i9MrUdCbbhSE+3OsNIC6x1KjpkzlQ==
X-Received: by 2002:a2e:9107:: with SMTP id m7mr461289ljg.209.1638980937681;
        Wed, 08 Dec 2021 08:28:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIwQU+X8t7tOP0ejJnpUdJkw86nIEXKXWXgD13uXER76HySFNl3iap+u968szw5hY15UDOBw==
X-Received: by 2002:a2e:9107:: with SMTP id m7mr461247ljg.209.1638980937283;
        Wed, 08 Dec 2021 08:28:57 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id m13sm296123lfl.131.2021.12.08.08.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:28:56 -0800 (PST)
Message-ID: <a7d5f290-7992-b37c-fe2c-90bf3e5e83ce@canonical.com>
Date:   Wed, 8 Dec 2021 17:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-8-virag.david003@gmail.com>
 <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
 <0c7fc14b-a0d0-7d31-3a33-623f07114a80@canonical.com>
 <CAPLW+4=ioLewf5Hv5FO1jXjxaLrgedrzyKNtNtevTGADF9rBmw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4=ioLewf5Hv5FO1jXjxaLrgedrzyKNtNtevTGADF9rBmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 16:37, Sam Protsenko wrote:
> On Wed, 8 Dec 2021 at 11:05, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 07/12/2021 21:19, Sam Protsenko wrote:
>>> On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> wrote:
>>>>
>>>> Add initial Exynos7885 device tree nodes with dts for the Samsung Galaxy
>>>> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
>>>> Currently this includes some clock support, UART support, and I2C nodes.
>>>>
>>>> Signed-off-by: David Virag <virag.david003@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>   - Remove address-cells, and size-cells from dts, since they are
>>>>     already in the dtsi.
>>>>   - Lower case hex in memory node
>>>>   - Fix node names with underscore instead of hyphen
>>>>   - Fix line breaks
>>>>   - Fix "-key" missing from gpio keys node names
>>>>   - Use the form without "key" in gpio key labels on all keys
>>>>   - Suffix pin configuration node names with "-pins"
>>>>   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
>>>>   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
>>>>   - Add comment about Arm PMU
>>>>   - Rename "clock-oscclk" to "osc-clock"
>>>>   - Include exynos-syscon-restart.dtsi instead of rewriting its contents
>>>>
>>>> Changes in v3:
>>>>   - Fix typo (seperate -> separate)
>>>>
>>>> Changes in v4:
>>>>   - Fixed leading 0x in clock-controller nodes
>>>>   - Actually suffixed pin configuration node names with "-pins"
>>>>   - Seperated Cortex-A53 and Cortex-A73 PMU
>>>>
>>>>  arch/arm64/boot/dts/exynos/Makefile           |   7 +-
>>>>  .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
>>>>  .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865 ++++++++++++++++++
>>>>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
>>>>  4 files changed, 1402 insertions(+), 3 deletions(-)
>>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>>
>>> Shouldn't SoC and board files be sent as two separate patches? For
>>> example, I've checked exynos5433 and exynos7, SoC support
>>
>> Does not have to be. DTSI by itself cannot be even compiled, so keeping
>> it a separate commit does not bring that much benefits. Especially if it
>> is only one DTSI and one DTS.
>>
> 
> Right, the only theoretical benefit I can see is reverting the board
> dts in future, if another board already uses SoC dtsi. Or
> cherry-picking in similar manner. Not my call though, for me it just
> seems easier to review it that way, and more atomic.
> 
>>>
>>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
>>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
>>>> index b41e86df0a84..c68c4ad577ac 100644
>>>> --- a/arch/arm64/boot/dts/exynos/Makefile
>>>> +++ b/arch/arm64/boot/dts/exynos/Makefile
>>>> @@ -1,6 +1,7 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  dtb-$(CONFIG_ARCH_EXYNOS) += \
>>>> -       exynos5433-tm2.dtb      \
>>>> -       exynos5433-tm2e.dtb     \
>>>> -       exynos7-espresso.dtb    \
>>>> +       exynos5433-tm2.dtb              \
>>>> +       exynos5433-tm2e.dtb             \
>>>> +       exynos7-espresso.dtb            \
>>>> +       exynos7885-jackpotlte.dtb       \
>>>>         exynosautov9-sadk.dtb
>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>>> new file mode 100644
>>>> index 000000000000..f5941dc4c374
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>>> @@ -0,0 +1,95 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Samsung Galaxy A8 2018 (jackpotlte/SM-A530F) device tree source
>>>> + *
>>>> + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
>>>> + * Copyright (c) 2021 Dávid Virág
>>>> + *
>>>
>>> This line is not needed.
>>>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>
>>> Suggest adding empty line here.
>>>
>>>> +#include "exynos7885.dtsi"
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/input/input.h>
>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>> +
>>>> +/ {
>>>> +       model = "Samsung Galaxy A8 (2018)";
>>>> +       compatible = "samsung,jackpotlte", "samsung,exynos7885";
>>>> +       chassis-type = "handset";
>>>> +
>>>> +       aliases {
>>>> +               serial0 = &serial_0;
>>>> +               serial1 = &serial_1;
>>>> +               serial2 = &serial_2;
>>>
>>> Suggestion: add aliases also for i2c nodes, to keep i2c instance
>>> numbers fixed in run-time (e.g. in "i2cdetect -l" output).
>>>
>>>> +       };
>>>> +
>>>> +       chosen {
>>>> +               stdout-path = &serial_2;
>>>> +       };
>>>> +
>>>> +       memory@80000000 {
>>>> +               device_type = "memory";
>>>> +               reg = <0x0 0x80000000 0x3da00000>,
>>>> +                     <0x0 0xc0000000 0x40000000>,
>>>> +                     <0x8 0x80000000 0x40000000>;
>>>> +       };
>>>> +
>>>> +       gpio-keys {
>>>> +               compatible = "gpio-keys";
>>>> +               pinctrl-names = "default";
>>>> +               pinctrl-0 = <&key_volup &key_voldown &key_power>;
>>>> +
>>>> +               volup-key {
>>>> +                       label = "Volume Up";
>>>> +                       interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
>>>
>>> Here and below: what is 0, why it's needed? Also, isn't it enough to
>>> have just "gpios", and remove interrupt*? Need to check "gpio-keys"
>>> driver and bindings doc, but AFAIR it should be enough to have just
>>> "gpios =" or just "interrupts =".
>>
>> "gpios" is enough, because the IRQ line is derived from it. However
>> explicitly describing interrupts seems like a more detailed hardware
>> description.
>>
> 
> Frankly I don't think it's more detailed, it states the same thing
> (gpa1 controller, line=5).

It states that interrupt is exactly the same as GPIO which not
explicitly coming from bindings.

> Also not sure if level interrupt is needed
> for a key, maybe edge type would be better. Also, I still don't
> understand 0 in the end. 

Indeed this part looks not correct - the leve and 0 at the end. In such
case better to skip it then define misleading property.

> Checking existing dts's, most of those only
> define "gpios". I'd say having only "gpios" is more obvious, and will
> work the same way. But that's not a strong preference on my side, just
> think it's a bit misleading right now.

Yep.

> 
>>>
>>>
>>>> +                       interrupt-parent = <&gpa1>;
>>>> +                       linux,code = <KEY_VOLUMEUP>;
>>>> +                       gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
>>>> +               };
>>>> +
>>>> +               voldown-key {
>>>> +                       label = "Volume Down";
>>>> +                       interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
>>>> +                       interrupt-parent = <&gpa1>;
>>>> +                       linux,code = <KEY_VOLUMEDOWN>;
>>>> +                       gpios = <&gpa1 6 GPIO_ACTIVE_LOW>;
>>>> +               };
>>>> +
>>>> +               power-key {
>>>> +                       label = "Power";
>>>> +                       interrupts = <7 IRQ_TYPE_LEVEL_HIGH 0>;
>>>> +                       interrupt-parent = <&gpa1>;
>>>> +                       linux,code = <KEY_POWER>;
>>>> +                       gpios = <&gpa1 7 GPIO_ACTIVE_LOW>;
>>>> +                       wakeup-source;
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>
>>> If there are some LEDs by chance on that board -- it might be useful
>>> to define those here with "gpio-leds" as well. Maybe even set some
>>> default trigger like "heartbeat".
>>>
>>>> +&serial_2 {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pinctrl_alive {
>>>> +       key_volup: key-volup-pins {
>>>> +               samsung,pins = "gpa1-5";
>>>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
>>>
>>> Maybe EXYNOS_PIN_FUNC_EINT is more self-explanatory? Just a suggestion though.
>>>
>>>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>>>> +               samsung,pin-drv = <0>;
>>>
>>> Here and below: please use EXYNOS5420_PIN_DRV_LV1 (means drive level = 1x).
>>
>> But are these drive level 1x? The Exynos Auto v9 has different values
>> than older ones.
>>
> 
> It should be that. One way to implicitly figure that out is to look at
> nodes like "sd0_clk_fast_slew_rate_3x" and those pin-drv properties.
> Also, in Exynos850 for most of domains those constants are
> appropriate, that's why I mentioned that.

Then I agree, use existing macros. The macros can be skipped for cases
when the meaning is different.

> 
>>>
>>>> +       };
>>>> +
>>>> +       key_voldown: key-voldown-pins {
>>>> +               samsung,pins = "gpa1-6";
>>>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
>>>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>>>> +               samsung,pin-drv = <0>;
>>>> +       };
>>>> +
>>>> +       key_power: key-power-pins {
>>>> +               samsung,pins = "gpa1-7";
>>>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
>>>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>>>> +               samsung,pin-drv = <0>;
>>>> +       };
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
>>>> new file mode 100644
>>>> index 000000000000..8336b2e48858
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
>>>> @@ -0,0 +1,865 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Samsung Exynos7885 SoC pin-mux and pin-config device tree source
>>>> + *
>>>> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
>>>> + * Copyright (c) 2021 Dávid Virág
>>>> + *
>>>> + * Samsung's Exynos7885 SoC pin-mux and pin-config options are listed as
>>>> + * device tree nodes in this file.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/pinctrl/samsung.h>
>>>
>>> You probably also need <dt-bindings/interrupt-controller/arm-gic.h>
>>> here for GIC_SPI definition.
>>>
>>>> +
>>>> +&pinctrl_alive {
>>>> +       etc0: etc0 {
>>>> +               gpio-controller;
>>>> +               #gpio-cells = <2>;
>>>> +
>>>> +               interrupt-controller;
>>>> +               #interrupt-cells = <2>;
>>>> +       };
>>>> +
>>>> +       etc1: etc1 {
>>>> +               gpio-controller;
>>>> +               #gpio-cells = <2>;
>>>> +
>>>> +               interrupt-controller;
>>>> +               #interrupt-cells = <2>;
>>>> +       };
>>>
>>> Hmm, what are these two? I can't find anything related in
>>> exynos7885.dtsi. If it's just some leftover from downstream vendor
>>> kernel -- please remove it.
>>
>> This is a pinctrl DTSI file. What do you expect to find in
>> exynos7885.dtsi for these? Why removing them?
> 
> etc0 and etc1 nodes are defined as gpio-controller and
> interrupt-controller. So "compatible" should be provided somewhere for
> those nodes. For example, for "gpa0" node below you can find its
> compatible in exynos7885.dtsi. 

I am sorry, I still don't get it. gpa0 below does not have compatible.

> Right now I don't understand how those
> etc0 and etc1 can be used at all.

Exactly the same as gpa0, nothing changes here.

>  So maybe it's better to just remove
> those? Those are not used anywhere and we probably don't even know
> what those nodes represent. My point is, if those are actually some
> leftovers from vendor kernel and those are not going to be used (and I
> don't see how, without "compatible"), then we probablly better off
> without those.

I don't have the manual but in other SoCs these are not left-overs, but
real GPIO banks. Their configurability depends on the SoCs. I agree that
usually they are not used (because one of the uses is debugging), but
they can be included for completness of HW description. Assuming they exist.

(...)

>>>> +#include "exynos7885-pinctrl.dtsi"
>>>> +#include "arm/exynos-syscon-restart.dtsi"
>>>
>>> Have you verified both reboot and power off functions from this file?
>>> I guess if some doesn't work, it's better to avoid including this, but
>>> instead add corresponding sub-nodes into your pmu_sytem_controller.
>>
>> Why open-coding same code work and including would not? Assuming that it
>> compiles, of course.
>>
> 
> For example, in case of Exynos850 the "power off" node from this file
> wasn't suitable. In that case it's not worth including it. But David
> already confirmed both work fine for him, so it doesn't matter
> anymore.

These nodes were here before and since they duplicated common syscon, I
asked to use DTSI. The boards which do not use the same syscon
registers/methods should not include it, obviously. :)


Best regards,
Krzysztof
