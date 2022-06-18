Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1586A5501C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383632AbiFRB4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiFRB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:56:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A46B659
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:56:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z14so5461644pgh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtAGuPWlDclOLtuut3wNPxB76BoLDhIudEt0Y8tqNwk=;
        b=L37xTtW94OTIvyImZWUWZSzaVN/Q+8SfdWOHEUuPC8e+e+hEbsgWmWvBUBIhMGhiYN
         CA2w7oCmfZ8hjGkruCkfuE0iNf2LtSINoeXRn/74G+V0TJTcOzZx2bBy+fFul3s97JG+
         Co7XMPQeD3CR+CAqvhl/QZHJ60ByD5IFcuPAZvFew44CmClDCgYilo2kC7/gVcUcQpCM
         i0yYyfFHf9EVIY3CzNSqqg120wcWU234NTqGaxub2HGAXfBph/DDc3M6dFhiGXC57Ge5
         ye0QTrTJHMhZpOWd+ppjXKWaA/paaJgOClVUSCYCncZz32OzbZzV1ZCu/BGYj66twmYT
         Bdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtAGuPWlDclOLtuut3wNPxB76BoLDhIudEt0Y8tqNwk=;
        b=X82ME742yeDmh/Wr5wXcu8Ib9siO5Owdo1O9UJCrx212VbYRB8UB+mXRE1spd4pWWv
         ykD2EDH2qOV7lWNZ23DcJ3Ap8nrMhpTFnfRLxfUdMN+Mri3QLAtlaMls8P6DpU/3xI1X
         Qamhtxl5wWaKaomD2hirJW74oXclLehRHU2v6hW3Bwi9576aGAmo29wCsoGUmoy/OS/7
         IMSc9rcqHx9Dj+0QX4VaF06HObUJrvv4iOeMq3nREMyv6pUXC63/y2rJqJEGnRF0rxsx
         LeHjHC/EILAymKslPRGm63hKuLn1AoAA6Q55Do+J5nOlnGSS+uHy/K3qQ0whb8SkYctP
         TvyA==
X-Gm-Message-State: AJIora+7psqhEIREwPPPnMW7t1KJZDEIgPBVMHxlcmufk88Oajb0JeJu
        ZuBjuLlJHTYKr1dHSM6qnf3hTHsnJolbvg==
X-Google-Smtp-Source: AGRyM1vEBh1R1S9d8pNr3JY9mG86I2UOBCZzS+O5P3XJMHMYGjs/EywCv3TlJEd7jifeNpsrJzXvBw==
X-Received: by 2002:a63:5706:0:b0:3fc:a31b:9083 with SMTP id l6-20020a635706000000b003fca31b9083mr11427116pgb.333.1655517412758;
        Fri, 17 Jun 2022 18:56:52 -0700 (PDT)
Received: from localhost.localdomain ([122.167.211.160])
        by smtp.gmail.com with ESMTPSA id p15-20020a170903248f00b00163c6ac211fsm1921227plw.111.2022.06.17.18.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 18:56:52 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Roman.Li@amd.com,
        shenshih@amd.com, Wayne.Lin@amd.com, contact@emersion.fr
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        Kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/display: Remove unused variable 'abo'
Date:   Sat, 18 Jun 2022 07:26:42 +0530
Message-Id: <20220618015642.5958-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9143:27:
warning: variable 'abo' set but not used [-Wunused-but-set-variable]

Remove the unused variable.

Reported-by: Kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9004f7e700d..0103b34aabdd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9136,7 +9136,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
-	struct amdgpu_bo *abo;
 	uint32_t target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool pflip_present = false;
@@ -9208,7 +9207,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 		}
 
-		abo = gem_to_amdgpu_bo(fb->obj[0]);
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
 			afb->tiling_flags,
-- 
2.25.1

