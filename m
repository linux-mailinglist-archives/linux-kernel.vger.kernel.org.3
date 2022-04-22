Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25F50BC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449605AbiDVP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449587AbiDVP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:57:25 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92004237FD;
        Fri, 22 Apr 2022 08:54:31 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MExSaS028654;
        Fri, 22 Apr 2022 17:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=/ZsiM/JVSStGy085+VUcOInF1XyD4vqdtylPW/d5gq8=;
 b=2rPNmR8qK7iYuF8eztJY/RH/AjGxVchq46xGxrCRGIxD4AX0udT3s9e7kO63Evlap+Um
 2rvZTiD5JtgwEHStlzJjTn+OUnJbdmCs+TH7rZUY2NDYmbEpO5K24sacp1lXf3HsCpYK
 4cQpffwgYwI+lz76MmlYic6DChgTyULQ7hjLlrqvxGlcBXs4loyMKy8eYG0rppUpQJ/5
 XfrBcauEAsA3MgipT75hTZ7pyM6qLgrSr7R0Xv9O6PyG9lAAg31BSbZ2znY2k+1Prkp5
 zfTHq8Dyz5/rHx/r2yVKfTrBcNL6mTvVnUzH8rVUo9CoYemfni/04lU2MUkVL6K93Zt3 Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fk4fvg40d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:54:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3CD5010002A;
        Fri, 22 Apr 2022 17:54:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3611B23695A;
        Fri, 22 Apr 2022 17:54:27 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 22 Apr 2022 17:54:26
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] rpmsg: virtio: Fix the unregistration of the device rpmsg_ctrl
Date:   Fri, 22 Apr 2022 17:54:02 +0200
Message-ID: <20220422155402.721982-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the rpmsg_ctrl device instead of just freeing the
the virtio_rpmsg_channel structure.
This will properly unregister the device and call
virtio_rpmsg_release_device() that frees the structure.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3b7b47f785cf..0db8043e6c49 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -861,7 +861,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
 {
 	if (!rpdev_ctrl)
 		return;
-	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
+	device_unregister(&rpdev_ctrl->dev);
 }
 
 static int rpmsg_probe(struct virtio_device *vdev)
-- 
2.24.3

