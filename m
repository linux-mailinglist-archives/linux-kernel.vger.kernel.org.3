Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4644956CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378257AbiATXVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378156AbiATXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53AC061574;
        Thu, 20 Jan 2022 15:20:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so17814279wme.0;
        Thu, 20 Jan 2022 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yLgKzWlNB46h4cCxcd6MlOdDX7NDwn6Xp4ylh5jriKo=;
        b=co4Wq1cm6z6LLDXS4ecPwr0XrQn6k407E/wnERm/vD4/3oIq4EChBGSf4IRoUNVqij
         YQgz4CBXnVj8Cv6iqEa60N8Ts6AXtqL2wjEpgAm+WGVkOyMLs01HGrJz+hGWCSoqyWir
         dpBV/vivTwC97ti0m5fCYw492bi4lBd7ZKE3Pa95rrvtpzPL4H6JG8p+ISZmVfjtFgEy
         jUdBIkCOtxtM3lUQ6KCOuyCJrJZ+4RjfJwzlX+XswTf9ItAeX4RytNaCnUjUOj2hyNlB
         KByEGyvoptcXIcGhld509EIjKi9AoRLoraxagqBKJfKhI2quog47x8jYAoPzkge0Y0eH
         xsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLgKzWlNB46h4cCxcd6MlOdDX7NDwn6Xp4ylh5jriKo=;
        b=WDsbjdrhqR9CH2oUgmmDFNCoE7JNNKRNxTg9wLmZrTG896iTk0YvMlHz3y9PEWQ+ed
         3DEgA+EPyEPcr5tRSOBtqHhlcDFOwbBe6cks0zMryDq4S0H1MpY0S+ZrbcpqNZcZ69RP
         b0uS3/fzdXn+5DEB0V8DRhLNS/sAJuL1Ckdb688AxSZgWMf5i5aatWVed0LyBCpeYILa
         ijrjNc2ga8nJhSL/TYcUdxdjI0ycDNlmtgI1o8PwDXXcnjjE7ZyAizweHYdB/cjrfHse
         y5Nx85sJ+W7kb7FZK2w0P4NRlTCqd6AlJkb2BG5icLBpFdt4q4rN7MxVjAKQ/7Drtur6
         /6qQ==
X-Gm-Message-State: AOAM531a6Xew7jITnIhj221xez8re8OyayUJJFjl+R/YQbyZOgshQ7Vo
        XGi6Nf9mVybjs8Ar0xEHB14=
X-Google-Smtp-Source: ABdhPJxw5KjBYGVH5hjG7osX6x9iTgxr3OjDNdhzsuvWuP5sl1NgcaP0/bxika7l56StnCbRtcAMmQ==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr1175857wrq.653.1642720833423;
        Thu, 20 Jan 2022 15:20:33 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:33 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] dt-bindings: clock: permit additionalProprieties to qcom,gcc
Date:   Fri, 21 Jan 2022 00:20:14 +0100
Message-Id: <20220120232028.6738-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To permit the use of qcom,gcc as a template for other Documentation, set
additionalProprieties to true.
While at it add the missing syscon for qcom,ipq8064 that is mandatory
for the correct function of the tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/clock/qcom,gcc.yaml   | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index f66d703bd913..3fd03687a6f7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -36,24 +36,27 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,gcc-apq8084
-      - qcom,gcc-ipq4019
-      - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
-      - qcom,gcc-mdm9607
-      - qcom,gcc-msm8226
-      - qcom,gcc-msm8660
-      - qcom,gcc-msm8916
-      - qcom,gcc-msm8939
-      - qcom,gcc-msm8953
-      - qcom,gcc-msm8960
-      - qcom,gcc-msm8974
-      - qcom,gcc-msm8974pro
-      - qcom,gcc-msm8974pro-ac
-      - qcom,gcc-mdm9615
-      - qcom,gcc-sdm630
-      - qcom,gcc-sdm660
+    oneOf:
+      - enum:
+          - qcom,gcc-apq8084
+          - qcom,gcc-ipq4019
+          - qcom,gcc-ipq6018
+          - qcom,gcc-mdm9607
+          - qcom,gcc-msm8226
+          - qcom,gcc-msm8660
+          - qcom,gcc-msm8916
+          - qcom,gcc-msm8939
+          - qcom,gcc-msm8953
+          - qcom,gcc-msm8960
+          - qcom,gcc-msm8974
+          - qcom,gcc-msm8974pro
+          - qcom,gcc-msm8974pro-ac
+          - qcom,gcc-mdm9615
+          - qcom,gcc-sdm630
+          - qcom,gcc-sdm660
+      - items:
+          - const: qcom,gcc-ipq8064
+          - const: syscon
 
   '#clock-cells':
     const: 1
@@ -78,7 +81,7 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   # Example for GCC for MSM8960:
-- 
2.33.1

