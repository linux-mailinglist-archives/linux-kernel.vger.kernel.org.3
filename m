Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C2573C44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiGMRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiGMRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:55:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C42559F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:55:11 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DHBfbs025425;
        Wed, 13 Jul 2022 17:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=efIXf5V8/hDg6Z+y3iB4jN9bgmdy8cHxvB7MA2dQbVc=;
 b=LyzbeS88Z+eA0w/YPh5MGblQ9RLzWXlC3oFG204DaB/NifGG8vXEnXWeKvMFOHMWlxMi
 F7A3v8U3HX9VKEX1QWb3iHxMBH4IdnbVczOX9QAH8Rn7U4KVO39KBE+bbZAh4g9KniWM
 sTF8aesbj30V49UYld6GoufjtXEMRIDTnpF0JK4gn0p5oI5gg6dNSoO/GM0Zhbtb5xbN
 ZfRKG9bmnphemf7OUTE2zkXmxsvGYX/J3iPRnizxEfgDd7tmiFR/0bfMS5egd3aDeiSK
 SuhEYRtmOIFV3gggOOHSiv8OzwNOSNpv61ueC+/Z0QAg5WD+tNizDWlSgFTpxzS8SWgk +Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ha1tj0kb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 17:55:06 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E9C11802085;
        Wed, 13 Jul 2022 17:55:05 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 37C73808E80;
        Wed, 13 Jul 2022 17:55:04 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, camille.lu@hpe.com, geoffrey.ndu@hpe.com,
        gustavo.knuppe@hpe.com, Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2 1/1] misc: hpilo: switch .{read,write} ops to .{read,write}_iter
Date:   Thu, 14 Jul 2022 01:54:52 +0800
Message-Id: <20220713175452.4221-2-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20220713175452.4221-1-matt.hsiao@hpe.com>
References: <20220713175452.4221-1-matt.hsiao@hpe.com>
X-Proofpoint-ORIG-GUID: sZQi1_2SDoyvamWHGmgQ10ruQSYa15Xp
X-Proofpoint-GUID: sZQi1_2SDoyvamWHGmgQ10ruQSYa15Xp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_07,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130073
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

Commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel reads and writes
without iter ops") requested exclusive .{read,write}_iter ops for
kernel_{read,write}. To support dependent drivers to access hpilo by
kernel_{read,write}, switch .{read,write} ops to their iter variants.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..5d431a56b7eb 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -23,6 +23,7 @@
 #include <linux/wait.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
+#include <linux/uio.h>
 #include "hpilo.h"
 
 static struct class *ilo_class;
@@ -435,14 +436,14 @@ static void ilo_set_reset(struct ilo_hwinfo *hw)
 	}
 }
 
-static ssize_t ilo_read(struct file *fp, char __user *buf,
-			size_t len, loff_t *off)
+static ssize_t ilo_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	int err, found, cnt, pkt_id, pkt_len;
-	struct ccb_data *data = fp->private_data;
+	int err = 0, found, cnt, pkt_id, pkt_len;
+	struct ccb_data *data = iocb->ki_filp->private_data;
 	struct ccb *driver_ccb = &data->driver_ccb;
 	struct ilo_hwinfo *hw = data->ilo_hw;
 	void *pkt;
+	size_t len = iov_iter_count(to), copied;
 
 	if (is_channel_reset(driver_ccb)) {
 		/*
@@ -477,7 +478,9 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
 	if (pkt_len < len)
 		len = pkt_len;
 
-	err = copy_to_user(buf, pkt, len);
+	copied = copy_to_iter(pkt, len, to);
+	if (unlikely(copied != len))
+		err = -EFAULT;
 
 	/* return the received packet to the queue */
 	ilo_pkt_enqueue(hw, driver_ccb, RECVQ, pkt_id, desc_mem_sz(1));
@@ -485,14 +488,14 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
 	return err ? -EFAULT : len;
 }
 
-static ssize_t ilo_write(struct file *fp, const char __user *buf,
-			 size_t len, loff_t *off)
+static ssize_t ilo_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	int err, pkt_id, pkt_len;
-	struct ccb_data *data = fp->private_data;
+	int err = 0, pkt_id, pkt_len;
+	struct ccb_data *data = iocb->ki_filp->private_data;
 	struct ccb *driver_ccb = &data->driver_ccb;
 	struct ilo_hwinfo *hw = data->ilo_hw;
 	void *pkt;
+	size_t len = iov_iter_count(from), copied;
 
 	if (is_channel_reset(driver_ccb))
 		return -ENODEV;
@@ -506,9 +509,11 @@ static ssize_t ilo_write(struct file *fp, const char __user *buf,
 		len = pkt_len;
 
 	/* on failure, set the len to 0 to return empty packet to the device */
-	err = copy_from_user(pkt, buf, len);
-	if (err)
+	copied = copy_from_iter(pkt, len, from);
+	if (unlikely(copied != len)) {
 		len = 0;
+		err = -EFAULT;
+	}
 
 	/* send the packet */
 	ilo_pkt_enqueue(hw, driver_ccb, SENDQ, pkt_id, len);
@@ -639,8 +644,8 @@ static int ilo_open(struct inode *ip, struct file *fp)
 
 static const struct file_operations ilo_fops = {
 	.owner		= THIS_MODULE,
-	.read		= ilo_read,
-	.write		= ilo_write,
+	.read_iter	= ilo_read_iter,
+	.write_iter	= ilo_write_iter,
 	.poll		= ilo_poll,
 	.open 		= ilo_open,
 	.release 	= ilo_close,
-- 
2.16.6

