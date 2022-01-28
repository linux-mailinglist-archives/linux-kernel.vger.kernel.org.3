Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585E49F994
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348554AbiA1MiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:38:23 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:48065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348547AbiA1MiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDAD+xuiKOyLV77jOMPMt3UsyOZCzPwjhVmsWRqzGYof8I0mBawxj+bo+SSZX5mguhVWPX8DmpVPwW2FV6XoMLTq4RoZxLN3Ufzc20bIwe5KckgK/n1oYTBrR4UZUr8esjlRxcQRaqObNilZqmGK1m19ZhU2gzBV7F59z39+wtHbfC+7UASOWkuG/Tre78ytX+r38SIJPRAIvK+2zDm3VehhjZmP3i8y1e6WJerC7YQFP9/8z7vEvA/7fTAuqTD2MOWaQmXrvShflUQ6U9+Ed7k1QE+5S21tliLk+0bq9u0DO54UMEr7PeuOiPFmn1l1GBXbNdYxUEq9xTYMHr03rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=OrMC8zo3/NrOfYgYl0sV/jb7zGGpvKJR2utcoFTpkzM8RGUIPP14djjnoRDByxo+kQW+RTSHnJPoc3KmZit74gf5B4vKUKNvPZ1z7SLyA2+4kz3UndPYEV9czUAU0GdDPAzTuU9wpMksfNDHQlCXxojI5ORsFpgU9jBzg9YSHUp5MxcvHfpSe13P9RaDkR/Nsf4sgmNm1Zemi8qLppiF/zpRGxTx9afSgsZj4SKmqPoFfOTK03n3TIMXy4VIDnOMoN4fhdtWU1tK8TSODPWyYw5aK4UBfTi7Ve8XDHDvouJPYaCoNehLg9mLwHYprE941Ey8W3qDGfmkbnGtdqBuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5BXBcXiF0CZz5A9+FA3akI8Ppw6XZq70FgS+JGhE9Q=;
 b=fL9KwtnbvmHg2KEqCB+lM5F519z1oVBG40lGantDcmccVP7/uOSC7y8bgkseveyzQqK360EvpUReATJsRBqUAd0TVlw05kaRTi8nzSFA/NxnGfA19JoBYQQfG5MzQ+PwepNbm0I/SGujY2pGnoY7G+nM6gxXwdEje9pCod/XM0uxCE4ts7hj8q8PdFngl6z7Juhe4I6L3/V3UrMg/kKLVDSqDmD7XqrvVddl/12qJGFa0r6zSuVGTQESJR0/kzXXB9DHADaTe2yqMO3HZNS0ojbMvSKGvOkVklA1ecTDS7VDalW4/Wag5ltraVzPzmozH7z7blSz3A0pLLDnWTf+gA==
Received: from MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) by CH2PR12MB4168.namprd12.prod.outlook.com
 (2603:10b6:610:a8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 12:38:17 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::ad) by MWHPR2001CA0012.outlook.office365.com
 (2603:10b6:301:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 12:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 12:38:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 28 Jan 2022 12:38:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 28 Jan 2022 04:38:16 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 28 Jan 2022 04:38:13 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 3/5] dt-bindings: Document Tegra234 APE support
Date:   Fri, 28 Jan 2022 18:07:54 +0530
Message-ID: <1643373476-8538-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cde99c0-035a-40cb-80d0-08d9e25b0f4d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4168F049740207DD6EAFFDD4A7229@CH2PR12MB4168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmXoZOinofikr70YTISqLUL9s8jft2NV/IuOOaOat8czOv42PDvjdqRnWnhM00KQr5zqA8irmRWg+bGqpc+xgG3kDtbkV/CaFjjmrKsB8UBkApzGGcONqwrEe3d9JFqAZnTcU+qmD88e0V/ByOOLoHeKHwEneFGUJdmfh0aGy7J/KwQbgdEFocWKMGfz6TP6+DADOO7lxOvHMlmeBt36uV/Zigb93Yn+sQUERiTL1LtGW+OWYYe+maWkrBKlnmSjRXMgBhzEe1GVYINVSfkwMg6+9RXDjY9Wpu5plGyqjabK44H6NFRmX+FLPiiypSMOYI3RXVN0WkAOrnElycRy+/c9G01EKEtbXo6hX3mxUPUiMRTobH+cVdpnHPjNaHCM2OUDRSf0RbhaCufRpGL3E07AwyQvmEY4m5iuypeH0wvXzuutKFZ7uT3LWUHYAJYv8KpIkgpJnrzsqSkHK9Grf7lqmfms1sA7BzS/brLtxwYoqISmbLqYD/63G894CzLq7UENIu7UjWcmhDYZ/53CJn1hwoRhQxgs9x9oGq5UQiSkIRIzjhu7gR+FEbljj9nssjtgMjJUQ5/UoJhxTFA71CFtf4XyGQOJY4d5cvdyzYFPrfFYJU9twP4z4Oj3zgWqz/Zpg5+K9fStmMKRcrGJQV8HkaEqx7qW2hYB/knYP1udPp6NNbdKFkdSISWeuNXjKn7ZhVanaE7W/8vP8TPG1g==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(186003)(426003)(26005)(70586007)(70206006)(356005)(8676002)(82310400004)(7416002)(7696005)(6666004)(81166007)(8936002)(5660300002)(4326008)(2906002)(36860700001)(2616005)(508600001)(47076005)(110136005)(54906003)(316002)(107886003)(83380400001)(40460700003)(36756003)(86362001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:38:17.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde99c0-035a-40cb-80d0-08d9e25b0f4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

