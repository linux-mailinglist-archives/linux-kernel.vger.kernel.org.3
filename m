Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB149D241
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiAZTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:05:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7088 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244330AbiAZTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643223928; x=1674759928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bvwTeXXCVgoKK6tip4OQOfBePiolT20pRdbUv6gGlkw=;
  b=l0EvEkUtxbKQKaiWKV1erDDA/wg2kJl9gfN7rsSta3kf5iQiqNDQHMD6
   kgfsa6jidQXEa1gJkpy1ndb3dyck8eJxjyBjZFWkEM3gt/CftJNRzdsw/
   RV3jJ6eLW3Ql+vFN/GG98VMFc1MH69Uzx58f9ade+ogHPB5GjrErJ9Oph
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 11:05:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 11:05:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:27 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:24 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH V1 2/3] rpmsg: glink: Add lock to avoid race when rpmsg device is released
Date:   Thu, 27 Jan 2022 00:34:45 +0530
Message-ID: <1643223886-28170-3-git-send-email-quic_deesin@quicinc.com>
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

When remote host goes down glink char device channel is freed,
At the same time user space apps can still try to open rpmsg_char
device which will result in calling rpmsg_create_ept. This may cause
reference to already freed context of glink chardev channel.

Use per ept lock to avoid race between rpmsg_destroy_ept and
rpmsg_destory_ept.
---
 drivers/rpmsg/rpmsg_char.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 72ee101..2108ef8 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -85,6 +85,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
 	mutex_lock(&eptdev->ept_lock);
+	eptdev->rpdev = NULL;
 	if (eptdev->ept) {
 		rpmsg_destroy_ept(eptdev->ept);
 		eptdev->ept = NULL;
@@ -145,15 +146,24 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 
 	get_device(dev);
 
+	mutex_lock(&eptdev->ept_lock);
+	if (!eptdev->rpdev) {
+		put_device(dev);
+		mutex_unlock(&eptdev->ept_lock);
+		return -ENETRESET;
+	}
+
 	ept = rpmsg_create_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
 	if (!ept) {
 		dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
+		mutex_unlock(&eptdev->ept_lock);
 		put_device(dev);
 		return -EINVAL;
 	}
 
 	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
+	mutex_unlock(&eptdev->ept_lock);
 	filp->private_data = eptdev;
 
 	return 0;
@@ -285,7 +295,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (eptdev->sig_pending)
 		mask |= EPOLLPRI;
 
+	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
+	mutex_unlock(&eptdev->ept_lock);
 
 	return mask;
 }
-- 
2.7.4

