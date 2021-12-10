Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1735D46F8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhLJB6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:58:53 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6689 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232822AbhLJB6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639101314; x=1670637314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RcDUI0O2vEznTQ0sfknLbOncw+pzz8jl9FF8nIbdcf0=;
  b=zX2oJMOMMgaUvh9Ee5c5FcZRsA7Y3jV98hNk2fxjZJish66h3d4yxFrS
   4eZu9YRBSX+6FscJ7yF3YvpxOLxOFq24mBNTf+Ods00u5Y2CoSNpQd/Au
   l6Wm9vHHkaXOWRnQSc6O1XrBc/lgLCE7xCNKKFGEkBeozyI+PjPhFVjWM
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Dec 2021 17:55:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:55:13 -0800
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 17:55:13 -0800
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
Subject: [PATCH 1/2] dt-bindings: firmware: arm,scmi: define support for name based regulators
Date:   Thu, 9 Dec 2021 17:54:41 -0800
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

