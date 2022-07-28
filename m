Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8A5845C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiG1SWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiG1SWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:21 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815B74E2E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:15 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzWp4Lt5zDrtL;
        Thu, 28 Jul 2022 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032534; bh=x7PWrdruU1/D/epM3C5CS/K+6fjcV1ng9alJKcLjSSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jw7yolenTr8yJvAjVDxS4c4msVW3Mcp9Lx0ohkod/NxehWmkbiYXyKiI5gymD6OEb
         eGUhd+8CHTzemwRpQLzhLWuNpYfFXxqQHs7jDDoUfoX/mlSVxQHbTPe4o68mSwQpeA
         HN7yZIrY8SjEnmw9+KSH+FLWKLlO9yPqtVoLfN0s=
X-Riseup-User-ID: 5B549052130933BFDB8282CA5799D6AD0E04851D2EE03AEB5CEAC24D3FD3FC4C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWj6bfWz5vMX;
        Thu, 28 Jul 2022 18:22:09 +0000 (UTC)
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
Subject: [PATCH 05/16] drm/amd/display: Remove VStartupMargin and FirstMainPlane VBA variables
Date:   Thu, 28 Jul 2022 15:20:37 -0300
Message-Id: <20220728182047.264825-6-mairacanal@riseup.net>
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

The variables VStartupMargin and FirstMainPlane from the struct
vba_vars_st are only used on assignments, so there values are not used
on code. So, remove the variables entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../display/dc/dml/dcn20/display_mode_vba_20.c  | 14 +++-----------
 .../dc/dml/dcn20/display_mode_vba_20v2.c        | 14 +++-----------
 .../display/dc/dml/dcn30/display_mode_vba_30.c  | 17 ++++++-----------
 .../drm/amd/display/dc/dml/display_mode_vba.h   |  2 --
 4 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d86d5c346e42..1424aa7a5018 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2662,19 +2662,12 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		}
 	}
 	{
-		unsigned int VStartupMargin = 0;
 		bool FirstMainPlane = true;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.BlendingAndTiming[k] == k) {
-				unsigned int Margin = (mode_lib->vba.MaxVStartupLines[k] - mode_lib->vba.VStartup[k])
-						* mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k];
-
-				if (FirstMainPlane) {
-					VStartupMargin = Margin;
-					FirstMainPlane = false;
-				} else
-					VStartupMargin = dml_min(VStartupMargin, Margin);
+			if (mode_lib->vba.BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
+			}
 		}
 
 		if (mode_lib->vba.UseMaximumVStartup) {
@@ -2685,7 +2678,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		}
 	}
 }
-}
 
 static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index effd02574a0e..03613dbb3e61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2735,19 +2735,12 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		}
 	}
 	{
-		unsigned int VStartupMargin = 0;
 		bool FirstMainPlane = true;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.BlendingAndTiming[k] == k) {
-				unsigned int Margin = (mode_lib->vba.MaxVStartupLines[k] - mode_lib->vba.VStartup[k])
-						* mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k];
-
-				if (FirstMainPlane) {
-					VStartupMargin = Margin;
-					FirstMainPlane = false;
-				} else
-					VStartupMargin = dml_min(VStartupMargin, Margin);
+			if (mode_lib->vba.BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
+			}
 		}
 
 		if (mode_lib->vba.UseMaximumVStartup) {
@@ -2758,7 +2751,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		}
 	}
 }
-}
 
 static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index fe7fcb0d7b1f..caa3a9c598ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3028,17 +3028,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	}
 
 	// VStartup Margin
-	v->VStartupMargin = 0;
-	v->FirstMainPlane = true;
-	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-		if (v->BlendingAndTiming[k] == k) {
-			double margin = (v->MaxVStartupLines[k] - v->VStartup[k]) * v->HTotal[k]
-					/ v->PixelClock[k];
-			if (v->FirstMainPlane == true) {
-				v->VStartupMargin = margin;
-				v->FirstMainPlane = false;
-			} else {
-				v->VStartupMargin = dml_min(v->VStartupMargin, margin);
+	{
+		bool FirstMainPlane = true;
+
+		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+			if (v->BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index f03cf9cf9096..841a05bea57e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1106,7 +1106,6 @@ struct vba_vars_st {
 	double TimePerChromaMetaChunkFlip[DC__NUM_DPP__MAX];
 	unsigned int DCCCMaxUncompressedBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCCMaxCompressedBlock[DC__NUM_DPP__MAX];
-	double VStartupMargin;
 	bool NotEnoughTimeForDynamicMetadata[DC__NUM_DPP__MAX];
 
 	/* Missing from VBA */
@@ -1137,7 +1136,6 @@ struct vba_vars_st {
 	double MinUrgentLatencySupportUs;
 	double MinFullDETBufferingTime;
 	double AverageReadBandwidthGBytePerSecond;
-	bool   FirstMainPlane;
 
 	unsigned int ViewportWidthChroma[DC__NUM_DPP__MAX];
 	unsigned int ViewportHeightChroma[DC__NUM_DPP__MAX];
-- 
2.37.1

