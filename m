Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A84E80EC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiCZMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiCZMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:50:05 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208F5FB8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 05:48:26 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Y5qBn1fUmxHdTY5qBncuR1; Sat, 26 Mar 2022 13:48:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 26 Mar 2022 13:48:24 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: [PATCH v3] scsi: pmcraid: Remove the PMCRAID_PASSTHROUGH_IOCTL ioctl implementation
Date:   Sat, 26 Mar 2022 13:48:15 +0100
Message-Id: <7f27a70bec3f3dcaf46a29b1c630edd4792e71c0.1648298857.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole passthrough ioctl path looks completely broken.  For example it
dma maps the scatterlist and after that copies data to it, which is
prohibited by the DMA API contract.

Moreover, in pmcraid_alloc_sglist(), the pointer returned by a
sgl_alloc_order() call is not recorded anywhere which is pointless.

So remove the PMCRAID_PASSTHROUGH_IOCTL ioctl implementation entirely.
Should it be needed, we should reimplement it using the proper block layer
request mapping helpers.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1: https://lore.kernel.org/all/20200920075722.376644-1-christophe.jaillet@wanadoo.fr/
v1 -> v2: synch with -next-20220110

v2: https://lore.kernel.org/all/11a1bc98501de37baa5bcd10b61136f6e450b82e.1641816080.git.christophe.jaillet@wanadoo.fr/
v2 -> v3: instead of fixing the memory allocation issue, remove

This patch is compile-tested only.
I've removed all related function so that compiler does not complain.
Maybe further simplification is possible.
---
 drivers/scsi/pmcraid.c | 491 -----------------------------------------
 drivers/scsi/pmcraid.h |  33 ---
 2 files changed, 524 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 928532180d32..fd674ed1febe 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3181,124 +3181,6 @@ static int pmcraid_build_ioadl(
 	return 0;
 }
 
-/**
- * pmcraid_free_sglist - Frees an allocated SG buffer list
- * @sglist: scatter/gather list pointer
- *
- * Free a DMA'able memory previously allocated with pmcraid_alloc_sglist
- *
- * Return value:
- *	none
- */
-static void pmcraid_free_sglist(struct pmcraid_sglist *sglist)
-{
-	sgl_free_order(sglist->scatterlist, sglist->order);
-	kfree(sglist);
-}
-
-/**
- * pmcraid_alloc_sglist - Allocates memory for a SG list
- * @buflen: buffer length
- *
- * Allocates a DMA'able buffer in chunks and assembles a scatter/gather
- * list.
- *
- * Return value
- *	pointer to sglist / NULL on failure
- */
-static struct pmcraid_sglist *pmcraid_alloc_sglist(int buflen)
-{
-	struct pmcraid_sglist *sglist;
-	int sg_size;
-	int order;
-
-	sg_size = buflen / (PMCRAID_MAX_IOADLS - 1);
-	order = (sg_size > 0) ? get_order(sg_size) : 0;
-
-	/* Allocate a scatter/gather list for the DMA */
-	sglist = kzalloc(sizeof(struct pmcraid_sglist), GFP_KERNEL);
-	if (sglist == NULL)
-		return NULL;
-
-	sglist->order = order;
-	sgl_alloc_order(buflen, order, false, GFP_KERNEL | __GFP_ZERO,
-			&sglist->num_sg);
-
-	return sglist;
-}
-
-/**
- * pmcraid_copy_sglist - Copy user buffer to kernel buffer's SG list
- * @sglist: scatter/gather list pointer
- * @buffer: buffer pointer
- * @len: buffer length
- * @direction: data transfer direction
- *
- * Copy a user buffer into a buffer allocated by pmcraid_alloc_sglist
- *
- * Return value:
- * 0 on success / other on failure
- */
-static int pmcraid_copy_sglist(
-	struct pmcraid_sglist *sglist,
-	void __user *buffer,
-	u32 len,
-	int direction
-)
-{
-	struct scatterlist *sg;
-	void *kaddr;
-	int bsize_elem;
-	int i;
-	int rc = 0;
-
-	/* Determine the actual number of bytes per element */
-	bsize_elem = PAGE_SIZE * (1 << sglist->order);
-
-	sg = sglist->scatterlist;
-
-	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
-		struct page *page = sg_page(sg);
-
-		kaddr = kmap(page);
-		if (direction == DMA_TO_DEVICE)
-			rc = copy_from_user(kaddr, buffer, bsize_elem);
-		else
-			rc = copy_to_user(buffer, kaddr, bsize_elem);
-
-		kunmap(page);
-
-		if (rc) {
-			pmcraid_err("failed to copy user data into sg list\n");
-			return -EFAULT;
-		}
-
-		sg->length = bsize_elem;
-	}
-
-	if (len % bsize_elem) {
-		struct page *page = sg_page(sg);
-
-		kaddr = kmap(page);
-
-		if (direction == DMA_TO_DEVICE)
-			rc = copy_from_user(kaddr, buffer, len % bsize_elem);
-		else
-			rc = copy_to_user(buffer, kaddr, len % bsize_elem);
-
-		kunmap(page);
-
-		sg->length = len % bsize_elem;
-	}
-
-	if (rc) {
-		pmcraid_err("failed to copy user data into sg list\n");
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
 /**
  * pmcraid_queuecommand_lck - Queue a mid-layer request
  * @scsi_cmd: scsi command struct
@@ -3454,365 +3336,6 @@ static int pmcraid_chr_fasync(int fd, struct file *filep, int mode)
 	return rc;
 }
 
-
-/**
- * pmcraid_build_passthrough_ioadls - builds SG elements for passthrough
- * commands sent over IOCTL interface
- *
- * @cmd       : pointer to struct pmcraid_cmd
- * @buflen    : length of the request buffer
- * @direction : data transfer direction
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static int pmcraid_build_passthrough_ioadls(
-	struct pmcraid_cmd *cmd,
-	int buflen,
-	int direction
-)
-{
-	struct pmcraid_sglist *sglist = NULL;
-	struct scatterlist *sg = NULL;
-	struct pmcraid_ioarcb *ioarcb = &cmd->ioa_cb->ioarcb;
-	struct pmcraid_ioadl_desc *ioadl;
-	int i;
-
-	sglist = pmcraid_alloc_sglist(buflen);
-
-	if (!sglist) {
-		pmcraid_err("can't allocate memory for passthrough SGls\n");
-		return -ENOMEM;
-	}
-
-	sglist->num_dma_sg = dma_map_sg(&cmd->drv_inst->pdev->dev,
-					sglist->scatterlist,
-					sglist->num_sg, direction);
-
-	if (!sglist->num_dma_sg || sglist->num_dma_sg > PMCRAID_MAX_IOADLS) {
-		dev_err(&cmd->drv_inst->pdev->dev,
-			"Failed to map passthrough buffer!\n");
-		pmcraid_free_sglist(sglist);
-		return -EIO;
-	}
-
-	cmd->sglist = sglist;
-	ioarcb->request_flags0 |= NO_LINK_DESCS;
-
-	ioadl = pmcraid_init_ioadls(cmd, sglist->num_dma_sg);
-
-	/* Initialize IOADL descriptor addresses */
-	for_each_sg(sglist->scatterlist, sg, sglist->num_dma_sg, i) {
-		ioadl[i].data_len = cpu_to_le32(sg_dma_len(sg));
-		ioadl[i].address = cpu_to_le64(sg_dma_address(sg));
-		ioadl[i].flags = 0;
-	}
-
-	/* setup the last descriptor */
-	ioadl[i - 1].flags = IOADL_FLAGS_LAST_DESC;
-
-	return 0;
-}
-
-
-/**
- * pmcraid_release_passthrough_ioadls - release passthrough ioadls
- *
- * @cmd: pointer to struct pmcraid_cmd for which ioadls were allocated
- * @buflen: size of the request buffer
- * @direction: data transfer direction
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static void pmcraid_release_passthrough_ioadls(
-	struct pmcraid_cmd *cmd,
-	int buflen,
-	int direction
-)
-{
-	struct pmcraid_sglist *sglist = cmd->sglist;
-
-	if (buflen > 0) {
-		dma_unmap_sg(&cmd->drv_inst->pdev->dev,
-			     sglist->scatterlist,
-			     sglist->num_sg,
-			     direction);
-		pmcraid_free_sglist(sglist);
-		cmd->sglist = NULL;
-	}
-}
-
-/**
- * pmcraid_ioctl_passthrough - handling passthrough IOCTL commands
- *
- * @pinstance: pointer to adapter instance structure
- * @ioctl_cmd: ioctl code
- * @buflen: unused
- * @arg: pointer to pmcraid_passthrough_buffer user buffer
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static long pmcraid_ioctl_passthrough(
-	struct pmcraid_instance *pinstance,
-	unsigned int ioctl_cmd,
-	unsigned int buflen,
-	void __user *arg
-)
-{
-	struct pmcraid_passthrough_ioctl_buffer *buffer;
-	struct pmcraid_ioarcb *ioarcb;
-	struct pmcraid_cmd *cmd;
-	struct pmcraid_cmd *cancel_cmd;
-	void __user *request_buffer;
-	unsigned long request_offset;
-	unsigned long lock_flags;
-	void __user *ioasa;
-	u32 ioasc;
-	int request_size;
-	int buffer_size;
-	u8 direction;
-	int rc = 0;
-
-	/* If IOA reset is in progress, wait 10 secs for reset to complete */
-	if (pinstance->ioa_reset_in_progress) {
-		rc = wait_event_interruptible_timeout(
-				pinstance->reset_wait_q,
-				!pinstance->ioa_reset_in_progress,
-				msecs_to_jiffies(10000));
-
-		if (!rc)
-			return -ETIMEDOUT;
-		else if (rc < 0)
-			return -ERESTARTSYS;
-	}
-
-	/* If adapter is not in operational state, return error */
-	if (pinstance->ioa_state != IOA_STATE_OPERATIONAL) {
-		pmcraid_err("IOA is not operational\n");
-		return -ENOTTY;
-	}
-
-	buffer_size = sizeof(struct pmcraid_passthrough_ioctl_buffer);
-	buffer = kmalloc(buffer_size, GFP_KERNEL);
-
-	if (!buffer) {
-		pmcraid_err("no memory for passthrough buffer\n");
-		return -ENOMEM;
-	}
-
-	request_offset =
-	    offsetof(struct pmcraid_passthrough_ioctl_buffer, request_buffer);
-
-	request_buffer = arg + request_offset;
-
-	rc = copy_from_user(buffer, arg,
-			     sizeof(struct pmcraid_passthrough_ioctl_buffer));
-
-	ioasa = arg + offsetof(struct pmcraid_passthrough_ioctl_buffer, ioasa);
-
-	if (rc) {
-		pmcraid_err("ioctl: can't copy passthrough buffer\n");
-		rc = -EFAULT;
-		goto out_free_buffer;
-	}
-
-	request_size = le32_to_cpu(buffer->ioarcb.data_transfer_length);
-
-	if (buffer->ioarcb.request_flags0 & TRANSFER_DIR_WRITE) {
-		direction = DMA_TO_DEVICE;
-	} else {
-		direction = DMA_FROM_DEVICE;
-	}
-
-	if (request_size < 0) {
-		rc = -EINVAL;
-		goto out_free_buffer;
-	}
-
-	/* check if we have any additional command parameters */
-	if (le16_to_cpu(buffer->ioarcb.add_cmd_param_length)
-	     > PMCRAID_ADD_CMD_PARAM_LEN) {
-		rc = -EINVAL;
-		goto out_free_buffer;
-	}
-
-	cmd = pmcraid_get_free_cmd(pinstance);
-
-	if (!cmd) {
-		pmcraid_err("free command block is not available\n");
-		rc = -ENOMEM;
-		goto out_free_buffer;
-	}
-
-	cmd->scsi_cmd = NULL;
-	ioarcb = &(cmd->ioa_cb->ioarcb);
-
-	/* Copy the user-provided IOARCB stuff field by field */
-	ioarcb->resource_handle = buffer->ioarcb.resource_handle;
-	ioarcb->data_transfer_length = buffer->ioarcb.data_transfer_length;
-	ioarcb->cmd_timeout = buffer->ioarcb.cmd_timeout;
-	ioarcb->request_type = buffer->ioarcb.request_type;
-	ioarcb->request_flags0 = buffer->ioarcb.request_flags0;
-	ioarcb->request_flags1 = buffer->ioarcb.request_flags1;
-	memcpy(ioarcb->cdb, buffer->ioarcb.cdb, PMCRAID_MAX_CDB_LEN);
-
-	if (buffer->ioarcb.add_cmd_param_length) {
-		ioarcb->add_cmd_param_length =
-			buffer->ioarcb.add_cmd_param_length;
-		ioarcb->add_cmd_param_offset =
-			buffer->ioarcb.add_cmd_param_offset;
-		memcpy(ioarcb->add_data.u.add_cmd_params,
-			buffer->ioarcb.add_data.u.add_cmd_params,
-			le16_to_cpu(buffer->ioarcb.add_cmd_param_length));
-	}
-
-	/* set hrrq number where the IOA should respond to. Note that all cmds
-	 * generated internally uses hrrq_id 0, exception to this is the cmd
-	 * block of scsi_cmd which is re-used (e.g. cancel/abort), which uses
-	 * hrrq_id assigned here in queuecommand
-	 */
-	ioarcb->hrrq_id = atomic_add_return(1, &(pinstance->last_message_id)) %
-			  pinstance->num_hrrq;
-
-	if (request_size) {
-		rc = pmcraid_build_passthrough_ioadls(cmd,
-						      request_size,
-						      direction);
-		if (rc) {
-			pmcraid_err("couldn't build passthrough ioadls\n");
-			goto out_free_cmd;
-		}
-	}
-
-	/* If data is being written into the device, copy the data from user
-	 * buffers
-	 */
-	if (direction == DMA_TO_DEVICE && request_size > 0) {
-		rc = pmcraid_copy_sglist(cmd->sglist,
-					 request_buffer,
-					 request_size,
-					 direction);
-		if (rc) {
-			pmcraid_err("failed to copy user buffer\n");
-			goto out_free_sglist;
-		}
-	}
-
-	/* passthrough ioctl is a blocking command so, put the user to sleep
-	 * until timeout. Note that a timeout value of 0 means, do timeout.
-	 */
-	cmd->cmd_done = pmcraid_internal_done;
-	init_completion(&cmd->wait_for_completion);
-	cmd->completion_req = 1;
-
-	pmcraid_info("command(%d) (CDB[0] = %x) for %x\n",
-		     le32_to_cpu(cmd->ioa_cb->ioarcb.response_handle) >> 2,
-		     cmd->ioa_cb->ioarcb.cdb[0],
-		     le32_to_cpu(cmd->ioa_cb->ioarcb.resource_handle));
-
-	spin_lock_irqsave(pinstance->host->host_lock, lock_flags);
-	_pmcraid_fire_command(cmd);
-	spin_unlock_irqrestore(pinstance->host->host_lock, lock_flags);
-
-	/* NOTE ! Remove the below line once abort_task is implemented
-	 * in firmware. This line disables ioctl command timeout handling logic
-	 * similar to IO command timeout handling, making ioctl commands to wait
-	 * until the command completion regardless of timeout value specified in
-	 * ioarcb
-	 */
-	buffer->ioarcb.cmd_timeout = 0;
-
-	/* If command timeout is specified put caller to wait till that time,
-	 * otherwise it would be blocking wait. If command gets timed out, it
-	 * will be aborted.
-	 */
-	if (buffer->ioarcb.cmd_timeout == 0) {
-		wait_for_completion(&cmd->wait_for_completion);
-	} else if (!wait_for_completion_timeout(
-			&cmd->wait_for_completion,
-			msecs_to_jiffies(le16_to_cpu(buffer->ioarcb.cmd_timeout) * 1000))) {
-
-		pmcraid_info("aborting cmd %d (CDB[0] = %x) due to timeout\n",
-			le32_to_cpu(cmd->ioa_cb->ioarcb.response_handle) >> 2,
-			cmd->ioa_cb->ioarcb.cdb[0]);
-
-		spin_lock_irqsave(pinstance->host->host_lock, lock_flags);
-		cancel_cmd = pmcraid_abort_cmd(cmd);
-		spin_unlock_irqrestore(pinstance->host->host_lock, lock_flags);
-
-		if (cancel_cmd) {
-			wait_for_completion(&cancel_cmd->wait_for_completion);
-			ioasc = le32_to_cpu(cancel_cmd->ioa_cb->ioasa.ioasc);
-			pmcraid_return_cmd(cancel_cmd);
-
-			/* if abort task couldn't find the command i.e it got
-			 * completed prior to aborting, return good completion.
-			 * if command got aborted successfully or there was IOA
-			 * reset due to abort task itself getting timedout then
-			 * return -ETIMEDOUT
-			 */
-			if (ioasc == PMCRAID_IOASC_IOA_WAS_RESET ||
-			    PMCRAID_IOASC_SENSE_KEY(ioasc) == 0x00) {
-				if (ioasc != PMCRAID_IOASC_GC_IOARCB_NOTFOUND)
-					rc = -ETIMEDOUT;
-				goto out_handle_response;
-			}
-		}
-
-		/* no command block for abort task or abort task failed to abort
-		 * the IOARCB, then wait for 150 more seconds and initiate reset
-		 * sequence after timeout
-		 */
-		if (!wait_for_completion_timeout(
-			&cmd->wait_for_completion,
-			msecs_to_jiffies(150 * 1000))) {
-			pmcraid_reset_bringup(cmd->drv_inst);
-			rc = -ETIMEDOUT;
-		}
-	}
-
-out_handle_response:
-	/* copy entire IOASA buffer and return IOCTL success.
-	 * If copying IOASA to user-buffer fails, return
-	 * EFAULT
-	 */
-	if (copy_to_user(ioasa, &cmd->ioa_cb->ioasa,
-		sizeof(struct pmcraid_ioasa))) {
-		pmcraid_err("failed to copy ioasa buffer to user\n");
-		rc = -EFAULT;
-	}
-
-	/* If the data transfer was from device, copy the data onto user
-	 * buffers
-	 */
-	else if (direction == DMA_FROM_DEVICE && request_size > 0) {
-		rc = pmcraid_copy_sglist(cmd->sglist,
-					 request_buffer,
-					 request_size,
-					 direction);
-		if (rc) {
-			pmcraid_err("failed to copy user buffer\n");
-			rc = -EFAULT;
-		}
-	}
-
-out_free_sglist:
-	pmcraid_release_passthrough_ioadls(cmd, request_size, direction);
-
-out_free_cmd:
-	pmcraid_return_cmd(cmd);
-
-out_free_buffer:
-	kfree(buffer);
-
-	return rc;
-}
-
-
-
-
 /**
  * pmcraid_ioctl_driver - ioctl handler for commands handled by driver itself
  *
@@ -3922,20 +3445,6 @@ static long pmcraid_chr_ioctl(
 
 	switch (_IOC_TYPE(cmd)) {
 
-	case PMCRAID_PASSTHROUGH_IOCTL:
-		/* If ioctl code is to download microcode, we need to block
-		 * mid-layer requests.
-		 */
-		if (cmd == PMCRAID_IOCTL_DOWNLOAD_MICROCODE)
-			scsi_block_requests(pinstance->host);
-
-		retval = pmcraid_ioctl_passthrough(pinstance, cmd,
-						   hdr->buffer_length, argp);
-
-		if (cmd == PMCRAID_IOCTL_DOWNLOAD_MICROCODE)
-			scsi_unblock_requests(pinstance->host);
-		break;
-
 	case PMCRAID_DRIVER_IOCTL:
 		arg += sizeof(struct pmcraid_ioctl_header);
 		retval = pmcraid_ioctl_driver(pinstance, cmd,
diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index bbb75318f1e7..9f59930e8b4f 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -1022,41 +1022,16 @@ struct pmcraid_ioctl_header {
 
 #define PMCRAID_IOCTL_SIGNATURE      "PMCRAID"
 
-/*
- * pmcraid_passthrough_ioctl_buffer - structure given as argument to
- * passthrough(or firmware handled) IOCTL commands. Note that ioarcb requires
- * 32-byte alignment so, it is necessary to pack this structure to avoid any
- * holes between ioctl_header and passthrough buffer
- *
- * .ioactl_header : ioctl header
- * .ioarcb        : filled-up ioarcb buffer, driver always reads this buffer
- * .ioasa         : buffer for ioasa, driver fills this with IOASA from firmware
- * .request_buffer: The I/O buffer (flat), driver reads/writes to this based on
- *                  the transfer directions passed in ioarcb.flags0. Contents
- *                  of this buffer are valid only when ioarcb.data_transfer_len
- *                  is not zero.
- */
-struct pmcraid_passthrough_ioctl_buffer {
-	struct pmcraid_ioctl_header ioctl_header;
-	struct pmcraid_ioarcb ioarcb;
-	struct pmcraid_ioasa  ioasa;
-	u8  request_buffer[];
-} __attribute__ ((packed, aligned(PMCRAID_IOARCB_ALIGNMENT)));
-
 /*
  * keys to differentiate between driver handled IOCTLs and passthrough
  * IOCTLs passed to IOA. driver determines the ioctl type using macro
  * _IOC_TYPE
  */
 #define PMCRAID_DRIVER_IOCTL         'D'
-#define PMCRAID_PASSTHROUGH_IOCTL    'F'
 
 #define DRV_IOCTL(n, size) \
 	_IOC(_IOC_READ|_IOC_WRITE, PMCRAID_DRIVER_IOCTL, (n), (size))
 
-#define FMW_IOCTL(n, size) \
-	_IOC(_IOC_READ|_IOC_WRITE, PMCRAID_PASSTHROUGH_IOCTL,  (n), (size))
-
 /*
  * _ARGSIZE: macro that gives size of the argument type passed to an IOCTL cmd.
  * This is to facilitate applications avoiding un-necessary memory allocations.
@@ -1069,12 +1044,4 @@ struct pmcraid_passthrough_ioctl_buffer {
 #define PMCRAID_IOCTL_RESET_ADAPTER          \
 	DRV_IOCTL(5, sizeof(struct pmcraid_ioctl_header))
 
-/* passthrough/firmware handled commands */
-#define PMCRAID_IOCTL_PASSTHROUGH_COMMAND         \
-	FMW_IOCTL(1, sizeof(struct pmcraid_passthrough_ioctl_buffer))
-
-#define PMCRAID_IOCTL_DOWNLOAD_MICROCODE     \
-	FMW_IOCTL(2, sizeof(struct pmcraid_passthrough_ioctl_buffer))
-
-
 #endif /* _PMCRAID_H */
-- 
2.32.0

