Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C008F46314F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhK3Kpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:45:38 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:16481
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234678AbhK3Kpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:45:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIZI+98S1KTyOdsjfIhoJaDtQesEJxbiHpg/O2Vbkf8QIvMK/PBS8emuD57RxIRJn2mOWBLXyIc9fCQiem/yfOGnZKdVRnGRENcDzklpyVBFXXB60LOOGEQIY+jHjtK3mnwpPqrPdXpK85kYUyXUXx42vmBdsUsxuCpe0EhUq7VndmMDj2LYpiV5QIkKfWDClzS9EDBfOJ+cpJFIqug0idQ6vFCN2SiQyjafvOXPxhTq3glme0EaMb/Yj9uIsqi43InhURk27adpn7QtM7DKiPZkgiw8ieSO2pbpLYAu2DCM75la25v9XCE6EwtHXet6Iz4zFd2IAZauGLRYYFsPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgMiajgePoSG2oZl5P6r+u0VZDpLtkawJbfXmEgjc9M=;
 b=HsKWXVkK1TStEvNyiC/LtBdRJ0XB4oR9LNRZeHNTGhgVOWhpZZF63QtKsJHQ1YkYwJ8CYko69zMCEuw/7OTWGHpoc0o0+dSS2NXijC5ZGoJx7HW6Ka+dQ4oKOBVKv82ebkaS6CMwdtmRJeHrzslExDm6nmZenjP1sjd2CWseKyvPTe60PafFxxQq8ddZtqJc6UitIu65nLQ+TyuaDbV/uIzGt9pXjSELWtckOTLv7ChNElly4uiOsx8lSPWDx9jgc2nThNLdPm/Xg/h/dRSa+M37yTex5ldpLDJY98K0ZccfigeE/gjb0L49QI6HbDxnmoQLshqOrCynk3k5CFxRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgMiajgePoSG2oZl5P6r+u0VZDpLtkawJbfXmEgjc9M=;
 b=eTEMJl1iUskarYNO7H9DB5e80i3lEIrRNgVgtz2d+WyVtdoJakCSQp5XsfXkV+39Fg4cz6TplhiL4GNWu1CLhLUccznakUoO2z30KCxWXttbVbwf9Mvp/wv4UHnJhd9R1YEYXqBGIEUYlP9elfdLZVa/6QnbaQvJgfE279S/f7Y=
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by SJ0PR02MB7712.namprd02.prod.outlook.com (2603:10b6:a03:32c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:42:14 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::82) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 10:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:42:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 02:42:10 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 02:42:10 -0800
Envelope-to: git@xilinx.com,
 robh@kernel.org,
 gregkh@linuxfoundation.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=35950)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ms0aP-0003BS-FT; Tue, 30 Nov 2021 02:42:09 -0800
Message-ID: <016cf560-5cbe-b1e2-d5b0-1d372fd78e75@xilinx.com>
Date:   Tue, 30 Nov 2021 11:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 2/2] usb: misc: usb244: add support for USB2 ultra fast
 sd controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>, <mka@chromium.org>,
        <ravisadineni@chromium.org>, <stern@rowland.harvard.edu>,
        <alcooperx@gmail.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
 <20211122062834.1812005-3-piyush.mehta@xilinx.com>
 <YZtAb9lz8WLnWu7E@kroah.com>
 <b4064914-40b5-3789-bebd-793cb27a29cd@xilinx.com>
 <YaWJHip//HzL8so5@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YaWJHip//HzL8so5@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 581fd31d-82bd-411d-8595-08d9b3ee125c
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7712:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7712F9BD513B98B420153199C6679@SJ0PR02MB7712.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1SUt+fjfbxofQ31f6Qh4oPkm4bIYawqoi32kqPWBQ4Ld8ifJW7TlQB/sV7rAwcJQdzbPqEoffUDMrfWBqm63goLlKqmX/rFGPccdBSgT+SqTivajS9YOegQH20256Zgi6z5IPrzk5O8CAs8TDUa7YMkePK7Se+oU9ZoNL5QkhXxwBCNBGc7vdxqAFbnht3wBG4dm/ly1ulHbVI/STb09VL160XqRZd0TEwh0rbmxctnL0NOHtzKvQDPIiXwwxM6OXSRM/NYpXjgPoB/ktvWYnmwLXpch0eY+WMFvCCp/DS7u9uYbbRaTJkl9DIbxWVMYfnE9yi3ZncKyUka+dufKT8MMczvmi/jB12ilVik2FQr+AdltqQMpckupVQJKNbuW0G/xax0ggYA8Jh+c+6wDjqEnsE2/AtQbky4OTmV/P9ZoIcvRYLvrkW1UB9N/3pe2RzpOm1S2lSbw+26nw1X8yqH2K1A2WEu/DjE9MkkTamwCIJru2IBTATKWlQLIPju+6hHZJbVo6FIWUWXywGnh/DHoERo7M0pRf5CQJDqS4VZ4MKZqLXyBOZZzzRWE4IcY2ppD82kqKbl34oNB7aoIyATdVVnj5JhdzxThJlxy07nIIx+92/Ibn8oYB/v0n+Uwjlwj0w6zjIhwzF/EPyKOk0lJqxWuZG3wemhjx3/gASdFKNUjdcBOMOKGbd7lyUq7R/a43feYTynYW1NmjW8c8V6MPD261jh2UAl5VjFCBxRz91mfWv+XjWR6jioeWGqgJBU3KYVdCvR026FUF7P4eMB0WvnwtzOKMrqXrC97Z+QxiUDl2edg0baiOeXfIZzC3SGWP13JDPc3CUUlZlivIp42Q8YCnhb2IN6rFzgU86IlGzgKf86H+InNOW5VxBJ
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(2906002)(110136005)(54906003)(316002)(31696002)(70586007)(44832011)(8936002)(70206006)(6666004)(336012)(31686004)(426003)(83380400001)(2616005)(82310400004)(107886003)(4326008)(5660300002)(36756003)(9786002)(186003)(966005)(26005)(47076005)(7636003)(508600001)(8676002)(53546011)(36860700001)(356005)(50156003)(43740500002)(15866825006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:42:13.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fd31d-82bd-411d-8595-08d9b3ee125c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/21 03:14, Rob Herring wrote:
> On Mon, Nov 22, 2021 at 12:02:52PM +0100, Michal Simek wrote:
>>
>> nit: Just spot typo in subject. It is usb2244.
>>
>> On 11/22/21 08:02, Greg KH wrote:
>>> On Mon, Nov 22, 2021 at 11:58:34AM +0530, Piyush Mehta wrote:
>>>> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
>>>> provides an ultra-fast interface between a USB host controller and flash
>>>> media cards.
>>>>
>>>> This patch adds a GPIO based usb-sd reset for USB2244 USB2 ultra fast
>>>> SD controller. This usb2244 driver trigger sd reset signal after soft
>>>> reset or core Reset. The SD needs to be resetted after completion of
>>>> phy initialization. After the toggling of gpio, controller gets out
>>>> form reset. USB2244 is a simple platform device driver.
>>>>
>>>> As part of the reset, sets the direction of the pin to output before
>>>> toggling the pin. Delay of microseconds is added in between high and
>>>> low to meet the setup and hold time requirement of the reset.
>>>>
>>>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>>>> ---
>>>> Changes for V2:
>>>> - Update reset polarity, make reset ACTIVE LOW in the usb2244 driver.
>>>> - Fix WARNING: msleep < 20ms can sleep for up to 20ms by changing msleep to
>>>>     usleep_range()
>>>> ---
>>>>    drivers/usb/misc/Kconfig   | 10 +++++++
>>>>    drivers/usb/misc/Makefile  |  1 +
>>>>    drivers/usb/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>>>
>>> This isn't really a USB driver, so maybe drivers/misc/ instead?
>>>
>>>>    3 files changed, 80 insertions(+)
>>>>    create mode 100644 drivers/usb/misc/usb2244.c
>>>>
>>>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>>>> index 8f11443..e1c66a2 100644
>>>> --- a/drivers/usb/misc/Kconfig
>>>> +++ b/drivers/usb/misc/Kconfig
>>>> @@ -215,6 +215,16 @@ config USB_ISIGHTFW
>>>>    	  driver beforehand. Tools for doing so are available at
>>>>    	  http://bersace03.free.fr
>>>> +config USB_USB2244
>>>> +	tristate "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
>>>> +	depends on GPIOLIB
>>>> +	help
>>>> +	  Say Y or M here if you want to reset Microchip USB2244 Ultra Fast
>>>> +	  USB 2.0 SD controller.
>>>> +	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
>>>> +	  SD controller. This driver reset the gpio pin makes controller out of
>>>> +	  reset.
>>>
>>> Module name?
>>>
>>>> +
>>>>    config USB_YUREX
>>>>    	tristate "USB YUREX driver support"
>>>>    	help
>>>> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
>>>> index 5f4e598..5b4af7d 100644
>>>> --- a/drivers/usb/misc/Makefile
>>>> +++ b/drivers/usb/misc/Makefile
>>>> @@ -21,6 +21,7 @@ obj-$(CONFIG_USB_LEGOTOWER)		+= legousbtower.o
>>>>    obj-$(CONFIG_USB_TEST)			+= usbtest.o
>>>>    obj-$(CONFIG_USB_EHSET_TEST_FIXTURE)    += ehset.o
>>>>    obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
>>>> +obj-$(CONFIG_USB_USB2244)		+= usb2244.o
>>>>    obj-$(CONFIG_USB_USS720)		+= uss720.o
>>>>    obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
>>>>    obj-$(CONFIG_USB_YUREX)			+= yurex.o
>>>> diff --git a/drivers/usb/misc/usb2244.c b/drivers/usb/misc/usb2244.c
>>>> new file mode 100644
>>>> index 0000000..5a868c2
>>>> --- /dev/null
>>>> +++ b/drivers/usb/misc/usb2244.c
>>>> @@ -0,0 +1,69 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Driver for the Microchip USB2244 Ultra Fast USB 2.0 Multi-Format,
>>>> + * SD/MMC, and MS Flash Media Controllers
>>>> + *
>>>> + * Copyright (c) 2021 Xilinx, Inc.
>>>> + */
>>>> +
>>>> +#include <linux/delay.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/gpio/consumer.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +struct usb2244 {
>>>> +	struct gpio_desc *reset_gpio;
>>>> +};
>>>
>>> Why is this structure needed?
>>>
>>>> +
>>>> +static int usb2244_init_hw(struct device *dev, struct usb2244 *data)
>>>> +{
>>>> +	data = devm_kzalloc(dev, sizeof(struct usb2244), GFP_KERNEL);
>>>> +	if (!data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>>> +	if (IS_ERR(data->reset_gpio)) {
>>>> +		dev_err_probe(dev, PTR_ERR(data->reset_gpio),
>>>> +			      "Failed to request reset GPIO %ld, errcode",
>>>> +			      PTR_ERR(data->reset_gpio));
>>>> +		return PTR_ERR(data->reset_gpio);
>>>> +	}
>>>> +
>>>> +	/* Toggle RESET_N to reset the hub. */
>>>> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
>>>> +	usleep_range(5, 10);
>>>> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
>>>> +	usleep_range(5000, 6000);
>>>
>>> Why do you need a kernel driver for this at all?  Why not just toggle
>>> the pin from userspace?
>>
>> It is usb-sd convertor. If you have rootfs on SD you need to get the chip
>> out of reset to be able to access init. There is no way how to do it via
>> userspace.
> 
> Then by the bootloader...

Bootloader is doing it because it needs to get access there too. And it 
also need to do in our case initialization of usb5744 usb hub via i2c to 
start working. And description is taken from DT.
When you get to OS it takes the same DT and start to do the job again. 
It means reset usb core, reset usb hub, reset usb-sd bridge and reset 
usb ULPI.
I don't think it is good way to let bootloader do it and Linux will just 
rely on it. Bootloader should be decouple from OS that's why IMHO 
initialization on both sides is necessary.

> 
>> Maybe there could be a different way how to do it via different driver to
>> toggle the reset. It is dwc3 -> usb-hub(usb5744) -> usb-sd(usb2244) + usb
>> phys for sd2.0 and it should be also reset in the right order.
> 
> Otherwise, you need to define the whole USB hierarchy to add the GPIO
> line to the USB device. Unfortunately, getting all that to work in the
> kernel is not a solved problem. It's the same issue on all the
> 'discoverable' buses.

We have to define that hierarchy anyway for bootloader to do all resets.
And structure is fixed.
This is what we have defined. (I have updated that 2244 usb-sd convertor).
usb2244 is connected to usb5744 hub port1. Not sure if this is correct 
description because maybe it should be child of it.

Can you please check this structure?


usb0: usb0@ff9d0000 {
	#address-cells = <2>;
	#size-cells = <2>;
	compatible = "xlnx,zynqmp-dwc3";
	reg = <0x0 0xff9d0000 0x0 0x100>;
	clock-names = "bus_clk", "ref_clk";
	power-domains = <&zynqmp_firmware PD_USB_0>;
	resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
		 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
		 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
	reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usb0_default>;
	phy-names = "usb3-phy";
	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
  	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
  	assigned-clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk 
USB3_DUAL_REF>;
	assigned-clock-rates = <250000000>, <20000000>;
	dr-mode = "host";

	usbhub0_2_0: hub@1 {
		i2c-bus = <&usbhub_i2c0>;
		compatible = "usb424:2744";
		reg = <1>;
		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
		companion-hub = <&usbhub0_3_0>;
	};

	usbhub0_3_0: hub@2 {
		i2c-bus = <&usbhub_i2c0>;
		compatible = "usb424:5744";
		reg = <2>;
		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
		companion-hub = <&usbhub0_2_0>;
	};

	/* connected to port 1, Should it be reg 1? */
	usb2244: device@3 {
		compatible = "usb424:2244";
		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
		reg = <3>;
	};
		dwc3_0: dwc3@fe200000 {
		compatible = "snps,dwc3";
		reg = <0x0 0xfe200000 0x0 0x40000>;
		interrupt-parent = <&gic>;
		interrupt-names = "dwc_usb3", "otg", "hiber";
		interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
		...
	};
};
