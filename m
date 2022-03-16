Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06924DB4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357254AbiCPPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344573AbiCPPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:31:28 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB796C92A;
        Wed, 16 Mar 2022 08:30:12 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GEDsXd005355;
        Wed, 16 Mar 2022 16:30:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=c2g6I4As5BWCLWcUp9SWPHmLYhsOd/4wcTcA+mh+Uv4=;
 b=HjOO/44Fw06Ezka90aXRsOVUgdvqhFg/1YfLErtLJakF926nVRgcLzELZFfDEMQ3XVQ/
 j0P555mxEGPqPTJB/2s/YNi3JJi61/uUrL7SeiVaLkOWTDUDRR4V1gKL6lG78+qgw9NY
 vhyLQMuQ8rToSqGdM0ZXwHBbCgegd9kIACFOmdklDg4YnOfm4vEAu1CvfnW/caNjqI7j
 YxMw0Q0y+vfVk14tTEqxkYybn+jKh0THbJhMhnmeqPJMw0wBskwKKUHqVkhgcwnMUBnM
 Rci4RXurkppp3SCV5OuOc+9m3VYK4dq3HGxiL8dAUg+lcKFRpjvY/rh/NeLQOFVK+4xc aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63j6kw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 16:30:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6498E10002A;
        Wed, 16 Mar 2022 16:30:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5842422FA29;
        Wed, 16 Mar 2022 16:30:09 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 16 Mar 2022 16:30:09
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2] rpmsg: virtio: set dst address on first message received
Date:   Wed, 16 Mar 2022 16:30:01 +0100
Message-ID: <20220316153001.662422-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_06,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a rpmsg channel has been created locally with a destination address
set to RPMSG_ADDR_ANY, a name service announcement message is sent to
the remote side. Then the destination address is never updated, making it
impossible to send messages to the remote.

An example of kernel trace observed:
rpmsg_tty virtio0.rpmsg-tty.29.-1: invalid addr (src 0x1d, dst 0xffffffff)

Implement same strategy than the open-amp library:
On the reception of the first message, if the destination address is
RPMSG_ADDR_ANY, then set it to address of the remote endpoint that
send the message.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---
Update from V1:
- fix rpmsg address conversion from fvirtio to cpu format,
  reported-by the kernel test robot <lkp@intel.com>.

Remarks:

- This issue has been detected during validation of the rpmsg_char
  restructuring series on going[1].
  Tested on the rpmsg_next branch[2]

- An alternative (or a complement?) could be to add a NS bind/unbind in
  the NS announcement channel (in rpmsg_ns.c).
  This would allow the local and/or the remote processor to inform the
  remote side the the service announced in bound.

[1] https://lkml.org/lkml/2022/1/24/293
[2] https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next

---
 drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3ede25b1f2e4..152b54b83782 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -708,6 +708,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 			     struct rpmsg_hdr *msg, unsigned int len)
 {
+	struct rpmsg_device *rpdev;
 	struct rpmsg_endpoint *ept;
 	struct scatterlist sg;
 	bool little_endian = virtio_is_little_endian(vrp->vdev);
@@ -746,6 +747,15 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 	mutex_unlock(&vrp->endpoints_lock);
 
 	if (ept) {
+		rpdev = ept->rpdev;
+		if (rpdev->ept == ept && rpdev->dst == RPMSG_ADDR_ANY) {
+			/*
+			 * First message received from the remote side on the default endpoint,
+			 * update channel destination address.
+			 */
+			rpdev->dst = __rpmsg32_to_cpu(little_endian, msg->src);
+		}
+
 		/* make sure ept->cb doesn't go away while we use it */
 		mutex_lock(&ept->cb_lock);
 
-- 
2.25.1

