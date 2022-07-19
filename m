Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F757A77A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiGSTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiGSTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05CA52E4D;
        Tue, 19 Jul 2022 12:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4D5jEIUjcBQzuw9WiDi7YR/MJhcikZ/+H8pIuqkWrD5o2ANpPb5JlAhizi0ibRKeALk2SycGv36NcnSE5l0EyxPR8DmjblUKQpZyohF/UyTwMVy4D3jSpJaGXD/f5vp0sXHoDsnB7d4LkLKHt6N9ohrIAuWH3elA3TovIcBkW/m817MGzNTU0DCOgCSjga2GmY3L37E2xSRv5Gc4agddSxKrjXGkwX9pMYp/yWeGa3lTXMZu+x+82wEJIYaHTpDM/ZHyV6wjQWnEJaOJIPX8e8qhmPHfoA8BKKhpmfcyCe0rWJN2eY/gMwhUsVt3iZsdLmVgA5pwnKSt80ointy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06dxfGY/uHYEXrufOAjnXuE+t8O1Ijb8KbLB0naCBao=;
 b=BKm7rm1G+mIOSH7S0UcCX6f4J7/woJn0/KiHSPN/sO5ljMa/9pijEbl4h+Rj98yCVGqdvSLkZfdvFiqmGaBUm/6sg3yz36gYZl12ylgsbuEM9gtjWruMVPwA/NGlzGcw1wLCjXi1+HMZ07Id+XN3PCGyMwSuSkZ6xy+1paE3eyrlYEJK/C6dtd2k0INm/zVmejOKJOIrheEXAI/gxi3iZwOx6zW7uKxt9LICSlr4uR1ToQQfSjNNd0snCrp9Y+jUR9aHn8S7RkwiSuv0N2Pr8ocBt5ZL5GGaBQmbCyHiQNRgKf21OfPkuXPACZSpeq77Pjx/XuVpxugZ9deC0TQnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06dxfGY/uHYEXrufOAjnXuE+t8O1Ijb8KbLB0naCBao=;
 b=YPw+Zq7zscFIaXiRkINNJCmX2yBclhOOWNfGhjunBxF9Q1YAkeeK97akgiq3O1vsh6QlJonamSBI97bjW5a7myUoTrKpPZscP7O9iDcnd4TX5lr5bcamVN5vKFqnu7iITZ/mTEKnxLdu4mVEtdzg+eyegKnVlCaXlqIttnothDk=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by DM5PR12MB1210.namprd12.prod.outlook.com (2603:10b6:3:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 19:53:00 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::fc) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Tue, 19 Jul 2022 19:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:53:00 +0000
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
Subject: [PATCH v3 RESEND 2/6] x86/amd_nb: Add Family 19h model 70h-7Fh IDs
Date:   Tue, 19 Jul 2022 14:52:52 -0500
Message-ID: <20220719195256.1516-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 902d96f4-2c5b-4063-37d1-08da69c048e8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1210:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InSyx44PCWGEbF2qSkRGtlsY8lpI6sQnn/ytdEIBn2sxEYOT+dpX5F3twBMMoq9/pq8vr4+bnsjumXHPpP+we2NAE/LmGoEwOIjANvOVBp+R6kYye7mRefEQ3cQ1OEJF4guKq/78Qj+1JJPnaJDP68MUHaBI55CMem9i9Fyo6hyU3iKJtJ7HUPCTyihd8N9hlLTcaEmPQmBxhB0t2qZjQjhOfyy9A/6Bn6EQ7wC8t/XJEHPgEnGUwQZQm0N+DXr8UbSCi0GJH7J1+qIOmLnE1l56zw6l7oH9OaAQZD9q+1n566JRk8dopmfKe/Kefb8BDHADR+hwSxgJXPvc9AlOV6HKA+tHhaVc/+ZPLuO74UPKmvSsM5HJanW/Py8hKpvjn2D2MM30F9H3K3dSA2vHUbup1D5udiXmAO8dfv6mfdo1gIRxsbNNbUqirSOQI/YXUcWDWKlt5kNewJF2svnNKDno5z5WTyiZKzi4oMjzREUljrg6/kiIUfI0bZaRJVe5n6O/nB5x5HPBR/pFXXd31sGUzG0Bqun4BMcRV7bFGZaEgv9Vox0at+S+m9BxZJUjUvVwG+b4Ko+/SlH9Q9ffyz3vqG3zA+hp39BRCs6/GhgFi+FPZZHQC/1iEEjU7T52BSYNWctNxhgX8Bq9P+e3K4oAgQaCetHwMO7XRFwPs+yZIm3EHmj6IbB6ycFzn9XgRL9scAIGzVGWSD4RG1ysrN926iPX62I+LFUJe54l1rXqEWBiXfQxw8P+v6hGdAs8O+H+EhNfaAytaTisXVIuV8DU7tPotpnOmgqjaAY8y1SPaHCviHCOEoVINQjOV6dBcWhmXFaBdgcrWsRF8uftcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(82310400005)(86362001)(36860700001)(40460700003)(82740400003)(356005)(8936002)(478600001)(44832011)(41300700001)(5660300002)(81166007)(316002)(54906003)(70206006)(336012)(4326008)(70586007)(8676002)(110136005)(47076005)(426003)(186003)(1076003)(16526019)(40480700001)(2906002)(2616005)(6666004)(7696005)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:53:00.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902d96f4-2c5b-4063-37d1-08da69c048e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMN communication on Family 19h Model 70h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 60c7bd525237a..cb7a40378ed3c 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -21,6 +21,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -32,6 +33,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -46,6 +48,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{}
 };
 
@@ -71,6 +74,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ec1c226d13e60..32a1f85ff0de1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

