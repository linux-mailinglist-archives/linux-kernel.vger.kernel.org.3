Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2D4E6377
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350225AbiCXMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbiCXMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:39:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E4DC0F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:37:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB191D6E;
        Thu, 24 Mar 2022 05:37:33 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9573F73D;
        Thu, 24 Mar 2022 05:37:32 -0700 (PDT)
Message-ID: <5d1bc111-54f1-c603-e8f4-ef28cc7cef81@arm.com>
Date:   Thu, 24 Mar 2022 12:37:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] drivers/coresight: Add Ultrasoc System Memory Buffer
 driver
Content-Language: en-US
To:     "liuqi (BA)" <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <20220128061755.31909-1-liuqi115@huawei.com>
 <da88a7eb-00e6-0a87-5fbf-99d5c72f28a9@arm.com>
 <dce4a668-34e4-97aa-bfaf-4a777eb1e073@huawei.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <dce4a668-34e4-97aa-bfaf-4a777eb1e073@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 10:04, liuqi (BA) wrote:
> 
> 
> On 2022/3/10 6:49, Suzuki K Poulose wrote:
>> Hi
>>
>> On 28/01/2022 06:17, Qi Liu wrote:
>>> This patch adds driver for Ultrasoc SMB(System Memory Buffer)
>>> device. SMB provides a way to buffer messages from ETM, and
>>> store these CPU instructions in system memory.
>>>
>>> SMB is developed by Ultrasoc technology, which is acquired by
>>> Siemens, and we still use "Ultrasoc" to name driver.
>>>
>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>> Tested-by: JunHao He <hejunhao2@hisilicon.com>
>>
>> Please find my comments below. In general :
>>
>> 1) Please run checkpatch and fix the warnings
>> 2) Add documentation for :
>>       - A brief description of the device and the firmware bindings 
>> (see comments below )
>>       - Sysfs attributes
>> 3) Other minor comments on the code
>>
> Hi Suzuki,
> 
> thanks a lot for your review! and some replies inline.
>>> ---
> [...]
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>>>         To compile this driver as a module, choose M here: the module 
>>> will be
>>>         called coresight-trbe.
>>> +config ULTRASOC_SMB
>>> +    tristate "Ultrasoc system memory buffer drivers"
>>> +    depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
>>
>> Given that this driver absolutely only works with ACPI, please could
>> you add that dependency here ?
> 
> yes, I'll add this, thanks.
>>
>>> +    help
>>> +      This driver provides support for the Ultrasoc system memory 
>>> buffer (SMB).
>>> +      SMB is responsible for receiving the trace data from Coresight 
>>> ETM devices
>>> +      and storing them to a system buffer.
>>> +
>>> +      To compile this driver as a module, choose M here: the module 
>>> will be
>>> +      called ultrasoc-smb.
>>>   endif
>>> diff --git a/drivers/hwtracing/coresight/Makefile 
>>> b/drivers/hwtracing/coresight/Makefile
>>> index b6c4a48140ec..344dba8d6ff8 100644
>>> --- a/drivers/hwtracing/coresight/Makefile
>>> +++ b/drivers/hwtracing/coresight/Makefile
>>> @@ -27,3 +27,4 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>>   coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>>              coresight-cti-sysfs.o
>>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c 
>>> b/drivers/hwtracing/coresight/ultrasoc-smb.c
>>> new file mode 100644
>>> index 000000000000..a18d061aab61
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>>> @@ -0,0 +1,602 @@
>>> +// SPDX-License-Identifier: MIT/GPL
>>> +/*
>>> + * Siemens System Memory Buffer driver.
>>> + * Copyright(c) 2022, HiSilicon Limited.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/circ_buf.h>
>>> +#include <linux/err.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#include "ultrasoc-smb.h"
>>> +
>>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "smb");
>>
>> minor nit: This name could be confused with SMB (samba) under linux
>> especially when it appears under /dev/smbN as a misc device.
>>
> got it, I'll rename this device. How about /dev/ultra_smbN?
>>> +
>>> +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
>>> +{
>>> +    u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
>>> +
>>> +    return buf_status & BIT(0) ? false : true;
>>> +}
>>> +
> 
> [...]
> 
>>> +
>>> +static ssize_t smb_read(struct file *file, char __user *data, size_t 
>>> len, loff_t *ppos)
>>> +{
>>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>>> +                            struct smb_drv_data, miscdev);
>>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>>> +    struct device *dev = &drvdata->csdev->dev;
>>> +    unsigned long flags;
>>> +    int to_copy = 0;
>>> +
>>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>>> +
>>> +    if (!sdb->data_size) {
>>> +        smb_update_data_size(drvdata);
>>> +        if (!sdb->data_size)
>>> +            goto out;
>>> +    }
>>> +
>>> +    if (atomic_read(drvdata->csdev->refcnt)) {
>>> +        to_copy = -EBUSY;
>>> +        goto out;
>>> +    }
>>> +
>>
>> Shouldn't this be performed *before* updating the data_size above ?
>> Looking at the smb_update_data_size() it "purges" the data. Is that
>> acceptable ?
> 
> ah, yes, we should get this before updating the data_size. I'll fix 
> this, thanks.
>>
>>> +    to_copy = min(sdb->data_size, len);
>>> +
>>> +    /* Copy parts of trace data when the read pointer will wrap 
>>> around SMB buffer. */
>>> +    if (sdb->rd_offset + to_copy > sdb->buf_size)
> 
> [...]
>>> +static struct attribute *smb_sink_attrs[] = {
>>> +    &dev_attr_read_pos.attr,
>>> +    &dev_attr_write_pos.attr,
>>> +    &dev_attr_buf_status.attr,
>>> +    &dev_attr_buf_size.attr,
>>> +    NULL,
>>> +};
>>
>> Please could you also update the sysfs ABI files with a brief
>> description of the above attributes ?
>>
>> e.g., Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>
> yes, sure. I'll do this.
> 
>>> +
>>> +static const struct attribute_group smb_sink_group = {
>>> +    .attrs = smb_sink_attrs,
>>> +    .name = "status",
>>> +};
>>> +
> [...]
>>> +
>>> +static int smb_enable_perf(struct smb_drv_data *drvdata, void *data)
>>> +{
>>> +    struct device *dev = &drvdata->csdev->dev;
>>> +    struct perf_output_handle *handle = data;
>>> +    pid_t pid;
>>> +
>>> +    if (drvdata->mode == CS_MODE_SYSFS) {
>>> +        dev_err(dev, "Device is already in used by sysfs\n");
>>
>> Please could you convert this to dev_dbg() ? An -EBUSY should
>> be sufficient to indicate that the resource is busy.
>>
> got it, thanks, will fix this.
> 
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    /* Get a handle on the pid of the target process*/
>>> +    pid = task_pid_nr(handle->event->owner);
>>> +    if (drvdata->pid != -1 && drvdata->pid != pid) {
>>> +        dev_err(dev, "Device is already in used by other session\n");
>>
>> Same here.
>>
> ok.
>>> +        return -EBUSY;
>>> +    }
>>> +    /* The sink is already enabled by this session. */
>>> +    if (drvdata->pid == pid)
>>> +        return 0;
>>
>> If the sink is shared by multiple events of the same group, don't
>> we need a refcount to make sure we don't disable the buffer when
>> an event goes away ?
>>
> 
> we increase this refcount in smb_enable(), if smb_enable_sysfs() or 
> smb_enable_perf() is enabled successfully, we increase the refcount.
> 
> So, when the sink is shared by multiple events of the same group, 
> refcount will be increased too. thanks.

I don't think this the case, at least by looking at the code. You need
to increment the refcount when you find that *this* session is going
to share the sink.

>>> +
>>> +    if (smb_set_perf_buffer(handle))
>>> +        return -EINVAL;
>>> +
>>> +    smb_enable_hw(drvdata);
>>> +    drvdata->pid = pid;
>>> +    drvdata->mode = CS_MODE_PERF;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int smb_enable(struct coresight_device *csdev, u32 mode, void 
>>> *data)
>>> +{
>>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +    unsigned long flags;
>>> +    int ret = -EINVAL;
>>> +
>>> +    /* Do nothing if trace data is reading by other interface now. */
>>> +    if (local_read(&drvdata->reading))
>>> +        return -EBUSY;
>>> +
>>> +    spin_lock_irqsave(&drvdata->spinlock, flags);
>>> +
>>> +    if (mode == CS_MODE_SYSFS)
>>> +        ret = smb_enable_sysfs(drvdata);
>>> +
>>> +    if (mode == CS_MODE_PERF)
>>> +        ret = smb_enable_perf(drvdata, data);
>>> +
>>> +    spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    atomic_inc(csdev->refcnt);

Shouldn't this be done within the spinlock ? Othewise, we could have:


CPU0: smb_enable() {
CPU0:   spin_lock()
CPU0:   ...
CPU0:   spin_unlock()...
CPU0:   atomic_inc(refcnt) == 1;
CPU0: }
...

CPU0: smb_disable() { # Note CPU0 started to disable the session

CPU1: smb_enable() {
CPU1:   spin_lock()
CPU1:   ...
CPU1:   spin_unlock()...

CPU0:   spin_lock();

# Before the CPU1 increments the counter, CPU0 could see the recnt == 1
# and go ahead to disable the HW. Where this must have been 2.


CPU0:   if (!atomic_dec_return()) == 0
CPU0:           disable_hw();
CPU1:   atomic_inc(refcnt) == 1;
CPU0:   spin_unlock()
CPU1: }


Suzuki
