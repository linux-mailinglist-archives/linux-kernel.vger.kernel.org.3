Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8D4A99E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358631AbiBDNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:25:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235551AbiBDNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:25:30 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2148QohX011944;
        Fri, 4 Feb 2022 14:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=897N+JwPn9HsR13TZ+mpUH1Tpgf2LXHOh1v74lWbI7w=;
 b=rMWmSOZjQUwurdCMNkuWKpT9S3b+GmYyH+Tcs0lvO7Jgg+w8iTiuO25GnbHBuofyqj5z
 iS25mFWBXml+bJa4CntOfU7MnS+bWdP05bEGTjJGbbKftmFT6gAQiXavfW6TVpgLZ7TB
 /EmywQkiHZeU13/xbsTUYO/7Ut9Wq8UmREeZUhWpUjuN/nMq4F2CcoL3tZQI0PxxxZfJ
 jRvqwSLNkIZUK+kXdv/Kjj4TlQ0ViEH6AZh2Wu5LFl7T7YlF52O2WkTT3K1FLiU2B9so
 GvV/Lfy3PPxxsMKoxi6hceKRJuEYjwvnVEZCKbZcvoTgT2hx3WRxIe7xEoQazwqzLbEQ gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0ejje7de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:23:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3BAA10002A;
        Fri,  4 Feb 2022 14:23:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C47AE21FE8A;
        Fri,  4 Feb 2022 14:23:02 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Feb
 2022 14:23:02 +0100
Message-ID: <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
Date:   Fri, 4 Feb 2022 14:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Erwan Le Ray <erwan.leray@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 2/3/22 18:25, Ahmad Fatoum wrote:
> Hello Erwan,
> 
> On 03.02.22 18:10, Erwan Le Ray wrote:
>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>> remove it at board level to keep current PIO behavior when needed.
>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>> (no HW flow control pin available) are kept in PIO mode, while USART3
>> is now configured in DMA mode.
>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>> console has been removed from the driver by commit e359b4411c28
>> ("serial: stm32: fix threaded interrupt handling").
> 
> Do I understand correctly that your first patch breaks consoles of
> most/all boards, because they will briefly use DMA, which is refused
> by the stm32-usart driver and then you add a patch for each board
> to fix that breakage?

We have two solutions and both have pro/drawbacks. The first one (Erwan 
ones, can break the boot if the patch is taken "alone". Your proposition 
avoids this breakage but deletes a non define property (which is a bit 
weird). However I prefer to keep a functional behavior, and keep Ahmad 
proposition. Ahmad, just one question, dt-bindings check doesn't 
complain about it ?

Cheers
Alex

> 
> Such intermittent breakage makes bisection a hassle. /delete-property/
> is a no-op when the property doesn't exist, so you could move the first
> patch to the very end to avoid intermittent breakage.
> 
> I also think that the driver's behavior is a bit harsh. I think it would
> be better for the UART driver to print a warning and fall back to
> PIO for console instead of outright refusing and rendering the system
> silent. That's not mutually exclusive with your patch series here, of course.
> 
> Cheers,
> Ahmad
> 
>>
>> For other stm32mp15x-based boards, current configuration is kept for
>> all UART instances.
>>
>> Erwan Le Ray (16):
>>    ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-ed1
>>    ARM: dts: stm32: keep uart4 and uart7 behavior on stm32mp15xx-dkx
>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-ctouch2
>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-edimm2.2
>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp157a-stinger96
>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-lxa-mc1
>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-drc02
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-picoitx
>>    ARM: dts: stm32: keep uart4 behavior on stm32mp15xx-dhcom-som
>>    ARM: dts: stm32: keep uart nodes behavior on
>>      stm32mp15xx-dhcor-avenger96
>>
>>   arch/arm/boot/dts/stm32mp151.dtsi             | 21 +++++++++++++++++++
>>   .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  2 ++
>>   .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  2 ++
>>   arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  2 ++
>>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  4 ++++
>>   ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  4 ++++
>>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  6 ++++++
>>   arch/arm/boot/dts/stm32mp157c-ed1.dts         |  2 ++
>>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  2 ++
>>   arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  2 ++
>>   .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  4 ++++
>>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi |  4 ++++
>>   .../boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   |  4 ++++
>>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  2 ++
>>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 ++++++
>>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  4 ++++
>>   16 files changed, 71 insertions(+)
>>
> 
> 

