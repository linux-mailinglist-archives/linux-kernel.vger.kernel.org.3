Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BB4BA0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiBQNNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:13:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBQNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5342929E956;
        Thu, 17 Feb 2022 05:13:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DDCC1515;
        Thu, 17 Feb 2022 05:13:00 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362F03F66F;
        Thu, 17 Feb 2022 05:12:58 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 4/8] dt-bindings: firmware: arm,scmi: Add atomic-threshold-us optional property
Date:   Thu, 17 Feb 2022 13:12:30 +0000
Message-Id: <20220217131234.50328-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217131234.50328-1-cristian.marussi@arm.com>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v4 --> v5:
- fixed example and removed dtschema warnings/errors :
  arm,scmi.yaml: properties:atomic-threshold-us:
  	'$ref' should not be valid under {'const': '$ref'}
- added default: 0 clause
v3 --> v4
- renamed property to atomic-threshold-us
v1 --> v2
- rephrased the property description
---
 .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index eae15df36eef..590743883802 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -81,6 +81,14 @@ properties:
   '#size-cells':
     const: 0
 
+  atomic-threshold-us:
+    description:
+      An optional time value, expressed in microseconds, representing, on this
+      platform, the threshold above which any SCMI command, advertised to have
+      an higher-than-threshold execution latency, should not be considered for
+      atomic mode of operation, even if requested.
+    default: 0
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -264,6 +272,8 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            atomic-threshold-us = <10000>;
+
             scmi_devpd: protocol@11 {
                 reg = <0x11>;
                 #power-domain-cells = <1>;
-- 
2.17.1

