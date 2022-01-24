Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD22497CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiAXKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:21 -0500
Received: from foss.arm.com ([217.140.110.172]:56006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236971AbiAXKEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 428A0101E;
        Mon, 24 Jan 2022 02:04:10 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D9563F73B;
        Mon, 24 Jan 2022 02:04:08 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: firmware: arm,scmi: Add atomic_threshold optional property
Date:   Mon, 24 Jan 2022 10:03:37 +0000
Message-Id: <20220124100341.41191-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124100341.41191-1-cristian.marussi@arm.com>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
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
 .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index eae15df36eef..8edda54dff5b 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -81,6 +81,14 @@ properties:
   '#size-cells':
     const: 0
 
+  atomic_threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional time value, expressed in microseconds, representing the
+      threshold above which, on this platform, any SCMI command advertised to
+      have a higher execution latency, should not be used in atomic mode, even
+      if requested. If left unconfigured defaults to zero.
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -264,6 +272,8 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            atomic_threshold = <10000>;
+
             scmi_devpd: protocol@11 {
                 reg = <0x11>;
                 #power-domain-cells = <1>;
-- 
2.17.1

