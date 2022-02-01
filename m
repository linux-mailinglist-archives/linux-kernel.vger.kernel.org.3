Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78B4A5D91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiBANlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:41:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37886 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiBANlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:41:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3267D6158F;
        Tue,  1 Feb 2022 13:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952BAC340EF;
        Tue,  1 Feb 2022 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643722881;
        bh=3KnlN7Y/hTEj9hATfxPZBzN00tZd7SwEaNHJNcOww7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAPxW1dubcrklO42+HmigoPO59fr3vE444AIRqWA2VbkFPrmN3iyEjQiGFh6SHyIF
         S32b75lBdjJK1SxJ940c8OV61VmXaBDaYVu918aALbJ1+7dJLg0lgly+xESOI5V8VG
         w+hz6kZ2eLdQA+xKCFCkIpOgEa0NaUC73Ywulx9YmOmtDkUciMuJk9g5m3Rp4U5NpV
         l/wiwt4w1iQ4gG/OLfsMBlwKGBLfwtCRuzXHfwMSlgnS51P/xhOF0xzPiOqvqim6CJ
         gL9dFeJtSuWqxj7omM9LPv/7dNrVj9+WwyNENCZeYkv/CfDHufJ7agxbz+SvtdxEY8
         YmHXxZk4BAcNg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: spmi: Add qcom,bus-id
Date:   Tue,  1 Feb 2022 19:11:07 +0530
Message-Id: <20220201134108.2677578-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201134108.2677578-1-vkoul@kernel.org>
References: <20220201134108.2677578-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC arbiter version 7 and beyond we need to define if we are using
primary or secondary bus, so add a new property of qcom,bus-id

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index 55d379c85fd9..cf17301fbb62 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -85,6 +85,14 @@ properties:
     description: >
       which of the PMIC Arb provided channels to use for accesses
 
+  qcom,bus-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+    description: >
+      SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
+      Supported values, 0 = primary bus, 1 = secondary bus
+
 required:
   - compatible
   - reg-names
@@ -116,5 +124,8 @@ examples:
 
         interrupt-controller;
         #interrupt-cells = <4>;
+
+        qcom,bus-id = <0>;
+
     };
 
-- 
2.31.1

