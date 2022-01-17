Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6949040E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiAQIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbiAQIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:41:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA18C061574;
        Mon, 17 Jan 2022 00:41:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id t18so20499413plg.9;
        Mon, 17 Jan 2022 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEtzxmnMM6Tm4aFw5dyzl7Dg82zrHDn+xLKCSqcIoYA=;
        b=BZoX3xjzmctBGdLOcR11a7mx2a7G4JSQKkCEsd1DEAWP237u5GCSv9nlsVkLCatXR0
         5CQmYevH5xmHtOf9XE9BOJJZU0R1WNFSlKLue7aU+bHtIozo34kbZ5jp62JAUooIOCE+
         mvB5bGwdlLyAmazE6sCyNOsSoIqH8KCD7OBHTlxZtqeY2/wVZBlY6mkdko+QMWTviSns
         1HXzL9gP+EnsuY6dbKFhtQqit01ts+nIGF+aa954ja2A1kDb6krSsMlEGGmaDAvYXAE/
         F5j8iaN8yaDAL9mqsG9bUE7Ksp52819NVVF//7rt/q0PAp+xGQONraWH6UQpW1bNoFdU
         YxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEtzxmnMM6Tm4aFw5dyzl7Dg82zrHDn+xLKCSqcIoYA=;
        b=nB0FxFAcSVt0ckatvosc59sT9HBALdOYs8F24XbQCkKFI4rytwClod6BRekksEQ8go
         C+HEt32yn5wgxICKMiJq/KsYvwPrcs0OUicTW4LL5d+r3DU4BEkB0zPopo5zhFOaZTpl
         lERxAvFzfAwvRBk7st+Tu8OkEbttfDVEAJc3sl1lK6T6z7aj87iTyHIbA/gXTWgEYLaq
         YLVsTZNdvLFzb8snGKDJGBpF50Z8eomXMHNALkerTevcMsHt1ptoDihm7iweYZo4pxL0
         lxMb965k13kdZIaet0qODYBio0W1HU1PuSG2W7V06WyAo/Btm3Uis/phBs6xxd6ZR4xq
         9wbA==
X-Gm-Message-State: AOAM5324eqyfMmbc+Tif81JCG/nDAirvA7HLPaQZqDbefw6VB1OlAySq
        XPA9LPIav91xVCQEAPS7JOQ=
X-Google-Smtp-Source: ABdhPJyKUf4iLLOgGSynqegS/pHGDCtLdascpbGORC9N0SwxRb5unf7azIBgzWg08E/buvKorUGnBw==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr16707808pjb.82.1642408862007;
        Mon, 17 Jan 2022 00:41:02 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([240e:47b:800:d5d1:d9c9:3c3f:6ba3:517a])
        by smtp.gmail.com with ESMTPSA id a9sm12673695pfo.169.2022.01.17.00.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:41:01 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        javierm@redhat.com, tzimmermann@suse.de, lukas.bulwahn@gmail.com
Cc:     zou_wei@huawei.com, kevin3.tang@gmail.com, pony1.wu@gmail.com,
        orsonzhai@gmail.com, dan.carpenter@oracle.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] drm/sprd: fix potential NULL dereference
Date:   Mon, 17 Jan 2022 16:40:44 +0800
Message-Id: <20220117084044.9210-1-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'drm' could be null in sprd_drm_shutdown, and drm_warn maybe dereference
it, remove this warning log.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

v1 -> v2:
- Split checking platform_get_resource() return value to a separate patch
- Use dev_warn() instead of removing the warning log
---
 drivers/gpu/drm/sprd/sprd_drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d..af2be97d5 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -155,7 +155,7 @@ static void sprd_drm_shutdown(struct platform_device *pdev)
 	struct drm_device *drm = platform_get_drvdata(pdev);
 
 	if (!drm) {
-		drm_warn(drm, "drm device is not available, no shutdown\n");
+		dev_warn(&pdev->dev, "drm device is not available, no shutdown\n");
 		return;
 	}
 
-- 
2.29.0

