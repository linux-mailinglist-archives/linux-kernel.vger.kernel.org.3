Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD548414F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiADL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:59:49 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:21895 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiADL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641297586; x=1672833586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lVRrgO3/VD/GMvGs6tBkbU/ERogIdO6bugaqEJVG5F8=;
  b=uXGg2Q4bfoR0rpfhac7ZiYcyHDWtuUYFaSh+GQjdFdewdbuZQo2Bahzf
   AqiI/PXEiotMaeu3Rhz4yiPwMaG34b6sT2dkY8XOH+g4nhd4G7s8i8z9q
   g8ydzHl3rTHtbzXDBQ/AoKTj7SehgmFyVQ97+eC8u0sFSJU79GFzSp+G1
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Jan 2022 03:59:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:59:45 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:44 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:39 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 2/7] dt-bindings: connector: Add property for EUD type-C connector
Date:   Tue, 4 Jan 2022 17:28:15 +0530
Message-ID: <8194777786be70073a5364fe45ba7ec684019a71.1641288286.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641288286.git.quic_schowdhu@quicinc.com>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the property for EUD(Embedded USB Debugger) connector. EUD
is a mini usb hub with debug and trace capabilities and it has a
type C connector attached to it for role-switching. This connector
is attached to EUD via port.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7eb8659..417d39a 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -30,6 +30,10 @@ properties:
           - const: samsung,usb-connector-11pin
           - const: usb-b-connector
 
+      - items:
+          - const: qcom,usb-connector-eud
+          - const: usb-c-connector
+
   label:
     description: Symbolic name for the connector.
 
@@ -179,7 +183,8 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description: High Speed (HS), present in all connectors.
+        description: High Speed (HS), present in all connectors. Also used as a
+                     port to connect QCOM Embedded USB Debugger(EUD).
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
-- 
2.7.4

