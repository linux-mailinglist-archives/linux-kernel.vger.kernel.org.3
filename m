Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612AD49E5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiA0PUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:20:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232640AbiA0PUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643296801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aTVuuEUXWX1mErLczilmbh9fu3jq5oQx7nKs6UX8+IQ=;
        b=bHTrNNXj1wFxCpOict4KFoZOyB80UAvWrdBB7JCHgjaur0hrrLPYOSBwJiYXzhYy486cTe
        V/oRPkv01cygbZ4kyoPq5OiZf76xLwrRZZrufVIZt7+lujDj7XgmVxF3aSmsoNBl4HoiZA
        M1PO4QSlLuAdcDWu+tjwOOktRvMK7H4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-R49oeXXsPemcYPCwNi9vvQ-1; Thu, 27 Jan 2022 10:19:59 -0500
X-MC-Unique: R49oeXXsPemcYPCwNi9vvQ-1
Received: by mail-ot1-f71.google.com with SMTP id h36-20020a9d2f27000000b0059e33f1f8a0so1694255otb.19
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTVuuEUXWX1mErLczilmbh9fu3jq5oQx7nKs6UX8+IQ=;
        b=oP39+HGNEDUhDCLkeAk7Nsq/bM5Y1uiUtnLqdPjGyb5pTLXAMkWl9QCwdTVgv3hkk0
         wgL2HOeEOtV3X4VQwLEO4aLk/c/9Up3rInT6ASmaCrGi8/fj53Hyh1c89we3siRUyp2k
         2zOR5U7FEDYHiNdtZbVcbuftX6ONocUGFgw8zVp6RxGbfAD6d/oU2/IB3BaNM5tBk+ew
         8oEihaiBAxGJ1MoZTBpNN3YH3z/CeL8AeqR3dGEjLx6c2HkPv79qh3xhbs6nP4PZOR2D
         755KKfmlMJXmgE6vfdugSfZvKhHyRT2XZKd7yzS1XxDwenl1HudAyfmPYgIJentPGNuG
         SKZA==
X-Gm-Message-State: AOAM5302f949e/auMZVF8jchTZF1Mbc+Kvp/OnhluK01iVWsY2GcMXGz
        z61KljOWZJIJ7Y/jZEf/NAbQdARZ6ZcS8y7R6lvjFUYZttNcC+eCQ3knQumrjb1mgIW1oKEbSzx
        K26C9eJ3Gn2gLxKlkEMHE4SCI
X-Received: by 2002:a54:410e:: with SMTP id l14mr835832oic.334.1643296796397;
        Thu, 27 Jan 2022 07:19:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlWrri5bJGCf9QjIVTTazaWB+g26yGYh9d1OGlVH/nnhDt+i7dSO424xji46haf1naUtAYhw==
X-Received: by 2002:a54:410e:: with SMTP id l14mr835783oic.334.1643296795293;
        Thu, 27 Jan 2022 07:19:55 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o12sm9229299ooi.18.2022.01.27.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:19:54 -0800 (PST)
From:   trix@redhat.com
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: megaraid: cleanup formatting of megaraid
Date:   Thu, 27 Jan 2022 07:19:45 -0800
Message-Id: <20220127151945.1244439-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch reports several hundred formatting errors.
Run these files through clang-format and knock off
some of them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/megaraid.c | 2026 ++++++++++++++++++---------------------
 drivers/scsi/megaraid.h |  988 ++++++++++---------
 2 files changed, 1417 insertions(+), 1597 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index bf987f3a7f3f2..d8823ec3b6635 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -53,29 +53,34 @@
 
 #define MEGARAID_MODULE_VERSION "2.00.4"
 
-MODULE_AUTHOR ("sju@lsil.com");
-MODULE_DESCRIPTION ("LSI Logic MegaRAID legacy driver");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("sju@lsil.com");
+MODULE_DESCRIPTION("LSI Logic MegaRAID legacy driver");
+MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGARAID_MODULE_VERSION);
 
 static DEFINE_MUTEX(megadev_mutex);
 static unsigned int max_cmd_per_lun = DEF_CMD_PER_LUN;
 module_param(max_cmd_per_lun, uint, 0);
-MODULE_PARM_DESC(max_cmd_per_lun, "Maximum number of commands which can be issued to a single LUN (default=DEF_CMD_PER_LUN=63)");
+MODULE_PARM_DESC(
+	max_cmd_per_lun,
+	"Maximum number of commands which can be issued to a single LUN (default=DEF_CMD_PER_LUN=63)");
 
 static unsigned short int max_sectors_per_io = MAX_SECTORS_PER_IO;
 module_param(max_sectors_per_io, ushort, 0);
-MODULE_PARM_DESC(max_sectors_per_io, "Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
-
+MODULE_PARM_DESC(
+	max_sectors_per_io,
+	"Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
 
 static unsigned short int max_mbox_busy_wait = MBOX_BUSY_WAIT;
 module_param(max_mbox_busy_wait, ushort, 0);
-MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
+MODULE_PARM_DESC(
+	max_mbox_busy_wait,
+	"Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
 
-#define RDINDOOR(adapter)	readl((adapter)->mmio_base + 0x20)
-#define RDOUTDOOR(adapter)	readl((adapter)->mmio_base + 0x2C)
-#define WRINDOOR(adapter,value)	 writel(value, (adapter)->mmio_base + 0x20)
-#define WROUTDOOR(adapter,value) writel(value, (adapter)->mmio_base + 0x2C)
+#define RDINDOOR(adapter) readl((adapter)->mmio_base + 0x20)
+#define RDOUTDOOR(adapter) readl((adapter)->mmio_base + 0x2C)
+#define WRINDOOR(adapter, value) writel(value, (adapter)->mmio_base + 0x20)
+#define WROUTDOOR(adapter, value) writel(value, (adapter)->mmio_base + 0x2C)
 
 /*
  * Global variables
@@ -88,17 +93,17 @@ static struct proc_dir_entry *mega_proc_dir_entry;
 /* For controller re-ordering */
 static struct mega_hbas mega_hbas[MAX_CONTROLLERS];
 
-static long
-megadev_unlocked_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+static long megadev_unlocked_ioctl(struct file *filep, unsigned int cmd,
+				   unsigned long arg);
 
 /*
  * The File Operations structure for the serial/ioctl interface of the driver
  */
 static const struct file_operations megadev_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= megadev_unlocked_ioctl,
-	.open		= megadev_open,
-	.llseek		= noop_llseek,
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = megadev_unlocked_ioctl,
+	.open = megadev_open,
+	.llseek = noop_llseek,
 };
 
 /*
@@ -114,8 +119,7 @@ static u32 driver_ver = 0x02000000;
 /* major number used by the device for character interface */
 static int major;
 
-#define IS_RAID_CH(hba, ch)	(((hba)->mega_ch_class >> (ch)) & 0x01)
-
+#define IS_RAID_CH(hba, ch) (((hba)->mega_ch_class >> (ch)) & 0x01)
 
 /*
  * Debug variable to print some diagnostic messages
@@ -128,22 +132,21 @@ static int trace_level;
  *
  * Allocates a 8 byte aligned memory for the handshake mailbox.
  */
-static int
-mega_setup_mailbox(adapter_t *adapter)
+static int mega_setup_mailbox(adapter_t *adapter)
 {
-	unsigned long	align;
+	unsigned long align;
 
-	adapter->una_mbox64 = dma_alloc_coherent(&adapter->dev->dev,
-						 sizeof(mbox64_t),
-						 &adapter->una_mbox64_dma,
-						 GFP_KERNEL);
+	adapter->una_mbox64 =
+		dma_alloc_coherent(&adapter->dev->dev, sizeof(mbox64_t),
+				   &adapter->una_mbox64_dma, GFP_KERNEL);
+
+	if (!adapter->una_mbox64)
+		return -1;
 
-	if( !adapter->una_mbox64 ) return -1;
-		
 	adapter->mbox = &adapter->una_mbox64->mbox;
 
-	adapter->mbox = (mbox_t *)((((unsigned long) adapter->mbox) + 15) &
-			(~0UL ^ 0xFUL));
+	adapter->mbox = (mbox_t *)((((unsigned long)adapter->mbox) + 15) &
+				   (~0UL ^ 0xFUL));
 
 	adapter->mbox64 = (mbox64_t *)(((unsigned long)adapter->mbox) - 8);
 
@@ -154,22 +157,21 @@ mega_setup_mailbox(adapter_t *adapter)
 	/*
 	 * Register the mailbox if the controller is an io-mapped controller
 	 */
-	if( adapter->flag & BOARD_IOMAP ) {
-
+	if (adapter->flag & BOARD_IOMAP) {
 		outb(adapter->mbox_dma & 0xFF,
-				adapter->host->io_port + MBOX_PORT0);
+		     adapter->host->io_port + MBOX_PORT0);
 
 		outb((adapter->mbox_dma >> 8) & 0xFF,
-				adapter->host->io_port + MBOX_PORT1);
+		     adapter->host->io_port + MBOX_PORT1);
 
 		outb((adapter->mbox_dma >> 16) & 0xFF,
-				adapter->host->io_port + MBOX_PORT2);
+		     adapter->host->io_port + MBOX_PORT2);
 
 		outb((adapter->mbox_dma >> 24) & 0xFF,
-				adapter->host->io_port + MBOX_PORT3);
+		     adapter->host->io_port + MBOX_PORT3);
 
 		outb(ENABLE_MBOX_BYTE,
-				adapter->host->io_port + ENABLE_MBOX_REGION);
+		     adapter->host->io_port + ENABLE_MBOX_REGION);
 
 		irq_ack(adapter);
 
@@ -179,7 +181,6 @@ mega_setup_mailbox(adapter_t *adapter)
 	return 0;
 }
 
-
 /*
  * mega_query_adapter()
  * @adapter - pointer to our soft state
@@ -187,14 +188,13 @@ mega_setup_mailbox(adapter_t *adapter)
  * Issue the adapter inquiry commands to the controller and find out
  * information and parameter about the devices attached
  */
-static int
-mega_query_adapter(adapter_t *adapter)
+static int mega_query_adapter(adapter_t *adapter)
 {
-	dma_addr_t	prod_info_dma_handle;
-	mega_inquiry3	*inquiry3;
-	struct mbox_out	mbox;
-	u8	*raw_mbox = (u8 *)&mbox;
-	int	retval;
+	dma_addr_t prod_info_dma_handle;
+	mega_inquiry3 *inquiry3;
+	struct mbox_out mbox;
+	u8 *raw_mbox = (u8 *)&mbox;
+	int retval;
 
 	/* Initialize adapter inquiry mailbox */
 
@@ -210,23 +210,24 @@ mega_query_adapter(adapter_t *adapter)
 
 	inquiry3 = (mega_inquiry3 *)adapter->mega_buffer;
 
-	raw_mbox[0] = FC_NEW_CONFIG;		/* i.e. mbox->cmd=0xA1 */
-	raw_mbox[2] = NC_SUBOP_ENQUIRY3;	/* i.e. 0x0F */
-	raw_mbox[3] = ENQ3_GET_SOLICITED_FULL;	/* i.e. 0x02 */
+	raw_mbox[0] = FC_NEW_CONFIG; /* i.e. mbox->cmd=0xA1 */
+	raw_mbox[2] = NC_SUBOP_ENQUIRY3; /* i.e. 0x0F */
+	raw_mbox[3] = ENQ3_GET_SOLICITED_FULL; /* i.e. 0x02 */
 
 	/* Issue a blocking command to the card */
 	if ((retval = issue_scb_block(adapter, raw_mbox))) {
 		/* the adapter does not support 40ld */
 
-		mraid_ext_inquiry	*ext_inq;
-		mraid_inquiry		*inq;
-		dma_addr_t		dma_handle;
+		mraid_ext_inquiry *ext_inq;
+		mraid_inquiry *inq;
+		dma_addr_t dma_handle;
 
 		ext_inq = dma_alloc_coherent(&adapter->dev->dev,
 					     sizeof(mraid_ext_inquiry),
 					     &dma_handle, GFP_KERNEL);
 
-		if( ext_inq == NULL ) return -1;
+		if (ext_inq == NULL)
+			return -1;
 
 		inq = &ext_inq->raid_inq;
 
@@ -242,48 +243,45 @@ mega_query_adapter(adapter_t *adapter)
 		 * mraid_inquiry structure
 		 */
 		mega_8_to_40ld(inq, inquiry3,
-				(mega_product_info *)&adapter->product_info);
+			       (mega_product_info *)&adapter->product_info);
 
-		dma_free_coherent(&adapter->dev->dev,
-				  sizeof(mraid_ext_inquiry), ext_inq,
-				  dma_handle);
+		dma_free_coherent(&adapter->dev->dev, sizeof(mraid_ext_inquiry),
+				  ext_inq, dma_handle);
 
-	} else {		/*adapter supports 40ld */
+	} else { /*adapter supports 40ld */
 		adapter->flag |= BOARD_40LD;
 
 		/*
 		 * get product_info, which is static information and will be
 		 * unchanged
 		 */
-		prod_info_dma_handle = dma_map_single(&adapter->dev->dev,
-						      (void *)&adapter->product_info,
-						      sizeof(mega_product_info),
-						      DMA_FROM_DEVICE);
+		prod_info_dma_handle = dma_map_single(
+			&adapter->dev->dev, (void *)&adapter->product_info,
+			sizeof(mega_product_info), DMA_FROM_DEVICE);
 
 		mbox.xferaddr = prod_info_dma_handle;
 
-		raw_mbox[0] = FC_NEW_CONFIG;	/* i.e. mbox->cmd=0xA1 */
-		raw_mbox[2] = NC_SUBOP_PRODUCT_INFO;	/* i.e. 0x0E */
+		raw_mbox[0] = FC_NEW_CONFIG; /* i.e. mbox->cmd=0xA1 */
+		raw_mbox[2] = NC_SUBOP_PRODUCT_INFO; /* i.e. 0x0E */
 
 		if ((retval = issue_scb_block(adapter, raw_mbox)))
 			dev_warn(&adapter->dev->dev,
-				"Product_info cmd failed with error: %d\n",
-				retval);
+				 "Product_info cmd failed with error: %d\n",
+				 retval);
 
 		dma_unmap_single(&adapter->dev->dev, prod_info_dma_handle,
 				 sizeof(mega_product_info), DMA_FROM_DEVICE);
 	}
 
-
 	/*
 	 * kernel scans the channels from 0 to <= max_channel
 	 */
 	adapter->host->max_channel =
-		adapter->product_info.nchannels + NVIRT_CHAN -1;
+		adapter->product_info.nchannels + NVIRT_CHAN - 1;
 
-	adapter->host->max_id = 16;	/* max targets per channel */
+	adapter->host->max_id = 16; /* max targets per channel */
 
-	adapter->host->max_lun = 7;	/* Up to 7 luns for non disk devices */
+	adapter->host->max_lun = 7; /* Up to 7 luns for non disk devices */
 
 	adapter->host->cmd_per_lun = max_cmd_per_lun;
 
@@ -291,7 +289,7 @@ mega_query_adapter(adapter_t *adapter)
 
 	adapter->max_cmds = adapter->product_info.max_commands;
 
-	if(adapter->max_cmds > MAX_COMMANDS)
+	if (adapter->max_cmds > MAX_COMMANDS)
 		adapter->max_cmds = MAX_COMMANDS;
 
 	adapter->host->can_queue = adapter->max_cmds - 1;
@@ -310,32 +308,27 @@ mega_query_adapter(adapter_t *adapter)
 	   sparse warnings. */
 	if (adapter->product_info.subsysvid == PCI_VENDOR_ID_HP) {
 		snprintf(adapter->fw_version, sizeof(adapter->fw_version),
-			 "%c%d%d.%d%d",
-			 adapter->product_info.fw_version[2],
-			 0,
-			 adapter->product_info.fw_version[1] & 0x0f,
-			 0,
+			 "%c%d%d.%d%d", adapter->product_info.fw_version[2], 0,
+			 adapter->product_info.fw_version[1] & 0x0f, 0,
 			 adapter->product_info.fw_version[0] & 0x0f);
 		snprintf(adapter->bios_version, sizeof(adapter->fw_version),
-			 "%c%d%d.%d%d",
-			 adapter->product_info.bios_version[2],
-			 0,
-			 adapter->product_info.bios_version[1] & 0x0f,
-			 0,
+			 "%c%d%d.%d%d", adapter->product_info.bios_version[2],
+			 0, adapter->product_info.bios_version[1] & 0x0f, 0,
 			 adapter->product_info.bios_version[0] & 0x0f);
 	} else {
 		memcpy(adapter->fw_version,
-				(char *)adapter->product_info.fw_version, 4);
+		       (char *)adapter->product_info.fw_version, 4);
 		adapter->fw_version[4] = 0;
 
 		memcpy(adapter->bios_version,
-				(char *)adapter->product_info.bios_version, 4);
+		       (char *)adapter->product_info.bios_version, 4);
 
 		adapter->bios_version[4] = 0;
 	}
 
 	dev_notice(&adapter->dev->dev, "[%s:%s] detected %d logical drives\n",
-		adapter->fw_version, adapter->bios_version, adapter->numldrv);
+		   adapter->fw_version, adapter->bios_version,
+		   adapter->numldrv);
 
 	/*
 	 * Do we support extended (>10 bytes) cdbs
@@ -344,7 +337,6 @@ mega_query_adapter(adapter_t *adapter)
 	if (adapter->support_ext_cdb)
 		dev_notice(&adapter->dev->dev, "supports extended CDBs\n");
 
-
 	return 0;
 }
 
@@ -354,10 +346,9 @@ mega_query_adapter(adapter_t *adapter)
  *
  * Runs through the list of pending requests.
  */
-static inline void
-mega_runpendq(adapter_t *adapter)
+static inline void mega_runpendq(adapter_t *adapter)
 {
-	if(!list_empty(&adapter->pending_list))
+	if (!list_empty(&adapter->pending_list))
 		__mega_runpendq(adapter);
 }
 
@@ -370,9 +361,9 @@ mega_runpendq(adapter_t *adapter)
  */
 static int megaraid_queue_lck(struct scsi_cmnd *scmd)
 {
-	adapter_t	*adapter;
-	scb_t	*scb;
-	int	busy=0;
+	adapter_t *adapter;
+	scb_t *scb;
+	int busy = 0;
 	unsigned long flags;
 
 	adapter = (adapter_t *)scmd->device->host->hostdata;
@@ -403,14 +394,14 @@ static int megaraid_queue_lck(struct scsi_cmnd *scmd)
 		mega_runpendq(adapter);
 
 	busy = 0;
- out:
+out:
 	spin_unlock_irqrestore(&adapter->lock, flags);
 	return busy;
 }
 
 static DEF_SCSI_QCMD(megaraid_queue)
 
-/**
+	/**
  * mega_allocate_scb()
  * @adapter: pointer to our soft state
  * @cmd: scsi command from the mid-layer
@@ -418,15 +409,14 @@ static DEF_SCSI_QCMD(megaraid_queue)
  * Allocate a SCB structure. This is the central structure for controller
  * commands.
  */
-static inline scb_t *
-mega_allocate_scb(adapter_t *adapter, struct scsi_cmnd *cmd)
+	static inline scb_t *mega_allocate_scb(adapter_t *adapter,
+					       struct scsi_cmnd *cmd)
 {
 	struct list_head *head = &adapter->free_list;
-	scb_t	*scb;
+	scb_t *scb;
 
 	/* Unlink command from Free List */
-	if( !list_empty(head) ) {
-
+	if (!list_empty(head)) {
 		scb = list_entry(head->next, scb_t, list);
 
 		list_del_init(head->next);
@@ -450,29 +440,27 @@ mega_allocate_scb(adapter_t *adapter, struct scsi_cmnd *cmd)
  * Calculate the logical drive number based on the information in scsi command
  * and the channel number.
  */
-static inline int
-mega_get_ldrv_num(adapter_t *adapter, struct scsi_cmnd *cmd, int channel)
+static inline int mega_get_ldrv_num(adapter_t *adapter, struct scsi_cmnd *cmd,
+				    int channel)
 {
-	int		tgt;
-	int		ldrv_num;
+	int tgt;
+	int ldrv_num;
 
 	tgt = cmd->device->id;
-	
-	if ( tgt > adapter->this_id )
-		tgt--;	/* we do not get inquires for initiator id */
 
-	ldrv_num = (channel * 15) + tgt;
+	if (tgt > adapter->this_id)
+		tgt--; /* we do not get inquires for initiator id */
 
+	ldrv_num = (channel * 15) + tgt;
 
 	/*
 	 * If we have a logical drive with boot enabled, project it first
 	 */
-	if( adapter->boot_ldrv_enabled ) {
-		if( ldrv_num == 0 ) {
+	if (adapter->boot_ldrv_enabled) {
+		if (ldrv_num == 0) {
 			ldrv_num = adapter->boot_ldrv;
-		}
-		else {
-			if( ldrv_num <= adapter->boot_ldrv ) {
+		} else {
+			if (ldrv_num <= adapter->boot_ldrv) {
 				ldrv_num--;
 			}
 		}
@@ -488,7 +476,7 @@ mega_get_ldrv_num(adapter_t *adapter, struct scsi_cmnd *cmd, int channel)
 	 * These is valid only for IO commands.
 	 */
 
-	if (adapter->support_random_del && adapter->read_ldidmap )
+	if (adapter->support_random_del && adapter->read_ldidmap)
 		switch (cmd->cmnd[0]) {
 		case READ_6:
 		case WRITE_6:
@@ -513,18 +501,18 @@ mega_get_ldrv_num(adapter_t *adapter, struct scsi_cmnd *cmd, int channel)
  * We also re-order the logical drives and physical devices based on their
  * boot settings.
  */
-static scb_t *
-mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
+static scb_t *mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd,
+			     int *busy)
 {
-	mega_passthru	*pthru;
-	scb_t	*scb;
-	mbox_t	*mbox;
-	u32	seg;
-	char	islogical;
-	int	max_ldrv_num;
-	int	channel = 0;
-	int	target = 0;
-	int	ldrv_num = 0;   /* logical drive number */
+	mega_passthru *pthru;
+	scb_t *scb;
+	mbox_t *mbox;
+	u32 seg;
+	char islogical;
+	int max_ldrv_num;
+	int channel = 0;
+	int target = 0;
+	int ldrv_num = 0; /* logical drive number */
 
 	/*
 	 * We know what channels our logical drives are on - mega_find_card()
@@ -538,15 +526,14 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 	 * the physical devices on virtual channel which is obviously converted
 	 * to actual channel on the HBA.
 	 */
-	if( adapter->boot_pdrv_enabled ) {
-		if( islogical ) {
+	if (adapter->boot_pdrv_enabled) {
+		if (islogical) {
 			/* logical channel */
 			channel = cmd->device->channel -
-				adapter->product_info.nchannels;
-		}
-		else {
+				  adapter->product_info.nchannels;
+		} else {
 			/* this is physical channel */
-			channel = cmd->device->channel; 
+			channel = cmd->device->channel;
 			target = cmd->device->id;
 
 			/*
@@ -554,29 +541,24 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			 * exposed first IF both the channels are SCSI, then
 			 * booting from the second channel is not allowed.
 			 */
-			if( target == 0 ) {
+			if (target == 0) {
 				target = adapter->boot_pdrv_tgt;
-			}
-			else if( target == adapter->boot_pdrv_tgt ) {
+			} else if (target == adapter->boot_pdrv_tgt) {
 				target = 0;
 			}
 		}
-	}
-	else {
-		if( islogical ) {
+	} else {
+		if (islogical) {
 			/* this is the logical channel */
-			channel = cmd->device->channel;	
-		}
-		else {
+			channel = cmd->device->channel;
+		} else {
 			/* physical channel */
-			channel = cmd->device->channel - NVIRT_CHAN;	
+			channel = cmd->device->channel - NVIRT_CHAN;
 			target = cmd->device->id;
 		}
 	}
 
-
-	if(islogical) {
-
+	if (islogical) {
 		/* have just LUN 0 for each target on virtual channels */
 		if (cmd->device->lun) {
 			cmd->result = (DID_BAD_TARGET << 16);
@@ -586,26 +568,25 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 
 		ldrv_num = mega_get_ldrv_num(adapter, cmd, channel);
 
-
 		max_ldrv_num = (adapter->flag & BOARD_40LD) ?
-			MAX_LOGICAL_DRIVES_40LD : MAX_LOGICAL_DRIVES_8LD;
+				       MAX_LOGICAL_DRIVES_40LD :
+					     MAX_LOGICAL_DRIVES_8LD;
 
 		/*
 		 * max_ldrv_num increases by 0x80 if some logical drive was
 		 * deleted.
 		 */
-		if(adapter->read_ldidmap)
+		if (adapter->read_ldidmap)
 			max_ldrv_num += 0x80;
 
-		if(ldrv_num > max_ldrv_num ) {
+		if (ldrv_num > max_ldrv_num) {
 			cmd->result = (DID_BAD_TARGET << 16);
 			scsi_done(cmd);
 			return NULL;
 		}
 
-	}
-	else {
-		if( cmd->device->lun > 7) {
+	} else {
+		if (cmd->device->lun > 7) {
 			/*
 			 * Do not support lun >7 for physically accessed
 			 * devices
@@ -621,7 +602,7 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 	 * Logical drive commands
 	 *
 	 */
-	if(islogical) {
+	if (islogical) {
 		switch (cmd->cmnd[0]) {
 		case TEST_UNIT_READY:
 #if MEGA_HAVE_CLUSTERING
@@ -629,13 +610,13 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			 * Do we support clustering and is the support enabled
 			 * If no, return success always
 			 */
-			if( !adapter->has_cluster ) {
+			if (!adapter->has_cluster) {
 				cmd->result = (DID_OK << 16);
 				scsi_done(cmd);
 				return NULL;
 			}
 
-			if(!(scb = mega_allocate_scb(adapter, cmd))) {
+			if (!(scb = mega_allocate_scb(adapter, cmd))) {
 				*busy = 1;
 				return NULL;
 			}
@@ -671,19 +652,18 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 		case READ_CAPACITY:
 		case INQUIRY:
 
-			if(!(adapter->flag & (1L << cmd->device->channel))) {
-
+			if (!(adapter->flag & (1L << cmd->device->channel))) {
 				dev_notice(&adapter->dev->dev,
-					"scsi%d: scanning scsi channel %d "
-					"for logical drives\n",
-						adapter->host->host_no,
-						cmd->device->channel);
+					   "scsi%d: scanning scsi channel %d "
+					   "for logical drives\n",
+					   adapter->host->host_no,
+					   cmd->device->channel);
 
 				adapter->flag |= (1L << cmd->device->channel);
 			}
 
 			/* Allocate a SCB and initialize passthru */
-			if(!(scb = mega_allocate_scb(adapter, cmd))) {
+			if (!(scb = mega_allocate_scb(adapter, cmd))) {
 				*busy = 1;
 				return NULL;
 			}
@@ -701,17 +681,18 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			pthru->cdblen = cmd->cmd_len;
 			memcpy(pthru->cdb, cmd->cmnd, cmd->cmd_len);
 
-			if( adapter->has_64bit_addr ) {
+			if (adapter->has_64bit_addr) {
 				mbox->m_out.cmd = MEGA_MBOXCMD_PASSTHRU64;
-			}
-			else {
+			} else {
 				mbox->m_out.cmd = MEGA_MBOXCMD_PASSTHRU;
 			}
 
 			scb->dma_direction = DMA_FROM_DEVICE;
 
-			pthru->numsgelements = mega_build_sglist(adapter, scb,
-				&pthru->dataxferaddr, &pthru->dataxferlen);
+			pthru->numsgelements =
+				mega_build_sglist(adapter, scb,
+						  &pthru->dataxferaddr,
+						  &pthru->dataxferlen);
 
 			mbox->m_out.xferaddr = scb->pthru_dma_addr;
 
@@ -725,7 +706,7 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 		case WRITE_12:
 
 			/* Allocate a SCB and initialize mailbox */
-			if(!(scb = mega_allocate_scb(adapter, cmd))) {
+			if (!(scb = mega_allocate_scb(adapter, cmd))) {
 				*busy = 1;
 				return NULL;
 			}
@@ -738,26 +719,25 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			 * A little hack: 2nd bit is zero for all scsi read
 			 * commands and is set for all scsi write commands
 			 */
-			if( adapter->has_64bit_addr ) {
-				mbox->m_out.cmd = (*cmd->cmnd & 0x02) ?
-					MEGA_MBOXCMD_LWRITE64:
-					MEGA_MBOXCMD_LREAD64 ;
-			}
-			else {
+			if (adapter->has_64bit_addr) {
+				mbox->m_out.cmd =
+					(*cmd->cmnd & 0x02) ?
+						MEGA_MBOXCMD_LWRITE64 :
+						      MEGA_MBOXCMD_LREAD64;
+			} else {
 				mbox->m_out.cmd = (*cmd->cmnd & 0x02) ?
-					MEGA_MBOXCMD_LWRITE:
-					MEGA_MBOXCMD_LREAD ;
+							  MEGA_MBOXCMD_LWRITE :
+								MEGA_MBOXCMD_LREAD;
 			}
 
 			/*
 			 * 6-byte READ(0x08) or WRITE(0x0A) cdb
 			 */
-			if( cmd->cmd_len == 6 ) {
-				mbox->m_out.numsectors = (u32) cmd->cmnd[4];
-				mbox->m_out.lba =
-					((u32)cmd->cmnd[1] << 16) |
-					((u32)cmd->cmnd[2] << 8) |
-					(u32)cmd->cmnd[3];
+			if (cmd->cmd_len == 6) {
+				mbox->m_out.numsectors = (u32)cmd->cmnd[4];
+				mbox->m_out.lba = ((u32)cmd->cmnd[1] << 16) |
+						  ((u32)cmd->cmnd[2] << 8) |
+						  (u32)cmd->cmnd[3];
 
 				mbox->m_out.lba &= 0x1FFFFF;
 
@@ -768,12 +748,12 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 				 * drive was deleted
 				 */
 				if (*cmd->cmnd == READ_6) {
-					adapter->nreads[ldrv_num%0x80]++;
-					adapter->nreadblocks[ldrv_num%0x80] +=
+					adapter->nreads[ldrv_num % 0x80]++;
+					adapter->nreadblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				} else {
-					adapter->nwrites[ldrv_num%0x80]++;
-					adapter->nwriteblocks[ldrv_num%0x80] +=
+					adapter->nwrites[ldrv_num % 0x80]++;
+					adapter->nwriteblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				}
 #endif
@@ -782,24 +762,23 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			/*
 			 * 10-byte READ(0x28) or WRITE(0x2A) cdb
 			 */
-			if( cmd->cmd_len == 10 ) {
+			if (cmd->cmd_len == 10) {
 				mbox->m_out.numsectors =
 					(u32)cmd->cmnd[8] |
 					((u32)cmd->cmnd[7] << 8);
-				mbox->m_out.lba =
-					((u32)cmd->cmnd[2] << 24) |
-					((u32)cmd->cmnd[3] << 16) |
-					((u32)cmd->cmnd[4] << 8) |
-					(u32)cmd->cmnd[5];
+				mbox->m_out.lba = ((u32)cmd->cmnd[2] << 24) |
+						  ((u32)cmd->cmnd[3] << 16) |
+						  ((u32)cmd->cmnd[4] << 8) |
+						  (u32)cmd->cmnd[5];
 
 #if MEGA_HAVE_STATS
 				if (*cmd->cmnd == READ_10) {
-					adapter->nreads[ldrv_num%0x80]++;
-					adapter->nreadblocks[ldrv_num%0x80] +=
+					adapter->nreads[ldrv_num % 0x80]++;
+					adapter->nreadblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				} else {
-					adapter->nwrites[ldrv_num%0x80]++;
-					adapter->nwriteblocks[ldrv_num%0x80] +=
+					adapter->nwrites[ldrv_num % 0x80]++;
+					adapter->nwriteblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				}
 #endif
@@ -808,12 +787,11 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			/*
 			 * 12-byte READ(0xA8) or WRITE(0xAA) cdb
 			 */
-			if( cmd->cmd_len == 12 ) {
-				mbox->m_out.lba =
-					((u32)cmd->cmnd[2] << 24) |
-					((u32)cmd->cmnd[3] << 16) |
-					((u32)cmd->cmnd[4] << 8) |
-					(u32)cmd->cmnd[5];
+			if (cmd->cmd_len == 12) {
+				mbox->m_out.lba = ((u32)cmd->cmnd[2] << 24) |
+						  ((u32)cmd->cmnd[3] << 16) |
+						  ((u32)cmd->cmnd[4] << 8) |
+						  (u32)cmd->cmnd[5];
 
 				mbox->m_out.numsectors =
 					((u32)cmd->cmnd[6] << 24) |
@@ -823,12 +801,12 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 
 #if MEGA_HAVE_STATS
 				if (*cmd->cmnd == READ_12) {
-					adapter->nreads[ldrv_num%0x80]++;
-					adapter->nreadblocks[ldrv_num%0x80] +=
+					adapter->nreads[ldrv_num % 0x80]++;
+					adapter->nreadblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				} else {
-					adapter->nwrites[ldrv_num%0x80]++;
-					adapter->nwriteblocks[ldrv_num%0x80] +=
+					adapter->nwrites[ldrv_num % 0x80]++;
+					adapter->nwriteblocks[ldrv_num % 0x80] +=
 						mbox->m_out.numsectors;
 				}
 #endif
@@ -837,16 +815,17 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			/*
 			 * If it is a read command
 			 */
-			if( (*cmd->cmnd & 0x0F) == 0x08 ) {
+			if ((*cmd->cmnd & 0x0F) == 0x08) {
 				scb->dma_direction = DMA_FROM_DEVICE;
-			}
-			else {
+			} else {
 				scb->dma_direction = DMA_TO_DEVICE;
 			}
 
 			/* Calculate Scatter-Gather info */
-			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
-					(u32 *)&mbox->m_out.xferaddr, &seg);
+			mbox->m_out.numsgelements =
+				mega_build_sglist(adapter, scb,
+						  (u32 *)&mbox->m_out.xferaddr,
+						  &seg);
 
 			return scb;
 
@@ -857,22 +836,22 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 			/*
 			 * Do we support clustering and is the support enabled
 			 */
-			if( ! adapter->has_cluster ) {
-
+			if (!adapter->has_cluster) {
 				cmd->result = (DID_BAD_TARGET << 16);
 				scsi_done(cmd);
 				return NULL;
 			}
 
 			/* Allocate a SCB and initialize mailbox */
-			if(!(scb = mega_allocate_scb(adapter, cmd))) {
+			if (!(scb = mega_allocate_scb(adapter, cmd))) {
 				*busy = 1;
 				return NULL;
 			}
 
 			scb->raw_mbox[0] = MEGA_CLUSTER_CMD;
-			scb->raw_mbox[2] = ( *cmd->cmnd == RESERVE ) ?
-				MEGA_RESERVE_LD : MEGA_RELEASE_LD;
+			scb->raw_mbox[2] = (*cmd->cmnd == RESERVE) ?
+						   MEGA_RESERVE_LD :
+							 MEGA_RELEASE_LD;
 
 			scb->raw_mbox[3] = ldrv_num;
 
@@ -893,7 +872,7 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 	 */
 	else {
 		/* Allocate a SCB and initialize passthru */
-		if(!(scb = mega_allocate_scb(adapter, cmd))) {
+		if (!(scb = mega_allocate_scb(adapter, cmd))) {
 			*busy = 1;
 			return NULL;
 		}
@@ -901,38 +880,32 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 		mbox = (mbox_t *)scb->raw_mbox;
 		memset(mbox, 0, sizeof(scb->raw_mbox));
 
-		if( adapter->support_ext_cdb ) {
-
-			mega_prepare_extpassthru(adapter, scb, cmd,
-					channel, target);
+		if (adapter->support_ext_cdb) {
+			mega_prepare_extpassthru(adapter, scb, cmd, channel,
+						 target);
 
 			mbox->m_out.cmd = MEGA_MBOXCMD_EXTPTHRU;
 
 			mbox->m_out.xferaddr = scb->epthru_dma_addr;
 
-		}
-		else {
-
+		} else {
 			pthru = mega_prepare_passthru(adapter, scb, cmd,
-					channel, target);
+						      channel, target);
 
 			/* Initialize mailbox */
-			if( adapter->has_64bit_addr ) {
+			if (adapter->has_64bit_addr) {
 				mbox->m_out.cmd = MEGA_MBOXCMD_PASSTHRU64;
-			}
-			else {
+			} else {
 				mbox->m_out.cmd = MEGA_MBOXCMD_PASSTHRU;
 			}
 
 			mbox->m_out.xferaddr = scb->pthru_dma_addr;
-
 		}
 		return scb;
 	}
 	return NULL;
 }
 
-
 /**
  * mega_prepare_passthru()
  * @adapter: pointer to our soft state
@@ -943,14 +916,14 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
  *
  * prepare a command for the scsi physical devices.
  */
-static mega_passthru *
-mega_prepare_passthru(adapter_t *adapter, scb_t *scb, struct scsi_cmnd *cmd,
-		      int channel, int target)
+static mega_passthru *mega_prepare_passthru(adapter_t *adapter, scb_t *scb,
+					    struct scsi_cmnd *cmd, int channel,
+					    int target)
 {
 	mega_passthru *pthru;
 
 	pthru = scb->pthru;
-	memset(pthru, 0, sizeof (mega_passthru));
+	memset(pthru, 0, sizeof(mega_passthru));
 
 	/* 0=6sec/1=60sec/2=10min/3=3hrs */
 	pthru->timeout = 2;
@@ -961,8 +934,8 @@ mega_prepare_passthru(adapter_t *adapter, scb_t *scb, struct scsi_cmnd *cmd,
 
 	pthru->channel = (adapter->flag & BOARD_40LD) ? 0 : channel;
 
-	pthru->target = (adapter->flag & BOARD_40LD) ?
-		(channel << 4) | target : target;
+	pthru->target =
+		(adapter->flag & BOARD_40LD) ? (channel << 4) | target : target;
 
 	pthru->cdblen = cmd->cmd_len;
 	pthru->logdrv = cmd->device->lun;
@@ -976,26 +949,25 @@ mega_prepare_passthru(adapter_t *adapter, scb_t *scb, struct scsi_cmnd *cmd,
 	switch (cmd->cmnd[0]) {
 	case INQUIRY:
 	case READ_CAPACITY:
-		if(!(adapter->flag & (1L << cmd->device->channel))) {
-
+		if (!(adapter->flag & (1L << cmd->device->channel))) {
 			dev_notice(&adapter->dev->dev,
-				"scsi%d: scanning scsi channel %d [P%d] "
-				"for physical devices\n",
-					adapter->host->host_no,
-					cmd->device->channel, channel);
+				   "scsi%d: scanning scsi channel %d [P%d] "
+				   "for physical devices\n",
+				   adapter->host->host_no, cmd->device->channel,
+				   channel);
 
 			adapter->flag |= (1L << cmd->device->channel);
 		}
 		fallthrough;
 	default:
-		pthru->numsgelements = mega_build_sglist(adapter, scb,
-				&pthru->dataxferaddr, &pthru->dataxferlen);
+		pthru->numsgelements =
+			mega_build_sglist(adapter, scb, &pthru->dataxferaddr,
+					  &pthru->dataxferlen);
 		break;
 	}
 	return pthru;
 }
 
-
 /**
  * mega_prepare_extpassthru()
  * @adapter: pointer to our soft state
@@ -1007,12 +979,12 @@ mega_prepare_passthru(adapter_t *adapter, scb_t *scb, struct scsi_cmnd *cmd,
  * prepare a command for the scsi physical devices. This rountine prepares
  * commands for devices which can take extended CDBs (>10 bytes)
  */
-static mega_ext_passthru *
-mega_prepare_extpassthru(adapter_t *adapter, scb_t *scb,
-			 struct scsi_cmnd *cmd,
-			 int channel, int target)
+static mega_ext_passthru *mega_prepare_extpassthru(adapter_t *adapter,
+						   scb_t *scb,
+						   struct scsi_cmnd *cmd,
+						   int channel, int target)
 {
-	mega_ext_passthru	*epthru;
+	mega_ext_passthru *epthru;
 
 	epthru = scb->epthru;
 	memset(epthru, 0, sizeof(mega_ext_passthru));
@@ -1025,8 +997,8 @@ mega_prepare_extpassthru(adapter_t *adapter, scb_t *scb,
 	epthru->islogical = 0;
 
 	epthru->channel = (adapter->flag & BOARD_40LD) ? 0 : channel;
-	epthru->target = (adapter->flag & BOARD_40LD) ?
-		(channel << 4) | target : target;
+	epthru->target =
+		(adapter->flag & BOARD_40LD) ? (channel << 4) | target : target;
 
 	epthru->cdblen = cmd->cmd_len;
 	epthru->logdrv = cmd->device->lun;
@@ -1036,43 +1008,40 @@ mega_prepare_extpassthru(adapter_t *adapter, scb_t *scb,
 	/* Not sure about the direction */
 	scb->dma_direction = DMA_BIDIRECTIONAL;
 
-	switch(cmd->cmnd[0]) {
+	switch (cmd->cmnd[0]) {
 	case INQUIRY:
 	case READ_CAPACITY:
-		if(!(adapter->flag & (1L << cmd->device->channel))) {
-
+		if (!(adapter->flag & (1L << cmd->device->channel))) {
 			dev_notice(&adapter->dev->dev,
-				"scsi%d: scanning scsi channel %d [P%d] "
-				"for physical devices\n",
-					adapter->host->host_no,
-					cmd->device->channel, channel);
+				   "scsi%d: scanning scsi channel %d [P%d] "
+				   "for physical devices\n",
+				   adapter->host->host_no, cmd->device->channel,
+				   channel);
 
 			adapter->flag |= (1L << cmd->device->channel);
 		}
 		fallthrough;
 	default:
-		epthru->numsgelements = mega_build_sglist(adapter, scb,
-				&epthru->dataxferaddr, &epthru->dataxferlen);
+		epthru->numsgelements =
+			mega_build_sglist(adapter, scb, &epthru->dataxferaddr,
+					  &epthru->dataxferlen);
 		break;
 	}
 
 	return epthru;
 }
 
-static void
-__mega_runpendq(adapter_t *adapter)
+static void __mega_runpendq(adapter_t *adapter)
 {
 	scb_t *scb;
 	struct list_head *pos, *next;
 
 	/* Issue any pending commands to the card */
-	list_for_each_safe(pos, next, &adapter->pending_list) {
-
+	list_for_each_safe (pos, next, &adapter->pending_list) {
 		scb = list_entry(pos, scb_t, list);
 
-		if( !(scb->state & SCB_ISSUED) ) {
-
-			if( issue_scb(adapter, scb) != 0 )
+		if (!(scb->state & SCB_ISSUED)) {
+			if (issue_scb(adapter, scb) != 0)
 				return;
 		}
 	}
@@ -1080,7 +1049,6 @@ __mega_runpendq(adapter_t *adapter)
 	return;
 }
 
-
 /**
  * issue_scb()
  * @adapter: pointer to our soft state
@@ -1090,29 +1058,28 @@ __mega_runpendq(adapter_t *adapter)
  * busy. We also take the scb from the pending list if the mailbox is
  * available.
  */
-static int
-issue_scb(adapter_t *adapter, scb_t *scb)
+static int issue_scb(adapter_t *adapter, scb_t *scb)
 {
-	volatile mbox64_t	*mbox64 = adapter->mbox64;
-	volatile mbox_t		*mbox = adapter->mbox;
-	unsigned int	i = 0;
+	volatile mbox64_t *mbox64 = adapter->mbox64;
+	volatile mbox_t *mbox = adapter->mbox;
+	unsigned int i = 0;
 
-	if(unlikely(mbox->m_in.busy)) {
+	if (unlikely(mbox->m_in.busy)) {
 		do {
 			udelay(1);
 			i++;
-		} while( mbox->m_in.busy && (i < max_mbox_busy_wait) );
+		} while (mbox->m_in.busy && (i < max_mbox_busy_wait));
 
-		if(mbox->m_in.busy) return -1;
+		if (mbox->m_in.busy)
+			return -1;
 	}
 
 	/* Copy mailbox data into host structure */
-	memcpy((char *)&mbox->m_out, (char *)scb->raw_mbox, 
-			sizeof(struct mbox_out));
-
-	mbox->m_out.cmdid = scb->idx;	/* Set cmdid */
-	mbox->m_in.busy = 1;		/* Set busy */
+	memcpy((char *)&mbox->m_out, (char *)scb->raw_mbox,
+	       sizeof(struct mbox_out));
 
+	mbox->m_out.cmdid = scb->idx; /* Set cmdid */
+	mbox->m_in.busy = 1; /* Set busy */
 
 	/*
 	 * Increment the pending queue counter
@@ -1138,12 +1105,11 @@ issue_scb(adapter_t *adapter, scb_t *scb)
 	 */
 	scb->state |= SCB_ISSUED;
 
-	if( likely(adapter->flag & BOARD_MEMMAP) ) {
+	if (likely(adapter->flag & BOARD_MEMMAP)) {
 		mbox->m_in.poll = 0;
 		mbox->m_in.ack = 0;
 		WRINDOOR(adapter, adapter->mbox_dma | 0x1);
-	}
-	else {
+	} else {
 		irq_enable(adapter);
 		issue_command(adapter);
 	}
@@ -1154,8 +1120,7 @@ issue_scb(adapter_t *adapter, scb_t *scb)
 /*
  * Wait until the controller's mailbox is available
  */
-static inline int
-mega_busywait_mbox (adapter_t *adapter)
+static inline int mega_busywait_mbox(adapter_t *adapter)
 {
 	if (adapter->mbox->m_in.busy)
 		return __mega_busywait_mbox(adapter);
@@ -1169,19 +1134,18 @@ mega_busywait_mbox (adapter_t *adapter)
  *
  * Issue a scb in synchronous and non-interrupt mode
  */
-static int
-issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
+static int issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
 {
 	volatile mbox64_t *mbox64 = adapter->mbox64;
 	volatile mbox_t *mbox = adapter->mbox;
-	u8	byte;
+	u8 byte;
 
 	/* Wait until mailbox is free */
-	if(mega_busywait_mbox (adapter))
+	if (mega_busywait_mbox(adapter))
 		goto bug_blocked_mailbox;
 
 	/* Copy mailbox data into host structure */
-	memcpy((char *) mbox, raw_mbox, sizeof(struct mbox_out));
+	memcpy((char *)mbox, raw_mbox, sizeof(struct mbox_out));
 	mbox->m_out.cmdid = 0xFE;
 	mbox->m_in.busy = 1;
 
@@ -1199,19 +1163,19 @@ issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
 		mbox64->xfer_segment_hi = 0;
 	}
 
-	if( likely(adapter->flag & BOARD_MEMMAP) ) {
+	if (likely(adapter->flag & BOARD_MEMMAP)) {
 		mbox->m_in.poll = 0;
 		mbox->m_in.ack = 0;
 		mbox->m_in.numstatus = 0xFF;
 		mbox->m_in.status = 0xFF;
 		WRINDOOR(adapter, adapter->mbox_dma | 0x1);
 
-		while((volatile u8)mbox->m_in.numstatus == 0xFF)
+		while ((volatile u8)mbox->m_in.numstatus == 0xFF)
 			cpu_relax();
 
 		mbox->m_in.numstatus = 0xFF;
 
-		while( (volatile u8)mbox->m_in.poll != 0x77 )
+		while ((volatile u8)mbox->m_in.poll != 0x77)
 			cpu_relax();
 
 		mbox->m_in.poll = 0;
@@ -1219,10 +1183,9 @@ issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
 
 		WRINDOOR(adapter, adapter->mbox_dma | 0x2);
 
-		while(RDINDOOR(adapter) & 0x2)
+		while (RDINDOOR(adapter) & 0x2)
 			cpu_relax();
-	}
-	else {
+	} else {
 		irq_disable(adapter);
 		issue_command(adapter);
 
@@ -1238,11 +1201,10 @@ issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
 
 bug_blocked_mailbox:
 	dev_warn(&adapter->dev->dev, "Blocked mailbox......!!\n");
-	udelay (1000);
+	udelay(1000);
 	return -1;
 }
 
-
 /**
  * megaraid_isr_iomapped()
  * @irq: irq
@@ -1252,17 +1214,15 @@ issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
  * and service the completed commands.
  */
-static irqreturn_t
-megaraid_isr_iomapped(int irq, void *devp)
+static irqreturn_t megaraid_isr_iomapped(int irq, void *devp)
 {
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-	u8	status;
-	u8	nstatus;
-	u8	completed[MAX_FIRMWARE_STATUS];
-	u8	byte;
-	int	handled = 0;
-
+	adapter_t *adapter = devp;
+	unsigned long flags;
+	u8 status;
+	u8 nstatus;
+	u8 completed[MAX_FIRMWARE_STATUS];
+	u8 byte;
+	int handled = 0;
 
 	/*
 	 * loop till F/W has more commands for us to complete.
@@ -1272,7 +1232,7 @@ megaraid_isr_iomapped(int irq, void *devp)
 	do {
 		/* Check if a valid interrupt is pending */
 		byte = irq_state(adapter);
-		if( (byte & VALID_INTR_BYTE) == 0 ) {
+		if ((byte & VALID_INTR_BYTE) == 0) {
 			/*
 			 * No more pending commands
 			 */
@@ -1280,8 +1240,8 @@ megaraid_isr_iomapped(int irq, void *devp)
 		}
 		set_irq_state(adapter, byte);
 
-		while((nstatus = (volatile u8)adapter->mbox->m_in.numstatus)
-				== 0xFF)
+		while ((nstatus = (volatile u8)adapter->mbox->m_in.numstatus) ==
+		       0xFF)
 			cpu_relax();
 		adapter->mbox->m_in.numstatus = 0xFF;
 
@@ -1292,8 +1252,8 @@ megaraid_isr_iomapped(int irq, void *devp)
 		 */
 		atomic_sub(nstatus, &adapter->pend_cmds);
 
-		memcpy(completed, (void *)adapter->mbox->m_in.completed, 
-				nstatus);
+		memcpy(completed, (void *)adapter->mbox->m_in.completed,
+		       nstatus);
 
 		/* Acknowledge interrupt */
 		irq_ack(adapter);
@@ -1305,20 +1265,19 @@ megaraid_isr_iomapped(int irq, void *devp)
 		handled = 1;
 
 		/* Loop through any pending requests */
-		if(atomic_read(&adapter->quiescent) == 0) {
+		if (atomic_read(&adapter->quiescent) == 0) {
 			mega_runpendq(adapter);
 		}
 
-	} while(1);
+	} while (1);
 
- out_unlock:
+out_unlock:
 
 	spin_unlock_irqrestore(&adapter->lock, flags);
 
 	return IRQ_RETVAL(handled);
 }
 
-
 /**
  * megaraid_isr_memmapped()
  * @irq: irq
@@ -1328,17 +1287,15 @@ megaraid_isr_iomapped(int irq, void *devp)
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
  * and service the completed commands.
  */
-static irqreturn_t
-megaraid_isr_memmapped(int irq, void *devp)
+static irqreturn_t megaraid_isr_memmapped(int irq, void *devp)
 {
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-	u8	status;
-	u32	dword = 0;
-	u8	nstatus;
-	u8	completed[MAX_FIRMWARE_STATUS];
-	int	handled = 0;
-
+	adapter_t *adapter = devp;
+	unsigned long flags;
+	u8 status;
+	u32 dword = 0;
+	u8 nstatus;
+	u8 completed[MAX_FIRMWARE_STATUS];
+	int handled = 0;
 
 	/*
 	 * loop till F/W has more commands for us to complete.
@@ -1348,7 +1305,7 @@ megaraid_isr_memmapped(int irq, void *devp)
 	do {
 		/* Check if a valid interrupt is pending */
 		dword = RDOUTDOOR(adapter);
-		if(dword != 0x10001234) {
+		if (dword != 0x10001234) {
 			/*
 			 * No more pending commands
 			 */
@@ -1356,8 +1313,8 @@ megaraid_isr_memmapped(int irq, void *devp)
 		}
 		WROUTDOOR(adapter, 0x10001234);
 
-		while((nstatus = (volatile u8)adapter->mbox->m_in.numstatus)
-				== 0xFF) {
+		while ((nstatus = (volatile u8)adapter->mbox->m_in.numstatus) ==
+		       0xFF) {
 			cpu_relax();
 		}
 		adapter->mbox->m_in.numstatus = 0xFF;
@@ -1369,15 +1326,15 @@ megaraid_isr_memmapped(int irq, void *devp)
 		 */
 		atomic_sub(nstatus, &adapter->pend_cmds);
 
-		memcpy(completed, (void *)adapter->mbox->m_in.completed, 
-				nstatus);
+		memcpy(completed, (void *)adapter->mbox->m_in.completed,
+		       nstatus);
 
 		/* Acknowledge interrupt */
 		WRINDOOR(adapter, 0x2);
 
 		handled = 1;
 
-		while( RDINDOOR(adapter) & 0x02 )
+		while (RDINDOOR(adapter) & 0x02)
 			cpu_relax();
 
 		mega_cmd_done(adapter, completed, nstatus, status);
@@ -1385,13 +1342,13 @@ megaraid_isr_memmapped(int irq, void *devp)
 		mega_rundoneq(adapter);
 
 		/* Loop through any pending requests */
-		if(atomic_read(&adapter->quiescent) == 0) {
+		if (atomic_read(&adapter->quiescent) == 0) {
 			mega_runpendq(adapter);
 		}
 
-	} while(1);
+	} while (1);
 
- out_unlock:
+out_unlock:
 
 	spin_unlock_irqrestore(&adapter->lock, flags);
 
@@ -1406,26 +1363,25 @@ megaraid_isr_memmapped(int irq, void *devp)
  *
  * Complete the commands and call the scsi mid-layer callback hooks.
  */
-static void
-mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
+static void mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus,
+			  int status)
 {
-	mega_ext_passthru	*epthru = NULL;
-	struct scatterlist	*sgl;
-	struct scsi_cmnd	*cmd = NULL;
-	mega_passthru	*pthru = NULL;
-	mbox_t	*mbox = NULL;
-	u8	c;
-	scb_t	*scb;
-	int	islogical;
-	int	cmdid;
-	int	i;
+	mega_ext_passthru *epthru = NULL;
+	struct scatterlist *sgl;
+	struct scsi_cmnd *cmd = NULL;
+	mega_passthru *pthru = NULL;
+	mbox_t *mbox = NULL;
+	u8 c;
+	scb_t *scb;
+	int islogical;
+	int cmdid;
+	int i;
 
 	/*
 	 * for all the commands completed, call the mid-layer callback routine
 	 * and free the scb.
 	 */
-	for( i = 0; i < nstatus; i++ ) {
-
+	for (i = 0; i < nstatus; i++) {
 		cmdid = completed[i];
 
 		/*
@@ -1449,10 +1405,11 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			/*
 			 * Make sure f/w has completed a valid command
 			 */
-			if( !(scb->state & SCB_ISSUED) || scb->cmd == NULL ) {
-				dev_crit(&adapter->dev->dev, "invalid command "
-					"Id %d, scb->state:%x, scsi cmd:%p\n",
-					cmdid, scb->state, scb->cmd);
+			if (!(scb->state & SCB_ISSUED) || scb->cmd == NULL) {
+				dev_crit(&adapter->dev->dev,
+					 "invalid command "
+					 "Id %d, scb->state:%x, scsi cmd:%p\n",
+					 cmdid, scb->state, scb->cmd);
 
 				continue;
 			}
@@ -1460,16 +1417,15 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			/*
 			 * Was a abort issued for this command
 			 */
-			if( scb->state & SCB_ABORT ) {
-
+			if (scb->state & SCB_ABORT) {
 				dev_warn(&adapter->dev->dev,
-					"aborted cmd [%x] complete\n",
-					scb->idx);
+					 "aborted cmd [%x] complete\n",
+					 scb->idx);
 
 				scb->cmd->result = (DID_ABORT << 16);
 
 				list_add_tail(SCSI_LIST(scb->cmd),
-						&adapter->completed_list);
+					      &adapter->completed_list);
 
 				mega_free_scb(adapter, scb);
 
@@ -1479,18 +1435,16 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			/*
 			 * Was a reset issued for this command
 			 */
-			if( scb->state & SCB_RESET ) {
-
+			if (scb->state & SCB_RESET) {
 				dev_warn(&adapter->dev->dev,
-					"reset cmd [%x] complete\n",
-					scb->idx);
+					 "reset cmd [%x] complete\n", scb->idx);
 
 				scb->cmd->result = (DID_RESET << 16);
 
 				list_add_tail(SCSI_LIST(scb->cmd),
-						&adapter->completed_list);
+					      &adapter->completed_list);
 
-				mega_free_scb (adapter, scb);
+				mega_free_scb(adapter, scb);
 
 				continue;
 			}
@@ -1502,35 +1456,35 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 
 #if MEGA_HAVE_STATS
 			{
+				int logdrv = mbox->m_out.logdrv;
 
-			int	logdrv = mbox->m_out.logdrv;
-
-			islogical = adapter->logdrv_chan[cmd->channel];
-			/*
+				islogical = adapter->logdrv_chan[cmd->channel];
+				/*
 			 * Maintain an error counter for the logical drive.
 			 * Some application like SNMP agent need such
 			 * statistics
 			 */
-			if( status && islogical && (cmd->cmnd[0] == READ_6 ||
-						cmd->cmnd[0] == READ_10 ||
-						cmd->cmnd[0] == READ_12)) {
-				/*
+				if (status && islogical &&
+				    (cmd->cmnd[0] == READ_6 ||
+				     cmd->cmnd[0] == READ_10 ||
+				     cmd->cmnd[0] == READ_12)) {
+					/*
 				 * Logical drive number increases by 0x80 when
 				 * a logical drive is deleted
 				 */
-				adapter->rd_errors[logdrv%0x80]++;
-			}
+					adapter->rd_errors[logdrv % 0x80]++;
+				}
 
-			if( status && islogical && (cmd->cmnd[0] == WRITE_6 ||
-						cmd->cmnd[0] == WRITE_10 ||
-						cmd->cmnd[0] == WRITE_12)) {
-				/*
+				if (status && islogical &&
+				    (cmd->cmnd[0] == WRITE_6 ||
+				     cmd->cmnd[0] == WRITE_10 ||
+				     cmd->cmnd[0] == WRITE_12)) {
+					/*
 				 * Logical drive number increases by 0x80 when
 				 * a logical drive is deleted
 				 */
-				adapter->wr_errors[logdrv%0x80]++;
-			}
-
+					adapter->wr_errors[logdrv % 0x80]++;
+				}
 			}
 #endif
 		}
@@ -1542,18 +1496,17 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 * PJ
 		 */
 		islogical = adapter->logdrv_chan[cmd->device->channel];
-		if( cmd->cmnd[0] == INQUIRY && !islogical ) {
-
+		if (cmd->cmnd[0] == INQUIRY && !islogical) {
 			sgl = scsi_sglist(cmd);
-			if( sg_page(sgl) ) {
-				c = *(unsigned char *) sg_virt(&sgl[0]);
+			if (sg_page(sgl)) {
+				c = *(unsigned char *)sg_virt(&sgl[0]);
 			} else {
 				dev_warn(&adapter->dev->dev, "invalid sg\n");
 				c = 0;
 			}
 
-			if(IS_RAID_CH(adapter, cmd->device->channel) &&
-					((c & 0x1F ) == TYPE_DISK)) {
+			if (IS_RAID_CH(adapter, cmd->device->channel) &&
+			    ((c & 0x1F) == TYPE_DISK)) {
 				status = 0xF0;
 			}
 		}
@@ -1563,27 +1516,24 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 
 		/* Convert MegaRAID status to Linux error code */
 		switch (status) {
-		case 0x00:	/* SUCCESS , i.e. SCSI_STATUS_GOOD */
+		case 0x00: /* SUCCESS , i.e. SCSI_STATUS_GOOD */
 			cmd->result |= (DID_OK << 16);
 			break;
 
-		case 0x02:	/* ERROR_ABORTED, i.e.
+		case 0x02: /* ERROR_ABORTED, i.e.
 				   SCSI_STATUS_CHECK_CONDITION */
 
 			/* set sense_buffer and result fields */
-			if( mbox->m_out.cmd == MEGA_MBOXCMD_PASSTHRU ||
-				mbox->m_out.cmd == MEGA_MBOXCMD_PASSTHRU64 ) {
-
+			if (mbox->m_out.cmd == MEGA_MBOXCMD_PASSTHRU ||
+			    mbox->m_out.cmd == MEGA_MBOXCMD_PASSTHRU64) {
 				memcpy(cmd->sense_buffer, pthru->reqsensearea,
-						14);
+				       14);
 
 				cmd->result = SAM_STAT_CHECK_CONDITION;
-			}
-			else {
+			} else {
 				if (mbox->m_out.cmd == MEGA_MBOXCMD_EXTPTHRU) {
-
 					memcpy(cmd->sense_buffer,
-						epthru->reqsensearea, 14);
+					       epthru->reqsensearea, 14);
 
 					cmd->result = SAM_STAT_CHECK_CONDITION;
 				} else
@@ -1592,7 +1542,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			}
 			break;
 
-		case 0x08:	/* ERR_DEST_DRIVE_FAILED, i.e.
+		case 0x08: /* ERR_DEST_DRIVE_FAILED, i.e.
 				   SCSI_STATUS_BUSY */
 			cmd->result |= (DID_BUS_BUSY << 16) | status;
 			break;
@@ -1603,25 +1553,23 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			 * If TEST_UNIT_READY fails, we know
 			 * MEGA_RESERVATION_STATUS failed
 			 */
-			if( cmd->cmnd[0] == TEST_UNIT_READY ) {
+			if (cmd->cmnd[0] == TEST_UNIT_READY) {
 				cmd->result |= (DID_ERROR << 16) |
-					SAM_STAT_RESERVATION_CONFLICT;
-			}
-			else
-			/*
+					       SAM_STAT_RESERVATION_CONFLICT;
+			} else
+				/*
 			 * Error code returned is 1 if Reserve or Release
 			 * failed or the input parameter is invalid
 			 */
-			if( status == 1 &&
-				(cmd->cmnd[0] == RESERVE ||
-					 cmd->cmnd[0] == RELEASE) ) {
-
-				cmd->result |= (DID_ERROR << 16) |
-					SAM_STAT_RESERVATION_CONFLICT;
-			}
-			else
+				if (status == 1 && (cmd->cmnd[0] == RESERVE ||
+						    cmd->cmnd[0] == RELEASE)) {
+					cmd->result |=
+						(DID_ERROR << 16) |
+						SAM_STAT_RESERVATION_CONFLICT;
+				} else
 #endif
-				cmd->result |= (DID_BAD_TARGET << 16)|status;
+					cmd->result |=
+						(DID_BAD_TARGET << 16) | status;
 		}
 
 		mega_free_scb(adapter, scb);
@@ -1631,21 +1579,18 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 	}
 }
 
-
 /*
  * mega_runpendq()
  *
  * Run through the list of completed requests and finish it
  */
-static void
-mega_rundoneq (adapter_t *adapter)
+static void mega_rundoneq(adapter_t *adapter)
 {
 	struct scsi_cmnd *cmd;
 	struct list_head *pos;
 
-	list_for_each(pos, &adapter->completed_list) {
-
-		struct scsi_pointer* spos = (struct scsi_pointer *)pos;
+	list_for_each (pos, &adapter->completed_list) {
+		struct scsi_pointer *spos = (struct scsi_pointer *)pos;
 
 		cmd = list_entry(spos, struct scsi_cmnd, SCp);
 		scsi_done(cmd);
@@ -1654,16 +1599,13 @@ mega_rundoneq (adapter_t *adapter)
 	INIT_LIST_HEAD(&adapter->completed_list);
 }
 
-
 /*
  * Free a SCB structure
  * Note: We assume the scsi commands associated with this scb is not free yet.
  */
-static void
-mega_free_scb(adapter_t *adapter, scb_t *scb)
+static void mega_free_scb(adapter_t *adapter, scb_t *scb)
 {
-	switch( scb->dma_type ) {
-
+	switch (scb->dma_type) {
 	case MEGA_DMA_TYPE_NONE:
 		break;
 
@@ -1686,9 +1628,7 @@ mega_free_scb(adapter_t *adapter, scb_t *scb)
 	list_add(&scb->list, &adapter->free_list);
 }
 
-
-static int
-__mega_busywait_mbox (adapter_t *adapter)
+static int __mega_busywait_mbox(adapter_t *adapter)
 {
 	volatile mbox_t *mbox = adapter->mbox;
 	long counter;
@@ -1699,20 +1639,19 @@ __mega_busywait_mbox (adapter_t *adapter)
 		udelay(100);
 		cond_resched();
 	}
-	return -1;		/* give up after 1 second */
+	return -1; /* give up after 1 second */
 }
 
 /*
  * Copies data to SGLIST
  * Note: For 64 bit cards, we need a minimum of one SG element for read/write
  */
-static int
-mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
+static int mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
 {
 	struct scatterlist *sg;
-	struct scsi_cmnd	*cmd;
-	int	sgcnt;
-	int	idx;
+	struct scsi_cmnd *cmd;
+	int sgcnt;
+	int idx;
 
 	cmd = scb->cmd;
 
@@ -1737,7 +1676,7 @@ mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
 		return 0;
 	}
 
-	scsi_for_each_sg(cmd, sg, sgcnt, idx) {
+	scsi_for_each_sg (cmd, sg, sgcnt, idx) {
 		if (adapter->has_64bit_addr) {
 			scb->sgl64[idx].address = sg_dma_address(sg);
 			*len += scb->sgl64[idx].length = sg_dma_len(sg);
@@ -1754,16 +1693,14 @@ mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
 	return sgcnt;
 }
 
-
 /*
  * mega_8_to_40ld()
  *
  * takes all info in AdapterInquiry structure and puts it into ProductInfo and
  * Enquiry3 structures for later use
  */
-static void
-mega_8_to_40ld(mraid_inquiry *inquiry, mega_inquiry3 *enquiry3,
-		mega_product_info *product_info)
+static void mega_8_to_40ld(mraid_inquiry *inquiry, mega_inquiry3 *enquiry3,
+			   mega_product_info *product_info)
 {
 	int i;
 
@@ -1795,17 +1732,15 @@ mega_8_to_40ld(mraid_inquiry *inquiry, mega_inquiry3 *enquiry3,
 		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
 }
 
-static inline void
-mega_free_sgl(adapter_t *adapter)
+static inline void mega_free_sgl(adapter_t *adapter)
 {
-	scb_t	*scb;
-	int	i;
-
-	for(i = 0; i < adapter->max_cmds; i++) {
+	scb_t *scb;
+	int i;
 
+	for (i = 0; i < adapter->max_cmds; i++) {
 		scb = &adapter->scb_list[i];
 
-		if( scb->sgl64 ) {
+		if (scb->sgl64) {
 			dma_free_coherent(&adapter->dev->dev,
 					  sizeof(mega_sgl64) * adapter->sglen,
 					  scb->sgl64, scb->sgl_dma_addr);
@@ -1813,7 +1748,7 @@ mega_free_sgl(adapter_t *adapter)
 			scb->sgl64 = NULL;
 		}
 
-		if( scb->pthru ) {
+		if (scb->pthru) {
 			dma_free_coherent(&adapter->dev->dev,
 					  sizeof(mega_passthru), scb->pthru,
 					  scb->pthru_dma_addr);
@@ -1821,34 +1756,31 @@ mega_free_sgl(adapter_t *adapter)
 			scb->pthru = NULL;
 		}
 
-		if( scb->epthru ) {
+		if (scb->epthru) {
 			dma_free_coherent(&adapter->dev->dev,
 					  sizeof(mega_ext_passthru),
 					  scb->epthru, scb->epthru_dma_addr);
 
 			scb->epthru = NULL;
 		}
-
 	}
 }
 
-
 /*
  * Get information about the card/driver
  */
-const char *
-megaraid_info(struct Scsi_Host *host)
+const char *megaraid_info(struct Scsi_Host *host)
 {
 	static char buffer[512];
 	adapter_t *adapter;
 
 	adapter = (adapter_t *)host->hostdata;
 
-	sprintf (buffer,
-		 "LSI Logic MegaRAID %s %d commands %d targs %d chans %d luns",
-		 adapter->fw_version, adapter->product_info.max_commands,
-		 adapter->host->max_id, adapter->host->max_channel,
-		 (u32)adapter->host->max_lun);
+	sprintf(buffer,
+		"LSI Logic MegaRAID %s %d commands %d targs %d chans %d luns",
+		adapter->fw_version, adapter->product_info.max_commands,
+		adapter->host->max_id, adapter->host->max_channel,
+		(u32)adapter->host->max_lun);
 	return buffer;
 }
 
@@ -1856,15 +1788,14 @@ megaraid_info(struct Scsi_Host *host)
  * Abort a previous SCSI request. Only commands on the pending list can be
  * aborted. All the commands issued to the F/W must complete.
  */
-static int
-megaraid_abort(struct scsi_cmnd *cmd)
+static int megaraid_abort(struct scsi_cmnd *cmd)
 {
-	adapter_t	*adapter;
-	int		rval;
+	adapter_t *adapter;
+	int rval;
 
 	adapter = (adapter_t *)cmd->device->host->hostdata;
 
-	rval =  megaraid_abort_and_reset(adapter, cmd, SCB_ABORT);
+	rval = megaraid_abort_and_reset(adapter, cmd, SCB_ABORT);
 
 	/*
 	 * This is required here to complete any completed requests
@@ -1875,13 +1806,11 @@ megaraid_abort(struct scsi_cmnd *cmd)
 	return rval;
 }
 
-
-static int
-megaraid_reset(struct scsi_cmnd *cmd)
+static int megaraid_reset(struct scsi_cmnd *cmd)
 {
-	adapter_t	*adapter;
-	megacmd_t	mc;
-	int		rval;
+	adapter_t *adapter;
+	megacmd_t mc;
+	int rval;
 
 	adapter = (adapter_t *)cmd->device->host->hostdata;
 
@@ -1889,17 +1818,16 @@ megaraid_reset(struct scsi_cmnd *cmd)
 	mc.cmd = MEGA_CLUSTER_CMD;
 	mc.opcode = MEGA_RESET_RESERVATIONS;
 
-	if( mega_internal_command(adapter, &mc, NULL) != 0 ) {
+	if (mega_internal_command(adapter, &mc, NULL) != 0) {
 		dev_warn(&adapter->dev->dev, "reservation reset failed\n");
-	}
-	else {
+	} else {
 		dev_info(&adapter->dev->dev, "reservation reset\n");
 	}
 #endif
 
 	spin_lock_irq(&adapter->lock);
 
-	rval =  megaraid_abort_and_reset(adapter, cmd, SCB_RESET);
+	rval = megaraid_abort_and_reset(adapter, cmd, SCB_RESET);
 
 	/*
 	 * This is required here to complete any completed requests
@@ -1920,22 +1848,20 @@ megaraid_reset(struct scsi_cmnd *cmd)
  * Try to locate the scsi command in the pending queue. If found and is not
  * issued to the controller, abort/reset it. Otherwise return failure
  */
-static int
-megaraid_abort_and_reset(adapter_t *adapter, struct scsi_cmnd *cmd, int aor)
+static int megaraid_abort_and_reset(adapter_t *adapter, struct scsi_cmnd *cmd,
+				    int aor)
 {
-	struct list_head	*pos, *next;
-	scb_t			*scb;
+	struct list_head *pos, *next;
+	scb_t *scb;
 
 	dev_warn(&adapter->dev->dev, "%s cmd=%x <c=%d t=%d l=%d>\n",
-	     (aor == SCB_ABORT)? "ABORTING":"RESET",
-	     cmd->cmnd[0], cmd->device->channel,
-	     cmd->device->id, (u32)cmd->device->lun);
+		 (aor == SCB_ABORT) ? "ABORTING" : "RESET", cmd->cmnd[0],
+		 cmd->device->channel, cmd->device->id, (u32)cmd->device->lun);
 
-	if(list_empty(&adapter->pending_list))
+	if (list_empty(&adapter->pending_list))
 		return FAILED;
 
-	list_for_each_safe(pos, next, &adapter->pending_list) {
-
+	list_for_each_safe (pos, next, &adapter->pending_list) {
 		scb = list_entry(pos, scb_t, list);
 
 		if (scb->cmd == cmd) { /* Found command */
@@ -1948,37 +1874,35 @@ megaraid_abort_and_reset(adapter_t *adapter, struct scsi_cmnd *cmd, int aor)
 			 * completes this command, we will return appropriate
 			 * status from ISR.
 			 */
-			if( scb->state & SCB_ISSUED ) {
-
+			if (scb->state & SCB_ISSUED) {
 				dev_warn(&adapter->dev->dev,
-					"%s[%x], fw owner\n",
-					(aor==SCB_ABORT) ? "ABORTING":"RESET",
-					scb->idx);
+					 "%s[%x], fw owner\n",
+					 (aor == SCB_ABORT) ? "ABORTING" :
+								    "RESET",
+					 scb->idx);
 
 				return FAILED;
-			}
-			else {
-
+			} else {
 				/*
 				 * Not yet issued! Remove from the pending
 				 * list
 				 */
 				dev_warn(&adapter->dev->dev,
-					"%s-[%x], driver owner\n",
-					(aor==SCB_ABORT) ? "ABORTING":"RESET",
-					scb->idx);
+					 "%s-[%x], driver owner\n",
+					 (aor == SCB_ABORT) ? "ABORTING" :
+								    "RESET",
+					 scb->idx);
 
 				mega_free_scb(adapter, scb);
 
-				if( aor == SCB_ABORT ) {
+				if (aor == SCB_ABORT) {
 					cmd->result = (DID_ABORT << 16);
-				}
-				else {
+				} else {
 					cmd->result = (DID_RESET << 16);
 				}
 
 				list_add_tail(SCSI_LIST(cmd),
-						&adapter->completed_list);
+					      &adapter->completed_list);
 
 				return SUCCESS;
 			}
@@ -1988,12 +1912,12 @@ megaraid_abort_and_reset(adapter_t *adapter, struct scsi_cmnd *cmd, int aor)
 	return FAILED;
 }
 
-static inline int
-make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
+static inline int make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
 {
 	*pdev = pci_alloc_dev(NULL);
 
-	if( *pdev == NULL ) return -1;
+	if (*pdev == NULL)
+		return -1;
 
 	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));
 
@@ -2005,8 +1929,7 @@ make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
 	return 0;
 }
 
-static inline void
-free_local_pdev(struct pci_dev *pdev)
+static inline void free_local_pdev(struct pci_dev *pdev)
 {
 	kfree(pdev);
 }
@@ -2018,22 +1941,20 @@ free_local_pdev(struct pci_dev *pdev)
  *
  * allocates memory for inquiry structure
  */
-static inline void *
-mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
+static inline void *mega_allocate_inquiry(dma_addr_t *dma_handle,
+					  struct pci_dev *pdev)
 {
-	return dma_alloc_coherent(&pdev->dev, sizeof(mega_inquiry3),
-				  dma_handle, GFP_KERNEL);
+	return dma_alloc_coherent(&pdev->dev, sizeof(mega_inquiry3), dma_handle,
+				  GFP_KERNEL);
 }
 
-
-static inline void
-mega_free_inquiry(void *inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
+static inline void mega_free_inquiry(void *inquiry, dma_addr_t dma_handle,
+				     struct pci_dev *pdev)
 {
 	dma_free_coherent(&pdev->dev, sizeof(mega_inquiry3), inquiry,
 			  dma_handle);
 }
 
-
 #ifdef CONFIG_PROC_FS
 /* Following code handles /proc fs  */
 
@@ -2044,42 +1965,40 @@ mega_free_inquiry(void *inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
  *
  * Display configuration information about the controller.
  */
-static int
-proc_show_config(struct seq_file *m, void *v)
+static int proc_show_config(struct seq_file *m, void *v)
 {
-
 	adapter_t *adapter = m->private;
 
 	seq_puts(m, MEGARAID_VERSION);
-	if(adapter->product_info.product_name[0])
+	if (adapter->product_info.product_name[0])
 		seq_printf(m, "%s\n", adapter->product_info.product_name);
 
 	seq_puts(m, "Controller Type: ");
 
-	if( adapter->flag & BOARD_MEMMAP )
+	if (adapter->flag & BOARD_MEMMAP)
 		seq_puts(m, "438/466/467/471/493/518/520/531/532\n");
 	else
 		seq_puts(m, "418/428/434\n");
 
-	if(adapter->flag & BOARD_40LD)
+	if (adapter->flag & BOARD_40LD)
 		seq_puts(m, "Controller Supports 40 Logical Drives\n");
 
-	if(adapter->flag & BOARD_64BIT)
+	if (adapter->flag & BOARD_64BIT)
 		seq_puts(m, "Controller capable of 64-bit memory addressing\n");
-	if( adapter->has_64bit_addr )
+	if (adapter->has_64bit_addr)
 		seq_puts(m, "Controller using 64-bit memory addressing\n");
 	else
-		seq_puts(m, "Controller is not using 64-bit memory addressing\n");
+		seq_puts(m,
+			 "Controller is not using 64-bit memory addressing\n");
 
-	seq_printf(m, "Base = %08lx, Irq = %d, ",
-		   adapter->base, adapter->host->irq);
+	seq_printf(m, "Base = %08lx, Irq = %d, ", adapter->base,
+		   adapter->host->irq);
 
-	seq_printf(m, "Logical Drives = %d, Channels = %d\n",
-		   adapter->numldrv, adapter->product_info.nchannels);
+	seq_printf(m, "Logical Drives = %d, Channels = %d\n", adapter->numldrv,
+		   adapter->product_info.nchannels);
 
-	seq_printf(m, "Version =%s:%s, DRAM = %dMb\n",
-		   adapter->fw_version, adapter->bios_version,
-		   adapter->product_info.dram_size);
+	seq_printf(m, "Version =%s:%s, DRAM = %dMb\n", adapter->fw_version,
+		   adapter->bios_version, adapter->product_info.dram_size);
 
 	seq_printf(m, "Controller Queue Depth = %d, Driver Queue Depth = %d\n",
 		   adapter->product_info.max_commands, adapter->max_cmds);
@@ -2108,18 +2027,17 @@ proc_show_config(struct seq_file *m, void *v)
  *
  * Display statistical information about the I/O activity.
  */
-static int
-proc_show_stat(struct seq_file *m, void *v)
+static int proc_show_stat(struct seq_file *m, void *v)
 {
 	adapter_t *adapter = m->private;
 #if MEGA_HAVE_STATS
-	int	i;
+	int i;
 #endif
 
 	seq_puts(m, "Statistical Information for this controller\n");
 	seq_printf(m, "pend_cmds = %d\n", atomic_read(&adapter->pend_cmds));
 #if MEGA_HAVE_STATS
-	for(i = 0; i < adapter->numldrv; i++) {
+	for (i = 0; i < adapter->numldrv; i++) {
 		seq_printf(m, "Logical Drive %d:\n", i);
 		seq_printf(m, "\tReads Issued = %lu, Writes Issued = %lu\n",
 			   adapter->nreads[i], adapter->nwrites[i]);
@@ -2134,7 +2052,6 @@ proc_show_stat(struct seq_file *m, void *v)
 	return 0;
 }
 
-
 /**
  * proc_show_mbox()
  * @m: Synthetic file construction data
@@ -2143,11 +2060,10 @@ proc_show_stat(struct seq_file *m, void *v)
  * Display mailbox information for the last command issued. This information
  * is good for debugging.
  */
-static int
-proc_show_mbox(struct seq_file *m, void *v)
+static int proc_show_mbox(struct seq_file *m, void *v)
 {
-	adapter_t	*adapter = m->private;
-	volatile mbox_t	*mbox = adapter->mbox;
+	adapter_t *adapter = m->private;
+	volatile mbox_t *mbox = adapter->mbox;
 
 	seq_puts(m, "Contents of Mail Box Structure\n");
 	seq_printf(m, "  Fw Command   = 0x%02x\n", mbox->m_out.cmd);
@@ -2162,7 +2078,6 @@ proc_show_mbox(struct seq_file *m, void *v)
 	return 0;
 }
 
-
 /**
  * proc_show_rebuild_rate()
  * @m: Synthetic file construction data
@@ -2170,33 +2085,32 @@ proc_show_mbox(struct seq_file *m, void *v)
  *
  * Display current rebuild rate
  */
-static int
-proc_show_rebuild_rate(struct seq_file *m, void *v)
+static int proc_show_rebuild_rate(struct seq_file *m, void *v)
 {
-	adapter_t	*adapter = m->private;
-	dma_addr_t	dma_handle;
-	caddr_t		inquiry;
-	struct pci_dev	*pdev;
+	adapter_t *adapter = m->private;
+	dma_addr_t dma_handle;
+	caddr_t inquiry;
+	struct pci_dev *pdev;
 
-	if( make_local_pdev(adapter, &pdev) != 0 )
+	if (make_local_pdev(adapter, &pdev) != 0)
 		return 0;
 
-	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL )
+	if ((inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL)
 		goto free_pdev;
 
-	if( mega_adapinq(adapter, dma_handle) != 0 ) {
+	if (mega_adapinq(adapter, dma_handle) != 0) {
 		seq_puts(m, "Adapter inquiry failed.\n");
 		dev_warn(&adapter->dev->dev, "inquiry failed\n");
 		goto free_inquiry;
 	}
 
-	if( adapter->flag & BOARD_40LD )
+	if (adapter->flag & BOARD_40LD)
 		seq_printf(m, "Rebuild Rate: [%d%%]\n",
 			   ((mega_inquiry3 *)inquiry)->rebuild_rate);
 	else
 		seq_printf(m, "Rebuild Rate: [%d%%]\n",
-			((mraid_ext_inquiry *)
-			 inquiry)->raid_inq.adapter_info.rebuild_rate);
+			   ((mraid_ext_inquiry *)inquiry)
+				   ->raid_inq.adapter_info.rebuild_rate);
 
 free_inquiry:
 	mega_free_inquiry(inquiry, dma_handle, pdev);
@@ -2205,7 +2119,6 @@ proc_show_rebuild_rate(struct seq_file *m, void *v)
 	return 0;
 }
 
-
 /**
  * proc_show_battery()
  * @m: Synthetic file construction data
@@ -2213,33 +2126,31 @@ proc_show_rebuild_rate(struct seq_file *m, void *v)
  *
  * Display information about the battery module on the controller.
  */
-static int
-proc_show_battery(struct seq_file *m, void *v)
+static int proc_show_battery(struct seq_file *m, void *v)
 {
-	adapter_t	*adapter = m->private;
-	dma_addr_t	dma_handle;
-	caddr_t		inquiry;
-	struct pci_dev	*pdev;
-	u8	battery_status;
+	adapter_t *adapter = m->private;
+	dma_addr_t dma_handle;
+	caddr_t inquiry;
+	struct pci_dev *pdev;
+	u8 battery_status;
 
-	if( make_local_pdev(adapter, &pdev) != 0 )
+	if (make_local_pdev(adapter, &pdev) != 0)
 		return 0;
 
-	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL )
+	if ((inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL)
 		goto free_pdev;
 
-	if( mega_adapinq(adapter, dma_handle) != 0 ) {
+	if (mega_adapinq(adapter, dma_handle) != 0) {
 		seq_puts(m, "Adapter inquiry failed.\n");
 		dev_warn(&adapter->dev->dev, "inquiry failed\n");
 		goto free_inquiry;
 	}
 
-	if( adapter->flag & BOARD_40LD ) {
+	if (adapter->flag & BOARD_40LD) {
 		battery_status = ((mega_inquiry3 *)inquiry)->battery_status;
-	}
-	else {
-		battery_status = ((mraid_ext_inquiry *)inquiry)->
-			raid_inq.adapter_info.battery_status;
+	} else {
+		battery_status = ((mraid_ext_inquiry *)inquiry)
+					 ->raid_inq.adapter_info.battery_status;
 	}
 
 	/*
@@ -2247,28 +2158,28 @@ proc_show_battery(struct seq_file *m, void *v)
 	 */
 	seq_printf(m, "Battery Status:[%d]", battery_status);
 
-	if(battery_status == MEGA_BATT_CHARGE_DONE)
+	if (battery_status == MEGA_BATT_CHARGE_DONE)
 		seq_puts(m, " Charge Done");
 
-	if(battery_status & MEGA_BATT_MODULE_MISSING)
+	if (battery_status & MEGA_BATT_MODULE_MISSING)
 		seq_puts(m, " Module Missing");
-	
-	if(battery_status & MEGA_BATT_LOW_VOLTAGE)
+
+	if (battery_status & MEGA_BATT_LOW_VOLTAGE)
 		seq_puts(m, " Low Voltage");
-	
-	if(battery_status & MEGA_BATT_TEMP_HIGH)
+
+	if (battery_status & MEGA_BATT_TEMP_HIGH)
 		seq_puts(m, " Temperature High");
-	
-	if(battery_status & MEGA_BATT_PACK_MISSING)
+
+	if (battery_status & MEGA_BATT_PACK_MISSING)
 		seq_puts(m, " Pack Missing");
-	
-	if(battery_status & MEGA_BATT_CHARGE_INPROG)
+
+	if (battery_status & MEGA_BATT_CHARGE_INPROG)
 		seq_puts(m, " Charge In-progress");
-	
-	if(battery_status & MEGA_BATT_CHARGE_FAIL)
+
+	if (battery_status & MEGA_BATT_CHARGE_FAIL)
 		seq_puts(m, " Charge Fail");
-	
-	if(battery_status & MEGA_BATT_CYCLES_EXCEEDED)
+
+	if (battery_status & MEGA_BATT_CYCLES_EXCEEDED)
 		seq_puts(m, " Cycles Exceeded");
 
 	seq_putc(m, '\n');
@@ -2280,14 +2191,12 @@ proc_show_battery(struct seq_file *m, void *v)
 	return 0;
 }
 
-
 /*
  * Display scsi inquiry
  */
-static void
-mega_print_inquiry(struct seq_file *m, char *scsi_inq)
+static void mega_print_inquiry(struct seq_file *m, char *scsi_inq)
 {
-	int	i;
+	int i;
 
 	seq_puts(m, "  Vendor: ");
 	seq_write(m, scsi_inq + 8, 8);
@@ -2303,7 +2212,7 @@ mega_print_inquiry(struct seq_file *m, char *scsi_inq)
 	seq_printf(m, "                 ANSI SCSI revision: %02x",
 		   scsi_inq[2] & 0x07);
 
-	if( (scsi_inq[2] & 0x07) == 1 && (scsi_inq[3] & 0x0f) == 1 )
+	if ((scsi_inq[2] & 0x07) == 1 && (scsi_inq[3] & 0x0f) == 1)
 		seq_puts(m, " CCS\n");
 	else
 		seq_putc(m, '\n');
@@ -2317,60 +2226,56 @@ mega_print_inquiry(struct seq_file *m, char *scsi_inq)
  *
  * Display information about the physical drives.
  */
-static int
-proc_show_pdrv(struct seq_file *m, adapter_t *adapter, int channel)
+static int proc_show_pdrv(struct seq_file *m, adapter_t *adapter, int channel)
 {
-	dma_addr_t	dma_handle;
-	char		*scsi_inq;
-	dma_addr_t	scsi_inq_dma_handle;
-	caddr_t		inquiry;
-	struct pci_dev	*pdev;
-	u8	*pdrv_state;
-	u8	state;
-	int	tgt;
-	int	max_channels;
-	int	i;
-
-	if( make_local_pdev(adapter, &pdev) != 0 )
+	dma_addr_t dma_handle;
+	char *scsi_inq;
+	dma_addr_t scsi_inq_dma_handle;
+	caddr_t inquiry;
+	struct pci_dev *pdev;
+	u8 *pdrv_state;
+	u8 state;
+	int tgt;
+	int max_channels;
+	int i;
+
+	if (make_local_pdev(adapter, &pdev) != 0)
 		return 0;
 
-	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL )
+	if ((inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL)
 		goto free_pdev;
 
-	if( mega_adapinq(adapter, dma_handle) != 0 ) {
+	if (mega_adapinq(adapter, dma_handle) != 0) {
 		seq_puts(m, "Adapter inquiry failed.\n");
 		dev_warn(&adapter->dev->dev, "inquiry failed\n");
 		goto free_inquiry;
 	}
 
-
 	scsi_inq = dma_alloc_coherent(&pdev->dev, 256, &scsi_inq_dma_handle,
 				      GFP_KERNEL);
-	if( scsi_inq == NULL ) {
+	if (scsi_inq == NULL) {
 		seq_puts(m, "memory not available for scsi inq.\n");
 		goto free_inquiry;
 	}
 
-	if( adapter->flag & BOARD_40LD ) {
+	if (adapter->flag & BOARD_40LD) {
 		pdrv_state = ((mega_inquiry3 *)inquiry)->pdrv_state;
-	}
-	else {
-		pdrv_state = ((mraid_ext_inquiry *)inquiry)->
-			raid_inq.pdrv_info.pdrv_state;
+	} else {
+		pdrv_state = ((mraid_ext_inquiry *)inquiry)
+				     ->raid_inq.pdrv_info.pdrv_state;
 	}
 
 	max_channels = adapter->product_info.nchannels;
 
-	if( channel >= max_channels ) {
+	if (channel >= max_channels) {
 		goto free_pci;
 	}
 
-	for( tgt = 0; tgt <= MAX_TARGET; tgt++ ) {
-
-		i = channel*16 + tgt;
+	for (tgt = 0; tgt <= MAX_TARGET; tgt++) {
+		i = channel * 16 + tgt;
 
 		state = *(pdrv_state + i);
-		switch( state & 0x0F ) {
+		switch (state & 0x0F) {
 		case PDRV_ONLINE:
 			seq_printf(m, "Channel:%2d Id:%2d State: Online",
 				   channel, tgt);
@@ -2403,9 +2308,9 @@ proc_show_pdrv(struct seq_file *m, adapter_t *adapter, int channel)
 		 * devices are available through /proc/scsi/scsi
 		 */
 		memset(scsi_inq, 0, 256);
-		if( mega_internal_dev_inquiry(adapter, channel, tgt,
-				scsi_inq_dma_handle) ||
-				(scsi_inq[0] & 0x1F) != TYPE_DISK ) {
+		if (mega_internal_dev_inquiry(adapter, channel, tgt,
+					      scsi_inq_dma_handle) ||
+		    (scsi_inq[0] & 0x1F) != TYPE_DISK) {
 			continue;
 		}
 
@@ -2433,13 +2338,11 @@ proc_show_pdrv(struct seq_file *m, adapter_t *adapter, int channel)
  *
  * Display information about the physical drives on physical channel 0.
  */
-static int
-proc_show_pdrv_ch0(struct seq_file *m, void *v)
+static int proc_show_pdrv_ch0(struct seq_file *m, void *v)
 {
 	return proc_show_pdrv(m, m->private, 0);
 }
 
-
 /**
  * proc_show_pdrv_ch1()
  * @m: Synthetic file construction data
@@ -2447,13 +2350,11 @@ proc_show_pdrv_ch0(struct seq_file *m, void *v)
  *
  * Display information about the physical drives on physical channel 1.
  */
-static int
-proc_show_pdrv_ch1(struct seq_file *m, void *v)
+static int proc_show_pdrv_ch1(struct seq_file *m, void *v)
 {
 	return proc_show_pdrv(m, m->private, 1);
 }
 
-
 /**
  * proc_show_pdrv_ch2()
  * @m: Synthetic file construction data
@@ -2461,13 +2362,11 @@ proc_show_pdrv_ch1(struct seq_file *m, void *v)
  *
  * Display information about the physical drives on physical channel 2.
  */
-static int
-proc_show_pdrv_ch2(struct seq_file *m, void *v)
+static int proc_show_pdrv_ch2(struct seq_file *m, void *v)
 {
 	return proc_show_pdrv(m, m->private, 2);
 }
 
-
 /**
  * proc_show_pdrv_ch3()
  * @m: Synthetic file construction data
@@ -2475,13 +2374,11 @@ proc_show_pdrv_ch2(struct seq_file *m, void *v)
  *
  * Display information about the physical drives on physical channel 3.
  */
-static int
-proc_show_pdrv_ch3(struct seq_file *m, void *v)
+static int proc_show_pdrv_ch3(struct seq_file *m, void *v)
 {
 	return proc_show_pdrv(m, m->private, 3);
 }
 
-
 /**
  * proc_show_rdrv()
  * @m: Synthetic file construction data
@@ -2492,28 +2389,28 @@ proc_show_pdrv_ch3(struct seq_file *m, void *v)
  * We do not print the inquiry information since its already available through
  * /proc/scsi/scsi interface
  */
-static int
-proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
+static int proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start,
+			  int end)
 {
-	dma_addr_t	dma_handle;
-	logdrv_param	*lparam;
-	megacmd_t	mc;
-	char		*disk_array;
-	dma_addr_t	disk_array_dma_handle;
-	caddr_t		inquiry;
-	struct pci_dev	*pdev;
-	u8	*rdrv_state;
-	int	num_ldrv;
-	u32	array_sz;
-	int	i;
-
-	if( make_local_pdev(adapter, &pdev) != 0 )
+	dma_addr_t dma_handle;
+	logdrv_param *lparam;
+	megacmd_t mc;
+	char *disk_array;
+	dma_addr_t disk_array_dma_handle;
+	caddr_t inquiry;
+	struct pci_dev *pdev;
+	u8 *rdrv_state;
+	int num_ldrv;
+	u32 array_sz;
+	int i;
+
+	if (make_local_pdev(adapter, &pdev) != 0)
 		return 0;
 
-	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL )
+	if ((inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL)
 		goto free_pdev;
 
-	if( mega_adapinq(adapter, dma_handle) != 0 ) {
+	if (mega_adapinq(adapter, dma_handle) != 0) {
 		seq_puts(m, "Adapter inquiry failed.\n");
 		dev_warn(&adapter->dev->dev, "inquiry failed\n");
 		goto free_inquiry;
@@ -2521,64 +2418,60 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 
 	memset(&mc, 0, sizeof(megacmd_t));
 
-	if( adapter->flag & BOARD_40LD ) {
+	if (adapter->flag & BOARD_40LD) {
 		array_sz = sizeof(disk_array_40ld);
 
 		rdrv_state = ((mega_inquiry3 *)inquiry)->ldrv_state;
 
 		num_ldrv = ((mega_inquiry3 *)inquiry)->num_ldrv;
-	}
-	else {
+	} else {
 		array_sz = sizeof(disk_array_8ld);
 
-		rdrv_state = ((mraid_ext_inquiry *)inquiry)->
-			raid_inq.logdrv_info.ldrv_state;
+		rdrv_state = ((mraid_ext_inquiry *)inquiry)
+				     ->raid_inq.logdrv_info.ldrv_state;
 
-		num_ldrv = ((mraid_ext_inquiry *)inquiry)->
-			raid_inq.logdrv_info.num_ldrv;
+		num_ldrv = ((mraid_ext_inquiry *)inquiry)
+				   ->raid_inq.logdrv_info.num_ldrv;
 	}
 
 	disk_array = dma_alloc_coherent(&pdev->dev, array_sz,
 					&disk_array_dma_handle, GFP_KERNEL);
 
-	if( disk_array == NULL ) {
+	if (disk_array == NULL) {
 		seq_puts(m, "memory not available.\n");
 		goto free_inquiry;
 	}
 
 	mc.xferaddr = (u32)disk_array_dma_handle;
 
-	if( adapter->flag & BOARD_40LD ) {
+	if (adapter->flag & BOARD_40LD) {
 		mc.cmd = FC_NEW_CONFIG;
 		mc.opcode = OP_DCMD_READ_CONFIG;
 
-		if( mega_internal_command(adapter, &mc, NULL) ) {
+		if (mega_internal_command(adapter, &mc, NULL)) {
 			seq_puts(m, "40LD read config failed.\n");
 			goto free_pci;
 		}
 
-	}
-	else {
+	} else {
 		mc.cmd = NEW_READ_CONFIG_8LD;
 
-		if( mega_internal_command(adapter, &mc, NULL) ) {
+		if (mega_internal_command(adapter, &mc, NULL)) {
 			mc.cmd = READ_CONFIG_8LD;
-			if( mega_internal_command(adapter, &mc, NULL) ) {
+			if (mega_internal_command(adapter, &mc, NULL)) {
 				seq_puts(m, "8LD read config failed.\n");
 				goto free_pci;
 			}
 		}
 	}
 
-	for( i = start; i < ( (end+1 < num_ldrv) ? end+1 : num_ldrv ); i++ ) {
-
-		if( adapter->flag & BOARD_40LD ) {
+	for (i = start; i < ((end + 1 < num_ldrv) ? end + 1 : num_ldrv); i++) {
+		if (adapter->flag & BOARD_40LD) {
 			lparam =
-			&((disk_array_40ld *)disk_array)->ldrv[i].lparam;
-		}
-		else {
+				&((disk_array_40ld *)disk_array)->ldrv[i].lparam;
+		} else {
 			lparam =
-			&((disk_array_8ld *)disk_array)->ldrv[i].lparam;
+				&((disk_array_8ld *)disk_array)->ldrv[i].lparam;
 		}
 
 		/*
@@ -2587,7 +2480,7 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 		 */
 		seq_printf(m, "Logical drive:%2d:, ", i);
 
-		switch( rdrv_state[i] & 0x0F ) {
+		switch (rdrv_state[i] & 0x0F) {
 		case RDRV_OFFLINE:
 			seq_puts(m, "state: offline");
 			break;
@@ -2609,21 +2502,21 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 		 * Check if check consistency or initialization is going on
 		 * for this logical drive.
 		 */
-		if( (rdrv_state[i] & 0xF0) == 0x20 )
+		if ((rdrv_state[i] & 0xF0) == 0x20)
 			seq_puts(m, ", check-consistency in progress");
-		else if( (rdrv_state[i] & 0xF0) == 0x10 )
+		else if ((rdrv_state[i] & 0xF0) == 0x10)
 			seq_puts(m, ", initialization in progress");
-		
+
 		seq_putc(m, '\n');
 
 		seq_printf(m, "Span depth:%3d, ", lparam->span_depth);
 		seq_printf(m, "RAID level:%3d, ", lparam->level);
 		seq_printf(m, "Stripe size:%3d, ",
-			   lparam->stripe_sz ? lparam->stripe_sz/2: 128);
+			   lparam->stripe_sz ? lparam->stripe_sz / 2 : 128);
 		seq_printf(m, "Row size:%3d\n", lparam->row_size);
 
 		seq_puts(m, "Read Policy: ");
-		switch(lparam->read_ahead) {
+		switch (lparam->read_ahead) {
 		case NO_READ_AHEAD:
 			seq_puts(m, "No read ahead, ");
 			break;
@@ -2633,11 +2526,10 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 		case ADAP_READ_AHEAD:
 			seq_puts(m, "Adaptive, ");
 			break;
-
 		}
 
 		seq_puts(m, "Write Policy: ");
-		switch(lparam->write_mode) {
+		switch (lparam->write_mode) {
 		case WRMODE_WRITE_THRU:
 			seq_puts(m, "Write thru, ");
 			break;
@@ -2647,7 +2539,7 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 		}
 
 		seq_puts(m, "Cache Policy: ");
-		switch(lparam->direct_io) {
+		switch (lparam->direct_io) {
 		case CACHED_IO:
 			seq_puts(m, "Cached IO\n\n");
 			break;
@@ -2674,13 +2566,11 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
  *
  * Display real time information about the logical drives 0 through 9.
  */
-static int
-proc_show_rdrv_10(struct seq_file *m, void *v)
+static int proc_show_rdrv_10(struct seq_file *m, void *v)
 {
 	return proc_show_rdrv(m, m->private, 0, 9);
 }
 
-
 /**
  * proc_show_rdrv_20()
  * @m: Synthetic file construction data
@@ -2688,13 +2578,11 @@ proc_show_rdrv_10(struct seq_file *m, void *v)
  *
  * Display real time information about the logical drives 0 through 9.
  */
-static int
-proc_show_rdrv_20(struct seq_file *m, void *v)
+static int proc_show_rdrv_20(struct seq_file *m, void *v)
 {
 	return proc_show_rdrv(m, m->private, 10, 19);
 }
 
-
 /**
  * proc_show_rdrv_30()
  * @m: Synthetic file construction data
@@ -2702,13 +2590,11 @@ proc_show_rdrv_20(struct seq_file *m, void *v)
  *
  * Display real time information about the logical drives 0 through 9.
  */
-static int
-proc_show_rdrv_30(struct seq_file *m, void *v)
+static int proc_show_rdrv_30(struct seq_file *m, void *v)
 {
 	return proc_show_rdrv(m, m->private, 20, 29);
 }
 
-
 /**
  * proc_show_rdrv_40()
  * @m: Synthetic file construction data
@@ -2716,8 +2602,7 @@ proc_show_rdrv_30(struct seq_file *m, void *v)
  *
  * Display real time information about the logical drives 0 through 9.
  */
-static int
-proc_show_rdrv_40(struct seq_file *m, void *v)
+static int proc_show_rdrv_40(struct seq_file *m, void *v)
 {
 	return proc_show_rdrv(m, m->private, 30, 39);
 }
@@ -2729,8 +2614,7 @@ proc_show_rdrv_40(struct seq_file *m, void *v)
  *
  * Creates /proc entries for our controllers.
  */
-static void
-mega_create_proc_entry(int index, struct proc_dir_entry *parent)
+static void mega_create_proc_entry(int index, struct proc_dir_entry *parent)
 {
 	adapter_t *adapter = hba_soft_state[index];
 	struct proc_dir_entry *dir;
@@ -2743,82 +2627,80 @@ mega_create_proc_entry(int index, struct proc_dir_entry *parent)
 		return;
 	}
 
-	proc_create_single_data("config", S_IRUSR, dir,
-			proc_show_config, adapter);
-	proc_create_single_data("stat", S_IRUSR, dir,
-			proc_show_stat, adapter);
-	proc_create_single_data("mailbox", S_IRUSR, dir,
-			proc_show_mbox, adapter);
+	proc_create_single_data("config", S_IRUSR, dir, proc_show_config,
+				adapter);
+	proc_create_single_data("stat", S_IRUSR, dir, proc_show_stat, adapter);
+	proc_create_single_data("mailbox", S_IRUSR, dir, proc_show_mbox,
+				adapter);
 #if MEGA_HAVE_ENH_PROC
 	proc_create_single_data("rebuild-rate", S_IRUSR, dir,
-			proc_show_rebuild_rate, adapter);
+				proc_show_rebuild_rate, adapter);
 	proc_create_single_data("battery-status", S_IRUSR, dir,
-			proc_show_battery, adapter);
+				proc_show_battery, adapter);
 	proc_create_single_data("diskdrives-ch0", S_IRUSR, dir,
-			proc_show_pdrv_ch0, adapter);
+				proc_show_pdrv_ch0, adapter);
 	proc_create_single_data("diskdrives-ch1", S_IRUSR, dir,
-			proc_show_pdrv_ch1, adapter);
+				proc_show_pdrv_ch1, adapter);
 	proc_create_single_data("diskdrives-ch2", S_IRUSR, dir,
-			proc_show_pdrv_ch2, adapter);
+				proc_show_pdrv_ch2, adapter);
 	proc_create_single_data("diskdrives-ch3", S_IRUSR, dir,
-			proc_show_pdrv_ch3, adapter);
+				proc_show_pdrv_ch3, adapter);
 	proc_create_single_data("raiddrives-0-9", S_IRUSR, dir,
-			proc_show_rdrv_10, adapter);
+				proc_show_rdrv_10, adapter);
 	proc_create_single_data("raiddrives-10-19", S_IRUSR, dir,
-			proc_show_rdrv_20, adapter);
+				proc_show_rdrv_20, adapter);
 	proc_create_single_data("raiddrives-20-29", S_IRUSR, dir,
-			proc_show_rdrv_30, adapter);
+				proc_show_rdrv_30, adapter);
 	proc_create_single_data("raiddrives-30-39", S_IRUSR, dir,
-			proc_show_rdrv_40, adapter);
+				proc_show_rdrv_40, adapter);
 #endif
 }
 
 #else
-static inline void mega_create_proc_entry(int index, struct proc_dir_entry *parent)
+static inline void mega_create_proc_entry(int index,
+					  struct proc_dir_entry *parent)
 {
 }
 #endif
 
-
 /*
  * megaraid_biosparam()
  *
  * Return the disk geometry for a particular disk
  */
-static int
-megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
-		    sector_t capacity, int geom[])
+static int megaraid_biosparam(struct scsi_device *sdev,
+			      struct block_device *bdev, sector_t capacity,
+			      int geom[])
 {
-	adapter_t	*adapter;
-	int	heads;
-	int	sectors;
-	int	cylinders;
+	adapter_t *adapter;
+	int heads;
+	int sectors;
+	int cylinders;
 
 	/* Get pointer to host config structure */
 	adapter = (adapter_t *)sdev->host->hostdata;
 
 	if (IS_RAID_CH(adapter, sdev->channel)) {
-			/* Default heads (64) & sectors (32) */
-			heads = 64;
-			sectors = 32;
-			cylinders = (ulong)capacity / (heads * sectors);
+		/* Default heads (64) & sectors (32) */
+		heads = 64;
+		sectors = 32;
+		cylinders = (ulong)capacity / (heads * sectors);
 
-			/*
+		/*
 			 * Handle extended translation size for logical drives
 			 * > 1Gb
 			 */
-			if ((ulong)capacity >= 0x200000) {
-				heads = 255;
-				sectors = 63;
-				cylinders = (ulong)capacity / (heads * sectors);
-			}
+		if ((ulong)capacity >= 0x200000) {
+			heads = 255;
+			sectors = 63;
+			cylinders = (ulong)capacity / (heads * sectors);
+		}
 
-			/* return result */
-			geom[0] = heads;
-			geom[1] = sectors;
-			geom[2] = cylinders;
-	}
-	else {
+		/* return result */
+		geom[0] = heads;
+		geom[1] = sectors;
+		geom[2] = cylinders;
+	} else {
 		if (scsi_partsize(bdev, capacity, geom))
 			return 0;
 
@@ -2855,14 +2737,12 @@ megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
  * scatter-gather list pointer, passthru and extended passthru structure
  * pointers.
  */
-static int
-mega_init_scb(adapter_t *adapter)
+static int mega_init_scb(adapter_t *adapter)
 {
-	scb_t	*scb;
-	int	i;
-
-	for( i = 0; i < adapter->max_cmds; i++ ) {
+	scb_t *scb;
+	int i;
 
+	for (i = 0; i < adapter->max_cmds; i++) {
 		scb = &adapter->scb_list[i];
 
 		scb->sgl64 = NULL;
@@ -2871,46 +2751,49 @@ mega_init_scb(adapter_t *adapter)
 		scb->epthru = NULL;
 	}
 
-	for( i = 0; i < adapter->max_cmds; i++ ) {
-
+	for (i = 0; i < adapter->max_cmds; i++) {
 		scb = &adapter->scb_list[i];
 
 		scb->idx = i;
 
-		scb->sgl64 = dma_alloc_coherent(&adapter->dev->dev,
-						sizeof(mega_sgl64) * adapter->sglen,
-						&scb->sgl_dma_addr, GFP_KERNEL);
+		scb->sgl64 =
+			dma_alloc_coherent(&adapter->dev->dev,
+					   sizeof(mega_sgl64) * adapter->sglen,
+					   &scb->sgl_dma_addr, GFP_KERNEL);
 
 		scb->sgl = (mega_sglist *)scb->sgl64;
 
-		if( !scb->sgl ) {
-			dev_warn(&adapter->dev->dev, "RAID: Can't allocate sglist\n");
+		if (!scb->sgl) {
+			dev_warn(&adapter->dev->dev,
+				 "RAID: Can't allocate sglist\n");
 			mega_free_sgl(adapter);
 			return -1;
 		}
 
-		scb->pthru = dma_alloc_coherent(&adapter->dev->dev,
-						sizeof(mega_passthru),
-						&scb->pthru_dma_addr, GFP_KERNEL);
+		scb->pthru =
+			dma_alloc_coherent(&adapter->dev->dev,
+					   sizeof(mega_passthru),
+					   &scb->pthru_dma_addr, GFP_KERNEL);
 
-		if( !scb->pthru ) {
-			dev_warn(&adapter->dev->dev, "RAID: Can't allocate passthru\n");
+		if (!scb->pthru) {
+			dev_warn(&adapter->dev->dev,
+				 "RAID: Can't allocate passthru\n");
 			mega_free_sgl(adapter);
 			return -1;
 		}
 
-		scb->epthru = dma_alloc_coherent(&adapter->dev->dev,
-						 sizeof(mega_ext_passthru),
-						 &scb->epthru_dma_addr, GFP_KERNEL);
+		scb->epthru =
+			dma_alloc_coherent(&adapter->dev->dev,
+					   sizeof(mega_ext_passthru),
+					   &scb->epthru_dma_addr, GFP_KERNEL);
 
-		if( !scb->epthru ) {
+		if (!scb->epthru) {
 			dev_warn(&adapter->dev->dev,
-				"Can't allocate extended passthru\n");
+				 "Can't allocate extended passthru\n");
 			mega_free_sgl(adapter);
 			return -1;
 		}
 
-
 		scb->dma_type = MEGA_DMA_TYPE_NONE;
 
 		/*
@@ -2926,27 +2809,25 @@ mega_init_scb(adapter_t *adapter)
 	return 0;
 }
 
-
 /**
  * megadev_open()
  * @inode: unused
  * @filep: unused
  *
  * Routines for the character/ioctl interface to the driver. Find out if this
- * is a valid open. 
+ * is a valid open.
  */
-static int
-megadev_open (struct inode *inode, struct file *filep)
+static int megadev_open(struct inode *inode, struct file *filep)
 {
 	/*
 	 * Only allow superuser to access private ioctl interface
 	 */
-	if( !capable(CAP_SYS_ADMIN) ) return -EACCES;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 
 	return 0;
 }
 
-
 /**
  * megadev_ioctl()
  * @filep: Our device file
@@ -2958,31 +2839,31 @@ megadev_open (struct inode *inode, struct file *filep)
  * ioctl to new ioctl command), and issue a synchronous command to the
  * controller.
  */
-static int
-megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+static int megadev_ioctl(struct file *filep, unsigned int cmd,
+			 unsigned long arg)
 {
-	adapter_t	*adapter;
-	nitioctl_t	uioc;
-	int		adapno;
-	int		rval;
-	mega_passthru	__user *upthru;	/* user address for passthru */
-	mega_passthru	*pthru;		/* copy user passthru here */
-	dma_addr_t	pthru_dma_hndl;
-	void		*data = NULL;	/* data to be transferred */
-	dma_addr_t	data_dma_hndl;	/* dma handle for data xfer area */
-	megacmd_t	mc;
+	adapter_t *adapter;
+	nitioctl_t uioc;
+	int adapno;
+	int rval;
+	mega_passthru __user *upthru; /* user address for passthru */
+	mega_passthru *pthru; /* copy user passthru here */
+	dma_addr_t pthru_dma_hndl;
+	void *data = NULL; /* data to be transferred */
+	dma_addr_t data_dma_hndl; /* dma handle for data xfer area */
+	megacmd_t mc;
 #if MEGA_HAVE_STATS
-	megastat_t	__user *ustats = NULL;
-	int		num_ldrv = 0;
+	megastat_t __user *ustats = NULL;
+	int num_ldrv = 0;
 #endif
-	u32		uxferaddr = 0;
-	struct pci_dev	*pdev;
+	u32 uxferaddr = 0;
+	struct pci_dev *pdev;
 
 	/*
 	 * Make sure only USCSICMD are issued through this interface.
 	 * MIMD application would still fire different command.
 	 */
-	if( (_IOC_TYPE(cmd) != MEGAIOC_MAGIC) && (cmd != USCSICMD) ) {
+	if ((_IOC_TYPE(cmd) != MEGAIOC_MAGIC) && (cmd != USCSICMD)) {
 		return -EINVAL;
 	}
 
@@ -2995,20 +2876,18 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	 * addresses.
 	 */
 	memset(&uioc, 0, sizeof(nitioctl_t));
-	if( (rval = mega_m_to_n( (void __user *)arg, &uioc)) != 0 )
+	if ((rval = mega_m_to_n((void __user *)arg, &uioc)) != 0)
 		return rval;
 
-
-	switch( uioc.opcode ) {
-
+	switch (uioc.opcode) {
 	case GET_DRIVER_VER:
-		if( put_user(driver_ver, (u32 __user *)uioc.uioc_uaddr) )
+		if (put_user(driver_ver, (u32 __user *)uioc.uioc_uaddr))
 			return (-EFAULT);
 
 		break;
 
 	case GET_N_ADAP:
-		if( put_user(hba_count, (u32 __user *)uioc.uioc_uaddr) )
+		if (put_user(hba_count, (u32 __user *)uioc.uioc_uaddr))
 			return (-EFAULT);
 
 		/*
@@ -3023,11 +2902,11 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
+		if ((adapno = GETADAP(uioc.adapno)) >= hba_count)
 			return (-ENODEV);
 
-		if( copy_to_user(uioc.uioc_uaddr, mcontroller+adapno,
-				sizeof(struct mcontroller)) )
+		if (copy_to_user(uioc.uioc_uaddr, mcontroller + adapno,
+				 sizeof(struct mcontroller)))
 			return (-EFAULT);
 		break;
 
@@ -3037,43 +2916,44 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
+		if ((adapno = GETADAP(uioc.adapno)) >= hba_count)
 			return (-ENODEV);
 
 		adapter = hba_soft_state[adapno];
 
 		ustats = uioc.uioc_uaddr;
 
-		if( copy_from_user(&num_ldrv, &ustats->num_ldrv, sizeof(int)) )
+		if (copy_from_user(&num_ldrv, &ustats->num_ldrv, sizeof(int)))
 			return (-EFAULT);
 
 		/*
 		 * Check for the validity of the logical drive number
 		 */
-		if( num_ldrv >= MAX_LOGICAL_DRIVES_40LD ) return -EINVAL;
+		if (num_ldrv >= MAX_LOGICAL_DRIVES_40LD)
+			return -EINVAL;
 
-		if( copy_to_user(ustats->nreads, adapter->nreads,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->nreads, adapter->nreads,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
-		if( copy_to_user(ustats->nreadblocks, adapter->nreadblocks,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->nreadblocks, adapter->nreadblocks,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
-		if( copy_to_user(ustats->nwrites, adapter->nwrites,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->nwrites, adapter->nwrites,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
-		if( copy_to_user(ustats->nwriteblocks, adapter->nwriteblocks,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->nwriteblocks, adapter->nwriteblocks,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
-		if( copy_to_user(ustats->rd_errors, adapter->rd_errors,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->rd_errors, adapter->rd_errors,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
-		if( copy_to_user(ustats->wr_errors, adapter->wr_errors,
-					num_ldrv*sizeof(u32)) )
+		if (copy_to_user(ustats->wr_errors, adapter->wr_errors,
+				 num_ldrv * sizeof(u32)))
 			return -EFAULT;
 
 		return 0;
@@ -3084,7 +2964,7 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
+		if ((adapno = GETADAP(uioc.adapno)) >= hba_count)
 			return (-ENODEV);
 
 		adapter = hba_soft_state[adapno];
@@ -3093,22 +2973,22 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		 * Deletion of logical drive is a special case. The adapter
 		 * should be quiescent before this command is issued.
 		 */
-		if( uioc.uioc_rmbox[0] == FC_DEL_LOGDRV &&
-				uioc.uioc_rmbox[2] == OP_DEL_LOGDRV ) {
-
+		if (uioc.uioc_rmbox[0] == FC_DEL_LOGDRV &&
+		    uioc.uioc_rmbox[2] == OP_DEL_LOGDRV) {
 			/*
 			 * Do we support this feature
 			 */
-			if( !adapter->support_random_del ) {
-				dev_warn(&adapter->dev->dev, "logdrv "
-					"delete on non-supporting F/W\n");
+			if (!adapter->support_random_del) {
+				dev_warn(&adapter->dev->dev,
+					 "logdrv "
+					 "delete on non-supporting F/W\n");
 
 				return (-EINVAL);
 			}
 
-			rval = mega_del_logdrv( adapter, uioc.uioc_rmbox[3] );
+			rval = mega_del_logdrv(adapter, uioc.uioc_rmbox[3]);
 
-			if( rval == 0 ) {
+			if (rval == 0) {
 				memset(&mc, 0, sizeof(megacmd_t));
 
 				mc.status = rval;
@@ -3122,9 +3002,8 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		 * This interface only support the regular passthru commands.
 		 * Reject extended passthru and 64-bit passthru
 		 */
-		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU64 ||
-			uioc.uioc_rmbox[0] == MEGA_MBOXCMD_EXTPTHRU ) {
-
+		if (uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU64 ||
+		    uioc.uioc_rmbox[0] == MEGA_MBOXCMD_EXTPTHRU) {
 			dev_warn(&adapter->dev->dev, "rejected passthru\n");
 
 			return (-EINVAL);
@@ -3134,18 +3013,18 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		 * For all internal commands, the buffer must be allocated in
 		 * <4GB address range
 		 */
-		if( make_local_pdev(adapter, &pdev) != 0 )
+		if (make_local_pdev(adapter, &pdev) != 0)
 			return -EIO;
 
 		/* Is it a passthru command or a DCMD */
-		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
+		if (uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU) {
 			/* Passthru commands */
 
 			pthru = dma_alloc_coherent(&pdev->dev,
 						   sizeof(mega_passthru),
 						   &pthru_dma_hndl, GFP_KERNEL);
 
-			if( pthru == NULL ) {
+			if (pthru == NULL) {
 				free_local_pdev(pdev);
 				return (-ENOMEM);
 			}
@@ -3153,17 +3032,18 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			/*
 			 * The user passthru structure
 			 */
-			upthru = (mega_passthru __user *)(unsigned long)MBOX(uioc)->xferaddr;
+			upthru = (mega_passthru __user *)(unsigned long)MBOX(
+					 uioc)
+					 ->xferaddr;
 
 			/*
 			 * Copy in the user passthru here.
 			 */
-			if( copy_from_user(pthru, upthru,
-						sizeof(mega_passthru)) ) {
-
+			if (copy_from_user(pthru, upthru,
+					   sizeof(mega_passthru))) {
 				dma_free_coherent(&pdev->dev,
-						  sizeof(mega_passthru),
-						  pthru, pthru_dma_hndl);
+						  sizeof(mega_passthru), pthru,
+						  pthru_dma_hndl);
 
 				free_local_pdev(pdev);
 
@@ -3173,13 +3053,13 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			/*
 			 * Is there a data transfer
 			 */
-			if( pthru->dataxferlen ) {
+			if (pthru->dataxferlen) {
 				data = dma_alloc_coherent(&pdev->dev,
 							  pthru->dataxferlen,
 							  &data_dma_hndl,
 							  GFP_KERNEL);
 
-				if( data == NULL ) {
+				if (data == NULL) {
 					dma_free_coherent(&pdev->dev,
 							  sizeof(mega_passthru),
 							  pthru,
@@ -3198,16 +3078,17 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 				pthru->dataxferaddr = data_dma_hndl;
 			}
 
-
 			/*
 			 * Is data coming down-stream
 			 */
-			if( pthru->dataxferlen && (uioc.flags & UIOC_WR) ) {
+			if (pthru->dataxferlen && (uioc.flags & UIOC_WR)) {
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char __user *)(unsigned long) uxferaddr,
-							pthru->dataxferlen) ) {
+				if (copy_from_user(data,
+						   (char __user *)(unsigned long)
+							   uxferaddr,
+						   pthru->dataxferlen)) {
 					rval = (-EFAULT);
 					goto freemem_and_return;
 				}
@@ -3225,15 +3106,16 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 			rval = mega_n_to_m((void __user *)arg, &mc);
 
-			if( rval ) goto freemem_and_return;
-
+			if (rval)
+				goto freemem_and_return;
 
 			/*
 			 * Is data going up-stream
 			 */
-			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char __user *)(unsigned long) uxferaddr, data,
-							pthru->dataxferlen) ) {
+			if (pthru->dataxferlen && (uioc.flags & UIOC_RD)) {
+				if (copy_to_user((char __user *)(unsigned long)
+							 uxferaddr,
+						 data, pthru->dataxferlen)) {
 					rval = (-EFAULT);
 				}
 			}
@@ -3243,11 +3125,11 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			 * whether the user has asked for it or not.
 			 */
 			if (copy_to_user(upthru->reqsensearea,
-					pthru->reqsensearea, 14))
+					 pthru->reqsensearea, 14))
 				rval = -EFAULT;
 
-freemem_and_return:
-			if( pthru->dataxferlen ) {
+		freemem_and_return:
+			if (pthru->dataxferlen) {
 				dma_free_coherent(&pdev->dev,
 						  pthru->dataxferlen, data,
 						  data_dma_hndl);
@@ -3259,20 +3141,19 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			free_local_pdev(pdev);
 
 			return rval;
-		}
-		else {
+		} else {
 			/* DCMD commands */
 
 			/*
 			 * Is there a data transfer
 			 */
-			if( uioc.xferlen ) {
+			if (uioc.xferlen) {
 				data = dma_alloc_coherent(&pdev->dev,
 							  uioc.xferlen,
 							  &data_dma_hndl,
 							  GFP_KERNEL);
 
-				if( data == NULL ) {
+				if (data == NULL) {
 					free_local_pdev(pdev);
 					return (-ENOMEM);
 				}
@@ -3283,13 +3164,14 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			/*
 			 * Is data coming down-stream
 			 */
-			if( uioc.xferlen && (uioc.flags & UIOC_WR) ) {
+			if (uioc.xferlen && (uioc.flags & UIOC_WR)) {
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char __user *)(unsigned long) uxferaddr,
-							uioc.xferlen) ) {
-
+				if (copy_from_user(data,
+						   (char __user *)(unsigned long)
+							   uxferaddr,
+						   uioc.xferlen)) {
 					dma_free_coherent(&pdev->dev,
 							  uioc.xferlen, data,
 							  data_dma_hndl);
@@ -3311,8 +3193,8 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 			rval = mega_n_to_m((void __user *)arg, &mc);
 
-			if( rval ) {
-				if( uioc.xferlen ) {
+			if (rval) {
+				if (uioc.xferlen) {
 					dma_free_coherent(&pdev->dev,
 							  uioc.xferlen, data,
 							  data_dma_hndl);
@@ -3326,15 +3208,15 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			/*
 			 * Is data going up-stream
 			 */
-			if( uioc.xferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char __user *)(unsigned long) uxferaddr, data,
-							uioc.xferlen) ) {
-
+			if (uioc.xferlen && (uioc.flags & UIOC_RD)) {
+				if (copy_to_user((char __user *)(unsigned long)
+							 uxferaddr,
+						 data, uioc.xferlen)) {
 					rval = (-EFAULT);
 				}
 			}
 
-			if( uioc.xferlen ) {
+			if (uioc.xferlen) {
 				dma_free_coherent(&pdev->dev, uioc.xferlen,
 						  data, data_dma_hndl);
 			}
@@ -3351,8 +3233,8 @@ megadev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static long
-megadev_unlocked_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+static long megadev_unlocked_ioctl(struct file *filep, unsigned int cmd,
+				   unsigned long arg)
 {
 	int ret;
 
@@ -3373,14 +3255,12 @@ megadev_unlocked_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
  *
  * Converts the older mimd ioctl structure to newer NIT structure
  */
-static int
-mega_m_to_n(void __user *arg, nitioctl_t *uioc)
+static int mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 {
-	struct uioctl_t	uioc_mimd;
-	char	signature[8] = {0};
-	u8	opcode;
-	u8	subopcode;
-
+	struct uioctl_t uioc_mimd;
+	char signature[8] = { 0 };
+	u8 opcode;
+	u8 subopcode;
 
 	/*
 	 * check is the application conforms to NIT. We do not have to do much
@@ -3389,11 +3269,10 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 	 * beginning of the structure.
 	 */
 
-	if( copy_from_user(signature, arg, 7) )
+	if (copy_from_user(signature, arg, 7))
 		return (-EFAULT);
 
-	if( memcmp(signature, "MEGANIT", 7) == 0 ) {
-
+	if (memcmp(signature, "MEGANIT", 7) == 0) {
 		/*
 		 * NOTE NOTE: The nit ioctl is still under flux because of
 		 * change of mailbox definition, in HPE. No applications yet
@@ -3402,7 +3281,7 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 		 */
 		return -EINVAL;
 #if 0
-		if( copy_from_user(uioc, arg, sizeof(nitioctl_t)) )
+		if (copy_from_user(uioc, arg, sizeof(nitioctl_t)))
 			return (-EFAULT);
 		return 0;
 #endif
@@ -3413,10 +3292,9 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 	 *
 	 * Get the user ioctl structure
 	 */
-	if( copy_from_user(&uioc_mimd, arg, sizeof(struct uioctl_t)) )
+	if (copy_from_user(&uioc_mimd, arg, sizeof(struct uioctl_t)))
 		return (-EFAULT);
 
-
 	/*
 	 * Get the opcode and subopcode for the commands
 	 */
@@ -3427,30 +3305,28 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 	case 0x82:
 
 		switch (subopcode) {
-
-		case MEGAIOC_QDRVRVER:	/* Query driver version */
+		case MEGAIOC_QDRVRVER: /* Query driver version */
 			uioc->opcode = GET_DRIVER_VER;
 			uioc->uioc_uaddr = uioc_mimd.data;
 			break;
 
-		case MEGAIOC_QNADAP:	/* Get # of adapters */
+		case MEGAIOC_QNADAP: /* Get # of adapters */
 			uioc->opcode = GET_N_ADAP;
 			uioc->uioc_uaddr = uioc_mimd.data;
 			break;
 
-		case MEGAIOC_QADAPINFO:	/* Get adapter information */
+		case MEGAIOC_QADAPINFO: /* Get adapter information */
 			uioc->opcode = GET_ADAP_INFO;
 			uioc->adapno = uioc_mimd.ui.fcs.adapno;
 			uioc->uioc_uaddr = uioc_mimd.data;
 			break;
 
 		default:
-			return(-EINVAL);
+			return (-EINVAL);
 		}
 
 		break;
 
-
 	case 0x81:
 
 		uioc->opcode = MBOX_CMD;
@@ -3460,8 +3336,10 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 
 		uioc->xferlen = uioc_mimd.ui.fcs.length;
 
-		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
-		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
+		if (uioc_mimd.outlen)
+			uioc->flags = UIOC_RD;
+		if (uioc_mimd.inlen)
+			uioc->flags |= UIOC_WR;
 
 		break;
 
@@ -3476,16 +3354,18 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 		 * Choose the xferlen bigger of input and output data
 		 */
 		uioc->xferlen = uioc_mimd.outlen > uioc_mimd.inlen ?
-			uioc_mimd.outlen : uioc_mimd.inlen;
+					uioc_mimd.outlen :
+					      uioc_mimd.inlen;
 
-		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
-		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
+		if (uioc_mimd.outlen)
+			uioc->flags = UIOC_RD;
+		if (uioc_mimd.inlen)
+			uioc->flags |= UIOC_WR;
 
 		break;
 
 	default:
 		return (-EINVAL);
-
 	}
 
 	return 0;
@@ -3499,53 +3379,52 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
  * Updates the status information to the application, depending on application
  * conforms to older mimd ioctl interface or newer NIT ioctl interface
  */
-static int
-mega_n_to_m(void __user *arg, megacmd_t *mc)
+static int mega_n_to_m(void __user *arg, megacmd_t *mc)
 {
-	nitioctl_t	__user *uiocp;
-	megacmd_t	__user *umc;
-	mega_passthru	__user *upthru;
-	struct uioctl_t	__user *uioc_mimd;
-	char	signature[8] = {0};
+	nitioctl_t __user *uiocp;
+	megacmd_t __user *umc;
+	mega_passthru __user *upthru;
+	struct uioctl_t __user *uioc_mimd;
+	char signature[8] = { 0 };
 
 	/*
 	 * check is the application conforms to NIT.
 	 */
-	if( copy_from_user(signature, arg, 7) )
+	if (copy_from_user(signature, arg, 7))
 		return -EFAULT;
 
-	if( memcmp(signature, "MEGANIT", 7) == 0 ) {
-
+	if (memcmp(signature, "MEGANIT", 7) == 0) {
 		uiocp = arg;
 
-		if( put_user(mc->status, (u8 __user *)&MBOX_P(uiocp)->status) )
+		if (put_user(mc->status, (u8 __user *)&MBOX_P(uiocp)->status))
 			return (-EFAULT);
 
-		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {
-
+		if (mc->cmd == MEGA_MBOXCMD_PASSTHRU) {
 			umc = MBOX_P(uiocp);
 
-			if (get_user(upthru, (mega_passthru __user * __user *)&umc->xferaddr))
+			if (get_user(upthru, (mega_passthru __user *
+					      __user *)&umc->xferaddr))
 				return -EFAULT;
 
-			if( put_user(mc->status, (u8 __user *)&upthru->scsistatus))
+			if (put_user(mc->status,
+				     (u8 __user *)&upthru->scsistatus))
 				return (-EFAULT);
 		}
-	}
-	else {
+	} else {
 		uioc_mimd = arg;
 
-		if( put_user(mc->status, (u8 __user *)&uioc_mimd->mbox[17]) )
+		if (put_user(mc->status, (u8 __user *)&uioc_mimd->mbox[17]))
 			return (-EFAULT);
 
-		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {
-
+		if (mc->cmd == MEGA_MBOXCMD_PASSTHRU) {
 			umc = (megacmd_t __user *)uioc_mimd->mbox;
 
-			if (get_user(upthru, (mega_passthru __user * __user *)&umc->xferaddr))
+			if (get_user(upthru, (mega_passthru __user *
+					      __user *)&umc->xferaddr))
 				return (-EFAULT);
 
-			if( put_user(mc->status, (u8 __user *)&upthru->scsistatus) )
+			if (put_user(mc->status,
+				     (u8 __user *)&upthru->scsistatus))
 				return (-EFAULT);
 		}
 	}
@@ -3553,7 +3432,6 @@ mega_n_to_m(void __user *arg, megacmd_t *mc)
 	return 0;
 }
 
-
 /*
  * MEGARAID 'FW' commands.
  */
@@ -3564,11 +3442,10 @@ mega_n_to_m(void __user *arg, megacmd_t *mc)
  *
  * issue command to find out if the BIOS is enabled for this controller
  */
-static int
-mega_is_bios_enabled(adapter_t *adapter)
+static int mega_is_bios_enabled(adapter_t *adapter)
 {
 	struct mbox_out mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 
 	memset(&mbox, 0, sizeof(mbox));
 
@@ -3584,7 +3461,6 @@ mega_is_bios_enabled(adapter_t *adapter)
 	return *(char *)adapter->mega_buffer;
 }
 
-
 /**
  * mega_enum_raid_scsi()
  * @adapter: pointer to our soft state
@@ -3593,11 +3469,10 @@ mega_is_bios_enabled(adapter_t *adapter)
  * differentiate the virtual channels and physical channels and to support
  * ROMB feature and non-disk devices.
  */
-static void
-mega_enum_raid_scsi(adapter_t *adapter)
+static void mega_enum_raid_scsi(adapter_t *adapter)
 {
 	struct mbox_out mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 	int i;
 
 	memset(&mbox, 0, sizeof(mbox));
@@ -3618,26 +3493,23 @@ mega_enum_raid_scsi(adapter_t *adapter)
 	 */
 	adapter->mega_ch_class = 0xFF;
 
-	if(!issue_scb_block(adapter, raw_mbox)) {
+	if (!issue_scb_block(adapter, raw_mbox)) {
 		adapter->mega_ch_class = *((char *)adapter->mega_buffer);
-
 	}
 
-	for( i = 0; i < adapter->product_info.nchannels; i++ ) { 
-		if( (adapter->mega_ch_class >> i) & 0x01 ) {
+	for (i = 0; i < adapter->product_info.nchannels; i++) {
+		if ((adapter->mega_ch_class >> i) & 0x01) {
 			dev_info(&adapter->dev->dev, "channel[%d] is raid\n",
-					i);
-		}
-		else {
+				 i);
+		} else {
 			dev_info(&adapter->dev->dev, "channel[%d] is scsi\n",
-					i);
+				 i);
 		}
 	}
 
 	return;
 }
 
-
 /**
  * mega_get_boot_drv()
  * @adapter: pointer to our soft state
@@ -3645,16 +3517,15 @@ mega_enum_raid_scsi(adapter_t *adapter)
  * Find out which device is the boot device. Note, any logical drive or any
  * phyical device (e.g., a CDROM) can be designated as a boot device.
  */
-static void
-mega_get_boot_drv(adapter_t *adapter)
+static void mega_get_boot_drv(adapter_t *adapter)
 {
-	struct private_bios_data	*prv_bios_data;
+	struct private_bios_data *prv_bios_data;
 	struct mbox_out mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
-	u16	cksum = 0;
-	u8	*cksum_p;
-	u8	boot_pdrv;
-	int	i;
+	unsigned char *raw_mbox = (u8 *)&mbox;
+	u16 cksum = 0;
+	u8 *cksum_p;
+	u8 boot_pdrv;
+	int i;
 
 	memset(&mbox, 0, sizeof(mbox));
 
@@ -3672,35 +3543,32 @@ mega_get_boot_drv(adapter_t *adapter)
 	adapter->boot_pdrv_ch = 0;
 	adapter->boot_pdrv_tgt = 0;
 
-	if(issue_scb_block(adapter, raw_mbox) == 0) {
+	if (issue_scb_block(adapter, raw_mbox) == 0) {
 		prv_bios_data =
 			(struct private_bios_data *)adapter->mega_buffer;
 
 		cksum = 0;
 		cksum_p = (char *)prv_bios_data;
-		for (i = 0; i < 14; i++ ) {
+		for (i = 0; i < 14; i++) {
 			cksum += (u16)(*cksum_p++);
 		}
 
-		if (prv_bios_data->cksum == (u16)(0-cksum) ) {
-
+		if (prv_bios_data->cksum == (u16)(0 - cksum)) {
 			/*
 			 * If MSB is set, a physical drive is set as boot
 			 * device
 			 */
-			if( prv_bios_data->boot_drv & 0x80 ) {
+			if (prv_bios_data->boot_drv & 0x80) {
 				adapter->boot_pdrv_enabled = 1;
 				boot_pdrv = prv_bios_data->boot_drv & 0x7F;
 				adapter->boot_pdrv_ch = boot_pdrv / 16;
 				adapter->boot_pdrv_tgt = boot_pdrv % 16;
-			}
-			else {
+			} else {
 				adapter->boot_ldrv_enabled = 1;
 				adapter->boot_ldrv = prv_bios_data->boot_drv;
 			}
 		}
 	}
-
 }
 
 /**
@@ -3710,11 +3578,10 @@ mega_get_boot_drv(adapter_t *adapter)
  * Find out if this controller supports random deletion and addition of
  * logical drives
  */
-static int
-mega_support_random_del(adapter_t *adapter)
+static int mega_support_random_del(adapter_t *adapter)
 {
 	struct mbox_out mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 	int rval;
 
 	memset(&mbox, 0, sizeof(mbox));
@@ -3730,18 +3597,16 @@ mega_support_random_del(adapter_t *adapter)
 	return !rval;
 }
 
-
 /**
  * mega_support_ext_cdb()
  * @adapter: pointer to our soft state
  *
  * Find out if this firmware support cdblen > 10
  */
-static int
-mega_support_ext_cdb(adapter_t *adapter)
+static int mega_support_ext_cdb(adapter_t *adapter)
 {
 	struct mbox_out mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 	int rval;
 
 	memset(&mbox, 0, sizeof(mbox));
@@ -3756,7 +3621,6 @@ mega_support_ext_cdb(adapter_t *adapter)
 	return !rval;
 }
 
-
 /**
  * mega_del_logdrv()
  * @adapter: pointer to our soft state
@@ -3765,8 +3629,7 @@ mega_support_ext_cdb(adapter_t *adapter)
  * Delete the specified logical drive. It is the responsibility of the user
  * app to let the OS know about this operation.
  */
-static int
-mega_del_logdrv(adapter_t *adapter, int logdrv)
+static int mega_del_logdrv(adapter_t *adapter, int logdrv)
 {
 	unsigned long flags;
 	scb_t *scb;
@@ -3784,7 +3647,7 @@ mega_del_logdrv(adapter_t *adapter, int logdrv)
 	 */
 	while (atomic_read(&adapter->pend_cmds) > 0 ||
 	       !list_empty(&adapter->pending_list))
-		msleep(1000);	/* sleep for 1s */
+		msleep(1000); /* sleep for 1s */
 
 	rval = mega_do_del_logdrv(adapter, logdrv);
 
@@ -3796,9 +3659,9 @@ mega_del_logdrv(adapter_t *adapter, int logdrv)
 	 */
 	if (adapter->read_ldidmap) {
 		struct list_head *pos;
-		list_for_each(pos, &adapter->pending_list) {
+		list_for_each (pos, &adapter->pending_list) {
 			scb = list_entry(pos, scb_t, list);
-			if (scb->pthru->logdrv < 0x80 )
+			if (scb->pthru->logdrv < 0x80)
 				scb->pthru->logdrv += 0x80;
 		}
 	}
@@ -3812,14 +3675,12 @@ mega_del_logdrv(adapter_t *adapter, int logdrv)
 	return rval;
 }
 
-
-static int
-mega_do_del_logdrv(adapter_t *adapter, int logdrv)
+static int mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 {
-	megacmd_t	mc;
-	int	rval;
+	megacmd_t mc;
+	int rval;
 
-	memset( &mc, 0, sizeof(megacmd_t));
+	memset(&mc, 0, sizeof(megacmd_t));
 
 	mc.cmd = FC_DEL_LOGDRV;
 	mc.opcode = OP_DEL_LOGDRV;
@@ -3828,7 +3689,7 @@ mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 	rval = mega_internal_command(adapter, &mc, NULL);
 
 	/* log this event */
-	if(rval) {
+	if (rval) {
 		dev_warn(&adapter->dev->dev, "Delete LD-%d failed", logdrv);
 		return rval;
 	}
@@ -3842,7 +3703,6 @@ mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 	return rval;
 }
 
-
 /**
  * mega_get_max_sgl()
  * @adapter: pointer to our soft state
@@ -3850,11 +3710,10 @@ mega_do_del_logdrv(adapter_t *adapter, int logdrv)
  * Find out the maximum number of scatter-gather elements supported by this
  * version of the firmware
  */
-static void
-mega_get_max_sgl(adapter_t *adapter)
+static void mega_get_max_sgl(adapter_t *adapter)
 {
-	struct mbox_out	mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	struct mbox_out mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 
 	memset(&mbox, 0, sizeof(mbox));
 
@@ -3865,39 +3724,35 @@ mega_get_max_sgl(adapter_t *adapter)
 	raw_mbox[0] = MAIN_MISC_OPCODE;
 	raw_mbox[2] = GET_MAX_SG_SUPPORT;
 
-
-	if( issue_scb_block(adapter, raw_mbox) ) {
+	if (issue_scb_block(adapter, raw_mbox)) {
 		/*
 		 * f/w does not support this command. Choose the default value
 		 */
 		adapter->sglen = MIN_SGLIST;
-	}
-	else {
+	} else {
 		adapter->sglen = *((char *)adapter->mega_buffer);
 
 		/*
 		 * Make sure this is not more than the resources we are
 		 * planning to allocate
 		 */
-		if ( adapter->sglen > MAX_SGLIST )
+		if (adapter->sglen > MAX_SGLIST)
 			adapter->sglen = MAX_SGLIST;
 	}
 
 	return;
 }
 
-
 /**
  * mega_support_cluster()
  * @adapter: pointer to our soft state
  *
  * Find out if this firmware support cluster calls.
  */
-static int
-mega_support_cluster(adapter_t *adapter)
+static int mega_support_cluster(adapter_t *adapter)
 {
-	struct mbox_out	mbox;
-	unsigned char	*raw_mbox = (u8 *)&mbox;
+	struct mbox_out mbox;
+	unsigned char *raw_mbox = (u8 *)&mbox;
 
 	memset(&mbox, 0, sizeof(mbox));
 
@@ -3911,8 +3766,7 @@ mega_support_cluster(adapter_t *adapter)
 	 */
 	raw_mbox[0] = MEGA_GET_TARGET_ID;
 
-	if( issue_scb_block(adapter, raw_mbox) == 0 ) {
-
+	if (issue_scb_block(adapter, raw_mbox) == 0) {
 		/*
 		 * Cluster support available. Get the initiator target id.
 		 * Tell our id to mid-layer too.
@@ -3936,32 +3790,29 @@ mega_support_cluster(adapter_t *adapter)
  * We only issue direct mailbox commands from within the driver. ioctl()
  * interface using these routines can issue passthru commands.
  */
-static int
-mega_adapinq(adapter_t *adapter, dma_addr_t dma_handle)
+static int mega_adapinq(adapter_t *adapter, dma_addr_t dma_handle)
 {
-	megacmd_t	mc;
+	megacmd_t mc;
 
 	memset(&mc, 0, sizeof(megacmd_t));
 
-	if( adapter->flag & BOARD_40LD ) {
+	if (adapter->flag & BOARD_40LD) {
 		mc.cmd = FC_NEW_CONFIG;
 		mc.opcode = NC_SUBOP_ENQUIRY3;
 		mc.subopcode = ENQ3_GET_SOLICITED_FULL;
-	}
-	else {
+	} else {
 		mc.cmd = MEGA_MBOXCMD_ADPEXTINQ;
 	}
 
 	mc.xferaddr = (u32)dma_handle;
 
-	if ( mega_internal_command(adapter, &mc, NULL) != 0 ) {
+	if (mega_internal_command(adapter, &mc, NULL) != 0) {
 		return -1;
 	}
 
 	return 0;
 }
 
-
 /**
  * mega_internal_dev_inquiry()
  * @adapter: pointer to our soft state
@@ -3971,27 +3822,26 @@ mega_adapinq(adapter_t *adapter, dma_addr_t dma_handle)
  *
  * Issue the scsi inquiry for the specified device.
  */
-static int
-mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
-		dma_addr_t buf_dma_handle)
+static int mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
+				     dma_addr_t buf_dma_handle)
 {
-	mega_passthru	*pthru;
-	dma_addr_t	pthru_dma_handle;
-	megacmd_t	mc;
-	int		rval;
-	struct pci_dev	*pdev;
-
+	mega_passthru *pthru;
+	dma_addr_t pthru_dma_handle;
+	megacmd_t mc;
+	int rval;
+	struct pci_dev *pdev;
 
 	/*
 	 * For all internal commands, the buffer must be allocated in <4GB
 	 * address range
 	 */
-	if( make_local_pdev(adapter, &pdev) != 0 ) return -1;
+	if (make_local_pdev(adapter, &pdev) != 0)
+		return -1;
 
 	pthru = dma_alloc_coherent(&pdev->dev, sizeof(mega_passthru),
 				   &pthru_dma_handle, GFP_KERNEL);
 
-	if( pthru == NULL ) {
+	if (pthru == NULL) {
 		free_local_pdev(pdev);
 		return -1;
 	}
@@ -4003,7 +3853,7 @@ mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
 
 	pthru->channel = (adapter->flag & BOARD_40LD) ? 0 : ch;
 
-	pthru->target = (adapter->flag & BOARD_40LD) ? (ch << 4)|tgt : tgt;
+	pthru->target = (adapter->flag & BOARD_40LD) ? (ch << 4) | tgt : tgt;
 
 	pthru->cdblen = 6;
 
@@ -4014,7 +3864,6 @@ mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
 	pthru->cdb[4] = 255;
 	pthru->cdb[5] = 0;
 
-
 	pthru->dataxferaddr = (u32)buf_dma_handle;
 	pthru->dataxferlen = 256;
 
@@ -4046,12 +3895,12 @@ mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
  *
  * Note: parameter 'pthru' is null for non-passthru commands.
  */
-static int
-mega_internal_command(adapter_t *adapter, megacmd_t *mc, mega_passthru *pthru)
+static int mega_internal_command(adapter_t *adapter, megacmd_t *mc,
+				 mega_passthru *pthru)
 {
 	unsigned long flags;
-	scb_t	*scb;
-	int	rval;
+	scb_t *scb;
+	int rval;
 
 	/*
 	 * The internal commands share one command id and hence are
@@ -4095,7 +3944,7 @@ mega_internal_command(adapter_t *adapter, megacmd_t *mc, mega_passthru *pthru)
 	 */
 	if (rval && trace_level) {
 		dev_info(&adapter->dev->dev, "cmd [%x, %x, %x] status:[%x]\n",
-			mc->cmd, mc->opcode, mc->subopcode, rval);
+			 mc->cmd, mc->opcode, mc->subopcode, rval);
 	}
 
 	mutex_unlock(&adapter->int_mtx);
@@ -4103,26 +3952,26 @@ mega_internal_command(adapter_t *adapter, megacmd_t *mc, mega_passthru *pthru)
 }
 
 static struct scsi_host_template megaraid_template = {
-	.module				= THIS_MODULE,
-	.name				= "MegaRAID",
-	.proc_name			= "megaraid_legacy",
-	.info				= megaraid_info,
-	.queuecommand			= megaraid_queue,	
-	.bios_param			= megaraid_biosparam,
-	.max_sectors			= MAX_SECTORS_PER_IO,
-	.can_queue			= MAX_COMMANDS,
-	.this_id			= DEFAULT_INITIATOR_ID,
-	.sg_tablesize			= MAX_SGLIST,
-	.cmd_per_lun			= DEF_CMD_PER_LUN,
-	.eh_abort_handler		= megaraid_abort,
-	.eh_device_reset_handler	= megaraid_reset,
-	.eh_bus_reset_handler		= megaraid_reset,
-	.eh_host_reset_handler		= megaraid_reset,
-	.no_write_same			= 1,
+	.module = THIS_MODULE,
+	.name = "MegaRAID",
+	.proc_name = "megaraid_legacy",
+	.info = megaraid_info,
+	.queuecommand = megaraid_queue,
+	.bios_param = megaraid_biosparam,
+	.max_sectors = MAX_SECTORS_PER_IO,
+	.can_queue = MAX_COMMANDS,
+	.this_id = DEFAULT_INITIATOR_ID,
+	.sg_tablesize = MAX_SGLIST,
+	.cmd_per_lun = DEF_CMD_PER_LUN,
+	.eh_abort_handler = megaraid_abort,
+	.eh_device_reset_handler = megaraid_reset,
+	.eh_bus_reset_handler = megaraid_reset,
+	.eh_host_reset_handler = megaraid_reset,
+	.no_write_same = 1,
 };
 
-static int
-megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
+static int megaraid_probe_one(struct pci_dev *pdev,
+			      const struct pci_device_id *id)
 {
 	struct Scsi_Host *host;
 	adapter_t *adapter;
@@ -4179,8 +4028,8 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	subsysvid = pdev->subsystem_vendor;
 	subsysid = pdev->subsystem_device;
 
-	dev_notice(&pdev->dev, "found 0x%4.04x:0x%4.04x\n",
-		id->vendor, id->device);
+	dev_notice(&pdev->dev, "found 0x%4.04x:0x%4.04x\n", id->vendor,
+		   id->device);
 
 	/* Read the base port and IRQ from PCI */
 	mega_baseport = pci_resource_start(pdev, 0);
@@ -4217,12 +4066,12 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	memset(adapter, 0, sizeof(adapter_t));
 
 	dev_notice(&pdev->dev,
-		"scsi%d:Found MegaRAID controller at 0x%lx, IRQ:%d\n",
-		host->host_no, mega_baseport, irq);
+		   "scsi%d:Found MegaRAID controller at 0x%lx, IRQ:%d\n",
+		   host->host_no, mega_baseport, irq);
 
 	adapter->base = mega_baseport;
 	if (flag & BOARD_MEMMAP)
-		adapter->mmio_base = (void __iomem *) mega_baseport;
+		adapter->mmio_base = (void __iomem *)mega_baseport;
 
 	INIT_LIST_HEAD(&adapter->free_list);
 	INIT_LIST_HEAD(&adapter->pending_list);
@@ -4251,25 +4100,26 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/*
 	 * Allocate buffer to issue internal commands.
 	 */
-	adapter->mega_buffer = dma_alloc_coherent(&adapter->dev->dev,
-						  MEGA_BUFFER_SIZE,
-						  &adapter->buf_dma_handle,
-						  GFP_KERNEL);
+	adapter->mega_buffer =
+		dma_alloc_coherent(&adapter->dev->dev, MEGA_BUFFER_SIZE,
+				   &adapter->buf_dma_handle, GFP_KERNEL);
 	if (!adapter->mega_buffer) {
 		dev_warn(&pdev->dev, "out of RAM\n");
 		goto out_host_put;
 	}
 
-	adapter->scb_list = kmalloc_array(MAX_COMMANDS, sizeof(scb_t),
-					  GFP_KERNEL);
+	adapter->scb_list =
+		kmalloc_array(MAX_COMMANDS, sizeof(scb_t), GFP_KERNEL);
 	if (!adapter->scb_list) {
 		dev_warn(&pdev->dev, "out of RAM\n");
 		goto out_free_cmd_buffer;
 	}
 
-	if (request_irq(irq, (adapter->flag & BOARD_MEMMAP) ?
-				megaraid_isr_memmapped : megaraid_isr_iomapped,
-					IRQF_SHARED, "megaraid", adapter)) {
+	if (request_irq(irq,
+			(adapter->flag & BOARD_MEMMAP) ?
+				megaraid_isr_memmapped :
+				      megaraid_isr_iomapped,
+			IRQF_SHARED, "megaraid", adapter)) {
 		dev_warn(&pdev->dev, "Couldn't register IRQ %d!\n", irq);
 		goto out_free_scb_list;
 	}
@@ -4288,24 +4138,22 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		 * Which firmware
 		 */
 		if (!strcmp(adapter->fw_version, "3.00") ||
-				!strcmp(adapter->fw_version, "3.01")) {
-
+		    !strcmp(adapter->fw_version, "3.01")) {
 			dev_warn(&pdev->dev,
-				"Your card is a Dell PERC "
-				"2/SC RAID controller with "
-				"firmware\nmegaraid: 3.00 or 3.01.  "
-				"This driver is known to have "
-				"corruption issues\nmegaraid: with "
-				"those firmware versions on this "
-				"specific card.  In order\nmegaraid: "
-				"to protect your data, please upgrade "
-				"your firmware to version\nmegaraid: "
-				"3.10 or later, available from the "
-				"Dell Technical Support web\n"
-				"megaraid: site at\nhttp://support."
-				"dell.com/us/en/filelib/download/"
-				"index.asp?fileid=2940\n"
-			);
+				 "Your card is a Dell PERC "
+				 "2/SC RAID controller with "
+				 "firmware\nmegaraid: 3.00 or 3.01.  "
+				 "This driver is known to have "
+				 "corruption issues\nmegaraid: with "
+				 "those firmware versions on this "
+				 "specific card.  In order\nmegaraid: "
+				 "to protect your data, please upgrade "
+				 "your firmware to version\nmegaraid: "
+				 "3.10 or later, available from the "
+				 "Dell Technical Support web\n"
+				 "megaraid: site at\nhttp://support."
+				 "dell.com/us/en/filelib/download/"
+				 "index.asp?fileid=2940\n");
 		}
 	}
 
@@ -4322,14 +4170,13 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		 */
 		if (!strcmp(adapter->fw_version, "H01.07") ||
 		    !strcmp(adapter->fw_version, "H01.08") ||
-		    !strcmp(adapter->fw_version, "H01.09") ) {
-			dev_warn(&pdev->dev,
-				"Firmware H.01.07, "
-				"H.01.08, and H.01.09 on 1M/2M "
-				"controllers\n"
-				"do not support 64 bit "
-				"addressing.\nDISABLING "
-				"64 bit support.\n");
+		    !strcmp(adapter->fw_version, "H01.09")) {
+			dev_warn(&pdev->dev, "Firmware H.01.07, "
+					     "H.01.08, and H.01.09 on 1M/2M "
+					     "controllers\n"
+					     "do not support 64 bit "
+					     "addressing.\nDISABLING "
+					     "64 bit support.\n");
 			adapter->flag &= ~BOARD_64BIT;
 		}
 	}
@@ -4356,14 +4203,14 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	if (adapter->boot_pdrv_enabled) {
 		j = adapter->product_info.nchannels;
-		for( i = 0; i < j; i++ )
+		for (i = 0; i < j; i++)
 			adapter->logdrv_chan[i] = 0;
-		for( i = j; i < NVIRT_CHAN + j; i++ )
+		for (i = j; i < NVIRT_CHAN + j; i++)
 			adapter->logdrv_chan[i] = 1;
 	} else {
 		for (i = 0; i < NVIRT_CHAN; i++)
 			adapter->logdrv_chan[i] = 1;
-		for (i = NVIRT_CHAN; i < MAX_CHANNELS+NVIRT_CHAN; i++)
+		for (i = NVIRT_CHAN; i < MAX_CHANNELS + NVIRT_CHAN; i++)
 			adapter->logdrv_chan[i] = 0;
 		adapter->mega_ch_class <<= NVIRT_CHAN;
 	}
@@ -4372,7 +4219,7 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * Do we support random deletion and addition of logical
 	 * drives
 	 */
-	adapter->read_ldidmap = 0;	/* set it after first logdrv
+	adapter->read_ldidmap = 0; /* set it after first logdrv
 						   delete cmd */
 	adapter->support_random_del = mega_support_random_del(adapter);
 
@@ -4404,22 +4251,21 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mcontroller[i].numldrv = adapter->numldrv;
 	mcontroller[i].pcibus = pci_bus;
 	mcontroller[i].pcidev = id->device;
-	mcontroller[i].pcifun = PCI_FUNC (pci_dev_func);
+	mcontroller[i].pcifun = PCI_FUNC(pci_dev_func);
 	mcontroller[i].pciid = -1;
 	mcontroller[i].pcivendor = id->vendor;
 	mcontroller[i].pcislot = PCI_SLOT(pci_dev_func);
 	mcontroller[i].uid = (pci_bus << 8) | pci_dev_func;
 
-
 	/* Set the Mode of addressing to 64 bit if we can */
 	if ((adapter->flag & BOARD_64BIT) && (sizeof(dma_addr_t) == 8)) {
 		dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 		adapter->has_64bit_addr = 1;
-	} else  {
+	} else {
 		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		adapter->has_64bit_addr = 0;
 	}
-		
+
 	mutex_init(&adapter->int_mtx);
 	init_completion(&adapter->int_waitq);
 
@@ -4436,9 +4282,8 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	 */
 	adapter->has_cluster = mega_support_cluster(adapter);
 	if (adapter->has_cluster) {
-		dev_notice(&pdev->dev,
-			"Cluster driver, initiator id:%d\n",
-			adapter->this_id);
+		dev_notice(&pdev->dev, "Cluster driver, initiator id:%d\n",
+			   adapter->this_id);
 	}
 #endif
 
@@ -4454,38 +4299,37 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	hba_count++;
 	return 0;
 
- out_free_mbox:
+out_free_mbox:
 	dma_free_coherent(&adapter->dev->dev, sizeof(mbox64_t),
 			  adapter->una_mbox64, adapter->una_mbox64_dma);
- out_free_irq:
+out_free_irq:
 	free_irq(adapter->host->irq, adapter);
- out_free_scb_list:
+out_free_scb_list:
 	kfree(adapter->scb_list);
- out_free_cmd_buffer:
+out_free_cmd_buffer:
 	dma_free_coherent(&adapter->dev->dev, MEGA_BUFFER_SIZE,
 			  adapter->mega_buffer, adapter->buf_dma_handle);
- out_host_put:
+out_host_put:
 	scsi_host_put(host);
- out_iounmap:
+out_iounmap:
 	if (flag & BOARD_MEMMAP)
 		iounmap((void *)mega_baseport);
- out_release_region:
+out_release_region:
 	if (flag & BOARD_MEMMAP)
 		release_mem_region(tbase, 128);
 	else
 		release_region(mega_baseport, 16);
- out_disable_device:
+out_disable_device:
 	pci_disable_device(pdev);
- out:
+out:
 	return error;
 }
 
-static void
-__megaraid_shutdown(adapter_t *adapter)
+static void __megaraid_shutdown(adapter_t *adapter)
 {
-	u_char	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox = (mbox_t *)raw_mbox;
-	int	i;
+	u_char raw_mbox[sizeof(struct mbox_out)];
+	mbox_t *mbox = (mbox_t *)raw_mbox;
+	int i;
 
 	/* Flush adapter cache */
 	memset(&mbox->m_out, 0, sizeof(raw_mbox));
@@ -4502,7 +4346,7 @@ __megaraid_shutdown(adapter_t *adapter)
 
 	/* Issue a blocking (interrupts disabled) command to the card */
 	issue_scb_block(adapter, raw_mbox);
-	
+
 	if (atomic_read(&adapter->pend_cmds) > 0)
 		dev_warn(&adapter->dev->dev, "pending commands!!\n");
 
@@ -4514,8 +4358,7 @@ __megaraid_shutdown(adapter_t *adapter)
 		mdelay(1000);
 }
 
-static void
-megaraid_remove_one(struct pci_dev *pdev)
+static void megaraid_remove_one(struct pci_dev *pdev)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	adapter_t *adapter = (adapter_t *)host->hostdata;
@@ -4549,8 +4392,7 @@ megaraid_remove_one(struct pci_dev *pdev)
 	hba_count--;
 }
 
-static void
-megaraid_shutdown(struct pci_dev *pdev)
+static void megaraid_shutdown(struct pci_dev *pdev)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	adapter_t *adapter = (adapter_t *)host->hostdata;
@@ -4559,22 +4401,24 @@ megaraid_shutdown(struct pci_dev *pdev)
 }
 
 static struct pci_device_id megaraid_pci_tbl[] = {
-	{PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_AMI_MEGARAID3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{0,}
+	{ PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID, PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, 0 },
+	{ PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID2, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_AMI_MEGARAID3, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+	{
+		0,
+	}
 };
 MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);
 
 static struct pci_driver megaraid_pci_driver = {
-	.name		= "megaraid_legacy",
-	.id_table	= megaraid_pci_tbl,
-	.probe		= megaraid_probe_one,
-	.remove		= megaraid_remove_one,
-	.shutdown	= megaraid_shutdown,
+	.name = "megaraid_legacy",
+	.id_table = megaraid_pci_tbl,
+	.probe = megaraid_probe_one,
+	.remove = megaraid_remove_one,
+	.shutdown = megaraid_shutdown,
 };
 
 static int __init megaraid_init(void)
@@ -4590,7 +4434,7 @@ static int __init megaraid_init(void)
 	mega_proc_dir_entry = proc_mkdir("megaraid", NULL);
 	if (!mega_proc_dir_entry) {
 		printk(KERN_WARNING
-				"megaraid: failed to create megaraid root\n");
+		       "megaraid: failed to create megaraid root\n");
 	}
 #endif
 	error = pci_register_driver(&megaraid_pci_driver);
@@ -4610,7 +4454,7 @@ static int __init megaraid_init(void)
 	major = register_chrdev(0, "megadev_legacy", &megadev_fops);
 	if (!major) {
 		printk(KERN_WARNING
-				"megaraid: failed to register char device\n");
+		       "megaraid: failed to register char device\n");
 	}
 
 	return 0;
diff --git a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
index cce23a086fbe4..1cf8737f01995 100644
--- a/drivers/scsi/megaraid.h
+++ b/drivers/scsi/megaraid.h
@@ -5,8 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 
-#define MEGARAID_VERSION	\
-	"v2.00.4 (Release Date: Thu Feb 9 08:51:30 EST 2006)\n"
+#define MEGARAID_VERSION "v2.00.4 (Release Date: Thu Feb 9 08:51:30 EST 2006)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -19,14 +18,14 @@
  * performance. Useful if the nature of the I/O is sequential. It is not very
  * useful for random natured I/Os.
  */
-#define MEGA_HAVE_COALESCING	0
+#define MEGA_HAVE_COALESCING 0
 
 /*
  * Clustering support - Set this flag if you are planning to use the
  * clustering services provided by the megaraid controllers and planning to
  * setup a cluster
  */
-#define MEGA_HAVE_CLUSTERING	1
+#define MEGA_HAVE_CLUSTERING 1
 
 /*
  * Driver statistics - Set this flag if you are interested in statics about
@@ -35,56 +34,59 @@
  * interface and through the private ioctl. Setting this flag has a
  * performance penalty.
  */
-#define MEGA_HAVE_STATS		0
+#define MEGA_HAVE_STATS 0
 
 /*
  * Enhanced /proc interface - This feature will allow you to have a more
  * detailed /proc interface for megaraid driver. E.g., a real time update of
  * the status of the logical drives, battery status, physical drives etc.
  */
-#define MEGA_HAVE_ENH_PROC	1
+#define MEGA_HAVE_ENH_PROC 1
 
-#define MAX_DEV_TYPE	32
+#define MAX_DEV_TYPE 32
 
-#define PCI_DEVICE_ID_DISCOVERY		0x000E
-#define PCI_DEVICE_ID_PERC4_DI		0x000F
-#define PCI_DEVICE_ID_PERC4_QC_VERDE	0x0407
+#define PCI_DEVICE_ID_DISCOVERY 0x000E
+#define PCI_DEVICE_ID_PERC4_DI 0x000F
+#define PCI_DEVICE_ID_PERC4_QC_VERDE 0x0407
 
-#define HBA_SIGNATURE	      		0x3344
-#define HBA_SIGNATURE_471	  	0xCCCC
-#define HBA_SIGNATURE_64BIT		0x0299
+#define HBA_SIGNATURE 0x3344
+#define HBA_SIGNATURE_471 0xCCCC
+#define HBA_SIGNATURE_64BIT 0x0299
 
-#define MBOX_BUSY_WAIT			10	/* wait for up to 10 usec for
+#define MBOX_BUSY_WAIT                                                         \
+	10 /* wait for up to 10 usec for
 						   mailbox to be free */
-#define DEFAULT_INITIATOR_ID	7
+#define DEFAULT_INITIATOR_ID 7
 
-#define MAX_SGLIST		64	/* max supported in f/w */
-#define MIN_SGLIST		26	/* guaranteed to support these many */
-#define MAX_COMMANDS		126
-#define CMDID_INT_CMDS		MAX_COMMANDS+1	/* make sure CMDID_INT_CMDS
+#define MAX_SGLIST 64 /* max supported in f/w */
+#define MIN_SGLIST 26 /* guaranteed to support these many */
+#define MAX_COMMANDS 126
+#define CMDID_INT_CMDS                                                         \
+	MAX_COMMANDS + 1 /* make sure CMDID_INT_CMDS
 					 	is less than max commands
 						supported by any f/w */
 
-#define MAX_CDB_LEN	     	10
-#define MAX_EXT_CDB_LEN		16	/* we support cdb length up to 16 */
-
-#define DEF_CMD_PER_LUN		63
-#define MAX_CMD_PER_LUN		MAX_COMMANDS
-#define MAX_FIRMWARE_STATUS	46
-#define MAX_XFER_PER_CMD	(64*1024)
-#define MAX_SECTORS_PER_IO	128
-
-#define MAX_LOGICAL_DRIVES_40LD		40
-#define FC_MAX_PHYSICAL_DEVICES		256
-#define MAX_LOGICAL_DRIVES_8LD		8
-#define MAX_CHANNELS			5
-#define MAX_TARGET			15
-#define MAX_PHYSICAL_DRIVES		MAX_CHANNELS*MAX_TARGET
-#define MAX_ROW_SIZE_40LD		32
-#define MAX_ROW_SIZE_8LD		8
-#define MAX_SPAN_DEPTH			8
-
-#define NVIRT_CHAN		4	/* # of virtual channels to represent
+#define MAX_CDB_LEN 10
+#define MAX_EXT_CDB_LEN 16 /* we support cdb length up to 16 */
+
+#define DEF_CMD_PER_LUN 63
+#define MAX_CMD_PER_LUN MAX_COMMANDS
+#define MAX_FIRMWARE_STATUS 46
+#define MAX_XFER_PER_CMD (64 * 1024)
+#define MAX_SECTORS_PER_IO 128
+
+#define MAX_LOGICAL_DRIVES_40LD 40
+#define FC_MAX_PHYSICAL_DEVICES 256
+#define MAX_LOGICAL_DRIVES_8LD 8
+#define MAX_CHANNELS 5
+#define MAX_TARGET 15
+#define MAX_PHYSICAL_DRIVES MAX_CHANNELS *MAX_TARGET
+#define MAX_ROW_SIZE_40LD 32
+#define MAX_ROW_SIZE_8LD 8
+#define MAX_SPAN_DEPTH 8
+
+#define NVIRT_CHAN                                                             \
+	4 /* # of virtual channels to represent
 					   up to 60 logical drives */
 struct mbox_out {
 	/* 0x0 */ u8 cmd;
@@ -95,7 +97,7 @@ struct mbox_out {
 	/* 0xC */ u8 logdrv;
 	/* 0xD */ u8 numsgelements;
 	/* 0xE */ u8 resvd;
-} __attribute__ ((packed));
+} __attribute__((packed));
 
 struct mbox_in {
 	/* 0xF */ volatile u8 busy;
@@ -104,35 +106,34 @@ struct mbox_in {
 	/* 0x12 */ volatile u8 completed[MAX_FIRMWARE_STATUS];
 	volatile u8 poll;
 	volatile u8 ack;
-} __attribute__ ((packed));
+} __attribute__((packed));
 
 typedef struct {
-	struct mbox_out	m_out;
-	struct mbox_in	m_in;
-} __attribute__ ((packed)) mbox_t;
+	struct mbox_out m_out;
+	struct mbox_in m_in;
+} __attribute__((packed)) mbox_t;
 
 typedef struct {
 	u32 xfer_segment_lo;
 	u32 xfer_segment_hi;
 	mbox_t mbox;
-} __attribute__ ((packed)) mbox64_t;
-
+} __attribute__((packed)) mbox64_t;
 
 /*
  * Passthru definitions
  */
-#define MAX_REQ_SENSE_LEN       0x20
+#define MAX_REQ_SENSE_LEN 0x20
 
 typedef struct {
-	u8 timeout:3;		/* 0=6sec/1=60sec/2=10min/3=3hrs */
-	u8 ars:1;
-	u8 reserved:3;
-	u8 islogical:1;
-	u8 logdrv;		/* if islogical == 1 */
-	u8 channel;		/* if islogical == 0 */
-	u8 target;		/* if islogical == 0 */
-	u8 queuetag;		/* unused */
-	u8 queueaction;		/* unused */
+	u8 timeout : 3; /* 0=6sec/1=60sec/2=10min/3=3hrs */
+	u8 ars : 1;
+	u8 reserved : 3;
+	u8 islogical : 1;
+	u8 logdrv; /* if islogical == 1 */
+	u8 channel; /* if islogical == 0 */
+	u8 target; /* if islogical == 0 */
+	u8 queuetag; /* unused */
+	u8 queueaction; /* unused */
 	u8 cdb[MAX_CDB_LEN];
 	u8 cdblen;
 	u8 reqsenselen;
@@ -141,24 +142,23 @@ typedef struct {
 	u8 scsistatus;
 	u32 dataxferaddr;
 	u32 dataxferlen;
-} __attribute__ ((packed)) mega_passthru;
-
+} __attribute__((packed)) mega_passthru;
 
 /*
  * Extended passthru: support CDB > 10 bytes
  */
 typedef struct {
-	u8 timeout:3;		/* 0=6sec/1=60sec/2=10min/3=3hrs */
-	u8 ars:1;
-	u8 rsvd1:1;
-	u8 cd_rom:1;
-	u8 rsvd2:1;
-	u8 islogical:1;
-	u8 logdrv;		/* if islogical == 1 */
-	u8 channel;		/* if islogical == 0 */
-	u8 target;		/* if islogical == 0 */
-	u8 queuetag;		/* unused */
-	u8 queueaction;		/* unused */
+	u8 timeout : 3; /* 0=6sec/1=60sec/2=10min/3=3hrs */
+	u8 ars : 1;
+	u8 rsvd1 : 1;
+	u8 cd_rom : 1;
+	u8 rsvd2 : 1;
+	u8 islogical : 1;
+	u8 logdrv; /* if islogical == 1 */
+	u8 channel; /* if islogical == 0 */
+	u8 target; /* if islogical == 0 */
+	u8 queuetag; /* unused */
+	u8 queueaction; /* unused */
 	u8 cdblen;
 	u8 rsvd3;
 	u8 cdb[MAX_EXT_CDB_LEN];
@@ -169,182 +169,180 @@ typedef struct {
 	u8 rsvd4;
 	u32 dataxferaddr;
 	u32 dataxferlen;
-} __attribute__ ((packed)) mega_ext_passthru;
+} __attribute__((packed)) mega_ext_passthru;
 
 typedef struct {
 	u64 address;
 	u32 length;
-} __attribute__ ((packed)) mega_sgl64;
+} __attribute__((packed)) mega_sgl64;
 
 typedef struct {
 	u32 address;
 	u32 length;
-} __attribute__ ((packed)) mega_sglist;
-
+} __attribute__((packed)) mega_sglist;
 
 /* Queued command data */
 typedef struct {
-	int	idx;
-	u32	state;
-	struct list_head	list;
-	u8	raw_mbox[66];
-	u32	dma_type;
-	u32	dma_direction;
-
-	struct scsi_cmnd	*cmd;
-	dma_addr_t	dma_h_bulkdata;
-	dma_addr_t	dma_h_sgdata;
-
-	mega_sglist	*sgl;
-	mega_sgl64	*sgl64;
-	dma_addr_t	sgl_dma_addr;
-
-	mega_passthru		*pthru;
-	dma_addr_t		pthru_dma_addr;
-	mega_ext_passthru	*epthru;
-	dma_addr_t		epthru_dma_addr;
+	int idx;
+	u32 state;
+	struct list_head list;
+	u8 raw_mbox[66];
+	u32 dma_type;
+	u32 dma_direction;
+
+	struct scsi_cmnd *cmd;
+	dma_addr_t dma_h_bulkdata;
+	dma_addr_t dma_h_sgdata;
+
+	mega_sglist *sgl;
+	mega_sgl64 *sgl64;
+	dma_addr_t sgl_dma_addr;
+
+	mega_passthru *pthru;
+	dma_addr_t pthru_dma_addr;
+	mega_ext_passthru *epthru;
+	dma_addr_t epthru_dma_addr;
 } scb_t;
 
 /*
  * Flags to follow the scb as it transitions between various stages
  */
-#define SCB_FREE	0x0000	/* on the free list */
-#define SCB_ACTIVE	0x0001	/* off the free list */
-#define SCB_PENDQ	0x0002	/* on the pending queue */
-#define SCB_ISSUED	0x0004	/* issued - owner f/w */
-#define SCB_ABORT	0x0008	/* Got an abort for this one */
-#define SCB_RESET	0x0010	/* Got a reset for this one */
+#define SCB_FREE 0x0000 /* on the free list */
+#define SCB_ACTIVE 0x0001 /* off the free list */
+#define SCB_PENDQ 0x0002 /* on the pending queue */
+#define SCB_ISSUED 0x0004 /* issued - owner f/w */
+#define SCB_ABORT 0x0008 /* Got an abort for this one */
+#define SCB_RESET 0x0010 /* Got a reset for this one */
 
 /*
  * Utilities declare this strcture size as 1024 bytes. So more fields can
  * be added in future.
  */
 typedef struct {
-	u32	data_size; /* current size in bytes (not including resvd) */
+	u32 data_size; /* current size in bytes (not including resvd) */
 
-	u32	config_signature;
-		/* Current value is 0x00282008
+	u32 config_signature;
+	/* Current value is 0x00282008
 		 * 0x28=MAX_LOGICAL_DRIVES,
 		 * 0x20=Number of stripes and
 		 * 0x08=Number of spans */
 
-	u8	fw_version[16];		/* printable ASCI string */
-	u8	bios_version[16];	/* printable ASCI string */
-	u8	product_name[80];	/* printable ASCI string */
+	u8 fw_version[16]; /* printable ASCI string */
+	u8 bios_version[16]; /* printable ASCI string */
+	u8 product_name[80]; /* printable ASCI string */
 
-	u8	max_commands;		/* Max. concurrent commands supported */
-	u8	nchannels;		/* Number of SCSI Channels detected */
-	u8	fc_loop_present;	/* Number of Fibre Loops detected */
-	u8	mem_type;		/* EDO, FPM, SDRAM etc */
+	u8 max_commands; /* Max. concurrent commands supported */
+	u8 nchannels; /* Number of SCSI Channels detected */
+	u8 fc_loop_present; /* Number of Fibre Loops detected */
+	u8 mem_type; /* EDO, FPM, SDRAM etc */
 
-	u32	signature;
-	u16	dram_size;		/* In terms of MB */
-	u16	subsysid;
+	u32 signature;
+	u16 dram_size; /* In terms of MB */
+	u16 subsysid;
 
-	u16	subsysvid;
-	u8	notify_counters;
-	u8	pad1k[889];		/* 135 + 889 resvd = 1024 total size */
-} __attribute__ ((packed)) mega_product_info;
+	u16 subsysvid;
+	u8 notify_counters;
+	u8 pad1k[889]; /* 135 + 889 resvd = 1024 total size */
+} __attribute__((packed)) mega_product_info;
 
 struct notify {
-	u32 global_counter;	/* Any change increments this counter */
+	u32 global_counter; /* Any change increments this counter */
 
-	u8 param_counter;	/* Indicates any params changed  */
-	u8 param_id;		/* Param modified - defined below */
-	u16 param_val;		/* New val of last param modified */
+	u8 param_counter; /* Indicates any params changed  */
+	u8 param_id; /* Param modified - defined below */
+	u16 param_val; /* New val of last param modified */
 
-	u8 write_config_counter;	/* write config occurred */
+	u8 write_config_counter; /* write config occurred */
 	u8 write_config_rsvd[3];
 
-	u8 ldrv_op_counter;	/* Indicates ldrv op started/completed */
-	u8 ldrv_opid;		/* ldrv num */
-	u8 ldrv_opcmd;		/* ldrv operation - defined below */
-	u8 ldrv_opstatus;	/* status of the operation */
+	u8 ldrv_op_counter; /* Indicates ldrv op started/completed */
+	u8 ldrv_opid; /* ldrv num */
+	u8 ldrv_opcmd; /* ldrv operation - defined below */
+	u8 ldrv_opstatus; /* status of the operation */
 
-	u8 ldrv_state_counter;	/* Indicates change of ldrv state */
-	u8 ldrv_state_id;		/* ldrv num */
-	u8 ldrv_state_new;	/* New state */
-	u8 ldrv_state_old;	/* old state */
+	u8 ldrv_state_counter; /* Indicates change of ldrv state */
+	u8 ldrv_state_id; /* ldrv num */
+	u8 ldrv_state_new; /* New state */
+	u8 ldrv_state_old; /* old state */
 
-	u8 pdrv_state_counter;	/* Indicates change of ldrv state */
-	u8 pdrv_state_id;		/* pdrv id */
-	u8 pdrv_state_new;	/* New state */
-	u8 pdrv_state_old;	/* old state */
+	u8 pdrv_state_counter; /* Indicates change of ldrv state */
+	u8 pdrv_state_id; /* pdrv id */
+	u8 pdrv_state_new; /* New state */
+	u8 pdrv_state_old; /* old state */
 
-	u8 pdrv_fmt_counter;	/* Indicates pdrv format started/over */
-	u8 pdrv_fmt_id;		/* pdrv id */
-	u8 pdrv_fmt_val;		/* format started/over */
+	u8 pdrv_fmt_counter; /* Indicates pdrv format started/over */
+	u8 pdrv_fmt_id; /* pdrv id */
+	u8 pdrv_fmt_val; /* format started/over */
 	u8 pdrv_fmt_rsvd;
 
-	u8 targ_xfer_counter;	/* Indicates SCSI-2 Xfer rate change */
-	u8 targ_xfer_id;	/* pdrv Id  */
-	u8 targ_xfer_val;		/* new Xfer params of last pdrv */
+	u8 targ_xfer_counter; /* Indicates SCSI-2 Xfer rate change */
+	u8 targ_xfer_id; /* pdrv Id  */
+	u8 targ_xfer_val; /* new Xfer params of last pdrv */
 	u8 targ_xfer_rsvd;
 
-	u8 fcloop_id_chg_counter;	/* Indicates loopid changed */
-	u8 fcloopid_pdrvid;		/* pdrv id */
-	u8 fcloop_id0;			/* loopid on fc loop 0 */
-	u8 fcloop_id1;			/* loopid on fc loop 1 */
+	u8 fcloop_id_chg_counter; /* Indicates loopid changed */
+	u8 fcloopid_pdrvid; /* pdrv id */
+	u8 fcloop_id0; /* loopid on fc loop 0 */
+	u8 fcloop_id1; /* loopid on fc loop 1 */
 
-	u8 fcloop_state_counter;	/* Indicates loop state changed */
-	u8 fcloop_state0;		/* state of fc loop 0 */
-	u8 fcloop_state1;		/* state of fc loop 1 */
+	u8 fcloop_state_counter; /* Indicates loop state changed */
+	u8 fcloop_state0; /* state of fc loop 0 */
+	u8 fcloop_state1; /* state of fc loop 1 */
 	u8 fcloop_state_rsvd;
-} __attribute__ ((packed));
+} __attribute__((packed));
 
-#define MAX_NOTIFY_SIZE     0x80
-#define CUR_NOTIFY_SIZE     sizeof(struct notify)
+#define MAX_NOTIFY_SIZE 0x80
+#define CUR_NOTIFY_SIZE sizeof(struct notify)
 
 typedef struct {
-	u32	data_size; /* current size in bytes (not including resvd) */
+	u32 data_size; /* current size in bytes (not including resvd) */
 
 	struct notify notify;
 
-	u8	notify_rsvd[MAX_NOTIFY_SIZE - CUR_NOTIFY_SIZE];
+	u8 notify_rsvd[MAX_NOTIFY_SIZE - CUR_NOTIFY_SIZE];
 
-	u8	rebuild_rate;		/* Rebuild rate (0% - 100%) */
-	u8	cache_flush_interval;	/* In terms of Seconds */
-	u8	sense_alert;
-	u8	drive_insert_count;	/* drive insertion count */
+	u8 rebuild_rate; /* Rebuild rate (0% - 100%) */
+	u8 cache_flush_interval; /* In terms of Seconds */
+	u8 sense_alert;
+	u8 drive_insert_count; /* drive insertion count */
 
-	u8	battery_status;
-	u8	num_ldrv;		/* No. of Log Drives configured */
-	u8	recon_state[MAX_LOGICAL_DRIVES_40LD / 8];	/* State of
+	u8 battery_status;
+	u8 num_ldrv; /* No. of Log Drives configured */
+	u8 recon_state[MAX_LOGICAL_DRIVES_40LD / 8]; /* State of
 							   reconstruct */
-	u16	ldrv_op_status[MAX_LOGICAL_DRIVES_40LD / 8]; /* logdrv
+	u16 ldrv_op_status[MAX_LOGICAL_DRIVES_40LD / 8]; /* logdrv
 								 Status */
 
-	u32	ldrv_size[MAX_LOGICAL_DRIVES_40LD];/* Size of each log drv */
-	u8	ldrv_prop[MAX_LOGICAL_DRIVES_40LD];
-	u8	ldrv_state[MAX_LOGICAL_DRIVES_40LD];/* State of log drives */
-	u8	pdrv_state[FC_MAX_PHYSICAL_DEVICES];/* State of phys drvs. */
-	u16	pdrv_format[FC_MAX_PHYSICAL_DEVICES / 16];
-
-	u8	targ_xfer[80];	/* phys device transfer rate */
-	u8	pad1k[263];	/* 761 + 263reserved = 1024 bytes total size */
-} __attribute__ ((packed)) mega_inquiry3;
+	u32 ldrv_size[MAX_LOGICAL_DRIVES_40LD]; /* Size of each log drv */
+	u8 ldrv_prop[MAX_LOGICAL_DRIVES_40LD];
+	u8 ldrv_state[MAX_LOGICAL_DRIVES_40LD]; /* State of log drives */
+	u8 pdrv_state[FC_MAX_PHYSICAL_DEVICES]; /* State of phys drvs. */
+	u16 pdrv_format[FC_MAX_PHYSICAL_DEVICES / 16];
 
+	u8 targ_xfer[80]; /* phys device transfer rate */
+	u8 pad1k[263]; /* 761 + 263reserved = 1024 bytes total size */
+} __attribute__((packed)) mega_inquiry3;
 
 /* Structures */
 typedef struct {
-	u8	max_commands;	/* Max concurrent commands supported */
-	u8	rebuild_rate;	/* Rebuild rate - 0% thru 100% */
-	u8	max_targ_per_chan;	/* Max targ per channel */
-	u8	nchannels;	/* Number of channels on HBA */
-	u8	fw_version[4];	/* Firmware version */
-	u16	age_of_flash;	/* Number of times FW has been flashed */
-	u8	chip_set_value;	/* Contents of 0xC0000832 */
-	u8	dram_size;	/* In MB */
-	u8	cache_flush_interval;	/* in seconds */
-	u8	bios_version[4];
-	u8	board_type;
-	u8	sense_alert;
-	u8	write_config_count;	/* Increase with every configuration
+	u8 max_commands; /* Max concurrent commands supported */
+	u8 rebuild_rate; /* Rebuild rate - 0% thru 100% */
+	u8 max_targ_per_chan; /* Max targ per channel */
+	u8 nchannels; /* Number of channels on HBA */
+	u8 fw_version[4]; /* Firmware version */
+	u16 age_of_flash; /* Number of times FW has been flashed */
+	u8 chip_set_value; /* Contents of 0xC0000832 */
+	u8 dram_size; /* In MB */
+	u8 cache_flush_interval; /* in seconds */
+	u8 bios_version[4];
+	u8 board_type;
+	u8 sense_alert;
+	u8 write_config_count; /* Increase with every configuration
 					   change */
-	u8	drive_inserted_count;	/* Increase with every drive inserted
+	u8 drive_inserted_count; /* Increase with every drive inserted
 					 */
-	u8	inserted_drive;	/* Channel:Id of inserted drive */
-	u8	battery_status;	/*
+	u8 inserted_drive; /* Channel:Id of inserted drive */
+	u8 battery_status; /*
 				 * BIT 0: battery module missing
 				 * BIT 1: VBAD
 				 * BIT 2: temperature high
@@ -357,103 +355,99 @@ typedef struct {
 				 * Bit 6: counter > 1000
 				 * Bit 7: Undefined
 				 */
-	u8	dec_fault_bus_info;
-} __attribute__ ((packed)) mega_adp_info;
-
+	u8 dec_fault_bus_info;
+} __attribute__((packed)) mega_adp_info;
 
 typedef struct {
-	u8	num_ldrv;	/* Number of logical drives configured */
-	u8	rsvd[3];
-	u32	ldrv_size[MAX_LOGICAL_DRIVES_8LD];
-	u8	ldrv_prop[MAX_LOGICAL_DRIVES_8LD];
-	u8	ldrv_state[MAX_LOGICAL_DRIVES_8LD];
-} __attribute__ ((packed)) mega_ldrv_info;
+	u8 num_ldrv; /* Number of logical drives configured */
+	u8 rsvd[3];
+	u32 ldrv_size[MAX_LOGICAL_DRIVES_8LD];
+	u8 ldrv_prop[MAX_LOGICAL_DRIVES_8LD];
+	u8 ldrv_state[MAX_LOGICAL_DRIVES_8LD];
+} __attribute__((packed)) mega_ldrv_info;
 
 typedef struct {
-	u8	pdrv_state[MAX_PHYSICAL_DRIVES];
-	u8	rsvd;
-} __attribute__ ((packed)) mega_pdrv_info;
+	u8 pdrv_state[MAX_PHYSICAL_DRIVES];
+	u8 rsvd;
+} __attribute__((packed)) mega_pdrv_info;
 
 /* RAID inquiry: Mailbox command 0x05*/
 typedef struct {
-	mega_adp_info	adapter_info;
-	mega_ldrv_info	logdrv_info;
-	mega_pdrv_info	pdrv_info;
-} __attribute__ ((packed)) mraid_inquiry;
-
+	mega_adp_info adapter_info;
+	mega_ldrv_info logdrv_info;
+	mega_pdrv_info pdrv_info;
+} __attribute__((packed)) mraid_inquiry;
 
 /* RAID extended inquiry: Mailbox command 0x04*/
 typedef struct {
-	mraid_inquiry	raid_inq;
-	u16	phys_drv_format[MAX_CHANNELS];
-	u8	stack_attn;
-	u8	modem_status;
-	u8	rsvd[2];
-} __attribute__ ((packed)) mraid_ext_inquiry;
-
+	mraid_inquiry raid_inq;
+	u16 phys_drv_format[MAX_CHANNELS];
+	u8 stack_attn;
+	u8 modem_status;
+	u8 rsvd[2];
+} __attribute__((packed)) mraid_ext_inquiry;
 
 typedef struct {
-	u8	channel;
-	u8	target;
-}__attribute__ ((packed)) adp_device;
+	u8 channel;
+	u8 target;
+} __attribute__((packed)) adp_device;
 
 typedef struct {
-	u32		start_blk;	/* starting block */
-	u32		num_blks;	/* # of blocks */
-	adp_device	device[MAX_ROW_SIZE_40LD];
-}__attribute__ ((packed)) adp_span_40ld;
+	u32 start_blk; /* starting block */
+	u32 num_blks; /* # of blocks */
+	adp_device device[MAX_ROW_SIZE_40LD];
+} __attribute__((packed)) adp_span_40ld;
 
 typedef struct {
-	u32		start_blk;	/* starting block */
-	u32		num_blks;	/* # of blocks */
-	adp_device	device[MAX_ROW_SIZE_8LD];
-}__attribute__ ((packed)) adp_span_8ld;
+	u32 start_blk; /* starting block */
+	u32 num_blks; /* # of blocks */
+	adp_device device[MAX_ROW_SIZE_8LD];
+} __attribute__((packed)) adp_span_8ld;
 
 typedef struct {
-	u8	span_depth;	/* Total # of spans */
-	u8	level;		/* RAID level */
-	u8	read_ahead;	/* read ahead, no read ahead, adaptive read
+	u8 span_depth; /* Total # of spans */
+	u8 level; /* RAID level */
+	u8 read_ahead; /* read ahead, no read ahead, adaptive read
 				   ahead */
-	u8	stripe_sz;	/* Encoded stripe size */
-	u8	status;		/* Status of the logical drive */
-	u8	write_mode;	/* write mode, write_through/write_back */
-	u8	direct_io;	/* direct io or through cache */
-	u8	row_size;	/* Number of stripes in a row */
-} __attribute__ ((packed)) logdrv_param;
+	u8 stripe_sz; /* Encoded stripe size */
+	u8 status; /* Status of the logical drive */
+	u8 write_mode; /* write mode, write_through/write_back */
+	u8 direct_io; /* direct io or through cache */
+	u8 row_size; /* Number of stripes in a row */
+} __attribute__((packed)) logdrv_param;
 
 typedef struct {
-	logdrv_param	lparam;
-	adp_span_40ld	span[MAX_SPAN_DEPTH];
-}__attribute__ ((packed)) logdrv_40ld;
+	logdrv_param lparam;
+	adp_span_40ld span[MAX_SPAN_DEPTH];
+} __attribute__((packed)) logdrv_40ld;
 
 typedef struct {
-	logdrv_param	lparam;
-	adp_span_8ld	span[MAX_SPAN_DEPTH];
-}__attribute__ ((packed)) logdrv_8ld;
+	logdrv_param lparam;
+	adp_span_8ld span[MAX_SPAN_DEPTH];
+} __attribute__((packed)) logdrv_8ld;
 
 typedef struct {
-	u8	type;		/* Type of the device */
-	u8	cur_status;	/* current status of the device */
-	u8	tag_depth;	/* Level of tagging */
-	u8	sync_neg;	/* sync negotiation - ENABLE or DISABLE */
-	u32	size;		/* configurable size in terms of 512 byte
+	u8 type; /* Type of the device */
+	u8 cur_status; /* current status of the device */
+	u8 tag_depth; /* Level of tagging */
+	u8 sync_neg; /* sync negotiation - ENABLE or DISABLE */
+	u32 size; /* configurable size in terms of 512 byte
 				   blocks */
-}__attribute__ ((packed)) phys_drv;
+} __attribute__((packed)) phys_drv;
 
 typedef struct {
-	u8		nlog_drives;		/* number of logical drives */
-	u8		resvd[3];
-	logdrv_40ld	ldrv[MAX_LOGICAL_DRIVES_40LD];
-	phys_drv	pdrv[MAX_PHYSICAL_DRIVES];
-}__attribute__ ((packed)) disk_array_40ld;
+	u8 nlog_drives; /* number of logical drives */
+	u8 resvd[3];
+	logdrv_40ld ldrv[MAX_LOGICAL_DRIVES_40LD];
+	phys_drv pdrv[MAX_PHYSICAL_DRIVES];
+} __attribute__((packed)) disk_array_40ld;
 
 typedef struct {
-	u8		nlog_drives;	/* number of logical drives */
-	u8		resvd[3];
-	logdrv_8ld	ldrv[MAX_LOGICAL_DRIVES_8LD];
-	phys_drv	pdrv[MAX_PHYSICAL_DRIVES];
-}__attribute__ ((packed)) disk_array_8ld;
-
+	u8 nlog_drives; /* number of logical drives */
+	u8 resvd[3];
+	logdrv_8ld ldrv[MAX_LOGICAL_DRIVES_8LD];
+	phys_drv pdrv[MAX_PHYSICAL_DRIVES];
+} __attribute__((packed)) disk_array_8ld;
 
 /*
  * User ioctl structure.
@@ -464,7 +458,7 @@ typedef struct {
  * without being sent to the card.
  */
 /* system call imposed limit. Change accordingly */
-#define IOCTL_MAX_DATALEN       4096
+#define IOCTL_MAX_DATALEN 4096
 
 struct uioctl_t {
 	u32 inlen;
@@ -483,18 +477,18 @@ struct uioctl_t {
 			u8 *buffer;
 #endif
 			u32 length;
-		} __attribute__ ((packed)) fcs;
-	} __attribute__ ((packed)) ui;
-	u8 mbox[18];		/* 16 bytes + 2 status bytes */
+		} __attribute__((packed)) fcs;
+	} __attribute__((packed)) ui;
+	u8 mbox[18]; /* 16 bytes + 2 status bytes */
 	mega_passthru pthru;
 #if BITS_PER_LONG == 32
-	char __user *data;		/* buffer <= 4096 for 0x80 commands */
+	char __user *data; /* buffer <= 4096 for 0x80 commands */
 	char pad[4];
 #endif
 #if BITS_PER_LONG == 64
 	char __user *data;
 #endif
-} __attribute__ ((packed));
+} __attribute__((packed));
 
 /*
  * struct mcontroller is used to pass information about the controllers in the
@@ -522,28 +516,28 @@ struct mcontroller {
  * mailbox structure used for internal commands
  */
 typedef struct {
-	u8	cmd;
-	u8	cmdid;
-	u8	opcode;
-	u8	subopcode;
-	u32	lba;
-	u32	xferaddr;
-	u8	logdrv;
-	u8	rsvd[3];
-	u8	numstatus;
-	u8	status;
-} __attribute__ ((packed)) megacmd_t;
+	u8 cmd;
+	u8 cmdid;
+	u8 opcode;
+	u8 subopcode;
+	u32 lba;
+	u32 xferaddr;
+	u8 logdrv;
+	u8 rsvd[3];
+	u8 numstatus;
+	u8 status;
+} __attribute__((packed)) megacmd_t;
 
 /*
  * Defines for Driver IOCTL interface
  */
-#define MEGAIOC_MAGIC  	'm'
+#define MEGAIOC_MAGIC 'm'
 
-#define MEGAIOC_QNADAP		'm'	/* Query # of adapters */
-#define MEGAIOC_QDRVRVER	'e'	/* Query driver version */
-#define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information */
-#define MKADAP(adapno)	  	(MEGAIOC_MAGIC << 8 | (adapno) )
-#define GETADAP(mkadap)	 	( (mkadap) ^ MEGAIOC_MAGIC << 8 )
+#define MEGAIOC_QNADAP 'm' /* Query # of adapters */
+#define MEGAIOC_QDRVRVER 'e' /* Query driver version */
+#define MEGAIOC_QADAPINFO 'g' /* Query adapter information */
+#define MKADAP(adapno) (MEGAIOC_MAGIC << 8 | (adapno))
+#define GETADAP(mkadap) ((mkadap) ^ MEGAIOC_MAGIC << 8)
 
 /*
  * Definition for the new ioctl interface (NIT)
@@ -552,30 +546,29 @@ typedef struct {
 /*
  * Vendor specific Group-7 commands
  */
-#define VENDOR_SPECIFIC_COMMANDS	0xE0
-#define MEGA_INTERNAL_CMD		VENDOR_SPECIFIC_COMMANDS + 0x01
+#define VENDOR_SPECIFIC_COMMANDS 0xE0
+#define MEGA_INTERNAL_CMD VENDOR_SPECIFIC_COMMANDS + 0x01
 
 /*
  * The ioctl command. No other command shall be used for this interface
  */
-#define USCSICMD	VENDOR_SPECIFIC_COMMANDS
+#define USCSICMD VENDOR_SPECIFIC_COMMANDS
 
 /*
  * Data direction flags
  */
-#define UIOC_RD		0x00001
-#define UIOC_WR		0x00002
+#define UIOC_RD 0x00001
+#define UIOC_WR 0x00002
 
 /*
  * ioctl opcodes
  */
-#define MBOX_CMD	0x00000	/* DCMD or passthru command */
-#define GET_DRIVER_VER	0x10000	/* Get driver version */
-#define GET_N_ADAP	0x20000	/* Get number of adapters */
-#define GET_ADAP_INFO	0x30000	/* Get information about a adapter */
-#define GET_CAP		0x40000	/* Get ioctl capabilities */
-#define GET_STATS	0x50000	/* Get statistics, including error info */
-
+#define MBOX_CMD 0x00000 /* DCMD or passthru command */
+#define GET_DRIVER_VER 0x10000 /* Get driver version */
+#define GET_N_ADAP 0x20000 /* Get number of adapters */
+#define GET_ADAP_INFO 0x30000 /* Get information about a adapter */
+#define GET_CAP 0x40000 /* Get ioctl capabilities */
+#define GET_STATS 0x50000 /* Get statistics, including error info */
 
 /*
  * The ioctl structure.
@@ -583,179 +576,170 @@ typedef struct {
  * MBOX_P macro converts a nitioctl_t pointer to megacmd_t pointer.
  */
 typedef struct {
-	char		signature[8];	/* Must contain "MEGANIT" */
-	u32		opcode;		/* opcode for the command */
-	u32		adapno;		/* adapter number */
+	char signature[8]; /* Must contain "MEGANIT" */
+	u32 opcode; /* opcode for the command */
+	u32 adapno; /* adapter number */
 	union {
-		u8	__raw_mbox[18];
+		u8 __raw_mbox[18];
 		void __user *__uaddr; /* xferaddr for non-mbox cmds */
-	}__ua;
+	} __ua;
 
-#define uioc_rmbox	__ua.__raw_mbox
-#define MBOX(uioc)	((megacmd_t *)&((uioc).__ua.__raw_mbox[0]))
-#define MBOX_P(uioc)	((megacmd_t __user *)&((uioc)->__ua.__raw_mbox[0]))
-#define uioc_uaddr	__ua.__uaddr
+#define uioc_rmbox __ua.__raw_mbox
+#define MBOX(uioc) ((megacmd_t *)&((uioc).__ua.__raw_mbox[0]))
+#define MBOX_P(uioc) ((megacmd_t __user *)&((uioc)->__ua.__raw_mbox[0]))
+#define uioc_uaddr __ua.__uaddr
 
-	u32		xferlen;	/* xferlen for DCMD and non-mbox
+	u32 xferlen; /* xferlen for DCMD and non-mbox
 					   commands */
-	u32		flags;		/* data direction flags */
-}nitioctl_t;
-
+	u32 flags; /* data direction flags */
+} nitioctl_t;
 
 /*
  * I/O statistics for some applications like SNMP agent. The caller must
  * provide the number of logical drives for which status should be reported.
  */
 typedef struct {
-	int	num_ldrv;	/* Number for logical drives for which the
+	int num_ldrv; /* Number for logical drives for which the
 				   status should be reported. */
-	u32	nreads[MAX_LOGICAL_DRIVES_40LD];	/* number of reads for
+	u32 nreads[MAX_LOGICAL_DRIVES_40LD]; /* number of reads for
 							each logical drive */
-	u32	nreadblocks[MAX_LOGICAL_DRIVES_40LD];	/* number of blocks
+	u32 nreadblocks[MAX_LOGICAL_DRIVES_40LD]; /* number of blocks
 							read for each logical
 							drive */
-	u32	nwrites[MAX_LOGICAL_DRIVES_40LD];	/* number of writes
+	u32 nwrites[MAX_LOGICAL_DRIVES_40LD]; /* number of writes
 							for each logical
 							drive */
-	u32	nwriteblocks[MAX_LOGICAL_DRIVES_40LD];	/* number of blocks
+	u32 nwriteblocks[MAX_LOGICAL_DRIVES_40LD]; /* number of blocks
 							writes for each
 							logical drive */
-	u32	rd_errors[MAX_LOGICAL_DRIVES_40LD];	/* number of read
+	u32 rd_errors[MAX_LOGICAL_DRIVES_40LD]; /* number of read
 							   errors for each
 							   logical drive */
-	u32	wr_errors[MAX_LOGICAL_DRIVES_40LD];	/* number of write
+	u32 wr_errors[MAX_LOGICAL_DRIVES_40LD]; /* number of write
 							   errors for each
 							   logical drive */
-}megastat_t;
-
+} megastat_t;
 
 struct private_bios_data {
-	u8	geometry:4;	/*
+	u8 geometry : 4; /*
 				 * bits 0-3 - BIOS geometry
 				 * 0x0001 - 1GB
 				 * 0x0010 - 2GB
 				 * 0x1000 - 8GB
 				 * Others values are invalid
 							 */
-	u8	unused:4;	/* bits 4-7 are unused */
-	u8	boot_drv;	/*
+	u8 unused : 4; /* bits 4-7 are unused */
+	u8 boot_drv; /*
 				 * logical drive set as boot drive
 				 * 0..7 - for 8LD cards
 				 * 0..39 - for 40LD cards
 				 */
-	u8	rsvd[12];
-	u16	cksum;	/* 0-(sum of first 13 bytes of this structure) */
-} __attribute__ ((packed));
-
-
-
+	u8 rsvd[12];
+	u16 cksum; /* 0-(sum of first 13 bytes of this structure) */
+} __attribute__((packed));
 
 /*
  * Mailbox and firmware commands and subopcodes used in this driver.
  */
 
-#define MEGA_MBOXCMD_LREAD	0x01
-#define MEGA_MBOXCMD_LWRITE	0x02
-#define MEGA_MBOXCMD_PASSTHRU	0x03
-#define MEGA_MBOXCMD_ADPEXTINQ	0x04
-#define MEGA_MBOXCMD_ADAPTERINQ	0x05
-#define MEGA_MBOXCMD_LREAD64	0xA7
-#define MEGA_MBOXCMD_LWRITE64	0xA8
-#define MEGA_MBOXCMD_PASSTHRU64	0xC3
-#define MEGA_MBOXCMD_EXTPTHRU	0xE3
+#define MEGA_MBOXCMD_LREAD 0x01
+#define MEGA_MBOXCMD_LWRITE 0x02
+#define MEGA_MBOXCMD_PASSTHRU 0x03
+#define MEGA_MBOXCMD_ADPEXTINQ 0x04
+#define MEGA_MBOXCMD_ADAPTERINQ 0x05
+#define MEGA_MBOXCMD_LREAD64 0xA7
+#define MEGA_MBOXCMD_LWRITE64 0xA8
+#define MEGA_MBOXCMD_PASSTHRU64 0xC3
+#define MEGA_MBOXCMD_EXTPTHRU 0xE3
 
-#define MAIN_MISC_OPCODE	0xA4	/* f/w misc opcode */
-#define GET_MAX_SG_SUPPORT	0x01	/* get max sg len supported by f/w */
+#define MAIN_MISC_OPCODE 0xA4 /* f/w misc opcode */
+#define GET_MAX_SG_SUPPORT 0x01 /* get max sg len supported by f/w */
 
-#define FC_NEW_CONFIG		0xA1
-#define NC_SUBOP_PRODUCT_INFO	0x0E
-#define NC_SUBOP_ENQUIRY3	0x0F
-#define ENQ3_GET_SOLICITED_FULL	0x02
-#define OP_DCMD_READ_CONFIG	0x04
-#define NEW_READ_CONFIG_8LD	0x67
-#define READ_CONFIG_8LD		0x07
-#define FLUSH_ADAPTER		0x0A
-#define FLUSH_SYSTEM		0xFE
+#define FC_NEW_CONFIG 0xA1
+#define NC_SUBOP_PRODUCT_INFO 0x0E
+#define NC_SUBOP_ENQUIRY3 0x0F
+#define ENQ3_GET_SOLICITED_FULL 0x02
+#define OP_DCMD_READ_CONFIG 0x04
+#define NEW_READ_CONFIG_8LD 0x67
+#define READ_CONFIG_8LD 0x07
+#define FLUSH_ADAPTER 0x0A
+#define FLUSH_SYSTEM 0xFE
 
 /*
  * Command for random deletion of logical drives
  */
-#define	FC_DEL_LOGDRV		0xA4	/* f/w command */
-#define	OP_SUP_DEL_LOGDRV	0x2A	/* is feature supported */
-#define OP_GET_LDID_MAP		0x18	/* get ldid and logdrv number map */
-#define OP_DEL_LOGDRV		0x1C	/* delete logical drive */
+#define FC_DEL_LOGDRV 0xA4 /* f/w command */
+#define OP_SUP_DEL_LOGDRV 0x2A /* is feature supported */
+#define OP_GET_LDID_MAP 0x18 /* get ldid and logdrv number map */
+#define OP_DEL_LOGDRV 0x1C /* delete logical drive */
 
 /*
  * BIOS commands
  */
-#define IS_BIOS_ENABLED		0x62
-#define GET_BIOS		0x01
-#define CHNL_CLASS		0xA9
-#define GET_CHNL_CLASS		0x00
-#define SET_CHNL_CLASS		0x01
-#define CH_RAID			0x01
-#define CH_SCSI			0x00
-#define BIOS_PVT_DATA		0x40
-#define GET_BIOS_PVT_DATA	0x00
-
+#define IS_BIOS_ENABLED 0x62
+#define GET_BIOS 0x01
+#define CHNL_CLASS 0xA9
+#define GET_CHNL_CLASS 0x00
+#define SET_CHNL_CLASS 0x01
+#define CH_RAID 0x01
+#define CH_SCSI 0x00
+#define BIOS_PVT_DATA 0x40
+#define GET_BIOS_PVT_DATA 0x00
 
 /*
  * Commands to support clustering
  */
-#define MEGA_GET_TARGET_ID	0x7D
-#define MEGA_CLUSTER_OP		0x70
-#define MEGA_GET_CLUSTER_MODE	0x02
-#define MEGA_CLUSTER_CMD	0x6E
-#define MEGA_RESERVE_LD		0x01
-#define MEGA_RELEASE_LD		0x02
-#define MEGA_RESET_RESERVATIONS	0x03
-#define MEGA_RESERVATION_STATUS	0x04
-#define MEGA_RESERVE_PD		0x05
-#define MEGA_RELEASE_PD		0x06
-
+#define MEGA_GET_TARGET_ID 0x7D
+#define MEGA_CLUSTER_OP 0x70
+#define MEGA_GET_CLUSTER_MODE 0x02
+#define MEGA_CLUSTER_CMD 0x6E
+#define MEGA_RESERVE_LD 0x01
+#define MEGA_RELEASE_LD 0x02
+#define MEGA_RESET_RESERVATIONS 0x03
+#define MEGA_RESERVATION_STATUS 0x04
+#define MEGA_RESERVE_PD 0x05
+#define MEGA_RELEASE_PD 0x06
 
 /*
  * Module battery status
  */
-#define MEGA_BATT_MODULE_MISSING	0x01
-#define MEGA_BATT_LOW_VOLTAGE		0x02
-#define MEGA_BATT_TEMP_HIGH		0x04
-#define MEGA_BATT_PACK_MISSING		0x08
-#define MEGA_BATT_CHARGE_MASK		0x30
-#define MEGA_BATT_CHARGE_DONE		0x00
-#define MEGA_BATT_CHARGE_INPROG		0x10
-#define MEGA_BATT_CHARGE_FAIL		0x20
-#define MEGA_BATT_CYCLES_EXCEEDED	0x40
+#define MEGA_BATT_MODULE_MISSING 0x01
+#define MEGA_BATT_LOW_VOLTAGE 0x02
+#define MEGA_BATT_TEMP_HIGH 0x04
+#define MEGA_BATT_PACK_MISSING 0x08
+#define MEGA_BATT_CHARGE_MASK 0x30
+#define MEGA_BATT_CHARGE_DONE 0x00
+#define MEGA_BATT_CHARGE_INPROG 0x10
+#define MEGA_BATT_CHARGE_FAIL 0x20
+#define MEGA_BATT_CYCLES_EXCEEDED 0x40
 
 /*
  * Physical drive states.
  */
-#define PDRV_UNCNF	0
-#define PDRV_ONLINE	3
-#define PDRV_FAILED	4
-#define PDRV_RBLD	5
-#define PDRV_HOTSPARE	6
-
+#define PDRV_UNCNF 0
+#define PDRV_ONLINE 3
+#define PDRV_FAILED 4
+#define PDRV_RBLD 5
+#define PDRV_HOTSPARE 6
 
 /*
  * Raid logical drive states.
  */
-#define RDRV_OFFLINE	0
-#define RDRV_DEGRADED	1
-#define RDRV_OPTIMAL	2
-#define RDRV_DELETED	3
+#define RDRV_OFFLINE 0
+#define RDRV_DEGRADED 1
+#define RDRV_OPTIMAL 2
+#define RDRV_DELETED 3
 
 /*
  * Read, write and cache policies
  */
-#define NO_READ_AHEAD		0
-#define READ_AHEAD		1
-#define ADAP_READ_AHEAD		2
-#define WRMODE_WRITE_THRU	0
-#define WRMODE_WRITE_BACK	1
-#define CACHED_IO		0
-#define DIRECT_IO		1
-
+#define NO_READ_AHEAD 0
+#define READ_AHEAD 1
+#define ADAP_READ_AHEAD 2
+#define WRMODE_WRITE_THRU 0
+#define WRMODE_WRITE_BACK 1
+#define CACHED_IO 0
+#define DIRECT_IO 1
 
 #define SCSI_LIST(scp) ((struct list_head *)(&(scp)->SCp))
 
@@ -763,169 +747,161 @@ struct private_bios_data {
  * Each controller's soft state
  */
 typedef struct {
-	int	this_id;	/* our id, may set to different than 7 if
+	int this_id; /* our id, may set to different than 7 if
 				   clustering is available */
-	u32	flag;
+	u32 flag;
 
-	unsigned long		base;
-	void __iomem		*mmio_base;
+	unsigned long base;
+	void __iomem *mmio_base;
 
 	/* mbox64 with mbox not aligned on 16-byte boundary */
-	mbox64_t	*una_mbox64;
-	dma_addr_t	una_mbox64_dma;
+	mbox64_t *una_mbox64;
+	dma_addr_t una_mbox64_dma;
 
-	volatile mbox64_t	*mbox64;/* ptr to 64-bit mailbox */
-	volatile mbox_t		*mbox;	/* ptr to standard mailbox */
-	dma_addr_t		mbox_dma;
+	volatile mbox64_t *mbox64; /* ptr to 64-bit mailbox */
+	volatile mbox_t *mbox; /* ptr to standard mailbox */
+	dma_addr_t mbox_dma;
 
-	struct pci_dev	*dev;
+	struct pci_dev *dev;
 
-	struct list_head	free_list;
-	struct list_head	pending_list;
-	struct list_head	completed_list;
+	struct list_head free_list;
+	struct list_head pending_list;
+	struct list_head completed_list;
 
-	struct Scsi_Host	*host;
+	struct Scsi_Host *host;
 
-#define MEGA_BUFFER_SIZE (2*1024)
-	u8		*mega_buffer;
-	dma_addr_t	buf_dma_handle;
+#define MEGA_BUFFER_SIZE (2 * 1024)
+	u8 *mega_buffer;
+	dma_addr_t buf_dma_handle;
 
-	mega_product_info	product_info;
+	mega_product_info product_info;
 
-	u8		max_cmds;
-	scb_t		*scb_list;
+	u8 max_cmds;
+	scb_t *scb_list;
 
-	atomic_t	pend_cmds;	/* maintain a counter for pending
+	atomic_t pend_cmds; /* maintain a counter for pending
 					   commands in firmware */
 
 #if MEGA_HAVE_STATS
-	u32	nreads[MAX_LOGICAL_DRIVES_40LD];
-	u32	nreadblocks[MAX_LOGICAL_DRIVES_40LD];
-	u32	nwrites[MAX_LOGICAL_DRIVES_40LD];
-	u32	nwriteblocks[MAX_LOGICAL_DRIVES_40LD];
-	u32	rd_errors[MAX_LOGICAL_DRIVES_40LD];
-	u32	wr_errors[MAX_LOGICAL_DRIVES_40LD];
+	u32 nreads[MAX_LOGICAL_DRIVES_40LD];
+	u32 nreadblocks[MAX_LOGICAL_DRIVES_40LD];
+	u32 nwrites[MAX_LOGICAL_DRIVES_40LD];
+	u32 nwriteblocks[MAX_LOGICAL_DRIVES_40LD];
+	u32 rd_errors[MAX_LOGICAL_DRIVES_40LD];
+	u32 wr_errors[MAX_LOGICAL_DRIVES_40LD];
 #endif
 
 	/* Host adapter parameters */
-	u8	numldrv;
-	u8	fw_version[7];
-	u8	bios_version[7];
+	u8 numldrv;
+	u8 fw_version[7];
+	u8 bios_version[7];
 
 #ifdef CONFIG_PROC_FS
-	struct proc_dir_entry	*controller_proc_dir_entry;
+	struct proc_dir_entry *controller_proc_dir_entry;
 #endif
 
-	int	has_64bit_addr;		/* are we using 64-bit addressing */
-	int	support_ext_cdb;
-	int	boot_ldrv_enabled;
-	int	boot_ldrv;
-	int	boot_pdrv_enabled;	/* boot from physical drive */
-	int	boot_pdrv_ch;		/* boot physical drive channel */
-	int	boot_pdrv_tgt;		/* boot physical drive target */
+	int has_64bit_addr; /* are we using 64-bit addressing */
+	int support_ext_cdb;
+	int boot_ldrv_enabled;
+	int boot_ldrv;
+	int boot_pdrv_enabled; /* boot from physical drive */
+	int boot_pdrv_ch; /* boot physical drive channel */
+	int boot_pdrv_tgt; /* boot physical drive target */
 
-
-	int	support_random_del;	/* Do we support random deletion of
+	int support_random_del; /* Do we support random deletion of
 					   logdrvs */
-	int	read_ldidmap;	/* set after logical drive deltion. The
+	int read_ldidmap; /* set after logical drive deltion. The
 				   logical drive number must be read from the
 				   map */
-	atomic_t	quiescent;	/* a stage reached when delete logical
+	atomic_t quiescent; /* a stage reached when delete logical
 					   drive needs to be done. Stop
 					   sending requests to the hba till
 					   delete operation is completed */
-	spinlock_t	lock;
+	spinlock_t lock;
 
-	u8	logdrv_chan[MAX_CHANNELS+NVIRT_CHAN]; /* logical drive are on
+	u8 logdrv_chan[MAX_CHANNELS + NVIRT_CHAN]; /* logical drive are on
 							what channels. */
-	int	mega_ch_class;
+	int mega_ch_class;
 
-	u8	sglen;	/* f/w supported scatter-gather list length */
+	u8 sglen; /* f/w supported scatter-gather list length */
 
-	scb_t			int_scb;
-	struct mutex		int_mtx;	/* To synchronize the internal
+	scb_t int_scb;
+	struct mutex int_mtx; /* To synchronize the internal
 						commands */
-	int			int_status;	/* status of internal cmd */
-	struct completion	int_waitq;	/* wait queue for internal
+	int int_status; /* status of internal cmd */
+	struct completion int_waitq; /* wait queue for internal
 						 cmds */
 
-	int	has_cluster;	/* cluster support on this HBA */
-}adapter_t;
-
+	int has_cluster; /* cluster support on this HBA */
+} adapter_t;
 
 struct mega_hbas {
 	int is_bios_enabled;
 	adapter_t *hostdata_addr;
 };
 
-
 /*
  * For state flag. Do not use LSB(8 bits) which are
  * reserved for storing info about channels.
  */
-#define IN_ABORT	0x80000000L
-#define IN_RESET	0x40000000L
-#define BOARD_MEMMAP	0x20000000L
-#define BOARD_IOMAP	0x10000000L
-#define BOARD_40LD   	0x08000000L
-#define BOARD_64BIT	0x04000000L
+#define IN_ABORT 0x80000000L
+#define IN_RESET 0x40000000L
+#define BOARD_MEMMAP 0x20000000L
+#define BOARD_IOMAP 0x10000000L
+#define BOARD_40LD 0x08000000L
+#define BOARD_64BIT 0x04000000L
 
-#define INTR_VALID			0x40
+#define INTR_VALID 0x40
 
-#define PCI_CONF_AMISIG			0xa0
-#define PCI_CONF_AMISIG64		0xa4
+#define PCI_CONF_AMISIG 0xa0
+#define PCI_CONF_AMISIG64 0xa4
 
-
-#define MEGA_DMA_TYPE_NONE		0xFFFF
-#define MEGA_BULK_DATA			0x0001
-#define MEGA_SGLIST			0x0002
+#define MEGA_DMA_TYPE_NONE 0xFFFF
+#define MEGA_BULK_DATA 0x0001
+#define MEGA_SGLIST 0x0002
 
 /*
  * Parameters for the io-mapped controllers
  */
 
 /* I/O Port offsets */
-#define CMD_PORT	 	0x00
-#define ACK_PORT	 	0x00
-#define TOGGLE_PORT		0x01
-#define INTR_PORT	  	0x0a
-
-#define MBOX_BUSY_PORT     	0x00
-#define MBOX_PORT0	 	0x04
-#define MBOX_PORT1	 	0x05
-#define MBOX_PORT2	 	0x06
-#define MBOX_PORT3	 	0x07
-#define ENABLE_MBOX_REGION 	0x0B
+#define CMD_PORT 0x00
+#define ACK_PORT 0x00
+#define TOGGLE_PORT 0x01
+#define INTR_PORT 0x0a
+
+#define MBOX_BUSY_PORT 0x00
+#define MBOX_PORT0 0x04
+#define MBOX_PORT1 0x05
+#define MBOX_PORT2 0x06
+#define MBOX_PORT3 0x07
+#define ENABLE_MBOX_REGION 0x0B
 
 /* I/O Port Values */
-#define ISSUE_BYTE	 	0x10
-#define ACK_BYTE	   	0x08
-#define ENABLE_INTR_BYTE   	0xc0
-#define DISABLE_INTR_BYTE  	0x00
-#define VALID_INTR_BYTE    	0x40
-#define MBOX_BUSY_BYTE     	0x10
-#define ENABLE_MBOX_BYTE   	0x00
-
+#define ISSUE_BYTE 0x10
+#define ACK_BYTE 0x08
+#define ENABLE_INTR_BYTE 0xc0
+#define DISABLE_INTR_BYTE 0x00
+#define VALID_INTR_BYTE 0x40
+#define MBOX_BUSY_BYTE 0x10
+#define ENABLE_MBOX_BYTE 0x00
 
 /* Setup some port macros here */
-#define issue_command(adapter)	\
-		outb_p(ISSUE_BYTE, (adapter)->base + CMD_PORT)
+#define issue_command(adapter) outb_p(ISSUE_BYTE, (adapter)->base + CMD_PORT)
 
-#define irq_state(adapter)	inb_p((adapter)->base + INTR_PORT)
+#define irq_state(adapter) inb_p((adapter)->base + INTR_PORT)
 
-#define set_irq_state(adapter, value)	\
-		outb_p((value), (adapter)->base + INTR_PORT)
+#define set_irq_state(adapter, value)                                          \
+	outb_p((value), (adapter)->base + INTR_PORT)
 
-#define irq_ack(adapter)	\
-		outb_p(ACK_BYTE, (adapter)->base + ACK_PORT)
+#define irq_ack(adapter) outb_p(ACK_BYTE, (adapter)->base + ACK_PORT)
 
-#define irq_enable(adapter)	\
+#define irq_enable(adapter)                                                    \
 	outb_p(ENABLE_INTR_BYTE, (adapter)->base + TOGGLE_PORT)
 
-#define irq_disable(adapter)	\
+#define irq_disable(adapter)                                                   \
 	outb_p(DISABLE_INTR_BYTE, (adapter)->base + TOGGLE_PORT)
 
-
 /*
  * This is our SYSDEP area. All kernel specific detail should be placed here -
  * as much as possible
@@ -935,14 +911,14 @@ struct mega_hbas {
  * End of SYSDEP area
  */
 
-const char *megaraid_info (struct Scsi_Host *);
+const char *megaraid_info(struct Scsi_Host *);
 
 static int mega_query_adapter(adapter_t *);
 static int issue_scb(adapter_t *, scb_t *);
 static int mega_setup_mailbox(adapter_t *);
 
-static int megaraid_queue (struct Scsi_Host *, struct scsi_cmnd *);
-static scb_t * mega_build_cmd(adapter_t *, struct scsi_cmnd *, int *);
+static int megaraid_queue(struct Scsi_Host *, struct scsi_cmnd *);
+static scb_t *mega_build_cmd(adapter_t *, struct scsi_cmnd *, int *);
 static void __mega_runpendq(adapter_t *);
 static int issue_scb_block(adapter_t *, u_char *);
 
@@ -955,25 +931,25 @@ static int megaraid_abort(struct scsi_cmnd *);
 static int megaraid_reset(struct scsi_cmnd *);
 static int megaraid_abort_and_reset(adapter_t *, struct scsi_cmnd *, int);
 static int megaraid_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int []);
-
-static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
-			      u32 *buffer, u32 *length);
-static int __mega_busywait_mbox (adapter_t *);
-static void mega_rundoneq (adapter_t *);
-static void mega_cmd_done(adapter_t *, u8 [], int, int);
-static inline void mega_free_sgl (adapter_t *adapter);
-static void mega_8_to_40ld (mraid_inquiry *inquiry,
-		mega_inquiry3 *enquiry3, mega_product_info *);
-
-static int megadev_open (struct inode *, struct file *);
-static int megadev_ioctl (struct file *, unsigned int, unsigned long);
+			      sector_t, int[]);
+
+static int mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buffer,
+			     u32 *length);
+static int __mega_busywait_mbox(adapter_t *);
+static void mega_rundoneq(adapter_t *);
+static void mega_cmd_done(adapter_t *, u8[], int, int);
+static inline void mega_free_sgl(adapter_t *adapter);
+static void mega_8_to_40ld(mraid_inquiry *inquiry, mega_inquiry3 *enquiry3,
+			   mega_product_info *);
+
+static int megadev_open(struct inode *, struct file *);
+static int megadev_ioctl(struct file *, unsigned int, unsigned long);
 static int mega_m_to_n(void __user *, nitioctl_t *);
 static int mega_n_to_m(void __user *, megacmd_t *);
 
-static int mega_init_scb (adapter_t *);
+static int mega_init_scb(adapter_t *);
 
-static int mega_is_bios_enabled (adapter_t *);
+static int mega_is_bios_enabled(adapter_t *);
 
 #ifdef CONFIG_PROC_FS
 static void mega_create_proc_entry(int, struct proc_dir_entry *);
@@ -982,10 +958,10 @@ static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
 #endif
 
 static int mega_support_ext_cdb(adapter_t *);
-static mega_passthru* mega_prepare_passthru(adapter_t *, scb_t *,
-		struct scsi_cmnd *, int, int);
-static mega_ext_passthru* mega_prepare_extpassthru(adapter_t *,
-		scb_t *, struct scsi_cmnd *, int, int);
+static mega_passthru *mega_prepare_passthru(adapter_t *, scb_t *,
+					    struct scsi_cmnd *, int, int);
+static mega_ext_passthru *
+mega_prepare_extpassthru(adapter_t *, scb_t *, struct scsi_cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
 static void mega_get_boot_drv(adapter_t *);
 static int mega_support_random_del(adapter_t *);
-- 
2.26.3

