Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A44B4D01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiBNKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:52:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350045AbiBNKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:51:09 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10688B10;
        Mon, 14 Feb 2022 02:15:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enSIdfx7WpgJFhaqDune0tvZCjBwt6wsvtjte+oqxkt0j5B6cot3fZC5U/CJK4f5rwlwzKhoX7Yo3g1yQKWGSvC6imV/MsqthiwGHYgKX4ynSzo3N1AuHvZQZd9OLl1X6jR73bRxp6IQPcBWYr5lD983VUOTPNh1ouRFxk4EPCWROree3Zr1M0Px2GnhQnqSkWMJXycn7lacD9HxTNRzq5kHhDdy/LYI8wRxoRgNVtI3rHvvXboERRul1qX2htUGqYFqtFnQM8xNzJxySKCieAuSb/0WdT/juPxtzqdfTIRZGW75ePtVguHphLzL6ulXxMx6UeoGmUy031fcxZf0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNbkBH7B5iMPv0VrmuE3kbcImPmX9WR9+nNGVLrN2BU=;
 b=hTgBVdrq9KvZ6Er1fA1RFIBAEnOXm5L5iWKX1zdq7nQ5G990Rgs7LIgAne7YR1d4uYgIENb9ielUv0Mixrth/mui6nbPafb/Oibpo68kPsNOGCNaH0nLOrkHRKodTJYhteHqm/kt2tjB9sNMHKnWIcDNdPTR03VtV6IB1jUCENp6knWgofIMNnG9WRv39yRprtt0xOiZphKkuzshJVo2VqEs+bNfQhdIGon4aFCzSO7eiEF/BJLhm2443EHIfkPiRAiV5wLbOYUIaS5EvgucpBAnFiWb+Mbo2FmBSwTTY5XULyt19joLnunJof9ehgw5jGOjHf8cQ0UPNNlMrdpVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNbkBH7B5iMPv0VrmuE3kbcImPmX9WR9+nNGVLrN2BU=;
 b=0QQXmH1KqBfIW9PL3UGfHI5W+XiTVrgY6cgb0RP7v+40UqsVtDvqDYvnkOnIKQb2czaiagGr8/TZMouxIpUtsRiWq4d8kOpr3trJk4toI5MaIB/zhOmCF57sUmwQD35CWjC9y5nVWI4PZHQoLvqOdStlZhYGDdRNz3z8+VVqB1o=
Received: from DM6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:5:174::18)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:15:17 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::37) by DM6PR21CA0008.outlook.office365.com
 (2603:10b6:5:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.6 via Frontend
 Transport; Mon, 14 Feb 2022 10:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:15:15 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 04:15:10 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Deepak Sharma" <deepak.sharma@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 1/4] x86/acpi: Expand the CPPC MSR file to cover the whole CPPC implementation
Date:   Mon, 14 Feb 2022 18:14:47 +0800
Message-ID: <20220214101450.356047-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214101450.356047-1-ray.huang@amd.com>
References: <20220214101450.356047-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869c178b-2ec3-470e-62ae-08d9efa2e4bc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4145D5A6D759CE163618FF1BEC339@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJQTZmikMe3o+nUNhi9AW+c4o8UU4H9fvILRFOcRWM8NWA/D1i+B7zPnfkvRkjbod9ucbu9yBeXOPO7hxP+SswuEGDvXB5OYkAygHzPWJBOctvadGc634XURwIbRofJrMzozx4nbkVkBIH/49PxTqlOSGFmhtzk2fDnsANxIhn36QatDM5ACDGhwLv2///Dj+rmn4nK5RMWLAyGc1fyk1riltMagfUX5g2tmzLQoumNTyNstxsD6iZmVNU05shiVcymJyngbtDEYlGvkE5G+uEpxs3cL2DWUopEwjC0Qr6t7nFwpzuxQdPOYMgSG61cwkiHOxi7RbnThlQYWkZ7ul+vTSRMXZ1DujDeSMrZZZ49sjIOjvhHkl4n0/BHVIM3hRIV9DXbKG5hdi7SinmOJBAy8G3EaVkEjDBf0kuV6XqA0I/NIZXq3aBR9dXemlPl4SO/8lJDj0PPWARkXHEg2qB5xhJUZq7s+z8xYg5auLfG+W7yjPHMawMaZWhk/HU0JYon8+WQHPYtvBAyecD07v8HmuMMNv6/PwoXyllB7li5NSNwg30RksdxKKgjwga0l86+7aKo0LPiYk1+Qp1vzWmylarrywfPGuKtYRfP32qp8n8WhFsN1e0O4xJRg5Dt/0pjjVReMbh8ZUMQkSi0zht+Koz+sT1SV8p1LtdBlolIMtOcuyws3Fdf5mKznk5vxQBvpII8JLRCP6nuR8FpL9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(508600001)(2616005)(7696005)(83380400001)(82310400004)(336012)(426003)(186003)(1076003)(26005)(16526019)(356005)(4326008)(8676002)(86362001)(70586007)(40460700003)(70206006)(8936002)(5660300002)(2906002)(36756003)(6666004)(110136005)(316002)(54906003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:15:15.0146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c178b-2ec3-470e-62ae-08d9efa2e4bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the cppc_msr.c to cppc.c in x86 ACPI, that expects to use this file
to cover more function implementation for ACPI CPPC beside MSR helpers.
Naming as "cppc" is more straightforward as one of the functionalities
under ACPI subsystem.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/kernel/acpi/Makefile               | 2 +-
 arch/x86/kernel/acpi/{cppc_msr.c => cppc.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/x86/kernel/acpi/{cppc_msr.c => cppc.c} (96%)

diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index cf340d85946a..fc17b3f136fe 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_msr.o
+obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y				+= cstate.o
diff --git a/arch/x86/kernel/acpi/cppc_msr.c b/arch/x86/kernel/acpi/cppc.c
similarity index 96%
rename from arch/x86/kernel/acpi/cppc_msr.c
rename to arch/x86/kernel/acpi/cppc.c
index b961de569e7e..08d823d72586 100644
--- a/arch/x86/kernel/acpi/cppc_msr.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * cppc_msr.c:  MSR Interface for CPPC
+ * cppc.c: CPPC Interface for x86
  * Copyright (c) 2016, Intel Corporation.
  */
 
-- 
2.25.1

