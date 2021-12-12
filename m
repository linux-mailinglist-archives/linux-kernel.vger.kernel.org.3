Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFD2471BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhLLQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 11:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhLLQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:40:04 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C1C061714;
        Sun, 12 Dec 2021 08:40:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b1so26710993lfs.13;
        Sun, 12 Dec 2021 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnedO9b6vjLZxKJM/wEKxKhqHm2FwahC7goP3pJJhNw=;
        b=V5oJ3i+5pWNV6Tlck110K9NB214XryU6AzpHIegPkXHZ5EiBItZnD9NflSGyGPf7a8
         c2C5IKpPHAUmGij+o7h8RKJ8H2CkmJzWZl4dmiHtRKCZf2qgqil5+thx5wrWXUW6Gkqs
         cMty2xGJpRbRowBIHaUNcsxVfVivDizL037Xt8yjPQT9Ilm6FUxHgjstH+asxYGAU6/o
         BVE8nIZmucjNUqNgkMDlx0lU5nv5lAp91b4xXn6vrd/TNL9fQUYQJB2O+jKG7/UtKN4l
         uwYYKFQ38Y+X3wYGEMlVLbCvd/lEvn0Q7TwFhOvy4+CZGNJxss8uqEXzlutEjpHI/Spp
         z1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnedO9b6vjLZxKJM/wEKxKhqHm2FwahC7goP3pJJhNw=;
        b=U2UVPwh0RawviyOi7c3u16xDTH/u6snDNDX11uOwjcT/3bndKv837IyFTBI75Sy/ZF
         ++Qh/b/BAxAnJNnQpWe4jSjQz69jn+hBNE1t2Q62rDbz72+W0dT5QUaNeYE/4OYAnTMP
         wqHQemlV6CUU/EbtRXQE0DZrCPx0qsISoHAsAvlIYDQWGyGdfBEf6zntlHb64QZ5I2EG
         WMPAUl84DsW6wQ730qZTKLiRkWxb+mNYnr3+4AiPa7sRnOwLOsxaHyZcjuMStQaIpDXd
         wQPUZJUS5uCGh/AyTtmeolml+3SFDXdxmp8nPN6yZ56ORQChlcJDeuR8O+73orYKGa5Z
         0JcA==
X-Gm-Message-State: AOAM530onPTc63ndttp3VX7HP7E9wFLtKzrPyVHZde5J0ZRjs6YVXl5x
        zwZUWlX/dGo9+x9iEpXdsQQ=
X-Google-Smtp-Source: ABdhPJzbzHHtaprJmbFJWQm+Zl/A3sbrNT7y1KqWq84qcIZgutxfbO8KaGojTHfKuutQJMs79ryaKg==
X-Received: by 2002:a05:6512:2289:: with SMTP id f9mr24013249lfu.619.1639327202731;
        Sun, 12 Dec 2021 08:40:02 -0800 (PST)
Received: from localhost.localdomain (public-nat-10.vpngate.v4.open.ad.jp. [219.100.37.242])
        by smtp.gmail.com with ESMTPSA id u7sm1110936lja.58.2021.12.12.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 08:40:02 -0800 (PST)
From:   Vladimir Lypak <vladimir.lypak@gmail.com>
To:     Vladimir Lypak <vladimir.lypak@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/msm/a5xx: Fix missing CP_PROTECT for SMMU on A540
Date:   Sun, 12 Dec 2021 16:03:17 +0000
Message-Id: <20211212160333.980343-2-vladimir.lypak@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211212160333.980343-1-vladimir.lypak@gmail.com>
References: <20211212160333.980343-1-vladimir.lypak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CP_PROTECT entry for SMMU registers is missing for A540. According to
downstream sources its length is same as on A530 - 0x20000 bytes.

On all other revisions SMMU region length is 0x10000 bytes. Despite
this, we setup region of length 0x20000 on all revisions. This doesn't
cause any issues on those GPUs. As for preventing accesses to the region
from protected mode it was tested to work the same.

This patch drops the "if" condition in setup of CP_PROTECT entry because
it already includes all supported revisions except A540.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 894881d273b8..fea632c789a0 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -860,10 +860,8 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	/* UCHE */
 	gpu_write(gpu, REG_A5XX_CP_PROTECT(16), ADRENO_PROTECT_RW(0xE80, 16));
 
-	if (adreno_is_a506(adreno_gou) || adreno_is_a508(adreno_gpu) ||
-	    adreno_is_a509(adreno_gpu) || adreno_is_a510(adreno_gpu) ||
-	    adreno_is_a512(adreno_gpu) || adreno_is_a530(adreno_gpu))
-		gpu_write(gpu, REG_A5XX_CP_PROTECT(17),
+	/* SMMU */
+	gpu_write(gpu, REG_A5XX_CP_PROTECT(17),
 			ADRENO_PROTECT_RW(0x10000, 0x8000));
 
 	gpu_write(gpu, REG_A5XX_RBBM_SECVID_TSB_CNTL, 0);
-- 
2.33.1

