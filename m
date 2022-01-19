Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7978049433D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357607AbiASWqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiASWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:46:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71CC061574;
        Wed, 19 Jan 2022 14:46:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w26so8234698wmi.0;
        Wed, 19 Jan 2022 14:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dozCW/4nG3udLwOhRUS1K5kLFfVXF4cNdQjF1vkmvlo=;
        b=eTuSHohyTQB9Bmao7dqcPpa5iKgzaCjRBmINJezn9uUIsQIY4xO+7pmWpTVF4wcLIG
         gJPXwv1OyMMCfBpUj3UrZY4ymzGYu8uV2D+/V4rKdRa1tf2kSDeSAPHIhrbq3GEkyV/7
         C3v8D1BvXLf9U8Y8NdhEF5iNRuFqvH1l5RVHHLHoyJgogkZtBpV9PDF6+AeUMZovg6/2
         ruYB4kiA9sXp+gcvkbgN4aAXJbtYldRjVg3Ajg9nVpI5yw2rPc0necow6Xz3WD5D9hXi
         /UoIXE4A+U9vwKr8XaOIB+wRLsKWr9PzhocGZQrqTgWc4YTeI1xNTRZn+Ie5sofugWDE
         GFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dozCW/4nG3udLwOhRUS1K5kLFfVXF4cNdQjF1vkmvlo=;
        b=EMkRNJoi+DvLifv3WOffk8U4oU1lxkgfFN8Og7IpBym96FCSBUWLK60UNskTaM4NUj
         5WBao9OSpt1WV6Iv9oplzt2+aALK7U0kh5oLUCp7m02DHqiqhhjJtLIvDzAGKnUHtOvX
         O8FgU8CVFaXaYNw1KV2aWa/NfcvElNA9YjYZDqu/2R55TtVJgJBvY1RRREzmjUuDY+TC
         iqsqf+L5VZSYs6O/IlwGf56c0ookfDf4zD3Rz7Ds2yvA0vJ29aZpmeSeg2fhpTCxmxtF
         DrWYLQZ1mTl7qNgsllH+R8i8NQdmMCjA69gHb/i2SO+SwLcNfejNF/PR2n0asBXqRrVr
         hkkA==
X-Gm-Message-State: AOAM531Q+V6payDEIWd/zbIdIw4HlQQIl81GkfE0m3ThV6rep1HV/ML0
        aRbAa8IAVZ0hoV8OxC4k8D43EiB1/aldvg==
X-Google-Smtp-Source: ABdhPJxOGEhjagNWyMQplUIULkMwQHFIt60zMdvuUb+Ib7Lu3QRBbFO1q1Qqx/xdRqaQeI+pXzRlvQ==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr4298033wmh.170.1642632389084;
        Wed, 19 Jan 2022 14:46:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t17sm1109531wrs.10.2022.01.19.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:46:28 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] drm/radeon: remove redundant assignment to reg
Date:   Wed, 19 Jan 2022 22:46:28 +0000
Message-Id: <20220119224628.123084-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer reg is being assigned a value that is not read, the
exit path via label 'out' never accesses it. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/radeon/radeon_object.c:570:3: warning: Value
stored to 'reg' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 56ede9d63b12..87536d205593 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -567,7 +567,6 @@ int radeon_bo_get_surface_reg(struct radeon_bo *bo)
 		return 0;
 
 	if (bo->surface_reg >= 0) {
-		reg = &rdev->surface_regs[bo->surface_reg];
 		i = bo->surface_reg;
 		goto out;
 	}
-- 
2.33.1

