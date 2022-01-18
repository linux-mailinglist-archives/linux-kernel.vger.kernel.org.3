Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E70492E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiARTnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:43:40 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48977 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348857AbiARTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642535018; x=1674071018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TUQqOnkv/900KZUw+oFMuV11j7TdNX7txIgYkN3/bw0=;
  b=GjEuLwYA6kC5IEy2sPnpzzpsMzzKzphzHMzPLmxMHe+79SSbzP6HRQWy
   Xm7g7vmOjVPdm9p9UT59hfGvMkcdCqNpQwDjA8ucG1NyfVgW9BtgrAX1w
   CYqggWl9v9PuvA9Yf0NhF0+L4ROQmP2rexKG0qR/3yitLh/0eCeWai7FL
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Jan 2022 11:43:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:43:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 11:43:37 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 11:43:34 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH V2 1/3] rpmsg: core: Add signal API support
Date:   Wed, 19 Jan 2022 01:13:11 +0530
Message-ID: <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some transports like Glink support the state notifications between
clients using signals similar to serial protocol signals.
Local glink client drivers can send and receive signals to glink
clients running on remote processors.

Add APIs to support sending and receiving of signals by rpmsg clients.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  2 ++
 include/linux/rpmsg.h          | 14 ++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index d3eb600..6712418 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -328,6 +328,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
 /**
+ * rpmsg_set_flow_control() - sets/clears serial flow control signals
+ * @ept:	the rpmsg endpoint
+ * @enable:	enable or disable serial flow control
+ *
+ * Return: 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->set_flow_control)
+		return -ENXIO;
+
+	return ept->ops->set_flow_control(ept, enable);
+}
+EXPORT_SYMBOL(rpmsg_set_flow_control);
+
+/**
  * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
  * @ept: the rpmsg endpoint
  *
@@ -535,6 +553,9 @@ static int rpmsg_dev_probe(struct device *dev)
 
 		rpdev->ept = ept;
 		rpdev->src = ept->addr;
+
+		if (rpdrv->signals)
+			ept->sig_cb = rpdrv->signals;
 	}
 
 	err = rpdrv->probe(rpdev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b1245d3..35c2197 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -53,6 +53,7 @@ struct rpmsg_device_ops {
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
  * @poll:		see @rpmsg_poll(), optional
+ * @set_flow_control:	see @rpmsg_set_flow_control(), optional
  * @get_mtu:		see @rpmsg_get_mtu(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
@@ -73,6 +74,7 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
 	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
 };
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 02fa911..06d090c 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -62,12 +62,14 @@ struct rpmsg_device {
 };
 
 typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
  * @rpdev: rpmsg channel device
  * @refcount: when this drops to zero, the ept is deallocated
  * @cb: rx callback handler
+ * @sig_cb: rx serial signal handler
  * @cb_lock: must be taken before accessing/changing @cb
  * @addr: local rpmsg address
  * @priv: private data for the driver's use
@@ -90,6 +92,7 @@ struct rpmsg_endpoint {
 	struct rpmsg_device *rpdev;
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
+	rpmsg_rx_sig_t sig_cb;
 	struct mutex cb_lock;
 	u32 addr;
 	void *priv;
@@ -111,6 +114,7 @@ struct rpmsg_driver {
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
 	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*signals)(struct rpmsg_device *rpdev, void *priv, u32);
 };
 
 static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
@@ -188,6 +192,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
+
 #else
 
 static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
@@ -306,6 +312,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return -ENXIO;
 }
 
+static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
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

