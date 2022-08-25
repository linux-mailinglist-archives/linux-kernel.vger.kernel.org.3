Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26065A10CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbiHYMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiHYMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:41:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7854DF00;
        Thu, 25 Aug 2022 05:41:56 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MD2dp1QD3z67bNK;
        Thu, 25 Aug 2022 20:41:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 14:41:53 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 13:41:53 +0100
Date:   Thu, 25 Aug 2022 13:41:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/mbox: Add background operation handling
 machinery
Message-ID: <20220825134152.00005244@huawei.com>
In-Reply-To: <20220804045029.2905056-2-dave@stgolabs.net>
References: <20220804045029.2905056-1-dave@stgolabs.net>
        <20220804045029.2905056-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Aug 2022 21:50:28 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run asynchronously in the background, these are limited to:
> transfer/activate firmware, scan media, sanitize (aka overwrite)
> and VPPB bind/unbind.
> 
> Completion of background operations, successful or not, can be handled
> via irq or poll based. This patch deals only with polling, which
> introduces some complexities as we need to handle the window in which
> the original background command completed, then a new one is
> successfully started before the poller wakes up and checks. This,
> in theory, can occur any amount of times. One of the problems is
> that previous states cannot be tracked as hw background status
> registers always deal with the last command.
> 
> So in order to keep hardware and the driver in sync, there can be
> windows where the hardware is ready but the driver won't be, and
> thus must serialize/handle it accordingly. While this polling cost
> may not be ideal: 1) background commands are rare/limited and
> 2) the extra busy time should be small compared to the overall
> command duration.
> 
> The implementation extends struct cxl_mem_command to become aware
> of background-capable commands in a generic fashion and presents
> some interfaces:
> 
> - Calls for bg operations, where each bg command can choose to implement
>   whatever needed based on the nature of the operation. For example,
>   while running, overwrite may only allow certain related commands to

I'd refer to sanitize rather than overwrite to keep aligned with spec.
It's not so much that command isn't allowed as it will return an error.
Is there any advantage in explicitly not sending the commands that will
error?  Either way the caller sees an error.


>   occur, while scan media does not have any such limitations.
>   Delay times can also be different, for which ad-hoc hinting can
>   be defined - for example, scan media could use some value based on
>   GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
>   pmem DSM specs[0]. Similarly some commands need to execute tasks
>   once the command finishes, such as overwriting requires CPU flushing
>   when successfully done. These are:
> 
>   cxl_mbox_bgcmd_conflicts()
>   cxl_mbox_bgcmd_delay()
>   cxl_mbox_bgcmd_post()
> 
> - cxl_mbox_send_cmd() is extended such that callers can distinguish,
>   upon rc == 0, between completed and successfully started in the
>   background.

Hmm. Is there a return code we could use for this rather than changing
the function signature?  I'm thinking similar long running commands
in Crypto return -EINPROGRESS to indicate a similar situation. 
> 
> - cxl_mbox_bgcmd_running() will atomically tell which command is
>   running in the background, if any. This allows easy querying
>   functionality. Similarly, there are cxl_mbox_bgcmd_start() and
>   cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
>   While x86 serializes atomics, care must be taken with arm64, for
>   example, ensuring, minimally, release/acquire semantics.
> 
> There are currently no supported commands.
> 
> [0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/core.h |   2 +-
>  drivers/cxl/core/mbox.c | 199 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/port.c |   9 +-
>  drivers/cxl/cxl.h       |   8 ++
>  drivers/cxl/cxlmem.h    |  62 ++++++++++++-
>  drivers/cxl/pci.c       |   3 +-
>  drivers/cxl/pmem.c      |   5 +-
>  drivers/cxl/security.c  |  13 +--
>  8 files changed, 274 insertions(+), 27 deletions(-)
> 

...

> +unsigned long cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
> +{
> +	struct cxl_mem_command *c;
> +	unsigned long ret = 0;
> +
> +	cxl_for_each_cmd(c) {

If this gets called on a non background command might make sense to return an
error.  If so, check for opcode match first, then background if there
is a match and if that's not set error out.

		
> +		if (!(c->flags & CXL_CMD_FLAG_BACKGROUND))
> +			continue;
> +		if (opcode != c->opcode)
> +			continue;
> +
> +		if (c->bgops && c->bgops->delay)
> +			ret = c->bgops->delay(cxlds);
> +		break;
> +	}
> +	return ret * HZ;
> +}
> +
> +void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
> +			 u16 opcode, bool success)
> +{
> +	struct cxl_mem_command *c;
> +
> +	cxl_for_each_cmd(c) {
> +		if (!(c->flags & CXL_CMD_FLAG_BACKGROUND))
> +			continue;
> +		if (opcode != c->opcode)
> +			continue;

We definitely shouldn't have duplicate entries, so I'd
check opcode match first, then if there is a match and
background not set error out.

> +
> +		if (c->bgops && c->bgops->post)
> +			c->bgops->post(cxlds, success);
> +		break;
> +	}
> +}
> +
> +/*
> + * Ensure that ->mbox_send() can run safely when a background
> + * command is running. If so, returns zero, otherwise -EBUSY.

As above, I'm not sure this is necessary given you should get
a sensible error code in response to any such message.
E.g. media disabled.

I'm not against defense in depth though if you want to add
this block list.  It's just strikes me as tricky to maintain
when new commands are added in future specs.  Perhaps better
to make it a problem for the hardware.
 
> + *
> + * check 1. bg cmd running. In most cases we can just be on
> + *          our merry way.
Comment is confusing. Perhaps
		bg cmd running. If not running it is fine to
		send any command. If one is running then there
		may be restrictions. 
> + * check 2. @new incoming command is not capable of running

is capable?

> + *          in the background. If there is an in-flight bg
> + *          operation, all these are forbidden as we need
> + *          to serialize when polling.
> + * check 3. @new incoming command is not blacklisted by the
> + *          current running command.
> + */
> +static int cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
> +{
> +	struct cxl_mem_command *c;
> +
> +	/* 1 */
> +	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
> +		return 0;
> +
> +	cxl_for_each_cmd(c) {
> +		if (new != c->opcode)
> +			continue;

Feels like a cxl_find_cmd() might be useful...


> +
> +		/* 2 */
> +		if (c->flags & CXL_CMD_FLAG_BACKGROUND)
> +			break;

My preference would be a direct return.

> +		/* 3 */
> +		if (c->bgops && c->bgops->conflicts)
> +			return c->bgops->conflicts(new);
> +		break;
		If there is no conflicts() function I would
		think that we are fine to run it. So return 0?

> +	}
> +
> +	return -EBUSY;
> +}
> +
> +/*
> + * Background operation polling mode.
> + */
> +static void cxl_mbox_bgcmd_work(struct work_struct *work)
> +{
> +	struct cxl_dev_state *cxlds;
> +	u64 bgcmd_status_reg;
> +	u16 opcode;
> +	u32 pct;
> +
> +	cxlds = container_of(work, struct cxl_dev_state, bg_dwork.work);
> +
> +	bgcmd_status_reg = readq(cxlds->regs.mbox +
> +				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK,
> +			   bgcmd_status_reg);
> +
> +	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
> +	if (pct != 100) {
> +		unsigned long hint;
> +		u64 status_reg;
> +
> +		status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
> +		if (!FIELD_GET(CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION,
> +			       status_reg))
> +			dev_WARN(cxlds->dev,
> +				 "No background operation running (%u%%).\n",
> +				 pct);
> +
> +		hint = cxl_mbox_bgcmd_delay(cxlds, opcode);
> +		if (hint == 0) {
> +			/*
> +			 * TODO: try to do better(?). pct is updated every
> +			 * ~1 sec, maybe use a heurstic based on that.
> +			 */
> +			hint = 5 * HZ;
> +		}
> +
> +		queue_delayed_work(cxl_mbox_bgcmd_wq, &cxlds->bg_dwork, hint);
> +	} else { /* bg operation completed */
> +		u16 return_code;
> +
> +		return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +					bgcmd_status_reg);
> +		cxl_mbox_bgcmd_post(cxlds, opcode,
> +				    return_code == CXL_MBOX_CMD_RC_SUCCESS);
> +
> +		put_device(cxlds->dev);
> +		cxl_mbox_bgcmd_done(cxlds);
> +	}
> +}
> +
>  /**
>   * cxl_mbox_send_cmd() - Send a mailbox command to a device.
>   * @cxlds: The device data for the operation
> @@ -153,6 +283,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * @in_size: The length of the input payload
>   * @out: Caller allocated buffer for the output.
>   * @out_size: Expected size of output.
> + * @return_code: (output) HW returned code.
>   *
>   * Context: Any context.
>   * Return:
> @@ -167,8 +298,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * error. While this distinction can be useful for commands from userspace, the
>   * kernel will only be able to use results when both are successful.
>   */
> -int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
> -		      size_t in_size, void *out, size_t out_size)
> +int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode,
> +		      void *in, size_t in_size,
> +		      void *out, size_t out_size, u16 *return_code)
>  {
>  	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  	struct cxl_mbox_cmd mbox_cmd = {
> @@ -183,12 +315,46 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>  	if (out_size > cxlds->payload_size)
>  		return -E2BIG;
>  
> +	/*
> +	 * With bg polling this can overlap a scenario where the
> +	 * hardware can receive new requests but the driver is
> +	 * not ready. Handle accordingly.
> +	 */
> +	rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
> +	if (return_code)
> +		*return_code = mbox_cmd.return_code;
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	switch (mbox_cmd.return_code) {
> +	case CXL_MBOX_CMD_RC_BACKGROUND:
> +	{
> +		int err;
> +
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x: %s\n", opcode,
> +			cxl_mbox_cmd_rc2str(&mbox_cmd));
> +
> +		err = cxl_mbox_bgcmd_begin(cxlds, opcode);
> +		if (err) {

Why not return an error?  I'd have thought this was fairly fatal...

> +			dev_WARN(cxlds->dev,
> +				 "Corrupted background cmd (opcode 0x%04x)\n",
> +				 err);
> +		}
> +
> +		get_device(cxlds->dev);
> +		/* do first poll check asap before using any hinting */
> +		queue_delayed_work(cxl_mbox_bgcmd_wq, &cxlds->bg_dwork, 0);
> +		fallthrough;

falling through to a break seems unnecessary, just break; here probably
slightly easier to read.

> +	}
> +	case CXL_MBOX_CMD_RC_SUCCESS:
> +		break;
> +	default:
>  		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +	}
>  
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the
> @@ -198,6 +364,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>  		if (mbox_cmd.size_out != out_size)
>  			return -EIO;
>  	}
> +
Unrelated change - drop it from this patch.
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
> @@ -575,7 +742,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		int rc;
>  
>  		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
> -				       out, xfer_size);
> +				       out, xfer_size, NULL);
>  		if (rc < 0)
>  			return rc;
>  
> @@ -628,7 +795,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
>  		return ERR_PTR(-ENOMEM);
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
> -			       cxlds->payload_size);
> +			       cxlds->payload_size, NULL);
>  	if (rc < 0) {
>  		kvfree(ret);
>  		return ERR_PTR(rc);
> @@ -733,7 +900,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
> -			       &pi, sizeof(pi));
> +			       &pi, sizeof(pi), NULL);
>  
>  	if (rc)
>  		return rc;
> @@ -766,7 +933,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> -			       sizeof(id));
> +			       sizeof(id), NULL);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -845,6 +1012,9 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	INIT_DELAYED_WORK(&cxlds->bg_dwork, cxl_mbox_bgcmd_work);
> +	atomic_set(&cxlds->bg, 0);
> +
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> @@ -853,7 +1023,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dev_state_create, CXL);
>  
>  static struct dentry *cxl_debugfs;
>  


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index dbce99bdffab..1350b99e7287 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -104,7 +104,7 @@ static ssize_t name##_show(struct device *dev,                       \
>  			   struct device_attribute *attr, char *buf) \
>  {                                                                    \
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
> -                                                                     \
> +								     \
Unrelated change that shouldn't be in this patch.

>  	return sysfs_emit(buf, "%s\n",                               \
>  			  (cxld->flags & (flag)) ? "1" : "0");       \
>  }                                                                    \

...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4bcb02f625b4..c05dc1b8189a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -192,6 +192,8 @@ struct cxl_endpoint_dvsec_info {
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> + * @bg: opcode for the in-flight background operation on @dev
> + * @bg_dwork: self-polling work item
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -225,12 +227,15 @@ struct cxl_dev_state {
>  	u64 serial;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +	atomic_t bg;
> +	struct delayed_work bg_dwork;
>  };
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> +	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> @@ -250,17 +255,46 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,

Why introduce all these now?  Better to keep to introducing at first use.

>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_BIND_VPPB		= 0x5201,
> +	CXL_MBOX_OP_UNBIND_VPPB		= 0x5202,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> -#define DEFINE_CXL_CEL_UUID                                                    \
> -	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
> +/*
> + * CXL 3.0 supported commands that can run in the background.

I'd drop the 3.0 reference as was true with CXL 2.0 as well and
it might confuse people with CXL 2.0 devices.

> + *
> + * Commands that require a longer execution time shall be
> + * completed asynchronously in the background. At a hw level
> + * only one command can be executed in the background at a
> + * time, and therefore additional background commands shall
> + * be rejected with the busy return code.
> + *
> + * Barriers pair with release/acquire semantics. When done,
> + * clearing ->bg must be the very last operation before
> + * finishing the command.
> + */
> +static inline int cxl_mbox_bgcmd_begin(struct cxl_dev_state *cxlds, u16 opcode)
> +{
> +	return atomic_xchg(&cxlds->bg, opcode);
> +}
> +static inline int cxl_mbox_bgcmd_running(struct cxl_dev_state *cxlds)
> +{
> +	return atomic_read_acquire(&cxlds->bg);
> +}
> +static inline void cxl_mbox_bgcmd_done(struct cxl_dev_state *cxlds)
> +{
> +	atomic_set_release(&cxlds->bg, 0);
> +}
> +
> +#define DEFINE_CXL_CEL_UUID						\
> +	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62, \
>  		  0x3b, 0x3f, 0x17)
>  
>  #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
> @@ -323,16 +357,32 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  

>   * The cxl_mem_command is the driver's internal representation of commands that
>   * are supported by the driver. Some of these commands may not be supported by
>   * the hardware. The driver will use @info to validate the fields passed in by
> @@ -344,8 +394,9 @@ struct cxl_mem_command {
>  	struct cxl_command_info info;
>  	enum cxl_opcode opcode;
>  	u32 flags;
> -#define CXL_CMD_FLAG_NONE 0
Why remove this?  If not used should be removed in a different patch.

> +	struct cxl_mem_bgcommand_ops *bgops;
>  #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
> +#define CXL_CMD_FLAG_BACKGROUND BIT(1)
>  };
>  
