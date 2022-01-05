Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364F148513F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiAEKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiAEKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:41:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F18C061799
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:41:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so3349406pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TM0oLFqK3+UblxbHfTgaii4BcWivZsyv76psXuHkAdQ=;
        b=Wqv/xa7APOKvS+s3RtMpjui+rD9jasoB6tSE+FjVCW8X415sA8drSS/BncsVrgmxxd
         A+nZyiqcJ4kQB5rUfWk19i/MsMUH5qK4ye52bC6lPU//4UnrJOJjCpu29uJV7tF1FZ3n
         ZJOXdJERk87GXedAato/cC7FfmDZFb5pQ4KurmchfwIMd/tx7UeJPwd0HwXOX3Pfh0wl
         wU2Ykot+QW0ORHLfOHQ2/M3vatX4lPcEzyno4tPqwPwr0bsJ5YhvuvlzUWo96FnXQImh
         SGrmfKrEooeFhH4oV/NfyCoHpUHWGmPemW1x2mfb/PxpgUBzzFP9d9usXNuV388nU2a4
         sOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TM0oLFqK3+UblxbHfTgaii4BcWivZsyv76psXuHkAdQ=;
        b=OmO6T/RdBjUkyHO6vgVRLBuc/Qgy2KG9fEICxJ3sbU9ShDMiBRmuXm3aJNg2hZhKpO
         hIzsjSTBB0qldh3/bweoiPxdBUlwW8UF+QiZuvEp5G/LeaUAqsFbwVgIFabQ2tJWJKb1
         4jS51ZbD8XxEvGEhthgr79KuS/D1/HtSQ9S36IhoKLWNy7Qgp5CEQIfQ4Q+KJD/ZwETl
         35rXeKW6v6LgRbpbYavo0NLowsv66FQ+E5u2zTHLLVK5u/CUFctffDAJGr3Ujon2oHWX
         pwZ6UgEjRfmHiaf7HkWk5QoKw9C73vn4/SJjNUCIqM6kaxUWYOF+BFQXzRPEtx/SISks
         ycvw==
X-Gm-Message-State: AOAM530mEj7kSGrGEXpmzuFSMSgLbLS6biBwwe/0jLVRtcUxbXTMTqV9
        QSAe0O0K633q7bOxcn+7Rks=
X-Google-Smtp-Source: ABdhPJyN+oiNrioaglDT7LRwLdlGJri9Di6VOmybaC+NlrIgziwYwB5nKvtevXHMnH142YAulUz+hg==
X-Received: by 2002:a17:902:d4c8:b0:149:c99e:dd83 with SMTP id o8-20020a170902d4c800b00149c99edd83mr3274694plg.146.1641379279705;
        Wed, 05 Jan 2022 02:41:19 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a17sm2254134pjs.23.2022.01.05.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:41:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: Add missing pm_runtime_disable() in __dw_mipi_dsi_probe
Date:   Wed,  5 Jan 2022 10:41:09 +0000
Message-Id: <20220105104113.31415-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for __dw_mipi_dsi_probe.

Fixes: 46fc515 ("drm/bridge/synopsys: Add MIPI DSI host controller bridge")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index e44e18a0112a..56c3fd08c6a0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1199,6 +1199,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
 	if (ret) {
 		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
+		pm_runtime_disable(dev);
 		dw_mipi_dsi_debugfs_remove(dsi);
 		return ERR_PTR(ret);
 	}
-- 
2.17.1

