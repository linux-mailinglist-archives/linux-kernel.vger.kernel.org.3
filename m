Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056551A02D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350154AbiEDNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiEDNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:06:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84028366AE;
        Wed,  4 May 2022 06:03:09 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244ALwRe018222;
        Wed, 4 May 2022 15:02:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xzVNZjTzmtBSIdVv6DBe++9eoUDnPj2RYYfZVOlqvaM=;
 b=samI+CtMvgD52A39gBqPpHXB+YG/3V36i7MpWEKQIKJaGJZooqnayV7FMkCE0zBVttQh
 OhQToxKdr7bvp2ZT5bgf6vgRueFifaxTTdAd434H4NjD40nPLdDGKqq2F/kFr4X5eSow
 wFQ7jqF6Sw/cSgsP8rTRKxijqDuiRQVXircx8anMfwkQLDyxULRNmVhwj7BDt+pRSj1d
 5yPet6ZLC/WttKulqMbba2ZLGWOJP8iNlSQKMNT+pX3pdG0QDDcN+EVsenFw8I8xnF1S
 lHe0qDsp2z2MWRkt/22pZGI+LVuaYQweBf2sBEX+UlNdVCXDlmxmzuObprK7Ui89mcjF +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjvemr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 15:02:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12435100034;
        Wed,  4 May 2022 15:02:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A43121FE9E;
        Wed,  4 May 2022 15:02:41 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 15:02:40
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] dt-bindings: rtc: stm32: add st,lsco optional property to select output
Date:   Wed, 4 May 2022 15:02:28 +0200
Message-ID: <20220504130233.330983-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504130233.330983-1-valentin.caron@foss.st.com>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

STM32 RTC has three output pins: RTC_OUT1, RTC_OUT2 or RTC_OUT2_RMP.

RTC Low-Speed Clock Output (LSCO) can be output on RTC_OUT1 or
RTC_OUT2_RMP.

This patch adds constants for RTC output bindings and adds st,lsco
optional property for stm32 rtc driver, to select and enable LSCO.
A pinctrl state is also optional to reserve pin for RTC output.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 20 +++++++++++++++++++
 include/dt-bindings/rtc/rtc-stm32.h           | 14 +++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/rtc/rtc-stm32.h

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
index 764717ce1873..56d46ea35c5d 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
@@ -52,6 +52,13 @@ properties:
       override default rtc_ck parent clock phandle of the new parent clock of rtc_ck
     maxItems: 1
 
+  st,lsco:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: |
+      To select and enable RTC Low Speed Clock Output.
+      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
+      Pinctrl state named "default" may be defined to reserve pin for RTC output.
+
 allOf:
   - if:
       properties:
@@ -65,6 +72,9 @@ allOf:
           minItems: 1
           maxItems: 1
 
+        st,lsco:
+          maxItems: 0
+
         clock-names: false
 
       required:
@@ -82,6 +92,9 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        st,lsco:
+          maxItems: 0
+
       required:
         - clock-names
         - st,syscfg
@@ -101,6 +114,9 @@ allOf:
         assigned-clocks: false
         assigned-clock-parents: false
 
+        st,lsco:
+          maxItems: 1
+
       required:
         - clock-names
 
@@ -130,12 +146,16 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/rtc/rtc-stm32.h>
     rtc@5c004000 {
       compatible = "st,stm32mp1-rtc";
       reg = <0x5c004000 0x400>;
       clocks = <&rcc RTCAPB>, <&rcc RTC>;
       clock-names = "pclk", "rtc_ck";
       interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+      st,lsco = <RTC_OUT2_RMP>;
+      pinctrl-0 = <&rtc_out2_rmp_pins_a>;
+      pinctrl-names = "default";
     };
 
 ...
diff --git a/include/dt-bindings/rtc/rtc-stm32.h b/include/dt-bindings/rtc/rtc-stm32.h
new file mode 100644
index 000000000000..2fd78c2e62d4
--- /dev/null
+++ b/include/dt-bindings/rtc/rtc-stm32.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for STM32_RTC bindings.
+ */
+
+#ifndef _DT_BINDINGS_RTC_RTC_STM32_H
+#define _DT_BINDINGS_RTC_RTC_STM32_H
+
+#define RTC_NO_OUT	0
+#define RTC_OUT1	1
+#define RTC_OUT2	2
+#define RTC_OUT2_RMP	3
+
+#endif
-- 
2.25.1

