Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726EC4CABCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiCBRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbiCBRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:30:23 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 9AA844BFE9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:29:01 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646242143; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9IwJD0ho4XLFneomGpeCLkp9yYmW0+WPE/5HI1ZoIcY=; b=HJHyeF3rjiCsFvAZ8XDAMyXyIhvHSRb95aPNaFDzk0PXhb0A0wNcAX0kRIAFOASvkFxO5vGF
 Udhx0v7Il/tf5QTXUajhl0/QVu5ppcZ11tUz7/iUADLew3NnmNtMi7obwbKmaXlH9pgi/sxW
 GlJyobmPdCgi93QxYlpeQCTGHZg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 621fa93ee1c212bb9c1fd1ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Mar 2022 17:28:30
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFA51C4363B; Wed,  2 Mar 2022 17:28:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0DAAC4361A;
        Wed,  2 Mar 2022 17:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E0DAAC4361A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] drm/msm/adreno: Retry on gpu resume failure
Date:   Wed,  2 Mar 2022 22:57:33 +0530
Message-Id: <20220302225551.v1.7.I55e39e28375b64455d1605f67453d5e91b0c2710@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retry infinitely on resume failure because there is nothing much we can
do if GPU is not ON. Also, this helps us to avoid checking for the
return value of pm_runtime_get() to see if GPU is ON.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 89cfd84..abcc553 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -603,8 +603,16 @@ static const struct of_device_id dt_match[] = {
 static int adreno_resume(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
+	int ret;
+
+	/* What hope do we have for the future if we can't turn ON gpu */
+	while (true) {
+		ret = gpu->funcs->pm_resume(gpu);
+		if (!ret)
+			break;
+	}
 
-	return gpu->funcs->pm_resume(gpu);
+	return 0;
 }
 
 static int active_submits(struct msm_gpu *gpu)
-- 
2.7.4

