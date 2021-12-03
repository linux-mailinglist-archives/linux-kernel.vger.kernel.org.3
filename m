Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8E467B27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhLCQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhLCQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:22:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733EC061751;
        Fri,  3 Dec 2021 08:18:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 137so2768933wma.1;
        Fri, 03 Dec 2021 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LPkN68tYspfEa2svzvg7iyj4T9p7CaSU3K6P782Fdw=;
        b=g2S3EPebcJNAfwNc5v6rHce3p4JPeOX8jq2jgny1i7i6I0pQBv6ab0x055D8Qntl9g
         sOCtaFKVUZIyDjf3TfGZQxEJW4utSuMpXeYfU9EtRwlCI3g7X7ByXchi/V00JiCuYxPW
         ND1ZPpODaA1hifD8cwrXs+p5BP1Z3ojig+eShCqg3RouXry7hyfMYx9I0pIX6isk9TlE
         rgRHNhmK0jL2uohPoDQ0mU2VsELYNz80QcQfGwIqkr1qGN0pijc41nBLieWYCkQ0VoYt
         1kVyVu/GfknhgVr8yMsJfSgbAvnfFi+RpnqTJiGk7GDIFRsOTFdKaoLH17EgJua598li
         JEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LPkN68tYspfEa2svzvg7iyj4T9p7CaSU3K6P782Fdw=;
        b=wWf9/gZjQ/efR151M6jHigl0tadC3LTKdVvVBPiFGO3KsjAP/38t0jR+0E/FAvQ0zj
         db70Bow0ZBsyr1t6FfF1nPsSUixjYyWawcRSXJyNskaCL+4MSnpl2fnT2QVcZb0T1Xky
         Ep6kf4HM/TsB3JIHdyDjQMY5hgjEeK6DtG6OCj36VFMHTBfunYgGXJBYHi+Kr+yq58qX
         3iF3FODuXfi9O2VpGmv6f2X8ghnzsgVYKY+/97OZIoanvFCeQ9zG9iOrHMqTonj7fS6P
         6TwCj/wG1Cvfm/5pCtjkef6gt9Yo9WnMlv+ZLC76Jc+SEXB1tCyKOIymECW4AKq7UYUM
         fLvQ==
X-Gm-Message-State: AOAM531sAIpBJGNVUWhehjltYEf45kycN8wiWkC/pQ5vH0DeXZ+hObJ6
        z2FoB4+3GN97ragQL+tJXKU=
X-Google-Smtp-Source: ABdhPJzmcfbTgyWLQSHJ5e/BGnE3Pqje/jXItvJqco9AXkaN5rIXhT48X2OYs6JMnimTMbYjs6If7A==
X-Received: by 2002:a05:600c:3d06:: with SMTP id bh6mr16326257wmb.40.1638548334048;
        Fri, 03 Dec 2021 08:18:54 -0800 (PST)
Received: from localhost.localdomain ([39.48.132.131])
        by smtp.gmail.com with ESMTPSA id t17sm5665970wmq.15.2021.12.03.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 08:18:53 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com
Subject: [PATCH] drm/msm/dpu: removed logically dead code
Date:   Fri,  3 Dec 2021 21:18:46 +0500
Message-Id: <20211203161846.37720-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coverity warning by removing the dead code

Addresses-Coverity: 1494147 ("Logically dead code")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 185379b18572..75f0c0cee661 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -751,8 +751,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
 
 fail:
 	DPU_ERROR("failed to create encoder\n");
-	if (phys_enc)
-		dpu_encoder_phys_vid_destroy(phys_enc);
 
 	return ERR_PTR(ret);
 }
-- 
2.25.1

