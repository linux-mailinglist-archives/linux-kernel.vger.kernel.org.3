Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B75845C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiG1SWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiG1SW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:28 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E674DE0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:27 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzX26j2MzDrsv;
        Thu, 28 Jul 2022 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032547; bh=KxvoCK+77gkilpIyGMLDeI1tnqCfaC+2xs0CoAX0DNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+ZbGIIaaEs2IB114VFnSeu7cc9eBsmrgthyIzjrFX5xO1hZ/3aOUMGjza3+I1Fc6
         m+qRAM40Q7/BVek4wypIiUT4In18hQWbtH+oowbfS4dVtPk3wr6v8rAgASjpztCST1
         oLTv8FMJ1uLzDIYTg345MBA+7s1HshPvLiHlrdqQ=
X-Riseup-User-ID: 26566C790EE104442A012390CD0FCC02310DDFB0C32058388C28B4ADFA6B79E4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWy4qZ8z5vMX;
        Thu, 28 Jul 2022 18:22:22 +0000 (UTC)
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
Subject: [PATCH 07/16] drm/amd/display: Remove WritebackAllowFCLKChangeEndPosition VBA variable
Date:   Thu, 28 Jul 2022 15:20:39 -0300
Message-Id: <20220728182047.264825-8-mairacanal@riseup.net>
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

The WritebackAllowFCLKChangeEndPosition variable from the struct
vba_vars_st is only used on assignments, so its value is not used on
code. So, remove the WritebackAllowFCLKChangeEndPosition entry
from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 ----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h         | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e2e1d6e77902..756a55f69799 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1219,12 +1219,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->WritebackAllowDRAMClockChangeEndPosition[k] = dml_max(0,
 						v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
 								- v->Watermark.WritebackDRAMClockChangeWatermark);
-				v->WritebackAllowFCLKChangeEndPosition[k] = dml_max(0,
-						v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
-								- v->Watermark.WritebackFCLKChangeWatermark);
 			} else {
 				v->WritebackAllowDRAMClockChangeEndPosition[k] = 0;
-				v->WritebackAllowFCLKChangeEndPosition[k] = 0;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 76cba5d7ac10..518e599d74e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1303,7 +1303,6 @@ struct vba_vars_st {
 	bool OutputMultistreamEn[DC__NUM_DPP__MAX];
 	bool UsesMALLForStaticScreen[DC__NUM_DPP__MAX];
 	double MaxActiveDRAMClockChangeLatencySupported[DC__NUM_DPP__MAX];
-	double WritebackAllowFCLKChangeEndPosition[DC__NUM_DPP__MAX];
 	bool PTEBufferSizeNotExceededPerState[DC__NUM_DPP__MAX]; // new in DML32
 	bool DCCMetaBufferSizeNotExceededPerState[DC__NUM_DPP__MAX]; // new in DML32
 	bool NotEnoughDSCSlices[DC__VOLTAGE_STATES];
-- 
2.37.1

