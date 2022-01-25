Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB68849BCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiAYUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:01:31 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53806 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiAYUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y7c1MC2Rv46IzPuWGbxn0agErRJ0tOIEOTZLv78PZ6g=; b=TkoogxuRTu3+3UPs8OhNVPn1dP
        hvLuJeVkwPL2cNs9MoRCvhPb54HU0aQy9ODvcZ0CmNHyrWDuwniBukaIzat/8o5g+n0pD6d435umi
        wctMCOIxmehLT/PSqXR4kcrOsmW4TaXwZ42d+LcurvryegVwei1WguuETUbXTr0xmp0E=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzU-0007fC-4R; Tue, 25 Jan 2022 15:00:33 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:09 -0500
Message-Id: <20220125200009.900660-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125200009.900660-1-hugo@hugovil.com>
References: <20220125200009.900660-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and INT_B support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The PCF2131 has two output interrupt pins, named INT_A and INT_B.

Add properties to identify onto which pin we want the alarm interrupt
to be routed. It can be either one, or both.

These properties are automatically set to false for variants other
than PCF2131 (ex: PCF2127).

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index 57eb0a58afa3..83656dd2f97f 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -24,6 +24,16 @@ properties:
   interrupts:
     maxItems: 1
 
+  alarm-output-a:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable alarm interrupt on INT_A output pin.
+
+  alarm-output-b:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable alarm interrupt on INT_B output pin.
+
   start-year: true
 
   reset-source: true
@@ -32,6 +42,18 @@ required:
   - compatible
   - reg
 
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - nxp,pcf2131
+then:
+  properties:
+    alarm-output-a: false
+    alarm-output-b: false
+
 additionalProperties: false
 
 examples:
@@ -62,6 +84,7 @@ examples:
             pinctrl-0 = <&rtc_nint_pins>;
             interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
             reset-source;
+            alarm-output-b;
         };
     };
 
-- 
2.30.2

