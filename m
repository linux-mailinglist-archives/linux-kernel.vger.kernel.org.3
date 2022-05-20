Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301B52E7A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbiETIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347160AbiETIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:33:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA5F15F6C8;
        Fri, 20 May 2022 01:32:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3tLjB028145;
        Fri, 20 May 2022 10:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=c/Lq0oy39Sxj5Cf7Ma+CafFIl6MIsyg+0GLBTzXk1No=;
 b=zRkUXEdtfH8syzUhy3lFopRF1TbdtxZIywyejyCWnUNX26LEVEDLybDrMkuoTAYKQ8/T
 653omNVZBb68VWCRg6tGVim8HxtRfYW+cfDoRuVn2Sqo8OaMnlj2cPgA3AKvcIZSiXBC
 6/AE7bTSMalsCjyAOEfpcwpgzRTC/XkHo5GGGlPl4XbktN3MYbSGCj/a8KW522zhqPuQ
 Z1W3/YkC2Si2Ggign9MmSNMJFqNypEXhp4qIQKQfeXOIAijYbuOfpcHDfIVuLUTevTeL
 X4o+jwGgm252pY5zmExI9C7gL6jCye1DWsZ5i0ovj1h4qPGGYH6ho8dFue9JgrTRLLG9 sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23s22u1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:32:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9A8010002A;
        Fri, 20 May 2022 10:32:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D11EB215124;
        Fri, 20 May 2022 10:32:23 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:32:22 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 10/10] rpmsg: virtio: Set default dst address on flow control
Date:   Fri, 20 May 2022 10:29:40 +0200
Message-ID: <20220520082940.2984914-11-arnaud.pouliquen@foss.st.com>
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

When a rpmsg channel has been created locally with a destination address
set to RPMSG_ADDR_ANY, a name service announcement message is sent to
the remote side. Then the destination address is never updated, making it
impossible to send messages to the remote.

An example of kernel trace observed:
rpmsg_tty virtio0.rpmsg-tty.29.-1: invalid addr (src 0x1d, dst 0xffffffff)

The flow control can be used to set the rpmsg device address.
If the destination address is RPMSG_ADDR_ANY, then set it to
address of the remote endpoint that send the message.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
This patch is an alternative of the fix proposed in patch [1]

[1] https://lore.kernel.org/lkml/20220316153001.662422-1-arnaud.pouliquen@foss.st.com/
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index a8e60ca4cd08..0337a07e278c 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -393,6 +393,16 @@ static int virtio_rpmsg_remote_flowctrl(struct rpmsg_device *rpdev,
 	if (!ept)
 		return -EINVAL;
 
+	/*
+	 * If the endpoint is the rpmsg device default one, then it can not be yet associated
+	 * to the remote endpoint. This can occur if a ns announcement message has been
+	 * previously sent to the remote side.
+	 * Update the rpmsg device destination address in such case to store the remote
+	 * address as default remote endpoint.
+	 */
+	if (rpdev->ept == ept && rpdev->dst == RPMSG_ADDR_ANY)
+		rpdev->dst = __rpmsg32_to_cpu(virtio_is_little_endian(vrp->vdev), chinfo->src);
+
 	/* Make sure ept->sig_cb doesn't go away while we use it */
 	mutex_lock(&ept->cb_lock);
 
-- 
2.25.1

