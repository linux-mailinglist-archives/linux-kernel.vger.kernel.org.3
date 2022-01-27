Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88D49E854
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiA0REW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbiA0REV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:04:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696FDC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:04:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso6391821wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq5JSeGAWZi1OsdDMQABwbOnDerwbPa8wE4vgOTW8/Y=;
        b=zcjytRgZhKk0UVB7sTJ2tWYadwRdtz8tU5dbL4itdSgdGa+Vfi1ivXb0DOX0wFJnF+
         jCTR+jwLKPiSOZAKRpM2zaK0baqKzuM5lWOZLUdDtKR3vP11Hlv8hQflCJkcyq/suMp/
         AxQ45gYnkkKnBGDvIN/sZ+HoA8TZhod5ouV9IHOJBGuU2m5JJMgoATDywhudRYjGpBJ9
         zdnW/Z8ZeWGS8QML+ZprPfhrzpxL8QTqPzqoszoFH1RaF/15uSsx0BRE/LhZ6UtlmPD9
         rz9A0ZscZRDDQsqNh1Ni9CxtrlmHzWAgfpbaBPX4WaTRRbLvOQ7TVyvEifxwMsr4j/oA
         Ey4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq5JSeGAWZi1OsdDMQABwbOnDerwbPa8wE4vgOTW8/Y=;
        b=rV1WR3cSrxQY/mhZHwoen0V3rEc+mWTusl7aWseWs/hAVAvtdqqoZzC95rBKXc6xk7
         +j+JI1AHEA/q1Cw++PuuhzaBKpdVQ7n7dPhLycdhYR8pb4AprXx4DF8huPTM9XngF27Z
         hfhjiFRFsOgNUrWy+605wc/sylLTnP38T51i3OkQ2d65h/3YipBIWQ0APAcqlApgtT7P
         VCUIs+C0BxrTA0tOuQKyy+hrcWXW/3thqIj5VLqHU1Sg/VrnLHGwl3kpXcCuKY1bb6NC
         FKx+aid6JHBwjsnfT96tiqZOYp/Kno4EeJMLjh8EXAEVWtfGr1TdMtvvE68kAsK6BJ/m
         Lx2w==
X-Gm-Message-State: AOAM531KrH40FklzDrIj7YSLu44e6ekphYwINjSO0nlAGzpPhKEyZ2hC
        +MgxTMcFgke5Ys39spC02vbztw==
X-Google-Smtp-Source: ABdhPJyBI5EHJ0MpglMjqGADM1SO/QEfD2Zy/mqKdhdp8dhVZB6esmP/S8cjIf8hsX6ZeIdl6n6hjg==
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr3902521wms.107.1643303059880;
        Thu, 27 Jan 2022 09:04:19 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t18sm2677495wri.34.2022.01.27.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:04:19 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Remove spurious IRQF_ONESHOT flags from dsi & hdmi
Date:   Thu, 27 Jan 2022 17:04:05 +0000
Message-Id: <20220127170405.155710-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
which need to keep the irq line disabled until the threaded handler has
been run.". When applied to an interrupt that doesn't request a threaded
irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
which it to disable the forced threading of irqs (and for "normal" kernels
it is a nop). In this case I can find no evidence that suppressing forced
threading is intentional. Had it been intentional then a driver must adopt
the raw_spinlock API in order to avoid deadlocks on PREEMPT_RT kernels
(and avoid calling any kernel API that uses regular spinlocks).

Fix this by removing the spurious additional flag.

This change is required for my Snapdragon 7cx Gen2 tablet to boot-to-GUI
with PREEMPT_RT enabled.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Just in case anybody asks, yes! I did use coccinelle to do a quick scan
    for similar issues. I didn't find any other instances in drivers/drm/ .

 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 6b3ced4aaaf5d..3a3f53f0c8ae1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1877,7 +1877,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)

 	/* do not autoenable, will be enabled later */
 	ret = devm_request_irq(&pdev->dev, msm_host->irq, dsi_host_irq,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+			IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
 			"dsi_isr", msm_host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ%u: %d\n",
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 3acdeae25caf0..a1bfbc4c74bf7 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -301,7 +301,7 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 	}

 	ret = devm_request_irq(&pdev->dev, hdmi->irq,
-			msm_hdmi_irq, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+			msm_hdmi_irq, IRQF_TRIGGER_HIGH,
 			"hdmi_isr", hdmi);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev->dev, "failed to request IRQ%u: %d\n",

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
--
2.34.1

