Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FB518308
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiECLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiECLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:08:37 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279E33375;
        Tue,  3 May 2022 04:05:01 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651575898;
        bh=f7LOPbAVv1vwG5hpUbka3+lbR6oTfswOHOcwYhEpF88=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=qyoE/dlTXwTBA+zlQ/8IZClSvD6AdZ5IMUDzVnQsY62rV/sHJ8m+IBt2euZJbtLi3
         xLgwLH8t4oujcsKVCBVFQv6EQnt9zgGYIrQ1u7FTejKBQzjyUNSxiHaPJZP6dxBQMx
         lZilLrbFaTADBPxnmH0Ty31cwyN1G47JR/Dcr9vxt/TsQ4qVpef5m81LTioUN80Soo
         eFE/8O0hOAEWjv2o8AArvlz8ZXQ9hFi3Nn1BOmIIlYDn18ocMXeuB9CVG5Rfbi2tcL
         VHkPNw/Nq/AXrXQn7QrstHGQm/wATUnQngo0YfWy8+HHnOVpCaMXbx4uVaC9sqhjO9
         S9gSAF1a7eWmA==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: [PATCH v1 1/2] dt-bindings: leds: Add multi-color default-intensities property
Date:   Tue,  3 May 2022 13:04:50 +0200
Message-Id: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651575831.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <20220502204616.GA27288@ucw.cz>
References: <20220502204616.GA27288@ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to assign intensity values to the indivisual sub LEDs
(colors) at driver probe time, i.e. most commonly at kernel boot time.
This is crucial for setting a specific color early in the boot process.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---
 .../devicetree/bindings/leds/leds-class-multicolor.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 37445c68cdef..c483967a847c 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -31,6 +31,13 @@ patternProperties:
           include/linux/leds/common.h.
         enum: [ 8, 9 ]
 
+      default-intensities:
+        description: |
+          This parameter, if present, sets the initial intensities of the
+          individual colors. This array must have the same length as the
+          multi-color LED has sub LEDs (colors).
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
     $ref: "common.yaml#"
 
     required:
-- 
2.36.0

