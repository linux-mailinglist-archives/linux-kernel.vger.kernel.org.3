Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA6562252
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiF3Sug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiF3Sue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:50:34 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE462DA9E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:50:34 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LYnTP5F58zDrvL
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1656615033; bh=nSCOT1DD58jQwqlCjkRUEtYtFzgOgAcIKRrxunM5WaM=;
        h=From:To:Cc:Subject:Date:From;
        b=caM6QXu1PpsdGLkcsQs6ObyHWYYVeM0GNL4qz9yhnkJLmnqlGwXjddxrQTqKftFD0
         i4t3we9blCXyTdO65SHBio+BjO3XaMU9LfGLBzZdCQwXDQTshw0/EglFDH331d18Be
         Y2rIlKeUEkLpBXBdO8xeKZA3Hk8L0riK/T2enPtI=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LYnTN5jyDz9sSd;
        Thu, 30 Jun 2022 18:50:32 +0000 (UTC)
X-Riseup-User-ID: 339BBADFF3DC1BF0303D044F0A237A340824BC022CE0114F3C19DA29713ABCB4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LYnTJ3PWWz5vLd;
        Thu, 30 Jun 2022 18:50:28 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH] drm/amd/display: Remove return value of Calculate256BBlockSizes
Date:   Thu, 30 Jun 2022 15:50:05 -0300
Message-Id: <20220630185005.908140-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function Calculate256BBlockSizes always returns true, regardless of
the parameters. As any file checks the return of the function, this
commit changes the return value to void.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2676710a5f2b..ed23c7c79d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -957,7 +957,7 @@ static void recalculate_params(
 	}
 }
 
-bool Calculate256BBlockSizes(
+void Calculate256BBlockSizes(
 		enum source_format_class SourcePixelFormat,
 		enum dm_swizzle_mode SurfaceTiling,
 		unsigned int BytePerPixelY,
@@ -995,7 +995,6 @@ bool Calculate256BBlockSizes(
 		*BlockWidth256BytesY = 256 / BytePerPixelY / *BlockHeight256BytesY;
 		*BlockWidth256BytesC = 256 / BytePerPixelC / *BlockHeight256BytesC;
 	}
-	return true;
 }
 
 bool CalculateMinAndMaxPrefetchMode(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 10ff536ef2a4..25a9a606ab6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -169,7 +169,7 @@ bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
 		unsigned int pipe_idx);
 void PixelClockAdjustmentForProgressiveToInterlaceUnit(struct display_mode_lib *mode_lib);
 
-bool Calculate256BBlockSizes(
+void Calculate256BBlockSizes(
 		enum source_format_class SourcePixelFormat,
 		enum dm_swizzle_mode SurfaceTiling,
 		unsigned int BytePerPixelY,
-- 
2.36.1

