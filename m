Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526A44A621B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiBARQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:16:31 -0500
Received: from foss.arm.com ([217.140.110.172]:53116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240737AbiBARQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:16:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38FB1477;
        Tue,  1 Feb 2022 09:16:24 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0993F40C;
        Tue,  1 Feb 2022 09:16:22 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 5/9] dt-bindings: firmware: arm,scmi: Add atomic_threshold optional property
Date:   Tue,  1 Feb 2022 17:15:57 +0000
Message-Id: <20220201171601.53316-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201171601.53316-1-cristian.marussi@arm.com>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI protocols in the platform can optionally signal to the OSPM agent
the expected execution latency for a specific resource/operation pair.

Introduce an SCMI system wide optional property to describe a global time
threshold which can be configured on a per-platform base to determine the
opportunity, or not, for an SCMI command advertised to have a higher
latency than the threshold, to be considered for atomic operations:
high-latency SCMI synchronous commands should be preferably issued in the
usual non-atomic mode.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- rephrased the property description
---
 .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index eae15df36eef..646bdf2873b5 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -81,6 +81,15 @@ properties:
   '#size-cells':
     const: 0
 
+  atomic_threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional time value, expressed in microseconds, representing, on this
+      platform, the threshold above which any SCMI command, advertised to have
+      an higher-than-threshold execution latency, should not be considered for
+      atomic mode of operation, even if requested.
+      If left unconfigured defaults to zero.
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -264,6 +273,8 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            atomic_threshold = <10000>;
+
             scmi_devpd: protocol@11 {
                 reg = <0x11>;
                 #power-domain-cells = <1>;
-- 
2.17.1

