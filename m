Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213034BCF5A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiBTPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:20:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiBTPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:20:19 -0500
Received: from forward107p.mail.yandex.net (forward107p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514BA49FB5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:19:58 -0800 (PST)
Received: from myt5-f0e8352497c8.qloud-c.yandex.net (myt5-f0e8352497c8.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3c22:0:640:f0e8:3524])
        by forward107p.mail.yandex.net (Yandex) with ESMTP id 207A5556CE46;
        Sun, 20 Feb 2022 18:19:56 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by myt5-f0e8352497c8.qloud-c.yandex.net (mxback/Yandex) with ESMTP id D6W9P1iVZ4-Jtdmn38c;
        Sun, 20 Feb 2022 18:19:56 +0300
X-Yandex-Fwd: 2
Authentication-Results: myt5-f0e8352497c8.qloud-c.yandex.net; dkim=pass
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id M6K5BEkQDc-JqH8q7d8;
        Sun, 20 Feb 2022 18:19:54 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Yaroslav Bolyukin <iam@lach.pw>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        "Lin, Wayne" <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v2 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
Date:   Sun, 20 Feb 2022 18:19:40 +0300
Message-Id: <20220220151940.58327-2-iam@lach.pw>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220151940.58327-1-iam@lach.pw>
References: <20220213133128.5833-1-iam@lach.pw>
 <20220220151940.58327-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VESA vendor header from DisplayID spec may contain fixed bit per pixel
rate, it should be respected by drm driver

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 29f07c26d..b34dd89ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -118,6 +118,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	edid_caps->dsc_fixed_bits_per_pixel_x16 = connector->display_info.dp_dsc_bpp;
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 57cf4cb82..f8516ec70 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -105,6 +105,8 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* EDID CAP translation for HDMI 2.0 */
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE = dc_sink_data->edid_caps.lte_340mcsc_scramble;
+	stream->timing.dsc_fixed_bits_per_pixel_x16 =
+		dc_sink_data->edid_caps.dsc_fixed_bits_per_pixel_x16;
 
 	memset(&stream->timing.dsc_cfg, 0, sizeof(stream->timing.dsc_cfg));
 	stream->timing.dsc_cfg.num_slices_h = 0;
@@ -738,4 +740,3 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			"\tlink: %d\n",
 			stream->link->link_index);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0285a4b38..ce2e11d70 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -227,6 +227,9 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 
+	/* DisplayPort caps */
+	uint32_t dsc_fixed_bits_per_pixel_x16;
+
 	struct dc_panel_patch panel_patch;
 };
 
-- 
2.35.1

