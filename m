Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17D50AA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392403AbiDUUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388062AbiDUUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:38:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913714D9F9;
        Thu, 21 Apr 2022 13:35:44 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1910FCC043;
        Thu, 21 Apr 2022 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650573312; bh=Wx/zCUfbsxDCv8xhISdDZZirNu+1fzyBwddjK0yGyOg=;
        h=From:To:Cc:Subject:Date;
        b=CQUxwhoVAz4cdMEfo9dta2JoY5jVEcOoXhXsXr+EnXMmkay599as3FhA4d/Zx5sZY
         5ZO/7/wOn1oxMgMwVbc87vRWZn4mEfaN38jiPb3+zUlVhdbEor4HKprwLja/gKpYfd
         Bbr2mwmKx9vVTk4tmYQ8oI3KyqMkA4naO4NVQb9s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Fix null pointer dereferences without iommu
Date:   Thu, 21 Apr 2022 22:34:53 +0200
Message-Id: <20220421203455.313523-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if 'aspace' is set before using it as it will stay null without
IOMMU, such as on msm8974.

Fixes: bc2112583a0b ("drm/msm/gpu: Track global faults per address-space")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 ++++-
 drivers/gpu/drm/msm/msm_gpu.c           | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9efc84929be0..1219f71629a5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -272,7 +272,10 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		*value = 0;
 		return 0;
 	case MSM_PARAM_FAULTS:
-		*value = gpu->global_faults + ctx->aspace->faults;
+		if (ctx->aspace)
+			*value = gpu->global_faults + ctx->aspace->faults;
+		else
+			*value = gpu->global_faults;
 		return 0;
 	case MSM_PARAM_SUSPENDS:
 		*value = gpu->suspend_count;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index faf0c242874e..58eb3e1662cb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -371,7 +371,8 @@ static void recover_worker(struct kthread_work *work)
 
 		/* Increment the fault counts */
 		submit->queue->faults++;
-		submit->aspace->faults++;
+		if (submit->aspace)
+			submit->aspace->faults++;
 
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
-- 
2.36.0

