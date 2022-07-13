Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE65739EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiGMPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiGMPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:20:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020345071
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:20:12 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDxIqL011285;
        Wed, 13 Jul 2022 15:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=WNdA1m28axZGBfBPgm+cwg45ry5Fy0HjTYzYu1KJoPY=;
 b=XkA0K7LUcRCL6g50wN5KSie/CjFMPQo0JB7zdh/Ac510xrQq+EjS4by6NEEzSjOqBoSd
 e7IQVEhjIjR9J4aiF+Bl8BcTn3Gdd0DhYSapZVtsL5G7RuHGfZgmD0uBLHGOB/BsrQvO
 cq23IspHucsu44bRxderJNA453Rx/vOrexG/N977liKOY99npjQNLxAhpo9ZLtYnRW8X
 27FY8kANiD+RoqjWEWLbHKNvjW17q8VXpmVWWGrp9TxdUYDIroGFBW+Y7BrDbumXgNvt
 sEFLZWaXA/eYCd/2kY6sj5zeZF/07xoiTps3O/5WlnVTkaUWW3VhMD+1sYjZUlQWed71 QA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h9ydjs05f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:20:09 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BF35814786;
        Wed, 13 Jul 2022 15:20:08 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C6B04809C4D;
        Wed, 13 Jul 2022 15:20:06 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, geoffrey.ndu@hpe.com, gustavo.knuppe@hpe.com,
        camille.lu@hpe.com, Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH] misc: hpilo: switch .{read,write} ops to .{read,write}_iter
Date:   Wed, 13 Jul 2022 23:08:31 +0800
Message-Id: <20220713150831.32453-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-GUID: VM1JLXDYjjE1fXkLxch-EbWZ_OchXDfP
X-Proofpoint-ORIG-GUID: VM1JLXDYjjE1fXkLxch-EbWZ_OchXDfP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_04,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130062
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

Commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel reads and writes
without iter ops") requested exclusive .{read,write}_iter ops for
kernel_{read,write}. To support dependent drivers to access hpilo by
kernel_{read,write}, switch .{read,write} ops to its iter variants.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 hpilo.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/hpilo.c b/hpilo.c
index 8d00df9..5d431a5 100644
--- a/hpilo.c
+++ b/hpilo.c
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
@@ -639,8 +644,8 @@ out:
 
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

