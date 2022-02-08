Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7564ADD51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381758AbiBHPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346648AbiBHPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:45:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED2AEC0613CB;
        Tue,  8 Feb 2022 07:45:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB10412FC;
        Tue,  8 Feb 2022 07:45:15 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48BA3F73B;
        Tue,  8 Feb 2022 07:45:13 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 4/8] dt-bindings: firmware: arm,scmi: Add atomic_threshold optional property
Date:   Tue,  8 Feb 2022 15:44:48 +0000
Message-Id: <20220208154452.39428-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208154452.39428-1-cristian.marussi@arm.com>
References: <20220208154452.39428-1-cristian.marussi@arm.com>
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

