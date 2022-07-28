Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EED5845C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiG1SWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiG1SWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:23 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510395B048
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:22 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzWx4QwyzDs0B;
        Thu, 28 Jul 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032541; bh=5hukvlPt2ChjYzre5ze2WfJX5Xbvr7tV7otABd84zlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyodr8kwFkVVg90zz5nWUUCKq3zyQVKKQS62RHEFJJ/G+kwNkUL2Igcnsd/T7A+4f
         ICCEdXQvl3Kja9HTkEdI/Gu01/UytBOGlT9/eXaKWYjAkDbat1UYbBZX2XjM4pluYr
         2cIIBMVNHWd0FhKsr0caUCQn5ECWn3kHiPZyChTY=
X-Riseup-User-ID: 66D1C708B57EE5B17385B395AC67F948C1042C7E83AEF2D42C307DA3DCAC86FD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWs0QJrz5vMX;
        Thu, 28 Jul 2022 18:22:16 +0000 (UTC)
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
Subject: [PATCH 06/16] drm/amd/display: Remove ImmediateFlipSupportedSurface VBA variable
Date:   Thu, 28 Jul 2022 15:20:38 -0300
Message-Id: <20220728182047.264825-7-mairacanal@riseup.net>
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

The ImmediateFlipSupportedSurface variable from the struct
vba_vars_st is only used on assignments, so its value is not used
on code. So, remove the ImmediateFlipSupportedSurface entry from the struct
vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 6 ------
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h       | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f199ef475ed0..e2e1d6e77902 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -355,12 +355,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			if (j != k && mode_lib->vba.BlendingAndTiming[k] == j && mode_lib->vba.DSCEnabled[j])
 				v->DSCDelay[k] = v->DSCDelay[j];
 
-	//Immediate Flip
-	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-		v->ImmediateFlipSupportedSurface[k] = mode_lib->vba.ImmediateFlipSupport
-				&& (mode_lib->vba.ImmediateFlipRequirement[k] != dm_immediate_flip_not_required);
-	}
-
 	// Prefetch
 	dml32_CalculateSurfaceSizeInMall(
 				mode_lib->vba.NumberOfActiveSurfaces,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 841a05bea57e..76cba5d7ac10 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -659,8 +659,6 @@ struct vba_vars_st {
 	double DISPCLK_calculated;
 	double DPPCLK_calculated[DC__NUM_DPP__MAX];
 
-	bool ImmediateFlipSupportedSurface[DC__NUM_DPP__MAX];
-
 	bool Use_One_Row_For_Frame[DC__NUM_DPP__MAX];
 	bool Use_One_Row_For_Frame_Flip[DC__NUM_DPP__MAX];
 	unsigned int VUpdateOffsetPix[DC__NUM_DPP__MAX];
-- 
2.37.1

