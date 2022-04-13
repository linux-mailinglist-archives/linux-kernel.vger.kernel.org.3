Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F04FF01F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDMGva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDMGv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:51:28 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 23:49:06 PDT
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC162D1EA;
        Tue, 12 Apr 2022 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xq0DB
        RRLDqYeeo9ZuXiFrw91M+Bulw3iR7DHGNuPRto=; b=PETy5mHLPsEbDZN7fFmyW
        DADf7hZfegmsqcS1MRpwzwhhdwx+o1UQ47TvGN9cEMxp2g1AH9EJU4S9+TyuzPcm
        +PCvWMzQXoyQJfWMAEXWu+9SS+j7/apWbCUx3z+YZwSEGtnljEG2UGt4g8sOyJK+
        fop8xZqAkWCb4T61GOOAas=
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by smtp1 (Coremail) with SMTP id C8mowAA3Rze8cVZiR1HWAQ--.11201S4;
        Wed, 13 Apr 2022 14:46:20 +0800 (CST)
From:   Bernard Zhao <zhaojunkui2008@126.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bernard@vivo.com, Bernard Zhao <zhaojunkui2008@126.com>
Subject: [PATCH] drm/tegra: remove useless if check before kfree
Date:   Tue, 12 Apr 2022 23:46:18 -0700
Message-Id: <20220413064618.23974-1-zhaojunkui2008@126.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAA3Rze8cVZiR1HWAQ--.11201S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWxKw4rtFW7Xr1UXFyDtrb_yoWxCFc_Cw
        40qr97Ww48u39rJF1jyr43ZFW0kFnI9FZ5ZF9Fgayftw1DZw1kA3429r1rZ3WUCFWUXF1D
        Ja4UXF45X3W3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN7KsDUUUUU==
X-Originating-IP: [58.213.83.157]
X-CM-SenderInfo: p2kd0y5xqn3xasqqmqqrswhudrp/1tbiLR3hqlpD9ZpaGAAAsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove useless if check before kfree.

Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
---
 drivers/gpu/drm/tegra/submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 6d6dd8c35475..54ac31bc80f6 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -639,8 +639,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		kfree(job_data->used_mappings);
 	}
 
-	if (job_data)
-		kfree(job_data);
+	kfree(job_data);
 put_bo:
 	gather_bo_put(&bo->base);
 unlock:
-- 
2.33.1

