Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783C4CABC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiCBRag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbiCBRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:30:19 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D32A04DF54
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:29:01 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646242141; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=A/7P7csz45sM8M75vo/R3s4K0v3XOsjwI3F7niEIByg=; b=MP+lyDGKCb4BAf9vrWJEa4I9rxVKGsV7mqVcslIOBseEI6HoRchjLgd23c3P1Kd5R2otwf2T
 5+VUEi+P5g9fURKOg4GfnMG0yHxMbUKY7FEowDLI1Wsh4X/1bHskzGb+3+dWcB4C0gRA0TzJ
 wBsTq55gsXHkGUQSAWCDAbVBo4s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 621fa94dea5f8dddb548d433 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Mar 2022 17:28:45
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C686C4314F; Wed,  2 Mar 2022 17:28:45 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0A55C43637;
        Wed,  2 Mar 2022 17:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A0A55C43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/10] drm/msm/a6xx: Free gmu_debug crashstate bo
Date:   Wed,  2 Mar 2022 22:57:36 +0530
Message-Id: <20220302225551.v1.10.I94896351ce7af04c2249ced42cf1557fb2bb0d33@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free gmu_debug bo while destroying the gpu crashstate.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 4d4588a..09bb993 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1054,6 +1054,9 @@ static void a6xx_gpu_state_destroy(struct kref *kref)
 	if (a6xx_state->gmu_hfi)
 		kvfree(a6xx_state->gmu_hfi->data);
 
+	if (a6xx_state->gmu_debug)
+		kvfree(a6xx_state->gmu_debug->data);
+
 	list_for_each_entry_safe(obj, tmp, &a6xx_state->objs, node)
 		kfree(obj);
 
-- 
2.7.4

