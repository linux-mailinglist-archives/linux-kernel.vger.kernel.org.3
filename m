Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213E653C7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiFCJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiFCJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:36:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D32C66D;
        Fri,  3 Jun 2022 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654248968; x=1685784968;
  h=from:to:cc:subject:date:message-id;
  bh=rNtSLC5bGnyIBYdwXfdRCRjwAbc7RD6DLKsmw6WkyWA=;
  b=dG7AG51hvPN8D2mGW/MBFDtSUASFTOygT+PuJFFbVwfecDzJYEd2qURU
   efgQkNbCmMD8ZamDQAXHmj1zTLdhcMii40uH3e19b0aUmZSO7HQtbwGPG
   xzaHbOlXZvn+D/l9YncU1PmakJjvAPKtD3W9kP3P5gsrAwM7WLfJo+kV7
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Jun 2022 02:36:08 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jun 2022 02:36:06 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Jun 2022 15:05:53 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 0DBC73A46; Fri,  3 Jun 2022 15:05:52 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, vpolimer@quicinc.com, swboyd@chromium.org,
        kalyant@quicinc.com, dmitry.baryshkov@linaro.org
Subject: [v3] drm/msm/disp/dpu1: avoid clearing hw interrupts if hw_intr is null during drm uninit
Date:   Fri,  3 Jun 2022 15:05:50 +0530
Message-Id: <1654248950-17946-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dp modeset init is failed due to panel being not ready and
probe defers during drm bind, avoid clearing irqs and dereference
hw_intr when hw_intr is null.

BUG: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

Call trace:
 dpu_core_irq_uninstall+0x50/0xb0
 dpu_irq_uninstall+0x18/0x24
 msm_drm_uninit+0xd8/0x16c
 msm_drm_bind+0x580/0x5fc
 try_to_bring_up_master+0x168/0x1c0
 __component_add+0xb4/0x178
 component_add+0x1c/0x28
 dp_display_probe+0x38c/0x400
 platform_probe+0xb0/0xd0
 really_probe+0xcc/0x2c8
 __driver_probe_device+0xbc/0xe8
 driver_probe_device+0x48/0xf0
 __device_attach_driver+0xa0/0xc8
 bus_for_each_drv+0x8c/0xd8
 __device_attach+0xc4/0x150
 device_initial_probe+0x1c/0x28

Changes in V2:
- Update commit message and correct fixes tag.

Changes in V3:
- Misc changes in commit text.

Fixes: f25f656608e3 ("drm/msm/dpu: merge struct dpu_irq into struct dpu_hw_intr")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index c515b7c..ab28577 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -599,6 +599,9 @@ void dpu_core_irq_uninstall(struct dpu_kms *dpu_kms)
 {
 	int i;
 
+	if (!dpu_kms->hw_intr)
+		return;
+
 	pm_runtime_get_sync(&dpu_kms->pdev->dev);
 	for (i = 0; i < dpu_kms->hw_intr->total_irqs; i++)
 		if (!list_empty(&dpu_kms->hw_intr->irq_cb_tbl[i]))
-- 
2.7.4

