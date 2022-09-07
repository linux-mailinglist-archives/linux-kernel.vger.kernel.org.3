Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3145B0E85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIGUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIGUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:49:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4C2C666
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:49:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so163633pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pG9vduXXJoxcbtDBjh/rl5QnFLLI3poU1R252hkhCiw=;
        b=ViKPUmX/jv44vdzCbjqqUzZPlfQIrKP0rqCjaiJymn+D01Nf6rbKcb8DuLYi6lpixP
         A9eUHtUnG9p9Q/wYoBTFjzdSKhtr1ZIoCILqItm+6uxjTMVSbIebAXhu2qM4bC9pLp07
         eX9lapLA/9pUKgGdvDu6SeWiVzAjSGRYNdB+X/A1b55GvgVvGhVLephtTe55eyZ39Z4I
         BS/kDJgb8AMEtfaNMosHv6wzfZJ7+fxLUF9qgcuKdAX2a3YnzZBMNyHGOjKOrbgAsRyR
         BQFGW+iag94v0lAr5sl2qFuoeT8eRx30h+eFTwcMSJB07XBvoPNCiGpljnmotfIJWVL5
         BTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pG9vduXXJoxcbtDBjh/rl5QnFLLI3poU1R252hkhCiw=;
        b=rzIXCACQ1xAPWkZiexT3NUmAx7/HvnPqILAvOXPBQKmrzKDylPsJxsA2c7KzGQB05Z
         Bs7SSbWdDqO2538IrCTB9ytaoAWat+9wREzp/OzEYAEV0kxcSVrJJoLTnxkVrJMCC30s
         YPDCjcHbxMF1f9i4fk9XLErcBTr51IeHGkcOU1gSH9/UwYDPsoNCp1LfrtoAlcrJ0NcI
         RkD12GL3OXEJTbRGBvI8iRLmV+yCWTfLyRbSUwpZmnw9uKsZ2zvNBeZs8n2pTq+8S2Yw
         9CvApVn4Q6uoSD7so5S8AhDOtTbywhHdcSCNoWfd/eW0Y2Dp6mxYe0lifwwcHeMlx8ya
         auxg==
X-Gm-Message-State: ACgBeo1qpJ7Fh7W90+eF7QP5pn8MK0U++g4UYRSelpIT82LgAJqCLaGV
        +idQsXbwQ5IgeiVdv5Vhul266w==
X-Google-Smtp-Source: AA6agR4NIq02+jTtMGunJIa2ym0aiXKbCs3PFLOTwxM1qgznaSx3xG2HKv4NWoA6voRjzgvVLvZ6Dw==
X-Received: by 2002:a17:902:b48b:b0:176:73df:dd6f with SMTP id y11-20020a170902b48b00b0017673dfdd6fmr5690680plr.147.1662583786609;
        Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001712c008f99sm12795140plh.11.2022.09.07.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 2/4] dt-bindings: net: snps,dwmac: Add Qualcomm Ethernet ETHQOS compatibles
Date:   Thu,  8 Sep 2022 02:19:22 +0530
Message-Id: <20220907204924.2040384-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220907204924.2040384-1-bhupesh.sharma@linaro.org>
References: <20220907204924.2040384-1-bhupesh.sharma@linaro.org>
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

Add Qualcomm Ethernet ETHQOS compatible checks
in snps,dwmac YAML binding document.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2d4e7c7c230a..2b6023ce3ac1 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -65,6 +65,8 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - qcom,qcs404-ethqos
+        - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
         - renesas,rzn1-gmac
         - rockchip,px30-gmac
@@ -384,6 +386,8 @@ allOf:
               - ingenic,x1600-mac
               - ingenic,x1830-mac
               - ingenic,x2000-mac
+              - qcom,qcs404-ethqos
+              - qcom,sm8150-ethqos
               - snps,dwmac-4.00
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
-- 
2.37.1

