Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515C4E9721
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiC1M5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiC1M46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:56:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25419E0BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:55:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i65so11233168qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+wjaE9zp8UiiJ3ll5xchHseTtAzJ2kCou17dDYzPoA=;
        b=tcx16Kj+7Cqux9mvpPivKKmgL8LuL0VEeyv7xtoKn155d3O5pQ1xM9KdQFbPq67vAu
         ncPSybCNjkrekLm+BxOjgqjGogipQmtloV8c1paAp+7GYhYuV6wCmsGykAk0FTp6Il/w
         SveZKg7ZHVBl72dE00xbC1PExj+UjXh2sEWE/3MXLhw/aMamfw35KhT50syApyCDML5H
         d2KWjYD0l7FoZFzuPTMtRxzKpj3dQESwtb/YnSuKykGxKYinz3NENxy+Xt7Er2ZZfRq1
         aWmBYOcwAkasBZD3JTKhMM9WLTWQDzMc+Sv2cWoc0BLJqX+/sYa7eWtfaYESenkXCpJ5
         gnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+wjaE9zp8UiiJ3ll5xchHseTtAzJ2kCou17dDYzPoA=;
        b=I85DYt6MGbhQF1kZMUPcyFzyHStbYZ6I+JiJpqJqnlzNjXpgCI3kxA82ftM9LCtCt9
         RLceZGNMTkBAb7UAcFDfjgLLOMt2wUMtrxuje6SRIGRFp3JEC/aCZ1/xnh/O1F80dNIw
         BzMl0Fk/pLa/QzSXSaHL6L57FadYEi++Z5/Vc4733NJgbpqSaI7C9FwMJWJ99iWLptQa
         R9wSF3uq2hjhM7er+yY380JL/hH/Pp/PbJEImWZHP/QeWbrQ26Qys38UusgPdOxwPaQO
         SqH6H2X3guekrxhBDMtm7HbNh7z7skIqCze8hmd6JK09H6Bx9MZUbisSX0kvGqBOX5Z/
         1DiA==
X-Gm-Message-State: AOAM5301dZJ+1bguBi3exwKJjKgXvaXjhUo0ypH/zHvNmsKseQ1+Catu
        xCRFYrouLS8XYPlxNJiEZNYFfQ==
X-Google-Smtp-Source: ABdhPJxc8NsbZVET0kGypEAfG6BJjXHoFiXSRAGghnfGjwEdoHpPzeLu52swAHTy2TVKfJyxc8qtoQ==
X-Received: by 2002:a37:a084:0:b0:67d:405b:60d0 with SMTP id j126-20020a37a084000000b0067d405b60d0mr15545606qke.83.1648472117315;
        Mon, 28 Mar 2022 05:55:17 -0700 (PDT)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id c10-20020ac87dca000000b002e1db1b7b10sm12441798qte.25.2022.03.28.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:55:16 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     dpiliaiev@igalia.com, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: use orig_nents to iterate over scatterlist with per-process tables
Date:   Mon, 28 Mar 2022 08:55:05 -0400
Message-Id: <20220328125505.31605-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the implementation of iommu_map_sgtable() used for the
non-per-process page tables path.

This works around the dma_map_sgtable() call (used to invalidate cache)
overwriting sgt->nents with 1 (which is probably a separate issue).

Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index bcaddbba564df..22935ef26a3a1 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -58,7 +58,7 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 	u64 addr = iova;
 	unsigned int i;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+	for_each_sg(sgt->sgl, sg, sgt->orig_nents, i) {
 		size_t size = sg->length;
 		phys_addr_t phys = sg_phys(sg);
 
-- 
2.26.1

