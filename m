Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288894851F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiAELlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiAELlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:41:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C210C061761;
        Wed,  5 Jan 2022 03:41:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso2065811pjm.4;
        Wed, 05 Jan 2022 03:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=W8qJ+gTWpAmAqccsu4VHP+qDqU+AE+afcLRoJrwVo6E=;
        b=b3QiHQH5Er4oKyc+54KGnd0tlcWe1qJ43yNX6bdDbwwVF2Vhgsj/nqEN5E0PdzPSgi
         i6L32JrWkLBNe0fjMhh6C321aYJKPKRZpaGo7L5b8OTJgxJR8tqwlImRO64uP+JrOiOI
         z0gX5qt78Zn0nEqZpP3OAMAe+EwYdkvKjgwPb2ceVOOeoGKqr0CJXWuDv0Yr9BYhy0vv
         ey9xGLkrfvf+qDKFQp15hpoQgEVnfCy3Kl8LvE73cvpDzTSV04d4nShIOgib6sv27j0Q
         YpPQp4QLol5SuP0GvJEv3hG+UzV9PmnKaTP+sGBsJzac2zQkfk2QiKWi2lBZ60DY7w7N
         wvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W8qJ+gTWpAmAqccsu4VHP+qDqU+AE+afcLRoJrwVo6E=;
        b=UtA+jW1Txb+LPdrFctJV1NbXCi9GPotA4iskbtM/vXZ7WqCPAW9HexA8TfFhLwqXZ4
         h9Wkchp+qBLz4I1mDKdKl2beIY4Y4i0kBYiWfbQWOkPVg2eu29u8zJads9IU/dJJGLR0
         4JA6vftypVymfuoMtrQ7IzTmdDHubXHBUmzC+6fhiV0bifH3y8uhDNIdIb3DHmy/MLEk
         pBjylkB/rnJTfS6N8hde66R+hyjogCEP2iqwpVVt23myHwpoNOwYYJXEhdzazk99bA/y
         zPG76z6YOelV3vYDZY00GEDDABWbxm/b7AB2WX+f62ORJhfheYAwCJ6ljYnx1+xZzxIq
         45tQ==
X-Gm-Message-State: AOAM5324zKNbDfNvWSBL+/gYzU3IlOlaltQ75WzVgEuggAaSu/QO7a3H
        DvUR5C5hSgSXLyL2KxB+mRM=
X-Google-Smtp-Source: ABdhPJwuRDvftHGsqLhPtov6RcOWcaLCpjOn8GP37kisprl7fIKuAr5s6mzCXoBSAvQYRt69/GMU9w==
X-Received: by 2002:a17:90b:1206:: with SMTP id gl6mr3625640pjb.228.1641382873733;
        Wed, 05 Jan 2022 03:41:13 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t126sm36753254pgc.61.2022.01.05.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:41:13 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: bdisp: Fix PM disable depth imbalance in bdisp_probe
Date:   Wed,  5 Jan 2022 11:41:08 +0000
Message-Id: <20220105114108.10380-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 28ffeeb ("[media] bdisp: 2D blitter driver using v4l2 mem2mem framework")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 7d467f2ba072..ded4d026f84c 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1396,6 +1396,8 @@ static int bdisp_probe(struct platform_device *pdev)
 err_remove:
 	bdisp_debugfs_remove(bdisp);
 	v4l2_device_unregister(&bdisp->v4l2_dev);
+disable_pm_runtime:
+	pm_runtime_disable(dev);
 err_clk:
 	if (!IS_ERR(bdisp->clock))
 		clk_unprepare(bdisp->clock);
-- 
2.17.1

