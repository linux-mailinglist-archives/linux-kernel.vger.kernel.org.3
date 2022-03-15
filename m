Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203FD4D97A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiCOJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiCOJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:31:08 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF44ECCD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:29:56 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ae8f9.dynamic.kabel-deutschland.de [95.90.232.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 24C7D61EA1927;
        Tue, 15 Mar 2022 10:29:53 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Use ternary operator in `vcn_v1_0_start()`
Date:   Tue, 15 Mar 2022 10:29:36 +0100
Message-Id: <20220315092937.141380-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the boilerplate of declaring a variable and using an if else
statement by using the ternary operator.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 3799226defc0..78ad85fdc769 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1095,13 +1095,8 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 
 static int vcn_v1_0_start(struct amdgpu_device *adev)
 {
-	int r;
-
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		r = vcn_v1_0_start_dpg_mode(adev);
-	else
-		r = vcn_v1_0_start_spg_mode(adev);
-	return r;
+	return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
+		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
 }
 
 /**
-- 
2.35.1

