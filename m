Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74074D5991
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbiCKEbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346314AbiCKEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:31:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3BD1A6FB6;
        Thu, 10 Mar 2022 20:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWChZDJDGcX1xbNqOlKjpMLBQnTnh4koLKRQYQ00HZb8onxUsWUZMZbTRcmSjMh5gs1TI7MWW49QCVv9r9ZtiO9UzpnmqTmSEc8E0D0V/fuzQM0l6c/trTcoGHin47QD6qnDAuqgpH7SAZzhBj2L7QqPtuY8fRAj45G07dtVpwiZviX/uAQscT3uRUu/GvmegY8N4dsYnYKbDqAwtl/L1HchDFzc1ZwWbRvdT3xl03Vx2dkDm7Fvc9RipjxeAA4kDAiB/Pc7GACBS7WgfGSdGnkhEoxdV/9/A0i5/JLBQ1IiOfLO6M/uLWrJKd9FyCeDYxWS5Asq5zzc38OcT7L4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ff9O8nFOUR4oKMDqSA0FmQ8LwUbu5ZbJ1+MCXz5yJM=;
 b=TpheBnSgnmYAhV3Xve14vTFFfRCuBzo2dhETjevecjrzdCrjNJX6SMIQ2GPPRLWU+EtfhqU4Umg/65VMk23neILO7NTfC2kN4GbwtSufrRn0FVgX8uU7DUP1V51zY8wF1Bvo0K18deOeOM5aYjsHl4302pERo4+IN+xqkqSnNtWHKBeQM08rVEeHCRqC27vEnD+k8gyp57jJxnSifCviNNzhhHS7aJjFbPTsyDrkcbAqh2F9SzzNn4OcoV9rW2Ea6cA4jWtGeoFF7ZG2hSryI55veVb8grPTasqxc3rSA4wKwiRabeWmmCbd2T6Ly86LqWVX3xZrc85W9OqRq4aq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ff9O8nFOUR4oKMDqSA0FmQ8LwUbu5ZbJ1+MCXz5yJM=;
 b=EiM3n8qNmqV5wg1rv+Qd2018dWY1ajRPwLWaChXGjK4EJXOLKNjbNZo1zYNDVZm9sEnIzfLsEogLlYt9kysWzZT4xf4TIzK0LOhTJ7pBz2ePRSYvcx61w/Jy2Hsprd6uO/MyVG8DEXCOQICUOKZ7wKyeeKPZOkhOwpOQOFoehHHkfCfA0SJg9/gF2Zuqg5Au8NNHtWZce9Q3LMxgRkLOQDheVrxc8+yZ2hUTDYBTEqDsvIJLA2d2JSJvwOMr5qYqFTHI/lDhT+pMSD0V/gquXkIT6kyXr+JKqT0x1/DikTri3aci+q9LEYejbKWBdaQWNNfse1KYA/yrRwS0+EX16g==
Received: from DM5PR07CA0158.namprd07.prod.outlook.com (2603:10b6:3:ee::24) by
 DM5PR1201MB2538.namprd12.prod.outlook.com (2603:10b6:3:de::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.16; Fri, 11 Mar 2022 04:30:27 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::7b) by DM5PR07CA0158.outlook.office365.com
 (2603:10b6:3:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 04:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 04:30:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 11 Mar
 2022 04:30:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 10 Mar
 2022 20:30:19 -0800
Received: from pshete-ubuntu.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 10 Mar 2022 20:30:17 -0800
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <smangipudi@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: [PATCH] pinctrl: tegra: Set SFIO mode to Mux Register
Date:   Fri, 11 Mar 2022 10:00:15 +0530
Message-ID: <20220311043015.4027-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e915a22d-0b99-4540-d4c4-08da0317db43
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2538:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2538E63B7FB1E7E05EC29D32B70C9@DM5PR1201MB2538.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkQU2CDYn3+MVfVpMydTSuIBmjDgkx2Z2I+siJhIKuNtfREM4JruJg3G/nWP0fmCejrEkKx19nDekuIAEzW1z6BuKQ3pBb3EDF5Up7hcaTfAvMuACdxNs4LZkK+P1fItONtRTY6ygQkUZANidlzMGYhOHYpuD1PDuEOu2mIsHLc9sS3gAWGpXEO0acOLtofGHWHxh3OHea6R5XYQyTJ3vs120AhGv6oQ5niANOJjPd4LtIJsIalZzYHTPDjbCtvuss5BDsThVk6fjYZQsXXMxc20c8S33gI6OPAjV12VTtGFhtB6qU1OSKu9X1+WclHyZ6Y6W5ngwV9Sm1gbe9+Zo7r97wzCtkiGVsI35s4f9LYk2Ktpy9hrSxbRBZtd9SFe92diT/dHhjn8IB/B2APPKU82p18HqYauwj+jbTG7Iz7P2CUVirglLslHV57h9DHU5R9llOcOV0BpzG7oKHfyn9U1KrooDklITv7rhODOP0XoK+jOehNoWEKlnz0dcG2E5g5MYfo4lc+qDMHBf6rcJweZuaHE0pMVzoNcS6jE4zft7sJMtsn6GTGkCmFHz/2+spBzzeGJr5uee8Z64aDPBpsxm/I+ur0uqZan4aweeiCKpEcxWn6/SUSFz1HI/BYtJbN4wzinddiFioIFLLH/6phGzGeaoWUj6qkKflhUziInEWIKhP6e6oAUqNYdDl1usbvntwkGkYKiqIBksCEnzA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(316002)(81166007)(8936002)(4744005)(47076005)(107886003)(356005)(186003)(5660300002)(26005)(2906002)(70586007)(36756003)(1076003)(40460700003)(2616005)(426003)(336012)(82310400004)(4326008)(8676002)(70206006)(110136005)(86362001)(508600001)(36860700001)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 04:30:22.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e915a22d-0b99-4540-d4c4-08da0317db43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2538
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device has the 'sfsel' bit field, pin should be
muxed to set to SFIO mode to be used for pinmux operation.

Signed-off-by: EJ Hsu <ejh@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 50bd26a30ac0..30341c43da59 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -270,6 +270,9 @@ static int tegra_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	val = pmx_readl(pmx, g->mux_bank, g->mux_reg);
 	val &= ~(0x3 << g->mux_bit);
 	val |= i << g->mux_bit;
+	/* Set the SFIO/GPIO selection to SFIO when under pinmux control*/
+	if (pmx->soc->sfsel_in_mux)
+		val |= (1 << g->sfsel_bit);
 	pmx_writel(pmx, val, g->mux_bank, g->mux_reg);
 
 	return 0;
-- 
2.17.1

