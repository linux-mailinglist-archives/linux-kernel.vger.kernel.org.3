Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585E4B4C55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiBNKkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:40:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350222AbiBNKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:37:00 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21192A66ED;
        Mon, 14 Feb 2022 02:03:31 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21E86fcW022932;
        Mon, 14 Feb 2022 11:02:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=zBXICPv5YGDXCve/KOSXwXFvMmf1sH/hj0bAI5GxYVo=;
 b=EDzvvd/pFTWvooKLuYkeUIe99KBk+BJGKcjGoooMobeLklfhVE52vjADfET8qq9eMneR
 tepiqHXGE8QIFRuWGM7cIrs78E0e1+xyb/W7y3nVcM2tjrjmBDJHcQKIaJqe+Jpb4UMy
 6wxW6+eAQgmRnhHtVnky7JpNNCvCAifMngR0OSSPTTaHGCT4LH9PQCZznxDD/L2ea35h
 txGgky7AWYHxRUr4RhqDRXF4YQv7jociSHi5GDhQZLjo8KeTpixWTH+ufkn+qzdkC2f/
 zgH5k9B7etZvNnZleKmO8QXfJ6Kqxnr+GvSCkXejVFnpNAvf3q3H2nT1vfpVQrcgiazh 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e72j13pam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 11:02:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D243A10002A;
        Mon, 14 Feb 2022 11:02:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C195D2194F3;
        Mon, 14 Feb 2022 11:02:32 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 14 Feb
 2022 11:02:32 +0100
Message-ID: <8e42cb99-a442-062a-cf0a-2f8d8aff0ab3@foss.st.com>
Date:   Mon, 14 Feb 2022 11:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
Content-Language: en-US
To:     Erwan Le Ray <erwan.leray@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_02,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 18:10, Erwan Le Ray wrote:
> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
> remove it at board level to keep current PIO behavior when needed.
> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
> (no HW flow control pin available) are kept in PIO mode, while USART3
> is now configured in DMA mode.
> UART4 (console UART) has to be kept in irq mode, as DMA support for
> console has been removed from the driver by commit e359b4411c28
> ("serial: stm32: fix threaded interrupt handling").
> 
> For other stm32mp15x-based boards, current configuration is kept for
> all UART instances.
> 
> Erwan Le Ray (16):
>    ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-ed1
>    ARM: dts: stm32: keep uart4 and uart7 behavior on stm32mp15xx-dkx
>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-ctouch2
>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-edimm2.2
>    ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp157a-stinger96
>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-lxa-mc1
>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-drc02
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-picoitx
>    ARM: dts: stm32: keep uart4 behavior on stm32mp15xx-dhcom-som
>    ARM: dts: stm32: keep uart nodes behavior on
>      stm32mp15xx-dhcor-avenger96
> 
>   arch/arm/boot/dts/stm32mp151.dtsi             | 21 +++++++++++++++++++
>   .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  2 ++
>   .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  2 ++
>   arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  2 ++
>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  4 ++++
>   ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  4 ++++
>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  6 ++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts         |  2 ++
>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  2 ++
>   arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  2 ++
>   .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  4 ++++
>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi |  4 ++++
>   .../boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   |  4 ++++
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  2 ++
>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 ++++++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  4 ++++
>   16 files changed, 71 insertions(+)
> 
Series applied on stm32-next.

Thanks
Alex
