Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63164A4D19
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380976AbiAaRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:25:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60034 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380909AbiAaRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:25:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36582B82B94;
        Mon, 31 Jan 2022 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4EDC340EE;
        Mon, 31 Jan 2022 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643649906;
        bh=OewE5JbYneEYqVbwKE8LUSsySUFFmPDwcDvIUETecjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhOdOdUGTTpMKPdSmzMnAxR7Eet2GJJ7ftucoDzI5Wr5kk+8Y7vfrUsHeCd71H60n
         ILipdghogWpb4wwv9Kw6QdYY9z5tybooh7maJZct/9oAKeDoSEZ8V+ztqSr6O1a74r
         LPD90pbNWwigWVerD1xYAL0WmhoR5DIb7nAgDEKAgMCnKW1crQLApmPzDOL3IfUjlT
         UlVaxDux6/iatX05p8i9qsz8J/z9FDlyQbj+sBUwk/gWFPl+wqiefUGcqa0FPMrYtP
         ot/GlyBWxh8NO2nBVj6gr3f6qnPAYt3ZJf8FK4QFLf34ZjXjV2LTTfpC5wV2GA/mRY
         TePGb0SXKyxUQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: spmi: Add qcom,bus-id
Date:   Mon, 31 Jan 2022 22:54:49 +0530
Message-Id: <20220131172450.2528065-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131172450.2528065-1-vkoul@kernel.org>
References: <20220131172450.2528065-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC arbiter version 7 and beyond we need to define if we are using
primary or secondary bus, so add a new property of qcom,bus-id

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index 0c094a03fb10..958ecc306fa9 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -67,6 +67,13 @@ properties:
       PMIC Arb which provides channels to use for accesses. Valid values 0 to 5
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  qcom,bus-id:
+    description: |
+      SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
+      Supported values, 0 = primary bus, 1 = secondary bus
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+
 required:
   - compatible
   - reg
@@ -106,6 +113,8 @@ examples:
         qcom,ee = <0>;
         qcom,channel = <0>;
 
+        qcom,bus-id = <0>;
+
         pmic@0 {
           reg = <0 0>;
           /* pmic properties */
-- 
2.31.1

