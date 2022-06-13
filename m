Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F63549E11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347187AbiFMTux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345939AbiFMTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:50:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE07427F6;
        Mon, 13 Jun 2022 11:20:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 123so6263289pgb.5;
        Mon, 13 Jun 2022 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPIFmqCq08/SpFCwk6A8CEBBfhPP5/Wk5un3Ts1xf9s=;
        b=E+wZjHmzh6EFZ9vKKG60lhqV9ZhJSRLQp2p8vF8yQi4Je1eGft2sy33hBoAmrBsGSA
         X+a6C0rVHwzy99s9ZjqLnj+XDUnhTzAQBZsG01edG+So9XfvQrvAgBL96y+R1ejuSFsx
         x3yViwfQT7IFJ6pt/1+k8s23lwJMdtNZEHe4UnDg5W6JndgtKkmGrKXoeDr5SI5lhtRS
         j6Knod7c94L7jH4fi3bb8yG6CyiXRYMlw8H7vswIff9sGaWOCRbSyR8yJsUC4+dNFtIL
         yYv6rEISd3QnsoBtHnUaT/Z1R2ftY2pPB5WUY6Y/ez5Dxlonzaziy/zWgyK1Xenvtpwk
         a71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPIFmqCq08/SpFCwk6A8CEBBfhPP5/Wk5un3Ts1xf9s=;
        b=S+mQXYNozXo5ZGPQSlu/8gNQbz1QrUv+gfe79aTXAEaqhScxR0XouTGuBn3plnG1mU
         Lm12zTsi5Yezm4BCdJBlQrUwGA/am6X5+tv6FrMPbNS/VxjSxzNtykf5dFXWgWslJUH/
         eOoXzh0hVBnLuKcKkps6cBJkMZ+OFxRB/DYh3iE/Yua0EC8B+rtT+eqf/2auk8hlKmwf
         RAIokWbT6MaLbf9n3Q0/2VrPSGlVdBKTWOUl+6+fLVVW+giWeAM6+EL4wMGwOKnasWey
         lkekb9mv2eEm9Xshi0X4IW54xf2szQhE2UzZA+hhTM1Ji3VqQsFwFPVmAdWA7OG6Qcy7
         TsbQ==
X-Gm-Message-State: AOAM531Dbl5is5D1G6warXR5YpBgu0A3MZTAsxiSZS4QemtvFIHNMffE
        XctYBvurBRwL0LboozSYjk8=
X-Google-Smtp-Source: ABdhPJwoCFy7Fg7AXQdm2sHljb364JgGjZxqDMO5nnl8BckmDA+So8WCDRoR5nCyZC6DzDAyDDrvcg==
X-Received: by 2002:a63:483:0:b0:3fc:9128:60a5 with SMTP id 125-20020a630483000000b003fc912860a5mr790658pge.606.1655144430244;
        Mon, 13 Jun 2022 11:20:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7958b000000b0051bdb735647sm5737882pfj.159.2022.06.13.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:20:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/adreno: Defer enabling runpm until hw_init()
Date:   Mon, 13 Jun 2022 11:20:30 -0700
Message-Id: <20220613182036.2567963-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

To avoid preventing the display from coming up before the rootfs is
mounted, without resorting to packing fw in the initrd, the GPU has
this limbo state where the device is probed, but we aren't ready to
start sending commands to it.  This is particularly problematic for
a6xx, since the GMU (which requires fw to be loaded) is the one that
is controlling the power/clk/icc votes.

So defer enabling runpm until we are ready to call gpu->hw_init(),
as that is a point where we know we have all the needed fw and are
ready to start sending commands to the coproc's.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 8706bcdd1472..7cef8ae73c71 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -415,6 +415,12 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
+	/*
+	 * Now that we have firmware loaded, and are ready to begin
+	 * booting the gpu, go ahead and enable runpm:
+	 */
+	pm_runtime_enable(&pdev->dev);
+
 	/* Make sure pm runtime is active and reset any previous errors */
 	pm_runtime_set_active(&pdev->dev);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 4e665c806a14..e1aef4875e2f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1042,7 +1042,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			gpu_name, &adreno_gpu_config);
-- 
2.36.1

