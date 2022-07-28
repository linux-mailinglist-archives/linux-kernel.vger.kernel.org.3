Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3335845C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiG1SXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1SWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:50 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E270E41
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:49 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LtzXS2Sz4z9sQc;
        Thu, 28 Jul 2022 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032568; bh=st9aPCSjCcU8sGTEUIKVJxFHPtEfVhpUBemleBVYzmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7+i974rqBt7BvjPNhqVkHS7tFjI2yJNb5P8chFCMxnaVCEPyVEgYUMLOTDpbrNct
         dsk3lwMqssdX9HWY+1ha2E3/gBlYM2MX9A94rJ9pGiQFg+t9DdLS0627nVjjD0KNRH
         BPi1555a9Q91eRkn4RcJUucG3xFHkelfxCj1Fzck=
X-Riseup-User-ID: 8AC2F3FC37DEDA158C3EB2EC2EDBF02A2D401933EFE23FD8C4A047370E2472FD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXL5N43z5vMX;
        Thu, 28 Jul 2022 18:22:42 +0000 (UTC)
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
Subject: [PATCH 10/16] drm/amd/display: Remove ModeIsSupported VBA variable
Date:   Thu, 28 Jul 2022 15:20:42 -0300
Message-Id: <20220728182047.264825-11-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ModeIsSupported variable from the struct vba_vars_st is only used on
assignments, so its value is not used on code. So, remove the
ModeIsSupported entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 1 -
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 4fac83c776ad..b776a7940fac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5250,7 +5250,6 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][1] == true) {
 					MaximumMPCCombine = 1;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 9ea2d2fd56f1..b338e72d96d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5521,7 +5521,6 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index ae749d39db2a..6c60731687bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5636,7 +5636,6 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index a88cfce3b771..5fce4bbb4e85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3668,8 +3668,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (i == v->soc.num_states || mode_lib->vba.ModeSupport[i][0] == true ||
 				mode_lib->vba.ModeSupport[i][1] == true) {
 			mode_lib->vba.VoltageLevel = i;
-			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
-					|| mode_lib->vba.ModeSupport[i][1] == true;
 
 			if (mode_lib->vba.ModeSupport[i][0] == true) {
 				MaximumMPCCombine = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index ac8131b52b78..f4d4bf7b6111 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1132,7 +1132,6 @@ struct vba_vars_st {
 	double VRatioChroma[DC__NUM_DPP__MAX];
 	int WritebackSourceWidth[DC__NUM_DPP__MAX];
 
-	bool ModeIsSupported;
 	bool ODMCombine4To1Supported;
 
 	unsigned int SurfaceWidthY[DC__NUM_DPP__MAX];
-- 
2.37.1

