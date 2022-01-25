Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137F449AE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453312AbiAYIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:53:20 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:42081
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376819AbiAYItH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:49:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Aw2C81j0MjM9WLlvyJGKLJm3K4Stn5m+FEAg+8kckOHhLaNerNFHZ2v1UIDX2vk0usamfdgGuZ1avskY7MSrG4e9zaLkamp3td0Cs6ppqN/FyzRqSFMoIsfrHFBotglgHE/yPbv4ir5FmUytOWTJ67KCqtWgVkQa0A5fsQSEdyor4WpWwCE7r2LHH9o/tyuqn57DCW8Z4AKy4LiUFAUEsCqw+LrkoblRDnGFRAUE+uJhjPsgfXnHgimDRN3zAq/1RDvT84E4FT79kdgb+85RTJnVzMgVZJpH/0E6GSxO0VDRYNJ4djphEEtYoUbLOdZOZeZgpfNHvX5946s3l4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=inthe4CjnSPm82+6Pz2eSzn6WaM001cQo0EM37hdY4oDF91oo+Tzi27TxierdMgDiMj6eS9OR2XS3zMNLAc53eH9wr2NYoVzjTVdLo0or1aPb2Gcpc6Aa2I2aNpRDPBJvSWbclyh/Yumu0nbwpzQXzC9CNsj7DEbucRFj1H8yiOgbHEdS3QyAW/B5q0I07sFJFGWQ1MsU0Nqj98COaLoLdFJfaepF5Muldoo8mccTY7FRI7p5YGWKSuUD3eCBWwytdViUDDkqRSyRGlUrXKrtgDwHb/xVDlUMAOqeZLZIU7xlZrEZDPpO7vmfEz9XuRZyxxcGULwF8/zuS7lmr9SFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=F+VKLBG0o6/mddOwYuaw57svYb7uJkZyz7/p/mDL2o4HlspzswmAYCeKclmQXHSioA57M0ch5N/kRTNWhzQ9Q0vW6dc7SBuARmERzmCOyL1YcGRT3B9V4Ey1jQwrX8Os2Im4uLMVgrXvus4Z/5CiaTL0hR56jAZWPbvUXSE6X0UF2JZoWlhKR9HhZAZFw4195L3hi7qc3Lt0CA+qtgKY/ed3rnYvDmCe9scML917j8PtuIlezGSD9KoMQmd0EodZ5zlymYC7uLX0VT9xTjSh6bgjdHps/mnJlxJxQ5NlZym9LZVRMxAoY7ylp8GIM5fvDMRfJaI/y7S4eQZpsPf6xw==
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by SN1PR12MB2462.namprd12.prod.outlook.com (2603:10b6:802:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 08:48:59 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2b) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 08:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:48:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 25 Jan 2022 08:48:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Tue, 25 Jan 2022 00:48:57 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 25 Jan 2022 00:48:54 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/5] dt-bindings: Document Tegra234 APE support
Date:   Tue, 25 Jan 2022 14:18:09 +0530
Message-ID: <1643100491-5398-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb8da50f-0e5f-4d8f-79e9-08d9dfdf872d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2462:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2462EAFF06C479094C8F8605A75F9@SN1PR12MB2462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emYSrPrVvZhLxaWu0pRvUcc2glJxJAvzKF+47PHBtf7ILytDjEOHgyqPguWyoLa+SUCUMpoUNf6yfWYD5X/1KIHeZT6SyK65IP6csgHaOufL24iO2KOEic4CjtwFFP1pRH9VFrlDM9rd1jNKb8LEyG54rtJ91XdZ9oL4dnoXvJSHbjlkyq9xr/QEhd6NNlVcn7ZQK2VrGc0bBT2/60EPLukNJLjpelUwUhNXfs1Q2PYESY/S8pnp7GhNgG6Pu8yDKzUZJ/ByIZ/zvAPgDPbcojLEz2LzlZ0bjlITAWF+aTbDyl5pwsYEGFUHOj/mVkdvHiGmp/+ezUa5zSRAACvB8i5/i3BoluRT3KzPkz3HywaGGyHlOWSvUqrb6JR3vxaFyt9JTTK2JLMCpFTEbOzmvIXYGqIqJjMT9aSK3QBRTnElNiTtlhBnaDSOovsdZp1b8420ml0f5c7CL8oO5m2LzPJDKUxfTC9Emzyumx5h6jEhEjZ4PUqAmPt758I4dQce+kFMmxY0wv7OxmveNAyOvzsvu+RIDZ0Yy6XIgrps3NSAA3nruSU8iszLNxA9VnGMS1mArxps3qlExYnd1k8TTe+99Y+xeklTdSDu3/en2A/I6AO7U0gSWqaaoWqzBI8eUdmTTZR8LGLJnmSw5Hp+6lW20u+SMaF0s3ZWvItUvx1bXmFKn8HRILh2bgjUEEHFuikOqvztOvt4yL6aCao7PbU7lzlcEnrsUf+pQzzInYtvzAqtXv5xo/HGpVHXrozfEaFumyR0kMG1KqQ6wEpVQyFs9uFhSukn2SQAMkepDd8=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(6666004)(8936002)(8676002)(26005)(356005)(83380400001)(54906003)(47076005)(7696005)(36860700001)(70206006)(81166007)(70586007)(316002)(110136005)(7416002)(186003)(426003)(2616005)(36756003)(40460700003)(86362001)(82310400004)(107886003)(336012)(2906002)(5660300002)(508600001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:48:58.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8da50f-0e5f-4d8f-79e9-08d9dfdf872d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2462
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

