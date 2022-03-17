Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4C4DBC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiCQBV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358255AbiCQBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:21:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAA1DA68;
        Wed, 16 Mar 2022 18:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO5teCpMierKnOCPX1ghJLMhPQXbzIApZe5JNuNQ2eLFztWWqCyedMu1Potq9Kzjhgfscgcez+Xs5gRKCnlbnCjEZxzK7Hs+8aw470Z1/RWQ6lRxkyr89K3lX7L2VDIVafPF5UMo8pxVSPstHnsDdTNwFnQBs3iuE0ZjPfFLs5NoIpYjHz5pkpK2LL9z/mX2UDO0zvRhqC77HBoLrqk6HDWGbqNUVU8NXRfYV6FpXDZ9XbZlUqhphUr4ay4eigxJy+OjYEhzeaRcpxBL6IGkbqeXDfCvnGyPsuwYCxe6DQBve0m/o7VQ/fToGII72PG2ZkhJfGsP93/j2ZUVDZFihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+29A/LkdF7idoccqnNl5ZRjmNGSwr4nhg0wUtaYyYY=;
 b=n3g9CpaxR8idx48E+hozUzzVTdVaGiIKnqLSloHMHjL/S37KstGq/tC9D7K4F0Y7SQkwec0bFYXViprA8tH3vkUUVqREKP5kvB/0IO5yYzE4AeQAIoc8A7nh3bVLj6W0A6J3bSS3MnuJS7hFrBOAyR7/G9R+o1fONLHd+T9ky+C4Pp6iuelExU44uKuOmED//YB84jyTQQ9ZR/iXN8wfC18cqC39bPX7R+91tXZkTKZC/3Y4RfY9I/ejeAbRPc+IjzTAiyZGO9hDPeMM5qyAoKHDtFf1B/n9jP5DmUuMK6Sdas7cMO8et4DryXNZdLAlEK0dNMsGxjF/fZ91cHzrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+29A/LkdF7idoccqnNl5ZRjmNGSwr4nhg0wUtaYyYY=;
 b=oAjoNkZfa72IuQBu1RXnkpGi15cLN2xqXZpiwTqXUEvjvqbgDrh0NCg41+9SS4ili49GiwKg3sx7dcF7uxoJZAlfDjB7tLebOobPYmdlT+mOb40OXY1Vd5IzAYiQTALjZ0vSLe1b15GyHYaIiuahjuV5ytmPGN7Gy6ZSdJGS4Yo7G5KyjvQqlUv0VUy47WjxT7NBpkKnk3wbcts7q79aqMx7BEjlpE/NvwitEEY9hEyV0qQc+hNH2AUZoXrDDZVEUEDT7DdN5EVIqQMZtHGLQC0E5Gy6qpm7kcDGdvh1qr6kZhxTsDlhSs2dCy7l6bwP/9hZ1agvEs+SjltQXFhiYQ==
Received: from BN8PR15CA0021.namprd15.prod.outlook.com (2603:10b6:408:c0::34)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 01:20:33 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::92) by BN8PR15CA0021.outlook.office365.com
 (2603:10b6:408:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 01:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 01:20:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 17 Mar
 2022 01:20:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 18:20:27 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 18:20:24 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH 3/3] spi: dt-bindings: Add wait state polling flag
Date:   Thu, 17 Mar 2022 06:50:06 +0530
Message-ID: <20220317012006.15080-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317012006.15080-1-kyarlagadda@nvidia.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cea0184-99f2-4450-941e-08da07b45529
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53699025873AD8864774A937C3129@CH0PR12MB5369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMK7AnVoJGYNQxrElkos65XkQc7hEyFYCIiMDNm/ZXXZ1+74fg3DV+Juk4uOiMBjbwhCs3FzT2p8nb8IWYdPa1Bl/Iwo22TVePRX0GvUKUJSgh0ydW4uQO6tSLVj1pJPTEhHkWN37Xn09PpGjZnYDe9+sfOSGxp5ZepPxCzPVzbo8MA2zdAslUgoU1yG/QEm8kfI/y+bQ0kq8lXwL4Akg7xA55CeH05oPEubk4mikdbISdWM2z1V9bJiPwFTLumIH8YaGwPEdYPocsMAWCWwcMQRsc8cSKlDwLz+SKrq7BsxlC0WxXLsNUAZGzUKBR0SuB4UxVXpUy6OeNm6imWZZS7WdsSHYrvrD4tUVbtATTmFvsxQ4kZqrzKVzlVnKDA/DUd1JenyDtw3CSuX24v7DbEuTy1o/6jRoUfi+7BuTKFTWfOXfOV5lpp2mi1Y6VIiw21fwM2xduPcZshJwyQpDfymksKD8Mrt+FS1Iv60GDud2X2RNfg2Scs0A9ZepAqxVt+7ZZSdEOidwPzyMFN+1Dn75wQLtaB5BxYkyaqaeSxm1UuTQzUmk9N48RYC2M8QzQJXIZP2o/nEQLGY6RwRq6vtqK5ifrFxr6zjAcJcsi2/bCxg2PCIwDMLv9hxzPbHQE2tdAyU2PsMUYeJiCyh9VigUsF0z4dvGOfEmeKWK2Rc7eAegiFZzSKEeQNpfRH/GKfPJEflaWyXixNl3F08Yw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(6636002)(4744005)(356005)(54906003)(8936002)(86362001)(107886003)(40460700003)(47076005)(81166007)(6666004)(7696005)(36860700001)(83380400001)(1076003)(26005)(336012)(186003)(426003)(2616005)(5660300002)(2906002)(508600001)(82310400004)(36756003)(8676002)(4326008)(70586007)(70206006)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:20:32.8923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea0184-99f2-4450-941e-08da07b45529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flag to enable tpm wait state polling and Tegra Grace binding.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra210-quad.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 0296edd1de22..88b00fcad210 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -20,6 +20,7 @@ properties:
       - nvidia,tegra186-qspi
       - nvidia,tegra194-qspi
       - nvidia,tegra234-qspi
+      - nvidia,tegra-grace-qspi
 
   reg:
     maxItems: 1
@@ -57,6 +58,11 @@ patternProperties:
       spi-tx-bus-width:
         enum: [1, 2, 4]
 
+      nvidia,wait-polling:
+        description:
+          Enable TPM wait state polling on supported chips.
+	type: boolean
+
       nvidia,tx-clk-tap-delay:
         description:
           Delays the clock going out to device with this tap value.
-- 
2.17.1

