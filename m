Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E884E8E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiC1Gmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiC1Gmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:42:52 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1A4ECC9;
        Sun, 27 Mar 2022 23:41:12 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C9991A02A8;
        Mon, 28 Mar 2022 08:41:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 356711A18DB;
        Mon, 28 Mar 2022 08:41:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6F049183F0C8;
        Mon, 28 Mar 2022 14:41:10 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH] rpmsg: char: Add mutex protection for rpmsg_eptdev_open()
Date:   Mon, 28 Mar 2022 14:31:11 +0800
Message-Id: <1648449071-16959-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no mutex protection for rpmsg_eptdev_open(),
especially for eptdev->ept read and write operation.
It may cause issues when multiple instances call
rpmsg_eptdev_open() in parallel,

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/rpmsg/rpmsg_char.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index b6183d4f62a2..4f2189111494 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -120,8 +120,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 	struct rpmsg_device *rpdev = eptdev->rpdev;
 	struct device *dev = &eptdev->dev;
 
-	if (eptdev->ept)
+	mutex_lock(&eptdev->ept_lock);
+	if (eptdev->ept) {
+		mutex_unlock(&eptdev->ept_lock);
 		return -EBUSY;
+	}
 
 	get_device(dev);
 
@@ -137,11 +140,13 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 	if (!ept) {
 		dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
 		put_device(dev);
+		mutex_unlock(&eptdev->ept_lock);
 		return -EINVAL;
 	}
 
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
+	mutex_unlock(&eptdev->ept_lock);
 
 	return 0;
 }
-- 
2.17.1

