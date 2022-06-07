Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26553F83D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiFGIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiFGIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:33:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94B223BC4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:33:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95A2A143D;
        Tue,  7 Jun 2022 01:33:33 -0700 (PDT)
Received: from [10.57.83.83] (unknown [10.57.83.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398563F73B;
        Tue,  7 Jun 2022 01:33:32 -0700 (PDT)
Message-ID: <4c4af59c-0b71-c5a5-1d5c-80b2e89de4d9@arm.com>
Date:   Tue, 7 Jun 2022 09:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <20220606130223.57354-1-liuqi115@huawei.com>
 <20220606130223.57354-2-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220606130223.57354-2-liuqi115@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

On 06/06/2022 14:02, Qi Liu wrote:
> This patch adds driver for UltraSoc SMB(System Memory Buffer)
> device. SMB provides a way to buffer messages from ETM, and
> store these CPU instructions in system memory.

nit: "CPU instruction trace" in system memory.

> 
> SMB is developed by UltraSoc technology, which is acquired by
> Siemens, and we still use "UltraSoc" to name driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Tested-by: JunHao He <hejunhao2@hisilicon.com>
> ---
>   drivers/hwtracing/coresight/Kconfig        |  10 +
>   drivers/hwtracing/coresight/Makefile       |   1 +
>   drivers/hwtracing/coresight/ultrasoc-smb.c | 663 +++++++++++++++++++++
>   drivers/hwtracing/coresight/ultrasoc-smb.h | 110 ++++
>   4 files changed, 784 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 514a9b8086e3..4380eb1a0a73 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig

...

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
> index 000000000000..44b4bceb6f28
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c

...

> +static int smb_open(struct inode *inode, struct file *file)
> +{
> +	struct smb_drv_data *drvdata = container_of(file->private_data,
> +					struct smb_drv_data, miscdev);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (local_read(&drvdata->reading)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (drvdata->mode == CS_MODE_PERF) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return ret;
> +}
> +
> +static ssize_t smb_read(struct file *file, char __user *data, size_t len,
> +			loff_t *ppos)
> +{
> +	struct smb_drv_data *drvdata = container_of(file->private_data,
> +					struct smb_drv_data, miscdev);
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
> +	if (local_cmpxchg(&drvdata->reading, 0, 1)) {
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return -EBUSY;
> +	}
> +

Shouldn't this be done in smb_open() ? Otherwise, a subsequent read
will fail with EBUSY ?
i.e,
	fd = open(/dev/ultra_smb0, ..);

	# size of the SMB buffer = 1M,
	size = read(fd, buf, SZ_4K);
	/* Do something the buf */
	if (size >= 0)
		size = read(fd, buf, SZ_4K);

^^ This would fail, isn't it ?

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
> +					struct smb_drv_data, miscdev);
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

I believe these fields should be dropped and instead use the 
handle->head, to determine the page number and offset. See the
TMC-ETR driver for e.g.

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
> +	if (drvdata->pid != -1 && drvdata->pid != pid) {
> +		dev_dbg(dev, "Device is already in used by other session.\n");
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
> +

Is there global switch for all the inports ? Or is there a control for
individual inports to the SMB ? Do we need additional information here
to enable the corresponding port ?

> +	switch (mode) {
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
> +	if (atomic_dec_return(csdev->refcnt)) {
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return -EBUSY;
> +	}
> +
> +	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
> +	smb_disable_hw(drvdata);
> +	smb_purge_data(drvdata);
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

You may need to pass the aux_handle here, to determine the handle->head
and the size. See my comments above.

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
> +	writel(sdb->start_addr + sdb->rd_offset, drvdata->base + SMB_LB_RD_ADDR);
> +
> +	/*
> +	 * Data remained in link cannot be purged when SMB is full, so
> +	 * synchronize the read pointer to write pointer, to make sure
> +	 * these remained data won't influence next trace.
> +	 */
> +	if (sdb->full) {
> +		smb_purge_data(drvdata);
> +		writel(readl(drvdata->base + SMB_LB_WR_ADDR),
> +		       drvdata->base + SMB_LB_RD_ADDR);
> +	}
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
> +	smb_disable_hw(drvdata);
> +	smb_update_data_size(drvdata);
> +	data_size = sdb->data_size;
> +
> +	/*
> +	 * The SMB buffer may be bigger than the space available in the
> +	 * perf ring buffer (handle->size). If so advance the offset so
> +	 * that we get the latest trace data.
> +	 */
> +	if (data_size > handle->size) {
> +		sdb->rd_offset += data_size - handle->size;
> +		sdb->rd_offset %= sdb->buf_size;
> +		data_size = handle->size;
> +		lost = true;
> +	}
> +
> +	smb_sync_perf_buffer(drvdata, buf, data_size);
> +	if (!buf->snapshot && lost)
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +
> +	smb_enable_hw(drvdata);
> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return data_size;
> +}
> +
> +static const struct coresight_ops_sink smb_cs_ops = {
> +	.enable		= smb_enable,
> +	.disable	= smb_disable,
> +	.alloc_buffer	= smb_alloc_buffer,
> +	.free_buffer	= smb_free_buffer,
> +	.update_buffer	= smb_update_buffer,
> +};
> +
> +static const struct coresight_ops cs_ops = {
> +	.sink_ops	= &smb_cs_ops,
> +};
> +
> +static int smb_init_data_buffer(struct platform_device *pdev,
> +				struct smb_data_buffer *sdb)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (IS_ERR(res)) {
> +		dev_err(&pdev->dev, "SMB device failed to get resource.\n");
> +		return -EINVAL;
> +	}
> +
> +	sdb->start_addr = res->start & SMB_BASE_LOW_MASK;
> +	sdb->buf_size = resource_size(res);
> +	if (sdb->buf_size == 0)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	sdb->buf_base = base;
> +
> +	return 0;
> +}
> +
> +static void smb_init_hw(struct smb_drv_data *drvdata)
> +{
> +	/* First disable smb and clear the status of SMB buffer */
> +	smb_reset_buffer_status(drvdata);
> +	smb_disable_hw(drvdata);
> +	smb_purge_data(drvdata);
> +
> +	writel(SMB_BUF_CFG_STREAMING, drvdata->base + SMB_LB_CFG_LO);
> +	writel(SMB_MSG_FILTER, drvdata->base + SMB_LB_CFG_HI);
> +	writel(SMB_GLOBAL_CFG, drvdata->base + SMB_CFG_REG);
> +	writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
> +	writel(SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
> +}
> +
> +static int smb_register_sink(struct platform_device *pdev,
> +			     struct smb_drv_data *drvdata)
> +{
> +	struct coresight_platform_data *pdata = NULL;
> +	struct coresight_desc desc = { 0 };
> +	int ret;
> +
> +	pdata = coresight_get_platform_data(&pdev->dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +
> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> +	desc.ops = &cs_ops;
> +	desc.pdata = pdata;
> +	desc.dev = &pdev->dev;
> +	desc.groups = smb_sink_groups;
> +	desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);

Please fill in the csdev_access method for the device.
	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);

> +	if (!desc.name) {
> +		dev_err(&pdev->dev, "Failed to alloc coresight device name.");
> +		return -ENOMEM;
> +	}
> +
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev))
> +		return PTR_ERR(drvdata->csdev);
> +
> +	drvdata->miscdev.name = desc.name;
> +	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	drvdata->miscdev.fops = &smb_fops;
> +	ret = misc_register(&drvdata->miscdev);
> +	if (ret) {
> +		coresight_unregister(drvdata->csdev);
> +		dev_err(&pdev->dev, "Failed to register misc, ret=%d.\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static void smb_unregister_sink(struct smb_drv_data *drvdata)
> +{
> +	misc_deregister(&drvdata->miscdev);
> +	coresight_unregister(drvdata->csdev);
> +}
> +
> +static int smb_config_inport(struct device *dev, bool enable)
> +{
> +	u64 func = enable ? 1 : 0;
> +	union acpi_object *obj;
> +	guid_t guid;
> +	u64 rev = 0;
> +
> +	/*
> +	 * Using DSM calls to enable/disable ultrasoc hardwares on
> +	 * tracing path, to prevent ultrasoc packet format being exposed.
> +	 */
> +	if (guid_parse(ULTRASOC_SMB_DSM_UUID, &guid)) {
> +		dev_err(dev, "Get GUID failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, rev, func, NULL);
> +	if (!obj)
> +		dev_err(dev, "ACPI handle failed!\n");
> +	else
> +		ACPI_FREE(obj);
> +
> +	return 0;
> +}
> +
> +static int smb_probe(struct platform_device *pdev)
> +{
> +	struct smb_drv_data *drvdata;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(drvdata->base)) {
> +		dev_err(&pdev->dev, "Failed to ioremap resource.\n");
> +		return PTR_ERR(drvdata->base);
> +	}
> +
> +	ret = smb_init_data_buffer(pdev, &drvdata->sdb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to init buffer, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	smb_init_hw(drvdata);
> +	spin_lock_init(&drvdata->spinlock);
> +	drvdata->pid = -1;
> +
> +	ret = smb_register_sink(pdev, drvdata);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register smb sink.\n");
> +		return ret;
> +	}
> +
> +	ret = smb_config_inport(&pdev->dev, true);
> +	if (ret) {
> +		smb_unregister_sink(drvdata);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, drvdata);
> +	return 0;
> +}
> +
> +static int smb_remove(struct platform_device *pdev)
> +{
> +	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = smb_config_inport(&pdev->dev, false);
> +	if (ret)
> +		return ret;
> +
> +	smb_unregister_sink(drvdata);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
> +	{"HISI03A1", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
> +
> +static struct platform_driver smb_driver = {
> +	.driver = {
> +		.name = "ultrasoc-smb",
> +		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = smb_probe,
> +	.remove = smb_remove,
> +};
> +module_platform_driver(smb_driver);
> +
> +MODULE_DESCRIPTION("UltraSoc smb driver");

"UltraSoc SMB CoreSight driver"

> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");

> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
> new file mode 100644
> index 000000000000..a01f869fe122
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Siemens System Memory Buffer driver.
> + * Copyright(c) 2021, HiSilicon Limited.
> + */
> +
> +#ifndef _ULTRASOC_SMB_H
> +#define _ULTRASOC_SMB_H
> +
> +#include <linux/coresight.h>
> +#include <linux/list.h>
> +#include <linux/miscdevice.h>
> +
> +#include "coresight-etm-perf.h"
> +#include "coresight-priv.h"
> +
> +/* Offset of SMB logical buffer registers */
> +#define SMB_CFG_REG		0x00
> +#define SMB_GLOBAL_EN		0x04
> +#define SMB_GLOBAL_INT		0x08
> +#define SMB_LB_CFG_LO		0x40
> +#define SMB_LB_CFG_HI		0x44
> +#define SMB_LB_INT_CTRL		0x48
> +#define SMB_LB_INT_STS		0x4c
> +#define SMB_LB_LIMIT		0x58
> +#define SMB_LB_RD_ADDR		0x5c
> +#define SMB_LB_WR_ADDR		0x60
> +#define SMB_LB_PURGE		0x64
> +
> +/* Set SMB_CFG_REG register */
> +#define SMB_BURST_LEN		GENMASK(7, 4)
> +#define SMB_IDLE_PRD		GENMASK(15, 12)
> +#define SMB_MEM_WR		GENMASK(17, 16)
> +#define SMB_MEM_RD		(GENMASK(26, 25) | GENMASK(23, 22))
> +#define SMB_GLOBAL_CFG		(SMB_IDLE_PRD |	SMB_MEM_WR | SMB_MEM_RD | \
> +				 SMB_BURST_LEN)
> +
> +/* Set SMB_GLOBAL_INT register */
> +#define SMB_INT_EN		BIT(0)
> +#define SMB_INT_TYPE_PULSE	BIT(1)
> +#define SMB_INT_POLARITY_HIGH	BIT(2)
> +#define SMB_GLB_INT_CFG		(SMB_INT_EN | SMB_INT_TYPE_PULSE |	\
> +				 SMB_INT_POLARITY_HIGH)
> +
> +/* Set SMB_LB_CFG_LO register */
> +#define SMB_BUF_EN		BIT(0)
> +#define SMB_BUF_SINGLE_END	BIT(1)
> +#define SMB_BUF_INIT		BIT(8)
> +#define SMB_BUF_CONTINUOUS	BIT(11)
> +#define SMB_FLOW_MASK		GENMASK(19, 16)

What does the value GENMASK(19, 16) indicate for SMB_FLOW ? That is the
value being passed down. Please add a descriptive name.
.e.g,

#define SMB_FLOW_MODE_X		GENMASK(19, 16)

Similarly for SMB_BUF_NOTE_MASK, unless there is an explanation.

> +#define SMB_BUF_CFG_STREAMING	(SMB_BUF_INIT | SMB_BUF_CONTINUOUS |	\
> +				 SMB_FLOW_MASK | SMB_BUF_SINGLE_END |	\
> +				 SMB_BUF_EN)
> +
> +#define SMB_BASE_LOW_MASK	GENMASK(31, 0)
> +
> +/* Set SMB_LB_CFG_HI register */
> +#define SMB_MSG_FILTER		GENMASK(15, 8)
> +
> +/* Set SMB_LB_INT_CTRL */
> +#define SMB_BUF_INT_EN		BIT(0)
> +#define SMB_BUF_NOTE_MASK	GENMASK(11, 8)
> +#define SMB_BUF_INT_CFG		(SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
> +
> +/**
> + * struct smb_data_buffer - Details of the buffer used by SMB
> + * @buf_base	: Memory mapped base address of SMB.
> + * @start_addr	: SMB buffer start Physical address.
> + * @buf_size	: Size of the buffer.

Please align the field definitions.

> + * @data_size	: Size of Trace data copy to userspace.
> + * @rd_offset	: Offset of the read pointer in the buffer.
> + * @wr_offset	: Offset of the write pointer in the buffer.
> + * @status	: Status of SMB buffer.
> + */
> +struct smb_data_buffer {
> +	void __iomem *buf_base;
> +	u32 start_addr;
> +	unsigned long buf_size;
> +	unsigned long data_size;
> +	unsigned long rd_offset;
> +	unsigned long wr_offset;
> +	bool full;
> +};
> +
> +/**
> + * struct smb_drv_data - specifics associated to an SMB component
> + * @base:	Memory mapped base address for SMB component.
> + * @csdev:	Component vitals needed by the framework.
> + * @sdb:	Data buffer for SMB.
> + * @miscdev:	Specifics to handle "/dev/xyz.smb" entry.
> + * @spinlock:	Only one at a time pls.
> + * @reading:	Synchronise user space access to SMB buffer.
> + * @pid:	Process ID of the process being monitored by the session
> + *		that is using this component.

Same as above.

> + * @mode:	how this SMB is being used, perf mode or sysfs mode.
> + */
> +struct smb_drv_data {
> +	void __iomem *base;
> +	struct coresight_device	*csdev;
> +	struct smb_data_buffer sdb;
> +	struct miscdevice miscdev;
> +	spinlock_t spinlock;
> +	local_t reading;
> +	pid_t pid;
> +	u32 mode;
> +};
> +
> +#define smb_reg(name, offset)  coresight_simple_reg32(struct smb_drv_data, name, offset)
> +
> +#endif

Suzuki
