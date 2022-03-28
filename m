Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7E4E8DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiC1GI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiC1GIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:08:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C113DE7;
        Sun, 27 Mar 2022 23:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiePL8vqzVsHarnACoeqT5r2HLy+svdHatIBgUXVQL5T0ZFzTAlvuxVPYU28okkfb6Xsy/1k2ozYPXbonvNxt/dC4+Wikzh8IMfjvGPSysz38fC7QaoPC/ypfmby3Zy1wp2dgq4K6TsKfkGKtR6UTxrYSdeOGi3MDj/2xSSVITpDGUulpzsW4wxwLwYbAXEY8oXIcHZTvusajwEoyDdr0yvJcUZ2i4dpRZYIRCdqBTwv3g1MUYsHl+ecLs1N/yWGix6UAaIZGaADdEN9ZMQT+6vq6KuKz2ZMI71qdHL/Rs3lGbbupySyQ0TOxUlgT7U5PYa+XpbF3/QXcL1o/Ba5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kaSMl4l3yOuOYqRVKCvJZQR+BIGjkX2obubDkXDwxA=;
 b=BbcrUcwESLXk40oukx2L9LJp9k0Y5EGP5RDHaeCNY0bzkabtdQE46iXO3DazcbWlaeMxuKnppRjVM1rZw1ZM4JXZRQ8K2LI7holOLTY40J/6/rMGoaM1llRYAAg4Li7epn6XeaHdngdMqTHPsi/pAuglA4fDijdMuYxVv0DCZBZ0xxAClk0UyXvtTGpPcSQVgMdOa2fs2ElFlGp3+31jsbubQFlhdKKIyictHreBAI0Th4J4u9bnKbmRGTgQ6fBWbDU7Seh8Y7u7hlXQm0M+9R+BDpCIP2mZYn8U7pXABdjhi5ZYPyRHaL0KfujO79cZr10KRdMsJLnxaQOZGgVXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kaSMl4l3yOuOYqRVKCvJZQR+BIGjkX2obubDkXDwxA=;
 b=rurmFezfzBHEgbnpOxbGQN/MtR99Fz0W9GvsLouIehL3WIWGe4eqr3MRVMdclKyRwuQhurjR3Ji8AMx1lzu+7skXHu32JN7A4zfbt8CVJEBzN3+iiiosrDS9/9pU72juhCueI1qAHxE822q3e/B3HFYYg8dUDsv97AX3Slb+FD06l9wjx+pWuk/dCpMEz59A9aAe4mnVB3EsGrFctP7sb0BzeKjgfEIIyuC38V8wwURvxYNFFvF1wrF/VeMY6eJUTmWZvpVH17e3yrqq9itGB+B3TGj4wo/iuKsxv4Hznlb/TtmCDNQmcG5aDMebA3EJtHaNd9JOfYtc3ZXY4IVP1g==
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 06:06:40 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b4) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:06:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:06:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:06:36 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:06:33 -0700
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
Subject: [PATCH 1/6] ASoC: tegra: Add binding doc for ASRC module
Date:   Mon, 28 Mar 2022 11:35:21 +0530
Message-ID: <1648447526-14523-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b56818-a87e-4671-996d-08da10811f78
X-MS-TrafficTypeDiagnostic: LV2PR12MB5847:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5847750DD636CDC6CCA96101A71D9@LV2PR12MB5847.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V/emu1nuDrs7gOQ7//yud8BJLmGZ54QD4hegEUeTwWqW/tHMSC0C9n+gcY757jK/jEUCMk5SW+Cgz0qNzXH34Ug7hpMN7HJcRApGUObejQxRtU/Jhokxpl8p73ym5/3eBtW3noLNo3zvwGNAp0zCQYUGSVYztBjJPkC2dYljF2mChPQ4pfdcAML+39Mc8swuWmX8ftP1vC7BIoqcJRocC9egyoU5Tde1iKECd+IuLTCEvXAJz0bEpUiQotn82/5dE1IRHwiIiVZztk/jUt1SVIUx7e/3+U4p2sw5zlonWOrmmyKucysVY6u2Q3Y68fAQP7LB1dnZkEoSLN0uqtDg7QoXGV8onnccR2teAwKW1n9x4DruBJa78SfxrtStcuFwAByXLewUESc9ScjroRHMveJ8OBwHwoxr+0Jc3tIc0kst700IKBVE+gnmoEPcSK89wVI3ML6m6MUJeZUK3VHW+/WnfP6NB3UE1ewxRDoGQfS4NirygnuoAnnyE+2upPL0n8dIcbJZB/reXNWKNaxSf9DTeJfDoB/iTROtTuhX3zOXgmNGvLBa5E6vEFvAxW5R5LcB4cxbAnvOvDkgwzEo8zBOASKn5c8OdFAdFhSj0QJ6qq2Uq1EAO04nQtE+cNo8Kix0OCIaaqOGEgWLR8GjA8Yox0FUxFlVyuILCHBbZMqStwLsDeDz16rmS9z/2uKhgDSGIuUdkS7g/87GuqAUtZQeL9PLVHFncpFTlElr9NbBG3qe4Y5qo7mwm5rdFuEege6nU/gsYx7W6ZpMe282kYulgHXw7fY/2w6GJnDUyAf3WvXLIzvO7GX61oJgdmHjYRJa94lWMlwqZK/QI7H/Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(70586007)(966005)(81166007)(47076005)(508600001)(40460700003)(36756003)(36860700001)(2906002)(107886003)(82310400004)(4326008)(70206006)(426003)(8676002)(6666004)(54906003)(336012)(186003)(26005)(316002)(7696005)(356005)(8936002)(86362001)(5660300002)(110136005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:06:39.0075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b56818-a87e-4671-996d-08da10811f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

