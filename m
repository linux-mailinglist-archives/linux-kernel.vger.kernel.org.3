Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A34A38D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356039AbiA3T5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:57:06 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36433 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356037AbiA3T47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643572620; x=1675108620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ui9GKFPyYNMmLF3gc89ulR+KCxxezwdSgNx0bwlIGyk=;
  b=snbYAlXd/X1IVRnS06+lfZ+jWD7OlBvy4gTKf6owV3y6bCrqiKPgFD62
   A/Yyd8YzLh0F23jxgzf1J6aIt6ChusoZW98FAuVZ/ha+N5jYc3mai6ytm
   ZuXnrY/NUbCHqPomVlfFlQUzlntHChQP6up/tIn3vnX6vWQQ5UCAjgehc
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Jan 2022 11:56:59 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Jan 2022 11:56:58 -0800
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg02-blr.qualcomm.com with ESMTP; 31 Jan 2022 01:26:31 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 3805421AD1; Mon, 31 Jan 2022 01:26:30 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: [v4 1/3] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Date:   Mon, 31 Jan 2022 01:26:24 +0530
Message-Id: <1643572586-21331-2-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643572586-21331-1-git-send-email-quic_rajeevny@quicinc.com>
References: <1643572586-21331-1-git-send-email-quic_rajeevny@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases, the default values of DSI PHY tuning registers should be
sufficient as they are fully optimized. However, in some cases where
extreme board parasitics cause the eye shape to degrade, the override
bits can be used to improve the signal quality.

The general guidelines for DSI PHY tuning include:
- High and moderate data rates may benefit from the drive strength and
  drive level tuning.
- Drive strength tuning will affect the output impedance and may be used
  for matching optimization.
- Drive level tuning will affect the output levels without affecting the
  impedance.

The clock and data lanes have a calibration circuitry feature. The drive
strength tuning can be done by adjusting rescode offset for hstop/hsbot,
and the drive level tuning can be done by adjusting the LDO output level
for the HSTX drive.

Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
---

Changes in v2:
 - More details in the commit text (Stephen Boyd)
 - Use human understandable values (Stephen Boyd, Dmitry Baryshkov)
 - Do not take values that are going to be unused (Dmitry Baryshkov)

Changes in v3:
 - Use "qcom," prefix (Dmitry Baryshkov)
 - Remove encoding from phy-drive-ldo-level (Dmitry Baryshkov)
 - Use negative values instead of two's complement (Dmitry, Rob Herring)

Changes in v4:
 - Fix dt_binding_check error (Rob Herring's bot)

 .../bindings/display/msm/dsi-phy-10nm.yaml         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
index 4399715..2d5a766 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
@@ -35,6 +35,38 @@ properties:
       Connected to DSI0_MIPI_DSI_PLL_VDDA0P9 pin for sc7180 target and
       connected to VDDA_MIPI_DSI_0_PLL_0P9 pin for sdm845 target
 
+  qcom,phy-rescode-offset-top:
+    $ref: /schemas/types.yaml#/definitions/int8-array
+    minItems: 5
+    maxItems: 5
+    description:
+      Integer array of offset for pull-up legs rescode for all five lanes.
+      To offset the drive strength from the calibrated value in an increasing
+      manner, -32 is the weakest and +31 is the strongest.
+    items:
+      minimum: -32
+      maximum: 31
+
+  qcom,phy-rescode-offset-bot:
+    $ref: /schemas/types.yaml#/definitions/int8-array
+    minItems: 5
+    maxItems: 5
+    description:
+      Integer array of offset for pull-down legs rescode for all five lanes.
+      To offset the drive strength from the calibrated value in a decreasing
+      manner, -32 is the weakest and +31 is the strongest.
+    items:
+      minimum: -32
+      maximum: 31
+
+  qcom,phy-drive-ldo-level:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      The PHY LDO has an amplitude tuning feature to adjust the LDO output
+      for the HSTX drive. Use supported levels (mV) to offset the drive level
+      from the default value.
+    enum: [ 375, 400, 425, 450, 475, 500 ]
+
 required:
   - compatible
   - reg
@@ -64,5 +96,9 @@ examples:
          clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
                   <&rpmhcc RPMH_CXO_CLK>;
          clock-names = "iface", "ref";
+
+         qcom,phy-rescode-offset-top = /bits/ 8 <0 0 0 0 0>;
+         qcom,phy-rescode-offset-bot = /bits/ 8 <0 0 0 0 0>;
+         qcom,phy-drive-ldo-level = <400>;
      };
 ...
-- 
2.7.4

