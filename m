Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A507567513
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiGERBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiGERBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:01:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F631C903;
        Tue,  5 Jul 2022 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657040481; x=1688576481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KJEqjiyJCjcTLZ25oWrA2VIRC1Sd75b2tLdI9i17zxI=;
  b=UuO+YUqSuAamtBAHqcl8CCOHXV2RsJgpfILWu6gIjhbCVYsVXUqHRQlW
   RZhCWSC/kHZsViPSCQbEZiJ41SKWrVbUh/40JmNIFxpehToh3DdTZ7YEO
   YLgFdfuJlFSJNe4TAou0ygYgWIg6C40XmBipsZmRdMzJ049EAK3Pw0Qnp
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 10:01:21 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Jul 2022 10:01:19 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Jul 2022 22:30:58 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 53C003CBE; Tue,  5 Jul 2022 22:30:57 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        bjorn.andersson@linaro.org, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v4 2/7] drm: add helper functions to retrieve old and new crtc
Date:   Tue,  5 Jul 2022 22:30:40 +0530
Message-Id: <1657040445-13067-3-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new helper functions, drm_atomic_get_old_crtc_for_encoder
and drm_atomic_get_new_crtc_for_encoder to retrieve the
corresponding crtc for the encoder.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/drm_atomic.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  7 ++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 58c0283..87fcb55 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -983,6 +983,66 @@ drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
 EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
 
 /**
+ * drm_atomic_get_old_crtc_for_encoder - Get old crtc for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the crtc state for
+ *
+ * This function finds and returns the crtc that was connected to @encoder
+ * as specified by the @state.
+ *
+ * Returns: The old crtc connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_crtc *
+drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
+				    struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_old_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_crtc_for_encoder);
+
+/**
+ * drm_atomic_get_new_crtc_for_encoder - Get new crtc for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the crtc state for
+ *
+ * This function finds and returns the crtc that will be connected to @encoder
+ * as specified by the @state.
+ *
+ * Returns: The new crtc connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_crtc *
+drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
+				    struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
+
+/**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
  * @connector: connector to get state object for
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 0777725..7001f12 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -528,6 +528,13 @@ struct drm_connector *
 drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
 					 struct drm_encoder *encoder);
 
+struct drm_crtc *
+drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+struct drm_crtc *
+drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+
 /**
  * drm_atomic_get_existing_crtc_state - get CRTC state, if it exists
  * @state: global atomic state object
-- 
2.7.4

