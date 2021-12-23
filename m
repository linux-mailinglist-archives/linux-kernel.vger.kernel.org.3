Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA347E2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348073AbhLWLyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:54:11 -0500
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:47361
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348041AbhLWLyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:54:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkvEwBopqAD06RnJ3DtzOoVXCy7P2qj3sC3XhVc43hS2Y87C1v0t0IMBGYtzxqFnx6/SwlmFrx+dGBrDtnaub5eNqSb3sO4hp7rnIfZaRPOmPtpyaZlz+xNtew9lq0IwCs1eVrmKniITQaxo3GVJOci+upJa6VlNMUEDbZ0Nf53JjbbqrrtwuAUu+wMCFmvPrzBMnGTMn/v3/AwzqOTwdALPpJGfMuqIeMH5KTMu8wiZQvZPcosnWRqVjmD5QPL1inf96nl8AeMJch60qkADy1okcIy1nzKZCxgFnJ+LuwwQRZG6IxceikpOpl6xoTeyg4NZf39a36RJgXs1rHahnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulSJVnov98VSqK8ZFklLKmRw1vyICyDm0P/U07+u9Fg=;
 b=g188xkCcCf3SRLczUMEt4nt/ik6+hBCqrlv7HueFJ4qr4f/bk2NggxNjkor1l/yAyXJYrzK8wuQxzTpOGdM4AziBYn85yCoYWeuT6qlsg0u7+j8juuVTLEO0dJ34Nf/eXbj2CRWafqwYBjaRxSXB3QAAVw4Q+oZ/pN7gASTzfkKv+M4DeQNNJBrQgkS0rDaPoZf7zY6+wcndHUWtAr+Sf0zeEe9wtYcguQrVVNO+QZ/McUL+O8NLr5rzcxJGQCKuuQ53IBUnSS4WY1zNXNIJwiIjrIlJC/raj7R8TOjhtxy/xxX+1s3G5Ut6jSH9bLWaZpfgthIkkGZWhRoGc9jTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulSJVnov98VSqK8ZFklLKmRw1vyICyDm0P/U07+u9Fg=;
 b=W9nwosHWM0WJiXKzCDhAFHqeh05LuH1+XL9whmH+88aS1UFp+JRoL9xkr0V0zjLrscCgTQlECvaGEv2HdB9ax5z2NdEjEs8nsbCj+q+gkavq48tdEzg7HaTB0z64yMZ45XTp39KoCNaT6mEvgKrK3Wi2bk/tyaj0ONwii6TcVH5FVWu9KxgMmHMhIxnsbR6meiXUuRg7aRa6mOMm3rx+pAbHrXyZes7Cx1pPGrEfJ2Kd3erb3HN8dt9fA+sMcvQKqHcKk/dBFG2R4DCUX5ag1+TB28pJLqLL5hPu5LxVKhy/fpH12MRzNft8lKzVxNB2kqe+UtcX1fAMEX+qTPNbFw==
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 11:54:06 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::48) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Thu, 23 Dec 2021 11:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Thu, 23 Dec 2021 11:54:06 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 11:54:05 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 11:54:05 +0000
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Dec 2021 11:54:02 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 2/3] dt-bindings: sound: tegra: Add minItems for resets
Date:   Thu, 23 Dec 2021 17:23:50 +0530
Message-ID: <1640260431-11613-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640260431-11613-1-git-send-email-spujar@nvidia.com>
References: <1640260431-11613-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4624e131-2b7e-49c6-bb14-08d9c60aec5c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4190AC5375FBBB70FDFED282A77E9@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fg+VDGm1QZPt0N00PgnX1hg0bao+LpezLMvkl5uEJvEdAODBCdmPkqvRWR93kDt79o55qwEBSL5o/H4A/zKFXnMih9CluUDxbNMBIgUCMAVU9Iwzi/78zNNCezB7AC93BhHqWcIru7i2fgseu07GybT/FgGU3Mr7v2ezp9LP6QjeF3dWrpSsR9ga3bbbacdZ2wr0nebjqmBVnqVjgZWfwymPiZ9dtBcMlamTD5meGuToX6seoSTJ/dGOerAH+irjCaE6ZUPABfz7bdmYJVuCfVCMA5CuOhI5lOkW4JOAgTJjGUcf3BCxTYrQqvli00Iy+CcIGi4hWVvO/62fRsnkzBPfNSBznCvNQODDUuufV+O3FJ9qHOx20BukfwAHgoNYCRcb0ODcwhTdsHjIdkEcZ/DhN3hCSKaYyKP416WBTbmMCZ3F1bREAcnzxQvB5dA5dpsMEgx4FQQryrdszH5mTukYhGUeCNq9YLEvzITOne3C5H1vvru3BfHa7pUXT3+8i3gDwKErHYfhmqlP/KPydy0RKPQoSM6OWqopoKYbCX3IVVmWa8ObzxJmisr58A5qqJ0k3ighcTpzMIVMFT00E9tmMQADNyilt1CybNIIKW/lZ19QLY5oSPdyf/4Hp1LWqFKExYQJaTuTmCppkXm/zQp7+LOuKsmWjP4cjKsWlgTXvtVgl9xngBXYS4LGEWpB55xQQTJckihQC0zQU4L/roQa4gXo/ZFOMY4B+Sd9axopYzdeOQChuyVm/nWLlnD1QM/2itmGT8KBqZ6QkvXA9ifWQOhBDc8Ze29SSdy/Cb0=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(2616005)(4326008)(86362001)(36756003)(26005)(7416002)(36860700001)(336012)(426003)(186003)(508600001)(107886003)(82310400004)(40460700001)(2906002)(81166007)(70206006)(6666004)(47076005)(70586007)(316002)(8936002)(8676002)(110136005)(7696005)(54906003)(356005)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 11:54:06.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4624e131-2b7e-49c6-bb14-08d9c60aec5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 HDA has only two resets unlike the previous generations of
Tegra SoCs. To take care of this set minItems field to two.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
index b55775e..2c913aa 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
@@ -50,9 +50,11 @@ properties:
       - const: hda2codec_2x
 
   resets:
+    minItems: 2
     maxItems: 3
 
   reset-names:
+    minItems: 2
     items:
       - const: hda
       - const: hda2hdmi
-- 
2.7.4

