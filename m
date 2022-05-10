Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4C5224D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiEJTaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiEJTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:30:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116B2A2F68
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:30:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so2817949pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spc3e6Lp3Smlzf38aH5fCH48i9kTiBR8/UYKG1CLueQ=;
        b=cz0Xr0eL1ajvZSsgLbzZbq39CiowXavZ6oKFanIVRSuNSdPrMxAI9a+lUYIybRRI8Z
         l9f9QgXxhrErMb0+Rw3GcIBYoSBZvvHafQIs7JEGkOMAMdASorM5GZlqQ/R8kl67yLk+
         MbgQgs1sU2wNKMz62e7ITFkvv7ogeaeVCTLPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spc3e6Lp3Smlzf38aH5fCH48i9kTiBR8/UYKG1CLueQ=;
        b=UDXah5T632zXw6bxYBXGavK7+WV1tvP7X0Lmgc4ao+/kL71NTpBTfxT26jWt3Heur+
         e5Iy0s1xN3dE19FUvx5xfPgX3DJvRD24i+KJbcrEgonGgdS4ES/+xeTbOOTgSHHGcEOO
         4FwHGCK0fpzgzLiEMSjwKkN2cZIaaqfo8laxzKTGzaIXiiexYtph9XNm75ULkDT7y0DM
         n1y5iqblHv22n3fALqhjQvQee9oXC+f8qZUFC8jxI/lcLAo5tEM+Iraw13pUXGxmlDvT
         H8ktiuMz/cE2lL/0LX6DWP533ob82XGQP9DOQxMbP0m2C37EHCq4eGx0yCbrmBTsxx9b
         2+zQ==
X-Gm-Message-State: AOAM532/lXOaPO8j7QM8AjRDrJwjXk099IpKHvwrQpWggs7ynmxN4jvp
        GmUtXrWEQ3goa2Z/N/lLGtDALQ==
X-Google-Smtp-Source: ABdhPJzOGtFQdD3JQK9OwWb3IO12+CBeitf6Rww1LcnbNvhYQovH5NU3lYy2huG1tVOn6wVcGz6pqg==
X-Received: by 2002:a17:90b:1001:b0:1d8:4978:c7d5 with SMTP id gm1-20020a17090b100100b001d84978c7d5mr1405066pjb.167.1652211001798;
        Tue, 10 May 2022 12:30:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6f08:624c:c762:d238])
        by smtp.gmail.com with ESMTPSA id s43-20020a056a001c6b00b0050dc762819dsm10786989pfw.119.2022.05.10.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:30:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
Date:   Tue, 10 May 2022 12:29:43 -0700
Message-Id: <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220510192944.2408515-1-dianders@chromium.org>
References: <20220510192944.2408515-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a devm managed version of drm_bridge_add(). Like other
"devm" function listed in drm_bridge.h, this function takes an
explicit "dev" to use for the lifetime management. A few notes:
* In general we have a "struct device" for bridges that makes a good
  candidate for where the lifetime matches exactly what we want.
* The "bridge->dev->dev" device appears to be the encoder
  device. That's not the right device to use for lifetime management.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Patch ("drm/bridge: Add devm_drm_bridge_add()") new for v3.

 drivers/gpu/drm/drm_bridge.c | 23 +++++++++++++++++++++++
 include/drm/drm_bridge.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c96847fc0ebc..e275b4ca344b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -170,6 +170,29 @@ void drm_bridge_add(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_add);
 
+static void drm_bridge_remove_void(void *bridge)
+{
+	drm_bridge_remove(bridge);
+}
+
+/**
+ * devm_drm_bridge_add - devm managed version of drm_bridge_add()
+ *
+ * @dev: device to tie the bridge lifetime to
+ * @bridge: bridge control structure
+ *
+ * This is the managed version of drm_bridge_add() which automatically
+ * calls drm_bridge_remove() when @dev is unbound.
+ *
+ * Return: 0 if no error or negative error code.
+ */
+int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
+{
+	drm_bridge_add(bridge);
+	return devm_add_action_or_reset(dev, drm_bridge_remove_void, bridge);
+}
+EXPORT_SYMBOL(devm_drm_bridge_add);
+
 /**
  * drm_bridge_remove - remove the given bridge from the global bridge list
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index f27b4060faa2..42aec8612f37 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -796,6 +796,7 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 }
 
 void drm_bridge_add(struct drm_bridge *bridge);
+int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
-- 
2.36.0.550.gb090851708-goog

