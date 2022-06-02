Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72853BF66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiFBUMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiFBULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:11:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98618101F;
        Thu,  2 Jun 2022 13:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxiL1q/YzRGXNV2tU01EuFJjhPDNLHaDAATdpbKfJxu2PcCicHdGdICZ0AHuz67jKEGHLK6M77PJAekVnACDVruWhgFyFJGe9m5eY5G6zQ3lkQ9YxuaLyzyYiBR09/kaVyDHhvlMpmX8hX60HpRLlyl3nNr7+Yk+rUrFzaX9zgAwZGl5M1GO4U+8tWtDogzR55gXQhFmMjg9uFcwRUSbO6PVlClfUpkgMxj7QozYH8N6LJCXBE92HCm2ll1sxiDi3HeXSBxMBa4qlDXrOejZTW6eMYB4W6eLSfG1EYpsECfd9Pru1vNwJLkxENJXQoeQr5tttrizo8a/eiw+vKYBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ey6OZeVHXpD5mdtbms/CWNTFneWrXwgY2HCfNz0chc=;
 b=bTnfH6Up6xXL4w/cJM8wL0SdVytj4kOJdD0jR7ByRVaySIyP5CpI+rHLn1kVBlWa8rEGvuOH1rxaQfNtp9dR2uIai6bfDjF2znpAZjR+jH1ir7SSdeUORquvgKQwBHxVAhET+NXPDq3GiofjlH8SHkEo7DP0Gjo2BSwY48+bE6MEd1jQbX5Xh1+jdnKTOw/PWWx9sPCpvtzkOTGQ/HSNytIemOSlo5bGMTtl8YOvCY5IV12oLT92yA7JA/1Qq0i5iCI/fhs+c/OSZV21oMDqs8zd8QWOzR+J/ynMzezGf1BroFaAwBAPGSUL9a215GaiQzfX3KlEaAFOwKMVaxZOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ey6OZeVHXpD5mdtbms/CWNTFneWrXwgY2HCfNz0chc=;
 b=cpsu5jhPwD5F9ysTJv1GCiW0fv2GCIo6A3afZrs69+WveLSPTlEwuBKuYONwMNpJAW+9WnWhnqZMCTpdSTM5lh0lgaw8untbK4bKzy9RSMHEqay+8HcUK62HwXqinrIA5cQ/FejRh6u+11lTk5VXgq+tKYLltBQyhi3CCtnoffs=
Received: from DM5PR18CA0058.namprd18.prod.outlook.com (2603:10b6:3:22::20) by
 BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 20:11:44 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::c9) by DM5PR18CA0058.outlook.office365.com
 (2603:10b6:3:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:11:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 15:11:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/6] Add support for upcoming chips to k10temp and amd_nb
Date:   Thu, 2 Jun 2022 15:11:31 -0500
Message-ID: <20220602201137.1415-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29295ea3-b129-4191-ba3e-08da44d41d18
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130D8936C43FF5BD2C4B04DE2DE9@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOgdDzNandrlHLShgqjo5Cny7pbLtPgUzJqoekvaa+uFXfcKxmKe9OUZ7BS4xbmuIrpVepOwQBUks72QditJ+qXN0cO8PqpLFv4BWlGEGic9/aYv0LlpiWJ5PSsM/TgMrzBEAz3OHZFRiTclSC1l9BsKylPuUFEOFtp0hqpxdVS0WWlVivj1I3wD4JTmmFqywsmth1/K84Z4K4oIVnqk+d7MScrXfuQWmf0qLGnlwc755I8YYDrEuDNhawIU4utLaAsiue/O1HJ0rxg6Swc9AdTBnVqrV99LM3EFW/dndpAhP359bBKAlWCvaLFgmPrcOQGdsAtdddEQO2CzHNCvH4ZfsQ+mVDHGD3xuSQICBU9xOe7AROINemsyBBa8U/+pvw7fbg6/h99i7uaxfN6wLXO3HhYuDmFs+yf3udjYbTeiDbdmoxPqb9iB5IGfvdnjpgRlYFtulibChzD6AhZaaoZYbFRxVRJPL1FPqgvH97SmadTnampHgHReNdlKgESkMQotTxgEM5WHqVj3RZ9gntTfDGny2etE6l+toku/BC80gw81jL/k9zPtNgGxBtjXZLgF0j+o0LRSDfN+aTmdRgtEWXiydBBTxM9unDTT1h/Q+Q8bhTK3c8n+711wxw1ALdpVyuONYOBuriSYyvmHx85uxPwptGDZWvlxtoluaqkDMZcEr9KiZhROI77x4Jvx7ZBmPgeW5uvW6X2G1pacIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(186003)(47076005)(426003)(16526019)(336012)(2906002)(7696005)(316002)(6666004)(54906003)(1076003)(6916009)(40460700003)(36756003)(86362001)(2616005)(83380400001)(8936002)(82310400005)(508600001)(26005)(36860700001)(44832011)(4744005)(81166007)(70586007)(70206006)(4326008)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:43.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29295ea3-b129-4191-ba3e-08da44d41d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series started as what looked like a correction to previous
commits, but I missed that the previous commits were for a different
family with the same chip models.  So while fixing up the series I also
noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
yet supported, so add them to amd_nb/k10temp.

v1->v2:
 * Correct commit messages
 * Add more missing chips and offsets
 * since so much changed, do not include Bjorn's Ack.
Mario Limonciello (6):
  x86/amd_nb: Add AMD Family 17h A0-AF IDs
  x86/amd_nb: Add Family 19h model 70h-7Fh IDs
  x86/amd_nb: Add Family 19h model 60h-6Fh IDs
  hwmon: (k10temp): Add support for family 17h models A0h-AFh
  hwmon: (k10temp): Add support for family 19h models 70h-7Fh
  hwmon: (k10temp): Add support for family 19h models 60h-6Fh

 arch/x86/kernel/amd_nb.c | 13 +++++++++++++
 drivers/hwmon/k10temp.c  | 12 ++++++++++++
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 28 insertions(+)

-- 
2.34.1

