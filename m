Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD257A783
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiGSTxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiGSTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB4A52E58;
        Tue, 19 Jul 2022 12:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEj3jV5wJOpQF7SLD+KnNPt2r2fzWg4bjPNXRFHX8jnZfKuTm2u0cd0GqtDjOllZ6txgt/JinMOhCs1eiW50NDgAjJyefYEpwO4ZkBasD1ge+xDUf9xxYayLouXH2G6yraMBepmIVkJSx8ZtjTGQX2F4lO2GETUPnNfheq6tx0MBUR9ga8VqVBBs8jvxDNfXhRNs5wE7NfYjiOTnR0bVA1JA7GkQUze7kh3VECS24m9CVPTVjSSdrkbb2mXrSTobLi/ux8poXe1A5Mq2IMYnfmBF1YTQgoDbe67I65f0t7+aSoQbTEqW0M19TIvJoVTEMNYcMY5UEH4SEgjpOAqh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVtM41PHZVkwofyD8tKB7HGzFu9ic5r+BzfB3+xWvvk=;
 b=LHfj0k15SW0nDFSU56noGF/drBDhI25iIq3T3K4e0I65G5FJPLYWMBefWfKcCMxBNMEaKT7DgYupDyv1aH9BosqKPE11/csyMTyIJVPQR0pqKQ0DNFjgBCvMy3TUwEuKySaXVUTFuHLbm5YcUfJ7altAfv6sfNc+2bZrtlReD6YdP0eqogXb9XOQCK5G0pIO2Q5RYR3T9e1/lg5MIqUAhLt/RCFIjirTNz+bfDqgOWOM2ZN2ZkSTlg0zcPokk91TORTxlX914i54sVCieP3hvuPDFtpmW8ovXpxmaovPoiMJ2ntIEokzpQ8tfwO7hqu5uP8Isv3Vz6CQJQJ+WBARyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVtM41PHZVkwofyD8tKB7HGzFu9ic5r+BzfB3+xWvvk=;
 b=ppmkvJDC+/r71RymaiUXFrTNFib5w3DOuGw6HLMuSVjJKpuM0+AKJ5VbR09ocmrSInKHnR7Ii4IsgJ+3oXZEum5QWy4F694woC0m9C4F3DYr+bj70eeNDJ11Zu/Q8yO26aQ4leBrYgZ7DsjxXQskgKWFq+jSrRM+5EGZnGtLTCA=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Tue, 19 Jul
 2022 19:53:01 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::5b) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Tue, 19 Jul 2022 19:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:53:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:52:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 3/6] x86/amd_nb: Add Family 19h model 60h-6Fh IDs
Date:   Tue, 19 Jul 2022 14:52:53 -0500
Message-ID: <20220719195256.1516-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce6eb58-64d6-4580-b937-08da69c0496d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZbrctS3irsKuE1Q1XNA7+rkIWX/nid8581xocCppXPwhn6/0cNBJXVb/WyXFT94XrEonK/XgdLYzyX45x/T3vgJv+iVS25eWBtveGKv7IJnMdGRLHADA8pKemSvLksgy5yZqvbDENCsrbDKPLi/R1ueI1rKiNuFP7k/innvz5PmThDnPTmQEdbBmwBCdmO6f/wSZusdgGNuhVnRhC+MZXWO9rlZkR88efy00e2nlEgNbU3VNV9Ny+APxI9lnQ76IAH7YvCPWzuQ+FjPchuFSbhbYyuJDPaBZJMj4uUUPheYHOaqWq+F4nfFUaBiG1b9/njgGRG75hbHTkq069xpGWny8u9NTs1k2t0tZGh9vXm8HIM86pk3RG22kEAU0if+BecS/MZZrtkbuXZrZvua0DIJJ4Y1I2EBn9sXBotal2xonbfKCQoLNx7nY30dZjtLSqBx9CKNfNWPnNX3m5NTVJDhjTYaDOO2j9RfEsBEnk6mzTXgBRQngu6kH/WYl7kCue+dUPEKiwsaWkyfn011s2Kj4QZ7JPyuPWoHroPcDhP9LCeUI85iibCaDHODOlBkiGSxkWvQfu4v18Beh+n0b2JBzGPFNNOeUUIWnBulNAcQG5fsZus9uuHUoQUKv544PTf6Xa3vgIOKude+eHl2PpKdIBz/2qwpxvubhOwUOvaNeWBjNyU647PtbCgTH6SJwIELTyBsjUYPp1wJcPo6zdOJ9lyL4zQeqYOpBVCazWR5drD10/OrZc7IzBdSbWTnE46R0PXdJ3HwWRmNLa42w50tO4t7Rn5Ilelr5DxFcxhL+VCwy6875gwjdHzx/QL+aMNGyZDNa5dFvIJ9DKPDIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(478600001)(86362001)(356005)(2616005)(41300700001)(7696005)(6666004)(26005)(186003)(110136005)(54906003)(1076003)(16526019)(316002)(426003)(47076005)(336012)(40460700003)(40480700001)(5660300002)(70586007)(70206006)(8936002)(8676002)(4326008)(44832011)(36860700001)(36756003)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:53:01.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce6eb58-64d6-4580-b937-08da69c0496d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMN communication on Family 19h Model 60h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cb7a40378ed3c..4266b64631a46 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -21,6 +21,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
@@ -33,6 +34,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -48,6 +50,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{}
 };
@@ -74,6 +77,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 32a1f85ff0de1..7fa460ccf7fa1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
-- 
2.25.1

