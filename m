Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05C4CA3B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiCBLaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiCBLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:30:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 581D031214;
        Wed,  2 Mar 2022 03:29:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2768A13D5;
        Wed,  2 Mar 2022 03:29:30 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E31383F70D;
        Wed,  2 Mar 2022 03:29:27 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: opp: Add "opp-microwatt" entry in the OPP
Date:   Wed,  2 Mar 2022 11:29:13 +0000
Message-Id: <20220302112917.27270-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302112917.27270-1-lukasz.luba@arm.com>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new entry for the OPP which provides information about power
expressed in micro-Watts. It is useful for the Energy Model framework.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../devicetree/bindings/opp/opp-v2-base.yaml  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 15a76bcd6d42..04a592c0f862 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -93,6 +93,21 @@ patternProperties:
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
+      opp-microwatt:
+        description: |
+          The power for the OPP in micro-Watts.
+
+          Entries for multiple regulators shall be provided in the same field
+          separated by angular brackets <>. If current values aren't required
+          for a regulator, then it shall be filled with 0. If power values
+          aren't required for any of the regulators, then this field is not
+          required. The OPP binding doesn't provide any provisions to relate the
+          values to their power supplies or the order in which the supplies need
+          to be configured and that is left for the implementation specific
+          binding.
+        minItems: 1
+        maxItems: 8   # Should be enough regulators
+
       opp-level:
         description:
           A value representing the performance level of the device.
@@ -203,6 +218,14 @@ patternProperties:
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
+      '^opp-microwatt':
+        description:
+          Named opp-microwatt property. Similar to opp-microamp property,
+          but for microwatt instead.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8   # Should be enough regulators
+
     dependencies:
       opp-avg-kBps: [ opp-peak-kBps ]
 
-- 
2.17.1

