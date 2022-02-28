Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04524C6C84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiB1MbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiB1MbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:31:15 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB0874DDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:30:36 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o23so11214845pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c33H+KhNRIM+MtgBKw1JzAencmoLfjnJxvjWbztOR4M=;
        b=nfY3uJRMInYtmcvYlqJiBa0oJZDzwXCW6rYKPRYJnf0y8YQHjn9slKGL0E7jnluWVq
         9L5aYVt61ohxbKB+5MIfQCYbpEIaVZj2rQbiMWwMZVNGOWh+MBMiF8SEDOTg0DMF7FLN
         8orujb0d4ioXcVd/tyAdV6N6w4r9eAIXnBW0ET8nptJ3IACdD9/wXZEVHpnoEorjJm0k
         GRIGM2hXdETWo0580iEvja+ifU5779QIJUIQTvQE9H8CLvsHRVJoNg7OaDsMgIJbTMW8
         26XgbOPnnE9qeNErnw8+mljIxj6m2cmQextFEU9Ru4HBPCcaX0RBpSvprbKe/ocHunJv
         KZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c33H+KhNRIM+MtgBKw1JzAencmoLfjnJxvjWbztOR4M=;
        b=UR9jOuYfYbtHN8p87A2yj9fhaihcsLJ4F3pEyTtv/MdN2xWLECJaxLhH4NKzdm7rJc
         tzuAV9/7GBp4dyQsC7z8+pbsq31iSvkFylShiGF3zlqIMRvM3zMpiylBrXBoxJtR4F6n
         VPRRQVG49eczJcYIOci0w2uiqUmA244r6JrH1jy+xral1ahqcriGzVScDqjcdkxd91SV
         9x/qlKoJN+Jl0eTN7+N1o677yr3eFo52g+jRpz7OjpFfMNoHBHZHuUOVlwEU7g+VRxuI
         kPyQ6ph1HT8C1z0g00HZw1KqvnRKjB+YVUYQKWcV2FMPUyvyA/ePyBCJ6+p+OcBErIwP
         LVrg==
X-Gm-Message-State: AOAM532ZXgVBSgEDF+wyMmGHkiJRZSPQf38gv89N8xvQr4P8KYrmBbeC
        qaoYqk24O0st84yHo5wNezd2Lg==
X-Google-Smtp-Source: ABdhPJxXWDcpwY6MdTNXZkLBQ9ksngNF8tb/ZSWnHf+xwxH6L3RJQeV0pSxXKaq6fG0OVCS+H9Ms6g==
X-Received: by 2002:a05:6a00:130e:b0:4cc:3c7d:4dec with SMTP id j14-20020a056a00130e00b004cc3c7d4decmr21491088pfu.32.1646051436042;
        Mon, 28 Feb 2022 04:30:36 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b004f0e9d686dcsm13790001pfj.137.2022.02.28.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:30:35 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shawn.guo@linaro.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 1/8] dt-bindings: phy: qcom,qmp: Mark '#clock-cells' as a 'optional' property
Date:   Mon, 28 Feb 2022 18:00:12 +0530
Message-Id: <20220228123019.382037-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
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

Since '#clock-cells' is not a required property for qmp-phy(s)
(atleast in the '/' node, but is used in 'phy@' subnode),
so mark it as an optional property instead.

This fixes the following 'make dtbs_check' warning(s):

sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
  '#clock-cells' is a required property

Also, make the dt-bindings confirm to changes
already made via commit 82d61e19fccb ("arm64: dts: qcom: msm8996:
 Move '#clock-cells' to QMP PHY child node"), by moving
'#clock-cells' property from the '/' node to the 'phy@' subnode.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e417cd667997..48cd6b6171a1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -63,9 +63,6 @@ properties:
       - description: Address and length of PHY's common serdes block.
       - description: Address and length of PHY's DP_COM control block.
 
-  "#clock-cells":
-    enum: [ 1, 2 ]
-
   "#address-cells":
     enum: [ 1, 2 ]
 
@@ -109,11 +106,13 @@ patternProperties:
     description:
       Each device node of QMP phy is required to have as many child nodes as
       the number of lanes the PHY has.
+    properties:
+      "#clock-cells":
+        enum: [ 0, 1, 2 ]
 
 required:
   - compatible
   - reg
-  - "#clock-cells"
   - "#address-cells"
   - "#size-cells"
   - ranges
@@ -461,7 +460,6 @@ examples:
     usb_2_qmpphy: phy-wrapper@88eb000 {
         compatible = "qcom,sdm845-qmp-usb3-uni-phy";
         reg = <0x088eb000 0x18c>;
-        #clock-cells = <1>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0x0 0x088eb000 0x2000>;
-- 
2.35.1

