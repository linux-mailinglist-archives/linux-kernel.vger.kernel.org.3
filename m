Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F193508789
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378349AbiDTL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378407AbiDTL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:59:01 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F2427F0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:56:00 -0700 (PDT)
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 20 Apr
 2022 19:55:55 +0800
Message-ID: <b880c64c-7651-c445-4e5e-74cb7a1e76ee@amlogic.com>
Date:   Wed, 20 Apr 2022 19:55:54 +0800
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
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220420094107.4799f15a@xps13>
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

On 2022/4/20 15:41, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> liang.yang@amlogic.com wrote on Sat, 2 Apr 2022 15:49:20 +0800:
> 
>> convert txt to yaml and refine the meson NFC clock document.
> 
> We generally prefer to split this into two changes (yaml conversion
> then modifications). You need to be very explicit on the changes you
> bring to this file afterward. Also you may s/refine/fix/ in your title
> if this really is a correction of something that does not work at all as
> you suggest.
ok
> 
> Please mention that due to the other series about the clock changes
> never being accepted the current binding was never valid/working
ok
> (again, I'm not sure it's the case on all Amlogic SoCs, so please be
> very careful about that).
of course.
> 
> And please use a Link: tag to point to the discussion with Neil and
> Jerome on your MMC/NAND subclock final discussion.
ok
> 
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   .../bindings/mtd/amlogic,meson-nand.txt       | 60 --------------
>>   .../bindings/mtd/amlogic,meson-nand.yaml      | 80 +++++++++++++++++++
>>   2 files changed, 80 insertions(+), 60 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> deleted file mode 100644
>> index 5794ab1147c1..000000000000
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> +++ /dev/null
>> @@ -1,60 +0,0 @@
>> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> -
>> -This file documents the properties in addition to those available in
>> -the MTD NAND bindings.
>> -
>> -Required properties:
>> -- compatible : contains one of:
>> -  - "amlogic,meson-gxl-nfc"
>> -  - "amlogic,meson-axg-nfc"
>> -- clocks     :
>> -	A list of phandle + clock-specifier pairs for the clocks listed
>> -	in clock-names.
>> -
>> -- clock-names: Should contain the following:
>> -	"core" - NFC module gate clock
>> -	"device" - device clock from eMMC sub clock controller
>> -	"rx" - rx clock phase
>> -	"tx" - tx clock phase
>> -
>> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> -				controller port C
>> -
>> -Optional children nodes:
>> -Children nodes represent the available nand chips.
>> -
>> -Other properties:
>> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
>> -
>> -Example demonstrate on AXG SoC:
>> -
>> -	sd_emmc_c_clkc: mmc@7000 {
>> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>> -		reg = <0x0 0x7000 0x0 0x800>;
>> -	};
>> -
>> -	nand-controller@7800 {
>> -		compatible = "amlogic,meson-axg-nfc";
>> -		reg = <0x0 0x7800 0x0 0x100>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> -
>> -		clocks = <&clkc CLKID_SD_EMMC_C>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>> -		clock-names = "core", "device", "rx", "tx";
>> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>> -
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&nand_pins>;
>> -
>> -		nand@0 {
>> -			reg = <0>;
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -
>> -			nand-on-flash-bbt;
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> new file mode 100644
>> index 000000000000..965a2dd20645
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/amlogic,meson-nand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> 
> Maybe you need to inherit from nand-controller.yaml.
ok
> 
>> +
>> +maintainers:
>> +  - liang.yang@amlogic.com
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - "amlogic,meson-gxl-nfc"
>> +      - "amlogic,meson-axg-nfc"
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  '#address-cells':
>> +    const: 1
> 
> Not sure this property is needed.
this is for the subnode, such as nand@0.
> 
>> +
>> +  '#size-cells':
>> +    const: 0
> 
> Ditto. Plus, this one looks wrong anyway.
this is for the subnode, such as nand@0. do you mean s/''/""/?
> 
>> +
>> +  reg-names:
>> +    items:
>> +      - const: nfc
>> +      - const: emmc
> 
> Why do you need the emmc register map? Do you really need to perform a
> register access there?
yes, we have to access the emmc register map. because the NFC clock 
comes from SDEMMC_CLOCK register.
> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: device
>> +
>> +  "#clock-cells":
>> +    const: 1
> 
> ?
en, it should be deleted here.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - reg-names
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
> 
> I will let Rob check that but I think what you need is
> 
> unevaluatedProperties: false
ok
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/axg-clkc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    apb {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
> 
> Not sure you need this upper node in the example.
use the upper node to indicate the "#address-cells" and "#size-cells". 
if i do not do that, dt_binding_check will report:
  ".....reg:0: [0, 30720, 0, 256] is too long" and
  ".....reg:1: [0, 28672, 0, 2048] is too long".
> 
>> +      nand-controller@7800 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "amlogic,meson-axg-nfc";
>> +        reg = <0x0 0x7800 0x0 0x100>,
>> +              <0x0 0x7000 0x0 0x800>;
>> +        reg-names = "nfc", "emmc";
>> +
>> +        interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clkc CLKID_SD_EMMC_C>,
>> +                 <&clkc CLKID_FCLK_DIV2>;
>> +        clock-names = "core", "device";
>> +
>> +      };
>> +    };
>> +...
> 
> 
> Thanks,
> Miquèl
> 
> .
