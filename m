Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D818D49D23E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiAZTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:05:25 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3535 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiAZTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643223925; x=1674759925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BFnNnWm8CqHcN1xPTfMOYp7u2KkoUPz+bESKbjmA/fM=;
  b=sQa8hEYd7KSYEqmU4iBvAARI8rkJG4dFtc07EpLvIt7YGsAu1pMrgp1+
   6grWiuTnaJI/pAEhiL3q/wz24xF2qwPQQA23HXwDjFVTj4zZaj8Co3rSZ
   4hgTzRql0JJs1lat2PZmLtwZRVe/582umopvjDC+a/e+6p0q4yYTS62zQ
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Jan 2022 11:05:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 11:05:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:23 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 11:05:20 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH V1 1/3] rpmsg: glink: Free device context only when cdev not in use
Date:   Thu, 27 Jan 2022 00:34:44 +0530
Message-ID: <1643223886-28170-2-git-send-email-quic_deesin@quicinc.com>
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

Struct device holding cdev should not be freed unless cdev
is not in use. It is possible that user space has opened
char device while kernel has freed the associated struct
device context.

Mark dev kobj as parent of cdev, so that chardev_add gets
an extra reference to dev. This ensures device context is not
freed until cdev is is not in uses.
---
 drivers/rpmsg/rpmsg_char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index c03a118..72ee101 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -417,6 +417,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 	dev->id = ret;
 	dev_set_name(dev, "rpmsg%d", ret);
 
+	cdev_set_parent(&eptdev->cdev, &dev->kobj);
 	ret = cdev_add(&eptdev->cdev, dev->devt, 1);
 	if (ret)
 		goto free_ept_ida;
@@ -533,6 +534,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	dev->id = ret;
 	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
 
+	cdev_set_parent(&ctrldev->cdev, &dev->kobj);
 	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
 	if (ret)
 		goto free_ctrl_ida;
-- 
2.7.4

