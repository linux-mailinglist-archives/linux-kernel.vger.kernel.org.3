Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53D64CAFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbiCBUby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbiCBUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:31:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F8CE924
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:31:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p17so2569316plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g11sci1g7elBgDqwDkIww3iURlfsGrxIIuaKlSKDbrU=;
        b=Rw3jcqSZCZ1vmJXAdgh/+bwdTkwGr9/04ntUuK/sbNkA55vJpVp5VBOj3qoKrcNCtb
         6cwILjxtxfZCX36e3R9ifjIPNhZVQhq6uChZDHdPncGbxVecDSvG3/GoTC38muQ9jE50
         AovKrawIGHmB5Wx8KZzo+rFN/r/tbbFuH1WWqf+2NBHHzCOu/bbuT12fvVbsMOfqXWHu
         al2uF1+O8zpJt6a+pF4KW+diM+9QH6GZkXzn2XjHCjFQY4R4eP72Lz3vuV7e0raoe09F
         1XkjaA/x9IVfhXs8rASx7mJGh/YTZTwH7RkI3YboV1JTSJAO9Ze+D1JbFEHuSK1x/BbD
         KbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g11sci1g7elBgDqwDkIww3iURlfsGrxIIuaKlSKDbrU=;
        b=se2q61MTg8KMMHTrB37Yq6qAnNUQqAlsAA8x/i01OCrkuntipGqQX1x1iE7Z2lPQ8D
         n2g1Nq2Vndo5+fCwFhXBmZatCQakLanCGGjbVwIAY2VOec90E8Ek6Z0E6ouVjzCMXkaN
         mk2/GDJp+UZ5LezxgGmiFk92dHZYHWc1PYSdV2CQQPFPQRQLXHL+ArnCXnfqA/tD07KZ
         wBUYpaemKQeUhgi2qegmegaUCY9Vw2A/ZrF1DJTrhaRHvfzXJ8H8IOJNQlgknZifSzRo
         wRQfQoF3+lrFLqcJlZAutxJRbkXRJZlNtsIGNugN7g8/22LJVy1IWagLZPRfjqnfAjnu
         xv3w==
X-Gm-Message-State: AOAM531tFqD+NIxpb7sAgXzjtyl325xVnX10BP+EA1PNoqhsFFUnYVU2
        inAmyfMIG4CzBGcqEPYW8xvbkQ==
X-Google-Smtp-Source: ABdhPJyhjo4ntKrVS36JVnPPurPWA7B4mWW7sqgCoPxfKzyHqFGRQiUlyHUBokTrfvUDLiDHQ5E0gQ==
X-Received: by 2002:a17:903:250:b0:151:6aef:b562 with SMTP id j16-20020a170903025000b001516aefb562mr16877585plh.30.1646253063011;
        Wed, 02 Mar 2022 12:31:03 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm5963410pjq.17.2022.03.02.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:31:02 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
Date:   Thu,  3 Mar 2022 02:00:39 +0530
Message-Id: <20220302203045.184500-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
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

Document the PCIe DT bindings for SM8150 SoC. The PCIe IP is similar to
the one used on SM8250.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index a0ae024c2d0c..a023f97daf84 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -14,6 +14,7 @@
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8150" for sm8150
 			- "qcom,pcie-sm8250" for sm8250
 			- "qcom,pcie-ipq6018" for ipq6018
 
@@ -157,7 +158,7 @@
 			- "pipe"	PIPE clock
 
 - clock-names:
-	Usage: required for sc8180x and sm8250
+	Usage: required for sc8180x, sm8150 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -246,7 +247,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845 and sm8250
+	Usage: required for sc8180x, sdm845, sm8150 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.35.1

