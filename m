Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116AE53AA52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351279AbiFAPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355740AbiFAPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:37:59 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17331506
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1654097871; bh=PKtd8/u8nWjPZdGzm0jz3lmh4Yz0PlPqWAloSXTo6Z8=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 6kfXov/hiy58kWFWjSHXhI4vNABC6bffFqWOsJcg+b0W5QH9j9HjLZDfk+BvG5FaI6cSSPkz44NybJcB3Lk7CA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1654097871; bh=PKtd8/u8nWjPZdGzm0jz3lmh4Yz0PlPqWAloSXTo6Z8=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 anI+lOJGOjXGhC67isOqDl7m7OBz99DhbhX0eZJv5RGWxX7l1CiI3okmtAhaQAP29mPm1D3CBL60qkag43ZO+lyHZpUXHdLd6ya4Dlkz+ylavx2Q1Pvl5rzPakRXe25wYsFcqa2r9aPdxhz1ash3anJdeTmyqEkzl2/DJGkidyA=
Received: from 139.30.22.81 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 01 Jun 2022 15:37:51 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.94) by
 email1.uni-rostock.de (139.30.22.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 1 Jun 2022 17:37:50 +0200
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        Johannes Berg <johannes.berg@intel.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: read multiple msg from virtio slave request fd
Date:   Wed, 1 Jun 2022 15:37:22 +0000
Message-ID: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.94]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 email1.uni-rostock.de (139.30.22.81)
X-TM-SNTS-SMTP: 65432843B81598EC2F6963A9BD00A45E17CF9588109DE9673455B75DF549C1F72002:8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is activated, the user mode
linux virtio irq handler only read one msg from the corresponding socket.
This creates issues, when the device emulation creates multiple call
requests (e.g. for multiple virtqueues), as the socket buffer tend to fill
up and the call requests are delayed.

This creates a deadlock situation, when the device simulation blocks,
because of sending a msg and the kernel side blocks because of
synchronously waiting for an acknowledge of kick request.

Actually inband notifications are meant to be used in combination with the
time travel protocol, but it is not required, therefore this corner case
needs to be handled.

Anyways, in general it seems to be more natural to consume always all
messages from a socket, instead of only a single one.

Fixes: 2cd097ba8c05 ("um: virtio: Implement VHOST_USER_PROTOCOL_F_SLAVE_REQ")
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/drivers/virtio_uml.c | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ba562d68dc04..0c171dd11414 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -363,45 +363,47 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 		struct vhost_user_msg msg;
 		u8 extra_payload[512];
 	} msg;
-	int rc;
-
-	rc = vhost_user_recv_req(vu_dev, &msg.msg,
-				 sizeof(msg.msg.payload) +
-				 sizeof(msg.extra_payload));
-
-	if (rc)
-		return IRQ_NONE;
-
-	switch (msg.msg.header.request) {
-	case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
-		vu_dev->config_changed_irq = true;
-		response = 0;
-		break;
-	case VHOST_USER_SLAVE_VRING_CALL:
-		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
-			if (vq->index == msg.msg.payload.vring_state.index) {
-				response = 0;
-				vu_dev->vq_irq_vq_map |= BIT_ULL(vq->index);
-				break;
+	irqreturn_t rc = IRQ_NONE;
+
+	while (1) {
+		if (vhost_user_recv_req(vu_dev, &msg.msg,
+					sizeof(msg.msg.payload)
+					+ sizeof(msg.extra_payload)))
+			break;
+
+		switch (msg.msg.header.request) {
+		case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
+			vu_dev->config_changed_irq = true;
+			response = 0;
+			break;
+		case VHOST_USER_SLAVE_VRING_CALL:
+			virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+				if (vq->index ==
+				    msg.msg.payload.vring_state.index) {
+					response = 0;
+					vu_dev->vq_irq_vq_map |=
+						BIT_ULL(vq->index);
+					break;
+				}
 			}
+			break;
+		case VHOST_USER_SLAVE_IOTLB_MSG:
+			/* not supported - VIRTIO_F_ACCESS_PLATFORM */
+		case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
+			/* not supported - VHOST_USER_PROTOCOL_F_HOST_NOTIFIER */
+		default:
+			vu_err(vu_dev, "unexpected slave request %d\n",
+			       msg.msg.header.request);
 		}
-		break;
-	case VHOST_USER_SLAVE_IOTLB_MSG:
-		/* not supported - VIRTIO_F_ACCESS_PLATFORM */
-	case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
-		/* not supported - VHOST_USER_PROTOCOL_F_HOST_NOTIFIER */
-	default:
-		vu_err(vu_dev, "unexpected slave request %d\n",
-		       msg.msg.header.request);
-	}
-
-	if (ev && !vu_dev->suspended)
-		time_travel_add_irq_event(ev);
 
-	if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
-		vhost_user_reply(vu_dev, &msg.msg, response);
+		if (ev && !vu_dev->suspended)
+			time_travel_add_irq_event(ev);
 
-	return IRQ_HANDLED;
+		if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
+			vhost_user_reply(vu_dev, &msg.msg, response);
+		rc = IRQ_HANDLED;
+	}
+	return rc;
 }
 
 static irqreturn_t vu_req_interrupt(int irq, void *data)
-- 
2.25.1
