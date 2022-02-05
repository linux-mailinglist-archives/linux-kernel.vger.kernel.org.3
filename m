Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA24AA9A8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376505AbiBEP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234982AbiBEP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644074853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pjmtgD9hDbE2eSozwnUFT0OXCz+k5OPkUk+zbtWjpnw=;
        b=Fut880lldA8nIvwdwnavAjleVg93EO4TgwbNny/HAQ9M+INqhjwpx2hxLG77cS2lwcUb+v
        7S7yLTM7CB6Mxev3cUSMMDO4MoQQSSoW0GxTI3XRfaWQmdIl6SdKwK17hCe4R0E65mBNgn
        vQY+Ft0JVVIU80f1AL4x4+j2eg1BplI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-gpoQzHvRNb2dQ_i_u5BBSQ-1; Sat, 05 Feb 2022 10:27:32 -0500
X-MC-Unique: gpoQzHvRNb2dQ_i_u5BBSQ-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso8887123wma.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 07:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjmtgD9hDbE2eSozwnUFT0OXCz+k5OPkUk+zbtWjpnw=;
        b=QYEIuEcsfi93q1HahVi3gTsKOm+MmWBqUCjZiSTnGtwAtFVSDyO7paDYQdwh/KL5T/
         DG/G5D6aVvnKPgrvUCpznYfzhqPVrv3g/26fgB7+PcC2n0c/gIoLQVGPrEQUv2os+CI9
         DqqpNTUGj49dDAF5SNuRsndb9lw5VIvXk5qf+IlQgNoJRRg5UV9N8/dKy/3UlO1D3Wo6
         R4D4BVb1IQSdaMtNNvf+r2AG7NYxGbHUSdHswnK+AEBjE/qgGpAwNydSxt3/TlYLfe03
         mRCpNAp7i7Ca3/lMZIR0g8Zq7zScH+iO0OYWkaeTABBc09g4u+tQkaAk5ETU58Tyx4oI
         n3pw==
X-Gm-Message-State: AOAM531xDv6hmPhfD7mFEMr7ycMna69YT1Yt8p9lg0rwKj85PD4VfOPt
        r33QQoctNJpX1I5NVw6TEm3N2XTkarZgpvoeECaoxqfLfIk2J0bTyI6p3jlM8r2vGdVo/ibYydZ
        a+NukLnRRm35X/FFpMKFR0hbrJdwNmMVZh8mxZHavW/Xdvj/KugT30JumcdHmeQkbKtZ9guZdj5
        E=
X-Received: by 2002:a5d:5052:: with SMTP id h18mr3552915wrt.350.1644074851250;
        Sat, 05 Feb 2022 07:27:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDXyrn2KzxrERhgoIpos43hCirk58UMQ3nCsqWFJ5g7LBqTHNLGaT6w0HYpj+eI+7jWIu5gw==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr3552891wrt.350.1644074850965;
        Sat, 05 Feb 2022 07:27:30 -0800 (PST)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id j5sm4635019wrq.31.2022.02.05.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 07:27:30 -0800 (PST)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH] Revert "drm/nouveau/pmu/gm200-: avoid touching PMU outside of DEVINIT/PREOS/ACR"
Date:   Sat,  5 Feb 2022 16:27:28 +0100
Message-Id: <20220205152729.2609837-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1d2271d2fb85e54bfc9630a6c30ac0feb9ffb983.

This fix actually causes regressions, which I could verify on my systems
as well. So let's revert it and figure out a proper fix for the original
problem.

Cc: Ben Skeggs <bskeggs@redhat.com>
Bug: https://gitlab.freedesktop.org/drm/nouveau/-/issues/149
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/subdev/pmu/base.c    | 37 ++++++++-----------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
index 455e95a89259..24382875fb4f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
@@ -94,13 +94,20 @@ nvkm_pmu_fini(struct nvkm_subdev *subdev, bool suspend)
 	return 0;
 }
 
-static void
+static int
 nvkm_pmu_reset(struct nvkm_pmu *pmu)
 {
 	struct nvkm_device *device = pmu->subdev.device;
 
 	if (!pmu->func->enabled(pmu))
-		return;
+		return 0;
+
+	/* Inhibit interrupts, and wait for idle. */
+	nvkm_wr32(device, 0x10a014, 0x0000ffff);
+	nvkm_msec(device, 2000,
+		if (!nvkm_rd32(device, 0x10a04c))
+			break;
+	);
 
 	/* Reset. */
 	if (pmu->func->reset)
@@ -111,37 +118,25 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
 		if (!(nvkm_rd32(device, 0x10a10c) & 0x00000006))
 			break;
 	);
+
+	return 0;
 }
 
 static int
 nvkm_pmu_preinit(struct nvkm_subdev *subdev)
 {
 	struct nvkm_pmu *pmu = nvkm_pmu(subdev);
-	nvkm_pmu_reset(pmu);
-	return 0;
+	return nvkm_pmu_reset(pmu);
 }
 
 static int
 nvkm_pmu_init(struct nvkm_subdev *subdev)
 {
 	struct nvkm_pmu *pmu = nvkm_pmu(subdev);
-	struct nvkm_device *device = pmu->subdev.device;
-
-	if (!pmu->func->init)
-		return 0;
-
-	if (pmu->func->enabled(pmu)) {
-		/* Inhibit interrupts, and wait for idle. */
-		nvkm_wr32(device, 0x10a014, 0x0000ffff);
-		nvkm_msec(device, 2000,
-			if (!nvkm_rd32(device, 0x10a04c))
-				break;
-		);
-
-		nvkm_pmu_reset(pmu);
-	}
-
-	return pmu->func->init(pmu);
+	int ret = nvkm_pmu_reset(pmu);
+	if (ret == 0 && pmu->func->init)
+		ret = pmu->func->init(pmu);
+	return ret;
 }
 
 static void *
-- 
2.34.1

