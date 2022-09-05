Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF75AD855
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiIERYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIERYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:24:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43E64D7;
        Mon,  5 Sep 2022 10:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHCisw2yIBT6GPmMyudVIjAudq4uVfyPJB6kHIQMbbTZ6AgJSdpLDVHVEcsdfqbrysVMF1YxtolNWfKNXVwuPrBsL+EkqWRjI0UvIZn/LBag0NJsuM5qDmrUnxkQ6GjGx5QYd+6xzZb+d1Asm8xw4dYn6PiD6lLpSrj8Zr5Ei3GiV4DFt6UQpLDn51TC1eLc/UDxPDkIRkwAJSInK/wjT65eo1CPBFgNCq6bzwmQ4QzMXog9iDAPUiIIBHIlz0tSi58/VEbkWRIaV6qNGq3EHpUx1I4XOHpzqswHhbTS/LO0ITSi2jEaZS4fZzRVeJlMulgK29njuKXzQHIQnEL6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Pt9yeMGXkD8y3QMXvO0d0w2llCU8Vu1dQvgQAouvI=;
 b=jGvf0jK84XROWEPJjila81G3Ujr13BR/Zf5+KbV2E8cdiF141wb4xAKS6TMsc2mH9GuQ3TvNvSCoMGT/6i8iGclkwavr92IE22VkKIoojgeve8XL4v3iaT8edRzSV9147LxO0m0og2nn3A2lptlx0M1lmD3LiW9yyMUAKPQp/EOLMOyow4F/dhma21Ob4s0KUBfMobUUdnrazmlo7gb7e2fqT+Ja7o9YGqXnAXZTlQEuAsKR5SUOOYWnhVG2j69ae52Fw4nF+8gdxAn84lO5yGrlMdSsPOhgYYXEQ5RIUhVaYKD07y2tH64mj+EOm3qkfnppSc4pKij7FsSfEGxelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Pt9yeMGXkD8y3QMXvO0d0w2llCU8Vu1dQvgQAouvI=;
 b=S+h/beP98p+aWpaDnkW0NiUodaBhVJs69bz6Kj8HIBMZb/G7euwUFvcYiS0o292PggzCd1cJayd/HxEhXSYHit+d/J3s9jeYSQywI/Tid/pl4RITNHLuJTl1dJ7HV5LFclb17Nzq9yJTKp0iNRYVO/V2xYYkO9MdMUsWC+sIqvW50t3Jb7s24zRTRMm705CodBOWo/nkPq4nA3oony6c7ufM0x5tYTD4dhUNisjsHXjuXDrGSOcP82nG3s0ZqL4bqcST8JE31Cn+WOGMTJ7TQkdOCVZ/eANzVRLZd3YDuYs1N32/dDxnNszaG2iulabvgEmdbuhbV7qSHIMvjF2G7w==
Received: from MW3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:303:2b::19)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 17:24:34 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::85) by MW3PR05CA0014.outlook.office365.com
 (2603:10b6:303:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Mon, 5 Sep 2022 17:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 17:24:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 5 Sep 2022 17:24:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 5 Sep 2022 10:24:33 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 5 Sep 2022 10:24:31 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] ALSA: hda/tegra: Align BDL entry to 4KB boundary
Date:   Mon, 5 Sep 2022 22:54:20 +0530
Message-ID: <20220905172420.3801-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb08439-4c97-4814-c629-08da8f638075
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtNHkicclGz9JFOsJskudLZfrMEXJ6CRlHWNw9scaBSy5nNLn6KOe6djc3sFmU4F5KcnS4ZdY8hKRSCfXEj7nhUzteJiodEhtZr1WrnKpqg8ki3czJi99+Wl7iwxrujPKembX2yrAQOkLJe6eVRoriYbeCN6Z/KC2TylQH167UIU6Nafoezk1VfVhlTOkHwX+KzSTqozqGwZQ4XtsoCAHewmCRsA2FHNmzUIEPibc6KAJAt6qUZFzRfeBxIA/IAHarTQse05OUDhqPNlhePke4VcHTIKgIRGgvly7q43LBVqucfQjXUyubzjDBh4bIJQoBfETtY3N563ShYNWLWXTj3w6EukiGMQNohjEHj6mCgajBoUfFZY7saV5WgVYvqU+StspB1amIjYcXj0MeNVeDx0iQwUrzDYWP+mDNCI4vh+iMQCFWAjCPwoxtNs1EknKEKokYNYaQzfigbTfXhFCUrO/lmsqsep9fIYjY/sIsDwARu2cUuUa74Byhjiaf48j69r48K+g3+m0uhY+WwXIulXTkfie7gCDAxrv/5xtDL+Fk70V24np4k25ztKUdGLHkyEvvB1B/QqL8cO2Z32NSMcVS1uZy0gyiNu6cFNifkr5wni0P7eB5MjUwLaRgNaEm2WNIexhMrwexm+CBgOUnT9nij5qHF0c9nOLz0kNgp+rrTI1lE4DhKAliInkTKDxQY+K4SGvHM6w7VzSZE2PQB5lwx4sMd8YvtPn8EkZkfzzotB9uBZmHGkoD8dsjjaSTBCXEOG4S1Ip06Yhmgg+w5RrI6Jyqb4bOOklWoYn8VXz9Uo9GjQW2XRiyhUP1lL
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(5660300002)(36860700001)(83380400001)(316002)(110136005)(54906003)(36756003)(70586007)(4744005)(8676002)(8936002)(2906002)(4326008)(70206006)(478600001)(41300700001)(40480700001)(107886003)(6666004)(26005)(82310400005)(426003)(1076003)(336012)(186003)(2616005)(47076005)(86362001)(82740400003)(40460700003)(356005)(81166007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 17:24:34.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb08439-4c97-4814-c629-08da8f638075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AZA HW may send a burst read/write request crossing 4K memory boundary.
The 4KB boundary is not guaranteed by Tegra HDA HW. Make SW change to
include the flag AZX_DCAPS_4K_BDLE_BOUNDARY to align BDLE to 4K
boundary.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 7debb2c76aa6..976a112c7d00 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -474,7 +474,8 @@ MODULE_DEVICE_TABLE(of, hda_tegra_match);
 static int hda_tegra_probe(struct platform_device *pdev)
 {
 	const unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR |
-					  AZX_DCAPS_PM_RUNTIME;
+					  AZX_DCAPS_PM_RUNTIME |
+					  AZX_DCAPS_4K_BDLE_BOUNDARY;
 	struct snd_card *card;
 	struct azx *chip;
 	struct hda_tegra *hda;
-- 
2.17.1

