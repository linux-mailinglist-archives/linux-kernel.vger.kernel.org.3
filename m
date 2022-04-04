Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57B4F2050
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiDDXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiDDXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:35:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B952E76
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:33:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so14951263ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYcF2JgiKO3iyobrkCuRU5Bwnqu8GY+UYkhCntyAAkw=;
        b=W1gAsjOXHXd5TL2PafVBKwCAzkY5HfXPciUHtw1CalSECJqoaulG5OpfGOFU6p8NDy
         WyRAfCqNTNvossP5rgO2UsgamRarvNLZT5iTzFh+Yk2lgq+pO3AWFoogPTY0QXJIZht+
         nWcPj56EJ/8wIcZhixgkbOh2IcPoFJDoyROWr67l5a2t1Wmqwsu4xiUbmzNr6v9k7Q1K
         jiL6q6HTyO+QfkeKgAUnGrUtID/t7HGLmaKMegtkckswGfLDe7qTLDDffudxsi6Y+sjD
         Ik3iqZXbJAAS8DSuF1v31KJmP2FzQiUS+ZJN/Otf7Tk68v0BMaGss7YgRr4x/dLdXa6p
         5cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYcF2JgiKO3iyobrkCuRU5Bwnqu8GY+UYkhCntyAAkw=;
        b=jDFF12RFgUOWTvg2SCDtinvI0ISMJ6h+E8e8zLxF+FCYu+QfHtQ5BPF/4qc5GbY014
         C0LfGaTTvJYIvJQ50XcK/KWJUPrVa+Ol0zrvD+KMwc8lqEYjpa2BmerOk8bXg29tXl9S
         kUdViMmJAllknRs3novncoIIRfo8kSYDiO8QP6IpGfMZGaA1QSyAtaqr9aQpHNCS9rlF
         FQbm3AdgcRZuEz+fEjZvyfz9GlXV/isNW4eTe6OPL3pWI5sWFmZqknxazCE/ApyjLNsa
         ImG6w31hM0kA1Nze9WEqkAt1PDh4k/MBYaxJeXFMZ5zq2PWOnuka4tQjpMY/LDx9j/YU
         Hieg==
X-Gm-Message-State: AOAM532DnW+foOnvMzUqZCPLtNGS89C+aV9ywyHPhOiqYeyfpPd7ynej
        2owqlK+U+LuPT2Qz8+OhcY8=
X-Google-Smtp-Source: ABdhPJwRP8euVP8PJVykYTC47Km7db9gS6a+mK1PxM84xFd0Qefdqyn7QAmC+Mm+J/tUMjvzOrUWvg==
X-Received: by 2002:a2e:9d91:0:b0:24b:a3:d784 with SMTP id c17-20020a2e9d91000000b0024b00a3d784mr292752ljj.461.1649115185641;
        Mon, 04 Apr 2022 16:33:05 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:1093:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id e11-20020a2e984b000000b00249b8b68f61sm1196639ljj.74.2022.04.04.16.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:33:05 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Claudio Suarez <cssk@net-c.es>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Junk code
Date:   Tue,  5 Apr 2022 02:33:04 +0300
Message-Id: <20220404233306.2207-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable igp_lane_info always is 0. 0 & any value = 0 and false.
In this way, all сonditional statements will false.
Therefore, it is not clear what this code does.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 2b0cc793291c..100bad2f5901 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -769,7 +769,6 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder *encoder, int a
 	int dp_clock = 0;
 	int dp_lane_count = 0;
 	int connector_object_id = 0;
-	int igp_lane_info = 0;
 	int dig_encoder = dig->dig_encoder;
 	int hpd_id = AMDGPU_HPD_NONE;
 
@@ -852,26 +851,6 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder *encoder, int a
 			else
 				args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_DIG1_ENCODER;
 
-			if ((adev->flags & AMD_IS_APU) &&
-			    (amdgpu_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_UNIPHY)) {
-				if (is_dp ||
-				    !amdgpu_dig_monitor_is_duallink(encoder, amdgpu_encoder->pixel_clock)) {
-					if (igp_lane_info & 0x1)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_0_3;
-					else if (igp_lane_info & 0x2)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_4_7;
-					else if (igp_lane_info & 0x4)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_8_11;
-					else if (igp_lane_info & 0x8)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_12_15;
-				} else {
-					if (igp_lane_info & 0x3)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_0_7;
-					else if (igp_lane_info & 0xc)
-						args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LANE_8_15;
-				}
-			}
-
 			if (dig->linkb)
 				args.v1.ucConfig |= ATOM_TRANSMITTER_CONFIG_LINKB;
 			else
-- 
2.35.1

