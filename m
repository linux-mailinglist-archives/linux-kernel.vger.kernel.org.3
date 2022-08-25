Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF85B5A12FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiHYOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHYOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:08:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4A72849;
        Thu, 25 Aug 2022 07:08:45 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MD4Yy5Ss3z67Zm5;
        Thu, 25 Aug 2022 22:08:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 16:08:42 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 15:08:42 +0100
Date:   Thu, 25 Aug 2022 15:08:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mem: Support sanitation commands
Message-ID: <20220825150841.000044a1@huawei.com>
In-Reply-To: <20220804045029.2905056-3-dave@stgolabs.net>
References: <20220804045029.2905056-1-dave@stgolabs.net>
        <20220804045029.2905056-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Aug 2022 21:50:29 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement support for the non-pmem exclusive sanitize (aka overwrite)
> and secure erase commands, per CXL 3.0 specs.
> 
> To properly support this feature, create a 'security' sysfs file that
> when read will list the current pmem security state or overwrite, and
> when written to, perform the requested operation.
> 
> As with ndctl-speak, the use cases here would be:
> 
> $> cxl sanitize --erase memX
> $> cxl sanitize --overwrite memX
> $> cxl sanitize --wait-overwrite memX  
> 
> While userspace can implement entirely the wait/query mechanism for
> waiting for the sanitize to complete. Unlike persistent memory
> equivalents, there is no command to query in CXL, and as such we can
> safely just use cxlds->bg.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  19 +++++
>  drivers/cxl/core/mbox.c                 | 105 ++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               |  58 +++++++++++++
>  drivers/cxl/cxlmem.h                    |   3 +
>  include/uapi/linux/cxl_mem.h            |   2 +
>  5 files changed, 187 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7c2b846521f3..88631b492a11 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -52,6 +52,25 @@ Description:
>  		host PCI device for this memory device, emit the CPU node
>  		affinity for this device.
>  
> +What:		/sys/bus/cxl/devices/memX/security
> +Date:		August, 2022
> +KernelVersion:	v5.21

v6.1

> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		Reading this file will display the security state for that
> +		device. The following states are available: disabled, frozen,
> +		locked, unlocked and overwrite. When writing to the file, the
> +		following commands are supported:
> +		* overwrite - Sanitize the device  to securely re-purpose or
> +		  decommission it. This is done by ensuring that all user data
> +		  and meta-data, whether it resides in persistent capacity,
> +		  volatile capacity, or the label storage area, is made
> +		  permanently unavailable by whatever means is appropriate for
> +		  the media type. This causes all CPU caches to be flushed.
> +		* erase - Secure Erase user data by changing the media encryption
> +		  keys for all user data areas of the device. This causes all
> +		  CPU caches to be flushed.
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index db6e5a4d1f6d..06bbb760b392 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -41,6 +41,8 @@ static struct workqueue_struct *cxl_mbox_bgcmd_wq;
>  #define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
>  	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
>  
> +static struct cxl_mem_bgcommand_ops sanitize_bgops;
> +
>  #define CXL_VARIABLE_PAYLOAD	~0U
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
> @@ -71,6 +73,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_BGCMD(SANITIZE, 0, 0, 0, &sanitize_bgops),
> +	CXL_CMD(SECURE_ERASE, 0, 0, 0),
>  	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
>  	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
>  	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
> @@ -962,6 +966,107 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> +static int sanitize_bgcmd_conflicts(u16 new)
> +{
> +	/* Forbid anyone but health related commands */
> +	if (new == CXL_MBOX_OP_GET_HEALTH_INFO)
> +		return 0;
> +	return -EBUSY;
> +}
> +
> +static unsigned long sanitize_bgcmd_delay(struct cxl_dev_state *cxlds)
> +{
> +	unsigned long secs;
> +	u64 total_mem;
> +
> +	if (!cxlds)
> +		return 0;
> +
> +	total_mem = cxlds->total_bytes / CXL_CAPACITY_MULTIPLIER;
> +
> +	if (total_mem <= 16)
> +		secs = 1;
> +	else if (total_mem <= 64)
> +		secs = 10;
> +	else if (total_mem <= 256)
> +		secs = 20;
> +	else if (total_mem <= 512)
> +		secs = 40;
> +	else if (total_mem <= 1024)
> +		secs = 50;
> +	else
> +		secs = 60; /* max */
> +	return secs;
> +}
> +
> +static void sanitize_bgcmd_post(struct cxl_dev_state *cxlds, bool success)
> +{
> +	if (success)
> +		flush_cache_all();
> +}
> +
> +static struct cxl_mem_bgcommand_ops sanitize_bgops = {
> +	.conflicts = sanitize_bgcmd_conflicts,
> +	.delay = sanitize_bgcmd_delay,
> +	.post = sanitize_bgcmd_post,
> +};

blank line here.

> +/**
> + * cxl_mem_sanitize() - Send sanitation related commands to the device.
> + * @cxlds: The device data for the operation
> + * @cmd: The command opcode to send
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background.
> + * Upon error, return the result of the mailbox command or -EINVAL if
> + * security requirements are not met. CPU caches are flushed before and
> + * after succesful completion of each command.
> + *
> + * See CXL 2.0 @8.2.9.5.5 Sanitize.
> + */
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
> +{
> +	int rc;
> +	bool skip_security;
> +	u32 sec_out;
> +	u16 ret_code; /* hw */
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
> +			       NULL, 0, &sec_out, sizeof(sec_out), &ret_code);
> +	/* this may just be plain unsupported, do not error out */
> +	skip_security = (ret_code == CXL_MBOX_CMD_RC_UNSUPPORTED);

Ah. Now I'm understanding why you had the ret_code. I'd rather see this
done using the CEL so we don't send the command if not supported.

> +	if (rc && !skip_security)
> +		return rc;
> +
> +	/*
> +	 * Prior to using these commands, any security applied to
> +	 * the user data areas of the device shall be DISABLED (or
> +	 * UNLOCKED for secure erase case).
> +	 */
> +	if (!skip_security && (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return -EINVAL;
> +
> +	if (cmd == CXL_MBOX_OP_SANITIZE) {
> +		flush_cache_all();
> +
> +		rc = cxl_mbox_send_cmd(cxlds, cmd, NULL, 0, NULL, 0, &ret_code);
> +		if (rc == 0 && ret_code != CXL_MBOX_CMD_RC_BACKGROUND)
> +			flush_cache_all();
> +	} else if (cmd == CXL_MBOX_OP_SECURE_ERASE) {
> +		if (!skip_security && (sec_out & CXL_PMEM_SEC_STATE_LOCKED))
> +			return -EINVAL;
> +
> +		flush_cache_all();
> +
> +		rc = cxl_mbox_send_cmd(cxlds, cmd, NULL, 0, NULL, 0, NULL);
> +		if (rc == 0)
> +			flush_cache_all();
> +	} else
> +		rc = -EINVAL;
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
>  int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  {
>  	int rc;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f7cdcd33504a..db3c5eab7099 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,70 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +#define CXL_SEC_CMD_SIZE 32
> +
> +static ssize_t security_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u32 sec_out = 0;
> +	u16 ret_code;
> +	int rc;
> +
> +	if (cxl_mbox_bgcmd_running(cxlds) == CXL_MBOX_OP_SANITIZE)
> +		return sprintf(buf, "overwrite\n");
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
> +			       NULL, 0, &sec_out, sizeof(sec_out), &ret_code);
> +	if (ret_code == CXL_MBOX_CMD_RC_UNSUPPORTED)

As above - if not supported, don't send command.

If none of this stuff is supported, hide the sysfs interface via
the is_visible callback.

> +		return sprintf(buf, "disabled\n");
> +	if (rc)
> +		return rc;
> +
> +	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return sprintf(buf, "disabled\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
> +		return sprintf(buf, "frozen\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sprintf(buf, "locked\n");
> +	else
> +		return sprintf(buf, "unlocked\n");
> +}
> +
> +static ssize_t security_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	char cmd[CXL_SEC_CMD_SIZE+1];
> +	ssize_t rc;
> +
> +	rc = sscanf(buf, "%"__stringify(CXL_SEC_CMD_SIZE)"s", cmd);
> +	if (rc < 1)
> +		return -EINVAL;
> +
> +	if (sysfs_streq(cmd, "overwrite"))
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
> +	else if (sysfs_streq(cmd, "erase"))
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
> +	else
> +		rc = -EINVAL;
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +static DEVICE_ATTR_RW(security);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_security.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c05dc1b8189a..ee56a4802b34 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -256,6 +256,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_SANITIZE		= 0x4400,

This definition should be pulled forwards from previous patch I think.

> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> @@ -457,6 +458,8 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 6da25f2e1bf9..2cea8fb33249 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,6 +41,8 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> +	___C(SANITIZE, "Sanitize"),                                       \
> +	___C(SECURE_ERASE, "Secure Erase"),				  \
>  	___C(GET_SECURITY_STATE, "Get Security State"),			  \
>  	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
>  	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \

