Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4A5845B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiG1SWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiG1SV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:21:57 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F574DE0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:21:51 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzWL4g4NzDryt;
        Thu, 28 Jul 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032510; bh=dOc0h9A9+TLSSc0lCI/yNseuodcICoVaSAtd2WgMo0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tO0UfFSsv6mnmmzOZaOJ6Dr/G614Ee99NzciEXbTQ9u8mp1/LKL1ccVDpPZP0nzTZ
         NLWbktGbSJkq7k9BBMs0vrJUw8fQptPWirTf0r8/UPptVKdG9cHLub55g2eu3NgaBz
         +VC24M3OkFakTqDHIyQjvbQBKOkSdodNI0Rr3/hk=
X-Riseup-User-ID: 4D0DE29A87800F0FBEFA4C6F967DE3A6FA7B671924CE920BA49D2ED64E91A686
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWF275dz5vMX;
        Thu, 28 Jul 2022 18:21:45 +0000 (UTC)
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
Subject: [PATCH 02/16] drm/amd/display: Remove CompBufReservedSpace* VBA variable
Date:   Thu, 28 Jul 2022 15:20:34 -0300
Message-Id: <20220728182047.264825-3-mairacanal@riseup.net>
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

The variables CompBufReservedSpaceZs, CompBufReservedSpace64B and
CompBufReservedSpaceNeedAdjustment from the struct vba_vars_st are
only used on assignments, so their values are not used on code. Moreover,
their getter functions are not used also. So, remove the variables
entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c        | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h        | 5 -----
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 573504de1789..a1fb2d1d1cdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -307,9 +307,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					 .dummy_boolean); /* bool *ViewportSizeSupport */
 	}
 
-	v->CompBufReservedSpaceZs     = v->CompBufReservedSpaceKBytes * 1024.0 / 256.0;
-	v->CompBufReservedSpace64B    = v->CompBufReservedSpaceKBytes * 1024.0 / 64.0;
-
 	// DCFCLK Deep Sleep
 	dml32_CalculateDCFCLKDeepSleep(
 			mode_lib->vba.NumberOfActiveSurfaces,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 5dc2f52165fb..d1c720b48b0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -122,8 +122,6 @@ dml_get_attr_func(fclk_watermark, mode_lib->vba.Watermark.FCLKChangeWatermark);
 dml_get_attr_func(usr_retraining_watermark, mode_lib->vba.Watermark.USRRetrainingWatermark);
 
 dml_get_attr_func(comp_buffer_reserved_space_kbytes, mode_lib->vba.CompBufReservedSpaceKBytes);
-dml_get_attr_func(comp_buffer_reserved_space_64bytes, mode_lib->vba.CompBufReservedSpace64B);
-dml_get_attr_func(comp_buffer_reserved_space_zs, mode_lib->vba.CompBufReservedSpaceZs);
 dml_get_attr_func(unbounded_request_enabled, mode_lib->vba.UnboundedRequestEnabled);
 
 #define dml_get_pipe_attr_func(attr, var)  double get_##attr(struct display_mode_lib *mode_lib, const display_e2e_pipe_params_st *pipes, unsigned int num_pipes, unsigned int which_pipe) \
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index cb125f7d0814..632041cf49bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -67,8 +67,6 @@ dml_get_attr_decl(min_meta_chunk_size_in_byte);
 dml_get_attr_decl(fclk_watermark);
 dml_get_attr_decl(usr_retraining_watermark);
 dml_get_attr_decl(comp_buffer_reserved_space_kbytes);
-dml_get_attr_decl(comp_buffer_reserved_space_64bytes);
-dml_get_attr_decl(comp_buffer_reserved_space_zs);
 dml_get_attr_decl(unbounded_request_enabled);
 
 #define dml_get_pipe_attr_decl(attr) double get_##attr(struct display_mode_lib *mode_lib, const display_e2e_pipe_params_st *pipes, unsigned int num_pipes, unsigned int which_pipe)
@@ -655,9 +653,6 @@ struct vba_vars_st {
 	Watermarks      Watermark;
 	bool DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE;
 	unsigned int CompBufReservedSpaceKBytes;
-	unsigned int CompBufReservedSpace64B;
-	unsigned int CompBufReservedSpaceZs;
-	bool CompBufReservedSpaceNeedAdjustment;
 
 	// These are the clocks calcuated by the library but they are not actually
 	// used explicitly. They are fetched by tests and then possibly used. The
-- 
2.37.1

