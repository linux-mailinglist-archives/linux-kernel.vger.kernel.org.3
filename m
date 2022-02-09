Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9E4AE8E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiBIFHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377694AbiBIEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428EC061579;
        Tue,  8 Feb 2022 20:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en8Jfi9Ubn9S2qWgCpITE4oU+NRwLnXlCE6nXK3o0Ev4vZVJErK8FtIT03iSVNWR64652Uy/1KWuFgnErins8MfsC0JDo1bBY0O4l4xkIZQVKP3XesO9X3UvFtz4nd32pAtLod1w9UbjgD4lHE48uB8yzNCfQ6eMGbC6gCQIDhU8NT2t6q0qMZ1g+379Z9NoBzSCk4mU3xaHF4dzZZXBADOvGpR84hol+sb0Zt7Zv08R2aBZBQdzrWKkpseuBwfwMwvKJkewvRipNPvUtCEAOgmgwEOsIJTctWgjJFvcJfSDoPT54CEycG8Y/JVOC7vUS1vVaruWkZkxmDZnwnSmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu72ttHvHPiKFSlrG3vD6x2qzI0NZVPRJKblpuD4p2w=;
 b=By3PfaPKu8sfG54Fx3QeywZ3Zjjtt+oVvSU6ZLWDop+jJv8qAbJs0uPFzjm399+jEk1gii7+/ZIUvkaqfLPiV06JvW2xJV31mmFonzi2S2bPvzre/43wWhp7Dg/YPvtuLo0zo4kPLYg56JJPvi7ehsyZB24tjQBwBX1fy2sG90zrLFPN8T10I3ltbWtYLNC+vjbE5YMmOAu3TmqO37NoAZCZTkl3o0Nbe1yglp6WxGaKoXWycLZCpKChQ//SfAGzqODuVhXwNEeQnSLp+p6g5/I8wReXZaamTe0L5AE9ICht82e1AfHBuocXDTAW+Lv38hBxaIBJgTreERJktDrDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu72ttHvHPiKFSlrG3vD6x2qzI0NZVPRJKblpuD4p2w=;
 b=nV5nvm4JGY3NF3SWaofniv3WRU+bAMt7xZ1Rz6dzDEiBuV0dZ4jAXnVP5vxcDNZpzsvhjgL4BTNi9p/ueSi1dKgEgK0keDHDCBp3Sae9pbfoXIeUzj9FsCYWeY1EUQkKTL5hRVjpdkJkABYkrKeHDmmvbXeITGOoSFgSwyWAcTIJb7pskeWg0fALNMyBuirgf5oDflJcv3gdvCGxf0j/UtNltvcSH+KpNoqbqhXttWrfvviSOQ/M4vDKT8DEKS12bO0GMBWAesrG4HAZ1afd3qF7gpqfpBJY5m9/yzLbjZ8QcrCC5kUuRPDiuSZhxvGcJPIw/IwufIjO9nenrLEIQg==
Received: from BN9PR03CA0925.namprd03.prod.outlook.com (2603:10b6:408:107::30)
 by BN6PR12MB1859.namprd12.prod.outlook.com (2603:10b6:404:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:23:52 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::41) by BN9PR03CA0925.outlook.office365.com
 (2603:10b6:408:107::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 04:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:23:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:23:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:23:50 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:23:47 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 0/6] Add Tegra234 HDA support
Date:   Wed, 9 Feb 2022 09:53:20 +0530
Message-ID: <20220209042326.15764-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b96e07-60c9-4b51-0fdb-08d9eb83fa45
X-MS-TrafficTypeDiagnostic: BN6PR12MB1859:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1859801BC830078E17A2DD28C12E9@BN6PR12MB1859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu6k0XI5frm4/gGHchJqqkc5qE7xZRoHNdNOp/IrAurv4tRO/Onw51mUCGh2A4OdsmwoQmssDRdiRMj1X3skdKLRgurm2+06i1vxk7TKQ1Bv2iOi/3Z8nbDZE9xOQJOzGwC6rFUIFhSfQQOjREt6pRT0BUWbdGlb0Jzt0yuci0vj7jG+tXRHQaF/HP3ztp/sARI/Yxsl6NAkcCeRrF+WO2X6myxFcVza+c1HckjUBQett1/lVNUpfhrcZJc2V3cG/kDbWOy/f7IlrA+uBAC38jvIxMOVk6FeNR6rCA1rO81rMRFBvltbDPj3FxSkxFls+ms/GLIZKfCuoMBufdOxyCDg/3EtPH5ngA1jUc9RIwkt3nSueMTR/eQflL8CgmggAnJHel8DxmOSVuSCZgiCeloNRf6J58gKRt1wFE5hFyGU/EU7DJCWUBpqEWIZI0na7+oUU2AlvbpzwPY8cP0s506/5wbLXH7lNRE0PEp56cFg/0WaHdSs+q4Kd3alTjs6PtUH5aXEfvZSU61Xw//yXdCuJpC0weDSMPgSdTd1rbM44EPo3cCyJdJ9CWGoc2ZYxxisI86DApcTtvLU3B7juxOPEMoJDE4yOfN0JW7gzzynvHOIc6zB4hRLKiTKobVPB6hk44EGcb/PyGV+8wfcDSAVn0ua7BQH20UpgPWKIeCaI+ENPu4RPCDgt9o4GYfBAZgzgIU9KG2FqYnpwt0BCl+hI0rGmH87MMLitWsoSTE=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(8936002)(70206006)(70586007)(2906002)(4744005)(82310400004)(356005)(81166007)(5660300002)(83380400001)(107886003)(1076003)(2616005)(26005)(186003)(336012)(426003)(7696005)(6666004)(508600001)(47076005)(36756003)(86362001)(36860700001)(110136005)(40460700003)(54906003)(6636002)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:23:51.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b96e07-60c9-4b51-0fdb-08d9eb83fa45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add the support for TEGRA234 HDA driver support

Mohan Kumar (6):
  ALSA: hda/tegra: Add Tegra234 hda driver support
  ALSA: hda/tegra: Hardcode GCAP ISS value on T234
  ALSA: hda/tegra: Update scratch reg. communication
  dt-bindings: Add HDA support for Tegra234
  dt-bindings: Document Tegra234 HDA support
  arm64: tegra: Add hda dts node for Tegra234

 .../bindings/sound/nvidia,tegra30-hda.yaml    |   3 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |   6 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  18 +++
 include/dt-bindings/clock/tegra234-clock.h    |   4 +
 include/dt-bindings/memory/tegra234-mc.h      |   6 +
 .../dt-bindings/power/tegra234-powergate.h    |   9 ++
 include/dt-bindings/reset/tegra234-reset.h    |   2 +
 include/sound/hda_codec.h                     |   4 +
 sound/pci/hda/hda_tegra.c                     |  33 ++++-
 sound/pci/hda/patch_hdmi.c                    | 115 ++++++++++++++----
 10 files changed, 176 insertions(+), 24 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

-- 
2.17.1

