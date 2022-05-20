Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132FA52E79B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347125AbiETIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347047AbiETIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:32:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8325DA0D;
        Fri, 20 May 2022 01:31:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K6PmIU022160;
        Fri, 20 May 2022 10:31:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=XxRyzDT/cjEKJwSautfebKnSTO2wQfu9PaCTzwbxsbM=;
 b=Zdg1hkZ3aCNwkHBaM7enUlBp96KdBa0rPExa/JTWIYi9YYP15mg8TpHlCyd+IrD0wGCQ
 fMtNqD7PireqCqnQEzFcQaaP78po6wTugsmEZQA7mpziw8xwHobRhXYL7zdq1weloqtK
 SvZ4nsoV8cT6wAipVG3LAlBsUUm7qJXJZCJi2GMCK/7h+DVcuuy1B4clZHQSONq4vrPA
 41GqOEt1bGg0ctwSco9FN6gQcGQ6nsAiy82bAH0cH2EC+aamUkwLjEX3PugzoDItv23x
 tyTNcMhwM0y0r8K7qKloli8lEKVudfTobWfPHQRDm/pkBRaPEnso90T4ceoKlwGwxTtR ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23aj6vtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:31:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C021E100039;
        Fri, 20 May 2022 10:31:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B9A7B215132;
        Fri, 20 May 2022 10:31:11 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:31:11 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 08/10] rpmsg: Add the destination address in rpmsg_set_flow_control
Date:   Fri, 20 May 2022 10:29:38 +0200
Message-ID: <20220520082940.2984914-9-arnaud.pouliquen@foss.st.com>
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

The destination address is not part of the rpmsg_endpoint structure.
For static endpoint without channel, we need to specify the
destination address for backend such as the rpmsg virtio.
It is also needed for endpoint to multi endpoint communication.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_char.c       | 2 +-
 drivers/rpmsg/rpmsg_core.c       | 6 ++++--
 drivers/rpmsg/rpmsg_internal.h   | 2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 include/linux/rpmsg.h            | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 904e7c67b356..f44747e64b5b 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -316,7 +316,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 		if (ret)
 			break;
 		set = (val & TIOCM_DTR) ? true : false;
-		ret = rpmsg_set_flow_control(eptdev->ept, set);
+		ret = rpmsg_set_flow_control(eptdev->ept, eptdev->chinfo.dst, set);
 		break;
 	case RPMSG_DESTROY_EPT_IOCTL:
 		/* Don't allow to destroy a default endpoint. */
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 6bbc3b3ace50..ab9a170ffa93 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -357,18 +357,20 @@ EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 /**
  * rpmsg_set_flow_control() - sets/clears serial flow control signals
  * @ept:	the rpmsg endpoint
+ * @dst:	the remote endpoint destination addr, set to RPMSG_ADDR_ANY to send to the default
+ *		remote endpoint associated to the rpmsg device.
  * @enable:	enable or disable serial flow control
  *
  * Return: 0 on success and an appropriate error value on failure.
  */
-int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, u32 dst, bool enable)
 {
 	if (WARN_ON(!ept))
 		return -EINVAL;
 	if (!ept->ops->set_flow_control)
 		return -ENXIO;
 
-	return ept->ops->set_flow_control(ept, enable);
+	return ept->ops->set_flow_control(ept, dst, enable);
 }
 EXPORT_SYMBOL(rpmsg_set_flow_control);
 
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 44e2c0f2f5ea..c34175f5093c 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -79,7 +79,7 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
-	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
+	int (*set_flow_control)(struct rpmsg_endpoint *ept, u32 dst, bool enable);
 	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
 };
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 96bd12095c8c..a8e60ca4cd08 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -154,7 +154,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
 						   struct rpmsg_channel_info *chinfo);
 
-static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
+static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, u32 dst, bool enable);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -748,7 +748,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
 }
 
-static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, u32 dst, bool enable)
 {
 	struct rpmsg_device *rpdev;
 	struct virtio_rpmsg_channel *vch;
@@ -764,7 +764,7 @@ static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable
 		struct rpmsg_ept_msg msg;
 
 		msg.src = cpu_to_rpmsg32(rpdev, ept->addr);
-		msg.dst = cpu_to_rpmsg32(rpdev, rpdev->dst);
+		msg.dst = cpu_to_rpmsg32(rpdev, dst == RPMSG_ADDR_ANY ? rpdev->dst : dst);
 		msg.flags = cpu_to_rpmsg32(rpdev, enable ? RPMSG_EPT_FC_ON : 0);
 
 		err = rpmsg_sendto(ept, &msg, sizeof(msg), RPMSG_FC_ADDR);
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index dbd0c591bb85..9b321e1554e3 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -193,7 +193,7 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 
-int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, u32 dst, bool enable);
 
 #else
 
@@ -313,7 +313,7 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return -ENXIO;
 }
 
-static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, u32 dst, bool enable)
 {
 	/* This shouldn't be possible */
 	WARN_ON(1);
-- 
2.25.1

