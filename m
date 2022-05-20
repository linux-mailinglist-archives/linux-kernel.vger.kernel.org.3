Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9C52E798
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiETIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbiETIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:32:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBE5253A;
        Fri, 20 May 2022 01:31:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K1fHuV021302;
        Fri, 20 May 2022 10:31:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=t94o4VLq7z8yU2gSvGyjpvMAkLvBovU9E/HfTz+KTSA=;
 b=n7qkXL8KJw/5QDLTaSC5lU3wZ09WfVAWDR3kXtXL4qiBfKf0/cPDYonDtCB4NVlaW6AV
 8GYUyNqz6IXsGKGxcYRN0fKtRD7ptyzIKy6rXULMHOm1fP+0+xHZFmveGZgVHLlAGFxI
 DVcvXF0SkWWoVAUhSdOuJWRlhX1eOlDXyqdzzoYOyouY+YfUhy+je/8lZDC+0ysJEei+
 T0nnx3gg5pARasCcdN/Fddlvf2j47OKN41qz2AterXBjjIZxDPbrGdA03Mj4mrW77GIf
 9Ya4swTaP/FhjkKEQl11iMoTuHPqoz+tGBpHhK6YP9ma6MFOokarB9eF4Ptg/nuvLH6B qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23aj6vtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:31:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32926100038;
        Fri, 20 May 2022 10:31:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9437720E6D1;
        Fri, 20 May 2022 10:31:13 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:31:10 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 07/10] rpmsg: virtio: Implement the set_flow_control ops
Date:   Fri, 20 May 2022 10:29:37 +0200
Message-ID: <20220520082940.2984914-8-arnaud.pouliquen@foss.st.com>
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

Add the capability for a rpmsg local endpoint to informs the
remote of its state using the flow control channel.

If the feature is not supported by the remote processor, no
message is sent.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 40d2ab86b395..96bd12095c8c 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -154,6 +154,8 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
 						   struct rpmsg_channel_info *chinfo);
 
+static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
+
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
 	.send = virtio_rpmsg_send,
@@ -163,6 +165,7 @@ static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.trysendto = virtio_rpmsg_trysendto,
 	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
 	.get_mtu = virtio_rpmsg_get_mtu,
+	.set_flow_control = virtio_rpmsg_set_flow_control,
 };
 
 /**
@@ -745,6 +748,34 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
 }
 
+static int virtio_rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+{
+	struct rpmsg_device *rpdev;
+	struct virtio_rpmsg_channel *vch;
+	int err = 0;
+
+	if (!ept)
+		return -EINVAL;
+
+	rpdev = ept->rpdev;
+	vch = to_virtio_rpmsg_channel(rpdev);
+
+	if (virtio_has_feature(vch->vrp->vdev, VIRTIO_RPMSG_F_FC)) {
+		struct rpmsg_ept_msg msg;
+
+		msg.src = cpu_to_rpmsg32(rpdev, ept->addr);
+		msg.dst = cpu_to_rpmsg32(rpdev, rpdev->dst);
+		msg.flags = cpu_to_rpmsg32(rpdev, enable ? RPMSG_EPT_FC_ON : 0);
+
+		err = rpmsg_sendto(ept, &msg, sizeof(msg), RPMSG_FC_ADDR);
+		if (err)
+			dev_err(&rpdev->dev, "Failed to set endpoint 0x%x state %sable (%d)\n",
+				ept->addr, enable ? "en" : "dis", err);
+	}
+
+	return err;
+}
+
 static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 			     struct rpmsg_hdr *msg, unsigned int len)
 {
-- 
2.25.1

