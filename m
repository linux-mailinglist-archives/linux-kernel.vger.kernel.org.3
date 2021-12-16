Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C97476DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhLPJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:47:02 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:30209
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235787AbhLPJq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:46:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVpXiUXHkx7jSrPfbcvt+DVvrPRdZieGdNbTZiE9yFdyaDoO3ZdNLiRmbZyW4Oz75kGX/AWtZufkQpIzagnQndbDdynpywVTs4yaoVwlfKK9Bth2l7y0jWpISBOi40IIS8v/oN67GBavuqqYw7DpoD+D4SGT+1nJoqjOYA45/wZnLVZNB8aBYgMvikLVPfC8VJhZRaTTKOY0E2YF0V1d32SyR+pv0N8fHwF4jqabi5syiLok6o1I7COPo1UHGHeFUCX05Zyfsz+aCL1WR9ZAvNuoPZY/m9+wTLe44fg1xqaQLJAOoAgrDxuHBnfJPvzInCQo4r19mcg0wuJj9XKSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfuSLsyoaEuITipvRFl5mGZRlscpdhvCf88Nx3TLv1M=;
 b=LRlZOWj0KAw2UU74ihfhLZRZ+dDRne6fq3LAWhpj6Dzo4gnPPc1uozDo0+SsMqQy70jBHQ4DAmwMVlmKm4WKRleLLWugmKOyjxA3wwBJbLdO2gPT8GoUCheFLMx/Ik8dTNxkoxZ0zMCJkSIxb0FOdn6wDw7nIqf+m+/QHyeaiKXa9mc9rML/PhAM359bmZyUaWFteL2S7kwBI28IZcsGmMwUw3Gc4Su1J44sunOR3P6QWzAlrUw+OxTQZ6YDNRXqjE9rMIaKx/Hv3hWPHrFOlZnpDRZcVRaXHCj6drkPwO+ruItdGk44aAIiKcVMNK+ss71ZQFo3DryBZzEDe684kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfuSLsyoaEuITipvRFl5mGZRlscpdhvCf88Nx3TLv1M=;
 b=GOxDqRoC39UpbUSyoMGO97VcK6pOdTsdYquB6HhqJf/3eEToKBuuWx6PTV8A+r4ARYzRdzWTiDMGzDZ/7mnEsHzmI/wVvG9jxdsd0CfjSzAOxo1BFgEwwXgEXLaiH6cc2lhuOFceo4Apek4q+lt/iv1C9A0rhvrZncu+M8veRjK+9+iHAU4X8DJEKlngrS+mPnxuRiVRDxzFQLG0PS4qruw0syeR/yGnSA5gsUH6dAG+TBWRna6fXaRf7Xe0af7yhPEfCeHLhf8zpD3gLky9ON1hkeXM7oGM/r7fXdrHEDo0msyEvgOlM7FQH2tW4dXXqV6vL8s95klQBsLyQGIGRQ==
Received: from BN9PR03CA0972.namprd03.prod.outlook.com (2603:10b6:408:109::17)
 by CY4PR12MB1126.namprd12.prod.outlook.com (2603:10b6:903:3d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 09:46:25 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c8) by BN9PR03CA0972.outlook.office365.com
 (2603:10b6:408:109::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 09:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Thu, 16 Dec 2021 09:46:25 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 09:46:24 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 09:46:24 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Dec 2021 09:46:22 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <anrao@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH] arm64: tegra: Update SDMMC4 speeds for Tegra194
Date:   Thu, 16 Dec 2021 15:16:10 +0530
Message-ID: <20211216094610.12697-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121f199f-32d0-43bc-e44e-08d9c078ed3a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1126:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB112677B2F54B75371E92A109B7779@CY4PR12MB1126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpBk8+NkIzxjgdD8eoODMWerKLqXFadNntvVo4H2+FGrBoCt9r5mqdYbs121q3E/B+AjLaZDUY8DR2ZmE3/2GPoFen2GyTUIDZu+GCR4VnkCYIhLE1rpwwE/DY6tVjp8Yr23cT4QwG07RHv0IhwrgloVRH4OQc2sRRcGkHQsOFNwfXk4Phrd0b2kFxNcFzhuf0gjpe5xp1idiVT+CKO0UDnJmw3Hebzb7iSbC3mQOKbpaVCgKsp0aGAfjJFSZ+RrohuuknbT8G9x9tzwKwtgwALodATh8HyeO/SltmSVc4JRHbaQ26697ard8bF1ZqJ1jZTTpEXW6vCgOe6eTCBgg51yPdg6b6OiRIQeDEdcI/nr9H6mR1fr4KDtuucarAVuxRSdc/0iBp6WP7QZZdk9+Q8r2kjcjNBMRQfWDf+aSf8AOv7g8LICDtBm5m83JvQLx33VjxwesUEtEbVhcWsqq/G4vh4Nz7FZqio9G1FMl1Wg7YyQJrsdNO7enmJ659H/QgUyj86MyMwM+MTRkbqsFj/L9M/8DDbMb9PP4INXP97jL5WcnNsoT/9zFsfYwr+6H5W2DpuaR6IU9mfEd6dkN6Uf3laMyRHNjlB8FTt0NAKrTSnYEaIqpTpH8+lJrAnrjMtdSA0cc31Jw12Xn9WxS87unCPUpMn8WtNA3G0jtnyYp7WsynTI+6H6HLoKJ5Uo8+uIiwOE5fgghItX2Zy5p9ovvoTXkkUpbSGZ1Fno0b8G9pLoe1Tgf6f5Q/dxN1d8gFuaB7jlj/DpCjDgky9v2fBpvJ2KVhkyAdRjofHMuL9CADhzy47TXyWMnRzzyepac8LqVjV7KJyYukuEminbBg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(83380400001)(70586007)(336012)(5660300002)(107886003)(316002)(26005)(70206006)(7696005)(47076005)(4326008)(40460700001)(356005)(2616005)(6666004)(1076003)(2906002)(86362001)(110136005)(36860700001)(54906003)(34020700004)(8676002)(4744005)(82310400004)(8936002)(426003)(508600001)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 09:46:25.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121f199f-32d0-43bc-e44e-08d9c078ed3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required device-tree properties to populate all speed
modes supported by SDMMC4 instance of Tegra194 SDHCI controller.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index b7d532841390..6424fc85ac19 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -805,6 +805,11 @@
 			nvidia,default-tap = <0x8>;
 			nvidia,default-trim = <0x14>;
 			nvidia,dqs-trim = <40>;
+			cap-mmc-highspeed;
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-hs400-1_8v;
+			mmc-hs400-enhanced-strobe;
 			supports-cqe;
 			status = "disabled";
 		};
-- 
2.17.1

