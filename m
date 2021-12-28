Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAA4806FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhL1Hbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:31:46 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:11908 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233631AbhL1Hbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:31:45 -0500
X-UUID: c5eaab73c6814abc813d602ca3e67c2c-20211228
X-UUID: c5eaab73c6814abc813d602ca3e67c2c-20211228
X-User: wenzhiwei@kylinos.cn
Received: from localhost.localdomain.localdomain [(172.17.127.26)] by nksmu.kylinos.cn
        (envelope-from <wenzhiwei@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1341986671; Tue, 28 Dec 2021 15:44:06 +0800
From:   Wen Zhiwei <wenzhiwei@kylinos.cn>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     wenzhiwei@kylinos.cn, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm/radeon:Fix null pointer risk
Date:   Tue, 28 Dec 2021 15:31:26 +0800
Message-Id: <20211228073126.48906-1-wenzhiwei@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the null pointer is not judged in advance,
there is a risk that the pointer will cross
the boundary

Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index bb53016f3138..d3d342041adf 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -951,7 +951,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 
 		if (mem->mem_type == TTM_PL_TT) {
 			bo_va->flags |= RADEON_VM_PAGE_SYSTEM;
-			if (!(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
+			if (bo_va->bo && !(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
 				bo_va->flags |= RADEON_VM_PAGE_SNOOPED;
 
 		} else {
-- 
2.30.0

