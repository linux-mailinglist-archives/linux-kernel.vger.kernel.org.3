Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFE57535F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiGNQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbiGNQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:49:18 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA07098A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:46:39 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkL3q0V6Yz9snB;
        Thu, 14 Jul 2022 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817191; bh=XV9tkKItKKrKdxeOCrOFU/aMW2lffXNMCCQLXD35gdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbfidNUvZjLDgWLPCM0leY/i4NLdBJrPJoPqoddJhnntfTDYAGYWCIkJ8OifHGSx5
         Y07G8uogypDYBwjUHE1X1YNJ/Hq6yNHD1+kNuEgcMGDJMC3iLr8Kii+3MHyaT1uY4w
         Vj0tdSehypuqwjzdHREubfLkstDtZTnsNZ1ntgKE=
X-Riseup-User-ID: 4406E95CF501A8ACD5FACC26F496C7F7E4FA70E08EF19107281E6C1AE30978AD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL3j1v9fz5vW1;
        Thu, 14 Jul 2022 16:46:24 +0000 (UTC)
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
Subject: [PATCH 09/12] drm/amd/display: Remove unused MaxUsedBW variable
Date:   Thu, 14 Jul 2022 13:45:04 -0300
Message-Id: <20220714164507.561751-9-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the variable MaxUsedBW from the function
DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.
As a side-effect, the variables MaxPerPlaneVActiveWRBandwidth and
WRBandwidth are also removed.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3043:10:
warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
                double MaxUsedBW = 0;
                       ^
1 warning generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn30/display_mode_vba_30.c        | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 842eb94ebe04..876b321b30ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3037,40 +3037,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 	{
 		//Maximum Bandwidth Used
-		double TotalWRBandwidth = 0;
-		double MaxPerPlaneVActiveWRBandwidth = 0;
-		double WRBandwidth = 0;
-		double MaxUsedBW = 0;
-		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-			if (v->WritebackEnable[k] == true
-					&& v->WritebackPixelFormat[k] == dm_444_32) {
-				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
-						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 4;
-			} else if (v->WritebackEnable[k] == true) {
-				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
-						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 8;
-			}
-			TotalWRBandwidth = TotalWRBandwidth + WRBandwidth;
-			MaxPerPlaneVActiveWRBandwidth = dml_max(MaxPerPlaneVActiveWRBandwidth, WRBandwidth);
-		}
-
 		v->TotalDataReadBandwidth = 0;
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 			v->TotalDataReadBandwidth = v->TotalDataReadBandwidth
 					+ v->ReadBandwidthPlaneLuma[k]
 					+ v->ReadBandwidthPlaneChroma[k];
 		}
-
-		{
-			double MaxPerPlaneVActiveRDBandwidth = 0;
-			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-				MaxPerPlaneVActiveRDBandwidth = dml_max(MaxPerPlaneVActiveRDBandwidth,
-						v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
-
-			}
-		}
-
-		MaxUsedBW = MaxTotalRDBandwidth + TotalWRBandwidth;
 	}
 
 	// VStartup Margin
-- 
2.36.1

