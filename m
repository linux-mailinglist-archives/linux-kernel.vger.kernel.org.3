Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A354CABAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiCBR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiCBR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:29:06 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 5D745443DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:28:01 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646242081; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=odXa6b5fU8MQd02N9WcX5w0ikkxNFvzlNrIqygo8Kz0=; b=NZvq7tq8sMEHEZwKvCypyxrrauxB431sQ3Z/+Yc4kspoJ0+SBEXOA6eJ6X95zwAnubu/Ugk/
 qI4xVpOXjovKOBbpyZ6RzaaSaVg+v2J5vWQeQehYurxIcQNexKYeQFJf3GhOZvAQeVlGyaxk
 fQxm8WlApq5iCxIxbfi8TKQ18Tw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 621fa921ea5f8dddb54808a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Mar 2022 17:28:01
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B402C43619; Wed,  2 Mar 2022 17:28:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA49DC43617;
        Wed,  2 Mar 2022 17:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DA49DC43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] drm/msm/a6xx: Send NMI to gmu when it is hung
Date:   Wed,  2 Mar 2022 22:57:28 +0530
Message-Id: <20220302225551.v1.2.Icda301aa85f1e4367601fa9b830b3365d377e669@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While capturing gmu state, first send an NMI to gmu when it is hung.
This helps to move gmu to a safe state.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       | 37 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 14 ++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 3e325e2..f208a81 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -14,6 +14,37 @@
 #include "msm_gpu_trace.h"
 #include "msm_mmu.h"
 
+void a6xx_gmu_send_nmi(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	u32 val;
+
+	if (a6xx_gmu_gx_is_on(gmu) && a6xx_is_smmu_stalled(gpu)) {
+		DRM_DEV_ERROR(gmu->dev,
+				"Skipping GMU NMI since SMMU is stalled\n");
+	}
+
+	/* Don't retrigger NMI if gmu reset is already active */
+	val = gmu_read(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT);
+	if (val & 0xE00)
+		return;
+
+	/* Mask all interrupts from GMU first */
+	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK, 0xFFFFFFFF);
+
+	/* Trigger NMI to make gmu save it's internal state to ddr */
+	val = gmu_read(gmu, REG_A6XX_GMU_CM3_CFG);
+	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, val | BIT(9));
+
+	/* Barrier to ensure write is posted before we proceed */
+	wmb();
+
+	/* Small delay to ensure state copy is ddr is complete at GMU */
+	udelay(200);
+}
+
 static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
@@ -790,6 +821,12 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	gmu_write(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, 0);
 	gmu_write(gmu, REG_A6XX_GMU_CM3_BOOT_CONFIG, 0x02);
 
+	/*
+	 * Make sure that the NMI bit is cleared by configuring the reset value
+	 * here
+	 */
+	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
+
 	/* Write the iova of the HFI table */
 	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_ADDR, gmu->hfi.iova);
 	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_INFO, 1);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 84bd516..4228ec1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -186,5 +186,6 @@ int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
 
 bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
+void a6xx_gmu_send_nmi(struct a6xx_gmu *gmu);
 
 #endif
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 7de9d2f..09b2ff0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -964,6 +964,18 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
 	a6xx_state->nr_indexed_regs = count;
 }
 
+void a6xx_get_gmu_state(struct msm_gpu *gpu, struct a6xx_gpu_state *a6xx_state)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+
+	if (gmu->hung)
+		a6xx_gmu_send_nmi(gmu);
+
+	a6xx_get_gmu_registers(gpu, a6xx_state);
+}
+
 struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 {
 	struct a6xx_crashdumper _dumper = { 0 }, *dumper = NULL;
@@ -980,7 +992,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	/* Get the generic state from the adreno core */
 	adreno_gpu_state_get(gpu, &a6xx_state->base);
 
-	a6xx_get_gmu_registers(gpu, a6xx_state);
+	a6xx_get_gmu_state(gpu, a6xx_state);
 
 	a6xx_state->gmu_log = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.log);
 	a6xx_state->gmu_hfi = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.hfi);
-- 
2.7.4

