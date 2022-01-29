Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22DD4A2C87
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352427AbiA2HgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:36:09 -0500
Received: from smtpbgjp3.qq.com ([54.92.39.34]:55983 "EHLO smtpbgjp3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352369AbiA2Hf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:35:56 -0500
X-QQ-mid: bizesmtp38t1643441745tmhbo8l6
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jan 2022 15:35:32 +0800 (CST)
X-QQ-SSF: 0140000000200090G000B00A0000000
X-QQ-FEAT: bUbfunjy+D9R0CmpzyPUKsRG+w28FZ5+xzS5jLRxjTrEDp7XJQpIJvqOe7KG5
        gBHHcpg37gSpNF19qFhVDzA17mPuRoYbXtLqoxZjDZBTzf439IacU96VH3sJS7/FVTYHMDA
        DLtpExDtvtRUrnV/iZ25AbJwajRMUrCFEvENfLqskTvlxXHtWjnK9X62Klc9dYM8fcHIgcZ
        CLqDG++mVrjE2V/VgEJjaAeZ09qXHM1Y89P4pueINUi7kq/XUpJC+qaQQuYHhrYU/2WprQG
        m7GGnHh1tQra4adeJ8W9qWcJi4bUoMyhVaGoBlr9Z6P+GdZcqdD+1FlnifX/c3GEw9pIK4k
        QnOikdcLcr1f0BPfI/WDqPCvurGyspMVAOEI/Yv
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date:   Sat, 29 Jan 2022 15:35:24 +0800
Message-Id: <20220129073524.31534-2-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220129073524.31534-1-zhanglianjie@uniontech.com>
References: <20220129073524.31534-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after the buffer object is successfully mapped, call radeon_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..c5482f7793db 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -497,6 +497,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	handle = msg[2];

 	if (handle == 0) {
+		radeon_bo_kunmap(bo);
 		DRM_ERROR("Invalid UVD handle!\n");
 		return -EINVAL;
 	}
@@ -559,11 +560,10 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 		return 0;

 	default:
-
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
-		return -EINVAL;
 	}

+	radeon_bo_kunmap(bo);
 	BUG();
 	return -EINVAL;
 }
--
2.20.1



