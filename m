Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F444C098D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiBWCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiBWCoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:44:25 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF298F61C;
        Tue, 22 Feb 2022 18:39:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V5FyhHb_1645583935;
Received: from rsjc10526.et2sqa.tbsite.net(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0V5FyhHb_1645583935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 10:39:12 +0800
From:   James Wang <jnwang@linux.alibaba.com>
To:     don.brace@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3] [hpsa] Improve the coding-style to comment sections
Date:   Wed, 23 Feb 2022 10:38:55 +0800
Message-Id: <1645583935-110103-1-git-send-email-jnwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <739e4ca0-ec2d-d39a-4c80-2b2e16435f49@acm.org>
References: <739e4ca0-ec2d-d39a-4c80-2b2e16435f49@acm.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I need to fix a mistake in comment lines that
is lead by "+" in comments, It wouldn't cause the compiler
warning, but it seems not good;

As the latest coding-style instruction,
for the multi-line comment is

.. code-block:: c

        /*
         * This is the preferred style for multi-line
         * comments in the Linux kernel source code.
         * Please use it consistently.
         *
         * Description:  A column of asterisks on the left side,
         * with beginning and ending almost-blank lines.
         */

But for net/ and drivers/net the perferred style for multi-line is:

.. code-block:: c

        /* The preferred comment style for files in net/ and drivers/net
         * looks like this.
         *
         * It is nearly the same as the generally preferred comment
         * style,
         * but there is no initial almost-blank line.
         */

For hpsa, there are two types of comment sections in hpsa code,
I choose the first style for all comment sections;

Signed-off-by: James Wang <jnwang@linux.alibaba.com>
---
 drivers/scsi/hpsa.c | 199 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 68 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a47bcce..777eaf7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1202,7 +1202,8 @@ static inline int is_scsi_rev_5(struct ctlr_info *h)
 static int hpsa_find_target_lun(struct ctlr_info *h,
 	unsigned char scsi3addr[], int bus, int *target, int *lun)
 {
-	/* finds an unused bus, target, lun for a new physical device
+	/* 
+	 * finds an unused bus, target, lun for a new physical device
 	 * assumes h->devlock is held
 	 */
 	int i, found = 0;
@@ -1302,7 +1303,8 @@ static int hpsa_scsi_add_entry(struct ctlr_info *h,
 		/* Logical device, lun is already assigned. */
 		goto lun_assigned;
 
-	/* If this device a non-zero lun of a multi-lun device
+	/* 
+	 * If this device a non-zero lun of a multi-lun device
 	 * byte 4 of the 8-byte LUN addr will contain the logical
 	 * unit no, zero otherwise.
 	 */
@@ -1314,7 +1316,8 @@ static int hpsa_scsi_add_entry(struct ctlr_info *h,
 		goto lun_assigned;
 	}
 
-	/* This is a non-zero lun of a multi-lun device.
+	/* 
+	 * This is a non-zero lun of a multi-lun device.
 	 * Search through our list and find the device which
 	 * has the same 8 byte LUN address, excepting byte 4 and 5.
 	 * Assign the same bus and target for this new LUN.
@@ -1493,7 +1496,8 @@ static void fixup_botched_add(struct ctlr_info *h,
 static inline int device_is_the_same(struct hpsa_scsi_dev_t *dev1,
 	struct hpsa_scsi_dev_t *dev2)
 {
-	/* we compare everything except lun and target as these
+	/* 
+	 * we compare everything except lun and target as these
 	 * are not yet assigned.  Compare parts likely
 	 * to differ first
 	 */
@@ -1517,7 +1521,8 @@ static inline int device_is_the_same(struct hpsa_scsi_dev_t *dev1,
 static inline int device_updated(struct hpsa_scsi_dev_t *dev1,
 	struct hpsa_scsi_dev_t *dev2)
 {
-	/* Device attributes that can change, but don't mean
+	/* 
+	 * Device attributes that can change, but don't mean
 	 * that the device is a different device, nor that the OS
 	 * needs to be told anything about the change.
 	 */
@@ -1544,7 +1549,8 @@ static inline int device_updated(struct hpsa_scsi_dev_t *dev1,
 	return 0;
 }
 
-/* Find needle in haystack.  If exact match found, return DEVICE_SAME,
+/* 
+ * Find needle in haystack.  If exact match found, return DEVICE_SAME,
  * and return needle location in *index.  If scsi3addr matches, but not
  * vendor, model, serial num, etc. return DEVICE_CHANGED, and return needle
  * location in *index.
@@ -1920,7 +1926,8 @@ static void hpsa_remove_device(struct ctlr_info *h,
 static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 	struct hpsa_scsi_dev_t *sd[], int nsds)
 {
-	/* sd contains scsi3 addresses and devtypes, and inquiry
+	/* 
+	 * sd contains scsi3 addresses and devtypes, and inquiry
 	 * data.  This function takes what's in sd to be the current
 	 * reality and updates h->dev[] to reflect that reality.
 	 */
@@ -1953,7 +1960,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 
 	spin_lock_irqsave(&h->devlock, flags);
 
-	/* find any devices in h->dev[] that are not in
+	/* 
+	 * find any devices in h->dev[] that are not in
 	 * sd[] and remove them from h->dev[], and for any
 	 * devices which have changed, remove the old device
 	 * info and add the new device info.
@@ -1974,7 +1982,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 			changes++;
 			hpsa_scsi_replace_entry(h, i, sd[entry],
 				added, &nadded, removed, &nremoved);
-			/* Set it to NULL to prevent it from being freed
+			/* 
+			 * Set it to NULL to prevent it from being freed
 			 * at the bottom of hpsa_update_scsi_devices()
 			 */
 			sd[entry] = NULL;
@@ -1984,7 +1993,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 		i++;
 	}
 
-	/* Now, make sure every device listed in sd[] is also
+	/* 
+	 * Now, make sure every device listed in sd[] is also
 	 * listed in h->dev[], adding them if they aren't found
 	 */
 
@@ -1992,7 +2002,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 		if (!sd[i]) /* if already added above. */
 			continue;
 
-		/* Don't add devices which are NOT READY, FORMAT IN PROGRESS
+		/* 
+		 * Don't add devices which are NOT READY, FORMAT IN PROGRESS
 		 * as the SCSI mid-layer does not handle such devices well.
 		 * It relentlessly loops sending TUR at 3Hz, then READ(10)
 		 * at 160Hz, and prevents the system from coming up.
@@ -2036,7 +2047,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 
 	spin_unlock_irqrestore(&h->devlock, flags);
 
-	/* Monitor devices which are in one of several NOT READY states to be
+	/* 
+	 * Monitor devices which are in one of several NOT READY states to be
 	 * brought online later. This must be done without holding h->devlock,
 	 * so don't touch h->dev[]
 	 */
@@ -2047,7 +2059,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 			hpsa_monitor_offline_device(h, sd[i]->scsi3addr);
 	}
 
-	/* Don't notify scsi mid layer of any changes the first time through
+	/* 
+	 * Don't notify scsi mid layer of any changes the first time through
 	 * (or if there are no changes) scsi_scan_host will do it later the
 	 * first time through.
 	 */
@@ -2077,7 +2090,8 @@ static void adjust_hpsa_scsi_table(struct ctlr_info *h,
 			continue;
 		dev_warn(&h->pdev->dev,
 			"addition failed %d, device not added.", rc);
-		/* now we have to remove it from h->dev,
+		/* 
+		 * now we have to remove it from h->dev,
 		 * since it didn't get added to scsi mid layer
 		 */
 		fixup_botched_add(h, added[i]);
@@ -2336,7 +2350,8 @@ static void hpsa_unmap_sg_chain_block(struct ctlr_info *h,
 }
 
 
-/* Decode the various types of errors on ioaccel2 path.
+/* 
+ * Decode the various types of errors on ioaccel2 path.
  * Return 1 for any error that should generate a RAID path retry.
  * Return 0 for errors that don't require a RAID path retry.
  */
@@ -2638,7 +2653,8 @@ static void complete_scsi_command(struct CommandList *cp)
 	if (ei->CommandStatus == 0)
 		return hpsa_cmd_free_and_done(h, cp, cmd);
 
-	/* For I/O accelerator commands, copy over some fields to the normal
+	/* 
+	 * For I/O accelerator commands, copy over some fields to the normal
 	 * CISS header used below for error handling.
 	 */
 	if (cp->cmd_type == CMD_IOACCEL1) {
@@ -2651,7 +2667,8 @@ static void complete_scsi_command(struct CommandList *cp)
 		memcpy(cp->Header.LUN.LunAddrBytes, c->CISS_LUN, 8);
 		memcpy(cp->Request.CDB, c->CDB, cp->Request.CDBLen);
 
-		/* Any RAID offload error results in retry which will use
+		/* 
+		 * Any RAID offload error results in retry which will use
 		 * the normal I/O path so the controller can handle whatever's
 		 * wrong.
 		 */
@@ -2696,7 +2713,8 @@ static void complete_scsi_command(struct CommandList *cp)
 			}
 			break;
 		}
-		/* Problem was not a check condition
+		/* 
+		 * Problem was not a check condition
 		 * Pass it up to the upper layers...
 		 */
 		if (ei->ScsiStatus) {
@@ -2710,7 +2728,8 @@ static void complete_scsi_command(struct CommandList *cp)
 			dev_warn(&h->pdev->dev, "cp %p SCSI status was 0. "
 				"Returning no connection.\n", cp),
 
-			/* Ordinarily, this case should never happen,
+			/* 
+			 * Ordinarily, this case should never happen,
 			 * but there is a bug in some released firmware
 			 * revisions that allows it to happen if, for
 			 * example, a 4100 backplane loses power and
@@ -2735,12 +2754,14 @@ static void complete_scsi_command(struct CommandList *cp)
 	case CMD_INVALID: {
 		/* print_bytes(cp, sizeof(*cp), 1, 0);
 		print_cmd(cp); */
-		/* We get CMD_INVALID if you address a non-existent device
+		/* 
+		 * We get CMD_INVALID if you address a non-existent device
 		 * instead of a selection timeout (no response).  You will
 		 * see this if you yank out a drive, then try to access it.
 		 * This is kind of a shame because it means that any other
 		 * CMD_INVALID (e.g. driver bug) will get interpreted as a
-		 * missing target. */
+		 * missing target. 
+		 */
 		cmd->result = DID_NO_CONNECT << 16;
 	}
 		break;
@@ -2786,7 +2807,8 @@ static void complete_scsi_command(struct CommandList *cp)
 			cmd->result = DID_ERROR << 16;
 		break;
 	case CMD_IOACCEL_DISABLED:
-		/* This only handles the direct pass-through case since RAID
+		/* 
+		 * This only handles the direct pass-through case since RAID
 		 * offload is handled above.  Just attempt a retry.
 		 */
 		cmd->result = DID_SOFT_ERROR << 16;
@@ -2959,7 +2981,8 @@ static void hpsa_scsi_interpret_error(struct ctlr_info *h,
 		hpsa_print_cmd(h, "overrun condition", cp);
 		break;
 	case CMD_INVALID: {
-		/* controller unfortunately reports SCSI passthru's
+		/* 
+		 * controller unfortunately reports SCSI passthru's
 		 * to non-existent targets as invalid commands.
 		 */
 		hpsa_print_cmd(h, "invalid command", cp);
@@ -3135,9 +3158,11 @@ static bool hpsa_cmd_dev_match(struct ctlr_info *h, struct CommandList *c,
 			match = true;
 		} else {
 			/* Possible RAID mode -- check each phys dev. */
-			/* FIXME:  Do we need to take out a lock here?  If
+			/* 
+			 * FIXME:  Do we need to take out a lock here?  If
 			 * so, we could just call hpsa_get_pdisk_of_ioaccel2()
-			 * instead. */
+			 * instead.
+			 */
 			for (i = 0; i < dev->nphysical_disks && !match; i++) {
 				/* FIXME: an alternate test might be
 				 *
@@ -3870,7 +3895,8 @@ static int hpsa_get_volume_status(struct ctlr_info *h,
 	return HPSA_VPD_LV_STATUS_UNSUPPORTED;
 }
 
-/* Determine offline status of a volume.
+/* 
+ * Determine offline status of a volume.
  * Return either:
  *  0 (not offline)
  *  0xff (offline for unknown reasons)
@@ -4331,7 +4357,8 @@ static bool hpsa_skip_device(struct ctlr_info *h, u8 *lunaddrbytes,
 
 static void hpsa_update_scsi_devices(struct ctlr_info *h)
 {
-	/* the idea here is we could get notified
+	/* 
+	 * the idea here is we could get notified
 	 * that some devices have changed, so we do a report
 	 * physical luns and report logical luns cmd, and adjust
 	 * our list of devices accordingly.
@@ -4383,7 +4410,8 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 			__func__);
 	}
 
-	/* We might see up to the maximum number of logical and physical disks
+	/* 
+	 * We might see up to the maximum number of logical and physical disks
 	 * plus external target devices, and a device for the local RAID
 	 * controller.
 	 */
@@ -4482,7 +4510,8 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 
 		switch (this_device->devtype) {
 		case TYPE_ROM:
-			/* We don't *really* support actual CD-ROM devices,
+			/* 
+			 * We don't *really* support actual CD-ROM devices,
 			 * just "One Button Disaster Recovery" tape drive
 			 * which temporarily pretends to be a CD-ROM drive.
 			 * So we check that the device is really an OBDR tape
@@ -4517,7 +4546,8 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 			ncurrent++;
 			break;
 		case TYPE_RAID:
-			/* Only present the Smartarray HBA as a RAID controller.
+			/* 
+			 * Only present the Smartarray HBA as a RAID controller.
 			 * If it's a RAID controller other than the HBA itself
 			 * (an external RAID controller, MSA500 or similar)
 			 * don't present it.
@@ -4863,7 +4893,8 @@ static void set_encrypt_ioaccel2(struct ctlr_info *h,
 	/* Set the encryption enable flag, encoded into direction field. */
 	cp->direction |= IOACCEL2_DIRECTION_ENCRYPT_MASK;
 
-	/* Set encryption tweak values based on logical block address
+	/* 
+	 * Set encryption tweak values based on logical block address
 	 * If block size is 512, tweak value is LBA.
 	 * For other block sizes, tweak is (LBA * block size)/ 512)
 	 */
@@ -5257,7 +5288,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 	case HPSA_RAID_0:
 		break; /* nothing special to do */
 	case HPSA_RAID_1:
-		/* Handles load balance across RAID 1 members.
+		/* 
+		 * Handles load balance across RAID 1 members.
 		 * (2-drive R1 and R10 with even # of drives.)
 		 * Appropriate for SSDs, not optimal for HDDs
 		 * Ensure we have the correct raid_map.
@@ -5271,7 +5303,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		dev->offload_to_mirror = !dev->offload_to_mirror;
 		break;
 	case HPSA_RAID_ADM:
-		/* Handles N-way mirrors  (R1-ADM)
+		/* 
+		 * Handles N-way mirrors  (R1-ADM)
 		 * and R10 with # of drives divisible by 3.)
 		 * Ensure we have the correct raid_map.
 		 */
@@ -5289,7 +5322,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 			le16_to_cpu(map->layout_map_count) - 1)
 			? 0 : offload_to_mirror + 1;
 		dev->offload_to_mirror = offload_to_mirror;
-		/* Avoid direct use of dev->offload_to_mirror within this
+		/* 
+		 * Avoid direct use of dev->offload_to_mirror within this
 		 * function since multiple threads might simultaneously
 		 * increment it beyond the range of dev->layout_map_count -1.
 		 */
@@ -5484,14 +5518,16 @@ static int hpsa_ciss_submit(struct ctlr_info *h,
 			TYPE_ATTR_DIR(TYPE_CMD, ATTR_SIMPLE, XFER_NONE);
 		break;
 	case DMA_BIDIRECTIONAL:
-		/* This can happen if a buggy application does a scsi passthru
+		/* 
+		 * This can happen if a buggy application does a scsi passthru
 		 * and sets both inlen and outlen to non-zero. ( see
 		 * ../scsi/scsi_ioctl.c:scsi_ioctl_send_command() )
 		 */
 
 		c->Request.type_attr_dir =
 			TYPE_ATTR_DIR(TYPE_CMD, ATTR_SIMPLE, XFER_RSVD);
-		/* This is technically wrong, and hpsa controllers should
+		/* 
+		 * This is technically wrong, and hpsa controllers should
 		 * reject it with CMD_INVALID, which is the most correct
 		 * response, but non-fibre backends appear to let it
 		 * slide by, and give the same results as if this field
@@ -5788,7 +5824,8 @@ static void hpsa_scan_start(struct Scsi_Host *sh)
 		h->scan_waiting = 1;
 		spin_unlock_irqrestore(&h->scan_lock, flags);
 		wait_event(h->scan_wait_queue, h->scan_finished);
-		/* Note: We don't need to worry about a race between this
+		/* 
+		 * Note: We don't need to worry about a race between this
 		 * thread and driver unload because the midlayer will
 		 * have incremented the reference count, so unload won't
 		 * happen if we're in here.
@@ -6018,7 +6055,8 @@ static int wait_for_device_to_become_ready(struct ctlr_info *h,
 	return rc;
 }
 
-/* Need at least one of these error handlers to keep ../scsi/hosts.c from
+/* 
+ * Need at least one of these error handlers to keep ../scsi/hosts.c from
  * complaining.  Doing a host- or bus-reset can't do anything good here.
  */
 static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
@@ -6140,7 +6178,8 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 	if (idx < HPSA_NRESERVED_CMDS || idx >= h->nr_cmds) {
 		dev_err(&h->pdev->dev, "Bad block tag: %d not in [%d..%d]\n",
 			idx, HPSA_NRESERVED_CMDS, h->nr_cmds - 1);
-		/* The index value comes from the block layer, so if it's out of
+		/* 
+		 * The index value comes from the block layer, so if it's out of
 		 * bounds, it's probably not our bug.
 		 */
 		BUG();
@@ -6688,7 +6727,8 @@ static void hpsa_send_host_reset(struct ctlr_info *h, u8 reset_type)
 	c->Request.CDB[1] = reset_type; /* fill_cmd defaults to target reset */
 	c->waiting = NULL;
 	enqueue_cmd_and_start_io(h, c);
-	/* Don't wait for completion, the reset won't complete.  Don't free
+	/* 
+	 * Don't wait for completion, the reset won't complete.  Don't free
 	 * the command either.  This is the last command we will send before
 	 * re-initializing everything, so it doesn't matter and won't leak.
 	 */
@@ -6984,7 +7024,8 @@ static inline void process_indexed_cmd(struct ctlr_info *h,
 	}
 }
 
-/* Some controllers, like p400, will give us one interrupt
+/* 
+ * Some controllers, like p400, will give us one interrupt
  * after a soft reset, even if we turned interrupts off.
  * Only need to check for this in the hpsa_xxx_discard_completions
  * functions.
@@ -7083,7 +7124,8 @@ static irqreturn_t do_hpsa_intr_msi(int irq, void *queue)
 	return IRQ_HANDLED;
 }
 
-/* Send a message CDB to the firmware. Careful, this only works
+/* 
+ * Send a message CDB to the firmware. Careful, this only works
  * in simple mode, not performant mode due to the tag lookup.
  * We only ever use this immediately after a controller reset.
  */
@@ -7108,7 +7150,8 @@ static int hpsa_message(struct pci_dev *pdev, unsigned char opcode,
 	if (vaddr == NULL)
 		return -ENOMEM;
 
-	/* The Inbound Post Queue only accepts 32-bit physical addresses for the
+	/* 
+	 * The Inbound Post Queue only accepts 32-bit physical addresses for the
 	 * CCISS commands, so they must be allocated from the lower 4GiB of
 	 * memory.
 	 */
@@ -7124,7 +7167,8 @@ static int hpsa_message(struct pci_dev *pdev, unsigned char opcode,
 		return -ENOMEM;
 	}
 
-	/* This must fit, because of the 32-bit consistent DMA mask.  Also,
+	/* 
+	 * This must fit, because of the 32-bit consistent DMA mask.  Also,
 	 * although there's no guarantee, we assume that the address is at
 	 * least 4-byte aligned (most likely, it's page-aligned).
 	 */
@@ -7158,7 +7202,8 @@ static int hpsa_message(struct pci_dev *pdev, unsigned char opcode,
 
 	iounmap(vaddr);
 
-	/* we leak the DMA buffer here ... no choice since the controller could
+	/* 
+	 * we leak the DMA buffer here ... no choice since the controller could
 	 *  still complete the command.
 	 */
 	if (i == HPSA_MSG_SEND_RETRY_LIMIT) {
@@ -7187,14 +7232,16 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
 {
 
 	if (use_doorbell) {
-		/* For everything after the P600, the PCI power state method
+		/* 
+		 * For everything after the P600, the PCI power state method
 		 * of resetting the controller doesn't work, so we have this
 		 * other way using the doorbell register.
 		 */
 		dev_info(&pdev->dev, "using doorbell to reset controller\n");
 		writel(use_doorbell, vaddr + SA5_DOORBELL);
 
-		/* PMC hardware guys tell us we need a 10 second delay after
+		/* 
+		 * PMC hardware guys tell us we need a 10 second delay after
 		 * doorbell reset and before any attempt to talk to the board
 		 * at all to ensure that this actually works and doesn't fall
 		 * over in some weird corner cases.
@@ -7202,13 +7249,15 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
 		msleep(10000);
 	} else { /* Try to do it the PCI power state way */
 
-		/* Quoting from the Open CISS Specification: "The Power
+		/* 
+		 * Quoting from the Open CISS Specification: "The Power
 		 * Management Control/Status Register (CSR) controls the power
 		 * state of the device.  The normal operating state is D0,
 		 * CSR=00h.  The software off state is D3, CSR=03h.  To reset
 		 * the controller, place the interface device in D3 then to D0,
 		 * this causes a secondary PCI reset which will reset the
-		 * controller." */
+		 * controller." 
+		 */
 
 		int rc = 0;
 
@@ -7278,7 +7327,8 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
 		return -ENOMEM;
 	driver_ver = old_driver_ver + size;
 
-	/* After a reset, the 32 bytes of "driver version" in the cfgtable
+	/* 
+	 * After a reset, the 32 bytes of "driver version" in the cfgtable
 	 * should have been changed, otherwise we know the reset failed.
 	 */
 	init_driver_version(old_driver_ver, size);
@@ -7287,7 +7337,8 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
 	kfree(old_driver_ver);
 	return rc;
 }
-/* This does a hard reset of the controller using PCI power management
+/* 
+ * This does a hard reset of the controller using PCI power management
  * states or the using the doorbell register.
  */
 static int hpsa_kdump_hard_reset_controller(struct pci_dev *pdev, u32 board_id)
@@ -7303,7 +7354,8 @@ static int hpsa_kdump_hard_reset_controller(struct pci_dev *pdev, u32 board_id)
 	u32 use_doorbell;
 	u16 command_register;
 
-	/* For controllers as old as the P600, this is very nearly
+	/* 
+	 * For controllers as old as the P600, this is very nearly
 	 * the same thing as
 	 *
 	 * pci_save_state(pci_dev);
@@ -7352,7 +7404,8 @@ static int hpsa_kdump_hard_reset_controller(struct pci_dev *pdev, u32 board_id)
 	if (rc)
 		goto unmap_cfgtable;
 
-	/* If reset via doorbell register is supported, use that.
+	/* 
+	 * If reset via doorbell register is supported, use that.
 	 * There are two such methods.  Favor the newest method.
 	 */
 	misc_fw_support = readl(&cfgtable->misc_fw_support);
@@ -7376,8 +7429,10 @@ static int hpsa_kdump_hard_reset_controller(struct pci_dev *pdev, u32 board_id)
 	pci_restore_state(pdev);
 	pci_write_config_word(pdev, 4, command_register);
 
-	/* Some devices (notably the HP Smart Array 5i Controller)
-	   need a little pause here */
+	/* 
+	 * Some devices (notably the HP Smart Array 5i Controller) 
+	 * need a little pause here 
+	 */
 	msleep(HPSA_POST_RESET_PAUSE_MSECS);
 
 	rc = hpsa_wait_for_board_state(pdev, vaddr, BOARD_READY);
@@ -7407,9 +7462,9 @@ static int hpsa_kdump_hard_reset_controller(struct pci_dev *pdev, u32 board_id)
 }
 
 /*
- *  We cannot read the structure directly, for portability we must use
- *   the io functions.
- *   This is for debug only.
+ * We cannot read the structure directly, for portability we must use
+ *  the io functions.
+ *  This is for debug only.
  */
 static void print_cfg_table(struct device *dev, struct CfgTable __iomem *tb)
 {
@@ -7506,7 +7561,8 @@ static void hpsa_setup_reply_map(struct ctlr_info *h)
 		h->reply_map[cpu] = 0;
 }
 
-/* If MSI/MSI-X is supported by the kernel we will try to enable it on
+/* 
+ * If MSI/MSI-X is supported by the kernel we will try to enable it on
  * controllers that are capable. If not, we use legacy INTx mode.
  */
 static int hpsa_interrupt_mode(struct ctlr_info *h)
@@ -7640,9 +7696,10 @@ static void hpsa_free_cfgtables(struct ctlr_info *h)
 	}
 }
 
-/* Find and map CISS config table and transfer table
-+ * several items must be unmapped (freed) later
-+ * */
+/* 
+ * Find and map CISS config table and transfer table
+ * several items must be unmapped (freed) later.
+ */
 static int hpsa_find_cfgtables(struct ctlr_info *h)
 {
 	u64 cfg_offset;
@@ -7697,7 +7754,8 @@ static void hpsa_get_max_perf_mode_cmds(struct ctlr_info *h)
 	}
 }
 
-/* If the controller reports that the total max sg entries is greater than 512,
+/* 
+ * If the controller reports that the total max sg entries is greater than 512,
  * then we know that chained SG blocks work.  (Original smart arrays did not
  * support chained SG blocks and would return zero for max sg entries.)
  */
@@ -7706,7 +7764,8 @@ static int hpsa_supports_chained_sg_blocks(struct ctlr_info *h)
 	return h->maxsgentries > 512;
 }
 
-/* Interrogate the hardware for some limits:
+/* 
+ * Interrogate the hardware for some limits:
  * max commands, max SG elements without chaining, and with chaining,
  * SG chain block size, etc.
  */
@@ -7764,7 +7823,8 @@ static inline void hpsa_set_driver_support_bits(struct ctlr_info *h)
 	writel(driver_support, &(h->cfgtable->driver_support));
 }
 
-/* Disable DMA prefetch for the P600.  Otherwise an ASIC bug may result
+/* 
+ * Disable DMA prefetch for the P600.  Otherwise an ASIC bug may result
  * in a prefetch beyond physical memory.
  */
 static inline void hpsa_p600_dma_prefetch_quirk(struct ctlr_info *h)
@@ -7804,7 +7864,8 @@ static int hpsa_wait_for_mode_change_ack(struct ctlr_info *h)
 	u32 doorbell_value;
 	unsigned long flags;
 
-	/* under certain very rare conditions, this can take awhile.
+	/* 
+	 * under certain very rare conditions, this can take awhile.
 	 * (e.g.: hot replace a failed 144GB drive in a RAID 5 set right
 	 * as we enter this code.)
 	 */
@@ -7974,7 +8035,8 @@ static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 	if (!reset_devices)
 		return 0;
 
-	/* kdump kernel is loading, we don't know in which state is
+	/* 
+	 * kdump kernel is loading, we don't know in which state is
 	 * the pci interface. The dev->enable_cnt is equal zero
 	 * so we call enable+disable, wait a while and switch it on.
 	 */
@@ -8004,7 +8066,8 @@ static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 	/* Reset the controller with a PCI power-cycle or via doorbell */
 	rc = hpsa_kdump_hard_reset_controller(pdev, board_id);
 
-	/* -ENOTSUPP here means we cannot reset the controller
+	/* 
+	 * -ENOTSUPP here means we cannot reset the controller
 	 * but it's already (and still) up and running in
 	 * "performant mode".  Or, it might be 640x, which can't reset
 	 * due to concerns about shared bbwc between 6402/6404 pair.
-- 
1.8.3.1

