Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D164C5798
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiBZSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiBZSlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:41:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773B1E64FC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x11so7433719pll.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBZeyokkJ0filn5vP507j526QxesK3K0dUHppgPVykM=;
        b=B1W8mjoXyaornrojdkdADhQLc4kLAuKLxYDdM68uwF885nNGCpbe10uz++85QniEDl
         50P4etoquBx62Y1CLZBMMJuWkWok4ubBKN4+v+UmJUcagw5hj0oS8q5r/jXJBQmGWlKa
         zUVz3NE4LoTA87+EpLZ3fPdqC049w0DmNurCmDbB7ZrTnrPZ8yzdKhg524BF11Dz0QpF
         6tzoJ6xpI0wtZc6ovYa1sSp1UXWTAGRxDKzuQjQWucMFKyxBsI/F/fMLOYfBe6anHcUs
         XWB1dAp/D+RL3mLHlh7pVlm44JqQjBYh8DKRsguRrNSR16CoXon8k421akGVa555mNi2
         2Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBZeyokkJ0filn5vP507j526QxesK3K0dUHppgPVykM=;
        b=wUbSZmd8SL0jx4V10LTLDgjZ8NZCPKSsbyZM9EY3xqlZRVhgheo9/c68S8t7xKMm3P
         j/seWXSFjE/uH1hZvNBn91OSCRPRHwDiH3K1LfXoBRgCkGJ44kdREqU397N0w53r1Ws/
         YoobUoJch/qjygWJKh8tWwF3dk5piekNZdSlTP4cP9BqIK4bS5ocn4J4+g7/NmOXmZ1x
         UkviUqG7WGYvabDPK2uo/dZD8Am8aMf1TWY3IbI3g1BZAv2MlWx/RzzNdjzZLNJ9d2DW
         jzV+CrbnvYESDItDAPJR54yasDkUefwTIzAKyf4vXiOpDcznb7SILjlOUKHdsuuVB0Pq
         lSjw==
X-Gm-Message-State: AOAM5323yy9CGN1lB1+/rq4ATW6BNhU/nHU0xd1R78MyWjeuFCEC0CqV
        TnLkkMUqctwgn+/Erp0WMhrI7A==
X-Google-Smtp-Source: ABdhPJyFqtWQVGiH+rxcf0zDTLOf8QCZE7DBG08FbC3+bzWD/A2yAvBz+1Mv54Lo12yyE86WM5nT2g==
X-Received: by 2002:a17:90a:e295:b0:1bd:2c02:7b48 with SMTP id d21-20020a17090ae29500b001bd2c027b48mr1396682pjz.215.1645900853280;
        Sat, 26 Feb 2022 10:40:53 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id b187-20020a621bc4000000b004f3c8f3b560sm7049319pfb.129.2022.02.26.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:40:53 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: qcom,pdc: Add compatible for SM8150
Date:   Sun, 27 Feb 2022 00:10:25 +0530
Message-Id: <20220226184028.111566-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
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

Add the compatible string for SM8150 SoC from Qualcomm.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 98d89e53013d..bd3539644d3f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -21,6 +21,7 @@ Properties:
 		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sc7280-pdc": For SC7280
 		    - "qcom,sdm845-pdc": For SDM845
+		    - "qcom,sdm8150-pdc": For SM8150
 		    - "qcom,sdm8250-pdc": For SM8250
 		    - "qcom,sdm8350-pdc": For SM8350
 
-- 
2.35.1

