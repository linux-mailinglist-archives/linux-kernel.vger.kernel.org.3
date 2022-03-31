Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFC4EDB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiCaOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCaOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:05:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026251586;
        Thu, 31 Mar 2022 07:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM+qCTRvntF9RDlTZ4ZAVmcToA5fbD8fovr42wsRMcGJhEB+Y7WPMvEVKnmYlIL3zIYI5/PGUq5DiLux8f+JPy5+0HmshP8EXRRdx6qsAlMcc8hK1DmLA5NL3ZonUBCWvOrOp4KrRQpN8ddJekkLGhWTL0/Q0KG1ll5aAxx6mGYo95wASM3MQx4XFZV6CAN639bDUJC94PBom8C8PL2wwGrp1RMAKRMIwBDaSm8vHVfjRpdf9Mi8T/7RLgnEc3OljTbWlxxRfNwNn1P7j9Vkhbc3TOONSSJTvMe/dHW3e0G4CPlV9gUFNsBeg/Aaz2k1CfAkRf7bqY1oDaHBDL3oTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kaSMl4l3yOuOYqRVKCvJZQR+BIGjkX2obubDkXDwxA=;
 b=SneDzsUq7M90IGi5NOSkbCki7lOyULNZCNGl239GH+reN0RpFUpYOHtTSmAAa374oPlrih/kYutqbmtVDLUOIqEXk4xVhVGQqo0SeOlDJb12+/suUZ3lAmLNyN4T/a6jCQFj1mrUfanEpptIcd4we8jaWGnZCqXOUttdfMI54vVsvCa3GQFBBdTetJf/rC4mKldoZ3JBC3yiHtPI0jYBnrMTyvvPHXJCSDljncI4juHMXjtr4jVBSDl7WMXY+C4TyI3qjr6tsztjPtrXNUbhXtCFZXXcqFmYs5Yb3v+4ZDxFHedCEiuzTxKKYwWxeEa4YQcJ/1W3+wgxrjcFEsqu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kaSMl4l3yOuOYqRVKCvJZQR+BIGjkX2obubDkXDwxA=;
 b=b2PKXL2dWfRWLcOn9OR/h9wbcO2ovaV3UaApXJywEdw14y65sSJJ9aNDJttQUtZSBK1aBgFpDkTKil1o4e07EQ92MRadNLwOc/pjEHORzoU5iHjIc2ZjoahdBqsvdUxejDbSJOX2Cyb4GCEymrns7ob7UBEfPPThXRPx7vI/sVuqXQp499ptYuTVNwKnhm3wmg0vdCjIXFAW0HT7PyQ2/fuBh3btWPPyosY2+UxniSRO7/sncD4PGHT88yBWpWEBwaTdGa+bcDP1odpvWvsrS2W6Be7PUby5Vbpszc8W4f3MI1pT1jjdaT8GSxteYv5uTbshSZVUuiL2HscQng/fGQ==
Received: from BN6PR22CA0031.namprd22.prod.outlook.com (2603:10b6:404:37::17)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Thu, 31 Mar
 2022 14:03:51 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::13) by BN6PR22CA0031.outlook.office365.com
 (2603:10b6:404:37::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 14:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:03:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 14:03:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 07:03:49 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 31 Mar
 2022 07:03:45 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/6] ASoC: tegra: Add binding doc for ASRC module
Date:   Thu, 31 Mar 2022 19:33:27 +0530
Message-ID: <1648735412-32220-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
References: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3586f027-7fd8-45ab-047c-08da131f48a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2875B80B4F1F8E94E01D0201A7E19@DM6PR12MB2875.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLoA5WfJg7cqzr0E6/DE0Ux/kp2mwOwkmMr5YOmez0zZLq4aPENRlvukw3tmn3djY0F54ozoNyzsYvqdBb2nJc+o2KYzkd5+gW/v3U+Wq1aRjUQb3FitVjYz7R3hhW47CBD3O3W+uT9rCPPLAcSU9m4lVGZuO+xIgFyKWmsH9i9RvIhtkzXagR0wHOTBpAmZcjnSnqNE2QVTKD6XTT4HF4ViwQnOg6siT86EC0JyKYsBwU/GJGps6FLPwFXk7jbYYKj5131HCOLKY5usg+LQM87XcI81XyQsNdXI5bliLpcf+lHEHth3EIKwwZFNGE/uItqKRvjr8g3yPUdEleefAnVHGDZWm2EPuzT5ix3eMIIO5oxIz5e0OQOIm/ZcVIDjkdH6TvTOhM6Cwj8PQu5A9xanWlid8eEYszV39uA3sVh0zA9LLGM7CKGwVa+5/OEIHXlAYP7mxItJBBUqXRhOQSIbbCunl788n//5L5TDGh/dMc0TTvnsjJhWoOPfT9/twWTpMgZPniTpnVAsGV84c/IaSMY3ltREDWYVgi1pf2037Rgw6OzkAlk9iQ52XOOkvGSUw6jirU5+QeqhFLPerJrI3uB7Keqzw6TfhGnpDwmfY9Dz9P8cawAI+e1tCcwYn+A9Y6m5RTWHl4TeIoU+LT+c7g2psVpmzTMBPdQ1mSsdgjO7qtlpnJze9a9Yk5HxuFZqjsA+3sE7eDpWeudbAK8WsnrjjS4aQyd87SGqXkTRYSekGGygAHoJlAlBDfwEz+uqP3ug0c57oukdiyCxk/+WSvViK9tg4ttbTSXdH09h3qEZzphR8ZYzBFpxSWTaGkuq+nwarKY0SUxlpaqZ+Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(8936002)(7416002)(7696005)(81166007)(70206006)(8676002)(82310400004)(86362001)(70586007)(47076005)(508600001)(2906002)(966005)(316002)(6666004)(4326008)(2616005)(5660300002)(107886003)(186003)(356005)(336012)(426003)(54906003)(26005)(40460700003)(36756003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:03:50.8447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3586f027-7fd8-45ab-047c-08da131f48a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds YAML schema for DT bindings of Asynchronous Sample Rate
Converter (ASRC) module. It will be registered as an ASoC component and
can be plugged into an audio path as per need via ALSA mixer controls.
The bindings are applicable on Tegra186 and later where the ASRC device
is present.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/sound/nvidia,tegra186-asrc.yaml       | 81 ++++++++++++++++++++++
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |  4 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
new file mode 100644
index 0000000..520d0d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra186-asrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra186 ASRC Device Tree Bindings
+
+description: |
+  Asynchronous Sample Rate Converter (ASRC) converts the sampling frequency
+  of the input signal from one frequency to another. It can handle over a
+  wide range of sample rate ratios (freq_in/freq_out) from 1:24 to 24:1.
+  ASRC has two modes of operation. One where ratio can be programmed in SW
+  and the other where it gets the information from ratio estimator module.
+
+  It supports  sample rate conversions in the range of 8 to 192 kHz and
+  supports 6 streams upto 12 total channels. The input data size can be
+  16, 24 and 32 bits.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Mohan Kumar <mkumard@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  $nodename:
+    pattern: "^asrc@[0-9a-f]*$"
+
+  compatible:
+    oneOf:
+      - const: nvidia,tegra186-asrc
+      - items:
+          - enum:
+              - nvidia,tegra234-asrc
+              - nvidia,tegra194-asrc
+          - const: nvidia,tegra186-asrc
+
+  reg:
+    maxItems: 1
+
+  sound-name-prefix:
+    pattern: "^ASRC[1-9]$"
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      ASRC has seven input ports and six output ports. Accordingly ACIF
+      (Audio Client Interfaces) port nodes are defined to represent the
+      ASRC inputs (port 0 to 6) and outputs (port 7 to 12). These are
+      connected to corresponding ports on AHUB (Audio Hub). Additional
+      input (port 6) is for receiving ratio information from estimator.
+
+    patternProperties:
+      '^port@[0-6]':
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: ASRC ACIF input ports
+      '^port@[7-9]|1[1-2]':
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: ASRC ACIF output ports
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    asrc@2910000 {
+        compatible = "nvidia,tegra186-asrc";
+        reg = <0x2910000 0x2000>;
+        sound-name-prefix = "ASRC1";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
index 4727f1e..6df6f85 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
@@ -106,6 +106,10 @@ patternProperties:
     type: object
     $ref: nvidia,tegra210-mixer.yaml#
 
+  '^asrc@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra186-asrc.yaml#
+
 required:
   - compatible
   - reg
-- 
2.7.4

