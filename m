Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7E480629
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 05:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhL1E6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 23:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhL1E6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 23:58:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F2C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 20:58:34 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s73so28338338oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 20:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98szpQBZjtZvNYlpyX/l6mXnydiaf9Cz3PXEMmMi7WI=;
        b=RkAse5a++wcvwXouZbSPgrz1WAGLQRgomwBlTuBF+n11/dsDnSAFBiJ5IZO71tXwWQ
         oG3FDo764vE2UDNwyhMV8XKQTjJ2EVfvXYrhWV84Nz2dPQRNRJGhvSbzCQ6Kvi9wletK
         IyNqaEnQOApQTc2sh/uEynNLXrOozmRDI3YVa8JTHsf6CQfPaoW2BqoLiBD6q7HpYBym
         GGI4CQXhGZAhFOrBfxmUFmGYOMxRPQbYcKDIqFbWJ6LsKOZRGv7c4YGCan52dlHN0SIX
         HnKaSdR0XXsFutjqissD5fp8Rsn/LZoyqDuI87U5H+YAlIFzeZaPKnRGVzD1+U4SDi1I
         OfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98szpQBZjtZvNYlpyX/l6mXnydiaf9Cz3PXEMmMi7WI=;
        b=wP9bYn/qnNzLHYMU8m6VUUWv/dGt/69KSEC9Vm9CS4e9qwKTWLgQhcbnOWA/juYYOG
         loRTHXFH116Qm64fN56FlvMp3Oar7L/4pHj17yNN0ah+4mlD1e9D6gyB9YRSspqio/tb
         fLOICgiblkdNht+ZonL+HxyMSxeaSoHmuDpnWfQXPteKk4Y6Dj/Xm01HUwv3eOE7j2OL
         j8mpmqlAgnBWf4pmS4sVtNbabQiCSUDsJO+SGOVtJXXnODSImwK+pBJgQ8LuesANWO6W
         2rcAsKFqw59GAdbyjCJrZhstQx3G0ECyP5oBTZSib8T0dPOIjdeYEAHIrFwUtto83Ls3
         PSIw==
X-Gm-Message-State: AOAM530ywL6n51lyCgMULBgertznII5fPDJk1lsqZaLXqP5DgbcS7Qx6
        EW6MqDHLFEY8uEQTzzMvzsUPaQ==
X-Google-Smtp-Source: ABdhPJw0LCJVxHQQ9QCWqtmjXSIikXnypZw3Qfu/0FsEFSTp1ESZgDOl8PKo+a6h8HMAc8zWhQBM9g==
X-Received: by 2002:a05:6808:aa7:: with SMTP id r7mr15681459oij.120.1640667514163;
        Mon, 27 Dec 2021 20:58:34 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n18sm3004786ooj.30.2021.12.27.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 20:58:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Add DisplayPort controller for SM8350
Date:   Mon, 27 Dec 2021 20:59:34 -0800
Message-Id: <20211228045934.1524865-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8350 platform comes with a single DisplayPort controller,
add support for this in the DisplayPort driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml    | 1 +
 drivers/gpu/drm/msm/dp/dp_display.c                       | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 5457612ab136..cd05cfd76536 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -21,6 +21,7 @@ properties:
       - qcom,sc7280-edp
       - qcom,sc8180x-dp
       - qcom,sc8180x-edp
+      - qcom,sm8350-dp
 
   reg:
     items:
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8d9c19dbf33e..fd0fd03f8fed 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -143,10 +143,18 @@ static const struct msm_dp_config sc7280_dp_cfg = {
 	.num_descs = 2,
 };
 
+static const struct msm_dp_config sm8350_dp_cfg = {
+	.descs = (const struct msm_dp_desc[]) {
+		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	},
+	.num_descs = 1,
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_cfg },
 	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_cfg },
+	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_cfg },
 	{}
 };
 
-- 
2.33.1

