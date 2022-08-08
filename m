Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459D58C2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiHHF16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiHHF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:27:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F7E0F2;
        Sun,  7 Aug 2022 22:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScmQY0K6jweRy1KKdJ7IMurtByAWHD8fCXOX8lsHYGfZlPkWoypMx5fRbqlNsCUVRNMvf5C5c4Y+MQ2AnbdY8MYFzlgxaApyRcaH95+tTRTmTmMwJWv6XP6aOgSnmM8+VLRhdmvxnGaVgO6D7hyXpfPI9ZpuVJ0E0uboqbrwtg3cedhrfgYVsULRSFWh4lyGbsoqp3IHdpjjlc8qeEdf3IH2WIKfqzEbvTXN5YYroCnrHs9NZFPSGgdJjqjgHq5JB4hATAC3PK11PAqZzx12K0mG35PZLFKV4V+6sLq5JtQZ7YZorobCzgJzLJwyjEnwwsvz0n4/ho/2x7zeCGuFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQRihwPB5Tsz2nWsKiF5E11gspYY2vrRUD2myAvBqLQ=;
 b=Rmpu5VWyaPhD5Nl6C3lkWf32HMeIuGykB8u10aOus9p/RRVq/K5uR4h0xgQTqarfWsjQU8ym7puroR0nQuWwhJz3JukfnwGLfKE0+UartWclShwnDMbFST6Zsqssrwvo6J0ZfbPwbPHuGNwKAPLnqxz7a/EPpGxi3Ifv96uCgHaYiCMkVIQBB2MR2eSF5uXesYLDI6mgPkgmXl22Se3KEyPPbPyV3OTzJXFALPv6Yp41A8XLWNTOOF/pEzgJIuETRt3C6lJSYHBr7TZwhraLhIOZYc/RMPodNY+ngkuuNN7hE5GRb6vo+GTFRaWlvx/IOOmuHoihmYTPfVWzBQgcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQRihwPB5Tsz2nWsKiF5E11gspYY2vrRUD2myAvBqLQ=;
 b=qImlC+LtfIzWZCT24JmpVjtNinQzjGdiQcZ6q4VHCNfDJQLk2bZ7skHvk/mJR+KT4Un4Lv4We8MAjwTYQ3KLE0x0tB/6EmtjJ5ts0vPiKdQi7i5gT+gMTXHUT6NJ62a+CLlOOATYu2Cpb6IkKF63C/ewpqdTB6caSGpFILynVGZ36rjqoI+L7Jszb1nfvRktQ7TjfsWMbpDQDEMyNH1c3DIaCZToH7sV+5R+7Sim5Tf5jJPauWJAmzTLIFiQhIXgxpjGxGKR2X01rOE5bayjl8Qgo97JIbpKbsi3Ddr1qKWSqz7YmtlbbVwUdnWds7TxRCmQeGc0tEkBatOHEXWxRg==
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Mon, 8 Aug
 2022 05:27:50 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::11) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.7 via Frontend
 Transport; Mon, 8 Aug 2022 05:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 05:27:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 8 Aug
 2022 05:27:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 7 Aug 2022
 22:27:49 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Sun, 7 Aug
 2022 22:27:46 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 2/3] ASoC: dt-bindings: Add sample format conversion
Date:   Mon, 8 Aug 2022 10:57:31 +0530
Message-ID: <1659936452-2254-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b6e753-84ee-4d9a-484a-08da78febcaf
X-MS-TrafficTypeDiagnostic: DS7PR12MB6024:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24TNSGA7bgiJCPegu5FPuhHMGXyc6+hwIw7dV/BzYRkU9DbhTpzaMMvjQa68NwYXzclwXOkWSR3+Au641Cw3PzmZxzFodbY8A2lySuuki7vQfj0ygcUwnJX6Bmv7U237GvTL8VK86/kuvWeVKtLWvscbssNm8jS8kyIGPg98g/tc6UYOiPtl0OX4kjYaYQGugXdNU1BuBow7zlgOgWdY01PL46iZ+pdKjaSXUtpFjm96kcwJwS9IojAeTMiklmng323u5EFTKbzCyVioOc2ksBbYvXFHitosuZ7BSw2fcZdBBXHDgFgk1n+NxluY20oyPDNK1ZjJ2gWFZRp/quGZY6vkc2ZA7ztS3hPYCwzzlIeb4oaizQVIotFZnJHh+fJp3VnR41eV3Cs4I8b0D2t7CTNczGTxvC1ZR+rflRxBAFiWZjAeKX9hwfrAl/nfWtIARfEkQQzLSYvckGnARHhCoG1BNkm4d1visjxOkzvEDPdsnns7VWp5w6Tg6m54FKf05AXcDEkwmPVAcBqEEsDx8uTk8NPt0wq5dOm/TdCr6rQs8isgHbnq55ox/ZMW+UXABLa8Jmgbra6kJ/oUw4bOo5WyX5nb0fAuGYvwJ/IHspUEf+gcaUZ4F46xrJdNMuAyhNr6i3FcJ+Es0KYbvAsPjMHfiN6kUMRO+f6zD57nFDoiL5htAR712D2GhrSjiNB+7fDLiWoqQF77jOrDFZIHRDu4PQAyTR1k02o+oUKqAe4Gx9xmqhmCGsjcZ4bDi8zGsFzD8vtgBBvR+n1P3b66Zg6g1QRbuSwROf0jYQA4wXIcHXvBFREQF7oOd6w4WvIIWHf6DHImw8vVM+Vd/sSreA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(2616005)(107886003)(6666004)(7696005)(82310400005)(186003)(2906002)(26005)(36860700001)(478600001)(40460700003)(4326008)(336012)(426003)(47076005)(54906003)(110136005)(81166007)(40480700001)(8936002)(82740400003)(7416002)(316002)(5660300002)(8676002)(70586007)(70206006)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 05:27:50.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b6e753-84ee-4d9a-484a-08da78febcaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently "convert-channels" and "convert-rate" DT bindings are available
for channel and rate fixups respectively.

Similarly add "convert-sample-format" binding to fixup DAI sample format
as well. This is added to audio-graph-card based bindings.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml |  4 ++++
 Documentation/devicetree/bindings/sound/audio-graph.yaml      |  2 ++
 Documentation/devicetree/bindings/sound/dai-params.yaml       | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index fa3931b..7ff7a4a 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -22,6 +22,8 @@ properties:
     $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
   convert-channels:
     $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+  convert-sample-format:
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
 
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
@@ -67,6 +69,8 @@ patternProperties:
         $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
       convert-channels:
         $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+      convert-sample-format:
+        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
 
       dai-tdm-slot-width-map:
         description: Mapping of sample widths to slot widths. For hardware
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index ffee5c9..aaa99c2 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -30,6 +30,8 @@ properties:
     $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
   convert-channels:
     $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+  convert-sample-format:
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
 
   pa-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/dai-params.yaml b/Documentation/devicetree/bindings/sound/dai-params.yaml
index f1421a0..f5fb71f 100644
--- a/Documentation/devicetree/bindings/sound/dai-params.yaml
+++ b/Documentation/devicetree/bindings/sound/dai-params.yaml
@@ -19,6 +19,16 @@ $defs:
     minimum: 1
     maximum: 32
 
+  dai-sample-format:
+    description: Audio sample format used by DAI
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - s8
+      - s16_le
+      - s24_le
+      - s24_3le
+      - s32_le
+
   dai-sample-rate:
     description: Audio sample rate used by DAI
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.7.4

