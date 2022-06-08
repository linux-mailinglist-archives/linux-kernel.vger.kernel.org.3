Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357C65425F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiFHEw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiFHEvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F992717A3;
        Tue,  7 Jun 2022 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654651040; x=1686187040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/4WqRcJOS9PY50o3EM4s4sR3QVY+ZH5V0fBKwluwEdU=;
  b=xPxwn/4n6JGw4mV0mAeMLhhgGiNzEAuBG7lhVTGlCyH6wzYZ4uvHM8kX
   7C8wtIGHWtqiqf0lM2jiVs87lqCptntP15xoNP3lQDLDZwn5SPtMCVjJ2
   kbF7KivFtM6arV5wVBMXo6N+BssC+jZm9zzQpb0Nq7JKHs+oSjPAhticA
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 18:17:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:17:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:19 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:19 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 2/4] rpmsg: char: Add support to use rpmsg_rx_done
Date:   Tue, 7 Jun 2022 18:16:43 -0700
Message-ID: <1654651005-15475-3-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support into the rpmsg char driver to skip copying the data into an
skb if the endpoint supports rpmsg_rx_done. If the endpoint supports
the rx_done operation, allocate a zero sized skb and set the data to
the buffer returned in the rx callback. When the packet is read from
the character device, release the memory by calling rpmsg_rx_done().

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/rpmsg/rpmsg_char.c | 50 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index b6183d4f62a2..be62ddcf356c 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -91,8 +91,8 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 }
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_destroy);
 
-static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
-			void *priv, u32 addr)
+static int rpmsg_ept_copy_cb(struct rpmsg_device *rpdev, void *buf, int len,
+			     void *priv, u32 addr)
 {
 	struct rpmsg_eptdev *eptdev = priv;
 	struct sk_buff *skb;
@@ -113,6 +113,43 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_ept_no_copy_cb(struct rpmsg_device *rpdev, void *buf, int len,
+				void *priv, u32 addr)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+	struct sk_buff *skb;
+
+	skb = alloc_skb(0, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	skb->head = buf;
+	skb->data = buf;
+	skb_reset_tail_pointer(skb);
+	skb_set_end_offset(skb, len);
+	skb_put(skb, len);
+
+	spin_lock(&eptdev->queue_lock);
+	skb_queue_tail(&eptdev->queue, skb);
+	spin_unlock(&eptdev->queue_lock);
+
+	/* wake up any blocking processes, waiting for new data */
+	wake_up_interruptible(&eptdev->readq);
+
+	return RPMSG_DEFER;
+}
+
+static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
+			void *priv, u32 addr)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+	rpmsg_rx_cb_t cb;
+
+	cb = (eptdev->ept->rx_done) ? rpmsg_ept_no_copy_cb : rpmsg_ept_copy_cb;
+
+	return cb(rpdev, buf, len, priv, addr);
+}
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -210,6 +247,15 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (copy_to_iter(skb->data, use, to) != use)
 		use = -EFAULT;
 
+	if (eptdev->ept->rx_done) {
+		rpmsg_rx_done(eptdev->ept, skb->data);
+		/*
+		 * Data memory is freed by rpmsg_rx_done(), reset the skb data
+		 * pointers so kfree_skb() does not try to free a second time.
+		 */
+		skb->head = NULL;
+		skb->data = NULL;
+	}
 	kfree_skb(skb);
 
 	return use;
-- 
2.7.4

