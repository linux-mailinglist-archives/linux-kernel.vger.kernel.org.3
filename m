Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159D47571C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbhLOK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:47326 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241840AbhLOK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:13 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFAOmbN014841;
        Wed, 15 Dec 2021 11:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=zQWkmP4ej0A5DSWCwAF/y8Xy7sc4PmpvNPei3TdmlCQ=;
 b=4PqLK+CcY6rD0mI6AbUMTgDmbt/9Dy41GxGhIwB4RBB+hSu53ujJt+YWP9cIWzLI9jD/
 x1vU+7E0oH69W/vh+tY4leC9wHIWEac/c+9a2sT28Xj7AE6NK2e25vMYkmiwxgMwqi/t
 4pkEayDg8mVVXTAlY0tD9vqH0NS0vXuUat/lgkAbudMFghG7f+3BHvG6dPhIToGnhiGO
 oCTG878peJdTUSxUUE/JwkYaqVvlcwc2rHuoQwjX/6ej7z4eCwCwCjfUv+jxb5cEnOR4
 hP+FmPhAXOkKOsywMbZjw3IOP1Chkn1eE4h2oQ7quiHsORWwCbXsMjYm2ry8hwshGPsf Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyeka85qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDB87100034;
        Wed, 15 Dec 2021 11:58:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4525235F6C;
        Wed, 15 Dec 2021 11:58:52 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:52
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: Update STM32 EXTI interrupt controller
Date:   Wed, 15 Dec 2021 11:58:43 +0100
Message-ID: <20211215105847.2328-2-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new entry "st,exti-mapping" which links EXTI lines with GIC
interrupt lines and add an include file to define EXTI interrupt type.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index d19c881b4abc..e08bb51e97a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -41,6 +41,17 @@ properties:
     description:
       Interrupts references to primary interrupt controller
 
+  st,exti-mapping:
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    description: |
+            Define mapping between EXTI lines and GIC irq lines. Should be:
+            st,exti-mapping = <EXTI_LINE GIC_IRQ EXTI_TYPE>, ...;
+            With:
+            - EXTI_LINE: EXTI line number.
+            - GIC_IRQ: GIC IRQ associated to the EXTI line.
+            - EXTI_TYPE: STM32_EXTI_TYPE_CONFIGURABLE or STM32_EXTI_TYPE_DIRECT.
+              Defined in include/dt-bindings/interrupt-controller/stm32-exti.h
+
 required:
   - "#interrupt-cells"
   - compatible
diff --git a/include/dt-bindings/interrupt-controller/stm32-exti.h b/include/dt-bindings/interrupt-controller/stm32-exti.h
new file mode 100644
index 000000000000..02b7e0e30cf7
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/stm32-exti.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_STM32_EXTI_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_STM32_EXTI_H
+
+#define STM32_EXTI_TYPE_CONFIGURABLE	0
+#define STM32_EXTI_TYPE_DIRECT		1
+
+#define STM32_EXTI_MAPPING_CELL_NB	3
+
+#endif
-- 
2.17.1

