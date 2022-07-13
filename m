Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F75738F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiGMOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiGMOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:34:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01D357E1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:34:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3994741pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EojiiqnaR1Vv9soFAihFtCV+EF4ew9tNYkxtmv1eok=;
        b=yF01ur2I88yDa32mCYv4eenhFmUAzs9Y5pELgNgyAZI7lHRy1yd0lpdl31fiViswHU
         ZouLyEyPQuRqG0TRkC6nao2r/n4qG0AgC7d+Elq711xNGqlF/G8rfVi5ZgJG3/wREA8j
         W+36NFgQrPayuMmnK816i+J/8qmDDT3XlgpnyF5nL7JxYsPwQQPAgGYmZR6vOQvVDlwX
         mD3nqeQvVtlLcETnbUsYmbklEMBnyPmH/reXSf/BZFpCXZUwru/Onf5sR72wKcr0w+Ns
         KhKLfyc8x7LH+YNyszuaiO83rF71CeA5/oQl256IQq/c/MQY7mg+UzdinOfCj2x9IoNH
         ax3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EojiiqnaR1Vv9soFAihFtCV+EF4ew9tNYkxtmv1eok=;
        b=tu+X2otggA+rURWQnIPVTz2hI3R0iApmfwYa0I8fkm23XQxVaJTqHrrDJfpfckuFt3
         tbXmqW/+AwIrYciD+lgWnbW/k0BNRrhstb2VYdDWplb7xh7IRIp6SmRUhtBu9GPCY9r1
         7Z3vM3NBeehb7L52AJS8wWMUn25pmjNXZwLjaolJYNWN0JPFFXh/eO5EpUyrUvwIlebF
         gpK8Z+7a/qU2uL8ZaVXgE/7eXsq/34yjGCBar3Uiu7vpic+mJ+beo0mGrhtUYyfWtOaB
         XgpojxbTyAtts/HOxVOFgU3Sc4E9LHFo4eiS+jhH5xupSHvHQDVkpQlnkfakl/lPime5
         1S2g==
X-Gm-Message-State: AJIora902Y9AYgfRcKx149ffwv1sbbMK1Wx/KuDRWMtTavQQHTDpMrrq
        tdOoCXhGJl0ro3JzNob89oL8
X-Google-Smtp-Source: AGRyM1t+5vdlca/j5x85wtZOkOXyR6Zw1Jdx14KpG1VbIXcgYR/E5OG0uRpCCrwYLmM4Mrqv86DE+Q==
X-Received: by 2002:a17:903:32c3:b0:16b:fbc3:3269 with SMTP id i3-20020a17090332c300b0016bfbc33269mr3808418plr.117.1657722890168;
        Wed, 13 Jul 2022 07:34:50 -0700 (PDT)
Received: from localhost.localdomain ([117.248.1.226])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b001620960f1dfsm8977872pll.198.2022.07.13.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:34:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
Date:   Wed, 13 Jul 2022 20:04:29 +0530
Message-Id: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

PPI interrupt should be 7 for the PMU.

Cc: Johan Hovold <johan+linaro@kernel.org>
Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Reported-by: Steve Capper <Steve.Capper@arm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 268ab423577a..2d7823cb783c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -477,7 +477,7 @@ memory@80000000 {
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
-		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	psci {
-- 
2.25.1

