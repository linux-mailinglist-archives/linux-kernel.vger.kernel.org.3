Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7366C52E789
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbiETIbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347156AbiETIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:30:44 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF2140840;
        Fri, 20 May 2022 01:30:20 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K4a0tN005786;
        Fri, 20 May 2022 10:30:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=fIYcdPhrP+UAIOWW4991D3j8xdtottmzpGrRfJZWd1o=;
 b=sCDduPYQDYLoRBEwoS+Uup3p4ey+PAWnDkWEfXYCSd5PQcwQIlMmPUzB3q49N4wrGZAk
 27QX0XcLO1WSDBtF7T4wMKwCm5fRIS2ku/8FmMocM4Qc83/Ze8yQfqxqIwNs4geMUlw1
 OQwVadXI3afvi9HmPiMhd0wzPUMdD5QXLfmm9RU4Go2qtAc5SlVK3SwrLNqjq4rr7Yab
 PjZZ+XK+UR9DSsYUant3Ew5bZuJZHdIiBus2ytqEQVivrJKgvmXQ2hY1fNMPU49YRMBk
 4Pmhw8bm2qsWaR7lMIq+fPe4rC8Aw0o63YSF5aACgfOrGzHCajfZuGeGFspInsuoG/71 LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j9f79t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:30:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D643100039;
        Fri, 20 May 2022 10:29:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37397215127;
        Fri, 20 May 2022 10:29:59 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:29:56 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 02/10] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Date:   Fri, 20 May 2022 10:29:32 +0200
Message-ID: <20220520082940.2984914-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Kumar Singh <quic_deesin@quicinc.com>

Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
to get/set the low level transport signals.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_char.c | 56 +++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index b6183d4f62a2..904e7c67b356 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -23,6 +23,7 @@
 #include <linux/rpmsg.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rpmsg.h>
 
@@ -52,6 +53,8 @@ static DEFINE_IDA(rpmsg_minor_ida);
  * @readq:	wait object for incoming queue
  * @default_ept: set to channel default endpoint if the default endpoint should be re-used
  *              on device open to prevent endpoint address update.
+ * @rsigs: remote flow control state
+ * @sig_pending: inform that flow control information has been received from remote but not treated
  */
 struct rpmsg_eptdev {
 	struct device dev;
@@ -68,6 +71,8 @@ struct rpmsg_eptdev {
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
 
+	u32 rsigs;
+	bool sig_pending;
 };
 
 int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
@@ -107,7 +112,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	skb_queue_tail(&eptdev->queue, skb);
 	spin_unlock(&eptdev->queue_lock);
 
-	/* wake up any blocking processes, waiting for new data */
+	wake_up_interruptible(&eptdev->readq);
+
+	return 0;
+}
+
+static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv, u32 sigs)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	eptdev->rsigs = sigs;
+	eptdev->sig_pending = true;
+
 	wake_up_interruptible(&eptdev->readq);
 
 	return 0;
@@ -140,6 +156,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 
@@ -159,6 +176,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->sig_pending = false;
 
 	/* Discard all SKBs */
 	skb_queue_purge(&eptdev->queue);
@@ -272,6 +290,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->sig_pending)
+		mask |= EPOLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -281,15 +302,36 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 			       unsigned long arg)
 {
 	struct rpmsg_eptdev *eptdev = fp->private_data;
+	bool set;
+	u32 val;
+	int ret;
 
-	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
-		return -EINVAL;
+	switch (cmd) {
+	case TIOCMGET:
+		eptdev->sig_pending = false;
+		ret = put_user(eptdev->rsigs, (int __user *)arg);
+		break;
+	case TIOCMSET:
+		ret = get_user(val, (int __user *)arg);
+		if (ret)
+			break;
+		set = (val & TIOCM_DTR) ? true : false;
+		ret = rpmsg_set_flow_control(eptdev->ept, set);
+		break;
+	case RPMSG_DESTROY_EPT_IOCTL:
+		/* Don't allow to destroy a default endpoint. */
+		if (eptdev->default_ept) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
-	/* Don't allow to destroy a default endpoint. */
-	if (eptdev->default_ept)
-		return -EINVAL;
 
-	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
+	return ret;
 }
 
 static const struct file_operations rpmsg_eptdev_fops = {
-- 
2.25.1

