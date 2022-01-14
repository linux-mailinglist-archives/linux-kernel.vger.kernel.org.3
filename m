Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0F48F03C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiANS5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiANS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:57:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69033C061574;
        Fri, 14 Jan 2022 10:57:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m1so3532923pfk.8;
        Fri, 14 Jan 2022 10:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfsWlZ8NFWx1uU7iqNfomSH4aDVoXB8WLZulfHDXbiU=;
        b=AxXYGXioXE1+f7CtBSW0vuFQGuUAd3neKR96VsJGT+uTkETY8PP4fDNvWZiatTjGrd
         Bq2zK8rBoROD5kYZADr0RiaMTWBi+CZYxAbEDFZ4rjDEfuR79bZm1QiZLu2YZaHTi2PJ
         9jWykAN+I7uOxZWAIuO5DL35ySbJ7mzH0T5k6EoiLJ5Sge8i7VmhisQkzlPAAFjysAGm
         ztTre6fsBXmne6SQYtwPeZON1kgUVcYqE5kscE8w+RXo945r62emwYRq9gUjqwt+N0Rg
         orv+dNzGhbY4KoBzAQL7Lt38OsjUF/s+PHElWbl/4k5MHOf4q0FB/34dv5LY2fNReqnm
         iCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfsWlZ8NFWx1uU7iqNfomSH4aDVoXB8WLZulfHDXbiU=;
        b=GdpNwMtvKAtLCg41WzQBWAe9VPfUkbGQexRXCbuICodGKOzKjyaWTjigKQXUhcmxWx
         osZ4prj+0zgDpopiadg5RLxyznINimJRj70aV2Bt4lWDLT0tj53SYx2J0Rl7LMmfBsEa
         nJ5/M6CyFKd+rrrhCoiReWQkkQoODLvDXqdJ6DK+3qXEEYGuSA09DfjDdTqJFVqzl8/e
         L+N4jIKJ8+xw/66AZVUmZa9dZXJXQCEcj+EU+Kwv6dCHP4FdGV076q0Kv/+uAfD2rio9
         Ht3xpponUx9Of6L/U9jW5DW7uMxCI+rSKXhBSfJkUySIMmKMFmxGBQLO+jBvsT9uQ59k
         cHKQ==
X-Gm-Message-State: AOAM533ZRXEZ1kv6mhvv1x5XFzACXHOaIG6a5lFRZVcmfMvNjO06Y0QZ
        nfCcbfDdVk7c2SaxRdNTOzU=
X-Google-Smtp-Source: ABdhPJyQgrBlfjf4WxO3o5H3yNyytTGW/UpG9pHb6wp7ZenQY6PoaUUorCVedNy4OVKwvZCYXZSMZw==
X-Received: by 2002:a62:3893:0:b0:4ba:7246:4830 with SMTP id f141-20020a623893000000b004ba72464830mr10421883pfa.30.1642186656908;
        Fri, 14 Jan 2022 10:57:36 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id h15sm7017170pfc.89.2022.01.14.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 10:57:35 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/rd: Add chip-id
Date:   Fri, 14 Jan 2022 10:57:42 -0800
Message-Id: <20220114185742.283539-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For newer devices which deprecate gpu-id and do matching based on
chip-id, we need this information in cmdstream dumps so that the
decoding tools know how to decode them.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 81432ec07012..7e4d6460719e 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -62,6 +62,7 @@ enum rd_sect_type {
 	RD_FRAG_SHADER,
 	RD_BUFFER_CONTENTS,
 	RD_GPU_ID,
+	RD_CHIP_ID,
 };
 
 #define BUF_SZ 512  /* should be power of 2 */
@@ -202,6 +203,9 @@ static int rd_open(struct inode *inode, struct file *file)
 
 	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
 
+	gpu->funcs->get_param(gpu, MSM_PARAM_CHIP_ID, &val);
+	rd_write_section(rd, RD_CHIP_ID, &val, sizeof(val));
+
 out:
 	mutex_unlock(&gpu->lock);
 	return ret;
-- 
2.34.1

