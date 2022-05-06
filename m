Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9351CDD7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387563AbiEFAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387520AbiEFAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:30:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6C415832
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:26:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3343D14BF;
        Thu,  5 May 2022 17:26:31 -0700 (PDT)
Received: from [10.57.0.148] (unknown [10.57.0.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812DC3FA31;
        Thu,  5 May 2022 17:26:29 -0700 (PDT)
Message-ID: <91a6f78d-1d8c-4b5b-3fc3-0c8866b184ad@arm.com>
Date:   Fri, 6 May 2022 01:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Jonathan_Lucas@mentor.com
References: <20220416083953.52610-1-liuqi115@huawei.com>
 <20220416083953.52610-2-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220416083953.52610-2-liuqi115@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi Liu

Apologies for the delay. I have some more comments below.

On 16/04/2022 09:39, Qi Liu wrote:
> This patch adds driver for UltraSoc SMB(System Memory Buffer)
> device. SMB provides a way to buffer messages from ETM, and
> store these CPU instructions in system memory.
> 
> SMB is developed by UltraSoc technology, which is acquired by
> Siemens, and we still use "UltraSoc" to name driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Tested-by: JunHao He <hejunhao2@hisilicon.com>
> ---
>   drivers/hwtracing/coresight/Kconfig        |  10 +
>   drivers/hwtracing/coresight/Makefile       |   1 +
>   drivers/hwtracing/coresight/ultrasoc-smb.c | 643 +++++++++++++++++++++
>   drivers/hwtracing/coresight/ultrasoc-smb.h | 106 ++++
>   4 files changed, 760 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 514a9b8086e3..4380eb1a0a73 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-trbe.
> +config ULTRASOC_SMB
> +	tristate "Ultrasoc system memory buffer drivers"
> +	depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
> +	help
> +	  This driver provides support for the Ultrasoc system memory buffer (SMB).
> +	  SMB is responsible for receiving the trace data from Coresight ETM devices
> +	  and storing them to a system buffer.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ultrasoc-smb.
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index b6c4a48140ec..344dba8d6ff8 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> new file mode 100644
> index 000000000000..9a93b7fc7bda
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: MIT/GPL
> +/*
> + * Siemens System Memory Buffer driver.
> + * Copyright(c) 2021, HiSilicon Limited.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/circ_buf.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +
> +#include "ultrasoc-smb.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "ultra_smb");
> +
> +#define ULTRASOC_SMB_DSM_UUID	"82ae1283-7f6a-4cbe-aa06-53e8fb24db18"
> +
> +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
> +{
> +	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
> +
> +	return buf_status & BIT(0) ? false : true;
> +}
> +
> +static bool smb_buffer_cmp_pointer(struct smb_drv_data *drvdata)
> +{
> +	u32 wr_offset, rd_offset;
> +
> +	wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR);
> +	rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR);
> +	return wr_offset == rd_offset;
> +}
> +
> +static void smb_reset_buffer_status(struct smb_drv_data *drvdata)
> +{
> +	writel(0xf, drvdata->base + SMB_LB_INT_STS);
> +}
> +
> +/* Purge data remaining in hardware path in case them influence next trace */
> +static void smb_purge_data(struct smb_drv_data *drvdata)
> +{
> +	writel(0x1, drvdata->base + SMB_LB_PURGE);
> +}
> +
> +static void smb_update_data_size(struct smb_drv_data *drvdata)
> +{
> +	struct smb_data_buffer *sdb = &drvdata->sdb;
> +	u32 write_offset;
> +
> +	smb_purge_data(drvdata);
> +	if (smb_buffer_cmp_pointer(drvdata)) {
> +		if (smb_buffer_is_empty(drvdata))
> +			sdb->data_size = 0;
> +		else
> +			sdb->data_size = sdb->buf_size;

What happens when the buffer is full ? Does the sink stop writing ?
Or does it keep on overwriting in a circular buffer mode ?
If it does keep overwriting, we would need to make sure to update the
sdb->rd_offset so that we provide the latest data (in smb_read())?
If it doesn't overwrite, I think this logic could be simpler (similar
to the tmc-et* circular buffer mode calculation.


> +		return;
> +	}
> +
> +	write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - sdb->start_addr;
> +	sdb->data_size = CIRC_CNT(write_offset, sdb->rd_offset, sdb->buf_size);
> +}
> +
> +static int smb_open(struct inode *inode, struct file *file)
> +{
> +	struct smb_drv_data *drvdata = container_of(file->private_data,
> +					struct smb_drv_data, miscdev);
> +
> +	if (local_cmpxchg(&drvdata->reading, 0, 1))

I believe this must be done in the smb_read(). Please see my comment
for smb_disable()

> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static ssize_t smb_read(struct file *file, char __user *data, size_t len,
> +			loff_t *ppos)
> +{
> +	struct smb_drv_data *drvdata = container_of(file->private_data,
> +						struct smb_drv_data, miscdev);
> +	struct smb_data_buffer *sdb = &drvdata->sdb;
> +	struct device *dev = &drvdata->csdev->dev;
> +	unsigned long flags;
> +	int to_copy = 0;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (atomic_read(drvdata->csdev->refcnt)) {
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return -EBUSY;
> +	}
> +
> +	if (!sdb->data_size) {
> +		smb_update_data_size(drvdata);
> +		if (!sdb->data_size)
> +			goto out;
> +	}
> +
> +	to_copy = min(sdb->data_size, len);
> +
> +	/* Copy parts of trace data when read pointer wrap around SMB buffer */
> +	if (sdb->rd_offset + to_copy > sdb->buf_size)
> +		to_copy = sdb->buf_size - sdb->rd_offset;
> +
> +	if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset,
> +			 to_copy)) {
> +		dev_dbg(dev, "Failed to copy data to user.\n");
> +		to_copy = -EFAULT;
> +		goto out;
> +	}
> +
> +	*ppos += to_copy;
> +	sdb->data_size -= to_copy;
> +	sdb->rd_offset += to_copy;
> +	sdb->rd_offset %= sdb->buf_size;
> +	writel(sdb->start_addr + sdb->rd_offset,
> +	       drvdata->base + SMB_LB_RD_ADDR);
> +	dev_dbg(dev, "%d bytes copied.\n", to_copy);
> +out:
> +	if (!sdb->data_size)
> +		smb_reset_buffer_status(drvdata);
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return to_copy;
> +}
> +
> +static int smb_release(struct inode *inode, struct file *file)
> +{
> +	struct smb_drv_data *drvdata = container_of(file->private_data,
> +						struct smb_drv_data, miscdev);
> +	local_set(&drvdata->reading, 0);
> +	return 0;
> +}
> +
> +static const struct file_operations smb_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= smb_open,
> +	.read		= smb_read,
> +	.release	= smb_release,
> +	.llseek		= no_llseek,
> +};
> +
> +smb_reg(read_pos, SMB_LB_RD_ADDR);
> +smb_reg(write_pos, SMB_LB_WR_ADDR);
> +smb_reg(buf_status, SMB_LB_INT_STS);
> +
> +static ssize_t buf_size_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "0x%lx\n", drvdata->sdb.buf_size);
> +}
> +static DEVICE_ATTR_RO(buf_size);
> +
> +static struct attribute *smb_sink_attrs[] = {
> +	&dev_attr_read_pos.attr,
> +	&dev_attr_write_pos.attr,
> +	&dev_attr_buf_status.attr,
> +	&dev_attr_buf_size.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group smb_sink_group = {
> +	.attrs = smb_sink_attrs,
> +	.name = "mgmt",
> +};
> +
> +static const struct attribute_group *smb_sink_groups[] = {
> +	&smb_sink_group,
> +	NULL,
> +};
> +
> +static int smb_set_perf_buffer(struct perf_output_handle *handle)
> +{
> +	struct cs_buffers *buf = etm_perf_sink_config(handle);
> +	u32 head;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	/* Wrap head around to the amount of space we have */
> +	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
> +
> +	/* Find the page to write to and offset within that page */
> +	buf->cur = head / PAGE_SIZE;
> +	buf->offset = head % PAGE_SIZE;
> +
> +	local_set(&buf->data_size, 0);
> +
> +	return 0;
> +}
> +
> +static void smb_enable_hw(struct smb_drv_data *drvdata)
> +{
> +	writel(0x1, drvdata->base + SMB_GLOBAL_EN);
> +}
> +
> +static void smb_disable_hw(struct smb_drv_data *drvdata)
> +{
> +	writel(0x0, drvdata->base + SMB_GLOBAL_EN);
> +}
> +
> +static int smb_enable_sysfs(struct coresight_device *csdev)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (drvdata->mode == CS_MODE_PERF) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (drvdata->mode == CS_MODE_DISABLED) {
> +		smb_enable_hw(drvdata);
> +		drvdata->mode = CS_MODE_SYSFS;
> +	}
> +
> +	atomic_inc(csdev->refcnt);
> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return ret;
> +}
> +
> +static int smb_enable_perf(struct coresight_device *csdev, void *data)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *dev = &drvdata->csdev->dev;
> +	struct perf_output_handle *handle = data;
> +	struct cs_buffers *buf = etm_perf_sink_config(handle);
> +	unsigned long flags;
> +	int ret = 0;
> +	pid_t pid;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (drvdata->mode == CS_MODE_SYSFS) {
> +		dev_dbg(dev, "Device is already in used by sysfs.\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* Get a handle on the pid of the target process */
> +	pid = buf->pid;
> +	if (drvdata->pid != -1 && drvdata->pid != pid) { > +		dev_dbg(dev, "Device is already in used by other session.\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* The sink is already enabled by this session */
> +	if (drvdata->pid == pid) {
> +		atomic_inc(csdev->refcnt);
> +		goto out;
> +	}
> +
> +	ret = smb_set_perf_buffer(handle);
> +	if (ret)
> +		goto out;
> +
> +	smb_enable_hw(drvdata);
> +	drvdata->pid = pid;
> +	drvdata->mode = CS_MODE_PERF;
> +	atomic_inc(csdev->refcnt);
> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return ret;
> +}
> +
> +static int smb_enable(struct coresight_device *csdev, u32 mode, void *data)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int ret;
> +
> +	/* Do nothing if trace data is reading by other interface now */
> +	if (local_read(&drvdata->reading))
> +		return -EBUSY;
> + > +	switch (mode) {
> +	case CS_MODE_SYSFS:
> +		ret = smb_enable_sysfs(csdev);
> +		break;
> +	case CS_MODE_PERF:
> +		ret = smb_enable_perf(csdev, data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;
> +	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled.\n");
> +
> +	return 0;
> +}
> +
> +static int smb_disable(struct coresight_device *csdev)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (local_read(&drvdata->reading)) {
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return -EBUSY;
> +	}
> +

This is a bit confusing. So, we don't allow "read" when a session
is in progress (via refcnt check in smb_read()). But the flag,
drvdata->reading is set as soon as we open(). And we fail the disable
if the drvdata->reading is set. I guess, we should move the setting
of the drvdata->reading to smb_read() and set it for the first case
where we are able to read.
Otherwise we could see, something like:

CPU0: smb_enable() 		# success, SMB is on
CPU1: open(/dev/usmb0) # -> set drvdata->reading
..
CPU0: smb_disable() # returns EBUSY since drvdata->reading is on.
CPU1: read(fd)      # returns EBUSY since there is a refcnt.



> +	if (atomic_dec_return(csdev->refcnt)) {
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return -EBUSY;
> +	}
> +
> +	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
> +	smb_disable_hw(drvdata);
> +	smb_purge_data(drvdata);
> +
> +	/*
> +	 * In perf mode, sink->disable is called after sink->update_buffer, so
> +	 * need to synchronize the read pointer to write pointer, to make sure
> +	 * these purged data won't influence next trace.
> +	 */
> +	if (drvdata->mode == CS_MODE_PERF)
> +		writel(readl(drvdata->base + SMB_LB_WR_ADDR),
> +		       drvdata->base + SMB_LB_RD_ADDR);
> +
> +	/* Dissociate from the target process. */
> +	drvdata->pid = -1;
> +	drvdata->mode = CS_MODE_DISABLED;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled.\n");
> +	return 0;
> +}
> +
> +static void *smb_alloc_buffer(struct coresight_device *csdev,
> +			      struct perf_event *event, void **pages,
> +			      int nr_pages, bool overwrite)
> +{
> +	struct cs_buffers *buf;
> +	int node;
> +
> +	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
> +	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->snapshot = overwrite;
> +	buf->nr_pages = nr_pages;
> +	buf->data_pages = pages;
> +	buf->pid = task_pid_nr(event->owner);
> +
> +	return buf;
> +}
> +
> +static void smb_free_buffer(void *config)
> +{
> +	struct cs_buffers *buf = config;
> +
> +	kfree(buf);
> +}
> +
> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
> +				 struct cs_buffers *buf,
> +				 unsigned long data_size)
> +{
> +	struct smb_data_buffer *sdb = &drvdata->sdb;
> +	char **dst_pages = (char **)buf->data_pages;
> +	unsigned long page_offset = buf->offset;
> +	unsigned int cur = buf->cur;
> +	unsigned long to_copy;
> +
> +	while (data_size) {
> +		unsigned long page_space = PAGE_SIZE - page_offset;
> +
> +		/* Copy parts of trace data when read pointer wrap around */
> +		if (sdb->rd_offset + page_space > sdb->buf_size)
> +			to_copy = sdb->buf_size - sdb->rd_offset;
> +		else
> +			to_copy = min(data_size, page_space);
> +
> +		memcpy_fromio(dst_pages[cur] + page_offset,
> +			      sdb->buf_base + sdb->rd_offset, to_copy);
> +
> +		page_offset += to_copy;
> +		if (page_offset >= PAGE_SIZE) {
> +			page_offset = 0;
> +			cur++;
> +			cur %= buf->nr_pages;
> +		}
> +		data_size -= to_copy;
> +		sdb->rd_offset += to_copy;
> +		sdb->rd_offset %= sdb->buf_size;
> +	}
> +
> +	sdb->data_size = 0;
> +	writel(sdb->start_addr + sdb->rd_offset,
> +	       drvdata->base + SMB_LB_RD_ADDR);
> +	smb_reset_buffer_status(drvdata);
> +}
> +
> +static unsigned long smb_update_buffer(struct coresight_device *csdev,
> +				       struct perf_output_handle *handle,
> +				       void *sink_config)
> +{
> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct smb_data_buffer *sdb = &drvdata->sdb;
> +	struct cs_buffers *buf = sink_config;
> +	unsigned long data_size = 0;
> +	unsigned long flags;
> +	bool lost = false;
> +
> +	if (!buf)
> +		return 0;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	/* Don't do anything if another tracer is using this sink. */
> +	if (atomic_read(csdev->refcnt) != 1)
> +		goto out;
> +
> +	smb_update_data_size(drvdata);

Are we allowed to call this when the SMB is ON ? In perf mode, we call
the update_buffer() before disabling the "sink". So, care must be taken
to stop the SMB if needed to make sure the registers are read properly.


Rest looks fine to me.


Suzuki
