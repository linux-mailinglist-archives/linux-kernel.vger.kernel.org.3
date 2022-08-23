Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145059ECD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiHWTsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiHWTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499EEE12;
        Tue, 23 Aug 2022 11:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ4Fs/bee2/cNDUXh3l3u7Qcb6LNO0GqwXy//A1itGwHHd0qY+owmE1yJ2LYDHWcqB6nuBKBkM7jDrwoE9PS/aTIEm0xE1rePrr+mgdvTzKssagklg/89Qw9lUkuWoj1FJ2g/ypHzRFcfF3xgCOwF68gbSAgDdXLjNx1Z6LLiobH6tKGkl1KGfed71HYxF1XcXaWFwM+VZDcCqbedsAY27rz52ySuNNvHb/PQsmemnT58gzvH7T+IklMD02Y/kjAag3BeZQnZr42gWXla2fbaXfowRM0GaEHS5N3GELw5ZetGgbjO3/ZR15FuBmot00Gxd7H7aK0l28gSHeEnR0mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThCe2AeyMszMrjZlffl5JDkCXNOJ3GrfsgCWYhio1zg=;
 b=CTZs9elJcKh6zPh2Nrz1rOYxBaA6WqjsF+zt5GABIx7/OcQ3HgZFwbYXbNMHb4cmWsF1A8tWhjLT8KklWb16jITqwtKP5nTrrDabl/ITZJaCEQBJWBN2rzKpcXZhhh4HkNr84LtZzlgYHIu5uvV+2DVFvMtTnd+OGQPfgFW6WFB77mtkBZtbxR/hC1H+8bQlSCr0E0O/ia/f/RfPt4pgRGrBK2DSWO+XC8S6JZpe77TChLXgr4m5zOZZA7L3TiJn0AKlokqdm6GAMUbKuQMjYYN4wDuqZJ4r/U2QxRQMulocqN+6/EtPAje3TMbXpbQyDkQsVEocuQ63gIgrD0mH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThCe2AeyMszMrjZlffl5JDkCXNOJ3GrfsgCWYhio1zg=;
 b=kz76vHmV5wAMl1Xx4dqJeEmOVzEytWnfKKLFxrb5eYf9xlm9s+T4T9SDWZ7OFbGCTcqiakmml6j7dwcMV2aOb3Sl9YIVWT19b8v8RWKgXQL9wSuKYlTO+FCCnm7BBlU5OYoT6OxL8R/l3Dx4tgE7ZmDUt5eiZKfXX+bV4pqahaU=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 18:51:23 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::16) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Tue, 23 Aug 2022 18:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 18:51:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 13:51:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <nouveau@lists.freedesktop.org>, <hdegoede@redhat.com>,
        <ddadap@nvidia.com>, <Dell.Client.Kernel@dell.com>,
        <kai.heng.feng@canonical.com>, <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
Date:   Tue, 23 Aug 2022 13:51:31 -0500
Message-ID: <20220823185134.14464-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823185134.14464-1-mario.limonciello@amd.com>
References: <20220823185134.14464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79580f12-5648-42de-3e72-08da8538796a
X-MS-TrafficTypeDiagnostic: PH7PR12MB6718:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzDp1L7kswL62aYDPILXBlEj66uLPHzSBlz9l2JnWF4Ky8qvfuFqzRaTbg4lgNNg4v7LeRWqcUlNA47i7pvBuOSxeFpKugcKnzzWQ+cdWImf2YzNt1ylfE5qJQT+XfQvnwJP3Bn0w6sGbpPfS2WnAuK6qpID+J2Pffd5fnSTwaqY7CkCi/1Hz8dOcGfL3mOI9LmpLfesbM+MwB17l4WV7Wm0/1y8GMqZzwwRBrRbsuwAGmSpiiMMMY5JAsIZh8vmvMZYK3JnA1hSItMd/IGrhBvQ9SKnO11Aw11eLcXhlUlIE0ZfscCZYLI87BfMJ1xrRxbcCFVmPLRks3jNSKZiWnkGYpGJSuCM5rGUmEG7DCn9ulEmEO2eeVLUcx/4PloS8oalg2aDhAsBIMJEdf8+td4ytT+ZHJXbGxnT8uM+iqCDb5l/eY7AIwG2/1kXYzjfsP1vXsY+jG8ChzETa4GeL5Pyl1xrC1LkVsVWqYNxanYAF2SMXzoJvjBgUhJ08Iw0tRwkMcyUVcU9vHnuDchSgbWT5QOcZjFqtO1s8TESMmWe1pU01Io5xBlev8kGCcJVoFtxN4vOyCPKY+bz5D7cNVa25Kq+2wjSCLTTNEmXhCOKDozvvmMGUZfwC7fO+MoStlr+V/F60TiZt78S03OE+TILM2N1iue5j3hWsrpYyecfr847dM7gbZ0xTPcsviA5taqN2PI72HiVT/VEjGt6sGg4n00EZ1QuYVWhGQDaqlrV2HfsDmq21sj/YdamUO5q14FUue2oEJcZHQ5fjLyvqtsHmskEML2KyOlsiqWWRfW0etwD5dIcJ1kR/HcSNtF4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(8676002)(426003)(47076005)(83380400001)(2616005)(26005)(7696005)(1076003)(336012)(2906002)(16526019)(186003)(81166007)(356005)(40460700003)(86362001)(82740400003)(36860700001)(7416002)(82310400005)(70206006)(5660300002)(44832011)(41300700001)(316002)(70586007)(54906003)(36756003)(110136005)(478600001)(40480700001)(6666004)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:51:22.6140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79580f12-5648-42de-3e72-08da8538796a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This string was introduced because drivers for NVIDIA hardware
had bugs supporting RTD3 in the past.  Thoes bugs have been fixed
by commit 5775b843a619 ("PCI: Restore config space on runtime resume
despite being unbound"). so vendors shouldn't be using this string
to modify ASL anymore.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/osi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9f6853809138..c2f6b2f553d9 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
-	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
-	 * cards will hang without RTD3 disabled.
-	 *
-	 * Once NVidia drivers officially support RTD3, this _OSI strings can
-	 * be removed if both new and old graphics cards are supported.
-	 */
-	{"Linux-Dell-Video", true},
 	/*
 	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
 	 * audio device which is turned off for power-saving in Windows OS.
-- 
2.34.1

