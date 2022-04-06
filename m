Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB754F6086
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiDFNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiDFNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:53:25 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CF48B850
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:04:24 -0700 (PDT)
X-UUID: 2a68b10bd70c4878b239404787f1c2ac-20220406
X-UUID: 2a68b10bd70c4878b239404787f1c2ac-20220406
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 745961270; Wed, 06 Apr 2022 17:03:06 +0800
X-ns-mid: postfix-624D5787-6421288226
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id 99FDF383C642;
        Wed,  6 Apr 2022 09:04:07 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     phil@philpotter.co.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom: make EXPORT_SYMBOL follow exported function
Date:   Wed,  6 Apr 2022 17:03:37 +0800
Message-Id: <20220406090337.1116708-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, some EXPORT_SYMBOL declarations do not follow the exported
function, which affects the readability of the code.  To maintain
consistency, move these EXPORT_SYMBOL declarations to the correct
position to improve the readability of the code.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 drivers/cdrom/cdrom.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 7bd10d63ddbe..2d9dce967c90 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -648,6 +648,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	mutex_unlock(&cdrom_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(register_cdrom);
 #undef ENSURE
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
@@ -663,6 +664,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 
 	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 }
+EXPORT_SYMBOL(unregister_cdrom);
 
 int cdrom_get_media_event(struct cdrom_device_info *cdi,
 			  struct media_event_desc *med)
@@ -690,6 +692,7 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
 	memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
 	return 0;
 }
+EXPORT_SYMBOL(cdrom_get_media_event);
 
 static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 			      struct rwrt_feature_desc *rfd)
@@ -1206,6 +1209,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 	cdi->use_count--;
 	return ret;
 }
+EXPORT_SYMBOL(cdrom_open);
 
 /* This code is similar to that in open_for_data. The routine is called
    whenever an audio play operation is requested.
@@ -1301,6 +1305,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 			cdo->tray_move(cdi, 1);
 	}
 }
+EXPORT_SYMBOL(cdrom_release);
 
 static int cdrom_read_mech_status(struct cdrom_device_info *cdi, 
 				  struct cdrom_changer_info *buf)
@@ -1383,6 +1388,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	kfree(info);
 	return nslots;
 }
+EXPORT_SYMBOL(cdrom_number_of_slots);
 
 
 /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
@@ -1582,6 +1588,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 	cgc->data_direction = type;
 	cgc->timeout = CDROM_DEF_TIMEOUT;
 }
+EXPORT_SYMBOL(init_cdrom_command);
 
 /* DVD handling */
 
@@ -2000,6 +2007,7 @@ int cdrom_mode_sense(struct cdrom_device_info *cdi,
 	cgc->data_direction = CGC_DATA_READ;
 	return cdo->generic_packet(cdi, cgc);
 }
+EXPORT_SYMBOL(cdrom_mode_sense);
 
 int cdrom_mode_select(struct cdrom_device_info *cdi,
 		      struct packet_command *cgc)
@@ -2015,6 +2023,7 @@ int cdrom_mode_select(struct cdrom_device_info *cdi,
 	cgc->data_direction = CGC_DATA_WRITE;
 	return cdo->generic_packet(cdi, cgc);
 }
+EXPORT_SYMBOL(cdrom_mode_select);
 
 static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 				 struct cdrom_subchnl *subchnl, int mcn)
@@ -2893,6 +2902,7 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	*last_written = toc.cdte_addr.lba;
 	return 0;
 }
+EXPORT_SYMBOL(cdrom_get_last_written);
 
 /* return the next writable block. also for udf file system. */
 static int cdrom_get_next_writable(struct cdrom_device_info *cdi,
@@ -3430,18 +3440,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 
 	return -ENOSYS;
 }
-
-EXPORT_SYMBOL(cdrom_get_last_written);
-EXPORT_SYMBOL(register_cdrom);
-EXPORT_SYMBOL(unregister_cdrom);
-EXPORT_SYMBOL(cdrom_open);
-EXPORT_SYMBOL(cdrom_release);
 EXPORT_SYMBOL(cdrom_ioctl);
-EXPORT_SYMBOL(cdrom_number_of_slots);
-EXPORT_SYMBOL(cdrom_mode_select);
-EXPORT_SYMBOL(cdrom_mode_sense);
-EXPORT_SYMBOL(init_cdrom_command);
-EXPORT_SYMBOL(cdrom_get_media_event);
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.25.1

