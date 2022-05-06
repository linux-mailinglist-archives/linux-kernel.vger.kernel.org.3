Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4751D076
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389057AbiEFFHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiEFFHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:07:50 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFF7755488;
        Thu,  5 May 2022 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kwrkS
        yRsaaiIFWrW7YZm2UrkeSJmomCa4/Kxdbxbyiw=; b=ONspd4qIXmW6V4d+1OMMb
        6vS4HvdMVbYN2c8XrxUoThFprjnJYB00mmBTz7aIxkx/pDHV9FpV1Tc3i5Arra4/
        YjOzqoo3Za+II1DevMBNWk8AWFJh3qq/Glre9ahoThdnjw03jdK7jh7hjfmoHt+3
        x1JZkQr4IbZUWwkE0Cb148=
Received: from localhost.localdomain (unknown [120.204.77.149])
        by smtp9 (Coremail) with SMTP id DcCowAD31eJMq3Rijn0EBQ--.64477S4;
        Fri, 06 May 2022 13:00:36 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     lee.jones@linaro.org, fthain@linux-m68k.org,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, zbr@ioremap.net, perex@perex.cz,
        tiwai@suse.com, bvanassche@acm.org, dan.j.williams@intel.com,
        srinivas.kandagatla@linaro.org, wens@csie.org,
        colin.king@intel.com, u.kleine-koenig@pengutronix.de, hare@suse.de,
        sensor1010@163.com
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH] kernel/drivers: Remove redundant driver match function
Date:   Thu,  5 May 2022 21:59:52 -0700
Message-Id: <20220506045952.136290-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAD31eJMq3Rijn0EBQ--.64477S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr13CF47Kr1rJF13uw13CFg_yoW7Ww4xpF
        s5JFWakrWUtanrWws2yrWkAFyak3Z7G347Kr4xW3sY9FnrAry5Xa4rtFy8ArZ8XFW8G3ZF
        van5try8CF4rJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziAuc_UUUUU=
X-Originating-IP: [120.204.77.149]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBohT4q1aEENxxpgAAss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes that each
candidate pair (driver, device) matches, see driver_match_device().

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/mfd/mcp-core.c             |  6 ------
 drivers/nubus/bus.c                |  6 ------
 drivers/s390/crypto/vfio_ap_drv.c  |  6 ------
 drivers/scsi/scsi_debug.c          |  7 -------
 drivers/target/loopback/tcm_loop.c |  7 -------
 drivers/w1/w1.c                    |  6 ------
 sound/ac97_bus.c                   | 11 -----------
 7 files changed, 49 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 2fa592c37c6f..281a9369f2b3 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -20,11 +20,6 @@
 #define to_mcp(d)		container_of(d, struct mcp, attached_device)
 #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
 
-static int mcp_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static int mcp_bus_probe(struct device *dev)
 {
 	struct mcp *mcp = to_mcp(dev);
@@ -43,7 +38,6 @@ static void mcp_bus_remove(struct device *dev)
 
 static struct bus_type mcp_bus_type = {
 	.name		= "mcp",
-	.match		= mcp_bus_match,
 	.probe		= mcp_bus_probe,
 	.remove		= mcp_bus_remove,
 };
diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index 17fad660032c..72921e4f35f6 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -14,11 +14,6 @@
 #define to_nubus_board(d)       container_of(d, struct nubus_board, dev)
 #define to_nubus_driver(d)      container_of(d, struct nubus_driver, driver)
 
-static int nubus_bus_match(struct device *dev, struct device_driver *driver)
-{
-	return 1;
-}
-
 static int nubus_device_probe(struct device *dev)
 {
 	struct nubus_driver *ndrv = to_nubus_driver(dev->driver);
@@ -39,7 +34,6 @@ static void nubus_device_remove(struct device *dev)
 
 struct bus_type nubus_bus_type = {
 	.name		= "nubus",
-	.match		= nubus_bus_match,
 	.probe		= nubus_device_probe,
 	.remove		= nubus_device_remove,
 };
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 29ebd54f8919..0a662c451f2a 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -172,14 +172,8 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
 	kfree(matrix_dev);
 }
 
-static int matrix_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static struct bus_type matrix_bus = {
 	.name = "matrix",
-	.match = &matrix_bus_match,
 };
 
 static struct device_driver matrix_driver = {
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 592a290e6cfa..8107489b36e8 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7844,15 +7844,8 @@ static void sdebug_driver_remove(struct device *dev)
 	scsi_host_put(sdbg_host->shost);
 }
 
-static int pseudo_lld_bus_match(struct device *dev,
-				struct device_driver *dev_driver)
-{
-	return 1;
-}
-
 static struct bus_type pseudo_lld_bus = {
 	.name = "pseudo",
-	.match = pseudo_lld_bus_match,
 	.probe = sdebug_driver_probe,
 	.remove = sdebug_driver_remove,
 	.drv_groups = sdebug_drv_groups,
diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 4407b56aa6d1..eeb63deff94f 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -83,15 +83,8 @@ static int tcm_loop_show_info(struct seq_file *m, struct Scsi_Host *host)
 static int tcm_loop_driver_probe(struct device *);
 static void tcm_loop_driver_remove(struct device *);
 
-static int pseudo_lld_bus_match(struct device *dev,
-				struct device_driver *dev_driver)
-{
-	return 1;
-}
-
 static struct bus_type tcm_loop_lld_bus = {
 	.name			= "tcm_loop_bus",
-	.match			= pseudo_lld_bus_match,
 	.probe			= tcm_loop_driver_probe,
 	.remove			= tcm_loop_driver_remove,
 };
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..a6ecfa1b3417 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -58,11 +58,6 @@ MODULE_PARM_DESC(slave_ttl,
 DEFINE_MUTEX(w1_mlock);
 LIST_HEAD(w1_masters);
 
-static int w1_master_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static int w1_master_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -174,7 +169,6 @@ static int w1_uevent(struct device *dev, struct kobj_uevent_env *env);
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
-	.match = w1_master_match,
 	.uevent = w1_uevent,
 };
 
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index b4685c53ff11..c7aee8c42c55 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -75,19 +75,8 @@ int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(snd_ac97_reset);
 
-/*
- * Let drivers decide whether they want to support given codec from their
- * probe method. Drivers have direct access to the struct snd_ac97
- * structure and may  decide based on the id field amongst other things.
- */
-static int ac97_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 struct bus_type ac97_bus_type = {
 	.name		= "ac97",
-	.match		= ac97_bus_match,
 };
 
 static int __init ac97_bus_init(void)
-- 
2.25.1

