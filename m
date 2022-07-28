Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5035845AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiG1SVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiG1SVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:21:44 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE95A8B3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:21:44 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LtzWC2zrqz9spX;
        Thu, 28 Jul 2022 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032503; bh=jaNzaNvCEhS2AXkA7K80CoMdT/QIxgViEtzB1k8nm5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+4XtFahyDtTKE3LGYXkAiHihWm/wNd22PbpsULP1ZyPzLnxUdKy7CeX6r9JDkKeE
         n+FD6m2ca5/z1y01UA71w0bZKTDAKe5WKygOQ8XtR1L+/GCfMxUuFjCQeLghKJvI05
         zGYgXbEkCNhUQflwg5/eqH14ObCKotV2BCmJBtLQ=
X-Riseup-User-ID: 7085B217FDD4BF70B4736E5A2DFB7BA16FA17F0EC436EF3BDB26F2BC14E00E67
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzW61d0Hz5vMX;
        Thu, 28 Jul 2022 18:21:37 +0000 (UTC)
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
Subject: [PATCH 01/16] drm/amd/display: Remove NonUrgentLatencyTolerance VBA variable
Date:   Thu, 28 Jul 2022 15:20:33 -0300
Message-Id: <20220728182047.264825-2-mairacanal@riseup.net>
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

The NonUrgentLatencyTolerance variable from the struct vba_vars_st is
only used on assignments, so its value is not used on code. Moreover,
its getter function is not used also. So, remove the
NonUrgentLatencyTolerance entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c    | 4 ----
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 4 ----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c         | 1 -
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h         | 2 --
 4 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d3b5b6fedf04..8a499f8066b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -1768,10 +1768,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 				mode_lib->vba.UrgentLatencySupportUs[k]);
 	}
 
-	// Non-Urgent Latency Tolerance
-	mode_lib->vba.NonUrgentLatencyTolerance = mode_lib->vba.MinUrgentLatencySupportUs
-			- mode_lib->vba.UrgentWatermark;
-
 	// DSCCLK
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 		if ((mode_lib->vba.BlendingAndTiming[k] != k) || !mode_lib->vba.DSCEnabled[k]) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 63bbdf8b8678..ef7f0b8ed2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -1804,10 +1804,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 				mode_lib->vba.UrgentLatencySupportUs[k]);
 	}
 
-	// Non-Urgent Latency Tolerance
-	mode_lib->vba.NonUrgentLatencyTolerance = mode_lib->vba.MinUrgentLatencySupportUs
-			- mode_lib->vba.UrgentWatermark;
-
 	// DSCCLK
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 		if ((mode_lib->vba.BlendingAndTiming[k] != k) || !mode_lib->vba.DSCEnabled[k]) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 503e7d984ff0..5dc2f52165fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -102,7 +102,6 @@ dml_get_attr_func(stutter_efficiency_no_vblank, mode_lib->vba.StutterEfficiencyN
 dml_get_attr_func(stutter_period, mode_lib->vba.StutterPeriod);
 dml_get_attr_func(urgent_latency, mode_lib->vba.UrgentLatency);
 dml_get_attr_func(urgent_extra_latency, mode_lib->vba.UrgentExtraLatency);
-dml_get_attr_func(nonurgent_latency, mode_lib->vba.NonUrgentLatencyTolerance);
 dml_get_attr_func(dram_clock_change_latency, mode_lib->vba.MinActiveDRAMClockChangeLatencySupported);
 dml_get_attr_func(dispclk_calculated, mode_lib->vba.DISPCLK_calculated);
 dml_get_attr_func(total_data_read_bw, mode_lib->vba.TotalDataReadBandwidth);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 8460aefe7b6d..cb125f7d0814 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -50,7 +50,6 @@ dml_get_attr_decl(stutter_efficiency);
 dml_get_attr_decl(stutter_period);
 dml_get_attr_decl(urgent_latency);
 dml_get_attr_decl(urgent_extra_latency);
-dml_get_attr_decl(nonurgent_latency);
 dml_get_attr_decl(dram_clock_change_latency);
 dml_get_attr_decl(dispclk_calculated);
 dml_get_attr_decl(total_data_read_bw);
@@ -648,7 +647,6 @@ struct vba_vars_st {
 	double WritebackDRAMClockChangeWatermark;
 	double StutterEfficiency;
 	double StutterEfficiencyNotIncludingVBlank;
-	double NonUrgentLatencyTolerance;
 	double MinActiveDRAMClockChangeLatencySupported;
 	double Z8StutterEfficiencyBestCase;
 	unsigned int Z8NumberOfStutterBurstsPerFrameBestCase;
-- 
2.37.1

