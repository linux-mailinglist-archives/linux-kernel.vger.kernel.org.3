Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836549024F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiAQHDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:03:54 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:31416 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiAQHDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:03:48 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 Jan
 2022 15:03:47 +0800
Message-ID: <8783eb66-16ee-3b8b-5d55-73b49deab3a2@amlogic.com>
Date:   Mon, 17 Jan 2022 15:03:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock
 controller
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220113115745.45826-1-liang.yang@amlogic.com>
 <20220113115745.45826-4-liang.yang@amlogic.com>
 <20220113212957.768FFC36AE3@smtp.kernel.org>
 <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
 <CAFBinCDkNk+Ba340vshhL2rE76U9qb_dZ5ZsgWnMgFYpL6i1jA@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <CAFBinCDkNk+Ba340vshhL2rE76U9qb_dZ5ZsgWnMgFYpL6i1jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2022/1/15 8:09, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> On Fri, Jan 14, 2022 at 4:06 AM Liang Yang <liang.yang@amlogic.com> wrote:
> [...]
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - "amlogic,axg-mmc-clkc", "syscon"
>>>
>>> Why is it a syscon?
>>
>> The register documented by reg is shared with SD/eMMC controller port C,
>> and it need to be ops on NFC driver.
> Can you please share an example how the .dts would look like in the
> end for two example cases:
> 1) using the sd_emmc_c MMC interface > 2) not using the MMC interface of sd_emmc_c but only using it's clocks
> for the NFC
I think both EMMC(although it is not implemented by 'axg-mmc-clkc'  yet) 
and NAND clock have the same way in dts:
		......
		clocks = <&clkc CLKID_SD_EMMC_C>,
			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
		clock-names = "core", "device", "rx", "tx";
		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
		......

> 
> Initially I wanted to suggest the usage of a sub-node with compatible
> = "mmc-slot" (see
> Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt for an
> example) to decide whether the MMC controller is registered or whether
> just the clock controller is registered.
> However, the mmc-slot compatible string is not documented in
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml currently.
> Maybe the MMC maintainers have any suggestions if other IPs have
> similar requirements (for IPs with shared parts).
> 
> 
> Best regards,
> Martin
> 
> .
