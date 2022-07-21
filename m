Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB757C441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiGUGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiGUGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453D7B37F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3z3njbO7p5GsB8MbgghfSi80X5NmHMH8bsu8MSvK+b8+//aO7lsP4o9iAtMNqgyEfAftZyY6uIfa1lIeyk5g5TpuIK/T54FQpCh4c8CRC8Q0sRNLeCrLLW76fmagOvEXdgzguh/jCO+yMX30iaCzl1jhHCWejWnL2sTC8oA1DyLqvZByu5uDh8/tL2LbKRPVHjDdXeMyttlt8IlUHdaQlQHOrAJdnOfwgCmUnZuxTBtj/86ZCOle1hTls4JZiPwnB8vB70ZxiXYRWBX+0ZegTn4QXRilpgx4fNy3vRTNF0ItNCyOTp4NW+DfQrBFZMPCbXhYGIet4BVubYW2PUFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu7WtA8VLq4PLBGahhMcFZEooeKZAuO8ByqFi67DHjI=;
 b=KZiw3Pgq2d9Eu7AuO1tNYaTo1jdrm+ty2VmIB2Y3hHZOmIGem6q35VaPGSu8tzEat2wmy4PvmZSlDm7OuUl+i3H8Ixb6qzjnmJCyf/wnsbQ0q4OsJPJsYIbS7oVAkXfGat46UERpDFS9vrEZKGM7DUC+F9w5lHLlmkkXT5+B1u5bEDpld1vA7A/RQN+zWY5UAoBHXFZZvgo1lzKtp+07jmjSrFwbbqCFdJltu37SlkMTvLHs70PwHqYQ7Q06Yv5ARn1LhA9EmfjcuMtHh2galPxyRlTmENteHJZFYG2vyg32MabWKhfapnWbGmpBlQWmUB6wMXVgc050S5ei8GoR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu7WtA8VLq4PLBGahhMcFZEooeKZAuO8ByqFi67DHjI=;
 b=jpYMnvllZwcmOk9ikHfpIn3ke/KpvJUFm1eV0LvjRxMxNaMLmAF7KeJGVggbdJb5UVGeGjPruaJ+1jssFY2LFzMx5oFBbxl9f9ZTDomWMNLcVbv+71ZtI8+GpJhDTOYc0yT7rwMUlwdthaCNVZSrAeD/TiCNDSj1sNNSwWtY8E4=
Received: from BN9PR03CA0353.namprd03.prod.outlook.com (2603:10b6:408:f6::28)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 06:12:06 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::c) by BN9PR03CA0353.outlook.office365.com
 (2603:10b6:408:f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 06:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:12:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:12:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 23:12:04 -0700
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 01:11:56 -0500
From:   syed sabakareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <vijendar.mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] ASoC: amd: add RPL Platform acp header file
Date:   Thu, 21 Jul 2022 11:39:58 +0530
Message-ID: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2258de3e-2e35-41d9-7f81-08da6adfefc5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkbMXHek0t3oayC0sD9J0LVxvBKbnp4Dpfa9JIi9+49BwWpD836rdrzky5uc7ec7reE8iQHllDHyvIbpVLlVaSDTYc8h4gBslP++TsK9eR9jkgBBnXVE0dh2JM+PCo9xllQfI6OV4dbnfOov4XgeG/fAWST8sJxwpCPGtHx1nvH/EH3KRnFGvMgQRNL4uriEqk91T68/AXHEUZ0BufzgYwD9sbVa8l6fj/nPDS7P2sHQYQOY5PC5D8BZuQjBPUhu6msIsUwUWYgXkJF6+MlwpwWlbBcUarAniy4uH1dRZMdiT4+MVKv42M/f3Mz5f6wiiHNs6yQWhFpSFs6pK9623k6LszT7Tf+l4n48vAvkulc5cHBXqYG5eCfV9ZWU7vlHUg6wfpeRW3Cfy4mkm72EPIz/OMISvCaNYCWwc0W4gsvlPy8nbUhtSW2XpzivUGBMscISIArX8MuDHJYuVbEYtu0Anj6Z+nO00Q+yxYt6y5KvYa5JWO02Uwm49eZbFBbTPgNGEKUk38ERUBTS5Kt0PbgNMZr65H9Jp4LLsYzAcazSvq7VeaS9++iivf848UdsB8VmNpdwJ9FIFVn7KpijvYPEtZX1qDYr52Q6q5+jYofFdvLkZAknMM9YXe6zPAG/siuH7wyg+YUmdNOOpJ4G47j4T1xjRnoccKF0hgWN/4JgwBlC4DuZEI+5BvyHS4ZjqUuW+MaZ2FGMB4fdMV8HOLodRg+gP7pMrGFHg8mVK1xTqqzlCMPwBDkg/UFEQ1AgLpTPWhNE3r8QU7OrtXXUf+rwfAoXS59Hxrgtbg5Fa+4ccHwwYTfeNNPXqMQ0LfUskEe48AwoYcKKxxKe9/uzdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(26005)(7696005)(2906002)(41300700001)(86362001)(40460700003)(70586007)(478600001)(82310400005)(5660300002)(8936002)(2616005)(1076003)(186003)(83380400001)(336012)(47076005)(426003)(82740400003)(356005)(36860700001)(40480700001)(81166007)(4326008)(8676002)(36756003)(316002)(70206006)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:12:05.8670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2258de3e-2e35-41d9-7f81-08da6adfefc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Add ACP register header file for RPL platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 .../soc/amd/rpl/rpl_acp6x_chip_offset_byte.h  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h

diff --git a/sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h b/sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h
new file mode 100644
index 000000000000..456498f5396d
--- /dev/null
+++ b/sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ACP 6.2 Register Documentation
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _rpl_acp6x_OFFSET_HEADER
+#define _rpl_acp6x_OFFSET_HEADER
+
+/* Registers from ACP_CLKRST block */
+#define ACP_SOFT_RESET                                0x1241000
+#define ACP_CONTROL                                   0x1241004
+#define ACP_STATUS                                    0x1241008
+#define ACP_DYNAMIC_CG_MASTER_CONTROL                 0x1241010
+#define ACP_PGFSM_CONTROL                             0x124101C
+#define ACP_PGFSM_STATUS                              0x1241020
+#define ACP_CLKMUX_SEL                                0x1241024
+
+/* Registers from ACP_AON block */
+#define ACP_PME_EN                                    0x1241400
+#define ACP_DEVICE_STATE                              0x1241404
+#define AZ_DEVICE_STATE                               0x1241408
+#define ACP_PIN_CONFIG                                0x1241440
+#define ACP_PAD_PULLUP_CTRL                           0x1241444
+#define ACP_PAD_PULLDOWN_CTRL                         0x1241448
+#define ACP_PAD_DRIVE_STRENGTH_CTRL                   0x124144C
+#define ACP_PAD_SCHMEN_CTRL                           0x1241450
+
+#endif
-- 
2.25.1

