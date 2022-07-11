Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA77570A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGKTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiGKTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:20:37 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25171747B5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JNV6gBlFKpE5Sku4/hH2lTFvl7x+/bQwXOO7dBTV2Qk=; b=naH+ihJXx5mGCV/kABr0P97Z7X
        AIntrUY+bEzSCb+uJroM7Vn4+hlJ8i17IJDr1jWLi5IhdUftMxg5x1zDbn5p1/5qbSvRdEgLhh9w1
        8SpaUz14ZDLI0FVwvqzuBbMLihlTkYMC2OW/vScKv/gEdEuu1zhy7zIFxd7sm69Ycfjbsm4K31SGl
        QeBCVfUK7IIgmNzz4eyDiIvpy31KHw+6ZjHWldL6zulLpvP8SKnv8gAfnUFSkfRVB1ZZVd+99GJac
        gtla2Mn9CnWE+AKARm8LeBlOuVTepMUEJwkkhv3lpB8FWV2CddVc1K546vZ/S/YJFfbJtYR6oJ7aq
        yDPBzbsA==;
Received: from [177.45.248.119] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oAyxJ-00CJom-W5; Mon, 11 Jul 2022 21:20:30 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/2] drm/amd/pm: Implement get GFXOFF status for vangogh
Date:   Mon, 11 Jul 2022 16:19:53 -0300
Message-Id: <20220711191953.145518-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191953.145518-1-andrealmeid@igalia.com>
References: <20220711191953.145518-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement function to get current GFXOFF status for vangogh.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index e2d8ac90cf36..c6aca79376b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2045,6 +2045,31 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
+/**
+ * vangogh_get_gfxoff_status - Get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
+ *
+ * Get current gfxoff status
+ *
+ * Return:
+ * * 0	- GFXOFF (default if enabled).
+ * * 1	- Transition out of GFX State.
+ * * 2	- Not in GFXOFF.
+ * * 3	- Transition into GFXOFF.
+ */
+static u32 vangogh_get_gfxoff_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	u32 reg, gfxoff_status;
+
+	reg = RREG32_SOC15(SMUIO, 0, mmSMUIO_GFX_MISC_CNTL);
+	gfxoff_status = (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
+		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
+
+	return gfxoff_status;
+}
+
 static int vangogh_get_power_limit(struct smu_context *smu,
 				   uint32_t *current_power_limit,
 				   uint32_t *default_power_limit,
@@ -2199,6 +2224,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.post_init = vangogh_post_smu_init,
 	.mode2_reset = vangogh_mode2_reset,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
+	.get_gfx_off_status = vangogh_get_gfxoff_status,
 	.get_ppt_limit = vangogh_get_ppt_limit,
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
-- 
2.37.0

