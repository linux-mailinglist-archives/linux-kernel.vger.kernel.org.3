Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E61510F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357317AbiD0DAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357298AbiD0DAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:00:30 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E810316E698;
        Tue, 26 Apr 2022 19:57:19 -0700 (PDT)
X-UUID: 73f1042d650548829fd8c49de4e7d434-20220427
X-UUID: 73f1042d650548829fd8c49de4e7d434-20220427
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 964372348; Wed, 27 Apr 2022 10:55:49 +0800
X-ns-mid: postfix-6268B10D-2505752843
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id 368243848664;
        Wed, 27 Apr 2022 02:57:17 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     lienze@kylinos.cn, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: sr: add handling of memory allocation failures when calling get_capabilities
Date:   Wed, 27 Apr 2022 10:56:47 +0800
Message-Id: <20220427025647.298358-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413100008.522912-1-lienze@kylinos.cn>
References: <20220413100008.522912-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_capabilities() has the possibility of failing to
allocate transfer buffer, but it does not currently handle this, which
may lead to exceptions when accessing the buffer.

This patch adds handling when memory allocation fails.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 drivers/scsi/sr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index cbd92891a762..32d3b8274f14 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -113,7 +113,7 @@ static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
 
 static void get_sectorsize(struct scsi_cd *);
-static void get_capabilities(struct scsi_cd *);
+static int get_capabilities(struct scsi_cd *);
 
 static unsigned int sr_check_events(struct cdrom_device_info *cdi,
 				    unsigned int clearing, int slot);
@@ -669,8 +669,9 @@ static int sr_probe(struct device *dev)
 
 	sdev->sector_size = 2048;	/* A guess, just in case */
 
-	/* FIXME: need to handle a get_capabilities failure properly ?? */
-	get_capabilities(cd);
+	error = -ENOMEM;
+	if (get_capabilities(cd))
+		goto fail_minor;
 	sr_vendor_init(cd);
 
 	set_capacity(disk, cd->capacity);
@@ -794,7 +795,7 @@ static void get_sectorsize(struct scsi_cd *cd)
 	return;
 }
 
-static void get_capabilities(struct scsi_cd *cd)
+static int get_capabilities(struct scsi_cd *cd)
 {
 	unsigned char *buffer;
 	struct scsi_mode_data data;
@@ -819,7 +820,7 @@ static void get_capabilities(struct scsi_cd *cd)
 	buffer = kmalloc(512, GFP_KERNEL);
 	if (!buffer) {
 		sr_printk(KERN_ERR, cd, "out of memory.\n");
-		return;
+		return -ENOMEM;
 	}
 
 	/* eat unit attentions */
@@ -839,7 +840,7 @@ static void get_capabilities(struct scsi_cd *cd)
 				 CDC_MRW | CDC_MRW_W | CDC_RAM);
 		kfree(buffer);
 		sr_printk(KERN_INFO, cd, "scsi-1 drive");
-		return;
+		return 0;
 	}
 
 	n = data.header_length + data.block_descriptor_length;
@@ -898,6 +899,7 @@ static void get_capabilities(struct scsi_cd *cd)
 	}
 
 	kfree(buffer);
+	return 0;
 }
 
 /*
-- 
2.25.1

