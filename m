Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6E4A2C86
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352347AbiA2Hfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:35:44 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92]:50533 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350821AbiA2Hfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:35:43 -0500
X-QQ-mid: bizesmtp38t1643441730t62b498p
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jan 2022 15:35:25 +0800 (CST)
X-QQ-SSF: 0140000000200090G000B00A0000000
X-QQ-FEAT: G+mSt178IQoTYQN1zQNWO4fWEpa2DjF6LmdbvCkxTJpa6g30cSawiGGPsWRcy
        nSN5/XaF6Hijq/rToZi9VOEKBy34VSLgR4gviRn/x3+ozu64xzhns6OV5jLbY/cTWsOR/9l
        1qo0H/L5m9ltuGRZln+q3CURtPSA7Gnc7gUZCW2iAotyAk7QATiOuMy2KznxJBoLzVGZ6Q9
        qLOAbhFvdq1lIzpNeWlQ8bJQTsOotpi5qp4I/ZTmMLT/wN7LMFt7D707KjGSbZlvNcbrAHB
        qlC+YT2uRY9kTAhUuQ/JTxNuoDx0vTYM/4fE1arW8E89cYhgdPP6XuaEQ276OChAaVO0MZt
        uf004hDt1ZApRHI+d3liKosa2WXnCuDfAMAtZpr
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH 1/2] drm/amd/amdgpu/amdgpu_uvd: Fix forgotten unmap buffer object
Date:   Sat, 29 Jan 2022 15:35:23 +0800
Message-Id: <20220129073524.31534-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after the buffer object is successfully mapped, call amdgpu_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 6f8de11a17f1..9cc23b220537 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -834,6 +834,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 	handle = msg[2];

 	if (handle == 0) {
+		amdgpu_bo_kunmap(bo);
 		DRM_ERROR("Invalid UVD handle!\n");
 		return -EINVAL;
 	}
@@ -892,6 +893,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
 	}

+	amdgpu_bo_kunmap(bo);
 	return -EINVAL;
 }

--
2.20.1




