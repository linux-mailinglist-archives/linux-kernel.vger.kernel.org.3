Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9257D36C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiGUShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiGUShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:37:09 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B2A89E8E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:37:08 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LphBC6XMrzDrgP;
        Thu, 21 Jul 2022 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658428628; bh=6UX1cdxV18xZgxAV2zIloALkEk5djV/Evfjd1FGKHOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEdPKM/B/Z9l5ZMADx1QUNZ8HFlqLI0I7cvkuvOgZfQCCGY2j+jEsYzquNnn8/xxh
         /Bnhlckc2TriTfq8pHSahkSlPJeyycLTijX6me4TjC7QhBltmwIlYLfrjYEYUF7yTP
         ScgxRlBSMj5zOLXS//J1sSIzlxl5qh+RyaY7facw=
X-Riseup-User-ID: DE10C7C9C92513AB932D80E6BB0A32FAFD3C8971CEF918592F1E62B0FADEAA24
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LphB64jgFz1xph;
        Thu, 21 Jul 2022 18:37:02 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v2 2/4] drm/amd/display: Remove duplicated CalculateWriteBackDISPCLK
Date:   Thu, 21 Jul 2022 15:36:31 -0300
Message-Id: <20220721183633.1004611-2-mairacanal@riseup.net>
In-Reply-To: <20220721183633.1004611-1-mairacanal@riseup.net>
References: <20220721183633.1004611-1-mairacanal@riseup.net>
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

The functions dml30_CalculateWriteBackDISPCLK and
dml31_CalculateWriteBackDISPCLK are identical. Therefor, to avoid code
duplication, replace dml31_CalculateWriteBackDISPCLK by
dml30_CalculateWriteBackDISPCLK

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
v1 -> v2:
- Describe changes in imperative mood (André Almeida).
---
 .../dc/dml/dcn31/display_mode_vba_31.c        | 24 ++-----------------
 .../dc/dml/dcn31/display_mode_vba_31.h        | 11 ---------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 3fab19134480..3bc529f0b0fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -2085,7 +2085,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->WritebackEnable[k]) {
 			v->WritebackDISPCLK = dml_max(
 					v->WritebackDISPCLK,
-					dml31_CalculateWriteBackDISPCLK(
+					dml30_CalculateWriteBackDISPCLK(
 							v->WritebackPixelFormat[k],
 							v->PixelClock[k],
 							v->WritebackHRatio[k],
@@ -3470,26 +3470,6 @@ static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLa
 	}
 }
 
-double dml31_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
-		double PixelClock,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackHTaps,
-		unsigned int WritebackVTaps,
-		long WritebackSourceWidth,
-		long WritebackDestinationWidth,
-		unsigned int HTotal,
-		unsigned int WritebackLineBufferSize)
-{
-	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
-
-	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
-	DISPCLK_V = PixelClock * (WritebackVTaps * dml_ceil(WritebackDestinationWidth / 6.0, 1) + 8.0) / HTotal;
-	DISPCLK_HB = PixelClock * WritebackVTaps * (WritebackDestinationWidth * WritebackVTaps - WritebackLineBufferSize / 57.0) / 6.0 / WritebackSourceWidth;
-	return dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
-}
-
 static double CalculateWriteBackDelay(
 		enum source_format_class WritebackPixelFormat,
 		double WritebackHRatio,
@@ -4055,7 +4035,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (v->WritebackEnable[k] == true) {
 			v->WritebackRequiredDISPCLK = dml_max(
 					v->WritebackRequiredDISPCLK,
-					dml31_CalculateWriteBackDISPCLK(
+					dml30_CalculateWriteBackDISPCLK(
 							v->WritebackPixelFormat[k],
 							v->PixelClock[k],
 							v->WritebackHRatio[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
index 90be612f26b2..654362adcaa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
@@ -28,16 +28,5 @@
 
 void dml31_recalculate(struct display_mode_lib *mode_lib);
 void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib);
-double dml31_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
-		double PixelClock,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackHTaps,
-		unsigned int WritebackVTaps,
-		long   WritebackSourceWidth,
-		long   WritebackDestinationWidth,
-		unsigned int HTotal,
-		unsigned int WritebackLineBufferSize);
 
 #endif /* __DML31_DISPLAY_MODE_VBA_H__ */
-- 
2.36.1

