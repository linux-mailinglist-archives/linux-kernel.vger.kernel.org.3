Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE171591083
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiHLMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiHLMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:09:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDEB028D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvYN1h6HADMfG9mUwOLp4jE65MjWJbGGyax2JEEGJUnOf6Y2xmFpsJElh5C1AVybk5cn0H+rxCjuVUOVJ/mUjxNA4BV9cL6xCoxKAiYxl3Jfhyr3jAaYobuW1W825gUo745/I5QAdrohcigVcjUETiqv3Bo+GMCs5nHWgx/EJR9ae9ySHwOZyJKkRPfcAo8G9d7pO9PxYELOCOAFKihWnBoSPYntRtmo8Q17pnbuQY1M3xoP0xYGr9Skp63OhBOr4Rx4B1jleUWfP7Bnprx+qL1xCBKOoWCjAbVQbS3eBcy3o0bcZvJgNHl04y3Bsr7g9Plh8mfdMUxmwCYU3ph4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7E5brQv8suEaHjy73LVr806/SwtxxgxfCanTtI70lg=;
 b=jwcVBfWY8eteMDOFyTRjGEI3v+10Xu/kmndZ6+v8ouOfTWEchMMaQj3LnSJ8wfhaQdCz3/Fdb1/74D4pUAT6BgV2Y7ocqsraN67/AGRgRdrRTkzV5sQQZ/6AnmkacgnWL3zQx68Sm49boBt5aWmtZE49V4cCCkbJN+Sy5pD+B0OZuQvcdZyn7kaRyImlqoXP1LEbS+ozfy3oG7KzfOYlxoipJpOyDcAYZxoTbrqZPZTr/xSmsqflbgYLSf8wyNfJdeUs4rRAXuhgehupmop35WSpI8Y1XR/pjFUr7AY4+8RaxcjlAqH28nM0GaOuKA2PqGxpR+10iljD9I58Ti/UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7E5brQv8suEaHjy73LVr806/SwtxxgxfCanTtI70lg=;
 b=lDcI9wLw/z8WrGq/gKAUusCQeVgIdIyDAve3hnsV8oHY5+Tk6sYRq0JHHMHgnWXoo0WvLoLG0SYcM7rW+vvZMOgUf+R2wQWstdhHwLEwTizcO1+QZXa1gGXNWnF4pVMth3JZfe7g3Voi9OHp02SGo9+NMYbsb0OauKqsPcbu18g=
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 12:09:26 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::83) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Fri, 12 Aug 2022 12:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 12:09:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:09:25 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:09:22 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/13] ASoC: amd: add Pink Sardine platform ACP IP register header
Date:   Fri, 12 Aug 2022 17:37:19 +0530
Message-ID: <20220812120731.788052-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16236279-4f04-4a67-ed24-08da7c5b803d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMIer8RwDcsiMsMxCAGVhkGWHsqNT05yGgF3VyhU+82CytlPUWGvJbiNNl+Xm0jLM2ii9b6E5fWMwdaYo4yaR6M7cEIPk7a5GBSLyhP/HwoFjMLN25Xb+xnAGGjXvyDQKkIl/YPMgNaba7p4bh1uguqGBvWzThK0cRJpmjyP7I0p2DM37GdFS7iEl/Mpru/y/EWhpH90na9coqPzs9FjLLg3MU0F/JjzH/6PE5j4ckLxedZJJP9us5XIwNKtvVvi/FKEOyWiPtERP+IGHxUivNcvRq1QE74Bt0wUCQKjj8AnJ32cqq8dzAHpuRCcdPudX9AzY4s5mJiYUlEcFyxt4716dmF0EQEtM9MsvbfpZAzk1x4AAlkStPBRKI+o/tJ8ZiFibYlQrFzWdXMTLLwsYJi4Ib0fYupnR8U8guDK2LB2lcMG0c5U6wtxcNlbjgWIBmhgeNY0T2PiOF82nWcWVnJxWV3GXGs3ZpXehXzNNCAh/wRVWqdWqgezeezlw+HmLG/IXJIeEjo4NRwdN0OnmJjXMXqkKlkwNnOXYQbA9yCVuVpNtP3D1y0vjui+vV4PsgpaXPQrcQV+nG7GIQAVCA95HddblY5joc/D9i2C3oJ8zlUMpG2qkhSxtQUEOEl2IkXyirTW75sGVk9tkocyQzuz0QwZ7Gi0ooM+XOofzZ9hYH9owSbM1oYUVtVWIHJYkDwWTaEaO8hzFwR+KEJcYF6AQ6Y+fQv1UsyUsDPrU3oe/xvRrTEIIuf7pLsx6R8PR/Td6NX9wepLq3uInbN39yvyTOBKkXO/XDnKqJ1VWGP2kC32qTgq713+NPGMkxHm4oczgEwDRjk4f9YCDhNHug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(8936002)(36860700001)(8676002)(40480700001)(54906003)(36756003)(83380400001)(426003)(47076005)(40460700003)(110136005)(70586007)(70206006)(316002)(4326008)(186003)(5660300002)(2616005)(86362001)(41300700001)(6666004)(1076003)(30864003)(336012)(478600001)(2906002)(81166007)(356005)(82740400003)(7696005)(26005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:09:26.0975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16236279-4f04-4a67-ed24-08da7c5b803d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACP IP Register header for Pink Sardine platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 include/sound/acp62_chip_offset_byte.h | 444 +++++++++++++++++++++++++
 1 file changed, 444 insertions(+)
 create mode 100644 include/sound/acp62_chip_offset_byte.h

diff --git a/include/sound/acp62_chip_offset_byte.h b/include/sound/acp62_chip_offset_byte.h
new file mode 100644
index 000000000000..0c85e4c3daae
--- /dev/null
+++ b/include/sound/acp62_chip_offset_byte.h
@@ -0,0 +1,444 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ACP 6.2 Register Documentation
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _acp_ip_OFFSET_HEADER
+#define _acp_ip_OFFSET_HEADER
+
+/* Registers from ACP_DMA block */
+#define ACP_DMA_CNTL_0                                0x1240000
+#define ACP_DMA_CNTL_1                                0x1240004
+#define ACP_DMA_CNTL_2                                0x1240008
+#define ACP_DMA_CNTL_3                                0x124000C
+#define ACP_DMA_CNTL_4                                0x1240010
+#define ACP_DMA_CNTL_5                                0x1240014
+#define ACP_DMA_CNTL_6                                0x1240018
+#define ACP_DMA_CNTL_7                                0x124001C
+#define ACP_DMA_DSCR_STRT_IDX_0                       0x1240020
+#define ACP_DMA_DSCR_STRT_IDX_1                       0x1240024
+#define ACP_DMA_DSCR_STRT_IDX_2                       0x1240028
+#define ACP_DMA_DSCR_STRT_IDX_3                       0x124002C
+#define ACP_DMA_DSCR_STRT_IDX_4                       0x1240030
+#define ACP_DMA_DSCR_STRT_IDX_5                       0x1240034
+#define ACP_DMA_DSCR_STRT_IDX_6                       0x1240038
+#define ACP_DMA_DSCR_STRT_IDX_7                       0x124003C
+#define ACP_DMA_DSCR_CNT_0                            0x1240040
+#define ACP_DMA_DSCR_CNT_1                            0x1240044
+#define ACP_DMA_DSCR_CNT_2                            0x1240048
+#define ACP_DMA_DSCR_CNT_3                            0x124004C
+#define ACP_DMA_DSCR_CNT_4                            0x1240050
+#define ACP_DMA_DSCR_CNT_5                            0x1240054
+#define ACP_DMA_DSCR_CNT_6                            0x1240058
+#define ACP_DMA_DSCR_CNT_7                            0x124005C
+#define ACP_DMA_PRIO_0                                0x1240060
+#define ACP_DMA_PRIO_1                                0x1240064
+#define ACP_DMA_PRIO_2                                0x1240068
+#define ACP_DMA_PRIO_3                                0x124006C
+#define ACP_DMA_PRIO_4                                0x1240070
+#define ACP_DMA_PRIO_5                                0x1240074
+#define ACP_DMA_PRIO_6                                0x1240078
+#define ACP_DMA_PRIO_7                                0x124007C
+#define ACP_DMA_CUR_DSCR_0                            0x1240080
+#define ACP_DMA_CUR_DSCR_1                            0x1240084
+#define ACP_DMA_CUR_DSCR_2                            0x1240088
+#define ACP_DMA_CUR_DSCR_3                            0x124008C
+#define ACP_DMA_CUR_DSCR_4                            0x1240090
+#define ACP_DMA_CUR_DSCR_5                            0x1240094
+#define ACP_DMA_CUR_DSCR_6                            0x1240098
+#define ACP_DMA_CUR_DSCR_7                            0x124009C
+#define ACP_DMA_CUR_TRANS_CNT_0                       0x12400A0
+#define ACP_DMA_CUR_TRANS_CNT_1                       0x12400A4
+#define ACP_DMA_CUR_TRANS_CNT_2                       0x12400A8
+#define ACP_DMA_CUR_TRANS_CNT_3                       0x12400AC
+#define ACP_DMA_CUR_TRANS_CNT_4                       0x12400B0
+#define ACP_DMA_CUR_TRANS_CNT_5                       0x12400B4
+#define ACP_DMA_CUR_TRANS_CNT_6                       0x12400B8
+#define ACP_DMA_CUR_TRANS_CNT_7                       0x12400BC
+#define ACP_DMA_ERR_STS_0                             0x12400C0
+#define ACP_DMA_ERR_STS_1                             0x12400C4
+#define ACP_DMA_ERR_STS_2                             0x12400C8
+#define ACP_DMA_ERR_STS_3                             0x12400CC
+#define ACP_DMA_ERR_STS_4                             0x12400D0
+#define ACP_DMA_ERR_STS_5                             0x12400D4
+#define ACP_DMA_ERR_STS_6                             0x12400D8
+#define ACP_DMA_ERR_STS_7                             0x12400DC
+#define ACP_DMA_DESC_BASE_ADDR                        0x12400E0
+#define ACP_DMA_DESC_MAX_NUM_DSCR                     0x12400E4
+#define ACP_DMA_CH_STS                                0x12400E8
+#define ACP_DMA_CH_GROUP                              0x12400EC
+#define ACP_DMA_CH_RST_STS                            0x12400F0
+
+/* Registers from ACP_AXI2AXIATU block */
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1                0x1240C00
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_1                0x1240C04
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2                0x1240C08
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_2                0x1240C0C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_3                0x1240C10
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_3                0x1240C14
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_4                0x1240C18
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_4                0x1240C1C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_5                0x1240C20
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_5                0x1240C24
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_6                0x1240C28
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_6                0x1240C2C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_7                0x1240C30
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_7                0x1240C34
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_8                0x1240C38
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_8                0x1240C3C
+#define ACPAXI2AXI_ATU_CTRL                           0x1240C40
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_9                0x1240C44
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_9                0x1240C48
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_10               0x1240C4C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_10               0x1240C50
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_11               0x1240C54
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_11               0x1240C58
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_12               0x1240C5C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_12               0x1240C60
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_13               0x1240C64
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_13               0x1240C68
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_14               0x1240C6C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_14               0x1240C70
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_15               0x1240C74
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_15               0x1240C78
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_16               0x1240C7C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_16               0x1240C80
+
+/* Registers from ACP_CLKRST block */
+#define ACP_SOFT_RESET                                0x1241000
+#define ACP_CONTROL                                   0x1241004
+#define ACP_STATUS                                    0x1241008
+#define ACP_DYNAMIC_CG_MASTER_CONTROL                 0x1241010
+#define ACP_ZSC_DSP_CTRL                              0x1241014
+#define ACP_ZSC_STS                                   0x1241018
+#define ACP_PGFSM_CONTROL                             0x1241024
+#define ACP_PGFSM_STATUS                              0x1241028
+#define ACP_CLKMUX_SEL                                0x124102C
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
+#define ACP_SW_PAD_KEEPER_EN                          0x1241454
+#define ACP_SW_WAKE_EN                                0x1241458
+#define ACP_I2S_WAKE_EN                               0x124145C
+#define ACP_SW1_WAKE_EN                               0x1241460
+
+/* Registers from ACP_P1_MISC block */
+#define ACP_EXTERNAL_INTR_ENB                         0x1241A00
+#define ACP_EXTERNAL_INTR_CNTL                        0x1241A04
+#define ACP_EXTERNAL_INTR_CNTL1                       0x1241A08
+#define ACP_EXTERNAL_INTR_STAT                        0x1241A0C
+#define ACP_EXTERNAL_INTR_STAT1                       0x1241A10
+#define ACP_ERROR_STATUS                              0x1241A4C
+#define ACP_P1_SW_I2S_ERROR_REASON                    0x1241A50
+#define ACP_P1_SW_POS_TRACK_I2S_TX_CTRL               0x1241A6C
+#define ACP_P1_SW_I2S_TX_DMA_POS                      0x1241A70
+#define ACP_P1_SW_POS_TRACK_I2S_RX_CTRL               0x1241A74
+#define ACP_P1_SW_I2S_RX_DMA_POS                      0x1241A78
+#define ACP_P1_DMIC_I2S_GPIO_INTR_CTRL                0x1241A7C
+#define ACP_P1_DMIC_I2S_GPIO_INTR_STATUS              0x1241A80
+#define ACP_SCRATCH_REG_BASE_ADDR                     0x1241A84
+#define ACP_P1_SW_POS_TRACK_BT_TX_CTRL                0x1241A88
+#define ACP_P1_SW_BT_TX_DMA_POS                       0x1241A8C
+#define ACP_P1_SW_POS_TRACK_HS_TX_CTRL                0x1241A90
+#define ACP_P1_SW_HS_TX_DMA_POS                       0x1241A94
+#define ACP_P1_SW_POS_TRACK_BT_RX_CTRL                0x1241A98
+#define ACP_P1_SW_BT_RX_DMA_POS                       0x1241A9C
+#define ACP_P1_SW_POS_TRACK_HS_RX_CTRL                0x1241AA0
+#define ACP_P1_SW_HS_RX_DMA_POS                       0x1241AA4
+
+/* Registers from ACP_AUDIO_BUFFERS block */
+#define ACP_I2S_RX_RINGBUFADDR                        0x1242000
+#define ACP_I2S_RX_RINGBUFSIZE                        0x1242004
+#define ACP_I2S_RX_LINKPOSITIONCNTR                   0x1242008
+#define ACP_I2S_RX_FIFOADDR                           0x124200C
+#define ACP_I2S_RX_FIFOSIZE                           0x1242010
+#define ACP_I2S_RX_DMA_SIZE                           0x1242014
+#define ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH            0x1242018
+#define ACP_I2S_RX_LINEARPOSITIONCNTR_LOW             0x124201C
+#define ACP_I2S_RX_INTR_WATERMARK_SIZE                0x1242020
+#define ACP_I2S_TX_RINGBUFADDR                        0x1242024
+#define ACP_I2S_TX_RINGBUFSIZE                        0x1242028
+#define ACP_I2S_TX_LINKPOSITIONCNTR                   0x124202C
+#define ACP_I2S_TX_FIFOADDR                           0x1242030
+#define ACP_I2S_TX_FIFOSIZE                           0x1242034
+#define ACP_I2S_TX_DMA_SIZE                           0x1242038
+#define ACP_I2S_TX_LINEARPOSITIONCNTR_HIGH            0x124203C
+#define ACP_I2S_TX_LINEARPOSITIONCNTR_LOW             0x1242040
+#define ACP_I2S_TX_INTR_WATERMARK_SIZE                0x1242044
+#define ACP_BT_RX_RINGBUFADDR                         0x1242048
+#define ACP_BT_RX_RINGBUFSIZE                         0x124204C
+#define ACP_BT_RX_LINKPOSITIONCNTR                    0x1242050
+#define ACP_BT_RX_FIFOADDR                            0x1242054
+#define ACP_BT_RX_FIFOSIZE                            0x1242058
+#define ACP_BT_RX_DMA_SIZE                            0x124205C
+#define ACP_BT_RX_LINEARPOSITIONCNTR_HIGH             0x1242060
+#define ACP_BT_RX_LINEARPOSITIONCNTR_LOW              0x1242064
+#define ACP_BT_RX_INTR_WATERMARK_SIZE                 0x1242068
+#define ACP_BT_TX_RINGBUFADDR                         0x124206C
+#define ACP_BT_TX_RINGBUFSIZE                         0x1242070
+#define ACP_BT_TX_LINKPOSITIONCNTR                    0x1242074
+#define ACP_BT_TX_FIFOADDR                            0x1242078
+#define ACP_BT_TX_FIFOSIZE                            0x124207C
+#define ACP_BT_TX_DMA_SIZE                            0x1242080
+#define ACP_BT_TX_LINEARPOSITIONCNTR_HIGH             0x1242084
+#define ACP_BT_TX_LINEARPOSITIONCNTR_LOW              0x1242088
+#define ACP_BT_TX_INTR_WATERMARK_SIZE                 0x124208C
+#define ACP_HS_RX_RINGBUFADDR                         0x1242090
+#define ACP_HS_RX_RINGBUFSIZE                         0x1242094
+#define ACP_HS_RX_LINKPOSITIONCNTR                    0x1242098
+#define ACP_HS_RX_FIFOADDR                            0x124209C
+#define ACP_HS_RX_FIFOSIZE                            0x12420A0
+#define ACP_HS_RX_DMA_SIZE                            0x12420A4
+#define ACP_HS_RX_LINEARPOSITIONCNTR_HIGH             0x12420A8
+#define ACP_HS_RX_LINEARPOSITIONCNTR_LOW              0x12420AC
+#define ACP_HS_RX_INTR_WATERMARK_SIZE                 0x12420B0
+#define ACP_HS_TX_RINGBUFADDR                         0x12420B4
+#define ACP_HS_TX_RINGBUFSIZE                         0x12420B8
+#define ACP_HS_TX_LINKPOSITIONCNTR                    0x12420BC
+#define ACP_HS_TX_FIFOADDR                            0x12420C0
+#define ACP_HS_TX_FIFOSIZE                            0x12420C4
+#define ACP_HS_TX_DMA_SIZE                            0x12420C8
+#define ACP_HS_TX_LINEARPOSITIONCNTR_HIGH             0x12420CC
+#define ACP_HS_TX_LINEARPOSITIONCNTR_LOW              0x12420D0
+#define ACP_HS_TX_INTR_WATERMARK_SIZE                 0x12420D4
+
+/* Registers from ACP_I2S_TDM block */
+#define ACP_I2STDM_IER                                0x1242400
+#define ACP_I2STDM_IRER                               0x1242404
+#define ACP_I2STDM_RXFRMT                             0x1242408
+#define ACP_I2STDM_ITER                               0x124240C
+#define ACP_I2STDM_TXFRMT                             0x1242410
+#define ACP_I2STDM0_MSTRCLKGEN                        0x1242414
+#define ACP_I2STDM1_MSTRCLKGEN                        0x1242418
+#define ACP_I2STDM2_MSTRCLKGEN                        0x124241C
+#define ACP_I2STDM_REFCLKGEN                          0x1242420
+
+/* Registers from ACP_BT_TDM block */
+#define ACP_BTTDM_IER                                 0x1242800
+#define ACP_BTTDM_IRER                                0x1242804
+#define ACP_BTTDM_RXFRMT                              0x1242808
+#define ACP_BTTDM_ITER                                0x124280C
+#define ACP_BTTDM_TXFRMT                              0x1242810
+#define ACP_HSTDM_IER                                 0x1242814
+#define ACP_HSTDM_IRER                                0x1242818
+#define ACP_HSTDM_RXFRMT                              0x124281C
+#define ACP_HSTDM_ITER                                0x1242820
+#define ACP_HSTDM_TXFRMT                              0x1242824
+
+/* Registers from ACP_WOV block */
+#define ACP_WOV_PDM_ENABLE                            0x1242C04
+#define ACP_WOV_PDM_DMA_ENABLE                        0x1242C08
+#define ACP_WOV_RX_RINGBUFADDR                        0x1242C0C
+#define ACP_WOV_RX_RINGBUFSIZE                        0x1242C10
+#define ACP_WOV_RX_LINKPOSITIONCNTR                   0x1242C14
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH            0x1242C18
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_LOW             0x1242C1C
+#define ACP_WOV_RX_INTR_WATERMARK_SIZE                0x1242C20
+#define ACP_WOV_PDM_FIFO_FLUSH                        0x1242C24
+#define ACP_WOV_PDM_NO_OF_CHANNELS                    0x1242C28
+#define ACP_WOV_PDM_DECIMATION_FACTOR                 0x1242C2C
+#define ACP_WOV_PDM_VAD_CTRL                          0x1242C30
+#define ACP_WOV_WAKE                                  0x1242C54
+#define ACP_WOV_BUFFER_STATUS                         0x1242C58
+#define ACP_WOV_MISC_CTRL                             0x1242C5C
+#define ACP_WOV_CLK_CTRL                              0x1242C60
+#define ACP_PDM_VAD_DYNAMIC_CLK_GATING_EN             0x1242C64
+#define ACP_WOV_ERROR_STATUS_REGISTER                 0x1242C68
+#define ACP_PDM_CLKDIV                                0x1242C6C
+
+/* Registers from ACP_P1_AUDIO_BUFFERS block */
+#define ACP_P1_I2S_RX_RINGBUFADDR                     0x1243A00
+#define ACP_P1_I2S_RX_RINGBUFSIZE                     0x1243A04
+#define ACP_P1_I2S_RX_LINKPOSITIONCNTR                0x1243A08
+#define ACP_P1_I2S_RX_FIFOADDR                        0x1243A0C
+#define ACP_P1_I2S_RX_FIFOSIZE                        0x1243A10
+#define ACP_P1_I2S_RX_DMA_SIZE                        0x1243A14
+#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_HIGH         0x1243A18
+#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_LOW          0x1243A1C
+#define ACP_P1_I2S_RX_INTR_WATERMARK_SIZE             0x1243A20
+#define ACP_P1_I2S_TX_RINGBUFADDR                     0x1243A24
+#define ACP_P1_I2S_TX_RINGBUFSIZE                     0x1243A28
+#define ACP_P1_I2S_TX_LINKPOSITIONCNTR                0x1243A2C
+#define ACP_P1_I2S_TX_FIFOADDR                        0x1243A30
+#define ACP_P1_I2S_TX_FIFOSIZE                        0x1243A34
+#define ACP_P1_I2S_TX_DMA_SIZE                        0x1243A38
+#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_HIGH         0x1243A3C
+#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_LOW          0x1243A40
+#define ACP_P1_I2S_TX_INTR_WATERMARK_SIZE             0x1243A44
+#define ACP_P1_BT_RX_RINGBUFADDR                      0x1243A48
+#define ACP_P1_BT_RX_RINGBUFSIZE                      0x1243A4C
+#define ACP_P1_BT_RX_LINKPOSITIONCNTR                 0x1243A50
+#define ACP_P1_BT_RX_FIFOADDR                         0x1243A54
+#define ACP_P1_BT_RX_FIFOSIZE                         0x1243A58
+#define ACP_P1_BT_RX_DMA_SIZE                         0x1243A5C
+#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_HIGH          0x1243A60
+#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_LOW           0x1243A64
+#define ACP_P1_BT_RX_INTR_WATERMARK_SIZE              0x1243A68
+#define ACP_P1_BT_TX_RINGBUFADDR                      0x1243A6C
+#define ACP_P1_BT_TX_RINGBUFSIZE                      0x1243A70
+#define ACP_P1_BT_TX_LINKPOSITIONCNTR                 0x1243A74
+#define ACP_P1_BT_TX_FIFOADDR                         0x1243A78
+#define ACP_P1_BT_TX_FIFOSIZE                         0x1243A7C
+#define ACP_P1_BT_TX_DMA_SIZE                         0x1243A80
+#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_HIGH          0x1243A84
+#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_LOW           0x1243A88
+#define ACP_P1_BT_TX_INTR_WATERMARK_SIZE              0x1243A8C
+#define ACP_P1_HS_RX_RINGBUFADDR                      0x1243A90
+#define ACP_P1_HS_RX_RINGBUFSIZE                      0x1243A94
+#define ACP_P1_HS_RX_LINKPOSITIONCNTR                 0x1243A98
+#define ACP_P1_HS_RX_FIFOADDR                         0x1243A9C
+#define ACP_P1_HS_RX_FIFOSIZE                         0x1243AA0
+#define ACP_P1_HS_RX_DMA_SIZE                         0x1243AA4
+#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_HIGH          0x1243AA8
+#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_LOW           0x1243AAC
+#define ACP_P1_HS_RX_INTR_WATERMARK_SIZE              0x1243AB0
+#define ACP_P1_HS_TX_RINGBUFADDR                      0x1243AB4
+#define ACP_P1_HS_TX_RINGBUFSIZE                      0x1243AB8
+#define ACP_P1_HS_TX_LINKPOSITIONCNTR                 0x1243ABC
+#define ACP_P1_HS_TX_FIFOADDR                         0x1243AC0
+#define ACP_P1_HS_TX_FIFOSIZE                         0x1243AC4
+#define ACP_P1_HS_TX_DMA_SIZE                         0x1243AC8
+#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_HIGH          0x1243ACC
+#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_LOW           0x1243AD0
+#define ACP_P1_HS_TX_INTR_WATERMARK_SIZE              0x1243AD4
+
+/* Registers from ACP_SCRATCH block */
+#define ACP_SCRATCH_REG_0                             0x1250000
+#define ACP_SCRATCH_REG_1                             0x1250004
+#define ACP_SCRATCH_REG_2                             0x1250008
+#define ACP_SCRATCH_REG_3                             0x125000C
+#define ACP_SCRATCH_REG_4                             0x1250010
+#define ACP_SCRATCH_REG_5                             0x1250014
+#define ACP_SCRATCH_REG_6                             0x1250018
+#define ACP_SCRATCH_REG_7                             0x125001C
+#define ACP_SCRATCH_REG_8                             0x1250020
+#define ACP_SCRATCH_REG_9                             0x1250024
+#define ACP_SCRATCH_REG_10                            0x1250028
+#define ACP_SCRATCH_REG_11                            0x125002C
+#define ACP_SCRATCH_REG_12                            0x1250030
+#define ACP_SCRATCH_REG_13                            0x1250034
+#define ACP_SCRATCH_REG_14                            0x1250038
+#define ACP_SCRATCH_REG_15                            0x125003C
+#define ACP_SCRATCH_REG_16                            0x1250040
+#define ACP_SCRATCH_REG_17                            0x1250044
+#define ACP_SCRATCH_REG_18                            0x1250048
+#define ACP_SCRATCH_REG_19                            0x125004C
+#define ACP_SCRATCH_REG_20                            0x1250050
+#define ACP_SCRATCH_REG_21                            0x1250054
+#define ACP_SCRATCH_REG_22                            0x1250058
+#define ACP_SCRATCH_REG_23                            0x125005C
+#define ACP_SCRATCH_REG_24                            0x1250060
+#define ACP_SCRATCH_REG_25                            0x1250064
+#define ACP_SCRATCH_REG_26                            0x1250068
+#define ACP_SCRATCH_REG_27                            0x125006C
+#define ACP_SCRATCH_REG_28                            0x1250070
+#define ACP_SCRATCH_REG_29                            0x1250074
+#define ACP_SCRATCH_REG_30                            0x1250078
+#define ACP_SCRATCH_REG_31                            0x125007C
+#define ACP_SCRATCH_REG_32                            0x1250080
+#define ACP_SCRATCH_REG_33                            0x1250084
+#define ACP_SCRATCH_REG_34                            0x1250088
+#define ACP_SCRATCH_REG_35                            0x125008C
+#define ACP_SCRATCH_REG_36                            0x1250090
+#define ACP_SCRATCH_REG_37                            0x1250094
+#define ACP_SCRATCH_REG_38                            0x1250098
+#define ACP_SCRATCH_REG_39                            0x125009C
+#define ACP_SCRATCH_REG_40                            0x12500A0
+#define ACP_SCRATCH_REG_41                            0x12500A4
+#define ACP_SCRATCH_REG_42                            0x12500A8
+#define ACP_SCRATCH_REG_43                            0x12500AC
+#define ACP_SCRATCH_REG_44                            0x12500B0
+#define ACP_SCRATCH_REG_45                            0x12500B4
+#define ACP_SCRATCH_REG_46                            0x12500B8
+#define ACP_SCRATCH_REG_47                            0x12500BC
+#define ACP_SCRATCH_REG_48                            0x12500C0
+#define ACP_SCRATCH_REG_49                            0x12500C4
+#define ACP_SCRATCH_REG_50                            0x12500C8
+#define ACP_SCRATCH_REG_51                            0x12500CC
+#define ACP_SCRATCH_REG_52                            0x12500D0
+#define ACP_SCRATCH_REG_53                            0x12500D4
+#define ACP_SCRATCH_REG_54                            0x12500D8
+#define ACP_SCRATCH_REG_55                            0x12500DC
+#define ACP_SCRATCH_REG_56                            0x12500E0
+#define ACP_SCRATCH_REG_57                            0x12500E4
+#define ACP_SCRATCH_REG_58                            0x12500E8
+#define ACP_SCRATCH_REG_59                            0x12500EC
+#define ACP_SCRATCH_REG_60                            0x12500F0
+#define ACP_SCRATCH_REG_61                            0x12500F4
+#define ACP_SCRATCH_REG_62                            0x12500F8
+#define ACP_SCRATCH_REG_63                            0x12500FC
+#define ACP_SCRATCH_REG_64                            0x1250100
+#define ACP_SCRATCH_REG_65                            0x1250104
+#define ACP_SCRATCH_REG_66                            0x1250108
+#define ACP_SCRATCH_REG_67                            0x125010C
+#define ACP_SCRATCH_REG_68                            0x1250110
+#define ACP_SCRATCH_REG_69                            0x1250114
+#define ACP_SCRATCH_REG_70                            0x1250118
+#define ACP_SCRATCH_REG_71                            0x125011C
+#define ACP_SCRATCH_REG_72                            0x1250120
+#define ACP_SCRATCH_REG_73                            0x1250124
+#define ACP_SCRATCH_REG_74                            0x1250128
+#define ACP_SCRATCH_REG_75                            0x125012C
+#define ACP_SCRATCH_REG_76                            0x1250130
+#define ACP_SCRATCH_REG_77                            0x1250134
+#define ACP_SCRATCH_REG_78                            0x1250138
+#define ACP_SCRATCH_REG_79                            0x125013C
+#define ACP_SCRATCH_REG_80                            0x1250140
+#define ACP_SCRATCH_REG_81                            0x1250144
+#define ACP_SCRATCH_REG_82                            0x1250148
+#define ACP_SCRATCH_REG_83                            0x125014C
+#define ACP_SCRATCH_REG_84                            0x1250150
+#define ACP_SCRATCH_REG_85                            0x1250154
+#define ACP_SCRATCH_REG_86                            0x1250158
+#define ACP_SCRATCH_REG_87                            0x125015C
+#define ACP_SCRATCH_REG_88                            0x1250160
+#define ACP_SCRATCH_REG_89                            0x1250164
+#define ACP_SCRATCH_REG_90                            0x1250168
+#define ACP_SCRATCH_REG_91                            0x125016C
+#define ACP_SCRATCH_REG_92                            0x1250170
+#define ACP_SCRATCH_REG_93                            0x1250174
+#define ACP_SCRATCH_REG_94                            0x1250178
+#define ACP_SCRATCH_REG_95                            0x125017C
+#define ACP_SCRATCH_REG_96                            0x1250180
+#define ACP_SCRATCH_REG_97                            0x1250184
+#define ACP_SCRATCH_REG_98                            0x1250188
+#define ACP_SCRATCH_REG_99                            0x125018C
+#define ACP_SCRATCH_REG_100                           0x1250190
+#define ACP_SCRATCH_REG_101                           0x1250194
+#define ACP_SCRATCH_REG_102                           0x1250198
+#define ACP_SCRATCH_REG_103                           0x125019C
+#define ACP_SCRATCH_REG_104                           0x12501A0
+#define ACP_SCRATCH_REG_105                           0x12501A4
+#define ACP_SCRATCH_REG_106                           0x12501A8
+#define ACP_SCRATCH_REG_107                           0x12501AC
+#define ACP_SCRATCH_REG_108                           0x12501B0
+#define ACP_SCRATCH_REG_109                           0x12501B4
+#define ACP_SCRATCH_REG_110                           0x12501B8
+#define ACP_SCRATCH_REG_111                           0x12501BC
+#define ACP_SCRATCH_REG_112                           0x12501C0
+#define ACP_SCRATCH_REG_113                           0x12501C4
+#define ACP_SCRATCH_REG_114                           0x12501C8
+#define ACP_SCRATCH_REG_115                           0x12501CC
+#define ACP_SCRATCH_REG_116                           0x12501D0
+#define ACP_SCRATCH_REG_117                           0x12501D4
+#define ACP_SCRATCH_REG_118                           0x12501D8
+#define ACP_SCRATCH_REG_119                           0x12501DC
+#define ACP_SCRATCH_REG_120                           0x12501E0
+#define ACP_SCRATCH_REG_121                           0x12501E4
+#define ACP_SCRATCH_REG_122                           0x12501E8
+#define ACP_SCRATCH_REG_123                           0x12501EC
+#define ACP_SCRATCH_REG_124                           0x12501F0
+#define ACP_SCRATCH_REG_125                           0x12501F4
+#define ACP_SCRATCH_REG_126                           0x12501F8
+#define ACP_SCRATCH_REG_127                           0x12501FC
+#define ACP_SCRATCH_REG_128                           0x1250200
+#endif
-- 
2.25.1

