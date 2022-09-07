Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF05B0E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIGUuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiIGUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:49:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953940544
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:49:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso150674pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9GZb9CRFPhxp9tscSggmlKolydoK7KEFJypG3qPCQT4=;
        b=tszoHT44RlM+zRsz3gdj4l3lxPj37/tivKl1gftfZYM71iXmWTI2fP+q73kWeCVbp1
         bTc2AZuz0sOKt9DMej/uQeOaOcipQSItiyPH9T7GFGCQkmumJpUAu16Y3qLP12QEaEUT
         hI8enOT8wValRxC7iAlNVa7eh4ofSdtw3R8MhdNisnA3XNW+laTsbaA3+1bisyVzcStc
         8xu9B6M+uGVCSWli8jr520BG5Pkhg0dcppbEQYRtoS6cohQZCAFH2GUrhz9QGWPtnYj8
         zAlunQhX4jRxPrrNESdeAre/fdrS0xpTYUuCC91xNwC9HzAiiYk0yzR2z0wfOhSOHWMN
         9ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9GZb9CRFPhxp9tscSggmlKolydoK7KEFJypG3qPCQT4=;
        b=yTg6P14cR3SJbk7nQ3RIkTvTLv8D21H4dgjjWsOdjdQtP0WkCRBtM46YTF9xXG1iti
         1c9OYKegt9QfADD0Sxd9IX0gd8equsiejurf+lPMCJqXcmW+XQIxOR+VK22oDF2myO+h
         tsSBQF7OdXBQ3A3npDc7Fxa4gTD4iZ5PJoilmSSfLfsd/xZNBFxc03AuKskQP7Oz4bDU
         E6Chef7XNfH/SISTuLvLDwieQhW9Rk5EXyvl2CzVhCSKExwGw5jOXLM/tdwxA5Xl3e5G
         SVfhl+SqteMJYNvYzQS2V3OCRFdLOruzoXiTMaIkQSONFa+4yU0S3I60j2FHqo302VkF
         XKUA==
X-Gm-Message-State: ACgBeo34J/8LRTSgNExdGRJq4m4OtxS9YI3+kvxbqmlpU4SruL+favW8
        D0iLWd48L3sp7WD1TC83iQ9yww==
X-Google-Smtp-Source: AA6agR5j70Jbhx0EjLhsyRaf4aRZseNE3kvGEZkZhmZ8bTfPbJcdAmpM90DukHtEZHRD8PjLoz+QHg==
X-Received: by 2002:a17:902:e40c:b0:176:9543:883 with SMTP id m12-20020a170902e40c00b0017695430883mr5764108ple.169.1662583795724;
        Wed, 07 Sep 2022 13:49:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001712c008f99sm12795140plh.11.2022.09.07.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:49:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 4/4] dt-bindings: net: snps,dwmac: Update interrupt-names
Date:   Thu,  8 Sep 2022 02:19:24 +0530
Message-Id: <20220907204924.2040384-5-bhupesh.sharma@linaro.org>
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

As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
interrupt error msg") noted, not every stmmac based platform
makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.

So, update the 'interrupt-names' inside 'snps,dwmac' YAML
bindings to reflect the same.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index f89ca308d55f..4d7fe4ee3d87 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -105,10 +105,12 @@ properties:
 
   interrupt-names:
     minItems: 1
-    items:
-      - const: macirq
-      - const: eth_wake_irq
-      - const: eth_lpi
+    maxItems: 3
+    contains:
+      enum:
+        - macirq
+        - eth_wake_irq
+        - eth_lpi
 
   clocks:
     minItems: 1
-- 
2.37.1

