Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7C5A38F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiH0Q73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH0Q70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:59:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB659251
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WinxPFO7UJaegMV90FVgHApV1VeXaZOuKBGE9EPLXRloE7o4nxTSJBGWB5yGaVtJ7vnffLvqMgjbaSDi8VIrt2QraoXym0y7tIApAOI2aFqvUZTZYpLvePzpxo7sHVey7ePVoTdDxiT/ghYwnXO75+f4LDsi3h7g6IeNUgQR9YBfQeQBaSxO6FEt51qtXRMUulQLhT0qsXD3Kb7X5TXvIKdfLsWp8o8+CimLnuGvPqWYLlptRMNl7DlKjB7F4VYlnuWND6D/eDcY5XsyJ2iO8XDe6s+l5/xfulMLYXZHrZyCbLAXSAVYWedze5xN6wu6GSZtoMcozWIYutA/nYKmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBK9EJPEZvP7BuZrlYjuBWm2vub/rRDLDZ/dnP95BDY=;
 b=L0bpG7ULH++uAUFD3UMF8W17QN8M7/dWYNCiNwKLtwCzLxNVVhNk8CLcAH590JbORWSEngVH08DyeW+rS3pSIcsv62J9S6/+2i2oBfCkTDCSXz4HruhMkqmQ5FvDxbS/NajDTMKiBK4cjGvYzlFjG5DhA/p7WQvVLbgznBFnwlMkAHUJ4epRCMrce5+y83VF4W8B4wa1QH56ul0Du9MAVNCj8qGPGqewrENeUfoDmcJCYpwp2iZBvetYFx45XIxBhf0cShMEGnDwOo0g2ArLvuFYGieV1xVWt1vKC8cTq9g37hOCz9pBVMfpoIH4XLmRHy6BBcXhbmX4/Hb1eCNeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBK9EJPEZvP7BuZrlYjuBWm2vub/rRDLDZ/dnP95BDY=;
 b=id3cDiRjytdfiBOXUcBY82MQmasbCyL5+Hvj0P2nhD8DJZnpQQgOzdhblfnJp9TpT+sDdglaIELNae62YGSEOqMNyO1RNz8Z9eA0/FAJ5YUdHoXLIoR5WDe8NIQ7xhUJpg+6o7E09MAixx/JOe2xnrunUvMdNDGcvHXxCB8TPjc=
Received: from DS7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:3b8::32)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 16:59:19 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::a2) by DS7PR03CA0027.outlook.office365.com
 (2603:10b6:5:3b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 16:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 16:59:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:18 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 11:59:14 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/13] ASoC: amd: add Pink Sardine platform ACP IP register header
Date:   Sat, 27 Aug 2022 22:26:45 +0530
Message-ID: <20220827165657.2343818-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870cae0d-1a4f-4239-4810-08da884d7b7a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0HJ/MhbgQojpofrjevdlALFFGQkKnCu2DQrNGDq2vP8ibA2hxY7bv/g9wQUjYfB6goh8aW5FH5lURC03oohcnCzGtQnA3163ilILs9KGn/7RVDLoBw0W6lUc6t13GcDvKpTN4Y/JJ1e1oH910CkW0kD6rM3HtyJnHLITVx5rjqKubb91wVeWZEuyyODzfFUv97ImgjJi1c9fnc2XtVFpi74Fi5NHP/Iw0Bns8L4zkAOJx4hArAlsGgh5TYV8z+CZEWu8W6TQvkUNx2/4qp2E2YLUJka/31q+ZZGzd+RnQT+wBy2ELqYJ3YjeD8iTV/aGpJ40Be27QPc6m03EqSC8oUIxOFmLDd+5zuqRoVR9FL5rgH1nDToa5fgjd1fGZuAth3OWcatQQMokJxd1H0mMsOR/tpnScGoDWnw0sgxvw8Wef/myNr6UFI/mcSGsbgl1Ek5sY6HeQfgC8kZz3Z3Fcbof/sHVPW6qSPEvBm2iffAM1tA5u3SRo998uEbUDNAEUpDN7a66US3E5FZzJy2dHlf3d7q8Mn991ixa32zhlCbS95gIxBvpWk6/Z3Vgy42lKA0Izqc5dUCVP79J+e5WyRDduXlqm6bUaoST4UFXBTkq2GEq2ythBMOzB+ewFi9nmZ5H5050TgnOtNh5joS8LgrlYUERkujvHJ19dVP1a3sk2nClpoqsWFoTgOefJtmm9YDsXp0U/Go8C/eXeqCfAGD/kGcKK2xbNomsf1VZUF3VHoCfjSCcTcDUGnoGbEWb0iMDLzA6XXm5Hle7P4wG6BLxe9I1Jw6W3erKl7pYX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(83380400001)(6666004)(186003)(8936002)(36860700001)(7696005)(2906002)(5660300002)(2616005)(30864003)(86362001)(1076003)(40480700001)(478600001)(70586007)(336012)(47076005)(8676002)(70206006)(81166007)(316002)(26005)(426003)(356005)(36756003)(4326008)(54906003)(110136005)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 16:59:19.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870cae0d-1a4f-4239-4810-08da884d7b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
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
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/acp62_chip_offset_byte.h | 444 +++++++++++++++++++++++++
 1 file changed, 444 insertions(+)
 create mode 100644 include/sound/acp62_chip_offset_byte.h

diff --git a/include/sound/acp62_chip_offset_byte.h b/include/sound/acp62_chip_offset_byte.h
new file mode 100644
index 000000000000..f03992f81168
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
+#define ACP_DMA_CNTL_0                                0x0000000
+#define ACP_DMA_CNTL_1                                0x0000004
+#define ACP_DMA_CNTL_2                                0x0000008
+#define ACP_DMA_CNTL_3                                0x000000C
+#define ACP_DMA_CNTL_4                                0x0000010
+#define ACP_DMA_CNTL_5                                0x0000014
+#define ACP_DMA_CNTL_6                                0x0000018
+#define ACP_DMA_CNTL_7                                0x000001C
+#define ACP_DMA_DSCR_STRT_IDX_0                       0x0000020
+#define ACP_DMA_DSCR_STRT_IDX_1                       0x0000024
+#define ACP_DMA_DSCR_STRT_IDX_2                       0x0000028
+#define ACP_DMA_DSCR_STRT_IDX_3                       0x000002C
+#define ACP_DMA_DSCR_STRT_IDX_4                       0x0000030
+#define ACP_DMA_DSCR_STRT_IDX_5                       0x0000034
+#define ACP_DMA_DSCR_STRT_IDX_6                       0x0000038
+#define ACP_DMA_DSCR_STRT_IDX_7                       0x000003C
+#define ACP_DMA_DSCR_CNT_0                            0x0000040
+#define ACP_DMA_DSCR_CNT_1                            0x0000044
+#define ACP_DMA_DSCR_CNT_2                            0x0000048
+#define ACP_DMA_DSCR_CNT_3                            0x000004C
+#define ACP_DMA_DSCR_CNT_4                            0x0000050
+#define ACP_DMA_DSCR_CNT_5                            0x0000054
+#define ACP_DMA_DSCR_CNT_6                            0x0000058
+#define ACP_DMA_DSCR_CNT_7                            0x000005C
+#define ACP_DMA_PRIO_0                                0x0000060
+#define ACP_DMA_PRIO_1                                0x0000064
+#define ACP_DMA_PRIO_2                                0x0000068
+#define ACP_DMA_PRIO_3                                0x000006C
+#define ACP_DMA_PRIO_4                                0x0000070
+#define ACP_DMA_PRIO_5                                0x0000074
+#define ACP_DMA_PRIO_6                                0x0000078
+#define ACP_DMA_PRIO_7                                0x000007C
+#define ACP_DMA_CUR_DSCR_0                            0x0000080
+#define ACP_DMA_CUR_DSCR_1                            0x0000084
+#define ACP_DMA_CUR_DSCR_2                            0x0000088
+#define ACP_DMA_CUR_DSCR_3                            0x000008C
+#define ACP_DMA_CUR_DSCR_4                            0x0000090
+#define ACP_DMA_CUR_DSCR_5                            0x0000094
+#define ACP_DMA_CUR_DSCR_6                            0x0000098
+#define ACP_DMA_CUR_DSCR_7                            0x000009C
+#define ACP_DMA_CUR_TRANS_CNT_0                       0x00000A0
+#define ACP_DMA_CUR_TRANS_CNT_1                       0x00000A4
+#define ACP_DMA_CUR_TRANS_CNT_2                       0x00000A8
+#define ACP_DMA_CUR_TRANS_CNT_3                       0x00000AC
+#define ACP_DMA_CUR_TRANS_CNT_4                       0x00000B0
+#define ACP_DMA_CUR_TRANS_CNT_5                       0x00000B4
+#define ACP_DMA_CUR_TRANS_CNT_6                       0x00000B8
+#define ACP_DMA_CUR_TRANS_CNT_7                       0x00000BC
+#define ACP_DMA_ERR_STS_0                             0x00000C0
+#define ACP_DMA_ERR_STS_1                             0x00000C4
+#define ACP_DMA_ERR_STS_2                             0x00000C8
+#define ACP_DMA_ERR_STS_3                             0x00000CC
+#define ACP_DMA_ERR_STS_4                             0x00000D0
+#define ACP_DMA_ERR_STS_5                             0x00000D4
+#define ACP_DMA_ERR_STS_6                             0x00000D8
+#define ACP_DMA_ERR_STS_7                             0x00000DC
+#define ACP_DMA_DESC_BASE_ADDR                        0x00000E0
+#define ACP_DMA_DESC_MAX_NUM_DSCR                     0x00000E4
+#define ACP_DMA_CH_STS                                0x00000E8
+#define ACP_DMA_CH_GROUP                              0x00000EC
+#define ACP_DMA_CH_RST_STS                            0x00000F0
+
+/* Registers from ACP_AXI2AXIATU block */
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1                0x0000C00
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_1                0x0000C04
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2                0x0000C08
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_2                0x0000C0C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_3                0x0000C10
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_3                0x0000C14
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_4                0x0000C18
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_4                0x0000C1C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_5                0x0000C20
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_5                0x0000C24
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_6                0x0000C28
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_6                0x0000C2C
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_7                0x0000C30
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_7                0x0000C34
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_8                0x0000C38
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_8                0x0000C3C
+#define ACPAXI2AXI_ATU_CTRL                           0x0000C40
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_9                0x0000C44
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_9                0x0000C48
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_10               0x0000C4C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_10               0x0000C50
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_11               0x0000C54
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_11               0x0000C58
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_12               0x0000C5C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_12               0x0000C60
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_13               0x0000C64
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_13               0x0000C68
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_14               0x0000C6C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_14               0x0000C70
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_15               0x0000C74
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_15               0x0000C78
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_16               0x0000C7C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_16               0x0000C80
+
+/* Registers from ACP_CLKRST block */
+#define ACP_SOFT_RESET                                0x0001000
+#define ACP_CONTROL                                   0x0001004
+#define ACP_STATUS                                    0x0001008
+#define ACP_DYNAMIC_CG_MASTER_CONTROL                 0x0001010
+#define ACP_ZSC_DSP_CTRL                              0x0001014
+#define ACP_ZSC_STS                                   0x0001018
+#define ACP_PGFSM_CONTROL                             0x0001024
+#define ACP_PGFSM_STATUS                              0x0001028
+#define ACP_CLKMUX_SEL                                0x000102C
+
+/* Registers from ACP_AON block */
+#define ACP_PME_EN                                    0x0001400
+#define ACP_DEVICE_STATE                              0x0001404
+#define AZ_DEVICE_STATE                               0x0001408
+#define ACP_PIN_CONFIG                                0x0001440
+#define ACP_PAD_PULLUP_CTRL                           0x0001444
+#define ACP_PAD_PULLDOWN_CTRL                         0x0001448
+#define ACP_PAD_DRIVE_STRENGTH_CTRL                   0x000144C
+#define ACP_PAD_SCHMEN_CTRL                           0x0001450
+#define ACP_SW_PAD_KEEPER_EN                          0x0001454
+#define ACP_SW_WAKE_EN                                0x0001458
+#define ACP_I2S_WAKE_EN                               0x000145C
+#define ACP_SW1_WAKE_EN                               0x0001460
+
+/* Registers from ACP_P1_MISC block */
+#define ACP_EXTERNAL_INTR_ENB                         0x0001A00
+#define ACP_EXTERNAL_INTR_CNTL                        0x0001A04
+#define ACP_EXTERNAL_INTR_CNTL1                       0x0001A08
+#define ACP_EXTERNAL_INTR_STAT                        0x0001A0C
+#define ACP_EXTERNAL_INTR_STAT1                       0x0001A10
+#define ACP_ERROR_STATUS                              0x0001A4C
+#define ACP_P1_SW_I2S_ERROR_REASON                    0x0001A50
+#define ACP_P1_SW_POS_TRACK_I2S_TX_CTRL               0x0001A6C
+#define ACP_P1_SW_I2S_TX_DMA_POS                      0x0001A70
+#define ACP_P1_SW_POS_TRACK_I2S_RX_CTRL               0x0001A74
+#define ACP_P1_SW_I2S_RX_DMA_POS                      0x0001A78
+#define ACP_P1_DMIC_I2S_GPIO_INTR_CTRL                0x0001A7C
+#define ACP_P1_DMIC_I2S_GPIO_INTR_STATUS              0x0001A80
+#define ACP_SCRATCH_REG_BASE_ADDR                     0x0001A84
+#define ACP_P1_SW_POS_TRACK_BT_TX_CTRL                0x0001A88
+#define ACP_P1_SW_BT_TX_DMA_POS                       0x0001A8C
+#define ACP_P1_SW_POS_TRACK_HS_TX_CTRL                0x0001A90
+#define ACP_P1_SW_HS_TX_DMA_POS                       0x0001A94
+#define ACP_P1_SW_POS_TRACK_BT_RX_CTRL                0x0001A98
+#define ACP_P1_SW_BT_RX_DMA_POS                       0x0001A9C
+#define ACP_P1_SW_POS_TRACK_HS_RX_CTRL                0x0001AA0
+#define ACP_P1_SW_HS_RX_DMA_POS                       0x0001AA4
+
+/* Registers from ACP_AUDIO_BUFFERS block */
+#define ACP_I2S_RX_RINGBUFADDR                        0x0002000
+#define ACP_I2S_RX_RINGBUFSIZE                        0x0002004
+#define ACP_I2S_RX_LINKPOSITIONCNTR                   0x0002008
+#define ACP_I2S_RX_FIFOADDR                           0x000200C
+#define ACP_I2S_RX_FIFOSIZE                           0x0002010
+#define ACP_I2S_RX_DMA_SIZE                           0x0002014
+#define ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH            0x0002018
+#define ACP_I2S_RX_LINEARPOSITIONCNTR_LOW             0x000201C
+#define ACP_I2S_RX_INTR_WATERMARK_SIZE                0x0002020
+#define ACP_I2S_TX_RINGBUFADDR                        0x0002024
+#define ACP_I2S_TX_RINGBUFSIZE                        0x0002028
+#define ACP_I2S_TX_LINKPOSITIONCNTR                   0x000202C
+#define ACP_I2S_TX_FIFOADDR                           0x0002030
+#define ACP_I2S_TX_FIFOSIZE                           0x0002034
+#define ACP_I2S_TX_DMA_SIZE                           0x0002038
+#define ACP_I2S_TX_LINEARPOSITIONCNTR_HIGH            0x000203C
+#define ACP_I2S_TX_LINEARPOSITIONCNTR_LOW             0x0002040
+#define ACP_I2S_TX_INTR_WATERMARK_SIZE                0x0002044
+#define ACP_BT_RX_RINGBUFADDR                         0x0002048
+#define ACP_BT_RX_RINGBUFSIZE                         0x000204C
+#define ACP_BT_RX_LINKPOSITIONCNTR                    0x0002050
+#define ACP_BT_RX_FIFOADDR                            0x0002054
+#define ACP_BT_RX_FIFOSIZE                            0x0002058
+#define ACP_BT_RX_DMA_SIZE                            0x000205C
+#define ACP_BT_RX_LINEARPOSITIONCNTR_HIGH             0x0002060
+#define ACP_BT_RX_LINEARPOSITIONCNTR_LOW              0x0002064
+#define ACP_BT_RX_INTR_WATERMARK_SIZE                 0x0002068
+#define ACP_BT_TX_RINGBUFADDR                         0x000206C
+#define ACP_BT_TX_RINGBUFSIZE                         0x0002070
+#define ACP_BT_TX_LINKPOSITIONCNTR                    0x0002074
+#define ACP_BT_TX_FIFOADDR                            0x0002078
+#define ACP_BT_TX_FIFOSIZE                            0x000207C
+#define ACP_BT_TX_DMA_SIZE                            0x0002080
+#define ACP_BT_TX_LINEARPOSITIONCNTR_HIGH             0x0002084
+#define ACP_BT_TX_LINEARPOSITIONCNTR_LOW              0x0002088
+#define ACP_BT_TX_INTR_WATERMARK_SIZE                 0x000208C
+#define ACP_HS_RX_RINGBUFADDR                         0x0002090
+#define ACP_HS_RX_RINGBUFSIZE                         0x0002094
+#define ACP_HS_RX_LINKPOSITIONCNTR                    0x0002098
+#define ACP_HS_RX_FIFOADDR                            0x000209C
+#define ACP_HS_RX_FIFOSIZE                            0x00020A0
+#define ACP_HS_RX_DMA_SIZE                            0x00020A4
+#define ACP_HS_RX_LINEARPOSITIONCNTR_HIGH             0x00020A8
+#define ACP_HS_RX_LINEARPOSITIONCNTR_LOW              0x00020AC
+#define ACP_HS_RX_INTR_WATERMARK_SIZE                 0x00020B0
+#define ACP_HS_TX_RINGBUFADDR                         0x00020B4
+#define ACP_HS_TX_RINGBUFSIZE                         0x00020B8
+#define ACP_HS_TX_LINKPOSITIONCNTR                    0x00020BC
+#define ACP_HS_TX_FIFOADDR                            0x00020C0
+#define ACP_HS_TX_FIFOSIZE                            0x00020C4
+#define ACP_HS_TX_DMA_SIZE                            0x00020C8
+#define ACP_HS_TX_LINEARPOSITIONCNTR_HIGH             0x00020CC
+#define ACP_HS_TX_LINEARPOSITIONCNTR_LOW              0x00020D0
+#define ACP_HS_TX_INTR_WATERMARK_SIZE                 0x00020D4
+
+/* Registers from ACP_I2S_TDM block */
+#define ACP_I2STDM_IER                                0x0002400
+#define ACP_I2STDM_IRER                               0x0002404
+#define ACP_I2STDM_RXFRMT                             0x0002408
+#define ACP_I2STDM_ITER                               0x000240C
+#define ACP_I2STDM_TXFRMT                             0x0002410
+#define ACP_I2STDM0_MSTRCLKGEN                        0x0002414
+#define ACP_I2STDM1_MSTRCLKGEN                        0x0002418
+#define ACP_I2STDM2_MSTRCLKGEN                        0x000241C
+#define ACP_I2STDM_REFCLKGEN                          0x0002420
+
+/* Registers from ACP_BT_TDM block */
+#define ACP_BTTDM_IER                                 0x0002800
+#define ACP_BTTDM_IRER                                0x0002804
+#define ACP_BTTDM_RXFRMT                              0x0002808
+#define ACP_BTTDM_ITER                                0x000280C
+#define ACP_BTTDM_TXFRMT                              0x0002810
+#define ACP_HSTDM_IER                                 0x0002814
+#define ACP_HSTDM_IRER                                0x0002818
+#define ACP_HSTDM_RXFRMT                              0x000281C
+#define ACP_HSTDM_ITER                                0x0002820
+#define ACP_HSTDM_TXFRMT                              0x0002824
+
+/* Registers from ACP_WOV block */
+#define ACP_WOV_PDM_ENABLE                            0x0002C04
+#define ACP_WOV_PDM_DMA_ENABLE                        0x0002C08
+#define ACP_WOV_RX_RINGBUFADDR                        0x0002C0C
+#define ACP_WOV_RX_RINGBUFSIZE                        0x0002C10
+#define ACP_WOV_RX_LINKPOSITIONCNTR                   0x0002C14
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH            0x0002C18
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_LOW             0x0002C1C
+#define ACP_WOV_RX_INTR_WATERMARK_SIZE                0x0002C20
+#define ACP_WOV_PDM_FIFO_FLUSH                        0x0002C24
+#define ACP_WOV_PDM_NO_OF_CHANNELS                    0x0002C28
+#define ACP_WOV_PDM_DECIMATION_FACTOR                 0x0002C2C
+#define ACP_WOV_PDM_VAD_CTRL                          0x0002C30
+#define ACP_WOV_WAKE                                  0x0002C54
+#define ACP_WOV_BUFFER_STATUS                         0x0002C58
+#define ACP_WOV_MISC_CTRL                             0x0002C5C
+#define ACP_WOV_CLK_CTRL                              0x0002C60
+#define ACP_PDM_VAD_DYNAMIC_CLK_GATING_EN             0x0002C64
+#define ACP_WOV_ERROR_STATUS_REGISTER                 0x0002C68
+#define ACP_PDM_CLKDIV                                0x0002C6C
+
+/* Registers from ACP_P1_AUDIO_BUFFERS block */
+#define ACP_P1_I2S_RX_RINGBUFADDR                     0x0003A00
+#define ACP_P1_I2S_RX_RINGBUFSIZE                     0x0003A04
+#define ACP_P1_I2S_RX_LINKPOSITIONCNTR                0x0003A08
+#define ACP_P1_I2S_RX_FIFOADDR                        0x0003A0C
+#define ACP_P1_I2S_RX_FIFOSIZE                        0x0003A10
+#define ACP_P1_I2S_RX_DMA_SIZE                        0x0003A14
+#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_HIGH         0x0003A18
+#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_LOW          0x0003A1C
+#define ACP_P1_I2S_RX_INTR_WATERMARK_SIZE             0x0003A20
+#define ACP_P1_I2S_TX_RINGBUFADDR                     0x0003A24
+#define ACP_P1_I2S_TX_RINGBUFSIZE                     0x0003A28
+#define ACP_P1_I2S_TX_LINKPOSITIONCNTR                0x0003A2C
+#define ACP_P1_I2S_TX_FIFOADDR                        0x0003A30
+#define ACP_P1_I2S_TX_FIFOSIZE                        0x0003A34
+#define ACP_P1_I2S_TX_DMA_SIZE                        0x0003A38
+#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_HIGH         0x0003A3C
+#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_LOW          0x0003A40
+#define ACP_P1_I2S_TX_INTR_WATERMARK_SIZE             0x0003A44
+#define ACP_P1_BT_RX_RINGBUFADDR                      0x0003A48
+#define ACP_P1_BT_RX_RINGBUFSIZE                      0x0003A4C
+#define ACP_P1_BT_RX_LINKPOSITIONCNTR                 0x0003A50
+#define ACP_P1_BT_RX_FIFOADDR                         0x0003A54
+#define ACP_P1_BT_RX_FIFOSIZE                         0x0003A58
+#define ACP_P1_BT_RX_DMA_SIZE                         0x0003A5C
+#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_HIGH          0x0003A60
+#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_LOW           0x0003A64
+#define ACP_P1_BT_RX_INTR_WATERMARK_SIZE              0x0003A68
+#define ACP_P1_BT_TX_RINGBUFADDR                      0x0003A6C
+#define ACP_P1_BT_TX_RINGBUFSIZE                      0x0003A70
+#define ACP_P1_BT_TX_LINKPOSITIONCNTR                 0x0003A74
+#define ACP_P1_BT_TX_FIFOADDR                         0x0003A78
+#define ACP_P1_BT_TX_FIFOSIZE                         0x0003A7C
+#define ACP_P1_BT_TX_DMA_SIZE                         0x0003A80
+#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_HIGH          0x0003A84
+#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_LOW           0x0003A88
+#define ACP_P1_BT_TX_INTR_WATERMARK_SIZE              0x0003A8C
+#define ACP_P1_HS_RX_RINGBUFADDR                      0x0003A90
+#define ACP_P1_HS_RX_RINGBUFSIZE                      0x0003A94
+#define ACP_P1_HS_RX_LINKPOSITIONCNTR                 0x0003A98
+#define ACP_P1_HS_RX_FIFOADDR                         0x0003A9C
+#define ACP_P1_HS_RX_FIFOSIZE                         0x0003AA0
+#define ACP_P1_HS_RX_DMA_SIZE                         0x0003AA4
+#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_HIGH          0x0003AA8
+#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_LOW           0x0003AAC
+#define ACP_P1_HS_RX_INTR_WATERMARK_SIZE              0x0003AB0
+#define ACP_P1_HS_TX_RINGBUFADDR                      0x0003AB4
+#define ACP_P1_HS_TX_RINGBUFSIZE                      0x0003AB8
+#define ACP_P1_HS_TX_LINKPOSITIONCNTR                 0x0003ABC
+#define ACP_P1_HS_TX_FIFOADDR                         0x0003AC0
+#define ACP_P1_HS_TX_FIFOSIZE                         0x0003AC4
+#define ACP_P1_HS_TX_DMA_SIZE                         0x0003AC8
+#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_HIGH          0x0003ACC
+#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_LOW           0x0003AD0
+#define ACP_P1_HS_TX_INTR_WATERMARK_SIZE              0x0003AD4
+
+/* Registers from ACP_SCRATCH block */
+#define ACP_SCRATCH_REG_0                             0x0010000
+#define ACP_SCRATCH_REG_1                             0x0010004
+#define ACP_SCRATCH_REG_2                             0x0010008
+#define ACP_SCRATCH_REG_3                             0x001000C
+#define ACP_SCRATCH_REG_4                             0x0010010
+#define ACP_SCRATCH_REG_5                             0x0010014
+#define ACP_SCRATCH_REG_6                             0x0010018
+#define ACP_SCRATCH_REG_7                             0x001001C
+#define ACP_SCRATCH_REG_8                             0x0010020
+#define ACP_SCRATCH_REG_9                             0x0010024
+#define ACP_SCRATCH_REG_10                            0x0010028
+#define ACP_SCRATCH_REG_11                            0x001002C
+#define ACP_SCRATCH_REG_12                            0x0010030
+#define ACP_SCRATCH_REG_13                            0x0010034
+#define ACP_SCRATCH_REG_14                            0x0010038
+#define ACP_SCRATCH_REG_15                            0x001003C
+#define ACP_SCRATCH_REG_16                            0x0010040
+#define ACP_SCRATCH_REG_17                            0x0010044
+#define ACP_SCRATCH_REG_18                            0x0010048
+#define ACP_SCRATCH_REG_19                            0x001004C
+#define ACP_SCRATCH_REG_20                            0x0010050
+#define ACP_SCRATCH_REG_21                            0x0010054
+#define ACP_SCRATCH_REG_22                            0x0010058
+#define ACP_SCRATCH_REG_23                            0x001005C
+#define ACP_SCRATCH_REG_24                            0x0010060
+#define ACP_SCRATCH_REG_25                            0x0010064
+#define ACP_SCRATCH_REG_26                            0x0010068
+#define ACP_SCRATCH_REG_27                            0x001006C
+#define ACP_SCRATCH_REG_28                            0x0010070
+#define ACP_SCRATCH_REG_29                            0x0010074
+#define ACP_SCRATCH_REG_30                            0x0010078
+#define ACP_SCRATCH_REG_31                            0x001007C
+#define ACP_SCRATCH_REG_32                            0x0010080
+#define ACP_SCRATCH_REG_33                            0x0010084
+#define ACP_SCRATCH_REG_34                            0x0010088
+#define ACP_SCRATCH_REG_35                            0x001008C
+#define ACP_SCRATCH_REG_36                            0x0010090
+#define ACP_SCRATCH_REG_37                            0x0010094
+#define ACP_SCRATCH_REG_38                            0x0010098
+#define ACP_SCRATCH_REG_39                            0x001009C
+#define ACP_SCRATCH_REG_40                            0x00100A0
+#define ACP_SCRATCH_REG_41                            0x00100A4
+#define ACP_SCRATCH_REG_42                            0x00100A8
+#define ACP_SCRATCH_REG_43                            0x00100AC
+#define ACP_SCRATCH_REG_44                            0x00100B0
+#define ACP_SCRATCH_REG_45                            0x00100B4
+#define ACP_SCRATCH_REG_46                            0x00100B8
+#define ACP_SCRATCH_REG_47                            0x00100BC
+#define ACP_SCRATCH_REG_48                            0x00100C0
+#define ACP_SCRATCH_REG_49                            0x00100C4
+#define ACP_SCRATCH_REG_50                            0x00100C8
+#define ACP_SCRATCH_REG_51                            0x00100CC
+#define ACP_SCRATCH_REG_52                            0x00100D0
+#define ACP_SCRATCH_REG_53                            0x00100D4
+#define ACP_SCRATCH_REG_54                            0x00100D8
+#define ACP_SCRATCH_REG_55                            0x00100DC
+#define ACP_SCRATCH_REG_56                            0x00100E0
+#define ACP_SCRATCH_REG_57                            0x00100E4
+#define ACP_SCRATCH_REG_58                            0x00100E8
+#define ACP_SCRATCH_REG_59                            0x00100EC
+#define ACP_SCRATCH_REG_60                            0x00100F0
+#define ACP_SCRATCH_REG_61                            0x00100F4
+#define ACP_SCRATCH_REG_62                            0x00100F8
+#define ACP_SCRATCH_REG_63                            0x00100FC
+#define ACP_SCRATCH_REG_64                            0x0010100
+#define ACP_SCRATCH_REG_65                            0x0010104
+#define ACP_SCRATCH_REG_66                            0x0010108
+#define ACP_SCRATCH_REG_67                            0x001010C
+#define ACP_SCRATCH_REG_68                            0x0010110
+#define ACP_SCRATCH_REG_69                            0x0010114
+#define ACP_SCRATCH_REG_70                            0x0010118
+#define ACP_SCRATCH_REG_71                            0x001011C
+#define ACP_SCRATCH_REG_72                            0x0010120
+#define ACP_SCRATCH_REG_73                            0x0010124
+#define ACP_SCRATCH_REG_74                            0x0010128
+#define ACP_SCRATCH_REG_75                            0x001012C
+#define ACP_SCRATCH_REG_76                            0x0010130
+#define ACP_SCRATCH_REG_77                            0x0010134
+#define ACP_SCRATCH_REG_78                            0x0010138
+#define ACP_SCRATCH_REG_79                            0x001013C
+#define ACP_SCRATCH_REG_80                            0x0010140
+#define ACP_SCRATCH_REG_81                            0x0010144
+#define ACP_SCRATCH_REG_82                            0x0010148
+#define ACP_SCRATCH_REG_83                            0x001014C
+#define ACP_SCRATCH_REG_84                            0x0010150
+#define ACP_SCRATCH_REG_85                            0x0010154
+#define ACP_SCRATCH_REG_86                            0x0010158
+#define ACP_SCRATCH_REG_87                            0x001015C
+#define ACP_SCRATCH_REG_88                            0x0010160
+#define ACP_SCRATCH_REG_89                            0x0010164
+#define ACP_SCRATCH_REG_90                            0x0010168
+#define ACP_SCRATCH_REG_91                            0x001016C
+#define ACP_SCRATCH_REG_92                            0x0010170
+#define ACP_SCRATCH_REG_93                            0x0010174
+#define ACP_SCRATCH_REG_94                            0x0010178
+#define ACP_SCRATCH_REG_95                            0x001017C
+#define ACP_SCRATCH_REG_96                            0x0010180
+#define ACP_SCRATCH_REG_97                            0x0010184
+#define ACP_SCRATCH_REG_98                            0x0010188
+#define ACP_SCRATCH_REG_99                            0x001018C
+#define ACP_SCRATCH_REG_100                           0x0010190
+#define ACP_SCRATCH_REG_101                           0x0010194
+#define ACP_SCRATCH_REG_102                           0x0010198
+#define ACP_SCRATCH_REG_103                           0x001019C
+#define ACP_SCRATCH_REG_104                           0x00101A0
+#define ACP_SCRATCH_REG_105                           0x00101A4
+#define ACP_SCRATCH_REG_106                           0x00101A8
+#define ACP_SCRATCH_REG_107                           0x00101AC
+#define ACP_SCRATCH_REG_108                           0x00101B0
+#define ACP_SCRATCH_REG_109                           0x00101B4
+#define ACP_SCRATCH_REG_110                           0x00101B8
+#define ACP_SCRATCH_REG_111                           0x00101BC
+#define ACP_SCRATCH_REG_112                           0x00101C0
+#define ACP_SCRATCH_REG_113                           0x00101C4
+#define ACP_SCRATCH_REG_114                           0x00101C8
+#define ACP_SCRATCH_REG_115                           0x00101CC
+#define ACP_SCRATCH_REG_116                           0x00101D0
+#define ACP_SCRATCH_REG_117                           0x00101D4
+#define ACP_SCRATCH_REG_118                           0x00101D8
+#define ACP_SCRATCH_REG_119                           0x00101DC
+#define ACP_SCRATCH_REG_120                           0x00101E0
+#define ACP_SCRATCH_REG_121                           0x00101E4
+#define ACP_SCRATCH_REG_122                           0x00101E8
+#define ACP_SCRATCH_REG_123                           0x00101EC
+#define ACP_SCRATCH_REG_124                           0x00101F0
+#define ACP_SCRATCH_REG_125                           0x00101F4
+#define ACP_SCRATCH_REG_126                           0x00101F8
+#define ACP_SCRATCH_REG_127                           0x00101FC
+#define ACP_SCRATCH_REG_128                           0x0010200
+#endif
-- 
2.25.1

