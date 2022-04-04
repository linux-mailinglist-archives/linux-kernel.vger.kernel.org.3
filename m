Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4647F4F1FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiDDXDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348056AbiDDXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:02:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E146C4A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:22:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q14so14740732ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3rwhB1mUhFaCfEgLZjUcCjNm+5f5fkFkvdLOTF0xYk=;
        b=P0iFhoylKXhVCWdgWMTjMyf65xZiqKqiiqn4536XFm7K4P9Ta0r/nlJa2ZwiC+a12n
         LSLuT9brEn/BUEFFC5GWAnVhrlfeyA9hIGXUnG9WJiMuq/PLyfQCGF2C66gRnkEK/+/W
         e0WoLN8Qs1s2zXNPwroDh68ftRZkYO04Dps0QAibdvREzehBAOAGVoxowB38OcI3ESLx
         IlDiri9w8Pk3RUThqxIFl288Atk6Wf21f7tUH9BmnEH5Aa2eAj6/ATlfCL13xk9EIcr8
         /Ri3gOybzV17/GnsQmzrsdw3NOaikndrXmGL+yF/PWgFm3YtmhHclJJPI4kygMXUTLX7
         0EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3rwhB1mUhFaCfEgLZjUcCjNm+5f5fkFkvdLOTF0xYk=;
        b=H3hlnmkldLIsM6g1wyH5log8eCKJ2G+7+WxEE9FWhC8G6gkfDT29dyWlU6A3ZH6Ih0
         wrbKSFG4pMreMQ/REVhYYNzU5Ambn73dyb/ojOuknn8ZPmChp3vHf8RYVemY6acIPTKY
         jDV6CozRzupGMh1NCyVMSCFEpTBILIUAKeLDal45w8dETrhQbuEr2VPbSrnd0eEadFIO
         9RP3XR0mHULDlihHVB3tGPg52pLVFwwSBIGGAji6HgFhdiG6lbLFIq0VRGEkYTbjNxKY
         uxhd8EmLfdRh1j04+1pwn2j7m+CnNNQONDu0B+1VWBwfWfg+5jGe5k6Ct6Mne2Wyeecy
         SkaQ==
X-Gm-Message-State: AOAM532boqShY9zguo29p9ZDWpklSMzAC4Acvufhz8ZoFCC8nhfCnxPg
        itoZI66RHRvcVXcET4U/8r0=
X-Google-Smtp-Source: ABdhPJwXm5uGlz1Ceov1IiHnrlmRknRoJkFqYNsXAi624p6ZE1sgHZJw6jz9Vbq32Ly/8CU4oucKGw==
X-Received: by 2002:a2e:9c96:0:b0:249:5f27:591a with SMTP id x22-20020a2e9c96000000b002495f27591amr172674lji.11.1649110925028;
        Mon, 04 Apr 2022 15:22:05 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:1093:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id v10-20020a2ea44a000000b002493831631csm1181068ljn.14.2022.04.04.15.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:22:04 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix potential NULL pointer dereference
Date:   Tue,  5 Apr 2022 01:21:32 +0300
Message-Id: <20220404222132.12740-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

In the amdgpu_amdkfd_get_xgmi_bandwidth_mbytes function,
the peer_adev pointer can be NULL and is passed to amdgpu_xgmi_get_num_links.

In amdgpu_xgmi_get_num_links, peer_adev pointer is dereferenced
without any checks: peer_adev->gmc.xgmi.node_id .

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index be1a55f8b8c5..1a1006b18016 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -541,11 +541,10 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 	struct amdgpu_device *adev = dst, *peer_adev;
 	int num_links;
 
-	if (adev->asic_type != CHIP_ALDEBARAN)
+	if (!src || adev->asic_type != CHIP_ALDEBARAN)
 		return 0;
 
-	if (src)
-		peer_adev = src;
+	peer_adev = src;
 
 	/* num links returns 0 for indirect peers since indirect route is unknown. */
 	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
-- 
2.35.1

