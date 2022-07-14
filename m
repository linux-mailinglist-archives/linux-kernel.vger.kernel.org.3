Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491EE575356
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiGNQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiGNQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:48:06 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DF26E8AE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:46:01 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkL2f73xZz9svP;
        Thu, 14 Jul 2022 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817134; bh=oTt/xCCD/UUmSHwReWaxrUI1n297jYtleCZ9PTN2bMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oikR8EA/PoKgRr+eQggjmUFyAVPka3BT4fG06Rei9Sqi8g2JdsxmT1tXPLUaSS7kW
         se5emkQw1QzmgahtP+fX73LwM8uJAfV7bC1VAtmLEGKV0FaHwbXIzzLPuNTwE5tyJ2
         Z2waUMi0utT9UzX3ql1mJMZQkgw0dcoxkf4uzMjc=
X-Riseup-User-ID: 78BA2B3056E721CAACDA863D27ED1DF81F1CA3751B3B5D38A9AACD4C31E50681
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2X4Zf5z5vW1;
        Thu, 14 Jul 2022 16:45:24 +0000 (UTC)
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
Subject: [PATCH 02/12] drm/amd/display: Change get_pipe_idx function scope
Date:   Thu, 14 Jul 2022 13:44:57 -0300
Message-Id: <20220714164507.561751-2-mairacanal@riseup.net>
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

Turn previously global function into a static function as it is not used
outside the file.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 39f93072b5e0..c5a0a3649e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -251,7 +251,7 @@ unsigned int get_total_surface_size_in_mall_bytes(
 	return size;
 }
 
-unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx)
+static unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx)
 {
 	int pipe_idx = -1;
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 47b149d4bfcf..6e61b5382361 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -165,7 +165,6 @@ unsigned int get_total_surface_size_in_mall_bytes(
 		struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
 		unsigned int num_pipes);
-unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx);
 
 bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
-- 
2.36.1

