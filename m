Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9C4760CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbhLOSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:33:45 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12097 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234977AbhLOSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639593224; x=1671129224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bqwbkxr0wiceI6jZizY/g/S70Ax6tR601faVJAwge0s=;
  b=wZZQp9tfssqAQsON5Xb1Wrgj5cxfDwHYTCAuM/0MrIkTXsq6b+TSAF4K
   tcouMAYcV5cK4e9C5Ut0pZZz+hR0AQx8zsVMmMljZvr95cdfov0lrIyo/
   b9hAOLYKekPunqJKxV+qpzdVZ3OSYoJr1/Gl3EJrXRGGwLTX6pXrQ6JO+
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Dec 2021 10:33:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:33:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 10:33:43 -0800
Received: from [10.50.9.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 10:33:38 -0800
Message-ID: <394aa08d-82b2-07ff-758e-921028672023@quicinc.com>
Date:   Thu, 16 Dec 2021 00:03:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 2/7] soc: qcom: dcc:Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-CA
To:     Alex Elder <elder@ieee.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vkoul@kernel.org>,
        <quic_rjendra@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_sibis@quicinc.com>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <fc69469f26983d373d5ad7dc2dc83df207967eda.1628617260.git.schowdhu@codeaurora.org>
 <cd1e6d81-7848-673e-bc73-bc52b176cddf@ieee.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <cd1e6d81-7848-673e-bc73-bc52b176cddf@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 4:06 AM, Alex Elder wrote:
> On 8/10/21 12:54 PM, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers.The DCC operates
>> based on user inputs via the sysfs interface.The user gives
>> addresses as inputs and these addresses are stored in the
>> form of linkedlists.In case of a system crash or a manual
>> software trigger by the user through the sysfs interface,
>> the dcc captures and stores the values at these addresses.
>> This patch contains the driver which has all the methods
>> pertaining to the sysfs interface, auxiliary functions to
>> support all the four fundamental operations of dcc namely
>> read, write, first read then write and loop.The probe method
>> here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the
>> values.The DCC driver can be used for debugging purposes
>> without going for a reboot since it can perform manual
>> triggers.
>
> I don't understand what you're trying to say with the last
> sentence above.
>
So DCC has both software and hardware triggers. The former can be 
triggered by the user by doing a

echo 1 > trigger from user space while the later happens during a crash.

>> Also added the documentation for sysfs entries
>> and explained the functionalities of each sysfs file that
>> has been created for dcc.
>
> Could these files all land in debugfs, at least initially?
> I guess if you get it right it's fine in sysfs, but unlike
> sysfs, debugfs is not considered a stable user space API.
>
Ack.Will move this to debugfs
>> The following is the justification of using sysfs interface
>> over the other alternatives like ioctls
>>
>> i) As can be seen from the sysfs attribute descriptions,
>> most of it does basic hardware manipulations like dcc_enable,
>> dcc_disable, config reset etc. As a result sysfs is preferred
>> over ioctl as we just need to enter a 0 or 1.
>>
>> ii) Existing similar debug hardwares are there for which drivers
>> have been written using sysfs interface.One such example is the
>> coresight-etm-trace driver.A closer analog can also be the watchdog
>> subsystems though it is ioctls based.
>
> Even if it eventually becomes a sysfs interface, it might
> be better to initially land it in debugfs.  (Maybe others
> disagree.)

Ack

>
> Generally, it looks to me like this always reads memory in
> 32-bit units.  I might have missed it, but if that is not
> documented it should be.  Also, is it OK to provide an
> address that is not aligned on a 32-bit boundary?  I
> presume memory is interpreted as CPU endian; does that
> produce the most meaningful results if the offset isn't
> aligned?
>
Address along with offset has to be valid to capture the results.


> More comments, below.
>
>                     -Alex
>
>> Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-dcc |  114 ++
>>   drivers/soc/qcom/Kconfig                   |    8 +
>>   drivers/soc/qcom/Makefile                  |    1 +
>>   drivers/soc/qcom/dcc.c                     | 1549 
>> ++++++++++++++++++++++++++++
>>   4 files changed, 1672 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-dcc 
>> b/Documentation/ABI/testing/sysfs-driver-dcc
>> new file mode 100644
>> index 0000000..05d24f0
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-dcc
>
> Throughout this file, add a space or two after each period.
>
>> @@ -0,0 +1,114 @@
>> +What:           /sys/bus/platform/devices/.../trigger
>> +Date:           March 2021
>
> Probably update these dates when the code is close to
> getting accepted.

Ack

>
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +        This is the sysfs interface for manual software
>
> Try to reword each of the descriptions so they don't
> talk about "this sysfs interface."  Each one of these
> *is* describing a sysfs interface file, so that can be
> omitted from the description.  For example:
>
>     This file is used to perform a manual trigger
>     operation, causing all lists of memory operations
>     to be executed.
>
> Or something along those lines.
Ack
>
>> +        triggers.The user can simply enter a 1 against
>> +        the sysfs file and enable a manual trigger.
>> +        Example:
>> +        echo  1 > /sys/bus/platform/devices/.../trigger
>> +
>> +What:           /sys/bus/platform/devices/.../enable
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +        This sysfs interface is used for enabling the
>> +        the dcc hardware.Without this being set to 1,
>> +        the dcc hardware ceases to function.
>
> This could/should use a standard Boolean interface.  That is,
> parse the input in your code using kstrtobool() on the buffer
> passed to your store function.

Ack

>
>
>
>> +        Example:
>> +        echo  0 > /sys/bus/platform/devices/.../enable
>> +        (disable interface)
>> +        echo  1 > /sys/bus/platform/devices/.../enable
>> +        (enable interface)
>> +
>> +What:           /sys/bus/platform/devices/.../config
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +        This is the most commonly used sysfs interface
>> +        file and this basically stores the addresses of
>
> It doesn't matter if this is the "most commonly used" file.
> Just describe what it does.
>
> If I understand it right, you write a memory offset and
> an (optional) number of consecutive memory addresses to
> be read.

That's right.  Ack.

>
>> +        the registers which needs to be read in case of
>> +        a hardware crash or manual software triggers.
>> +        Example:
>> +        echo  0x80000010 10 > /sys/bus/platform/devices/../config
>> +        This specifies that 10 words starting from address
>> +        0x80000010 is to be read.In case there are no words to be
>> +        specified we can simply enter the address.
>
> I don't know what "in case there are no words to be specified"
> means.  Does that just mean memory at exactly one offset is
> read is implied if a count is not specified?

That's correct.Will update accordingly

>
>
>> +
>> +What:           /sys/bus/platform/devices/.../config_write
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +        This file allows user to write a value to the register
>> +        address given as argument.The values are entered in the
>> +        form of <register_address> <value>.The reason for this
>> +        feature of dcc is that for accessing certain registers
>> +        it is necessary to set some bits of soe other register.
>> +        That is achievable by giving DCC this privelege.
>> +        Example:
>> +        echo 0x80000000 0xFF > 
>> /sys/bus/platform/devices/.../config_write
>> +
>> +What:           /sys/bus/platform/devices/.../config_reset
>> +Date:           March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +        This file is used to reset the configuration of
>> +        a dcc driver to the default configuration.
>
> What does it mean to "reset the driver to the default"?
> Does that mean all lists of operations supplied previously
> are forgotten, and the lists become empty and disabled?

That's correct. Will update accordingly.

>
>> +        Example:
>> +        echo  1 > /sys/bus/platform/devices/.../config_reset
>> +
>> +What:           /sys/bus/platform/devices/.../loop
>> +Date:        March 2021
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>
> Can looping be done for a write or read/modify/write operation,
> or is it only used for reads?

Looping is only for read operations.

>
> Now skipping ahead to the code.
>
>> +        This file is used to enter the loop count as dcc
>> +        driver gives the option to loop multiple times on
>> +        the same register and store the values for each
>
> . . .
>
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
>> +#define TIMEOUT_US        5000
>
> This timeout is only used when polling the STATUS register to
> determine when the DCC hardware is "ready".  Maybe the name
> could reflect that (STATUS_READY_TIMEOUT?).
>
Ack
> I think the next two might be better implemented as functions.
> It would allow the compiler to do some additional type checking.

Ack

>
>
>> +#define dcc_writel(drvdata, val, off)                    \
>> +    writel((val), drvdata->base + dcc_offset_conv(drvdata, off))
>> +#define dcc_readl(drvdata, off)                        \
>> +    readl(drvdata->base + dcc_offset_conv(drvdata, off))
>> +
>> +#define DCC_SRAM_NODE "dcc_sram"
>> +
>> +/* DCC registers */
>> +#define DCC_HW_INFO            0x04
>> +#define DCC_LL_NUM_INFO            0x10
>> +#define DCC_STATUS            0x1C
>> +#define DCC_LL_LOCK(m)            (0x34 + 0x80 * m)
>> +#define DCC_LL_CFG(m)            (0x38 + 0x80 * m)
>> +#define DCC_LL_BASE(m)            (0x3c + 0x80 * m)
>> +#define DCC_FD_BASE(m)            (0x40 + 0x80 * m)
>> +#define DCC_LL_TIMEOUT(m)        (0x44 + 0x80 * m)
>> +#define DCC_LL_INT_ENABLE(m)        (0x4C + 0x80 * m)
>> +#define DCC_LL_INT_STATUS(m)        (0x50 + 0x80 * m)
>> +#define DCC_LL_SW_TRIGGER(m)        (0x60 + 0x80 * m)
>> +#define DCC_LL_BUS_ACCESS_STATUS(m)    (0x64 + 0x80 * m)
>
> The MAP_LEVEL and MAP_OFFSET definitions below, together
> with the function dcc_offset_conv(), are a clever way to
> have the above set of offsets "work" by mapping them to
> (at least) three distinct "actual" addresses.  That is:
>
>     if (map_ver == 1)
>
>         if (0 <= offset < MAP_LEVEL_1)
>
>             actual_offset = offset
>
>         else if (MAP_LEVEL_1 <= offset < MAP_LEVEL_2)
>
>             actual_offset = offset - MAP_OFFSET_1
>
>         else if (MAP_LEVEL_2 <= offset < MAP_LEVEL_3)
>
>             actual_offset = offset - MAP_OFFSET_2
>
>         else
>
>             actual_offset = offset - MAP_OFFSET_3
>
>     else
>  if (map_ver == 2)
>         if (0 <= offset < MAP_LEVEL_1)
>
>             actual_offset = offset
>
>         else
>
>             actual_offset = offset - MAP_OFFSET_4
>
>     else
>             actual_offset = offset
>
> This is a bit messy, but other ways of doing it aren't
> likely to be any cleaner.  Regardless, this whole mapping
> process should be explained in comments.

Ack

>
>> +#define DCC_MAP_LEVEL1            0x18
>> +#define DCC_MAP_LEVEL2            0x34
>> +#define DCC_MAP_LEVEL3            0x4C
>> +
>> +#define DCC_MAP_OFFSET1            0x10
>> +#define DCC_MAP_OFFSET2            0x18
>> +#define DCC_MAP_OFFSET3            0x1C
>> +#define DCC_MAP_OFFSET4            0x8
>> +
>> +#define DCC_FIX_LOOP_OFFSET        16
>> +#define DCC_VER_INFO_BIT        9
>> +
>> +#define DCC_READ            0
>> +#define DCC_WRITE            1
>> +#define DCC_LOOP            2
>> +#define DCC_READ_WRITE            3
>> +
>> +#define MAX_DCC_OFFSET            GENMASK(9, 2)
>> +#define MAX_DCC_LEN            GENMASK(6, 0)
>> +#define MAX_LOOP_CNT            GENMASK(7, 0)
>> +
>> +#define DCC_ADDR_DESCRIPTOR        0x00
>> +#define DCC_ADDR_LIMIT            27
>> +#define DCC_ADDR_OFF_RANGE        8
>> +#define DCC_ADDR_RANGE            GENMASK(31, 4)
>> +#define DCC_LOOP_DESCRIPTOR        BIT(30)
>> +#define DCC_RD_MOD_WR_DESCRIPTOR    BIT(31)
>> +#define DCC_LINK_DESCRIPTOR        GENMASK(31, 30)
>> +
>> +#define DCC_READ_IND            0x00
>> +#define DCC_WRITE_IND            (BIT(28))
>> +
>> +#define DCC_AHB_IND            0x00
>> +#define DCC_APB_IND            BIT(29)
>> +
>> +#define DCC_MAX_LINK_LIST        8
>> +#define DCC_INVALID_LINK_LIST        GENMASK(7, 0)
>> +
>> +#define DCC_VER_MASK1            GENMASK(6, 0)
>> +#define DCC_VER_MASK2            GENMASK(5, 0)
>> +
>> +#define DCC_RD_MOD_WR_ADDR              0xC105E
>> +
>> +struct qcom_dcc_config {
>
> No need for "qcom_" in the type name here.

Ack

>
>
>> +    int dcc_ram_offset;
>> +};
>> +
>> +enum dcc_descriptor_type {
>> +    DCC_ADDR_TYPE,
>> +    DCC_LOOP_TYPE,
>> +    DCC_READ_WRITE_TYPE,
>> +    DCC_WRITE_TYPE
>> +};
>> +
>> +enum dcc_mem_map_ver {
>> +    DCC_MEM_MAP_VER1 = 1,
>> +    DCC_MEM_MAP_VER2 = 2,
>> +    DCC_MEM_MAP_VER3 = 3
>
> This enumerated type doesn't really add any value.  Just use 1, 2, and 3
> for your version numbers in the few places this is used in code. If it
> gets more complicated than this one-to-one mapping in the future, add
> a type like this.
  Ack
>
>> +};
>> +
>> +struct dcc_config_entry {
>
> . . .
>
>> +static bool dcc_ready(struct dcc_drvdata *drvdata)
>> +{
>> +    u32 val;
>> +
>> +    return !readl_poll_timeout((drvdata->base + 
>> dcc_offset_conv(drvdata, DCC_STATUS)),
>
> Use dcc_readl(drvdata, offset) here.
Ack
>
>> +                val, (FIELD_GET(GENMASK(1, 0), val) == 0), 1, 
>> TIMEOUT_US);
>
> Use !FIELD_GET(...) here.
Ack
>
>
> Is the 1 microsecond delay required?

Ack

>
>
>> +
>> +}
>> +
>> +static int dcc_read_status(struct dcc_drvdata *drvdata)
>> +{
>> +    int curr_list;
>> +    u32 bus_status;
>> +    u32 ll_cfg;
>> +    u32 tmp_ll_cfg;
>> +
>> +    for (curr_list = 0; curr_list < drvdata->nr_link_list; 
>> curr_list++) {
>> +        if (!drvdata->enable[curr_list])
>> +            continue;
>> +
>> +        bus_status = dcc_readl(drvdata, 
>> DCC_LL_BUS_ACCESS_STATUS(curr_list));
>> +
>> +        if (bus_status) {
>> +            dev_err(drvdata->dev,
>> +                "Read access error for list %d err: 0x%x.\n",
>> +                curr_list, bus_status);
>> +
>> +            ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(curr_list));
>> +            tmp_ll_cfg = ll_cfg & ~BIT(9);
>> +            dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(curr_list));
>> +            dcc_writel(drvdata, 0x3,
>> +                DCC_LL_BUS_ACCESS_STATUS(curr_list));
>
> What does writing 1 to the bottom two bits of the STATUS
> register do?  Can you represent that with a mask, which
> defines the register field?

Ack. This is used to set the status bits for DCC to configure the 
linkedlist.

>
>> +            dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(curr_list));
>> +            return -ENODATA;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
>> +{
>> +    int ret;
>> +    int curr_list;
>> +    u32 ll_cfg;
>> +    u32 tmp_ll_cfg;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    for (curr_list = 0; curr_list < drvdata->nr_link_list; 
>> curr_list++) {
>> +        if (!drvdata->enable[curr_list])
>> +            continue;
>> +        ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(curr_list));
>> +        tmp_ll_cfg = ll_cfg & ~BIT(9);
>
> What does bit 9 of this register represent?  Why is it turned
> off here?
>
This bit needs to be set for the software trigger to happen as per the

DCC hardware configuration.

>> +        dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(curr_list));
>> +        dcc_writel(drvdata, 1, DCC_LL_SW_TRIGGER(curr_list));
>> +        dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(curr_list));
>
> Does this assume that bit 9 of the register was originally set?

Yes. This is the predefined sequence of operation for the DCC software 
trigger

to take place.

>
>
>> +    }
>> +
>> +    if (!dcc_ready(drvdata)) {
>> +        dev_err(drvdata->dev,
>> +            "DCC is busy after receiving sw tigger.\n");
>> +        ret = -EBUSY;
>> +        goto err;
>> +    }
>> +
>> +    ret = dcc_read_status(drvdata);
>> +
>> +err:
>> +    mutex_unlock(&drvdata->mutex);
>> +    return ret;
>> +}
>> +
>
> . . .
>
>> +static int __dcc_ll_cfg(struct dcc_drvdata *drvdata, int curr_list)
>> +{
>> +    int ret = 0;
>> +    u32 total_len, pos;
>> +    struct dcc_config_entry *entry;
>> +    struct dcc_cfg_attr cfg;
>> +    struct dcc_cfg_loop_attr cfg_loop;
>> +
>> +    memset(&cfg, 0, sizeof(cfg));
>> +    memset(&cfg_loop, 0, sizeof(cfg_loop));
>> +    cfg.sram_offset = drvdata->ram_cfg * 4;
>> +    total_len = 0;
>> +
>> +    list_for_each_entry(entry, &drvdata->cfg_head[curr_list], list) {
>> +        switch (entry->desc_type) {
>> +        case DCC_READ_WRITE_TYPE:
>> +            ret = _dcc_ll_cfg_read_write(drvdata, entry, &cfg);
>> +            if (ret)
>> +                goto overstep;
>> +            break;
>> +
>> +        case DCC_LOOP_TYPE:
>> +            ret = _dcc_ll_cfg_loop(drvdata, entry, &cfg, &cfg_loop, 
>> &total_len);
>> +            if (ret)
>> +                goto overstep;
>> +            break;
>> +
>> +        case DCC_WRITE_TYPE:
>> +            ret = _dcc_ll_cfg_write(drvdata, entry, &cfg, &total_len);
>> +            if (ret)
>> +                goto overstep;
>> +            break;
>> +
>> +        default:
>
> Use this instead of "default":
>         case DCC_ADDR_TYPE:

Ack

>
>> +            ret = _dcc_ll_cfg_default(drvdata, entry, &cfg, &pos, 
>> &total_len);
>> +            if (ret)
>> +                goto overstep;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (cfg.link) {
>> +        ret = dcc_sram_writel(drvdata, cfg.link, cfg.sram_offset);
>> +        if (ret)
>> +            goto overstep;
>> +        cfg.sram_offset += 4;
>> +    }
>
> . . .
>
>> +static ssize_t enable_show(struct device *dev,
>> +    struct device_attribute *attr, char *buf)
>> +{
>> +    int ret;
>> +    bool dcc_enable = false;
>> +    struct dcc_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +    if (drvdata->curr_list >= drvdata->nr_link_list) {
>> +        dev_err(dev, "Select link list to program using curr_list\n");
>
> Can this actually happen?  Isn't curr_list initially 0?
> And can't you constrain the store function for curr_list
> so it never exceeds nr_link_list?

Ack

>
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    dcc_enable = is_dcc_enabled(drvdata);
>> +
>> +    ret = scnprintf(buf, PAGE_SIZE, "%u\n",
>> +                (unsigned int)dcc_enable > +err:
>> +    mutex_unlock(&drvdata->mutex);
>> +    return ret;
>> +}
>> +
>> +static ssize_t enable_store(struct device *dev,
>> +                struct device_attribute *attr,
>> +                const char *buf, size_t size)
>> +{
>> +    int ret = 0;
>> +    unsigned long val;
>> +    struct dcc_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    if (kstrtoul(buf, 16, &val))
>> +        return -EINVAL;
>
> I recommend using kstrtobool() here.

Ack

>
>
>> +
>> +    if (val)
>> +        ret = dcc_enable(drvdata);
>> +    else
>> +        dcc_disable(drvdata);
>> +
>> +    if (!ret)
>> +        ret = size;
>> +
>> +    return ret;
>> +
>> +}
>
> . . .
>
>> +static ssize_t config_write_store(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        const char *buf, size_t size)
>> +{
>> +    int ret;
>> +    int nval;
>> +    unsigned int addr, write_val;
>> +    int apb_bus = 0;
>> +    struct dcc_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    nval = sscanf(buf, "%x %x %d", &addr, &write_val, &apb_bus);
>
> You didn't document in the sysfs documentation the optional
> third argument here, which specify APB rather than AHB bus.
Ack
>
>
>> +    if (nval <= 1 || nval > 3) {
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    if (drvdata->curr_list >= drvdata->nr_link_list) {
>> +        dev_err(dev, "Select link list to program using curr_list\n");
>
> Here again (and everywhere else), avoid this possible error
> condition by guaranteeing it will never be assigned a value
> that's larger than nr_link_list.
Ack
>
>
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    if (nval == 3 && apb_bus != 0)
>> +        apb_bus = 1;
>> +
>> +    ret = dcc_add_write(drvdata, addr, write_val, apb_bus);
>> +    if (ret)
>> +        goto err;
>> +
>> +    mutex_unlock(&drvdata->mutex);
>> +    return size;
>> +err:
>> +    mutex_unlock(&drvdata->mutex);
>> +    return ret;
>> +}
>> +
>> +static DEVICE_ATTR_WO(config_write);
>> +
>> +static const struct device_attribute *dcc_attrs[] = {
>> +    &dev_attr_trigger,
>> +    &dev_attr_enable,
>> +    &dev_attr_config,
>> +    &dev_attr_config_reset,
>> +    &dev_attr_ready,
>> +    &dev_attr_interrupt_disable,
>> +    &dev_attr_loop,
>> +    &dev_attr_rd_mod_wr,
>> +    &dev_attr_curr_list,
>> +    &dev_attr_config_write,
>> +    NULL,
>> +};
>> +
>> +static int dcc_create_files(struct device *dev,
>> +                    const struct device_attribute **attrs)
>> +{
>> +    int ret = 0, i;
>
> Cant these be initialized automatically as an attribute group
> or something?  Maybe I'm getting confused.
Ack. Attr group can be used in this case.
>
>
>> +    for (i = 0; attrs[i] != NULL; i++) {
>> +        ret = device_create_file(dev, attrs[i]);
>> +        if (ret) {
>> +            dev_err(dev, "DCC: Couldn't create sysfs attribute: %s\n",
>> +                attrs[i]->attr.name);
>> +            break;
>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int dcc_sram_open(struct inode *inode, struct file *file)
>> +{
>> +    struct dcc_drvdata *drvdata = container_of(inode->i_cdev,
>> +        struct dcc_drvdata,
>> +        sram_dev);
>> +    file->private_data = drvdata;
>> +
>> +    return    0;
>> +}
>> +
>> +static ssize_t dcc_sram_read(struct file *file, char __user *data,
>> +                        size_t len, loff_t *ppos)
>> +{
>> +    unsigned char *buf;
>> +    struct dcc_drvdata *drvdata = file->private_data;
>> +
>> +    /* EOF check */
>> +    if (drvdata->ram_size <= *ppos)
>> +        return 0;
>> +
>> +    if ((*ppos + len) > drvdata->ram_size)
>> +        len = (drvdata->ram_size - *ppos);
>> +
>> +    buf = kzalloc(len, GFP_KERNEL);
>> +    if (!buf)
>> +        return -ENOMEM;
>> +
>> +    memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
>> +
>> +    if (copy_to_user(data, buf, len)) {
>> +        dev_err(drvdata->dev, "DCC: Couldn't copy all data to user\n");
>
> Don't allow user input (i.e., providing a bad buffer pointer
> in this case) lead to spamming the log.  The EFAULT error is
> enough to explain what the problem is.  In generaly, I don't
> think you should call dev_err() in these sysfs functions.

Ack

>
>
>> +        kfree(buf);
>> +        return -EFAULT;
>> +    }
>> +
>> +    *ppos += len;
>> +
>> +    kfree(buf);
>> +
>> +    return len;
>> +}
>> +
>> +static const struct file_operations dcc_sram_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .open        = dcc_sram_open,
>> +    .read        = dcc_sram_read,
>> +    .llseek        = no_llseek,
>> +};
>
>
> Since dcc_sram_dev_init() does nothing but call this function,
> why not just incorporate one into the other?  Same thing goes
> for dcc_sram_dev_exit() and dcc_sram_dev_deregister().
Ack
>
>
>> +static int dcc_sram_dev_register(struct dcc_drvdata *drvdata)
>> +{
>> +    int ret;
>> +    struct device *device;
>> +    dev_t dev;
>> +
>> +    ret = alloc_chrdev_region(&dev, 0, 1, DCC_SRAM_NODE);
>> +    if (ret)
>> +        goto err_alloc;
>> +
>> +    cdev_init(&drvdata->sram_dev, &dcc_sram_fops);
>> +
>> +    drvdata->sram_dev.owner = THIS_MODULE;
>> +    ret = cdev_add(&drvdata->sram_dev, dev, 1);
>> +    if (ret)
>> +        goto err_cdev_add;
>> +
>> +    drvdata->sram_class = class_create(THIS_MODULE, DCC_SRAM_NODE);
>> +    if (IS_ERR(drvdata->sram_class)) {
>> +        ret = PTR_ERR(drvdata->sram_class);
>> +        goto err_class_create;
>> +    }
>> +
>> +    device = device_create(drvdata->sram_class, NULL,
>> +                        drvdata->sram_dev.dev, drvdata,
>> +                        DCC_SRAM_NODE);
>> +    if (IS_ERR(device)) {
>> +        ret = PTR_ERR(device);
>> +        goto err_dev_create;
>> +    }
>> +
>> +    return 0;
>> +err_dev_create:
>> +    class_destroy(drvdata->sram_class);
>> +err_class_create:
>> +    cdev_del(&drvdata->sram_dev);
>> +err_cdev_add:
>> +    unregister_chrdev_region(drvdata->sram_dev.dev, 1);
>> +err_alloc:
>> +    return ret;
>> +}
>> +
>> +static void dcc_sram_dev_deregister(struct dcc_drvdata *drvdata)
>> +{
>> +    device_destroy(drvdata->sram_class, drvdata->sram_dev.dev);
>> +    class_destroy(drvdata->sram_class);
>> +    cdev_del(&drvdata->sram_dev);
>> +    unregister_chrdev_region(drvdata->sram_dev.dev, 1);
>> +}
>> +
>> +static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
>> +{
>> +    int ret = 0;
>> +
>> +    ret = dcc_sram_dev_register(drvdata);
>> +    if (ret)
>> +        dev_err(drvdata->dev, "DCC: sram node not registered.\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
>> +{
>> +    dcc_sram_dev_deregister(drvdata);
>> +}
>> +
>> +static int dcc_probe(struct platform_device *pdev)
>> +{
>> +    u32 val;
>> +    int ret = 0, i, enable_size, nr_config_size, cfg_head_size;
>> +    struct device *dev = &pdev->dev;
>> +    struct dcc_drvdata *dcc;
>> +    struct resource *res;
>> +    const struct qcom_dcc_config *cfg;
>> +
>> +    dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
>> +    if (!dcc)
>> +        return -ENOMEM;
>> +
>> +    dcc->dev = &pdev->dev;
>> +    platform_set_drvdata(pdev, dcc);
>> +
>> +    dcc->base = devm_platform_ioremap_resource(pdev, 0);
>
> I mentioned earlier, it might be nice to give these memory
> ranges a name more meaningful than 0 and 1.
Reason explained in the reply on the previous patch.
>
>
>> +    if (IS_ERR(dcc->base))
>> +        return PTR_ERR(dcc->base);
>> +
>> +    dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, 
>> &res);
>> +    if (IS_ERR(dcc->ram_base))
>> +        return PTR_ERR(dcc->ram_base);
>> +
>> +    dcc->ram_size = resource_size(res);
>
> Did you already take care of remapping with the call just above?
Ack
>
>
>> +    dcc->ram_base = devm_ioremap(dev, res->start, resource_size(res));
>> +    if (!dcc->ram_base)
>> +        return -ENOMEM;
>
> In any case, I think this second memory region is more like
> memory space than I/O space.  If so, memremapping it might
> be the right thing to do.

  Ack

>
>
>> +    cfg = of_device_get_match_data(&pdev->dev);
>> +    dcc->ram_offset = cfg->dcc_ram_offset;
>> +
>> +    val = dcc_readl(dcc, DCC_HW_INFO);
>
> Can you provide a short block of code that explains in English
> what the next set of if statements are doing, and why?

So here I am finding out the memory map version of DCC by reading 
DCC_HW_INFO register.

If DCC_VER_INFO_BIT(9) of DCC_HW_INFO is set then

memory map version is 3 and max supported link list is the value at 
register DCC_LL_NUM_INFO.

If  all the first 7 bits(0x7F) of DCC_HW_INFO is set, then

memory map version is 2 and  max supported link list is the value at 
register DCC_LL_NUM_INFO.

If none of the above is true then

Memory map version is 1 and max supported link list is 
DCC_MAX_LINK_LIST(predefined) which is 8.

>
>> +    if (FIELD_GET(BIT(DCC_VER_INFO_BIT), val)) {
>> +        dcc->mem_map_ver = DCC_MEM_MAP_VER3;
>> +        dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +        if (dcc->nr_link_list == 0)
>> +            return    -EINVAL;
>> +    } else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
>> +        dcc->mem_map_ver = DCC_MEM_MAP_VER2;
>> +        dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +        if (dcc->nr_link_list == 0)
>> +            return    -EINVAL;
>> +    } else {
>> +        dcc->mem_map_ver = DCC_MEM_MAP_VER1;
>> +        dcc->nr_link_list = DCC_MAX_LINK_LIST;
>> +    }
>
> What does bit 6 in the HW_INFO register represent?

This gives the loop_offset value type for the dcc version which is used in

case of loop addresses.

>
>
>> +    if ((val & BIT(6)) == BIT(6))
>
>     if (val & BIT(6))
>
>> +        dcc->loopoff = DCC_FIX_LOOP_OFFSET;
>> +    else
>> +        dcc->loopoff = get_bitmask_order((dcc->ram_size +
>> +                dcc->ram_offset) / 4 - 1);
>> +
>> +    mutex_init(&dcc->mutex);
>> +    /* Allocate space for all entries at once */
>> +    enable_size = dcc->nr_link_list * sizeof(bool);
>> +    nr_config_size = dcc->nr_link_list * sizeof(size_t);
>> +    cfg_head_size = dcc->nr_link_list * sizeof(struct list_head);
>> +
>> +    dcc->enable = devm_kzalloc(dev, enable_size + nr_config_size + 
>> cfg_head_size, GFP_KERNEL);
>> +    if (!dcc->enable)
>> +        return -ENOMEM;
>> +
>> +    dcc->nr_config  = (size_t *)(dcc->enable + dcc->nr_link_list);
>> +    dcc->cfg_head = (struct list_head *)(dcc->nr_config + 
>> dcc->nr_link_list);
>> +
>> +    for (i = 0; i < dcc->nr_link_list; i++)
>> +        INIT_LIST_HEAD(&dcc->cfg_head[i]);
>> +
>> +    dcc->curr_list = DCC_INVALID_LINK_LIST;
>> +    ret = dcc_sram_dev_init(dcc);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return dcc_create_files(dev, dcc_attrs);
>
> If dcc_create_files() returns an error, you are not calling
> dcc_sram_dev_exit() to clean things up.

Ack

>
>
>> +}
>> +
>> +static int dcc_remove(struct platform_device *pdev)
>> +{
>> +    struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
>> +
>> +    dcc_sram_dev_exit(drvdata);
>> +
>> +    dcc_config_reset(drvdata);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct qcom_dcc_config sm8150_cfg = {
>> +    .dcc_ram_offset    = 0x5000,
>
> If you know you'll be adding more fields there's nothing
> wrong with this, but if the only thing you're storing is
> the RAM offset, there's no need to define that within a
> structure.  Just do something like:
>
>     { .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
>
Ack
>> +};
>> +
>> +static const struct qcom_dcc_config sc7280_cfg = {
>> +    .dcc_ram_offset = 0x12000,
>> +};
>> +
>> +static const struct qcom_dcc_config sc7180_cfg = {
>> +    .dcc_ram_offset = 0x6000,
>> +};
>> +
>> +static const struct qcom_dcc_config sdm845_cfg = {
>> +    .dcc_ram_offset = 0x6000,
>> +};
>> +
>> +static const struct of_device_id dcc_match_table[] = {
>> +    { .compatible = "qcom,sm8150-dcc", .data = &sm8150_cfg },
>> +    { .compatible = "qcom,sc7280-dcc", .data = &sc7280_cfg },
>> +    { .compatible = "qcom,sc7180-dcc", .data = &sc7180_cfg },
>> +    { .compatible = "qcom,sdm845-dcc", .data = &sdm845_cfg },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, dcc_match_table);
>> +
>> +static struct platform_driver dcc_driver = {
>> +    .probe = dcc_probe,
>> +    .remove    = dcc_remove,
>> +    .driver    = {
>> +        .name = "qcom-dcc",
>> +        .of_match_table    = dcc_match_table,
>> +    },
>> +};
>> +
>> +module_platform_driver(dcc_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
>> +
>>
>
>
>
