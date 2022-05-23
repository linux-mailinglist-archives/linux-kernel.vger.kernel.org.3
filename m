Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3066D530BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiEWIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiEWIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:46:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E81006
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:46:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gi33so18742395ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KZ9e+aFywu8cob9B7lyv8cw/GG4lY7xYjZnUL2c5Po=;
        b=x6a0/a59LPzK/XbjLygNZX+iuxxHylNyyOs3r109raURIjnZdsiY/qUM3RzicmAgRL
         g0Nd5CRWwWwTy/qomFzYeX3g/CjTeg2mI7yEXg0HQhnb90sMlip0m/Ew6N+3nNvXE6gg
         9d6FbvhKtkLNXd2qpA354YSaJhzZ6YGKFn+L22TnIUZ23k2hlEo1EFe8LMk6lNiViNpp
         /X2reVm7Zce6S8CAWolYqpb/uizlg/dfwAU1vjiPCCPvPXlrV2wxK3PwFSC2tMnga59d
         ZwxJqzZutwdSpR1Ku3+rfFSeqBer6+OuTmQK+ZjCTgRJS/1k9W2ZQS7pp8ag13X7jC1m
         hyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KZ9e+aFywu8cob9B7lyv8cw/GG4lY7xYjZnUL2c5Po=;
        b=HPCe5O9kef+Y4VOtMOMpIyR20X8GbrGDBx65Znddk6LUpdDMK1RxPlTDk32vOflBWn
         u0CXmwt8tY2auuJ3Pk0tFj+TfoS6V3LBXsU3BlzC6vZsW45feGBQ9TY/MR2ACP85JEJ8
         nfXdZLQRH9IBJlhQZYbASxdbwC3H24RsWSj8e5BON722D2x8Kd6qo+f2MDJ+ACNH5z2K
         YPF/QF3OfL2n5hZarScvAHH2Scfpz/13O5gI+FwARUN4nrZHS9Py3q3sLa2EhiflFrMh
         yXd0tIFY4kf9+1M9W9eQ/hYCqzAP6W1FXqXon6ejZDjQrIkOK0M80AH1LdgcanbW8ZeM
         APkQ==
X-Gm-Message-State: AOAM530YqB/+scCNy3Tmt0rPScxJ423vFOnlgxBiwuPxgYjmGsk8ajjn
        HXSy8IhLo77PZsU81GdH/7e7TA==
X-Google-Smtp-Source: ABdhPJwDRYBw80yFFSMqilCh6Rwe3b3/Gwjq4XKqz2jH2FgXaRVvRV2qPJPfLQhSkrW6CBKtFhnKdw==
X-Received: by 2002:a17:907:78cb:b0:6fe:9ca3:2a9b with SMTP id kv11-20020a17090778cb00b006fe9ca32a9bmr17175623ejc.727.1653295593558;
        Mon, 23 May 2022 01:46:33 -0700 (PDT)
Received: from prec5560.. ([176.74.57.19])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b006fee27d471csm905706ejf.150.2022.05.23.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:46:32 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, tzimmermann@suse.de,
        maxime@cerno.tech, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
Date:   Mon, 23 May 2022 10:46:14 +0200
Message-Id: <20220523084615.13510-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 01f46d9189c1..53a5da6c49dd 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
 
 	anx7625_get_swing_setting(dev, pdata);
 
-	pdata->is_dpi = 0; /* default dsi mode */
+	pdata->is_dpi = 1; /* default dpi mode */
 	pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
 	if (!pdata->mipi_host_node) {
 		DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
 		return -ENODEV;
 	}
 
-	bus_type = 0;
+	bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
 	mipi_lanes = MAX_LANES_SUPPORT;
 	ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
 	if (ep0) {
@@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
 		mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
 	}
 
-	if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
-		pdata->is_dpi = 1;
+	if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
+		pdata->is_dpi = 0;
 
 	pdata->mipi_lanes = mipi_lanes;
 	if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
-- 
2.34.1

