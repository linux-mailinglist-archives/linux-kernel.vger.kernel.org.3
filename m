Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9586D575379
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiGNQzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiGNQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:55:11 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD344A839
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:10 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LkL2V1yX0zDqJ6;
        Thu, 14 Jul 2022 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817122; bh=LtTJoOMXTYblHOmEzFD9Z9+ZWWSU7JPSs4v5n5un1fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PL2sHy7GJK/zmyS0ugXaxPdsM2NvrBgGUbCbtC1VyI1LR+HxHpmRhPm5QqDttXqfz
         ZUlD+SBOROEpyD2NjKQ4ZMynMnbc2IJh7qEEUGGFob0UZeZKXU7ggSiHoHTrNencXs
         BeiE+eA4XxWiyaOxcTTs1QHG1Il5dYngoPaFDfHk=
X-Riseup-User-ID: 5606EAEC306D01162A019378FB2E7187901FB4B30771F350631FF2AB1AA21580
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2M4cTmz5vW1;
        Thu, 14 Jul 2022 16:45:15 +0000 (UTC)
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
Subject: [PATCH 01/12] drm/amdgpu: Write masked value to control register
Date:   Thu, 14 Jul 2022 13:44:56 -0300
Message-Id: <20220714164507.561751-1-mairacanal@riseup.net>
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

On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
should be written into the control register instead of 0.

Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index f5a29526684d..0a7b1c002822 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -339,7 +339,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 
 		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
-		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
+		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 780a8aa972fe..f57f4a25cf5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -333,7 +333,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 
 		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
-		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
+		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
-- 
2.36.1

