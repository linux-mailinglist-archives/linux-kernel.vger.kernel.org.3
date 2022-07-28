Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B95845C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiG1SXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiG1SWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:44 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7A7539C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:41 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzXK01DLzDs0B;
        Thu, 28 Jul 2022 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032561; bh=FyrTULDUjyHGwlKFXrAzhhgN/h2/e4OL5Wz+Mjczc+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dK75nsGugzCU2x/Joq/noP+7wj8EMcO0ZNrMppP6awgvGflvDbvdaX7wbcTsZvyrO
         +I2A4aJR0bt+R9AdURU/SzjpRCOaV1tCS/XU3h4Q7ljvQJTxaVcj+fGYlcWM8mt+7J
         0JJWbRPBmOnij9ZcHHx/j36GfYmldOKoK0ik8zqM=
X-Riseup-User-ID: DB8DA08FA5CFC323C5D417C811618355A6AA7C67129E314DB8EC4AB602387803
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXC3M2Hz5vMX;
        Thu, 28 Jul 2022 18:22:35 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 09/16] drm/amd/display: Remove SwathWidthCSingleDPP VBA variable
Date:   Thu, 28 Jul 2022 15:20:41 -0300
Message-Id: <20220728182047.264825-10-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SwathWidthCSingleDPP variable from the struct vba_vars_st is only
used on assignments, so its value is not used on code. So, remove the
SwathWidthCSingleDPP entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 --
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 --
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index caa3a9c598ce..4fac83c776ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3660,10 +3660,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index eca05bbc0fb5..9ea2d2fd56f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3965,10 +3965,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index acb47cdaaa05..ae749d39db2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4077,10 +4077,8 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 756a55f69799..a88cfce3b771 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1721,10 +1721,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 		if (!IsVertical(mode_lib->vba.SourceRotation[k])) {
 			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 91562c0d35f2..ac8131b52b78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -939,7 +939,6 @@ struct vba_vars_st {
 
 
 	bool           MPCCombine[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-	double         SwathWidthCSingleDPP[DC__NUM_DPP__MAX];
 	double         MaximumSwathWidthInLineBufferLuma;
 	double         MaximumSwathWidthInLineBufferChroma;
 	double         MaximumSwathWidthLuma[DC__NUM_DPP__MAX];
-- 
2.37.1

