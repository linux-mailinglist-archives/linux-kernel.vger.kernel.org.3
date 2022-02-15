Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD54B621C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiBOEbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:31:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiBOEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:31:52 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C01C135
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:31:43 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso21815196oop.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7WsWCRqMLz25vENb3RcLmuP7khzK1rVK0lqIZnKd40=;
        b=qErQvLRHn4lNi32tmw38jEAFNYywB5rAnIRozMJp3Wu3QmiUz3kavqhSmwRx+OyGdY
         LtFC0T6uamzGnphHeZAlx2E1u/X08Qdv0rSQVmPBMCw/bxC7HPu1UmcuD1XhaM4JDvYX
         I4bDSc2FY1CS/fmpYAxzwSHegdZOpTn3+JHe4HYhGhAAJvYYWrMeR1jB2KswbOlvhXRY
         vcBCpFE2SKQZI0N3AJjoxA/7iO58Xne2M4Qub/qxrwYEplfa7J2L9DwvSjOrBF9h5Knq
         N7E5+9wOTrS8FWn7D59QuP6De+aGmzBjM7fKCSdus9AG6+5zH9nefOBQushQwXNqnQi9
         6HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7WsWCRqMLz25vENb3RcLmuP7khzK1rVK0lqIZnKd40=;
        b=mZSN0V4j1S9YCCmIVfR84sJ9bsJeggRQ+UzLbSwcmERG1IRMfqQB0J9h6ZgWYMLcig
         TweM9kiQ5u55ls39hVxG5OSDnH1FLwuqDkzCod/0JCIpAxmsbye6Xga1fb7SGFVMM0wX
         7trmvY0qvLktGyaR9zJaM+EFzDn+FU/O81E02fU8DIiDgium/75Ms5+FXbg7Ps02sNRR
         Rz9LTyH7lMZb+bz7n9VPVMdXmFt0y/Kiquon3J2UKMKT6B7M2w0Cb1wCROOQwPTwdLnA
         TeRtt+u+Jppb5Qg4DGKFGdLijENJkRxUucDE5J6mZ0H7jC0GEoDLYA20/B6pA9Z0tO0f
         X58Q==
X-Gm-Message-State: AOAM530Zbhg6N6347aIIS8av44BvfhdLUHWN2q3nKJM8fDQlebPjQ77u
        g7MpSgR2/m6rIh+CwcjpCWdVVw==
X-Google-Smtp-Source: ABdhPJxYZ98hSXj39qS4Lid82RoCU1bJQMN1rQR1NrXEQZ6QwcOrw3ie1V58t9SRMlck6xKqEZOWcw==
X-Received: by 2002:a05:6870:6296:: with SMTP id s22mr800654oan.338.1644899502683;
        Mon, 14 Feb 2022 20:31:42 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id z4sm12926964otu.24.2022.02.14.20.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 20:31:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/dpu: Add INTF_5 interrupts
Date:   Mon, 14 Feb 2022 20:33:52 -0800
Message-Id: <20220215043353.1256754-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8180x has the eDP controller wired up to INTF_5, so add the interrupt
register block for this interface to the list.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 6 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index a77a5eaa78ad..dd2161e7bdb6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -23,6 +23,7 @@
 #define MDP_INTF_2_OFF			0x6B000
 #define MDP_INTF_3_OFF			0x6B800
 #define MDP_INTF_4_OFF			0x6C000
+#define MDP_INTF_5_OFF			0x6C800
 #define MDP_AD4_0_OFF			0x7C000
 #define MDP_AD4_1_OFF			0x7D000
 #define MDP_AD4_INTR_EN_OFF		0x41c
@@ -93,6 +94,11 @@ static const struct dpu_intr_reg dpu_intr_set[] = {
 		MDP_INTF_4_OFF+INTF_INTR_EN,
 		MDP_INTF_4_OFF+INTF_INTR_STATUS
 	},
+	{
+		MDP_INTF_5_OFF+INTF_INTR_CLEAR,
+		MDP_INTF_5_OFF+INTF_INTR_EN,
+		MDP_INTF_5_OFF+INTF_INTR_STATUS
+	},
 	{
 		MDP_AD4_0_OFF + MDP_AD4_INTR_CLEAR_OFF,
 		MDP_AD4_0_OFF + MDP_AD4_INTR_EN_OFF,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 1ab75cccd145..37379966d8ec 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -22,6 +22,7 @@ enum dpu_hw_intr_reg {
 	MDP_INTF2_INTR,
 	MDP_INTF3_INTR,
 	MDP_INTF4_INTR,
+	MDP_INTF5_INTR,
 	MDP_AD4_0_INTR,
 	MDP_AD4_1_INTR,
 	MDP_INTF0_7xxx_INTR,
-- 
2.33.1

