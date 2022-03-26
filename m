Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184194E7F54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiCZGKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiCZGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 02:10:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A053587D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:08:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so9392658pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29ohcmk+WpMbeDVWQK/EG8Sg/hmSlIvrDXmbJsgg1AI=;
        b=B+UqxkOxdFdPEBgdSSeGzgmvxO5mOP0JYIY1EfcNmFxdiTbrcCrRmKngasA+1VSoyE
         Kgx+LAgfiouyQ3Fsfy7e0jg8WZZxut0cPwHw9wrTk00oMo4BDl+DuTIyjls4yHtyPO+L
         eWSq18/GShcaMHycr+HmzObBCcgs65+/GoqZC4/G6XYjO4uiPHZCZ5TndFjE85Eo+Tc8
         UkWM5q9psyXrmBpTJah+G2+bdPgoO5k7ICiMXz3Lj735+JNkm/ZHyPZVLZdXh1cqME3q
         3/Oo5eqrZjsOd9KWo4g+ym9D36iYzpSURkNunrLcosRu3Iybu7oIqH6OjRXxtvf1n7fd
         M/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29ohcmk+WpMbeDVWQK/EG8Sg/hmSlIvrDXmbJsgg1AI=;
        b=TUtRpcyfxviW7NRzjwoAcIKZhgMP57Q4rF1YZjIxO1zLT4FHFKAZFjmXqmxdgYpQNH
         wVB0mIV/XfOM9xh21wWsD0tN7zOLzJyAKjvEQv3Uob6Xn8wP8xDP35RmsbSLWMxMxtry
         mHVHpB4d/OGmfQm4xjZyghe/BwpAqAXc1qrAx/aDf4oAO0qI5SaMVgz4Oe91x2a3OE4w
         exsqYg7LBZVEs6kWQI3fXAJ7vMkhBmpFVwdVHqNgeuPYZKcZzjsrIIQVa7aRA1Ofh5iy
         LAagYc/sJrzpfJbSZmZokpibwRmFGZ7Q7E6QX/e44uvIXStaUCnZ7Sq4M/nNbOY4uuB6
         QoKQ==
X-Gm-Message-State: AOAM533lHOyU/287+owlIMnH+PZcYlZ/Z9VIiuk1jdCf2WOKDW81a76S
        hvOtWVTXQf9vMBLLEq9r0iKLhQ==
X-Google-Smtp-Source: ABdhPJxkIIUxA6/qud0HKlVxagcAACOtgkeJL53JKLutEFJD+2R88ZNw46KOjL1emWIlfEGBIjvowg==
X-Received: by 2002:a17:902:ce05:b0:14f:8cfa:1ace with SMTP id k5-20020a170902ce0500b0014f8cfa1acemr14974539plg.149.1648274908805;
        Fri, 25 Mar 2022 23:08:28 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a63951a000000b003826aff3e41sm6944959pgd.33.2022.03.25.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 23:08:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pci@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
Date:   Sat, 26 Mar 2022 11:38:09 +0530
Message-Id: <20220326060810.1797516-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326060810.1797516-1-bhupesh.sharma@linaro.org>
References: <20220326060810.1797516-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 0adb56d5645e..fd8b6d1912e7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -14,6 +14,7 @@
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8150" for sm8150
 			- "qcom,pcie-sm8250" for sm8250
 			- "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
 			- "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450
@@ -159,7 +160,7 @@
 			- "pipe"	PIPE clock
 
 - clock-names:
-	Usage: required for sc8180x and sm8250
+	Usage: required for sc8180x, sm8150 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -266,7 +267,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845, sm8250 and sm8450
+	Usage: required for sc8180x, sdm845, sm8150, sm8250 and sm8450
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.35.1

