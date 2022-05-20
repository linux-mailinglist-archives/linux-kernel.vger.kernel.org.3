Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1D52E771
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiETIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347002AbiETIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:30:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473714E2DB;
        Fri, 20 May 2022 01:30:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K4Uw9T017719;
        Fri, 20 May 2022 10:30:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=YHFIJxRiiXd7Hm4A9fpzYXfeaDCgITQVThJATlJXER4=;
 b=z5qsmjMr8pw8Svt/HbQH0xtotQE8l+Mn3cYrlhh8Aa+OcfRZMJ96KSVKVtnyThp4wn8D
 7UoKzxRDp6SXMvlraZ7mU77s4UDpmRwoS6UG6u4AmUf1IbbFvdmm5MT1VjbrEaT/ddSh
 YtEglG8n+mlG3zYngJg8lZVApY8bXGxo6bfkaUDd7eRjQDIGCWTj+V06VMZ1hKBmH1eM
 8hU1xKUMKj75ojomsOERYK0BwcEgchjM4F5vhmgsslbwMtUkSSJsmlA4doW+yUXQ5VeE
 ecuSuCvuJZd3LXETD5aMG7W64cUAWwdw/pjlqQ3wX1Jc1xE9zEXuoczk6A9wWvopYfeT aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j9f79s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:30:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8966210003B;
        Fri, 20 May 2022 10:29:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F1C7215122;
        Fri, 20 May 2022 10:29:58 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:29:58 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 04/10] rpmsg: virtio: Implement the announce_remote_fc ops
Date:   Fri, 20 May 2022 10:29:34 +0200
Message-ID: <20220520082940.2984914-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
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

Add the capability for a rpmsg local endpoint to receive information
of a remote endpoint state using the flow control channel.

The virtio_rpmsg_remote_flowctrl function calls the endpoint which
matches with the chinfo.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 0db8043e6c49..785fda77984e 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -305,6 +305,7 @@ __rpmsg_destroy_ept(struct virtproc_info *vrp, struct rpmsg_endpoint *ept)
 	/* make sure in-flight inbound messages won't invoke cb anymore */
 	mutex_lock(&ept->cb_lock);
 	ept->cb = NULL;
+	ept->sig_cb =  NULL;
 	mutex_unlock(&ept->cb_lock);
 
 	kref_put(&ept->refcount, __ept_release);
@@ -365,12 +366,49 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	return err;
 }
 
+static int virtio_rpmsg_remote_flowctrl(struct rpmsg_device *rpdev,
+					struct rpmsg_channel_info *chinfo,
+					bool enable)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+	struct rpmsg_endpoint *ept;
+
+	/* Use the dst addr to fetch the callback of the appropriate user */
+	mutex_lock(&vrp->endpoints_lock);
+
+	ept = idr_find(&vrp->endpoints, chinfo->dst);
+
+	/* Let's make sure no one deallocates ept while we use it */
+	if (ept)
+		kref_get(&ept->refcount);
+
+	mutex_unlock(&vrp->endpoints_lock);
+
+	if (!ept)
+		return -EINVAL;
+
+	/* Make sure ept->sig_cb doesn't go away while we use it */
+	mutex_lock(&ept->cb_lock);
+
+	if (ept->sig_cb)
+		ept->sig_cb(ept->rpdev, ept->priv, enable);
+
+	mutex_unlock(&ept->cb_lock);
+
+	/* Farewell, ept, we don't need you anymore */
+	kref_put(&ept->refcount, __ept_release);
+
+	return 0;
+}
+
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
 	.create_channel = virtio_rpmsg_create_channel,
 	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
 	.announce_create = virtio_rpmsg_announce_create,
 	.announce_destroy = virtio_rpmsg_announce_destroy,
+	.announce_remote_fc = virtio_rpmsg_remote_flowctrl,
 };
 
 static void virtio_rpmsg_release_device(struct device *dev)
-- 
2.25.1

