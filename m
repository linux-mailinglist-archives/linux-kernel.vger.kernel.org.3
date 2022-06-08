Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F030542CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiFHKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiFHKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:13:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D822C827
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:00:36 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJ2jy2Gx0z1K9tT;
        Wed,  8 Jun 2022 17:58:46 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 18:00:35 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 18:00:34 +0800
Subject: Re: [PATCH v6 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
References: <20220606130223.57354-1-liuqi115@huawei.com>
 <20220606130223.57354-2-liuqi115@huawei.com>
 <4c4af59c-0b71-c5a5-1d5c-80b2e89de4d9@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <413e09a7-4a03-1beb-f533-9839bff9ddb7@huawei.com>
Date:   Wed, 8 Jun 2022 18:00:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4c4af59c-0b71-c5a5-1d5c-80b2e89de4d9@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,
On 2022/6/7 16:33, Suzuki K Poulose wrote:
> Hi Qi
> 
> On 06/06/2022 14:02, Qi Liu wrote:
>> This patch adds driver for UltraSoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these CPU instructions in system memory.
> 
> nit: "CPU instruction trace" in system memory.
> 
>>
>> SMB is developed by UltraSoc technology, which is acquired by
>> Siemens, and we still use "UltraSoc" to name driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Tested-by: JunHao He <hejunhao2@hisilicon.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig        |  10 +
>>   drivers/hwtracing/coresight/Makefile       |   1 +
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 663 +++++++++++++++++++++
>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 110 ++++
>>   4 files changed, 784 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index 514a9b8086e3..4380eb1a0a73 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
> 
> ...
> 
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
>> index 000000000000..44b4bceb6f28
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> 
> ...
> 
>> +static int smb_open(struct inode *inode, struct file *file)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
>> +    unsigned long flags;
>> +    int ret = 0;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (local_read(&drvdata->reading)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    if (drvdata->mode == CS_MODE_PERF) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +out:
>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +    return ret;
>> +}
>> +
>> +static ssize_t smb_read(struct file *file, char __user *data, size_t 
>> len,
>> +            loff_t *ppos)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
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
>> +    if (local_cmpxchg(&drvdata->reading, 0, 1)) {
>> +        spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +        return -EBUSY;
>> +    }
>> +
> 
> Shouldn't this be done in smb_open() ? Otherwise, a subsequent read
> will fail with EBUSY ?
> i.e,
>      fd = open(/dev/ultra_smb0, ..);
> 
>      # size of the SMB buffer = 1M,
>      size = read(fd, buf, SZ_4K);
>      /* Do something the buf */
>      if (size >= 0)
>          size = read(fd, buf, SZ_4K);
> 
> ^^ This would fail, isn't it ?
> 

Yes, I'll change it to:
static int smb_open(struct inode *inode, struct file *file)
{
	struct smb_drv_data *drvdata = container_of(file->private_data,
					struct smb_drv_data, miscdev);
	unsigned long flags;
	int ret = 0;

	spin_lock_irqsave(&drvdata->spinlock, flags);

	if (local_read(&drvdata->reading)) {
		ret = -EBUSY;
		goto out;
	}

	if (drvdata->mode != CS_MODE_DISABLED) {
		ret = -EBUSY;
		goto out;
	}

	local_set(&drvdata->reading, 1);
out:
	spin_unlock_irqrestore(&drvdata->spinlock, flags);
	return ret;
}

So SMB data can only be read when SMB is disabled, and could be read 
subsequently.

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
[...]
>> +
>> +static int smb_set_perf_buffer(struct perf_output_handle *handle)
>> +{
>> +    struct cs_buffers *buf = etm_perf_sink_config(handle);
>> +    u32 head;
>> +
>> +    if (!buf)
>> +        return -EINVAL;
>> +
>> +    /* Wrap head around to the amount of space we have */
>> +    head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
>> +
>> +    /* Find the page to write to and offset within that page */
>> +    buf->cur = head / PAGE_SIZE;
>> +    buf->offset = head % PAGE_SIZE;
>> +
> 
> I believe these fields should be dropped and instead use the 
> handle->head, to determine the page number and offset. See the
> TMC-ETR driver for e.g.

got it, I'll do this next time.

> 
>> +    local_set(&buf->data_size, 0);
>> +
>> +    return 0;
>> +}
>> +

[...]
>> +
>> +static int smb_enable(struct coresight_device *csdev, u32 mode, void 
>> *data)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret;
>> +
>> +    /* Do nothing if trace data is reading by other interface now */
>> +    if (local_read(&drvdata->reading))
>> +        return -EBUSY;
>> +
> 
> Is there global switch for all the inports ? Or is there a control for
> individual inports to the SMB ? Do we need additional information here
> to enable the corresponding port ?

There is a global switch to enable and disable all the inports in 
smb_config_inport() when probe the SMB driver.

> 
>> +    switch (mode) {
>> +    case CS_MODE_SYSFS:
>> +        ret = smb_enable_sysfs(csdev);
>> +        break;
>> +    case CS_MODE_PERF:
>> +        ret = smb_enable_perf(csdev, data);
>> +        break;
>> +    default:
>> +        ret = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    if (ret)
>> +        return ret;
>> +    dev_dbg(&csdev->dev, "Ultrasoc SMB enabled.\n");
>> +
>> +    return 0;
>> +}
>> +
>> +
>> +static void smb_free_buffer(void *config)
>> +{
>> +    struct cs_buffers *buf = config;
>> +
>> +    kfree(buf);
>> +}
>> +
>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>> +                 struct cs_buffers *buf,
>> +                 unsigned long data_size)
> 
> You may need to pass the aux_handle here, to determine the handle->head
> and the size. See my comments above.
ok, I'll do this next time, thanks.

> 
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    char **dst_pages = (char **)buf->data_pages;
>> +    unsigned long page_offset = buf->offset;
>> +    unsigned int cur = buf->cur;
>> +    unsigned long to_copy;
>> +
>> +    while (data_size) {
>> +        unsigned long page_space = PAGE_SIZE - page_offset;
>> +
>> +        /* Copy parts of trace data when read pointer wrap around */
>> +        if (sdb->rd_offset + page_space > sdb->buf_size)
>> +            to_copy = sdb->buf_size - sdb->rd_offset;
>> +        else
>> +            to_copy = min(data_size, page_space);
>> +
>> +        memcpy_fromio(dst_pages[cur] + page_offset,
>> +                  sdb->buf_base + sdb->rd_offset, to_copy);
>> +
>> +        page_offset += to_copy;
>> +        if (page_offset >= PAGE_SIZE) {
>> +            page_offset = 0;
>> +            cur++;
>> +            cur %= buf->nr_pages;
>> +        }
>> +        data_size -= to_copy;
>> +        sdb->rd_offset += to_copy;
>> +        sdb->rd_offset %= sdb->buf_size;
>> +    }
>> +
>> +    sdb->data_size = 0;
>> +    writel(sdb->start_addr + sdb->rd_offset, drvdata->base + 
>> SMB_LB_RD_ADDR);
>> +
>> +    /*
>> +     * Data remained in link cannot be purged when SMB is full, so
>> +     * synchronize the read pointer to write pointer, to make sure
>> +     * these remained data won't influence next trace.
>> +     */
>> +    if (sdb->full) {
>> +        smb_purge_data(drvdata);
>> +        writel(readl(drvdata->base + SMB_LB_WR_ADDR),
>> +               drvdata->base + SMB_LB_RD_ADDR);
>> +    }
>> +    smb_reset_buffer_status(drvdata);
>> +}
>> +

>> +
>> +static int smb_register_sink(struct platform_device *pdev,
>> +                 struct smb_drv_data *drvdata)
>> +{
>> +    struct coresight_platform_data *pdata = NULL;
>> +    struct coresight_desc desc = { 0 };
>> +    int ret;
>> +
>> +    pdata = coresight_get_platform_data(&pdev->dev);
>> +    if (IS_ERR(pdata))
>> +        return PTR_ERR(pdata);
>> +
>> +    desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +    desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>> +    desc.ops = &cs_ops;
>> +    desc.pdata = pdata;
>> +    desc.dev = &pdev->dev;
>> +    desc.groups = smb_sink_groups;
>> +    desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);
> 
> Please fill in the csdev_access method for the device.
will do this next time, thanks.

Thanks,
Qi
>      desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
> 
>> +    if (!desc.name) {
>> +        dev_err(&pdev->dev, "Failed to alloc coresight device name.");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    drvdata->csdev = coresight_register(&desc);
>> +    if (IS_ERR(drvdata->csdev))
>> +        return PTR_ERR(drvdata->csdev);
>> +
>> +    drvdata->miscdev.name = desc.name;
>> +    drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>> +    drvdata->miscdev.fops = &smb_fops;
>> +    ret = misc_register(&drvdata->miscdev);
>> +    if (ret) {
>> +        coresight_unregister(drvdata->csdev);
>> +        dev_err(&pdev->dev, "Failed to register misc, ret=%d.\n", ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void smb_unregister_sink(struct smb_drv_data *drvdata)
>> +{
>> +    misc_deregister(&drvdata->miscdev);
>> +    coresight_unregister(drvdata->csdev);
>> +}
>> +
>> +static int smb_config_inport(struct device *dev, bool enable)
>> +{
>> +    u64 func = enable ? 1 : 0;
>> +    union acpi_object *obj;
>> +    guid_t guid;
>> +    u64 rev = 0;
>> +
>> +    /*
>> +     * Using DSM calls to enable/disable ultrasoc hardwares on
>> +     * tracing path, to prevent ultrasoc packet format being exposed.
>> +     */
>> +    if (guid_parse(ULTRASOC_SMB_DSM_UUID, &guid)) {
>> +        dev_err(dev, "Get GUID failed.\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, rev, func, NULL);
>> +    if (!obj)
>> +        dev_err(dev, "ACPI handle failed!\n");
>> +    else
>> +        ACPI_FREE(obj);
>> +
>> +    return 0;
>> +}
>> +
>> +static int smb_probe(struct platform_device *pdev)
>> +{
>> +    struct smb_drv_data *drvdata;
>> +    int ret;
>> +
>> +    drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>> +    if (!drvdata)
>> +        return -ENOMEM;
>> +
>> +    drvdata->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(drvdata->base)) {
>> +        dev_err(&pdev->dev, "Failed to ioremap resource.\n");
>> +        return PTR_ERR(drvdata->base);
>> +    }
>> +
>> +    ret = smb_init_data_buffer(pdev, &drvdata->sdb);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Failed to init buffer, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    smb_init_hw(drvdata);
>> +    spin_lock_init(&drvdata->spinlock);
>> +    drvdata->pid = -1;
>> +
>> +    ret = smb_register_sink(pdev, drvdata);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Failed to register smb sink.\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = smb_config_inport(&pdev->dev, true);
>> +    if (ret) {
>> +        smb_unregister_sink(drvdata);
>> +        return ret;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, drvdata);
>> +    return 0;
>> +}
>> +
>> +static int smb_remove(struct platform_device *pdev)
>> +{
>> +    struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
>> +    int ret;
>> +
>> +    ret = smb_config_inport(&pdev->dev, false);
>> +    if (ret)
>> +        return ret;
>> +
>> +    smb_unregister_sink(drvdata);
>> +    return 0;
>> +}
>> +
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +    {"HISI03A1", 0},
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
>> +
>> +static struct platform_driver smb_driver = {
>> +    .driver = {
>> +        .name = "ultrasoc-smb",
>> +        .acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
>> +        .suppress_bind_attrs = true,
>> +    },
>> +    .probe = smb_probe,
>> +    .remove = smb_remove,
>> +};
>> +module_platform_driver(smb_driver);
>> +
>> +MODULE_DESCRIPTION("UltraSoc smb driver");
> 
> "UltraSoc SMB CoreSight driver"
> 
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> 
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h 
>> b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> new file mode 100644
>> index 000000000000..a01f869fe122
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> @@ -0,0 +1,110 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2021, HiSilicon Limited.
>> + */
>> +
>> +#ifndef _ULTRASOC_SMB_H
>> +#define _ULTRASOC_SMB_H
>> +
>> +#include <linux/coresight.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +
>> +#include "coresight-etm-perf.h"
>> +#include "coresight-priv.h"
>> +
>> +/* Offset of SMB logical buffer registers */
>> +#define SMB_CFG_REG        0x00
>> +#define SMB_GLOBAL_EN        0x04
>> +#define SMB_GLOBAL_INT        0x08
>> +#define SMB_LB_CFG_LO        0x40
>> +#define SMB_LB_CFG_HI        0x44
>> +#define SMB_LB_INT_CTRL        0x48
>> +#define SMB_LB_INT_STS        0x4c
>> +#define SMB_LB_LIMIT        0x58
>> +#define SMB_LB_RD_ADDR        0x5c
>> +#define SMB_LB_WR_ADDR        0x60
>> +#define SMB_LB_PURGE        0x64
>> +
>> +/* Set SMB_CFG_REG register */
>> +#define SMB_BURST_LEN        GENMASK(7, 4)
>> +#define SMB_IDLE_PRD        GENMASK(15, 12)
>> +#define SMB_MEM_WR        GENMASK(17, 16)
>> +#define SMB_MEM_RD        (GENMASK(26, 25) | GENMASK(23, 22))
>> +#define SMB_GLOBAL_CFG        (SMB_IDLE_PRD |    SMB_MEM_WR | 
>> SMB_MEM_RD | \
>> +                 SMB_BURST_LEN)
>> +
>> +/* Set SMB_GLOBAL_INT register */
>> +#define SMB_INT_EN        BIT(0)
>> +#define SMB_INT_TYPE_PULSE    BIT(1)
>> +#define SMB_INT_POLARITY_HIGH    BIT(2)
>> +#define SMB_GLB_INT_CFG        (SMB_INT_EN | SMB_INT_TYPE_PULSE |    \
>> +                 SMB_INT_POLARITY_HIGH)
>> +
>> +/* Set SMB_LB_CFG_LO register */
>> +#define SMB_BUF_EN        BIT(0)
>> +#define SMB_BUF_SINGLE_END    BIT(1)
>> +#define SMB_BUF_INIT        BIT(8)
>> +#define SMB_BUF_CONTINUOUS    BIT(11)
>> +#define SMB_FLOW_MASK        GENMASK(19, 16)
> 
> What does the value GENMASK(19, 16) indicate for SMB_FLOW ? That is the
> value being passed down. Please add a descriptive name.
> .e.g,
> 
> #define SMB_FLOW_MODE_X        GENMASK(19, 16)
> 
> Similarly for SMB_BUF_NOTE_MASK, unless there is an explanation.
> 
>> +#define SMB_BUF_CFG_STREAMING    (SMB_BUF_INIT | SMB_BUF_CONTINUOUS 
>> |    \
>> +                 SMB_FLOW_MASK | SMB_BUF_SINGLE_END |    \
>> +                 SMB_BUF_EN)
>> +
>> +#define SMB_BASE_LOW_MASK    GENMASK(31, 0)
>> +
>> +/* Set SMB_LB_CFG_HI register */
>> +#define SMB_MSG_FILTER        GENMASK(15, 8)
>> +
>> +/* Set SMB_LB_INT_CTRL */
>> +#define SMB_BUF_INT_EN        BIT(0)
>> +#define SMB_BUF_NOTE_MASK    GENMASK(11, 8)
>> +#define SMB_BUF_INT_CFG        (SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
>> +
>> +/**
>> + * struct smb_data_buffer - Details of the buffer used by SMB
>> + * @buf_base    : Memory mapped base address of SMB.
>> + * @start_addr    : SMB buffer start Physical address.
>> + * @buf_size    : Size of the buffer.
> 
> Please align the field definitions.
> 
>> + * @data_size    : Size of Trace data copy to userspace.
>> + * @rd_offset    : Offset of the read pointer in the buffer.
>> + * @wr_offset    : Offset of the write pointer in the buffer.
>> + * @status    : Status of SMB buffer.
>> + */
>> +struct smb_data_buffer {
>> +    void __iomem *buf_base;
>> +    u32 start_addr;
>> +    unsigned long buf_size;
>> +    unsigned long data_size;
>> +    unsigned long rd_offset;
>> +    unsigned long wr_offset;
>> +    bool full;
>> +};
>> +
>> +/**
>> + * struct smb_drv_data - specifics associated to an SMB component
>> + * @base:    Memory mapped base address for SMB component.
>> + * @csdev:    Component vitals needed by the framework.
>> + * @sdb:    Data buffer for SMB.
>> + * @miscdev:    Specifics to handle "/dev/xyz.smb" entry.
>> + * @spinlock:    Only one at a time pls.
>> + * @reading:    Synchronise user space access to SMB buffer.
>> + * @pid:    Process ID of the process being monitored by the session
>> + *        that is using this component.
> 
> Same as above.
> 
>> + * @mode:    how this SMB is being used, perf mode or sysfs mode.
>> + */
>> +struct smb_drv_data {
>> +    void __iomem *base;
>> +    struct coresight_device    *csdev;
>> +    struct smb_data_buffer sdb;
>> +    struct miscdevice miscdev;
>> +    spinlock_t spinlock;
>> +    local_t reading;
>> +    pid_t pid;
>> +    u32 mode;
>> +};
>> +
>> +#define smb_reg(name, offset)  coresight_simple_reg32(struct 
>> smb_drv_data, name, offset)
>> +
>> +#endif
> 
> Suzuki
> .
