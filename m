Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0434BEF28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiBVB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:27:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiBVB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:27:11 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AC24F2E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:26:47 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 27A8C3F5D8;
        Tue, 22 Feb 2022 02:26:45 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/msm/dpu1: Add a common DPU1 compatible
Date:   Tue, 22 Feb 2022 02:26:37 +0100
Message-Id: <20220222012638.6650-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is *almost no reason* to keep separate compatibles for different
SoCs utilizing the DPU1 driver, as it checks the HW version at runtime.

Introduce a common compatible, while not removing the old ones to keep
old DT compatibility.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Bar some very very very unlikely edge cases (such as need for some random
quick being applied to one SoC from a family that shares DPU hw rev, but
not the others, there is little to no reason to keep adding compatibles
that don't mean anything.

If this change is cool, then the question about what to do with
dt-bindings arises...

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 47fe11a84a77..335018542a3a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1348,6 +1348,9 @@ static const struct dev_pm_ops dpu_pm_ops = {
 };
 
 const struct of_device_id dpu_dt_match[] = {
+	{ .compatible = "qcom,dpu1" },
+
+	/* Legacy compatibles for old DTs */
 	{ .compatible = "qcom,sdm845-dpu", },
 	{ .compatible = "qcom,sc7180-dpu", },
 	{ .compatible = "qcom,sc7280-dpu", },
-- 
2.35.1

