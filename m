Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E651597261
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbiHQPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiHQO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866439D112
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x9so13797069ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RKK4m4MCCq64LxUXkLOTw73ZVqUkcy/RE/8uvhmqgxo=;
        b=IY2F2WY5LulUEfMl8pnbjnodz0OLDI3eZ1AziXAjbAQWbzU6xuoVY8La3gPZU8+hmy
         lJqSEsX5OL8ohlMqNite+F665bvQG9r06vdw5rhdwNvuinaaiGPCQYrzvk+GsbyGic2d
         CUBwljTpr5pKyecn6o23E0k4vvxmazb7qX9R4ew8SBo4gZHRM3Di3lEUwrP5CiQieXka
         ZN2mPaLAZB30bZ0fypLLlxZVjI9Y6DR4Llv+b22n23s5nmmWTx70Ify3+KqHscxAoRWN
         y7AY5pEr+tLVysnr9x404gcP2TWK+2ZcRtHAf+1qsp8+vnyyAMDwCvsatXEtJMQMnidX
         9Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RKK4m4MCCq64LxUXkLOTw73ZVqUkcy/RE/8uvhmqgxo=;
        b=4/XNeRJ1md26RJwXNLotB293iQUNqOPl7/PWIZecDJkxv8YlrA9DRhMFKUzxuxUdJj
         3tNEsu8ti4R4cTlTM9Bq5yNvh0YC9q5p+3b2vJKrW2zIP6MDIgfIgN/hnoDzVwY1opKr
         zrAeqKbJOusUpoxnZ8tgQWS2RRuq0ArPQw4rirDg8zzzuUdcBXT9oF2UY3SNDqljQs05
         oSZkfdKISGw/C446A0FOkmZsRPIHok0H0oPPpoWAeljp40DcqczZOVfcH9LzuIr4N04X
         EIhSgN1DaaXFX6kkqnJodyyDCS2GQGNhWxrcm3jL2hVo9WNbf92sb2zJmCJg5Yb/Hbf0
         GRvw==
X-Gm-Message-State: ACgBeo1NFYpgNoYPhhX+EVxFaXtqcAWyASvKO60CJ3iHl5oBR3FgUbIu
        igrIc0o3XOcYWcVPFuEOVMiwog==
X-Google-Smtp-Source: AA6agR5Rt0U1dJbKg6azMFGsfw2nDfRxDbP5HL8FlqQsn4keUHJr+9tphNKS09xTJiY/ACRHSw4+Yg==
X-Received: by 2002:a2e:b8d1:0:b0:25f:f4fb:357 with SMTP id s17-20020a2eb8d1000000b0025ff4fb0357mr7813198ljp.66.1660748349215;
        Wed, 17 Aug 2022 07:59:09 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 02/17] dt-bindings: mfd: qcom,tcsr: add QCS404
Date:   Wed, 17 Aug 2022 17:58:46 +0300
Message-Id: <20220817145901.865977-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new QCS404 TCSR compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 5d7f4ac21a8d..87b173ad9710 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -18,6 +18,7 @@ properties:
     items:
       - enum:
           - qcom,msm8998-tcsr
+          - qcom,qcs404-tcsr
           - qcom,sc7180-tcsr
           - qcom,sc7280-tcsr
           - qcom,sdm845-tcsr
-- 
2.34.1

