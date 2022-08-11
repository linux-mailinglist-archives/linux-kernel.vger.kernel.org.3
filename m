Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A458FAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiHKKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiHKKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:51:09 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E972865;
        Thu, 11 Aug 2022 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1660215046; bh=7lbOrkLQlaL+wxUcC+lxwAVImAth8xZxU/409rDiSVs=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=Em+tth42/Zjv6d3r4OMWZ2mbxuwo0T7ltvUQRrkYFncsgdVhcaYxIHrvZzfIteyXH
         pFEypFyx/WPG68MtBM5gJPK+uXVk9jx2meXmpzw8pScRLTIc79nFG5dTQzLGH4Wpx5
         WSNqhHTbglOuKQHNITpW4KEvajiL/HdCQ2Hlt5nw=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Thu, 11 Aug 2022 12:50:46 +0200 (CEST)
X-EA-Auth: ys8Oz4QKJY8y4I9vMX0BnGYNqpB4Bgz5fVr4ItE8ABwGrI0ruDmLcwR66klTEEftfDfxaz+BzKHoX6ladLXvrQ8lDecHG0zGh7EJlGriM38=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH] thermal: qcom: tsens-v0_1: Fix MSM8939 fourth sensor hw_id
Date:   Thu, 11 Aug 2022 12:50:14 +0200
Message-Id: <20220811105014.7194-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading temperature from this sensor fails with 'Invalid argument'.

Looking at old vendor dts [1], its hw_id should be 3 instead of 4.
Change this hw_id accordingly.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/master/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L511

Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
Fixes reading GPU temperature on msm8939 idol3 with current WIP dtsi
---
 drivers/thermal/qcom/tsens-v0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index f136cb350238..327f37202c69 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -604,7 +604,7 @@ static const struct tsens_ops ops_8939 = {
 struct tsens_plat_data data_8939 = {
 	.num_sensors	= 10,
 	.ops		= &ops_8939,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
 
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
-- 
2.37.1



