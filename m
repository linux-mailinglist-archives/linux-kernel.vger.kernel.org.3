Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5541649A3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2369024AbiAYAAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:00:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:43529 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1847818AbiAXXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643066443; x=1674602443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2wr8SGhJDgwc1rii8kTEvDvFvWDeC6rw0Za8FEAfY5c=;
  b=wuMn6jikAHoC7ajV0Pyy/XREitzsoptc7LFzBcune5vw8ZGU9IrMRwQd
   tzaqKjAQNqF8050A0hNdlB0zjQIZJR+Faue8wF3MUfraheNPIkmTykAif
   4Bs3cjel+hKbsD2N9MCxeKHNROmrYGr33kNIK7l32ZSQ+ek9ZR9M/GOLS
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jan 2022 15:20:42 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 15:20:42 -0800
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 15:20:41 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <devicetree@vger.kernel.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>
Subject: [RESEND PATCH 1/2] dt-bindings: firmware: arm,scmi: define support for name based regulators
Date:   Mon, 24 Jan 2022 15:20:01 -0800
Message-ID: <2d78b0f19991f8028d9be913be0a5aefd7d1ee17.1639099631.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1639099631.git.quic_collinsd@quicinc.com>
References: <cover.1639099631.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow SCMI regulator subnodes to be specified either by ID using
the "reg" property or by name using the "regulator-name" property.

Name based SCMI regulator specification helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..bc4a84fe25d2 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -155,7 +155,7 @@ properties:
           The list of all regulators provided by this SCMI controller.
 
         patternProperties:
-          '^regulators@[0-9a-f]+$':
+          '^regulator.+$':
             type: object
             $ref: "../regulator/regulator.yaml#"
 
@@ -164,8 +164,13 @@ properties:
                 maxItems: 1
                 description: Identifier for the voltage regulator.
 
-            required:
-              - reg
+              regulator-name: true
+
+            anyOf:
+              - required:
+                  - reg
+              - required:
+                  - regulator-name
 
 additionalProperties: false
 
-- 
2.17.1

