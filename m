Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A4508841
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378605AbiDTMid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDTMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:38:30 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837911277F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:35:43 -0700 (PDT)
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 20 Apr
 2022 20:35:41 +0800
Message-ID: <f20078df-bf96-a972-25ce-7e9dce3f99d7@amlogic.com>
Date:   Wed, 20 Apr 2022 20:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/2] dt-bindings: nand: meson: refine Amlogic NAND
 controller driver
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
 <20220402074921.13316-3-liang.yang@amlogic.com>
 <20220420094107.4799f15a@xps13>
 <b880c64c-7651-c445-4e5e-74cb7a1e76ee@amlogic.com>
 <20220420141620.4fd68eef@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220420141620.4fd68eef@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2022/4/20 20:16, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
>>>> +maintainers:
>>>> +  - liang.yang@amlogic.com
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - "amlogic,meson-gxl-nfc"
>>>> +      - "amlogic,meson-axg-nfc"
>>>> +
>>>> +  reg:
>>>> +    maxItems: 2
>>>> +
>>>> +  '#address-cells':
>>>> +    const: 1
>>>
>>> Not sure this property is needed.
>> this is for the subnode, such as nand@0.
> 
> Yes but if you refer to nand-controller.yaml you no longer need these.
ok, i will try it.
> 
>>>    
>>>> +
>>>> +  '#size-cells':
>>>> +    const: 0
>>>
>>> Ditto. Plus, this one looks wrong anyway.
>> this is for the subnode, such as nand@0. do you mean s/''/""/?
> 
> Sorry, this is not "wrong anyway", my fault. But still, you don't need
> this property for the same reason as above.
ok.
> 
>>>    
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: nfc
>>>> +      - const: emmc
>>>
>>> Why do you need the emmc register map? Do you really need to perform a
>>> register access there?
>> yes, we have to access the emmc register map. because the NFC clock comes from SDEMMC_CLOCK register.
> 
> But if it's a clock you should get the clock and call
> clk_prepare_enable(), you don't need to poke directly in the registers.
> Do you?

no, it doesn't. it is special and the reason why need to implement a MMC 
sub clock driver previously. also we don't implement it as a clock 
provider in drivers/clk/meson/, because the SDEMMC_CLOCK register is 
internal in MCI controller.
> 
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/axg-clkc.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    apb {
>>>> +      #address-cells = <2>;
>>>> +      #size-cells = <2>;
>>>
>>> Not sure you need this upper node in the example.
>> use the upper node to indicate the "#address-cells" and "#size-cells". if i do not do that, dt_binding_check will report:
>>    ".....reg:0: [0, 30720, 0, 256] is too long" and
>>    ".....reg:1: [0, 28672, 0, 2048] is too long".
> 
> ok, maybe, I'll let bindings maintainer review that.

ok. thanks.

> 
>>>    
>>>> +      nand-controller@7800 {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +        compatible = "amlogic,meson-axg-nfc";
>>>> +        reg = <0x0 0x7800 0x0 0x100>,
>>>> +              <0x0 0x7000 0x0 0x800>;
>>>> +        reg-names = "nfc", "emmc";
>>>> +
>>>> +        interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>>> +        clocks = <&clkc CLKID_SD_EMMC_C>,
>>>> +                 <&clkc CLKID_FCLK_DIV2>;
>>>> +        clock-names = "core", "device";
>>>> +
>>>> +      };
>>>> +    };
>>>> +...
> 
> 
> Thanks,
> Miquèl
> 
> .
