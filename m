Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4E4AE8D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiBIFH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377703AbiBIEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80EC06129A;
        Tue,  8 Feb 2022 20:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzbemRME3wJKKb8USKhjVQHVxtip7Xq3lNgrrI3GALgLTd0GCBPsKzmFNw1BF3ovbKIOOaPaoWok6xm/lpAF6gl1VOFqgpDYyYCRyVdNQCBSa1k+M5YgKcGwbfe+yaVvjg0Niu5/Lmr4zUjEWI4S70FnVQTG9Mjvg36hN3Jp7262oXk/Cv9M26iO6MBDvM5GgZYS2g6Ne64KSIddhWKxLWp/EVutHJXRWD1n2abPd033AvEafD8kDTd4PU8RSyiMdWHDDgF8K6EH3K/l0CMwVPenUQ1IMTMtZLaybsDWN+dPe/ocFA5ZW9muMKQkoY2Z/ZD1sxH42TNQxpb2r1Yusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyzCqJeD1HQ0eLP5+04rVR1LsYSQBNJgx+wbf5BLld8=;
 b=Cr6IY3SMtGGtxoyFoo0sjLrdfuY4/AEaxBciwXfsmoth95PDUwl8VINWEvBq5CPSIwjr3bnk8g9Hija1n9GBIwXbW8Q6TtVT4D+ZoMi/l0lMEKROSkTDikd/h9jN9ha4515Jy5mbqD3MHXMhjc7N8Yh/oa69mGsvzNKin7JNIxYPxWkowIem1EKtiPQMqA3TdtdAPd1EMXgTf69TuJ1YFVawxsP8QFFUQ/SrsiV+sD5uRCJ/BrUzd8LZn3ZTrdfCUM+jDqJaqleWF1wZrrM79h7nwbNc9m4/cDUQMvH2nvcK2fk/xsXud9UzSllR1F+CBgk0aX2FN1825as9BardpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyzCqJeD1HQ0eLP5+04rVR1LsYSQBNJgx+wbf5BLld8=;
 b=QSxnRp/grxlPDIFgaT0fLf1ieb+Ha/JgN7L+H+kksrku6AwwrN7Eewzdzv5owhUZU+KulwxA4/7zkS5rBalwNp3HO2CWhYULwXIlOlYkGLP3Gn+NcZmu9hvmIezhAFA0Jiew9/ez6ylZ1y3uo1kGDcAkLfLfx141rk7l7xv413exJysVokaGkpxuBcWF/WGUWVdA43fICi37QZWy/7pK0y/QGX9hWQLuYnoxTBIs7QitzQSOsVSR+EOPsP6AxzAhjnjf+FPbTf7Ug26delNBuNrhQk9lqQYZy0xWwCdiHLYmWpJdxnQvkHxue46Dg16MxhSlFuSlY9sco2bbMu9aOg==
Received: from BN8PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:70::19)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:24:00 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::9d) by BN8PR04CA0006.outlook.office365.com
 (2603:10b6:408:70::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 04:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:23:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:23:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:23:58 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:23:54 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 2/6] ALSA: hda/tegra: Hardcode GCAP ISS value on T234
Date:   Wed, 9 Feb 2022 09:53:22 +0530
Message-ID: <20220209042326.15764-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209042326.15764-1-mkumard@nvidia.com>
References: <20220209042326.15764-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78464057-eff9-4674-7edf-08d9eb83fee3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB312545832646005B6ABB8AABC12E9@BYAPR12MB3125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3IDJW90CLB2W0iYuE3axv7V+PvPcXclKOIV7Sws865O05/+/46S/PC8PCgwfrUx0RDH+z+cJEkyo7vSd8Qd5H/p+TaS2iPaywQ4F23SDiWhEriHCwsVuK9wMUfOax5o/HtGmboLj0p+iJZo/qL/4Bdbef7pYFRfL/NApVwvuQ5GG760bqOAy2/yZbN5ZrpY4G4VOmFXFBBetsO8DS60598vU47SL9K4ZngLA118MBuNAwW/lTcM4zvQJcaoJfceZNHSxp+UDiSFiIV+NK/Caw+Gqb0b9hi6DUWhrNw5MWeQJ0wUkYLO+qIIfMpg12S2UVHS0qy8z62fQhvtmYpz8Pfkj2RomBcrptOEq9qkrQss5uHrBsYjjys828o4gw3+vrjcgN8zRaOPWmeEEyl8ofTrH4BxoAglSKgXaQB3peogyKvVByj9yCp5U58Rx1GpUclq1JO/P/2qyHgR0DpEv5aJF3tCJbeaXJJ8CCZNGZKpr+juW0DOZrXRgu3f22mwBrSsW/Vsl5TgJAQ4jgsQv3Rr2wPBcA1hRsFV/NYBlpXa+a5vSjRPoAeF2VlstyTVTyB63a2ybRjZKXNqBhcsMFaSNWPU2QoCu7a8ZBf+34GRn4ONaIEr8lkL7IuLZPsC7E7zjNFiJRmopANagigeyU6HcwpYDsIbgEILhd74y3bkNwlI86MPlE2JIyPEX/BPiNjXGPyR4OdrwemEVuZTMhwr70lJO5LzoFMcj48g1N0=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(70586007)(4326008)(6666004)(8936002)(70206006)(8676002)(86362001)(7696005)(508600001)(82310400004)(316002)(6636002)(54906003)(110136005)(2616005)(336012)(186003)(426003)(36756003)(107886003)(1076003)(47076005)(2906002)(40460700003)(356005)(5660300002)(26005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:23:59.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78464057-eff9-4674-7edf-08d9eb83fee3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCAP register on Tegra234 implies no Input Streams(ISS)
supported, but the HW output stream descriptor programming
should start with offset 0x20*4 from base stream descriptor
address. This will be a problem while calculating the offset
for output stream descriptor which will be considering input
stream also. So here output stream starts with offset 0 which
is wrong as HW register for output stream offset starts with 4.
So hardcode the input stream numbers to 4 to avoid the issue
in offset calculation.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 95df52b0505b..2347d0304f93 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -315,6 +315,18 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * hardcoded value
 	 */
 	chip->capture_streams = (gcap >> 8) & 0x0f;
+
+	/* The GCAP register on Tegra234 implies no Input Streams(ISS) support,
+	 * but the HW output stream descriptor programming should start with
+	 * offset 0x20*4 from base stream descriptor address. This will be a
+	 * problem while calculating the offset for output stream descriptor
+	 * which will be considering input stream also. So here output stream
+	 * starts with offset 0 which is wrong as HW register for output stream
+	 * offset starts with 4.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra234-hda"))
+		chip->capture_streams = 4;
+
 	chip->playback_streams = (gcap >> 12) & 0x0f;
 	if (!chip->playback_streams && !chip->capture_streams) {
 		/* gcap didn't give any info, switching to old method */
-- 
2.17.1

