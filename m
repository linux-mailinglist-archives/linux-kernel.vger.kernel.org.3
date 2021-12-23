Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD247E2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348034AbhLWLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:54:02 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:32672
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233724AbhLWLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:54:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H31/MfaovhuCehngHV1CQyZPLKYnL5yhw35B4L1hSFcem6nWYJJ9B5glbOqSKP3cUMOjVm7uIMRzj9DsTvb2x/PxKIcKFBfu4ggIb89qkupFYURNwPSlKu8tfGV23zg21vxI8d8+dHCbT6etSvUAGRc7sGp4n5+Jjc/I5lW9LRWRIRFVWg5Wjogt2NhK3I1zGzgOoSwX1EX8SSHXPFOlK0xj21jkeKMSlCqjhWLkvXjAGGf/ZqFoO7n9hYbLOnZCFJdxw1cMGJIrw+mK4MdfVKBNhRcqUFcx9M6B0ClR+VpniOFu2xT9iYeUeS437ik8lqlXDH0L92SUWTLMtfY30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJPyLUU8SP5A8yPIAj67nps/ttGW0BBWBsz4tCqzN8k=;
 b=oaMvYE3Uwk+1p/xbpYcDtExms0V+H2dv0eowUpzWoOyxbGOi0TN//hxSl8bcNzWAXvJQTsoeUI1pIobsyarWXmezhLlkMenMxJYJOp/oFF9iNALE3Nl7LOCUNtWXUGOEILRZBlCQb2Yv8rk+cz7EkonBf5l4GjfXgRf/2Z1HGN4X4XXW01PJvAb2PRZlXx0WlT6SOrouougo/1jQ5EQJzSk3NW5jATc/YyZx+/xgSq+bmAihLnErE8CLSvjx1Cd3AckipNwN9qtzdAiQPHV0c4fPzJldzUWjli93XA0MU1/OwomKWsewcXLG0tRlzjitnV3FC6Njv9Yk13bMx99ZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJPyLUU8SP5A8yPIAj67nps/ttGW0BBWBsz4tCqzN8k=;
 b=AZcET4Vmvj8boltbagwgVOTSA82fMeG7R80w8j741RcAfbQ+Lf4/OPXbnkj+8O2P2D0GaIfi9RE63H8w6QN9SVZLBZzM4flx+q0fRKxpDg6ak5Kms93jvmdXphCjQXEHuGteEXYe5I8cPWFoahT58V2iA95mCZ2mo1RdmeiGLp6++3lqXYyU5RTuwcqhn++mp/mZXEjzO5vBUxP9pjQDCZttfWSnELNWWoIS35T74RKxpz45ujkqK0cO+h0HfQLIGzxmsflbhBtTUqvlHL1WS9yO5mPqPGUVWhrxAQX8oJyWTfWW5jDmv2Hv7rOyjRP33QxcbhFB06CK/jimpCg7ew==
Received: from MWHPR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:301:14::34) by CY4PR12MB1526.namprd12.prod.outlook.com
 (2603:10b6:910:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 11:53:58 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::e4) by MWHPR1701CA0024.outlook.office365.com
 (2603:10b6:301:14::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Thu, 23 Dec 2021 11:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Thu, 23 Dec 2021 11:53:58 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 11:53:57 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 11:53:57 +0000
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Dec 2021 11:53:54 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 0/3] Fix Tegra194 HDA regression
Date:   Thu, 23 Dec 2021 17:23:48 +0530
Message-ID: <1640260431-11613-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48c37ca0-cea1-4dd7-5fd8-08d9c60ae769
X-MS-TrafficTypeDiagnostic: CY4PR12MB1526:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1526502079E9240B2D29F562A77E9@CY4PR12MB1526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nO02WWS+qO1f81Pqb3KgrX2vcSO8F2VXOVKVpmYe49L0FhoGMXWyKkL3RySCDeFa5+IUK/ToTvoCSuj2wLCaBOAHtRWI3g7l7eLu+4IBcCaMCg+rKdSgUj2IiLzCqxLe1ejBM64bPFeDhKi9A5+hRMDA5fOx9JxtjFsdt9Y8DJH0VZl8Pr+fGpNtIbSU/1P/cW33w1b0HpJXPoIBiaTq7EQsQlVsFO33QdG8FNAl3lZrjfNfd9nyzIdTabAI6UyjNuQ9SicHf4/vagXyunoEge7HhUym4RN/mrCSRUpAFV8kMYKFqdAG0kdyVQfCrPiPJhlYUQFFv8ejHRpsVJskxX6scvGw9XlihDGtye7OrmE40wDh/A3AHAAsyL8zyR6+bDbMOir0BttEvnkf7uqIAcfDB4mPRCuQgWE4MRULRHV2wa8DJvspVXPMYCURfY7/s40pkYaE6Z+tQ0TwBFGorB/75LfnM0IniB27EiEB4K4FQ4VDK/ym6//51UVQzTbtMfaL3TJnsMmDwDBTSRX9h2TGi93C5repCk9AMUhDknTz9Ev3Y7qDWKXS/gsr9zbuF4ki3wfWVoHvD1lQTnjfzxpuA4Rum+E8Hh7K2O1YFsJG3HivrBT03Z6bG6xXDEFl3mCROx9TVb8PjVtVoEkHWNiOkD7/Ds2wj0xr2SBwQpuOh2Jvy2k/csD8nYKMUjTWRrHxcANn8a4fC8VG2qDbuFyj2uRq6YxGJRpkshtjuHCMU0Vu8lzdIgNuLo/NccNZ0ZpF8SCUo+KSZA9I5xPw6RuZIP8czUJF7csXzRXPPBU=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(86362001)(508600001)(54906003)(7416002)(4326008)(36860700001)(36756003)(186003)(83380400001)(26005)(107886003)(8936002)(7696005)(336012)(82310400004)(40460700001)(356005)(6666004)(110136005)(2906002)(47076005)(2616005)(8676002)(70586007)(81166007)(70206006)(316002)(5660300002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 11:53:58.2957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c37ca0-cea1-4dd7-5fd8-08d9c60ae769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA probe failure is observed on Tegra194 based platforms and this
happens due to reset failure. This series fixes the problem by
skipping the failing reset and DT bindings are updated accordingly.


Changelog
=========
 v3 -> v4:
 ---------
   * Rename SoC data variable in HDA driver patch.
   * Remove NULL check for compatible match data in HDA driver patch.
   * Drop "Depends-on" tag from commit message and add "Reviewed-by"
     tag from Dmitry.
   * Update binding doc patch as per comment from Rob.

 
 v2 -> v3:
 ---------
   * Use reset bulk APIs in HDA driver as suggested by Dmitry.


 v1 -> v2:
 ---------
   * Updated HDA driver patch to skip the failing reset instead of
     skipping resets in general for BPMP devices as per comment from
     Dmitry.
   * Used a better strucure name for SoC data as per comment from
     Thierry.
   * Dropped 'Fixes' tag in binding doc patch as per comment from
     Dmitry.

Sameer Pujar (3):
  ALSA: hda/tegra: Fix Tegra194 HDA reset failure
  dt-bindings: sound: tegra: Add minItems for resets
  arm64: tegra: Remove non existent Tegra194 reset

 .../bindings/sound/nvidia,tegra30-hda.yaml         |  2 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  5 +--
 sound/pci/hda/hda_tegra.c                          | 43 +++++++++++++++++-----
 3 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.7.4

