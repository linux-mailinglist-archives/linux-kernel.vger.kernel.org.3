Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29751CF05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388342AbiEFCjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiEFCjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:39:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686B5A58E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:36:00 -0700 (PDT)
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KvZLr3LVkzNkT6;
        Fri,  6 May 2022 10:31:16 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 10:35:58 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:35:57 +0800
Subject: Re: [PATCH v5 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <Jonathan_Lucas@mentor.com>
References: <20220416083953.52610-1-liuqi115@huawei.com>
 <20220416083953.52610-2-liuqi115@huawei.com>
 <91a6f78d-1d8c-4b5b-3fc3-0c8866b184ad@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <19061fcb-37b9-2fe8-508a-5f60bdc07639@huawei.com>
Date:   Fri, 6 May 2022 10:35:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91a6f78d-1d8c-4b5b-3fc3-0c8866b184ad@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,

thanks for your review, some replies below.

On 2022/5/6 8:26, Suzuki K Poulose wrote:
> Hi Qi Liu
> 
> Apologies for the delay. I have some more comments below.
>  > On 16/04/2022 09:39, Qi Liu wrote:
>> This patch adds driver for UltraSoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these CPU instructions in system memory.
>>
>> SMB is developed by UltraSoc technology, which is acquired by
>> Siemens, and we still use "UltraSoc" to name driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Tested-by: JunHao He <hejunhao2@hisilicon.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig        |  10 +
>>   drivers/hwtracing/coresight/Makefile       |   1 +
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 643 +++++++++++++++++++++
>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 106 ++++
>>   4 files changed, 760 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index 514a9b8086e3..4380eb1a0a73 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called coresight-trbe.
>> +config ULTRASOC_SMB
>> +    tristate "Ultrasoc system memory buffer drivers"
>> +    depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
>> +    help
>> +      This driver provides support for the Ultrasoc system memory 
>> buffer (SMB).
>> +      SMB is responsible for receiving the trace data from Coresight 
>> ETM devices
>> +      and storing them to a system buffer.
>> +
>> +      To compile this driver as a module, choose M here: the module 
>> will be
>> +      called ultrasoc-smb.
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile 
>> b/drivers/hwtracing/coresight/Makefile
>> index b6c4a48140ec..344dba8d6ff8 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -27,3 +27,4 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c 
>> b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> new file mode 100644
>> index 000000000000..9a93b7fc7bda
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -0,0 +1,643 @@
>> +// SPDX-License-Identifier: MIT/GPL
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2021, HiSilicon Limited.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/circ_buf.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "ultrasoc-smb.h"
>> +
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "ultra_smb");
>> +
>> +#define ULTRASOC_SMB_DSM_UUID    "82ae1283-7f6a-4cbe-aa06-53e8fb24db18"
>> +
>> +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
>> +{
>> +    u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
>> +
>> +    return buf_status & BIT(0) ? false : true;
>> +}
>> +
>> +static bool smb_buffer_cmp_pointer(struct smb_drv_data *drvdata)
>> +{
>> +    u32 wr_offset, rd_offset;
>> +
>> +    wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR);
>> +    rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR);
>> +    return wr_offset == rd_offset;
>> +}
>> +
>> +static void smb_reset_buffer_status(struct smb_drv_data *drvdata)
>> +{
>> +    writel(0xf, drvdata->base + SMB_LB_INT_STS);
>> +}
>> +
>> +/* Purge data remaining in hardware path in case them influence next 
>> trace */
>> +static void smb_purge_data(struct smb_drv_data *drvdata)
>> +{
>> +    writel(0x1, drvdata->base + SMB_LB_PURGE);
>> +}
>> +
>> +static void smb_update_data_size(struct smb_drv_data *drvdata)
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    u32 write_offset;
>> +
>> +    smb_purge_data(drvdata);
>> +    if (smb_buffer_cmp_pointer(drvdata)) {
>> +        if (smb_buffer_is_empty(drvdata))
>> +            sdb->data_size = 0;
>> +        else
>> +            sdb->data_size = sdb->buf_size;
> 
> What happens when the buffer is full ? Does the sink stop writing ?
> Or does it keep on overwriting in a circular buffer mode ?
> If it does keep overwriting, we would need to make sure to update the
> sdb->rd_offset so that we provide the latest data (in smb_read())?
> If it doesn't overwrite, I think this logic could be simpler (similar
> to the tmc-et* circular buffer mode calculation.
> 

sink will stop writing when the buffer is full, and I'll simplify this 
function like this:

static void smb_buffer_is_full(struct smb_drv_data *drvdata)
{
	if (smb_buffer_cmp_pointer(drvdata) && !smb_buffer_is_empty(drvdata))
		return true;
	return false;
}

static void smb_update_data_size(struct smb_drv_data *drvdata)
{
	struct smb_data_buffer *sdb = &drvdata->sdb;
	u32 write_offset;

	if (smb_buffer_is_full(drvdata)) {
		sdb->data_size = sdb->buf_size;
		return;
	}

	write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) -
sdb->start_addr;
	sdb->data_size = CIRC_CNT(write_offset, sdb->rd_offset,
sdb->buf_size);
}
> 
>> +        return;
>> +    }
>> +
>> +    write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - 
>> sdb->start_addr;
>> +    sdb->data_size = CIRC_CNT(write_offset, sdb->rd_offset, 
>> sdb->buf_size);
>> +}
>> +
>> +static int smb_open(struct inode *inode, struct file *file)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
>> +
>> +    if (local_cmpxchg(&drvdata->reading, 0, 1))
> 
> I believe this must be done in the smb_read(). Please see my comment
> for smb_disable()
> 
got it, I'll change this like:

static int smb_open(struct inode *inode, struct file *file)
{
	struct smb_drv_data *drvdata = container_of(file->private_data, struct 
smb_drv_data, miscdev);
	ret = 0;

	spin_lock_irqsave(&drvdata->spinlock, flags);

	if (drvdata->reading) {
		ret = -EBUSY;
		goto out;
	}

	if (drvdata->mode == CS_MODE_PERF) {
		ret = -EINVAL;
		goto out;
	}

	if (atomic_read(drvdata->csdev->refcnt))
		ret = -EBUSY;

out:
	spin_unlock_irqrestore(&drvdata->spinlock, flags);
	return ret;
}
>> +        return -EBUSY;
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t smb_read(struct file *file, char __user *data, size_t 
>> len,
>> +            loff_t *ppos)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                        struct smb_drv_data, miscdev);
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    struct device *dev = &drvdata->csdev->dev;
>> +    unsigned long flags;
>> +    int to_copy = 0;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (atomic_read(drvdata->csdev->refcnt)) {
>> +        spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +        return -EBUSY;
>> +    }
>> +
>> +    if (!sdb->data_size) {
>> +        smb_update_data_size(drvdata);
>> +        if (!sdb->data_size)
>> +            goto out;
>> +    }
>> +
>> +    to_copy = min(sdb->data_size, len);
>> +
>> +    /* Copy parts of trace data when read pointer wrap around SMB 
>> buffer */
>> +    if (sdb->rd_offset + to_copy > sdb->buf_size)
>> +        to_copy = sdb->buf_size - sdb->rd_offset;
>> +
>> +    if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset,
>> +             to_copy)) {
>> +        dev_dbg(dev, "Failed to copy data to user.\n");
>> +        to_copy = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    *ppos += to_copy;
>> +    sdb->data_size -= to_copy;
>> +    sdb->rd_offset += to_copy;
>> +    sdb->rd_offset %= sdb->buf_size;
>> +    writel(sdb->start_addr + sdb->rd_offset,
>> +           drvdata->base + SMB_LB_RD_ADDR);
>> +    dev_dbg(dev, "%d bytes copied.\n", to_copy);
>> +out:
>> +    if (!sdb->data_size)
>> +        smb_reset_buffer_status(drvdata);
>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +    return to_copy;
>> +}
>> +
>> +static int smb_release(struct inode *inode, struct file *file)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                        struct smb_drv_data, miscdev);
>> +    local_set(&drvdata->reading, 0);
>> +    return 0;
>> +}
>> +

[...]
>> +
>> +static int smb_disable(struct coresight_device *csdev)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (local_read(&drvdata->reading)) {
>> +        spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +        return -EBUSY;
>> +    }
>> +
> 
> This is a bit confusing. So, we don't allow "read" when a session
> is in progress (via refcnt check in smb_read()). But the flag,
> drvdata->reading is set as soon as we open(). And we fail the disable
> if the drvdata->reading is set. I guess, we should move the setting
> of the drvdata->reading to smb_read() and set it for the first case
> where we are able to read.
> Otherwise we could see, something like:
> 
> CPU0: smb_enable()         # success, SMB is on
> CPU1: open(/dev/usmb0) # -> set drvdata->reading
> ..
> CPU0: smb_disable() # returns EBUSY since drvdata->reading is on.
> CPU1: read(fd)      # returns EBUSY since there is a refcnt.
> 
> 
got it, I'll change this next version, thanks.
> 
>> +    if (atomic_dec_return(csdev->refcnt)) {
>> +        spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +        return -EBUSY;
>> +    }
>> +
>> +    WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
>> +    smb_disable_hw(drvdata);
>> +    smb_purge_data(drvdata);
>> +
>> +    /*
>> +     * In perf mode, sink->disable is called after 
>> sink->update_buffer, so
+    buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);

[...]
>> +
>> +static unsigned long smb_update_buffer(struct coresight_device *csdev,
>> +                       struct perf_output_handle *handle,
>> +                       void *sink_config)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    struct cs_buffers *buf = sink_config;
>> +    unsigned long data_size = 0;
>> +    unsigned long flags;
>> +    bool lost = false;
>> +
>> +    if (!buf)
>> +        return 0;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    /* Don't do anything if another tracer is using this sink. */
>> +    if (atomic_read(csdev->refcnt) != 1)
>> +        goto out;
>> +
>> +    smb_update_data_size(drvdata);
> 
> Are we allowed to call this when the SMB is ON ? In perf mode, we call
> the update_buffer() before disabling the "sink". So, care must be taken
> to stop the SMB if needed to make sure the registers are read properly.

got it, will do disable smb before smb_update_data_size.
> 
> 
> Rest looks fine to me.
> 
> 
> Suzuki
> .
Thanks,
Qi
