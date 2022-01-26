Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD64E49D244
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244350AbiAZTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:05:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42425 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244338AbiAZTFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643223931; x=1674759931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LFRE4HwPeuPzOCaR80UUEjsVA+y4mxNn65JRwX9K7fY=;
  b=vd7evSiHlLgyzx8/iS9pn3kEXxYWcMdqr5DtYK3TX17CmNTAlYsooMbv
   v/+9d1Qu5l4nRJojFziOdU4y2tAJHWXQev8HlrBDvx4isWgcaU9mysyZk
   OVlWV6R+gV80LidOqjTv6nO/0Ptcp5uPxgnqn7cFqYTAFTMnh22ZtPOmf
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jan 2022 11:05:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 11:05:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:30 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:27 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH V1 3/3] rpmsg: glink: Add lock for ctrl device
Date:   Thu, 27 Jan 2022 00:34:46 +0530
Message-ID: <1643223886-28170-4-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
References: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Race between rpmsg_eptdev_create and rpmsg_chrdev_remove
can sometime casue crash while accessing rpdev while new
endpoint is being created. Using lock ensure no new eptdev
is created after rpmsg_chrdev_remove has been completed.
---
 drivers/rpmsg/rpmsg_char.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 2108ef8..3e5b85d 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -27,6 +27,7 @@
 
 static dev_t rpmsg_major;
 static struct class *rpmsg_class;
+struct mutex ctrl_lock;
 
 static DEFINE_IDA(rpmsg_ctrl_ida);
 static DEFINE_IDA(rpmsg_ept_ida);
@@ -396,9 +397,12 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 	struct device *dev;
 	int ret;
 
+	mutex_lock(&ctrl_lock);
 	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
-	if (!eptdev)
+	if (!eptdev) {
+		mutex_unlock(&ctrl_lock);
 		return -ENOMEM;
+	}
 
 	dev = &eptdev->dev;
 	eptdev->rpdev = rpdev;
@@ -443,6 +447,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 		put_device(dev);
 	}
 
+	mutex_unlock(&ctrl_lock);
 	return ret;
 
 free_ept_ida:
@@ -453,6 +458,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 	put_device(dev);
 	kfree(eptdev);
 
+	mutex_unlock(&ctrl_lock);
 	return ret;
 }
 
@@ -525,6 +531,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	if (!ctrldev)
 		return -ENOMEM;
 
+	mutex_init(&ctrl_lock);
 	ctrldev->rpdev = rpdev;
 
 	dev = &ctrldev->dev;
@@ -581,12 +588,14 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
 	int ret;
 
 	/* Destroy all endpoints */
+	mutex_lock(&ctrl_lock);
 	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_eptdev_destroy);
 	if (ret)
 		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
 
 	device_del(&ctrldev->dev);
 	put_device(&ctrldev->dev);
+	mutex_unlock(&ctrl_lock);
 }
 
 static struct rpmsg_driver rpmsg_chrdev_driver = {
-- 
2.7.4

