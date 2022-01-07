Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1BF4870BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiAGCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:48:10 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:15505 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbiAGCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:48:10 -0500
Received: from [10.28.39.73] (10.28.39.73) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 Jan 2022
 10:48:08 +0800
Message-ID: <e4e1c378-81de-5e45-e5da-68193148e1e1@amlogic.com>
Date:   Fri, 7 Jan 2022 10:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] dt-bindings: nand: meson: fix controller clock
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
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
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220106033130.37623-1-liang.yang@amlogic.com>
 <20220106091209.6b97cf3c@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220106091209.6b97cf3c@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.73]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2022/1/6 16:12, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> liang.yang@amlogic.com wrote on Thu, 6 Jan 2022 11:31:30 +0800:
> 
> This patch should be in a series with "mtd: rawnand: meson: fix the
> clock after discarding sd_emmc_c_clk" and possibly come first.
> 
> You miss a commit message which is _very_ important given the type of
> change you propose.
>   
>> Change-Id: I1425b491d8b95061e1ce358ef33143433fc94d24
> 
> Change IDs have nothing to do here.
> 
> However a Fixes and a Signed-off-by are welcome.
> 
> You'll also need to Cc: Rob H. in your v2.
> 
ok, i will fix these once we clarify the patch about sd_emmc_c_clk and 
decide to use this patch.
>> ---
>>   .../bindings/mtd/amlogic,meson-nand.txt        | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> index 5794ab1147c1..37f16fe4fe66 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -14,11 +14,6 @@ Required properties:
>>   - clock-names: Should contain the following:
>>   	"core" - NFC module gate clock
>>   	"device" - device clock from eMMC sub clock controller
>> -	"rx" - rx clock phase
>> -	"tx" - tx clock phase
>> -
>> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> -				controller port C
>>   
>>   Optional children nodes:
>>   Children nodes represent the available nand chips.
>> @@ -28,11 +23,6 @@ see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindi
>>   
>>   Example demonstrate on AXG SoC:
>>   
>> -	sd_emmc_c_clkc: mmc@7000 {
>> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>> -		reg = <0x0 0x7000 0x0 0x800>;
>> -	};
>> -
>>   	nand-controller@7800 {
>>   		compatible = "amlogic,meson-axg-nfc";
>>   		reg = <0x0 0x7800 0x0 0x100>;
>> @@ -41,11 +31,9 @@ Example demonstrate on AXG SoC:
>>   		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>   
>>   		clocks = <&clkc CLKID_SD_EMMC_C>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>> -		clock-names = "core", "device", "rx", "tx";
>> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>> +			<&clkc CLKID_FCLK_DIV2>;
>> +		clock-names = "core", "device";
>> +		sd_emmc_c_clkc = <0xffe07000>;
>>   
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&nand_pins>;
> 
> 
> Thanks,
> Miquèl
> 
> .
