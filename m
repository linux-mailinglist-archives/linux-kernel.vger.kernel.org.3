Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3D258C2CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiHHF1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHF1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:27:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33BE0F2;
        Sun,  7 Aug 2022 22:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxBoLP5dVMaIJPSWFPIYARHMVhF+6n7b5w+kn/5hlt8/yHPc81qnJZ/UHJr2snTj5OJuPldq3tl3LLCp4D2goqVnIKv2yxnHD0DreFnCtJ++GZVIF2GEKKsQypPH9lmT1MwYzBlZbZ+HbuDO/o34/zw/3t6Df7WAoeSb9qWEANekUSIR3QudqEkDn2AS9SZqzs05tmwXV42At43CWNWuuHk7ctkLgjyPPkMKxG5bRFS9VR6VxBq0XavCjJIE9WPUmcKbR0uKn3JTXLD9CK2prdrfAPISgi6zmtPIWa+uCnM6SWHukCiyJ4BVbk5x4hzV+OzYPHGERgplG8GhGGWB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi8UoOBGdEQahrq7GeszTYGcv7X4EM1WeWRQILzpG6Q=;
 b=i2rFgPjloNBIBrehvbk5fzkHlBkG+dy01kBOPoFQg1w30RvGzEmFzyt217gGrhZaFWcGx7kg11HnYl/QAlxinBtuNgHLuOLdkyJ0aeShUhivSBs84UPRmfVRA0nfI05JP+/75A74s0Q3dv0Yl6CdIglJSGrrHxgbnVFLCMtRjStzoxZcAOxZtlvtTIp0cU193M8wSts5MseNGC8w0/NruB0wx0oQscTD32B1Oa0Ui9m8G3T632/riufaG8pJ3DGLyr9Cpp0bhg3p/hZAy+U8U6lHk2O8STGczgu5DN/dlqnWNuAPDLWHhZHY1lcLIloXAeV/rSVgzflDNyjgcHHEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi8UoOBGdEQahrq7GeszTYGcv7X4EM1WeWRQILzpG6Q=;
 b=jZosXpVfTfap59HAa0mrvjcK3QcEAxCMyxx3lulGvJdWu+451m0EcKM15xL4FMP8o4szxO5wXSpSdFLvtxl4MLVg5XUX6kT8Qpum76Mq3SzvKrojihUrpQ5FyLmO7VXc8qtD0ioNDjZ9F24NM9h8RE3il//4AG9C+0fqkJZVXCg5vx505+XUHMISVRgcUWv5qvgVn0yzGpqKWo0zUJfphe9JCKLg7rtqAbzZCUTx66XH8AqHzzslh0HLm/tbCPq4NJQaIdtT1wiOJ4DK4bTknp/RJZ3FEuYRYsHeqmXlRkvieCpgz8wSZdW8N4STeTNrOiWXSYv3iKl+vIkcAZLSpg==
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 05:27:47 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::61) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.7 via Frontend
 Transport; Mon, 8 Aug 2022 05:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 05:27:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 8 Aug
 2022 05:27:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 7 Aug 2022
 22:27:45 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Sun, 7 Aug
 2022 22:27:42 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 1/3] ASoC: dt-bindings: Definitions for DAI params
Date:   Mon, 8 Aug 2022 10:57:30 +0530
Message-ID: <1659936452-2254-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32fdfd86-97ea-4421-5cf8-08da78feba7c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKw04Ilh4zhu/k3CYA/hTCSbnW1obuumm75NATVGgZTlj64oakMhHu2OXVCr?=
 =?us-ascii?Q?QP+kg4gt/re2h7wkkEhcfGFJXAt3RoFryF5KS7q6X8ziyoHDkPqV/kXsDUpz?=
 =?us-ascii?Q?fE89WwSDescrzMgjQdkQeTuS53wk2FzF3L9LsW0soMHWO0xKvfsRQ4CmpBnF?=
 =?us-ascii?Q?IXDcY2usR+YiRqlH4Qx+NQQIQ741EUvGvwpkqMKw8HWn0QO77v7cwdqcu5Pf?=
 =?us-ascii?Q?ulXZQfORtVZRqr4SSscwpEQyJiq6mEjh8+5vhwvYfJ7wjvbJUuVZzQiTvZIA?=
 =?us-ascii?Q?dZ1Yna0MSloto14PMf1PMpxD8Ig2Am09XDJkGdQnWV5E5gCM12LN7EtMgap9?=
 =?us-ascii?Q?THFF5Ypjju5Zi5dff6q5YO6gd6dz9KNkN2sDC2o9Pf3uJMe5QsLE6ERX3ALV?=
 =?us-ascii?Q?9pwLDk+UhkuHjju2HfIBz/Y5CyHdBc+VSSZAjAhJeyN4LTLWPlfW7fdYkMdq?=
 =?us-ascii?Q?77Q1ZkJyI3VjMHdAVHzq8ndEYrj0WlotUhQ/Ah5pamyw8OAasX+eezoe5Vd4?=
 =?us-ascii?Q?fIZUfBSM4ZYksGE8zaApxdUFqfqv5bN62+ztdJWRB1OUocdse1xC8XGV19+J?=
 =?us-ascii?Q?X9dTH5pUBbHS87tUv46oa8QV7Oq/ennXcQOLP9RxvcVXQcncuRp386mJBhRK?=
 =?us-ascii?Q?nYPS+IhnXi8cC7QIxR7g1KZLzUZQEwlRp6TzubpGaHljChBc9EwrmHV+MWGU?=
 =?us-ascii?Q?h/sjPXgl53DmyiYZyyAUbdD1ul4Bjm38O0Qdhnlzol01NIAFmXwi2oHFTLCs?=
 =?us-ascii?Q?HNd3wGFRjrMavdvV0muTHbISjx7bdIlRZ8YVctkJDc4S1G90UkdRB8I1pZMG?=
 =?us-ascii?Q?l77amCPqURl/IYo/v9Fitux7qWuYINld6XW94ITP0EhzKjp4r4oykYVjhwjo?=
 =?us-ascii?Q?bfVZdj2hx5SUG2IGqBPfE2bokTpppoUDxM/Mzh6hGUfV05ITyHhEEQ4l43p0?=
 =?us-ascii?Q?mE/rE2wH71cYLKWxl0pmyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(82310400005)(40460700003)(40480700001)(81166007)(356005)(82740400003)(83380400001)(966005)(26005)(41300700001)(54906003)(110136005)(5660300002)(8676002)(316002)(4326008)(8936002)(7416002)(478600001)(70206006)(70586007)(7696005)(6666004)(47076005)(107886003)(336012)(2616005)(426003)(186003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 05:27:47.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fdfd86-97ea-4421-5cf8-08da78feba7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "convert-channels" and "convert-rate" bindings are available for
audio-graph-card and are documented in the audio-graph-port.yaml and
the audio-graph.yaml. There is duplication of property details at
multiple places.

Introduce a new schema to have common definitions for DAI params and
these can be re-used in other schemas wherever applicable. Presently
update audio-graph-card bindings to use these definitions. If required
simple-card bindings can be extended to make use of common definitions.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/sound/audio-graph-port.yaml           | 13 ++++------
 .../devicetree/bindings/sound/audio-graph.yaml     |  7 +++--
 .../devicetree/bindings/sound/dai-params.yaml      | 30 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/dai-params.yaml

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 5c36867..fa3931b 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -19,11 +19,10 @@ properties:
     description: "device name prefix"
     $ref: /schemas/types.yaml#/definitions/string
   convert-rate:
-    description: CPU to Codec rate convert.
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
   convert-channels:
-    description: CPU to Codec rate channels.
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
     $ref: /schemas/graph.yaml#/$defs/endpoint-base
@@ -65,11 +64,9 @@ patternProperties:
             - msb
             - lsb
       convert-rate:
-        description: CPU to Codec rate convert.
-        $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
       convert-channels:
-        description: CPU to Codec rate channels.
-        $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
 
       dai-tdm-slot-width-map:
         description: Mapping of sample widths to slot widths. For hardware
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index 4b46794..ffee5c9 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -27,11 +27,10 @@ properties:
     description: User specified audio sound widgets.
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
   convert-rate:
-    description: CPU to Codec rate convert.
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
   convert-channels:
-    description: CPU to Codec rate channels.
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+
   pa-gpios:
     maxItems: 1
   hp-det-gpio:
diff --git a/Documentation/devicetree/bindings/sound/dai-params.yaml b/Documentation/devicetree/bindings/sound/dai-params.yaml
new file mode 100644
index 0000000..f1421a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dai-params.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/dai-params.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Digital Audio Interface (DAI) Stream Parameters
+
+maintainers:
+  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
+select: false
+
+$defs:
+
+  dai-channels:
+    description: Number of audio channels used by DAI
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+
+  dai-sample-rate:
+    description: Audio sample rate used by DAI
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8000
+    maximum: 192000
+
+properties: {}
+
+additionalProperties: true
-- 
2.7.4

