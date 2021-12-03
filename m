Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40427467F48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383240AbhLCV2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:28:08 -0500
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:53601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353858AbhLCV2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOUGdHjyIcvqHY9TrH5zribQqhj16//HeEFDBas38UZiEZp/aTSQEc5IeG26J6yZVH3s7vMgamvGXeX8F3xI3QTZgagADTkXIyaJdyaXRw1g8y0sxARSPMHUziKFIxRThAS4Bd8/TLlqikrxFYdykTRjFi3ZXT1KBYYyI9y0/7VTNc770u1SBqMoAM5yitUPW8/ssl+ZDPFPBqWgnKmR66tuBfw3wiKMizC39QrV+x8LOkg4E0UZ2u47/0T1XITxa4x/viQW8GTQpeUzMwYemtIq/ILzcx/MoKHmUkT9jT5MZ4F0a1WV8labU+xCKhOv44pBTD+5SEKUzOd3/G444A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=Oxn0tUbMOZ/bQeQLSA3OW3PY7urvHgjKX6qOb8QwV2ikU4PZ4LgsiI55REBrwloh57axp5qmkllnIxOmt5pJbYJ8UKrEnThKVtuSndeCYZQthELpKUzxn7IIom5UaV5hQbmSIXz1h/0ZgYr/ztvTXLLb/eAJIVKjFJXaaz9HVS/ofU16xUJriAXOxlFQjyGOE2Xezeoo/ud2fSZM8EyFBoRSG0ROiYw3pt9cYRnEZcvlW4KY3jNFxgX51XIzfVOBjBNhu7QAJFvdGULLFVNZmwbAZ0e2nUNwwkb6U4VxgbhVzUhSo2JG7NVGPl0YwHpQOMByhMLb018FYMEJ1T9mSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=aPdHnswDcg1RCu6z2f4R0LiR24iO/GS+bRe7m89AWKkRubpqE6trKiGKNZHbfiCWcZQBsIUwv/GcP0fb/Y59RQKfvOJya/C9b53JsH0o/iHHhK6A3h6Eh8fGQ4mckWQx2kznJ6maDACWwZCCZEqX+R38vH+HDZfgjmCjeQjvI/k=
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by SN6PR02MB5645.namprd02.prod.outlook.com (2603:10b6:805:e4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 21:24:18 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::40) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 21:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 21:24:18 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 21:24:10 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 21:24:09 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michals@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=14741 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mtG2C-0005F8-BO; Fri, 03 Dec 2021 21:24:00 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v12 4/5] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Fri, 3 Dec 2021 21:23:57 +0000
Message-ID: <20211203212358.31444-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfda8367-d3e4-458a-0874-08d9b6a3440c
X-MS-TrafficTypeDiagnostic: SN6PR02MB5645:
X-Microsoft-Antispam-PRVS: <SN6PR02MB564566F069448A12BECC13ABA96A9@SN6PR02MB5645.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0bwbv5jBwKvJi2hyuhC5v8amX5mJ7rMH2yUjIPembPSGiXxSj7Ia/BK9Z2g+B/5pFtWX1mWlWf+6BZuHbdTFvFiZshKe/dN9vLGXahp0flFMvHmZ2BGZHwP3FyUfQn6XO3TjzPeKgYjt36nLJtG/mxchm572G4Z7bqkch8xR8BgV+hBd8MjeGdPUaYMdBft+IXkAeb0bLZEA+a4OuRZ9/qVP9muTPkwicGkVPRxHGUMQnRffW9KGHhL8ErFkYU7sG+awvqR/Jiklk66juayglEzPU2vzteyN7C0+f95k+tA1tW4QJkhBOkkeCnyUjb+jcTzbl/JOXAKxuWttpn9IhRfOressBU3XOcxLJiGzOixvSD7M4RiEhwDlzFB5Lad8VhC/B2B7C9Kz1cMIQx4sB67HTr9rurYsDnHDdPAeOjOzC4y8L3591yFB7tEw+GiMmohAoUsl+YZQshFQMZOdcKUL3ommTNT4/jL3BNpObx/1bgWMOali0k0nFlo/iM27yt08MhB7zmh+NHfvjLG81nxK1lby6Nd1wBBFR6uHhV+5dcVDFaO+6AwP2rbjowZTNw4vVZVoXO+FLYQhxHF1MqjlbxTFlh6OSY3R+POy9L/F5+9F/yZriuzJq26Rkynw/P9kddWI+PkiySv9ZYU+rvpmVaCpqJwUtr+8QGqFea4hDst+1fzkOHSd4u+AE6/8CNHJ4KCrHf9GL5YOA39mQMWUYumKHXDMBm0fOdfnfc5jUKqKS4/blMU4hhAWMHBCl8r4zzhGzYKAfhZlE0BhxkjuiePl7732h+owQcKj0r7+MW/92GV0rw6VvDjd6ybwd/5PJFMlAtCBrbNYU0AHhtoaNoKp1DWvDJwEr1PAaO0F0m8YnHH/QDyYwX9lKgxeczRdrIlwOx8K12kinS96dpcWK5/LypdKTIo6XXI+4s=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70206006)(6666004)(83380400001)(1076003)(70586007)(5660300002)(356005)(36860700001)(36756003)(47076005)(2616005)(186003)(8676002)(107886003)(8936002)(426003)(26005)(7636003)(316002)(966005)(336012)(2906002)(110136005)(7696005)(508600001)(82310400004)(921005)(4326008)(103116003)(9786002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:24:18.4387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfda8367-d3e4-458a-0874-08d9b6a3440c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
new file mode 100644
index 000000000000..87992db389b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -0,0 +1,227 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,zynqmp-ams.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale AMS controller
+
+maintainers:
+  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+
+description: |
+  The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
+  that can be used to sample external voltages and monitor on-die operating
+  conditions, such as temperature and supply voltage levels.
+  The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
+  PS (Processing System) SYSMON.
+  All designs should have AMS registers, but PS and PL are optional. The
+  AMS controller can work with only PS, only PL and both PS and PL
+  configurations. Please specify registers according to your design. Devicetree
+  should always have AMS module property. Providing PS & PL module is optional.
+
+  AMS Channel Details
+  ```````````````````
+  Sysmon Block  |Channel|                       Details                                 |Measurement
+                |Number |                                                               |Type
+  ---------------------------------------------------------------------------------------------------------
+  AMS CTRL      |0      |System PLLs voltage measurement, VCC_PSPLL.                    |Voltage
+                |1      |Battery voltage measurement, VCC_PSBATT.                       |Voltage
+                |2      |PL Internal voltage measurement, VCCINT.                       |Voltage
+                |3      |Block RAM voltage measurement, VCCBRAM.                        |Voltage
+                |4      |PL Aux voltage measurement, VCCAUX.                            |Voltage
+                |5      |Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.       |Voltage
+                |6      |VCC_PSINTFP_DDR voltage measurement.                           |Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PS Sysmon     |7      |LPD temperature measurement.                                   |Temperature
+                |8      |FPD temperature measurement (REMOTE).                          |Temperature
+                |9      |VCC PS LPD voltage measurement (supply1).                      |Voltage
+                |10     |VCC PS FPD voltage measurement (supply2).                      |Voltage
+                |11     |PS Aux voltage reference (supply3).                            |Voltage
+                |12     |DDR I/O VCC voltage measurement.                               |Voltage
+                |13     |PS IO Bank 503 voltage measurement (supply5).                  |Voltage
+                |14     |PS IO Bank 500 voltage measurement (supply6).                  |Voltage
+                |15     |VCCO_PSIO1 voltage measurement.                                |Voltage
+                |16     |VCCO_PSIO2 voltage measurement.                                |Voltage
+                |17     |VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).                 |Voltage
+                |18     |VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).                 |Voltage
+                |19     |VCC_PSADC voltage measurement.                                 |Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PL Sysmon     |20     |PL temperature measurement.                                    |Temperature
+                |21     |PL Internal voltage measurement, VCCINT.                       |Voltage
+                |22     |PL Auxiliary voltage measurement, VCCAUX.                      |Voltage
+                |23     |ADC Reference P+ voltage measurement.                          |Voltage
+                |24     |ADC Reference N- voltage measurement.                          |Voltage
+                |25     |PL Block RAM voltage measurement, VCCBRAM.                     |Voltage
+                |26     |LPD Internal voltage measurement, VCC_PSINTLP (supply4).       |Voltage
+                |27     |FPD Internal voltage measurement, VCC_PSINTFP (supply5).       |Voltage
+                |28     |PS Auxiliary voltage measurement (supply6).                    |Voltage
+                |29     |PL VCCADC voltage measurement (vccams).                        |Voltage
+                |30     |Differential analog input signal voltage measurment.           |Voltage
+                |31     |VUser0 voltage measurement (supply7).                          |Voltage
+                |32     |VUser1 voltage measurement (supply8).                          |Voltage
+                |33     |VUser2 voltage measurement (supply9).                          |Voltage
+                |34     |VUser3 voltage measurement (supply10).                         |Voltage
+                |35     |Auxiliary ch 0 voltage measurement (VAux0).                    |Voltage
+                |36     |Auxiliary ch 1 voltage measurement (VAux1).                    |Voltage
+                |37     |Auxiliary ch 2 voltage measurement (VAux2).                    |Voltage
+                |38     |Auxiliary ch 3 voltage measurement (VAux3).                    |Voltage
+                |39     |Auxiliary ch 4 voltage measurement (VAux4).                    |Voltage
+                |40     |Auxiliary ch 5 voltage measurement (VAux5).                    |Voltage
+                |41     |Auxiliary ch 6 voltage measurement (VAux6).                    |Voltage
+                |42     |Auxiliary ch 7 voltage measurement (VAux7).                    |Voltage
+                |43     |Auxiliary ch 8 voltage measurement (VAux8).                    |Voltage
+                |44     |Auxiliary ch 9 voltage measurement (VAux9).                    |Voltage
+                |45     |Auxiliary ch 10 voltage measurement (VAux10).                  |Voltage
+                |46     |Auxiliary ch 11 voltage measurement (VAux11).                  |Voltage
+                |47     |Auxiliary ch 12 voltage measurement (VAux12).                  |Voltage
+                |48     |Auxiliary ch 13 voltage measurement (VAux13).                  |Voltage
+                |49     |Auxiliary ch 14 voltage measurement (VAux14).                  |Voltage
+                |50     |Auxiliary ch 15 voltage measurement (VAux15).                  |Voltage
+  --------------------------------------------------------------------------------------------------------
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynqmp-ams
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    description: AMS Controller register space
+    maxItems: 1
+
+  ranges:
+    description:
+      Maps the child address space for PS and/or PL.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#io-channel-cells':
+    const: 1
+
+  ams-ps@0:
+    type: object
+    description: |
+      PS (Processing System) SYSMON is memory mapped to PS. This block has
+      built-in alarm generation logic that is used to interrupt the processor
+      based on condition set.
+
+    properties:
+      compatible:
+        enum:
+          - xlnx,zynqmp-ams-ps
+
+      reg:
+        description: Register Space for PS-SYSMON
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+  ams-pl@400:
+    type: object
+    description:
+      PL-SYSMON is capable of monitoring off chip voltage and temperature.
+      PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
+      from external master. Out of this interface currently only DRP is
+      supported. This block has alarm generation logic that is used to
+      interrupt the processor based on condition set.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - xlnx,zynqmp-ams-pl
+
+      reg:
+        description: Register Space for PL-SYSMON.
+        maxItems: 1
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([2-4][0-9]|50)$":
+        type: object
+        description:
+          Describes the external channels connected.
+
+        properties:
+          reg:
+            description:
+              Pair of pins the channel is connected to. This value is
+              same as Channel Number for a particular channel.
+            minimum: 20
+            maximum: 50
+
+          xlnx,bipolar:
+            $ref: /schemas/types.yaml#/definitions/flag
+            type: boolean
+            description:
+              If the set channel is used in bipolar mode.
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        xilinx_ams: ams@ffa50000 {
+            compatible = "xlnx,zynqmp-ams";
+            interrupt-parent = <&gic>;
+            interrupts = <0 56 4>;
+            reg = <0x0 0xffa50000 0x0 0x800>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            #io-channel-cells = <1>;
+            ranges = <0 0 0xffa50800 0x800>;
+
+            ams_ps: ams-ps@0 {
+                compatible = "xlnx,zynqmp-ams-ps";
+                reg = <0 0x400>;
+            };
+
+            ams_pl: ams-pl@400 {
+                compatible = "xlnx,zynqmp-ams-pl";
+                reg = <0x400 0x400>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                channel@30 {
+                    reg = <30>;
+                    xlnx,bipolar;
+                };
+                channel@31 {
+                    reg = <31>;
+                };
+                channel@38 {
+                    reg = <38>;
+                    xlnx,bipolar;
+                };
+            };
+        };
+    };
-- 
2.17.1

