Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19B849DB80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiA0H2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:28:03 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:53729
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237316AbiA0H2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:28:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbcQqs7oiiE6I8XPrEpUM0nuRUdRp9qqq+CMe1hpvMAy+uoZagnYbSJVZ5cXA0OxBb3ZmKx/wobWB9V1eX+IVKZh5jOD7cTxjeyuczcVmzggSHp/KqzOGcnTkTwQTzkObh+5j8FW7vVzPvvRpkKnPC3VdhbKQCzX2BlPEB+Wm0Ue4kxX21BYgTikJuQUvvb1uZYxPhDAeMvz32gO62WL/1+LQeVXj94HypQ9U8Gr8sc8fmeBEIgH9WSnAWaADCoMz8T94xT7l9rkRN4c4KO7VQWl++MeXaIPW63+p19UR5Z1G9xhjTiv2gLkYwrJMwiFXOemz/3px9rP4Ac8tVbKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=f4iapiaFrM/PxJFb4nBY8uZhj1mu0RpNdKPWa56mqQeHBeZZ1yPQ6MKUtNuCTEwX9wl7psealI4rlg6MjcRyuH0Nl6dXJZrcce20Ebgc0RV7bPmRDJ10ZtMlRRCvBKhVoJDejJOeUQl5ApEl0A3QfW1iGOEv0RJ415uKTQUivxODhKXvZGQPiiL+netvAt77ZxdMDqOCe/vX9c5GbpUjQeGEL17W8wBOjQ6Cx9yd885/kTUjJ0GjZjoTfbkcSuJV0FwDYu5csYbLkhnYg4/4lqhq7HhaUyxPcOrvTIe8sFHGTM7hzZSQ6QCWZ+X/SM0zxWjzS1pnyRABIfVDx5uiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=Z1ZB3cLVdDpYNJbu/4ABrVCQWzCAyfBuCjfewDqNdzHxyOhkCLgA5P2tbC45gDBKjL8HVPgr9Jc8+3x5+/o4zl6wN6IghXpnheJq4J989Zn7IWLkd/vRSVkZOiz0kQW+Mfk2SwZ33c6knzTL4ytLKpT3PTz/2wTOI6f8Vjst3nA2LaSwJQ8a8w0LOXb+O6+Q3XrUMLtCv93PzatZhVZAp39Kb4eBLi3YXivhdJ4s4Pjkd4ANWVjNawEbsNEMqLb8TrrE9N6pcKBTLlOUC2ZMwJiA0CT04zDMPAFNF6Pj8+CZhacJYadW+MRfwtcEkeEIhEcxekRytJSG/VO6u3y01w==
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by MWHPR1201MB0112.namprd12.prod.outlook.com (2603:10b6:301:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:27:58 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::5) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:27:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Thu, 27 Jan 2022 07:27:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Wed, 26 Jan 2022 23:27:56 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 26 Jan 2022 23:27:53 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 3/5] dt-bindings: Document Tegra234 APE support
Date:   Thu, 27 Jan 2022 12:57:33 +0530
Message-ID: <1643268455-15567-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
References: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b749c96e-4557-4970-240f-08d9e1668abf
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0112:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0112CA46367442383EBE0CF5A7219@MWHPR1201MB0112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6ukYeo0LkqMus6UWvNIEVG1azf4a17cgjX5kN7fMiNta63Lhj6BUxcYsZujNMBhBUbWoqdbEvoWZzE4XVjrdh8aIM+ZkgCxB+WhFlKNJc8Qj/A+DeLGo1xLUxPUpec97swluljUILP2PSSvVKgI70CShtmB+peQDCOUuzC4D0K+Ykc0A9DTiZbCjmhrlR3W2UaoZEUHSrwQ821zN2QFOXIEGnRMI8hc2E+lO0Xdj29j06h1RbtjN1d+HrL2n6aaw4VFx0FMIoUVcVP7PICjgJDGWVYDsiBqFebgiLGqHMOffFEl7FF9ndf/asOM6qhuK8KktuaTAOJ1WE5p6iB5+PeQ6zUT9jVuv2t++lT1qQtgiA56QKquEkXM/1DCrX5bEk1clWNG0TqcjP4RsyO2FBlqKr0R8HfP6L+XBPkYZrTf29m4h2clA0ucU9fvh55VepnmBXpKC6DVbBhgX4jjAxDOO5NkPIZ8WzqxrRmFkp1Kv3FqYDUh7NHOqhTwJU6FODkQ/eBfhRuI6eAKB10nCaoDUn1GaDOoPGX+Pc5F6RSt1yc6EFX/tj9bFFf+xPxcACHE46GYOmLRPwEjuV8Kn/PuFeXE0Tad5Do+o6Pt9f909+ePkdlR7cYHqmGXvQNDZkHWZACQZZOKb7CTx7qLqGZkRc3NKf1WeV0GhPDJTfruNXquEhTHWrn7KwoVAK55yPHIZnb/F+WHYe+LvOHdSw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(107886003)(47076005)(356005)(83380400001)(82310400004)(36860700001)(81166007)(70586007)(70206006)(5660300002)(4326008)(316002)(426003)(110136005)(7696005)(86362001)(2906002)(7416002)(8676002)(8936002)(54906003)(508600001)(36756003)(40460700003)(186003)(26005)(6666004)(336012)(2616005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:27:57.8457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b749c96e-4557-4970-240f-08d9e1668abf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding docs for devices which are part of APE subsystem
on Tegra234 chip.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml | 1 +
 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml     | 4 +++-
 Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml   | 4 +++-
 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml | 4 +++-
 Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml    | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml   | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml    | 3 +++
 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml   | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml    | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml  | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml    | 1 +
 Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml    | 1 +
 13 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
index 7b1a08c..d3ed048 100644
--- a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
+++ b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
@@ -21,6 +21,7 @@ properties:
       - const: nvidia,tegra210-aconnect
       - items:
           - enum:
+              - nvidia,tegra234-aconnect
               - nvidia,tegra186-aconnect
               - nvidia,tegra194-aconnect
           - const: nvidia,tegra210-aconnect
diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 5c2e2f1..fef8045 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -23,7 +23,9 @@ properties:
           - nvidia,tegra210-adma
           - nvidia,tegra186-adma
       - items:
-          - const: nvidia,tegra194-adma
+          - enum:
+              - nvidia,tegra234-adma
+              - nvidia,tegra194-adma
           - const: nvidia,tegra186-adma
 
   reg:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index ba282f4..62219a5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -58,6 +58,7 @@ properties:
               - enum:
                   - nvidia,tegra186-agic
                   - nvidia,tegra194-agic
+                  - nvidia,tegra234-agic
               - const: nvidia,tegra210-agic
 
   interrupt-controller: true
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
index 0912d3e..73b98b2 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
@@ -28,7 +28,9 @@ properties:
     oneOf:
       - const: nvidia,tegra186-dspk
       - items:
-          - const: nvidia,tegra194-dspk
+          - enum:
+              - nvidia,tegra234-dspk
+              - nvidia,tegra194-dspk
           - const: nvidia,tegra186-dspk
 
   reg:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
index 19eaacc..372043e 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
@@ -27,7 +27,9 @@ properties:
           - nvidia,tegra210-admaif
           - nvidia,tegra186-admaif
       - items:
-          - const: nvidia,tegra194-admaif
+          - enum:
+              - nvidia,tegra234-admaif
+              - nvidia,tegra194-admaif
           - const: nvidia,tegra186-admaif
 
   reg:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
index c4ba12e..8d8dc7f 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
@@ -30,6 +30,7 @@ properties:
       - const: nvidia,tegra210-adx
       - items:
           - enum:
+              - nvidia,tegra234-adx
               - nvidia,tegra194-adx
               - nvidia,tegra186-adx
           - const: nvidia,tegra210-adx
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
index df81d20..4727f1e 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
@@ -26,6 +26,7 @@ properties:
       - enum:
           - nvidia,tegra210-ahub
           - nvidia,tegra186-ahub
+          - nvidia,tegra234-ahub
       - items:
           - const: nvidia,tegra194-ahub
           - const: nvidia,tegra186-ahub
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
index bb2111a..f9e4fc6 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
@@ -31,6 +31,9 @@ properties:
           - const: nvidia,tegra186-amx
           - const: nvidia,tegra210-amx
       - const: nvidia,tegra194-amx
+      - items:
+          - const: nvidia,tegra234-amx
+          - const: nvidia,tegra194-amx
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
index 62db982..bcb496d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
@@ -28,6 +28,7 @@ properties:
       - const: nvidia,tegra210-dmic
       - items:
           - enum:
+              - nvidia,tegra234-dmic
               - nvidia,tegra194-dmic
               - nvidia,tegra186-dmic
           - const: nvidia,tegra210-dmic
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
index f954be6..6188f56 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
@@ -28,6 +28,7 @@ properties:
       - const: nvidia,tegra210-i2s
       - items:
           - enum:
+              - nvidia,tegra234-i2s
               - nvidia,tegra194-i2s
               - nvidia,tegra186-i2s
           - const: nvidia,tegra210-i2s
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
index 428f3c8..ee1e1d2 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
@@ -28,6 +28,7 @@ properties:
       - const: nvidia,tegra210-amixer
       - items:
           - enum:
+              - nvidia,tegra234-amixer
               - nvidia,tegra194-amixer
               - nvidia,tegra186-amixer
           - const: nvidia,tegra210-amixer
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
index e2f5a85..c9888c5 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
@@ -31,6 +31,7 @@ properties:
       - const: nvidia,tegra210-mvc
       - items:
           - enum:
+              - nvidia,tegra234-mvc
               - nvidia,tegra194-mvc
               - nvidia,tegra186-mvc
           - const: nvidia,tegra210-mvc
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
index 41ad6517..8579306 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
@@ -28,6 +28,7 @@ properties:
       - const: nvidia,tegra210-sfc
       - items:
           - enum:
+              - nvidia,tegra234-sfc
               - nvidia,tegra194-sfc
               - nvidia,tegra186-sfc
           - const: nvidia,tegra210-sfc
-- 
2.7.4

