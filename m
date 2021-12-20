Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319C47B53A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhLTVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhLTVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:31:26 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E66C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:26 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id kj16so6633075qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TZsqgcnexho8xD1nxnnl9R0Pkmm2FcWy2QDii/7Sys=;
        b=n7n49IRDQvxi7CHuTHh+u+OuE171gKGZZ7wBNG9SVgP38qEBz6+/x1F90nKaiV8OR0
         Wgke/xLnpPtMYahVI6VTnKVS8h/pfBCINkn05Sl4blF9cx+mjPjwMYprlCp5h2T2HsTZ
         LVYtvBMKom+l8h1LcausygllYlzPVz5DfaAgxCTTA/Jg8T9SAMKWuj1VAOnrUPgftosv
         b3awbxGC2I0RLoqfzUfYnZlMUPjAimgzb78J7XCGrtPg7bTSrWFcwga6oKYpdS01H9Ho
         hGTyLu+V6ap9V+bAMbm+jtp7RuyNDryH/G/8UHie+aqJbqYse+CzgO1MlUaVEgbL5+Ll
         QGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TZsqgcnexho8xD1nxnnl9R0Pkmm2FcWy2QDii/7Sys=;
        b=C7W6D/Tn2u8k3H3XdoQUE5vVcGA4PQr/JNsn/wiDhabAXklxl1ZSOkWCMQ2GMUUgRG
         1GyWedwpf1adP8IZUeaqxybYDdOdSit1Y/lIgr6GujlolW9bklw3DgiunJi5SjdroOU2
         sGxgp4lo99FIuANztCc7hU3vJ/R4T26yfz1UtrviLTbX5dWsgiwkvCtZJv4BpZW7E+Sv
         jSmD3vo05EmmlBYbGcKs+2PrT6GCZ+JwLzmULnhuJdEAUXwiY+1u89uyN5pbo4ft2Q7X
         tU99jhxKfPqgx335k64jgfdy2gD3S+dPmECBBXHt22xkY0Cy7axAdcS7DICKrAV0wigQ
         v5Cg==
X-Gm-Message-State: AOAM531tsiOknvRAISGbmxsIf1dXxXbuANJ0NLtOgVNNAZjxtHVfVL1u
        RmdRC7wx9DFQWOrkszqsCdo=
X-Google-Smtp-Source: ABdhPJy805I2vaVWrMqFtSrfyvP2UMaV1jMyh9EYwgEB2ksQ59Z01784aSMHQfsx1wy4tIwFV0eJNA==
X-Received: by 2002:a05:6214:500f:: with SMTP id jo15mr39831qvb.64.1640035885582;
        Mon, 20 Dec 2021 13:31:25 -0800 (PST)
Received: from localhost.localdomain ([181.23.83.92])
        by smtp.gmail.com with ESMTPSA id s20sm16132210qtc.75.2021.12.20.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:31:25 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH 3/4] staging: vc04_services: avoid the use of typedef for function pointers
Date:   Mon, 20 Dec 2021 18:29:13 -0300
Message-Id: <a218f1bd092d874ccd96e3a94c1174ad41fffebc.1639858361.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639858361.git.gascoar@gmail.com>
References: <cover.1639858361.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the function pointer typedef vchiq_mmal_buffer_cb with
equivalent declaration to better align with the linux kernel coding
style.

While at it, realignments were done in some touched lines.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 24 +++++++++----------
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 13 +++++-----
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f0399964..54e5ce245ae7 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -269,10 +269,10 @@ static void buffer_work_cb(struct work_struct *work)
 
 	atomic_dec(&msg_context->u.bulk.port->buffers_with_vpu);
 
-	msg_context->u.bulk.port->buffer_cb(msg_context->u.bulk.instance,
-					    msg_context->u.bulk.port,
-					    msg_context->u.bulk.status,
-					    msg_context->u.bulk.buffer);
+	msg_context->u.bulk.port->vchiq_mmal_buffer_cb(msg_context->u.bulk.instance,
+						       msg_context->u.bulk.port,
+						       msg_context->u.bulk.status,
+						       msg_context->u.bulk.buffer);
 }
 
 /* workqueue scheduled callback to handle receiving buffers
@@ -1327,13 +1327,12 @@ static int port_disable(struct vchiq_mmal_instance *instance,
 			mmalbuf = list_entry(buf_head, struct mmal_buffer,
 					     list);
 			list_del(buf_head);
-			if (port->buffer_cb) {
+			if (port->vchiq_mmal_buffer_cb) {
 				mmalbuf->length = 0;
 				mmalbuf->mmal_flags = 0;
 				mmalbuf->dts = MMAL_TIME_UNKNOWN;
 				mmalbuf->pts = MMAL_TIME_UNKNOWN;
-				port->buffer_cb(instance,
-						port, 0, mmalbuf);
+				port->vchiq_mmal_buffer_cb(instance, port, 0, mmalbuf);
 			}
 		}
 
@@ -1363,7 +1362,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 
 	port->enabled = 1;
 
-	if (port->buffer_cb) {
+	if (port->vchiq_mmal_buffer_cb) {
 		/* send buffer headers to videocore */
 		hdr_count = 1;
 		list_for_each_safe(buf_head, q, &port->buffers) {
@@ -1454,9 +1453,10 @@ EXPORT_SYMBOL_GPL(vchiq_mmal_port_parameter_get);
  * enables a port and queues buffers for satisfying callbacks if we
  * provide a callback handler
  */
-int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
-			   struct vchiq_mmal_port *port,
-			   vchiq_mmal_buffer_cb buffer_cb)
+int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance, struct vchiq_mmal_port *port,
+			   void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
+							struct vchiq_mmal_port *port, int status,
+							struct mmal_buffer *buffer))
 {
 	int ret;
 
@@ -1469,7 +1469,7 @@ int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
 		goto unlock;
 	}
 
-	port->buffer_cb = buffer_cb;
+	port->vchiq_mmal_buffer_cb = vchiq_mmal_buffer_cb;
 
 	ret = port_enable(instance, port);
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 1dc81ecf9268..39615ce6584a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -42,11 +42,6 @@ struct vchiq_mmal_port_buffer {
 
 struct vchiq_mmal_port;
 
-typedef void (*vchiq_mmal_buffer_cb)(
-		struct vchiq_mmal_instance  *instance,
-		struct vchiq_mmal_port *port,
-		int status, struct mmal_buffer *buffer);
-
 struct vchiq_mmal_port {
 	u32 enabled:1;
 	u32 handle;
@@ -76,7 +71,9 @@ struct vchiq_mmal_port {
 	/* Count of buffers the VPU has yet to return */
 	atomic_t buffers_with_vpu;
 	/* callback on buffer completion */
-	vchiq_mmal_buffer_cb buffer_cb;
+	void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
+				     struct vchiq_mmal_port *port, int status,
+				     struct mmal_buffer *buffer);
 	/* callback context */
 	void *cb_ctx;
 };
@@ -126,7 +123,9 @@ int vchiq_mmal_component_disable(
 int vchiq_mmal_port_enable(
 		struct vchiq_mmal_instance *instance,
 		struct vchiq_mmal_port *port,
-		vchiq_mmal_buffer_cb buffer_cb);
+		void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
+					     struct vchiq_mmal_port *port, int status,
+					     struct mmal_buffer *buffer));
 
 /* disable a port
  *
-- 
2.34.1

