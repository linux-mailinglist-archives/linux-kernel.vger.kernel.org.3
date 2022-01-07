Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A1487446
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbiAGIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiAGIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:50:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927DC061245;
        Fri,  7 Jan 2022 00:50:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v25so4938175pge.2;
        Fri, 07 Jan 2022 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IQS4J/qtHwJGGOnAQs0o0rtK4NFNyvH92Ln82XpYq1E=;
        b=BR9uftG+cCtV8P36GOU+YlObjfqGNjV8mIZYTwYw5+DCzL+BOwdPwVbM3W2Gruavzu
         32qKXVL3Pm05dggOZeyGMYvmCVPqcnm644blBcdbV+bKenZmugHuv991x8t0KfqfwIQV
         72D0fgW9hmUTsgWjbgKZS4YCyBQ6kgfjpKzcwJtq1bvHQx4X4zTIOnNbJAxtClRLGJZi
         1zSj3Oy67PRKgvBwhkJl8UPb6juw9oepXa+8aF6xLEm5RXNB/y3goROq2NB66Nv9KWMr
         AfoSW1ItYV32P/T0irVa6Bw4SK9lVifs8P2m69RBE0IXafbaxoNuzUp8px1kY9ZYE5wB
         Mxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IQS4J/qtHwJGGOnAQs0o0rtK4NFNyvH92Ln82XpYq1E=;
        b=VOvnUCf5X7LXaC7OJfaHyZA89O1UjxpEWNEfkrDrT4w9WngsF/5/pNBJ+8Sx4ELsyn
         N5ckMDs6fpiKv1kfyjP2RoV5lPehgZ2aJjlS2ezwDBKxm4V5C8ePsbwJTgiVwb7Z6gHc
         mzyJTRqTaXAeTX82mC0mSUbSQA/IYmmRpjmnobJ83sXhDuOoih8DGPzlAToCGCJk36nI
         5ahxUgCHUJ3IJ2FkuXEWK50sxuo1luvVbTA/kAQfQPXFVHgEr47ICm1clVO2jPXw4x75
         C9Q9FTdbWFAt8MFEWlrMkcCSkkYZENLBBXv2obz0TrjMeqFJyBKil7IcPBxBp+PPps4X
         FkIg==
X-Gm-Message-State: AOAM531vGqQlFcF2rJIr/I2mdfKSC1v6Vhbwzzwe7CskblqHVdgQrUjj
        rntUSmEYfsz3v/gO4HF7Zw8=
X-Google-Smtp-Source: ABdhPJzrezcJmoyT8I5bb9IzMr0GwT31Qhm2NI7Dx6C7H3w2cx5/PuMuN/+otYHv28cEYnq5kQUd5w==
X-Received: by 2002:a63:8149:: with SMTP id t70mr55367147pgd.71.1641545433164;
        Fri, 07 Jan 2022 00:50:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f20sm5167583pfe.166.2022.01.07.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:50:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/hdmi: Fix missing put_device() call in msm_hdmi_get_phy
Date:   Fri,  7 Jan 2022 08:50:22 +0000
Message-Id: <20220107085026.23831-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: e00012b256d4 ("drm/msm/hdmi: Make HDMI core get its PHY")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 75b64e6ae035..a439794a32e8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -95,10 +95,15 @@ static int msm_hdmi_get_phy(struct hdmi *hdmi)
 
 	of_node_put(phy_node);
 
-	if (!phy_pdev || !hdmi->phy) {
+	if (!phy_pdev) {
 		DRM_DEV_ERROR(&pdev->dev, "phy driver is not ready\n");
 		return -EPROBE_DEFER;
 	}
+	if (!hdmi->phy) {
+		DRM_DEV_ERROR(&pdev->dev, "phy driver is not ready\n");
+		put_device(&phy_pdev->dev);
+		return -EPROBE_DEFER;
+	}
 
 	hdmi->phy_dev = get_device(&phy_pdev->dev);
 
-- 
2.17.1

