Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728A484EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiAEHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:55:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22325 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbiAEHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641369347; x=1672905347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wMpCFxZouB4qcMkAfw9jqA66cLKURNnaeykBbXrk5nk=;
  b=n6t1RnORktjetK1ztMWmTwKM/syx38scIvV4W0RAPIQ5Aqrzuks0MHgu
   uVz8YBWsH8KjwzrKHHhax+MT/tw0cdotJQXdAh1121r7fWRcI/egSEKH3
   /WCx7Ky//Flw967xXxgDTaHX8C5zjCZ0DVll1EYaDxEIyXjj8sFNPK4Gb
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jan 2022 23:55:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 23:55:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 23:55:46 -0800
Received: from [10.50.27.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 4 Jan 2022
 23:55:41 -0800
Message-ID: <40976c37-2eda-c586-d465-5babb2a14e4d@quicinc.com>
Date:   Wed, 5 Jan 2022 13:24:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 2/7] soc: qcom: dcc:Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-CA
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, <vkoul@kernel.org>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <fc69469f26983d373d5ad7dc2dc83df207967eda.1628617260.git.schowdhu@codeaurora.org>
 <20211214172529.GA27563@thinkpad>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20211214172529.GA27563@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 10:55 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 10, 2021 at 11:24:38PM +0530, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers.The DCC operates
>> based on user inputs via the sysfs interface.The user gives
>> addresses as inputs and these addresses are stored in the
>> form of linkedlists.
> The linked lists are present in the hardware, right? You should state it
> explicitly.
Ack
>
>> In case of a system crash or a manual
> So what does a crash here means? How does DCC detect it?

In case of a system crashes like kernel panic , the dcc hardware gets 
activated

automatically and dumps the register values.Nothing needs to be done from

software side for that.

>
>> software trigger by the user through the sysfs interface,
>> the dcc captures and stores the values at these addresses.
> This could be reworded a bit:
>
> "DCC captures and stores the current values of the provided addresses in SRAM"
Ack
>
>> This patch contains the driver which has all the methods
>> pertaining to the sysfs interface, auxiliary functions to
>> support all the four fundamental operations of dcc namely
>> read, write, first read then write and loop.The probe method
>> here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the
> Please use "DCC" everywhere.

Ack

>
>> values.The DCC driver can be used for debugging purposes
>> without going for a reboot since it can perform manual
>> triggers.
>>
> It allows users to perform software triggers for capturing values manually.
Ack
>
>> Also added the documentation for sysfs entries
>> and explained the functionalities of each sysfs file that
>> has been created for dcc.
>>
>> The following is the justification of using sysfs interface
>> over the other alternatives like ioctls
>>
>> i) As can be seen from the sysfs attribute descriptions,
>> most of it does basic hardware manipulations like dcc_enable,
>> dcc_disable, config reset etc. As a result sysfs is preferred
>> over ioctl as we just need to enter a 0 or 1.
>>
> This is not an apt reason to use sysfs. The one-value-per-file is a rule of
> sysfs not a criteria to use it.
Ack. Will be updating the justifications accordingly.
>
>> ii) Existing similar debug hardwares are there for which drivers
>> have been written using sysfs interface.One such example is the
>> coresight-etm-trace driver.A closer analog can also be the watchdog
>> subsystems though it is ioctls based.
>>
> Initially I thought that this driver could use debugfs interface, but going
> through it I feel that sysfs is more suited. Reason is, debugfs interface is
> used by drivers to expose debugging information additional to the function they
> do. But the sole usage of this driver depends on the configuration exported
> through the attributes and they looks to be an ABI to me.
Ack
>
>> Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-dcc |  114 ++
>>   drivers/soc/qcom/Kconfig                   |    8 +
>>   drivers/soc/qcom/Makefile                  |    1 +
>>   drivers/soc/qcom/dcc.c                     | 1549 ++++++++++++++++++++++++++++
>>   4 files changed, 1672 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-dcc b/Documentation/ABI/testing/sysfs-driver-dcc
>> new file mode 100644
>> index 0000000..05d24f0
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-dcc
>> @@ -0,0 +1,114 @@
>> +What:           /sys/bus/platform/devices/.../trigger
>> +Date:           March 2021
> Please fix the dates of all attributes.
Ack
>
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This is the sysfs interface for manual software
> All entries should be aligned properly.
Ack
>
>> +		triggers.The user can simply enter a 1 against
>> +		the sysfs file and enable a manual trigger.
>> +		Example:
>> +		echo  1 > /sys/bus/platform/devices/.../trigger
> Why 2 spaces after echo?
Ack
>
>> +
>> +What:           /sys/bus/platform/devices/.../enable
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This sysfs interface is used for enabling the
>> +		the dcc hardware.Without this being set to 1,
> DCC here also. And a space after "." everywhere.
Ack
>
>> +		the dcc hardware ceases to function.
>> +		Example:
>> +		echo  0 > /sys/bus/platform/devices/.../enable
>> +		(disable interface)
>> +		echo  1 > /sys/bus/platform/devices/.../enable
>> +		(enable interface)
>> +
>> +What:           /sys/bus/platform/devices/.../config
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This is the most commonly used sysfs interface
>> +		file and this basically stores the addresses of
>> +		the registers which needs to be read in case of
>> +		a hardware crash or manual software triggers.
>> +		Example:
>> +		echo  0x80000010 10 > /sys/bus/platform/devices/../config
>> +		This specifies that 10 words starting from address
> words are of width?
32 bits, will update accordingly.
>
>> +		0x80000010 is to be read.In case there are no words to be
>> +		specified we can simply enter the address.
> No word to be read? So what's the purpose then?

This will only read the value at the address. By specifying the words , 
it will read the value of the

subsequent addresses as well. For example :-

echo  0x80000010 10 > /sys/bus/platform/devices/../config

This will also read and store the value at the next 9 addresses after 0x80000010.
  

>
>> +
>> +What:           /sys/bus/platform/devices/.../config_write
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This file allows user to write a value to the register
>> +		address given as argument.The values are entered in the
>> +		form of <register_address> <value>.The reason for this
>> +		feature of dcc is that for accessing certain registers
>> +		it is necessary to set some bits of soe other register.
> soe?
Ack
>
>> +		That is achievable by giving DCC this privelege.
> privilege
Ack
>
>> +		Example:
>> +		echo 0x80000000 0xFF > /sys/bus/platform/devices/.../config_write
>> +
>> +What:           /sys/bus/platform/devices/.../config_reset
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This file is used to reset the configuration of
>> +		a dcc driver to the default configuration.
> s/"a dcc driver"/"the DCC driver"/g
Ack
>
>> +		Example:
>> +		echo  1 > /sys/bus/platform/devices/.../config_reset
>> +
>> +What:           /sys/bus/platform/devices/.../loop
>> +Date:		March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This file is used to enter the loop count as dcc
>> +		driver gives the option to loop multiple times on
>> +		the same register and store the values for each
>> +		loop.This is done to capture the changing values
>> +		of a register with time which comes handy for
>> +		debugging purposes.
>> +		Example:
>> +		echo 10 > /sys/bus/platform/devices/10a2000.dcc/loop
>> +		(Setting the loop count to 10)
>> +		echo  0x80000010 10 > /sys/bus/platform/devices/.../config
>> +                (Read 10 words starting from address 0x80000010O)
>> +		echo 1 > /sys/bus/platform/devices/.../loop
>> +		(Terminate the loop by writing a count of 1 to the loop sysfs node)
>> +
>> +What:           /sys/bus/platform/devices/.../rd_mod_wr
> Can you come up with a better name? Like config_read_write?
Ack
>
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This file is used to read the value of the register
>> +		and then write the value given as an argument to the
>> +		register address in config.The address argument should
>> +		be given of the form <mask> <value>.For debugging
>> +		purposes sometimes we need to first read from a register
>> +		and then set some values to the register.
> Reading this description gives an impression that this file is used to read the
> value of a register. But it is write only and the value will be read only during
> the trigger or crash. So this should be stated explicitly.
Ack
>
>> +		Example:
>> +		echo 0x80000000 > /sys/bus/platform/devices/.../config
>> +		(Set the address in config file)
>> +		echo 0xF 0xA > /sys/bus/platform/devices/.../rd_mod_wr
>> +		(Provide the mask and the value to write)
>> +
>> +What:           /sys/bus/platform/devices/.../ready
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This file is used to check the status of the dcc
>> +		hardware if it's ready to take the inputs.
>> +		Example:
>> +		cat /sys/bus/platform/devices/.../ready
> Document the value read also.
Ack
>
>> +
>> +What:		/sys/bus/platform/devices/.../curr_list
>> +Date:		February 2021
>> +Contact:	Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		This attribute is used to enter the linklist to be
>> +		used while appending addresses.The range of values
>> +		for this can be from 0 to 3.This feature is given in
>> +		order to use certain linkedlist for certain debugging
>> +		purposes.
>> +		Example:
>> +		echo 0 > /sys/bus/platform/devices/10a2000.dcc/curr_list
>> +
> How does a user will know the contents of the linked list? Basis on what
> criteria, user will know what value to write?

The purpose of creating separate linked list for the user was to provide 
them with a guidelines of

which linked list to use for which debugging purposes. There is no 
stringent rule as such for which

linked list to use but while debugging multiple components , this gives 
an advantage to the user.

>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 79b568f..5101912 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -69,6 +69,14 @@ config QCOM_LLCC
>>   	  SDM845. This provides interfaces to clients that use the LLCC.
>>   	  Say yes here to enable LLCC slice driver.
>>   
>> +config QCOM_DCC
>> +	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This option enables driver for Data Capture and Compare engine. DCC
>> +	  driver provides interface to configure DCC block and read back
>> +	  captured data from DCC's internal SRAM.
>> +
>>   config QCOM_KRYO_L2_ACCESSORS
>>   	bool
>>   	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index ad675a6..0aaf82b 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>> +obj-$(CONFIG_QCOM_DCC) += dcc.o
>>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
>> new file mode 100644
>> index 0000000..daf4388
>> --- /dev/null
>> +++ b/drivers/soc/qcom/dcc.c
>> @@ -0,0 +1,1549 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +
>> +#define TIMEOUT_US		5000
>> +
>> +#define dcc_writel(drvdata, val, off)					\
>> +	writel((val), drvdata->base + dcc_offset_conv(drvdata, off))
>> +#define dcc_readl(drvdata, off)						\
>> +	readl(drvdata->base + dcc_offset_conv(drvdata, off))
>> +
>> +#define DCC_SRAM_NODE "dcc_sram"
>> +
>> +/* DCC registers */
>> +#define DCC_HW_INFO			0x04
>> +#define DCC_LL_NUM_INFO			0x10
>> +#define DCC_STATUS			0x1C
> Please use lower case for register offsets. Also, align the defines properly.
Ack
>
>> +#define DCC_LL_LOCK(m)			(0x34 + 0x80 * m)
>> +#define DCC_LL_CFG(m)			(0x38 + 0x80 * m)
>> +#define DCC_LL_BASE(m)			(0x3c + 0x80 * m)
>> +#define DCC_FD_BASE(m)			(0x40 + 0x80 * m)
>> +#define DCC_LL_TIMEOUT(m)		(0x44 + 0x80 * m)
>> +#define DCC_LL_INT_ENABLE(m)		(0x4C + 0x80 * m)
>> +#define DCC_LL_INT_STATUS(m)		(0x50 + 0x80 * m)
>> +#define DCC_LL_SW_TRIGGER(m)		(0x60 + 0x80 * m)
>> +#define DCC_LL_BUS_ACCESS_STATUS(m)	(0x64 + 0x80 * m)
>> +
>> +#define DCC_MAP_LEVEL1			0x18
>> +#define DCC_MAP_LEVEL2			0x34
>> +#define DCC_MAP_LEVEL3			0x4C
>> +
>> +#define DCC_MAP_OFFSET1			0x10
>> +#define DCC_MAP_OFFSET2			0x18
>> +#define DCC_MAP_OFFSET3			0x1C
>> +#define DCC_MAP_OFFSET4			0x8
>> +
>> +#define DCC_FIX_LOOP_OFFSET		16
>> +#define DCC_VER_INFO_BIT		9
>> +
>> +#define DCC_READ			0
>> +#define DCC_WRITE			1
>> +#define DCC_LOOP			2
>> +#define DCC_READ_WRITE			3
>> +
>> +#define MAX_DCC_OFFSET			GENMASK(9, 2)
>> +#define MAX_DCC_LEN			GENMASK(6, 0)
>> +#define MAX_LOOP_CNT			GENMASK(7, 0)
>> +
>> +#define DCC_ADDR_DESCRIPTOR		0x00
>> +#define DCC_ADDR_LIMIT			27
>> +#define DCC_ADDR_OFF_RANGE		8
>> +#define DCC_ADDR_RANGE			GENMASK(31, 4)
>> +#define DCC_LOOP_DESCRIPTOR		BIT(30)
>> +#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
>> +#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
>> +
>> +#define DCC_READ_IND			0x00
>> +#define DCC_WRITE_IND			(BIT(28))
>> +
>> +#define DCC_AHB_IND			0x00
>> +#define DCC_APB_IND			BIT(29)
>> +
>> +#define DCC_MAX_LINK_LIST		8
>> +#define DCC_INVALID_LINK_LIST		GENMASK(7, 0)
>> +
>> +#define DCC_VER_MASK1			GENMASK(6, 0)
>> +#define DCC_VER_MASK2			GENMASK(5, 0)
>> +
>> +#define DCC_RD_MOD_WR_ADDR              0xC105E
>> +
>> +struct qcom_dcc_config {
>> +	int dcc_ram_offset;
> Are you planning to expand this structure? If not, please use "dcc_ram_offset"
> directly.
Ack
>
>> +};
>> +
>> +enum dcc_descriptor_type {
>> +	DCC_ADDR_TYPE,
>> +	DCC_LOOP_TYPE,
>> +	DCC_READ_WRITE_TYPE,
>> +	DCC_WRITE_TYPE
>> +};
>> +
>> +enum dcc_mem_map_ver {
>> +	DCC_MEM_MAP_VER1 = 1,
>> +	DCC_MEM_MAP_VER2 = 2,
>> +	DCC_MEM_MAP_VER3 = 3
>> +};
>> +
>> +struct dcc_config_entry {
>> +	u32				base;
>> +	u32				offset;
>> +	u32				len;
>> +	u32				index;
>> +	u32				loop_cnt;
>> +	u32				write_val;
>> +	u32				mask;
>> +	bool				apb_bus;
>> +	enum dcc_descriptor_type	desc_type;
>> +	struct list_head		list;
>> +};
>> +
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:	      Base Address of the dcc device
>> + * @dev:	      The device attached to the driver data
>> + * @mutex:	      Lock to protect access and manipulation of dcc_drvdata
> What? Are you trying to protect the whole structure or some fields?
whole structure in this case
>
>> + * @ram_base:         Base address for the SRAM dedicated for the dcc device
>> + * @ram_offset:       Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:      Memory map version of DCC hardware
>> + * @ram_cfg:          Used for address limit calculation for dcc
>> + * @ram_start:        Starting address of DCC SRAM
>> + * @enable:	      Flag to check if DCC linked list is enabled
> This contains an array of linked list enable flags.
Ack
>
>> + * @interrupt_disable:Flag to enable/disable interrupts
> For simplicity, just use a space after colon.
Ack
>
>> + * @sram_dev:	      Character device equivalent of dcc SRAM
>> + * @sram_class:	      Class equivalent of the DCC SRAM device
>> + * @cfg_head:	      Points to the head of the linked list of addresses
>> + * @nr_config:        Stores the number of addresses currently configured for a linkedlist
>> + * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
>> + * @curr_list:        The index of the current linklist with which the driver is working
>> + * @loopoff:          Loop offset bits range for the addresses
>> + */
>> +struct dcc_drvdata {
>> +	void __iomem		*base;
>> +	struct device		*dev;
>> +	struct mutex		mutex;
>> +	void __iomem		*ram_base;
>> +	phys_addr_t		ram_size;
>> +	phys_addr_t		ram_offset;
>> +	enum dcc_mem_map_ver	mem_map_ver;
>> +	phys_addr_t		ram_cfg;
>> +	phys_addr_t		ram_start;
>> +	bool			*enable;
>> +	bool			interrupt_disable;
> Move this to end to avoid holes.
Ack
>
>> +	struct cdev		sram_dev;
>> +	struct class		*sram_class;
>> +	struct list_head	*cfg_head;
>> +	size_t			*nr_config;
>> +	size_t			nr_link_list;
>> +	u8			curr_list;
>> +	u8			loopoff;
>> +};
> Is it possible to move the linked list specific members to a different struct?
Ack
>
>> +
>> +struct dcc_cfg_attr {
>> +	u32	addr;
>> +	u32	prev_addr;
>> +	u32	prev_off;
>> +	u32	link;
>> +	u32	sram_offset;
>> +};
>> +
>> +struct dcc_cfg_loop_attr {
>> +	u32	loop;
>> +	bool	loop_start;
> Move this to the end
Ack
>
>> +	u32	loop_cnt;
>> +	u32	loop_len;
>> +	u32	loop_off;
>> +};
>> +
>> +static size_t dcc_offset_conv(struct dcc_drvdata *drvdata, size_t off)
> Add comment on what this function does.
Ack
>
>> +{
>> +	if (drvdata->mem_map_ver == DCC_MEM_MAP_VER1) {
>> +		if ((off & DCC_VER_MASK1) >= DCC_MAP_LEVEL3)
> Use FIELD_* macros where applicable.
Ack
>
>> +			return off - DCC_MAP_OFFSET3;
> Use brackets ():
>
> return (off - DCC_MAP_OFFSET3);
Ack
>
>> +		if ((off & DCC_VER_MASK1) >= DCC_MAP_LEVEL2)
>> +			return off - DCC_MAP_OFFSET2;
>> +		else if ((off & DCC_VER_MASK1) >= DCC_MAP_LEVEL1)
>> +			return off - DCC_MAP_OFFSET1;
>> +	} else if (drvdata->mem_map_ver == DCC_MEM_MAP_VER2) {
>> +		if ((off & DCC_VER_MASK1) >= DCC_MAP_LEVEL2)
>> +			return off - DCC_MAP_OFFSET4;
>> +	}
>> +
>> +	return off;
>> +}
>> +
>> +static int dcc_sram_writel(struct dcc_drvdata *drvdata,
>> +					u32 val, u32 off)
>> +{
>> +	if (unlikely(off > (drvdata->ram_size - 4)))
> A comment here would be good too.
Ack
>
>> +		return -EINVAL;
>> +
>> +	writel(val, drvdata->ram_base + off);
>> +
>> +	return 0;
>> +}
>> +
>> +static bool dcc_ready(struct dcc_drvdata *drvdata)
>> +{
>> +	u32 val;
>> +
>> +	return !readl_poll_timeout((drvdata->base + dcc_offset_conv(drvdata, DCC_STATUS)),
>> +				val, (FIELD_GET(GENMASK(1, 0), val) == 0), 1, TIMEOUT_US);
> "FIELD_GET(GENMASK(1, 0)" could be wrapped in a define.
Ack
>
>> +
>> +}
>> +
>> +static int dcc_read_status(struct dcc_drvdata *drvdata)
>> +{
>> +	int curr_list;
>> +	u32 bus_status;
>> +	u32 ll_cfg;
>> +	u32 tmp_ll_cfg;
>> +
>> +	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
>> +		if (!drvdata->enable[curr_list])
> This looks wrong to me. Why can't you simply allocate N number of linked list
> structures based on the value read from hardware and do all list manipulations
> with it? Like,
>
> struct dcc_list {
> 	struct list_head cfg_head;
> 	bool enable;
> 	...
> };
>
> struct dcc_drvdata {
> 	...
> 	struct dcc_list *lists;
> 	...
> };
>
> /* List allocation */
> dcc->lists = devm_kzalloc();
>
> ...
>
> /* List initialization */
> for (i = 0; i < dcc->nr_link_list; i++) {
> 	list = dcc->lists[i];
> 	INIT_LIST_HEAD(&list->cfg_head);
> }
>
> ...
>
> /* List manipulation */
> list = dcc->lists[i];
> list->enable = true;
Ack
>
>> +			continue;
>> +
>> +		bus_status = dcc_readl(drvdata, DCC_LL_BUS_ACCESS_STATUS(curr_list));
>> +
> No new line needed here.
Ack
>
> I'm stopping here. For the next revision, please split this patch into multiple
> ones based on the functionality added. It is hard to review 1.3k LOC in a single
> patch.

So in version 1 of this series, separate patches were posted for the 
driver but as per Bjorn's

suggestion this was merged as it was becoming difficult to review in 
that case as well.

>
> Thanks,
> Mani
