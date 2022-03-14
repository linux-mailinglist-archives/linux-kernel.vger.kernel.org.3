Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8074D7F65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiCNKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiCNKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:05:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245E1F602
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:04:17 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KHBpJ0ZPkz1GCRY;
        Mon, 14 Mar 2022 17:59:20 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 18:04:15 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 18:04:14 +0800
Subject: Re: [PATCH v4] drivers/coresight: Add Ultrasoc System Memory Buffer
 driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
References: <20220128061755.31909-1-liuqi115@huawei.com>
 <da88a7eb-00e6-0a87-5fbf-99d5c72f28a9@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <dce4a668-34e4-97aa-bfaf-4a777eb1e073@huawei.com>
Date:   Mon, 14 Mar 2022 18:04:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <da88a7eb-00e6-0a87-5fbf-99d5c72f28a9@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/10 6:49, Suzuki K Poulose wrote:
> Hi
> 
> On 28/01/2022 06:17, Qi Liu wrote:
>> This patch adds driver for Ultrasoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these CPU instructions in system memory.
>>
>> SMB is developed by Ultrasoc technology, which is acquired by
>> Siemens, and we still use "Ultrasoc" to name driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Tested-by: JunHao He <hejunhao2@hisilicon.com>
> 
> Please find my comments below. In general :
> 
> 1) Please run checkpatch and fix the warnings
> 2) Add documentation for :
>       - A brief description of the device and the firmware bindings (see 
> comments below )
>       - Sysfs attributes
> 3) Other minor comments on the code
> 
Hi Suzuki,

thanks a lot for your review! and some replies inline.
>> ---
[...]
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called coresight-trbe.
>> +config ULTRASOC_SMB
>> +    tristate "Ultrasoc system memory buffer drivers"
>> +    depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
> 
> Given that this driver absolutely only works with ACPI, please could
> you add that dependency here ?

yes, I'll add this, thanks.
> 
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
>> index 000000000000..a18d061aab61
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -0,0 +1,602 @@
>> +// SPDX-License-Identifier: MIT/GPL
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2022, HiSilicon Limited.
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
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "smb");
> 
> minor nit: This name could be confused with SMB (samba) under linux
> especially when it appears under /dev/smbN as a misc device.
> 
got it, I'll rename this device. How about /dev/ultra_smbN?
>> +
>> +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
>> +{
>> +    u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
>> +
>> +    return buf_status & BIT(0) ? false : true;
>> +}
>> +

[...]

>> +
>> +static ssize_t smb_read(struct file *file, char __user *data, size_t 
>> len, loff_t *ppos)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                            struct smb_drv_data, miscdev);
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    struct device *dev = &drvdata->csdev->dev;
>> +    unsigned long flags;
>> +    int to_copy = 0;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (!sdb->data_size) {
>> +        smb_update_data_size(drvdata);
>> +        if (!sdb->data_size)
>> +            goto out;
>> +    }
>> +
>> +    if (atomic_read(drvdata->csdev->refcnt)) {
>> +        to_copy = -EBUSY;
>> +        goto out;
>> +    }
>> +
> 
> Shouldn't this be performed *before* updating the data_size above ?
> Looking at the smb_update_data_size() it "purges" the data. Is that
> acceptable ?

ah, yes, we should get this before updating the data_size. I'll fix 
this, thanks.
> 
>> +    to_copy = min(sdb->data_size, len);
>> +
>> +    /* Copy parts of trace data when the read pointer will wrap 
>> around SMB buffer. */
>> +    if (sdb->rd_offset + to_copy > sdb->buf_size)

[...]
>> +static struct attribute *smb_sink_attrs[] = {
>> +    &dev_attr_read_pos.attr,
>> +    &dev_attr_write_pos.attr,
>> +    &dev_attr_buf_status.attr,
>> +    &dev_attr_buf_size.attr,
>> +    NULL,
>> +};
> 
> Please could you also update the sysfs ABI files with a brief
> description of the above attributes ?
> 
> e.g., Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> 
yes, sure. I'll do this.

>> +
>> +static const struct attribute_group smb_sink_group = {
>> +    .attrs = smb_sink_attrs,
>> +    .name = "status",
>> +};
>> +
[...]
>> +
>> +static int smb_enable_perf(struct smb_drv_data *drvdata, void *data)
>> +{
>> +    struct device *dev = &drvdata->csdev->dev;
>> +    struct perf_output_handle *handle = data;
>> +    pid_t pid;
>> +
>> +    if (drvdata->mode == CS_MODE_SYSFS) {
>> +        dev_err(dev, "Device is already in used by sysfs\n");
> 
> Please could you convert this to dev_dbg() ? An -EBUSY should
> be sufficient to indicate that the resource is busy.
> 
got it, thanks, will fix this.

>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Get a handle on the pid of the target process*/
>> +    pid = task_pid_nr(handle->event->owner);
>> +    if (drvdata->pid != -1 && drvdata->pid != pid) {
>> +        dev_err(dev, "Device is already in used by other session\n");
> 
> Same here.
> 
ok.
>> +        return -EBUSY;
>> +    }
>> +    /* The sink is already enabled by this session. */
>> +    if (drvdata->pid == pid)
>> +        return 0;
> 
> If the sink is shared by multiple events of the same group, don't
> we need a refcount to make sure we don't disable the buffer when
> an event goes away ?
> 

we increase this refcount in smb_enable(), if smb_enable_sysfs() or 
smb_enable_perf() is enabled successfully, we increase the refcount.

So, when the sink is shared by multiple events of the same group, 
refcount will be increased too. thanks.
>> +
>> +    if (smb_set_perf_buffer(handle))
>> +        return -EINVAL;
>> +
>> +    smb_enable_hw(drvdata);
>> +    drvdata->pid = pid;
>> +    drvdata->mode = CS_MODE_PERF;
>> +
>> +    return 0;
>> +}
>> +
>> +static int smb_enable(struct coresight_device *csdev, u32 mode, void 
>> *data)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    unsigned long flags;
>> +    int ret = -EINVAL;
>> +
>> +    /* Do nothing if trace data is reading by other interface now. */
>> +    if (local_read(&drvdata->reading))
>> +        return -EBUSY;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (mode == CS_MODE_SYSFS)
>> +        ret = smb_enable_sysfs(drvdata);
>> +
>> +    if (mode == CS_MODE_PERF)
>> +        ret = smb_enable_perf(drvdata, data);
>> +
>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    atomic_inc(csdev->refcnt);
>> +    dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static int smb_disable(struct coresight_device *csdev)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +    if (atomic_dec_return(csdev->refcnt)) {
> 
> We need to increment the refcnt for every event that shares the
> sink for perf mode. Please see my comments above.
> 
>> +        spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +        return -EBUSY;
>> +    }
>> +
>> +    WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
>> +    smb_disable_hw(drvdata);
>> +
>> +    /*
>> +     * Data remaining in hardware path will be sent to SMB after 
>> purge, so needs to
>> +     * synchronize the read pointer to write pointer in perf mode.
> 
> Please run checkpatch on your submission ^^^
> 
> 
this comment is more than 80 word but less than 120 word, so there's no 
checkpatch warning~ I'll modify it to 80 words per line next version :)
>> +     */
>> +    smb_purge_data(drvdata);
>> +    if (drvdata->mode == CS_MODE_PERF)
>> +        writel(readl(drvdata->base + SMB_LB_WR_ADDR), drvdata->base + 
>> SMB_LB_RD_ADDR);
> 
> Same here. Why don't we do this for CS_MODE_SYSFS ?
> 

when SMB is disabled, we need to do purge, in case data remaining in 
hardware path influence next trace.
when we use sysfs interface, smb_disable() is called before smb_read(), 
so the purged data will be dumped to userspace together.
But when using perf interface, smb_disable() is called after 
smb_update_buffer(), so we need to synchronize the read pointer to write 
pointer, to make sure these data won't influence next trace. Thanks.
>> +
>> +    /* Dissociate from the target process. */
>> +    drvdata->pid = -1;
>> +    drvdata->mode = CS_MODE_DISABLED;
>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +    dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
>> +    return 0;
>> +}
>> +
[...]
>> +
>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>> +                 struct cs_buffers *buf, unsigned long data_size)
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    char **dst_pages = (char **)buf->data_pages;
>> +    unsigned long buf_offset = buf->offset;
> 
> Please could you rename this to page_offset ?
> 
yes, sure.
>> +    unsigned int cur = buf->cur;
>> +    unsigned long to_copy;
>> +
> 
>> +    while (data_size) {
>> +        /* Copy parts of trace data when the read pointer will wrap 
>> around SMB buffer. */
> 
> Wrap the lines please.
> 
> Please could you do :
> 
>          unsigned long page_space = (PAGE_SIZE - page_offset);
> 
> 
>> +        if (sdb->rd_offset + PAGE_SIZE - buf_offset > sdb->buf_size)
> 
> ^^        if (sdb->rd_offset + page_space > sdb->buf_size)
> 
>> +            to_copy = sdb->buf_size - sdb->rd_offset;
>> +        else
>> +            to_copy = min(data_size, PAGE_SIZE - buf_offset);
> 
>              to_copy = min(data_size, page_space);
> 
>> +
>> +        memcpy_fromio(dst_pages[cur] + buf_offset, sdb->buf_base + 
>> sdb->rd_offset, to_copy);
> 
>          memcpy_fromio(dst_pages[cur] + page_offset, ...
> 
>> +
>> +        buf_offset += to_copy;
>> +        if (buf_offset >= PAGE_SIZE) {
> 
> That becomes much simpler to follow with the rename to page_offset.
> 

sure, I'll do this next time. thanks.
>> +            buf_offset = 0;
>> +            cur++;
>> +            cur %= buf->nr_pages;
>> +        }
>> +        data_size -= to_copy;
>> +        /* ensure memcpy finished before update the read pointer */
> 
> Why and how ?
> 
this comment is used to express we do memcpy first, then update read 
pointer. Seems it's misleading, I'll delete it next time, thanks.
>> +        sdb->rd_offset += to_copy;
>> +        sdb->rd_offset %= sdb->buf_size;
>> +    }
>> +
>> +    sdb->data_size = 0;
>> +    writel(sdb->start_addr + sdb->rd_offset, drvdata->base + 
>> SMB_LB_RD_ADDR);
>> +    smb_reset_buffer_status(drvdata);
>> +}
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
>> +    data_size = sdb->data_size;
> 
> Please could you add in a comment on what we do here below ?
got it, will add this, thanks.
> 
>> +    if (data_size > handle->size)  > +        sdb->rd_offset += 
>> data_size - handle->size;
>> +        sdb->rd_offset %= sdb->buf_size;
>> +        data_size = handle->size;
>> +        lost = true;
>> +    }
>> +
>> +    smb_sync_perf_buffer(drvdata, buf, data_size);
>> +    if (!buf->snapshot && lost)
>> +        perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +
>> +out:
>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +    return data_size;
>> +}
>> +
>> +static const struct coresight_ops_sink smb_cs_ops = {
>> +    .enable        = smb_enable,
>> +    .disable    = smb_disable,
>> +    .alloc_buffer    = smb_alloc_buffer,
>> +    .free_buffer    = smb_free_buffer,
>> +    .update_buffer    = smb_update_buffer,
>> +};
>> +
>> +static const struct coresight_ops cs_ops = {
>> +    .sink_ops    = &smb_cs_ops,
>> +};
>> +
>> +static int smb_init_data_buffer(struct platform_device *pdev, struct 
>> smb_data_buffer *sdb)
>> +{
>> +    struct resource *res;
>> +    void __iomem *base;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> 
> What are these IO bases ? What does 0 stand for ? What is 1 for ?
> 
> Please could you add a documentation under
> 
> Documentation/trace/coresight/.
> 
> Doesn't need to be too detailed. But a basic description would be helpful.
> 
yes, I'll add this, thanks.
> 
>> +    if (IS_ERR(res)) {
>> +        dev_err(&pdev->dev, "SMB device failed to get resource\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    sdb->start_addr = res->start & SMB_BASE_LOW_MASK;
>> +    sdb->buf_size = resource_size(res);
>> +    if (sdb->buf_size == 0)
>> +        return -EINVAL;
>> +
>> +    base = devm_ioremap_resource(&pdev->dev, res);
>> +    if (IS_ERR(base))
>> +        return PTR_ERR(base);
>> +
>> +    sdb->buf_base = base;
>> +
>> +    return 0;
>> +}
>> +
>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>> +{
>> +    u32 value;
>> +
>> +    /* First disable smb and clear the status of SMB buffer */
>> +    smb_reset_buffer_status(drvdata);
>> +    smb_disable_hw(drvdata);
>> +    smb_purge_data(drvdata);
>> +
>> +    /* Using smb in single-end mode, and set other configures default */
>> +    value = SMB_BUF_CFG_STREAMING | SMB_BUF_SINGLE_END | SMB_BUF_EN;
>> +    writel(value, drvdata->base + SMB_LB_CFG_LO);
>> +    value = SMB_MSG_FILTER(0x0, 0xff);
> 
> Could we not simply say :
> 
> 
>> +    writel(value, drvdata->base + SMB_LB_CFG_HI);
>> +
> 
>      #define SMB_CFG_MSG_FILTER    0xff00
> 
>      writel(SMB_CFG_MSG_FILTER, drvdata->base + SMB_LB_CFG_HI) ?
> 
> 
> Just like you do below for the other registers ? Anyways, none of these
> values make any sense to the reader without the Reference Manual. The
> best you could do is stick a sensible name for the value like you do
> below.
> 
yes, I'll do this, thanks.

>> +    writel(SMB_GLOBAL_CFG, drvdata->base + SMB_CFG_REG);
>> +    writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
>> +    writel(SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
>> +}
[...]
>> +
>> +static void smb_unregister_sink(struct smb_drv_data *drvdata)
>> +{
>> +    misc_deregister(&drvdata->miscdev);
>> +    coresight_unregister(drvdata->csdev);
>> +}
>> +
>> +/*
>> + * Send ultrasoc messge to control hardwares on the tracing path,
>> + * using DSM calls to avoid exposing ultrasoc message format.
>> + */
>> +static int smb_config_inport(struct device *dev, bool enable)
>> +{
>> +    u32 flag = enable ? 1 : 0;
>> +    union acpi_object *obj;
>> +    guid_t guid;
>> +
>> +    if (guid_parse("82ae1283-7f6a-4cbe-aa06-53e8fb24db18", &guid)) {
> 
> Please could you add symbolic name for this UUID string and a comment on
> what this will do ?
> 
sure, I'll fix this, thanks.
>> +        dev_err(dev, "Get GUID failed\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, 0, flag, NULL);
> 
> What are the parameters ? What do they mean ?
> 
We need to initialize the register before tracing, but the vendor does 
not want us to expose these initialize information, so we add these set 
function in ACPI and use a ACPI handler to call this function. Thanks.

>> +    if (!obj)
>> +        dev_err(dev, "ACPI handle failed\n");
>> +    else
>> +        ACPI_FREE(obj);
>> +
>> +    return 0;
>> +}
>> +
[...]
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +    {"HISI03A1", 0},
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
>> +#endif
> 
> As mentioned above this driver must depend on the ACPI and thus
> you may remove the #ifdef

got it, thanks
> 
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
>> +MODULE_DESCRIPTION("Ultrasoc smb driver");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h 
>> b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> new file mode 100644
>> index 000000000000..a7c76140ee46
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2022, HiSilicon Limited.
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
>> +#define SMB_CFG_REG            0X0
>> +#define SMB_GLOBAL_EN            0X4
>> +#define SMB_GLOBAL_INT            0X8
>> +#define SMB_LB_CFG_LO            0X40
>> +#define SMB_LB_CFG_HI            0X44
>> +#define SMB_LB_INT_CTRL            0X48
>> +#define SMB_LB_INT_STS            0X4C
>> +#define SMB_LB_LIMIT            0X58
>> +#define SMB_LB_RD_ADDR            0X5C
>> +#define SMB_LB_WR_ADDR            0X60
>> +#define SMB_LB_PURGE            0X64
>> +
>> +/* Set SMB_CFG_REG register */
>> +#define SMB_IDLE_PRD(period)        ((((period) - 216) & 0xf) << 12)
>> +#define SMB_MEM_WR(credit, rate)    (((credit) << 16) | ((rate) << 18))
>> +#define SMB_MEM_RD(credit, rate)    (((credit) << 22) | ((rate) << 24))
>> +#define SMB_BURST_LEN(len)        (((len) - 1) << 4)
>> +#define SMB_GLOBAL_CFG            (SMB_IDLE_PRD(231) | 
>> SMB_MEM_WR(0x3, 0x0) |   \
>> +                     SMB_MEM_RD(0x3, 0x6) | SMB_BURST_LEN(16))
>> +
>> +/* Set SMB_GLOBAL_INT register */
>> +#define SMB_INT_EN            BIT(0)
>> +#define SMB_INT_TYPE_PULSE        BIT(1)
>> +#define SMB_INT_POLARITY_HIGH        BIT(2)
>> +#define SMB_GLB_INT_CFG            (SMB_INT_EN | SMB_INT_TYPE_PULSE | 
>> SMB_INT_POLARITY_HIGH)
>> +
>> +/* Set SMB_LB_CFG_LO register */
>> +#define SMB_BUF_EN            BIT(0)
>> +#define SMB_BUF_SINGLE_END        BIT(1)
>> +#define SMB_BUF_INIT            BIT(8)
>> +#define SMB_BUF_CONTINUOUS        BIT(11)
>> +#define SMB_FLOW_MASK            GENMASK(19, 16)
>> +#define SMB_BUF_CFG_STREAMING        (SMB_BUF_INIT | 
>> SMB_BUF_CONTINUOUS | SMB_FLOW_MASK)
>> +#define SMB_BASE_LOW_MASK        GENMASK(31, 0)
>> +
>> +/* Set SMB_LB_CFG_HI register */
>> +#define SMB_MSG_FILTER(lower, upper)    (((lower) & 0xff) | (((upper) 
>> & 0xff) << 8))
> 
> There is only one place where this is used and it is unnecessarily
> confusing. Why not simply define:
> 
> #define SMB_CFG_MSG_FILTER        0xff00
> 
> 

got it, I'll do this.

thanks a lot.
Qi
>> +#define SMB_BUF_INT_EN            BIT(0)
>> +#define SMB_BUF_NOTE_MASK        GENMASK(11, 8)
>> +#define SMB_BUF_INT_CFG            (SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
>> +
>> +/**
>> + * struct smb_data_buffer - Details of the buffer used by SMB
>> + * @buf_base    : Memory mapped base address of SMB.
>> + * @start_addr    : SMB buffer start Physical address.
>> + * @buf_size    : Size of the buffer.
>> + * @data_size    : Size of Trace data copy to userspace.
>> + * @rd_offset    : Offset of the read pointer in the buffer.
>> + */
>> +struct smb_data_buffer {
>> +    void __iomem *buf_base;
>> +    u32 start_addr;
>> +    unsigned long buf_size;
>> +    unsigned long data_size;
>> +    unsigned long rd_offset;
>> +};
>> +
>> +/**
>> + * struct smb_drv_data - specifics associated to an SMB component
>> + * @base    : Memory mapped base address for SMB component.
>> + * @csdev    : Component vitals needed by the framework.
>> + * @sdb        : Data buffer for SMB.
>> + * @miscdev    : Specifics to handle "/dev/smb" entry.
>> + * @spinlock    : Only one at a time pls.
>> + * @reading    : Synchronise user space access to SMB buffer.
>> + * @pid        : Process ID of the process being monitored by the 
>> session
>> + *        that is using this component.
>> + * @mode    : how this SMB is being used, perf mode or sysfs mode.
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
