Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929B527DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiEPGc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiEPGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:32:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCBF28E1B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:32:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bh5so1732734plb.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnGJlvnGMiDx5UJTsjZY8cbmPSUgi63UDEbXgnLRWFI=;
        b=QHdA8yNWeLoobNesmZ6p7lpMmSdLzZ0FYpXrljyxYz590HfGgy54FuWQPNoSu8RkfT
         fxcQBt+3rypT1bV1OTvaUtgh9TBfuN8GzZso8WLwiwsFHwCykBIfbzs/eM2IJNlC+gwV
         oPDbjluvXHurap4X5jOjeT9T+V2CXgUrXB51jGMwVxH/nUZCgt85s64/MPJmtB3jwDd/
         huCSA9lh6XfLV3o12yh80LEW3vFmHJPPRQEemtQsOA46GojLIqxuQdqtnnRwT7P+O0PX
         WiTxF8nze18d/7RwM7YPNzYPS1U8HwrA3MWT+3ceJRvv3NNDNxTxcj2JuZuLAEijW1rM
         6H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnGJlvnGMiDx5UJTsjZY8cbmPSUgi63UDEbXgnLRWFI=;
        b=PpjpYxZXT2qegr1rsP4GXAR1WoWAWmCZQKVFU0et+vzP2Oir/1YOaniZ/1YaqTMtWp
         tFaAnnUsbfIcnwSzptp91j5ih+/RB+ntYQOrxTvGRRisCIUGl3C3EAIseKR6swY9v7gX
         agcqe+wJals4zSZVIOwmfwMTOsseevCjJ1TO3CmayQpqEgTcas7dN9IksFw9MWxpGWM7
         8sQUpuBtYnrVXu0L80zjOYO4osjNb521hKKm7xnM1FZ9P0LOdSdU74ZgrBqO3Lq57pDY
         /TRzwz5PtxzsnUkJs+6bXY/TzQHsCmDNhMnYf+9aYZlM6im5bb4jELRxBxhwzskXCPhr
         2kJQ==
X-Gm-Message-State: AOAM531wMqGPmAXKV6lfwIB/lfZ982CyETBfjvi4ydO7RH6seUUUNU3h
        YMDCQANpPYEJpQKjx0bzX3IZew==
X-Google-Smtp-Source: ABdhPJwRDeYx9cR3OoMIgCswNSH0r6L5bJFZWM/OpX2bEdoyy3HWvdyW19fUKUK2a5nOI2m/jrfbaw==
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id az5-20020a170902a58500b0014d58ef0065mr16394014plb.139.1652682740697;
        Sun, 15 May 2022 23:32:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b0015e8d4eb1e2sm6053647plb.44.2022.05.15.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 23:32:20 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
        konrad.dybcio@somainline.org
Subject: [PATCH v4 3/4] dt-bindings: phy: qcom,qmp: Add 'power-domains' property
Date:   Mon, 16 May 2022 12:01:54 +0530
Message-Id: <20220516063155.1332683-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516063155.1332683-1-bhupesh.sharma@linaro.org>
References: <20220516063155.1332683-1-bhupesh.sharma@linaro.org>
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

Fix the following 'make dtbs_check' error with the 'qcom,qmp-phy'
bindings:
 arch/arm64/boot/dts/qcom/sm8150-mtp.dtb: phy@1d87000:
  'power-domains' does not match any of the regexes:
   '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 60ab494df975..c5d4c8152699 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -102,6 +102,10 @@ properties:
     description:
       Phandle to a regulator supply to any specific refclk pll block.
 
+  power-domains:
+    description: Phandle to the power domain node.
+    maxItems: 1
+
 #Required nodes:
 patternProperties:
   "^phy@[0-9a-f]+$":
-- 
2.35.3

