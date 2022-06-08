Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB35421D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiFHEwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFHEvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1A2717AB;
        Tue,  7 Jun 2022 18:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654651042; x=1686187042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=k1TdWJdCOte5lEmhirdFhp1kWl2phGEs6DbE8zLu2oQ=;
  b=wjLJxzHbopOqCRppzLNHsj9CT3DesharkOuAaaPH4GtHlFHrLP4aGx9Y
   v3O+OBTo6qUWPDgX/dhlscjfsfYH80S755qp6yYUWlaWJXn6ZNSzc0FHQ
   RHX/WTnNGXMpuaYWEa3aF8fcnds3xn09t+LlDUs2Qvmb8y1DDQBp/EUu+
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 18:17:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:17:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:19 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:19 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 1/4] rpmsg: core: Add rx done hooks
Date:   Tue, 7 Jun 2022 18:16:42 -0700
Message-ID: <1654651005-15475-2-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the amount of copies in the rpmsg framework, it is
necessary for clients to take brief ownership of the receive buffer.

Add the capability for clients to notify the rpmsg framework and the
underlying transports when it is going to hold onto a buffer and also
notify when the client is done with the buffer.

In the .rx_cb of the rpmsg drivers, if they wish to use the received
buffer at a later point, they should return RPMSG_DEFER. Otherwise
returning RPMSG_HANDLED (0) will signal the framework that the client
is done with the resources and can continue with cleanup.

The clients should check if their rpmsg endpoint supports the rx_done
operation with the new state variable in the rpmsg_endpoint since not
all endpoints will have the ability to support this operation.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  1 +
 include/linux/rpmsg.h          | 24 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 290c1f02da10..359be643060f 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -351,6 +351,26 @@ ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 }
 EXPORT_SYMBOL(rpmsg_get_mtu);
 
+/**
+ * rpmsg_rx_done() - release resources related to @data from a @rx_cb
+ * @ept:	the rpmsg endpoint
+ * @data:	payload from a message
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->rx_done)
+		return -ENXIO;
+	if (!ept->rx_done)
+		return -EINVAL;
+
+	return ept->ops->rx_done(ept, data);
+}
+EXPORT_SYMBOL(rpmsg_rx_done);
+
 /*
  * match a rpmsg channel with a channel info struct.
  * this is used to make sure we're not creating rpmsg devices for channels
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index a22cd4abe7d1..99cb86ce638e 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -76,6 +76,7 @@ struct rpmsg_endpoint_ops {
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
 	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
+	int (*rx_done)(struct rpmsg_endpoint *ept, void *data);
 };
 
 struct device *rpmsg_find_device(struct device *parent,
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 523c98b96cb4..8e34222e8bca 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -63,6 +63,18 @@ struct rpmsg_device {
 	const struct rpmsg_device_ops *ops;
 };
 
+/**
+ * rpmsg rx callback return definitions
+ * @RPMSG_HANDLED: rpmsg user is done processing data, framework can free the
+ *                 resources related to the buffer
+ * @RPMSG_DEFER:   rpmsg user is not done processing data, framework will hold
+ *                 onto resources related to the buffer until rpmsg_rx_done is
+ *                 called. User should check their endpoint to see if rx_done
+ *                 is a supported operation.
+ */
+#define RPMSG_HANDLED	0
+#define RPMSG_DEFER	1
+
 typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
@@ -71,6 +83,7 @@ typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
  * @refcount: when this drops to zero, the ept is deallocated
  * @cb: rx callback handler
  * @cb_lock: must be taken before accessing/changing @cb
+ * @rx_done: if set, rpmsg endpoint supports rpmsg_rx_done
  * @addr: local rpmsg address
  * @priv: private data for the driver's use
  *
@@ -93,6 +106,7 @@ struct rpmsg_endpoint {
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
 	struct mutex cb_lock;
+	bool rx_done;
 	u32 addr;
 	void *priv;
 
@@ -192,6 +206,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 
+int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data);
+
 #else
 
 static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
@@ -316,6 +332,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return -ENXIO;
 }
 
+static inline int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
2.7.4

