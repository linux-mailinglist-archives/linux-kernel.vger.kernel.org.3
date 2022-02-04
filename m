Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B54A9C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359801AbiBDPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:44:18 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49076 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230391AbiBDPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:44:17 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214EF34A014088;
        Fri, 4 Feb 2022 16:41:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rJOveNVJGX7DUGKosJTj/eP0Rf6Ql1gp9b9F/RL8EE8=;
 b=UZzJOO+hHBvX7Hedp1IyXXl4kFp9uLhmE78AG2xYPWkZ93swtWDb2NbbKgtmbq1qUINs
 4YlA49z5DOgaP5F651pgTwWOEHD6noSkHafNJwO1ui2mGjpxS6uWLtvuDw5PE3pL9Tq8
 0StRDCGl6Edl4BrudAD1E1SonnOl8sQkgfKCdIra1AHg4PpF1ypCsn7/rbI6DvNEQLg/
 /rLXRjDEVEfTEb1vZICw8Xh8s/DOn8kTLrmoDDf/aoQVuzL/Bs5DfPUg+nuBVmNmIxqi
 dQqHoRyHOTrMiKiQRqlVvo42dKpF6So4uBxZAWA4yHlKZeedhIB/N+zJxrivUbjdf4QB mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0n4e4paj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:41:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A015E10002A;
        Fri,  4 Feb 2022 16:41:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9328D229A8C;
        Fri,  4 Feb 2022 16:41:56 +0100 (CET)
Received: from lmecxl0566.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Feb
 2022 16:41:55 +0100
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
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
 <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
From:   Erwan LE RAY <erwan.leray@foss.st.com>
Message-ID: <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
Date:   Fri, 4 Feb 2022 16:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,


On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
> Hi Ahmad
> 
> On 2/3/22 18:25, Ahmad Fatoum wrote:
>> Hello Erwan,
>>
>> On 03.02.22 18:10, Erwan Le Ray wrote:
>>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>>> remove it at board level to keep current PIO behavior when needed.
>>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>>> (no HW flow control pin available) are kept in PIO mode, while USART3
>>> is now configured in DMA mode.
>>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>>> console has been removed from the driver by commit e359b4411c28
>>> ("serial: stm32: fix threaded interrupt handling").
>>
>> Do I understand correctly that your first patch breaks consoles of
>> most/all boards, because they will briefly use DMA, which is refused
>> by the stm32-usart driver and then you add a patch for each board
>> to fix that breakage?
> 
> We have two solutions and both have pro/drawbacks. The first one (Erwan 
> ones, can break the boot if the patch is taken "alone". Your proposition 
> avoids this breakage but deletes a non define property (which is a bit 
> weird). However I prefer to keep a functional behavior, and keep Ahmad 
> proposition. Ahmad, just one question, dt-bindings check doesn't 
> complain about it ?
> 
> Cheers
> Alex
> 
>>
>> Such intermittent breakage makes bisection a hassle. /delete-property/
>> is a no-op when the property doesn't exist, so you could move the first
>> patch to the very end to avoid intermittent breakage.
>>
>> I also think that the driver's behavior is a bit harsh. I think it would
>> be better for the UART driver to print a warning and fall back to
>> PIO for console instead of outright refusing and rendering the system
>> silent. That's not mutually exclusive with your patch series here, of 
>> course.
>>
>> Cheers,
>> Ahmad
>>

The driver implementation will consider the request to probe the UART 
console in DMA mode as an error (-ENODEV), and will fallback this UART 
probe in irq mode.
Whatever the patch ordering, the boot will never be broken. The board dt 
patches aim to get a "proper" implementation, but from functional 
perspective the driver will manage a request to probe an UART console in 
DMA mode as an error and fall it back in irq mode.

Cheers, Erwan.

>>>
>>> For other stm32mp15x-based boards, current configuration is kept for
>>> all UART instances.
>>>
>>> Erwan Le Ray (16):
>>>    ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-ed1
>>>    ARM: dts: stm32: keep uart4 and uart7 behavior on stm32mp15xx-dkx
>>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-ctouch2
>>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-edimm2.2
>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0
>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp157a-stinger96
>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-lxa-mc1
>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-drc02
>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
>>>    ARM: dts: stm32: keep uart nodes behavior on 
>>> stm32mp15xx-dhcom-picoitx
>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp15xx-dhcom-som
>>>    ARM: dts: stm32: keep uart nodes behavior on
>>>      stm32mp15xx-dhcor-avenger96
>>>
>>>   arch/arm/boot/dts/stm32mp151.dtsi             | 21 +++++++++++++++++++
>>>   .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  2 ++
>>>   .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  2 ++
>>>   arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  2 ++
>>>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  4 ++++
>>>   ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  4 ++++
>>>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  6 ++++++
>>>   arch/arm/boot/dts/stm32mp157c-ed1.dts         |  2 ++
>>>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  2 ++
>>>   arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  2 ++
>>>   .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  4 ++++
>>>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi |  4 ++++
>>>   .../boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   |  4 ++++
>>>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  2 ++
>>>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 ++++++
>>>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  4 ++++
>>>   16 files changed, 71 insertions(+)
>>>
>>
>>
> 
