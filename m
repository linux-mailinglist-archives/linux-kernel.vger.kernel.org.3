Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB4490402
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiAQIii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiAQIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:38:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FB6C061574;
        Mon, 17 Jan 2022 00:38:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e19so20488258plc.10;
        Mon, 17 Jan 2022 00:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3dMb3L6alEHiAdLanjhoWI6FKkNSSFPHoeSh767vk0=;
        b=lVmAx9LIJmnrwluVwigCccYGNdJ3TijZkDjlw/Q2z3yxktk3EFUQ+7TjP9eL/X1q4p
         thm8OwOcBOiLNi4Wa+fzi3vPk6xUT0hI+uxjRRyisbi8SPOi1y/O+zXB25xPoDFNRDFI
         Ig3EeRAsck/F6GwjrZkSV0GJq3FN9dvJ57fMbLVU857fl8pNyGNezQjVZAMDsuYFImg0
         y7eGDcQc8atsOp+DylHX5YJJjksxqCOMe+ZbBy4IIUM6NnPGyhHPBmm/XBOFry5RmL/J
         6o/OeD1dM0+uXfOmCJKSRZzjF4vcWI6LJ6T/4djB4tr60/PHw13EPiyRHSCMAs+w6ofT
         +bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3dMb3L6alEHiAdLanjhoWI6FKkNSSFPHoeSh767vk0=;
        b=sAfXUDsp9Gj+OVO6uwJTJj99QjU/RPwxtJFLyGUkdrnkquhBLo8NlRQtrnbMXOyW/I
         wyGqtaMu5oJDnWku7BICOnB0vaIGJ4CEzhaoVxZpGTAeltbGySnsYSy0WSPqpCszggVv
         /YlQoLuE1fY/TnnPiRmyZfJmsLWuOVysIqejtw4L7s2G/7AWKrqG9AHohJeXwRWzVSc5
         QWevuITA+g/bIovprLZc78VaMYmdGO+DwUga3EE6lkq3b2ZfzO7jM4f9HfmOJd2igtyn
         a+TIx3JqLBeAaYxYpuicugJRoVoF1Lzy2QwN60/ZYOeX4qKQvLn/cfN0z8rbz3NZUWm9
         IE1Q==
X-Gm-Message-State: AOAM5302W9w6Lfy6PRFjE/bykpmIR1Qf98xpOdUCfDEsbtVWUTpE8gPO
        8ewSQB0p2oN7DrAisAGKxxQ=
X-Google-Smtp-Source: ABdhPJwqtjOW+jcPjrQBChZw59j+MKfYUcjzeqZtqLvQ0rh9JvbLq/1phu/gffQa8KpYOdtz5L+EPw==
X-Received: by 2002:a17:90b:38c1:: with SMTP id nn1mr9329697pjb.224.1642408717272;
        Mon, 17 Jan 2022 00:38:37 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([103.6.5.6])
        by smtp.gmail.com with ESMTPSA id pg9sm7260181pjb.44.2022.01.17.00.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:38:36 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        javierm@redhat.com, tzimmermann@suse.de, lukas.bulwahn@gmail.com
Cc:     zou_wei@huawei.com, kevin3.tang@gmail.com, pony1.wu@gmail.com,
        orsonzhai@gmail.com, dan.carpenter@oracle.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] drm/sprd: remove the selected DRM_KMS_CMA_HELPER in kconfig
Date:   Mon, 17 Jan 2022 16:38:18 +0800
Message-Id: <20220117083820.6893-2-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220117083820.6893-1-kevin3.tang@gmail.com>
References: <20220117083820.6893-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On commit 43531edd53f0 ("drm/sprd: add Unisoc's drm kms master"),
adds the config DRM_SPRD, which selects DRM_KMS_CMA_HELPER.

However, commit 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER
option") just removed the DRM_KMS_CMA_HELPER.
So the select DRM_KMS_CMA_HELPER refers to a non-existing kconfig symbol.

Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

v1 -> v2:
- fix commit comments long lines issue and drop "On linux-next" comments
---
 drivers/gpu/drm/sprd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
index 3edeaeca0..9a9c7ebfc 100644
--- a/drivers/gpu/drm/sprd/Kconfig
+++ b/drivers/gpu/drm/sprd/Kconfig
@@ -3,7 +3,6 @@ config DRM_SPRD
 	depends on ARCH_SPRD || COMPILE_TEST
 	depends on DRM && OF
 	select DRM_GEM_CMA_HELPER
-	select DRM_KMS_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
-- 
2.29.0

