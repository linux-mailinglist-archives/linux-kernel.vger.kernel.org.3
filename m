Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E760D5175A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386648AbiEBRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386621AbiEBRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:16 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 10:17:46 PDT
Received: from forward107p.mail.yandex.net (forward107p.mail.yandex.net [77.88.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20288AE7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:17:46 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward107p.mail.yandex.net (Yandex) with ESMTP id 6AA90556E59B;
        Mon,  2 May 2022 20:10:59 +0300 (MSK)
Received: from vla1-166bfab327a3.qloud-c.yandex.net (vla1-166bfab327a3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3007:0:640:166b:fab3])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 6613D13E80002;
        Mon,  2 May 2022 20:10:59 +0300 (MSK)
Received: from vla3-3dd1bd6927b2.qloud-c.yandex.net (vla3-3dd1bd6927b2.qloud-c.yandex.net [2a02:6b8:c15:350f:0:640:3dd1:bd69])
        by vla1-166bfab327a3.qloud-c.yandex.net (mxback/Yandex) with ESMTP id TVcvmXr5ZA-AxgKLj8a;
        Mon, 02 May 2022 20:10:59 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lach.pw; s=mail; t=1651511459;
        bh=Agoq4DRar/aNcme/ep3h/Ph9puEsY2Ulitbie9lM8hE=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=hp1HvciOXsQY1mQw5MW7itL9JqwMvVo0pNZPz/tzCcJaHaD0DXBXN6Qbo8Bv/+Wti
         CWxJig41NJgQCkv5/S1e0xX00OKSZQ9TfQKyxE61LdlECV+X+QJr5J8cWkAiKqKpnw
         HV2w/MDwpnH/k5SiMrAJMbSyIhd7HJuqBD7jaass=
Authentication-Results: vla1-166bfab327a3.qloud-c.yandex.net; dkim=pass header.i=@lach.pw
Received: by vla3-3dd1bd6927b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id xTgxo8AHyR-AuMSB13b;
        Mon, 02 May 2022 20:10:58 +0300
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
Subject: [RESEND PATCH v2 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
Date:   Mon,  2 May 2022 20:10:31 +0300
Message-Id: <20220502171031.11797-2-iam@lach.pw>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502171031.11797-1-iam@lach.pw>
References: <20220220151940.58327-1-iam@lach.pw>
 <20220502171031.11797-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index f5f39984702f..5565d55f56f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -119,6 +119,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	edid_caps->dsc_fixed_bits_per_pixel_x16 = connector->display_info.dp_dsc_bpp;
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index c4e871f358ab..65c90e432a39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -105,6 +105,8 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* EDID CAP translation for HDMI 2.0 */
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE = dc_sink_data->edid_caps.lte_340mcsc_scramble;
+	stream->timing.dsc_fixed_bits_per_pixel_x16 =
+		dc_sink_data->edid_caps.dsc_fixed_bits_per_pixel_x16;
 
 	memset(&stream->timing.dsc_cfg, 0, sizeof(stream->timing.dsc_cfg));
 	stream->timing.dsc_cfg.num_slices_h = 0;
@@ -773,4 +775,3 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 		}
 	}
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2ba9f528c0fe..e53c414b6c93 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -228,6 +228,9 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 
+	/* DisplayPort caps */
+	uint32_t dsc_fixed_bits_per_pixel_x16;
+
 	struct dc_panel_patch panel_patch;
 };
 
-- 
2.35.1

