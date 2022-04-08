Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218524F92F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiDHKcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiDHKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:32:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B9BF320
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:30:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z1so12175936wrg.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SCsXI+hzZ4M8pTIIhdBURJ1vAhjOUm0NYJOu+WF3Ho=;
        b=lBncH8biBgxdmWqPcc7DHgEYUNyW6eCG8WXtkAhWQcl5/wS1IFdOCsNgi2DIlN76mt
         6aH5eK7ZcIqhrXgjQxUwfnxVSLcyXu2ts5aTUVSI2EG9l6pOQGjt9XbwzeooGfgGnkUL
         PG0ALD43x5R4kK8ppL/46Gbn6n84DaW7gJzAYO/MNs45Rpqo7a+HDukKzC0X/zWXMwbS
         WZ3Kk1r7fU2iZzUbTR/Ucvh7OKafY8r+mnAa4hVJkPjNCEOiuFn8J2jjO4f8ta8H2dGa
         Bdq83Szd9rtG2ESJpqEhFAp8TrAzSmuf2uQaa8RDKJ4K1xjCG1yTnSlr+CH4oGcnpike
         xEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SCsXI+hzZ4M8pTIIhdBURJ1vAhjOUm0NYJOu+WF3Ho=;
        b=O6G2T+Ev1QF+ceJs77FG/QkgyI4VBxoLknJsjtYo4nEN2Ur7nVOxvRokQXiyW4cRjV
         4ekqeT6nMS27H/3QKnOkS7uNF0hY4WezwYxd5YU8+8Rd97a8z1/GAa+/bcHOJdxoA4Wj
         TLklwhHHiVEEbDkqSad0+W06mKp/H1ihJStFQ34b5SjSXCF6FzcnAbSWV/rgo9BEd7VE
         3JHwQ0pRK5smRcPWFBoI7ucY65hNAhGzCWuwysN3cxHPDXx1PM+M/GTJRvo3XbzLvHtG
         jy7OE2Go79TfNAch2POMa0Oxr2XwJv27k7EVQDxk1mk01ueufq1UjpeILI5eIqi3bFov
         ksPA==
X-Gm-Message-State: AOAM531/+4ih6DWelv7GA1atWHi49bZx3hMMcga61IEDYmOp3StJMEB0
        Y/BncnnZjIbYoHT+iOtsUgbH7w==
X-Google-Smtp-Source: ABdhPJysphEKfa7iwvT1xCAj6Qs8hPWMRm+D8EWo4QIZhCpoHLfEHvNaVq4xv0Ws/a5TcW8WVNpMmA==
X-Received: by 2002:a05:6000:186c:b0:205:3479:ad85 with SMTP id d12-20020a056000186c00b002053479ad85mr14238006wri.54.1649413835229;
        Fri, 08 Apr 2022 03:30:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm20181920wre.34.2022.04.08.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:30:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] scsi: core: fix white-spaces
Date:   Fri,  8 Apr 2022 12:30:25 +0200
Message-Id: <20220408103027.311624-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trailing white-spaces and correct mixed-up indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/scsi_debug.c         |  2 +-
 drivers/scsi/scsi_priv.h          |  4 +--
 drivers/scsi/scsi_proc.c          | 14 ++++-----
 drivers/scsi/scsi_scan.c          | 10 +++----
 drivers/scsi/scsi_sysfs.c         |  4 +--
 drivers/scsi/scsi_transport_spi.c | 49 +++++++++++++++----------------
 drivers/scsi/scsicam.c            |  6 ++--
 include/scsi/scsi_cmnd.h          |  2 +-
 include/scsi/scsi_device.h        | 10 +++----
 include/scsi/scsi_host.h          | 13 ++++----
 include/scsi/scsi_ioctl.h         |  2 +-
 include/scsi/scsi_transport.h     |  2 +-
 include/scsi/scsi_transport_spi.h |  2 +-
 include/scsi/scsicam.h            |  2 +-
 include/scsi/sg.h                 |  2 +-
 15 files changed, 61 insertions(+), 63 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c607755cce00..e227e2fc98ba 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1602,7 +1602,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
-		
+
 		port_group_id = (((host_no + 1) & 0x7f) << 8) +
 		    (devip->channel & 0x7f);
 		if (sdebug_vpd_use_hostno == 0)
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5c4786310a31..8bc7353883ee 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -37,7 +37,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
 void scsi_log_send(struct scsi_cmnd *cmd);
 void scsi_log_completion(struct scsi_cmnd *cmd, int disposition);
 #else
-static inline void scsi_log_send(struct scsi_cmnd *cmd) 
+static inline void scsi_log_send(struct scsi_cmnd *cmd)
 	{ };
 static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
 	{ };
@@ -183,7 +183,7 @@ struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
 
 extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
 
-/* 
+/*
  * internal scsi timeout functions: for use by mid-layer and transport
  * classes.
  */
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 6f023a2f951b..fce8ae470be4 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -4,13 +4,13 @@
  *
  * The functions in this file provide an interface between
  * the PROC file system and the SCSI device drivers
- * It is mainly used for debugging, statistics and to pass 
+ * It is mainly used for debugging, statistics and to pass
  * information directly to the lowlevel driver.
  *
- * (c) 1995 Michael Neuffer neuffer@goofy.zdv.uni-mainz.de 
+ * (c) 1995 Michael Neuffer neuffer@goofy.zdv.uni-mainz.de
  * Version: 0.99.8   last change: 95/09/13
- * 
- * generic command parser provided by: 
+ *
+ * generic command parser provided by:
  * Andreas Heilwagen <crashcar@informatik.uni-koblenz.de>
  *
  * generic_proc_info() support of xxxx_info() by:
@@ -52,7 +52,7 @@ static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
 	struct Scsi_Host *shost = pde_data(file_inode(file));
 	ssize_t ret = -ENOMEM;
 	char *page;
-    
+
 	if (count > PROC_BLOCK_SIZE)
 		return -EOVERFLOW;
 
@@ -106,7 +106,7 @@ void scsi_proc_hostdir_add(struct scsi_host_template *sht)
 	mutex_lock(&global_host_template_mutex);
 	if (!sht->present++) {
 		sht->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
-        	if (!sht->proc_dir)
+		if (!sht->proc_dir)
 			printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
 			       __func__, sht->proc_name);
 	}
@@ -361,7 +361,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	}
 
 	/*
-	 * convert success returns so that we return the 
+	 * convert success returns so that we return the
 	 * number of bytes consumed.
 	 */
 	if (!err)
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 2ef78083f1ef..d8c272cd9544 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -108,7 +108,7 @@ MODULE_PARM_DESC(scan, "sync, async, manual, or none. "
 static unsigned int scsi_inq_timeout = SCSI_TIMEOUT/HZ + 18;
 
 module_param_named(inq_timeout, scsi_inq_timeout, uint, S_IRUGO|S_IWUSR);
-MODULE_PARM_DESC(inq_timeout, 
+MODULE_PARM_DESC(inq_timeout,
 		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
 		 " Default is 20. Some devices may need more; most need less.");
 
@@ -687,7 +687,7 @@ static int scsi_probe_lun(struct scsi_device *sdev, unsigned char *inq_result,
 			 * not-ready to ready transition [asc/ascq=0x28/0x0]
 			 * or power-on, reset [asc/ascq=0x29/0x0], continue.
 			 * INQUIRY should not yield UNIT_ATTENTION
-			 * but many buggy devices do so anyway. 
+			 * but many buggy devices do so anyway.
 			 */
 			if (scsi_status_is_check_condition(result) &&
 			    scsi_sense_valid(&sshdr)) {
@@ -933,7 +933,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 * Don't set the device offline here; rather let the upper
 	 * level drivers eval the PQ to decide whether they should
 	 * attach. So remove ((inq_result[0] >> 5) & 7) == 1 check.
-	 */ 
+	 */
 
 	sdev->inq_periph_qual = (inq_result[0] >> 5) & 7;
 	sdev->lockable = sdev->removable;
@@ -1088,7 +1088,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 }
 
 #ifdef CONFIG_SCSI_LOGGING
-/** 
+/**
  * scsi_inq_str - print INQUIRY data from min to max index, strip trailing whitespace
  * @buf:   Output buffer with at least end-first+1 bytes of space
  * @inq:   Inquiry buffer (input)
@@ -1588,7 +1588,7 @@ EXPORT_SYMBOL(__scsi_add_device);
 int scsi_add_device(struct Scsi_Host *host, uint channel,
 		    uint target, u64 lun)
 {
-	struct scsi_device *sdev = 
+	struct scsi_device *sdev =
 		__scsi_add_device(host, channel, target, lun, NULL);
 	if (IS_ERR(sdev))
 		return PTR_ERR(sdev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index cdc6e1ab8ce7..139ec8f4a4fc 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -660,7 +660,7 @@ static int scsi_sdev_check_buf_bit(const char *buf)
 			return 1;
 		else if (buf[0] == '0')
 			return 0;
-		else 
+		else
 			return -EINVAL;
 	} else
 		return -EINVAL;
@@ -876,7 +876,7 @@ store_queue_type_field(struct device *dev, struct device_attribute *attr,
 
 	if (!sdev->tagged_supported)
 		return -EINVAL;
-		
+
 	sdev_printk(KERN_INFO, sdev,
 		    "ignoring write to deprecated queue_type attribute");
 	return count;
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index bd72c38d7bfc..51d163200f41 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* 
+/*
  *  Parallel SCSI (SPI) transport specific attributes exported to sysfs.
  *
  *  Copyright (c) 2003 Silicon Graphics, Inc.  All rights reserved.
@@ -33,7 +33,7 @@
 
 #define DV_LOOPS	3
 #define DV_TIMEOUT	(10*HZ)
-#define DV_RETRIES	3	/* should only need at most 
+#define DV_RETRIES	3	/* should only need at most
 				 * two cc/ua clears */
 
 /* Our blacklist flags */
@@ -651,7 +651,7 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 		 * 0xffff (test b) */
 		for ( ; j < min(len, k + 32); j += 2) {
 			u16 *word = (u16 *)&buffer[j];
-			
+
 			*word = (j & 0x02) ? 0x0000 : 0xffff;
 		}
 		k = j;
@@ -667,7 +667,7 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 		for ( ; j < min(len, k + 32); j += 4) {
 			u32 *word = (unsigned int *)&buffer[j];
 			u32 roll = (pattern & 0x80000000) ? 1 : 0;
-			
+
 			*word = pattern;
 			pattern = (pattern << 1) | roll;
 		}
@@ -724,7 +724,7 @@ spi_dv_device_compare_inquiry(struct scsi_device *sdev, u8 *buffer,
 
 		result = spi_execute(sdev, spi_inquiry, DMA_FROM_DEVICE,
 				     ptr, len, NULL);
-		
+
 		if(result || !scsi_device_online(sdev)) {
 			scsi_device_set_state(sdev, SDEV_QUIESCE);
 			return SPI_COMPARE_FAILURE;
@@ -747,12 +747,12 @@ spi_dv_device_compare_inquiry(struct scsi_device *sdev, u8 *buffer,
 
 static enum spi_compare_returns
 spi_dv_retrain(struct scsi_device *sdev, u8 *buffer, u8 *ptr,
-	       enum spi_compare_returns 
+	       enum spi_compare_returns
 	       (*compare_fn)(struct scsi_device *, u8 *, u8 *, int))
 {
 	struct spi_internal *i = to_spi_internal(sdev->host->transportt);
 	struct scsi_target *starget = sdev->sdev_target;
-	int period = 0, prevperiod = 0; 
+	int period = 0, prevperiod = 0;
 	enum spi_compare_returns retval;
 
 
@@ -808,11 +808,11 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 {
 	int l, result;
 
-	/* first off do a test unit ready.  This can error out 
+	/* first off do a test unit ready.  This can error out
 	 * because of reservations or some other reason.  If it
 	 * fails, the device won't let us write to the echo buffer
 	 * so just return failure */
-	
+
 	static const char spi_test_unit_ready[] = {
 		TEST_UNIT_READY, 0, 0, 0, 0, 0
 	};
@@ -821,14 +821,13 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 		READ_BUFFER, 0x0b, 0, 0, 0, 0, 0, 0, 4, 0
 	};
 
-	
-	/* We send a set of three TURs to clear any outstanding 
+	/* We send a set of three TURs to clear any outstanding
 	 * unit attention conditions if they exist (Otherwise the
 	 * buffer tests won't be happy).  If the TUR still fails
 	 * (reservation conflict, device not ready, etc) just
 	 * skip the write tests */
 	for (l = 0; ; l++) {
-		result = spi_execute(sdev, spi_test_unit_ready, DMA_NONE, 
+		result = spi_execute(sdev, spi_test_unit_ready, DMA_NONE,
 				     NULL, 0, NULL);
 
 		if(result) {
@@ -840,7 +839,7 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 		}
 	}
 
-	result = spi_execute(sdev, spi_read_buffer_descriptor, 
+	result = spi_execute(sdev, spi_read_buffer_descriptor,
 			     DMA_FROM_DEVICE, buffer, 4, NULL);
 
 	if (result)
@@ -1222,7 +1221,7 @@ EXPORT_SYMBOL_GPL(spi_populate_ppr_msg);
  * @cmd:	pointer to the scsi command for the tag
  *
  * Notes:
- *	designed to create the correct type of tag message for the 
+ *	designed to create the correct type of tag message for the
  *	particular request.  Returns the size of the tag message.
  *	May return 0 if TCQ is disabled for this device.
  **/
@@ -1231,7 +1230,7 @@ int spi_populate_tag_msg(unsigned char *msg, struct scsi_cmnd *cmd)
         if (cmd->flags & SCMD_TAGGED) {
 		*msg++ = SIMPLE_QUEUE_TAG;
 		*msg++ = scsi_cmd_to_rq(cmd)->tag;
-        	return 2;
+		return 2;
 	}
 
 	return 0;
@@ -1241,10 +1240,10 @@ EXPORT_SYMBOL_GPL(spi_populate_tag_msg);
 #ifdef CONFIG_SCSI_CONSTANTS
 static const char * const one_byte_msgs[] = {
 /* 0x00 */ "Task Complete", NULL /* Extended Message */, "Save Pointers",
-/* 0x03 */ "Restore Pointers", "Disconnect", "Initiator Error", 
+/* 0x03 */ "Restore Pointers", "Disconnect", "Initiator Error",
 /* 0x06 */ "Abort Task Set", "Message Reject", "Nop", "Message Parity Error",
 /* 0x0a */ "Linked Command Complete", "Linked Command Complete w/flag",
-/* 0x0c */ "Target Reset", "Abort Task", "Clear Task Set", 
+/* 0x0c */ "Target Reset", "Abort Task", "Clear Task Set",
 /* 0x0f */ "Initiate Recovery", "Release Recovery",
 /* 0x11 */ "Terminate Process", "Continue Task", "Target Transfer Disable",
 /* 0x14 */ NULL, NULL, "Clear ACA", "LUN Reset"
@@ -1290,8 +1289,8 @@ int spi_print_msg(const unsigned char *msg)
 		if (len == 2)
 			len += 256;
 		if (msg[2] < ARRAY_SIZE(extended_msgs))
-			printk ("%s ", extended_msgs[msg[2]]); 
-		else 
+			printk ("%s ", extended_msgs[msg[2]]);
+		else
 			printk ("Extended Message, reserved code (0x%02x) ",
 				(int) msg[2]);
 		switch (msg[2]) {
@@ -1312,7 +1311,7 @@ int spi_print_msg(const unsigned char *msg)
 			print_ptr(msg, 7, "in");
 			break;
 		default:
-		for (i = 2; i < len; ++i) 
+		for (i = 2; i < len; ++i)
 			printk("%02x ", msg[i]);
 		}
 	/* Identify */
@@ -1332,13 +1331,13 @@ int spi_print_msg(const unsigned char *msg)
 	/* Two byte */
 	} else if (msg[0] <= 0x2f) {
 		if ((msg[0] - 0x20) < ARRAY_SIZE(two_byte_msgs))
-			printk("%s %02x ", two_byte_msgs[msg[0] - 0x20], 
+			printk("%s %02x ", two_byte_msgs[msg[0] - 0x20],
 				msg[1]);
-		else 
-			printk("reserved two byte (%02x %02x) ", 
+		else
+			printk("reserved two byte (%02x %02x) ",
 				msg[0], msg[1]);
 		len = 2;
-	} else 
+	} else
 		printk("reserved ");
 	return len;
 }
@@ -1366,7 +1365,7 @@ int spi_print_msg(const unsigned char *msg)
 	} else if (msg[0] <= 0x2f) {
 		printk("%02x %02x", msg[0], msg[1]);
 		len = 2;
-	} else 
+	} else
 		printk("%02x ", msg[0]);
 	return len;
 }
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index acdc0aceca5e..30385c176c68 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -3,7 +3,7 @@
  * scsicam.c - SCSI CAM support functions, use for HDIO_GETGEO, etc.
  *
  * Copyright 1993, 1994 Drew Eckhardt
- *      Visionary Computing 
+ *      Visionary Computing
  *      (Unix and Linux consulting and custom programming)
  *      drew@Colorado.EDU
  *      +1 (303) 786-7975
@@ -160,7 +160,7 @@ EXPORT_SYMBOL(scsi_partsize);
  * Information technology -
  * SCSI-2 Common access method
  * transport and SCSI interface module
- * 
+ *
  * ANNEX A :
  *
  * setsize() converts a read capacity value to int 13h
@@ -170,7 +170,7 @@ EXPORT_SYMBOL(scsi_partsize);
  * will not fit in 4 bits (or 6 bits). This algorithm also
  * minimizes the number of sectors that will be unused at the end
  * of the disk while allowing for very large disks to be
- * accommodated. This algorithm does not use physical geometry. 
+ * accommodated. This algorithm does not use physical geometry.
  */
 
 static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds,
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 1e80e70dfa92..410a2ceefc52 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -105,7 +105,7 @@ struct scsi_cmnd {
 
 	unsigned transfersize;	/* How much we are guaranteed to
 				   transfer with each SCSI transfer
-				   (ie, between disconnect / 
+				   (ie, between disconnect /
 				   reconnects.   Probably == sector
 				   size */
 	unsigned resid_len;	/* residual count */
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 57e3e239a1fc..cbbd69902f61 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -42,7 +42,7 @@ enum scsi_device_state {
 				 * All commands allowed */
 	SDEV_CANCEL,		/* beginning to delete device
 				 * Only error handler commands allowed */
-	SDEV_DEL,		/* device deleted 
+	SDEV_DEL,		/* device deleted
 				 * no commands allowed */
 	SDEV_QUIESCE,		/* Device quiescent.  No block commands
 				 * will be accepted, only specials (which
@@ -126,14 +126,14 @@ struct scsi_device {
 
 	unsigned int id, channel;
 	u64 lun;
-	unsigned int manufacturer;	/* Manufacturer of device, for using 
+	unsigned int manufacturer;	/* Manufacturer of device, for using
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
 
 	void *hostdata;		/* available to low-level driver */
 	unsigned char type;
 	char scsi_level;
-	char inq_periph_qual;	/* PQ from INQUIRY data */	
+	char inq_periph_qual;	/* PQ from INQUIRY data */
 	struct mutex inquiry_mutex;
 	unsigned char inquiry_len;	/* valid bytes in 'inquiry' */
 	unsigned char * inquiry;	/* INQUIRY response data */
@@ -158,7 +158,7 @@ struct scsi_device {
 	unsigned busy:1;	/* Used to prevent races */
 	unsigned lockable:1;	/* Able to prevent media removal */
 	unsigned locked:1;      /* Media removal disabled */
-	unsigned borken:1;	/* Tell the Seagate driver to be 
+	unsigned borken:1;	/* Tell the Seagate driver to be
 				 * painfully slow on this device */
 	unsigned disconnect:1;	/* can disconnect */
 	unsigned soft_reset:1;	/* Uses soft reset option */
@@ -167,7 +167,7 @@ struct scsi_device {
 	unsigned ppr:1;		/* Device supports PPR messages */
 	unsigned tagged_supported:1;	/* Supports SCSI-II tagged queuing */
 	unsigned simple_tags:1;	/* simple queue tag messages are enabled */
-	unsigned was_reset:1;	/* There was a bus reset on the bus for 
+	unsigned was_reset:1;	/* There was a bus reset on the bus for
 				 * this device */
 	unsigned expecting_cc_ua:1; /* Expecting a CHECK_CONDITION/UNIT_ATTN
 				     * because we did a bus reset. */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 667d889b92b5..44ff28d8fd0d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -178,7 +178,7 @@ struct scsi_host_template {
 	 * this function, it *must* perform the task of setting the queue
 	 * depth on the device.  All other tasks are optional and depend
 	 * on what the driver supports and various implementation details.
-	 * 
+	 *
 	 * Things currently recommended to be handled at this time include:
 	 *
 	 * 1.  Setting the device queue depth.  Proper setting of this is
@@ -207,7 +207,7 @@ struct scsi_host_template {
 	 * has ceased the mid layer calls this point so that the low level
 	 * driver may completely detach itself from the scsi device and vice
 	 * versa.  The low level driver is responsible for freeing any memory
-	 * it allocated in the slave_alloc or slave_configure calls. 
+	 * it allocated in the slave_alloc or slave_configure calls.
 	 *
 	 * Status: OPTIONAL
 	 */
@@ -466,7 +466,7 @@ struct scsi_host_template {
 	/*
 	 * Default value for the blocking.  If the queue is empty,
 	 * host_blocked counts down in the request_fn until it restarts
-	 * host operations as zero is reached.  
+	 * host operations as zero is reached.
 	 *
 	 * FIXME: This should probably be a value in the template
 	 */
@@ -540,7 +540,7 @@ struct Scsi_Host {
 	 */
 	struct list_head	__devices;
 	struct list_head	__targets;
-	
+
 	struct list_head	starved_list;
 
 	spinlock_t		default_lock;
@@ -565,7 +565,7 @@ struct Scsi_Host {
 	unsigned int host_failed;	   /* commands that failed.
 					      protected by host_lock */
 	unsigned int host_eh_scheduled;    /* EH scheduled without command */
-    
+
 	unsigned int host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 
 	/* next two fields are used to bound the time spent in error handling */
@@ -627,7 +627,7 @@ struct Scsi_Host {
 	 * time being.
 	 */
 	unsigned host_self_blocked:1;
-    
+
 	/*
 	 * Host uses correct SCSI ordering not PC ordering. The bit is
 	 * set for the minority of drivers whose authors actually read
@@ -682,7 +682,6 @@ struct Scsi_Host {
 	unsigned char n_io_port;
 	unsigned char dma_channel;
 	unsigned int  irq;
-	
 
 	enum scsi_host_state shost_state;
 
diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
index beac64e38b87..c3ab331c809b 100644
--- a/include/scsi/scsi_ioctl.h
+++ b/include/scsi/scsi_ioctl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _SCSI_IOCTL_H
-#define _SCSI_IOCTL_H 
+#define _SCSI_IOCTL_H
 
 #define SCSI_IOCTL_SEND_COMMAND 1
 #define SCSI_IOCTL_TEST_UNIT_READY 2
diff --git a/include/scsi/scsi_transport.h b/include/scsi/scsi_transport.h
index a0458bda3148..1a7b92f8b423 100644
--- a/include/scsi/scsi_transport.h
+++ b/include/scsi/scsi_transport.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* 
+/*
  *  Transport specific attributes.
  *
  *  Copyright (c) 2003 Silicon Graphics, Inc.  All rights reserved.
diff --git a/include/scsi/scsi_transport_spi.h b/include/scsi/scsi_transport_spi.h
index 78324502b1c9..d967bc6f1836 100644
--- a/include/scsi/scsi_transport_spi.h
+++ b/include/scsi/scsi_transport_spi.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* 
+/*
  *  Parallel SCSI (SPI) transport specific attributes exported to sysfs.
  *
  *  Copyright (c) 2003 Silicon Graphics, Inc.  All rights reserved.
diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 08edd603e521..3a37512c06ec 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -3,7 +3,7 @@
  * scsicam.h - SCSI CAM support functions, use for HDIO_GETGEO, etc.
  *
  * Copyright 1993, 1994 Drew Eckhardt
- *      Visionary Computing 
+ *      Visionary Computing
  *      (Unix and Linux consulting and custom programming)
  *      drew@Colorado.EDU
  *	+1 (303) 786-7975
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index 068e35d36557..e16160b5b407 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -244,7 +244,7 @@ typedef struct sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_GET_KEEP_ORPHAN 0x2288
 
 /* yields scsi midlevel's access_count for this SCSI device */
-#define SG_GET_ACCESS_COUNT 0x2289  
+#define SG_GET_ACCESS_COUNT 0x2289
 
 
 #define SG_SCATTER_SZ (8 * 4096)
-- 
2.32.0

