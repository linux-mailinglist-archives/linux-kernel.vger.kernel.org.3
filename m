Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1A59ECC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiHWTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiHWTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C6796A4;
        Tue, 23 Aug 2022 11:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJfcYpMMDQ1lIbajmJHh+2qks0gFVafBr+EMEK1vjgeUpLAHY+ExH755y/BSw1/RKyVkIB4ysEEnxamoIoDhKxfSwC3+gRFbP11GX8dpjzqxp8wd7Sy1pZwFFY7vcJyYUC15fl9kwWax56S9VdaeuRVUScPUF7C5xDf8eOZwhtKsLWMVDNW8ke6rBOiEamRxJktR2/xIqeON8dot6pr+MxWGDJafQY5Ni6aAgENfyR3MYKr8F02FIn+cyQx/K0Fl4/IlA1fFBBFuj7Zbt+vDUkjmm5m96otykrdZOGU+7JytbLdCDjxlGN4Wzf97/z0zWOHTrrHXI2VmXsmnSeLM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=401Aqicbs4OpGjnmI8rHua9yPnug+eO0sISZof9ZJo8=;
 b=DxWxq12EIg6PKL+tydRBV5289+mVH8pwEjDtBXp8Es4xI60HC2EDD5AWQo4dZZo881OId6E1V/FhTcRkEZK9FK8DtqrlAZ/6JU0rO2ywQwcKTLiMVrOX0fsoE0Vdla+loDAUsCx9h9QhG8VATLHSgKOAl3biEmBDmFjwxRaS02gC6z0UGGGFhid/n33R4IqO6Gw2ToeF10fa7jIiiVJf/uiaOPqvCUhOR/WmHxjY23m+gcEGEf+OLp+bpf4Y+Dz1J1/8cdDRmzDmSOnoQSPHegGBvMYO8qRLHralTTdYZ4cGCW2dKy3FKe9HiQVgsSXWz3uvvRjrkkNkDIjOYzwa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=401Aqicbs4OpGjnmI8rHua9yPnug+eO0sISZof9ZJo8=;
 b=pMrbPTiZ4Qqo00u94b2giXHcPvVAzi0h8w12Z666MFWFJRf3+W5VghV0Yq/F0/iBDhsqmjgAoCZ7zuV8RCmuftqAYnBBldyiaV37Hvme3kFpPrbi/3xX5gMoJxLKc9IYWU215l0911Di5G6KiD8LNm67Ovk+XFTluhgEw1SVxSs=
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 23 Aug
 2022 18:51:24 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::da) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Tue, 23 Aug 2022 18:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 18:51:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 13:51:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <nouveau@lists.freedesktop.org>, <hdegoede@redhat.com>,
        <ddadap@nvidia.com>, <Dell.Client.Kernel@dell.com>,
        <kai.heng.feng@canonical.com>, <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ACPI: OSI: Remove Linux-Lenovo-NV-HDMI-Audio _OSI string
Date:   Tue, 23 Aug 2022 13:51:32 -0500
Message-ID: <20220823185134.14464-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6cdce385-1cd1-42af-ab61-08da853879fb
X-MS-TrafficTypeDiagnostic: CY5PR12MB6082:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3n3JIXOKdYqqYXT6EmUWxMt/97ZqZHFKGyzddw0Or00HySayero2LnVZK7WtVQ7rCT27tXjPKE8eAC1pI02gQJY2ITmJtWdUEazPeRnsGadwWtdo1Dp2+vQkarJoVQH9x0QAMT6BpwuTL7ZBlRwJ5hHkHrMV4SFvc3gYg+UH5XsoCkM17zu38+trSRyXh4Kund2s7MkyCcK02EFgjOH7t8K8kVkFkNLtJMU792oGlD+cQdfpgWI32vKXgzarf7L3mfqKkPK09AsKDeum+XeMZvxIde+ZLvFIVMCaXXOsKGsq2ZuvCzcsxqj3nEUmg9CNU5ZvFsH145kdY51bOW0YPh3n/Juzj0Kh5XpOZkAsXuBFzP1diZIJNt/fkXnUWzH1EFbRUwzdr9H/U5rg9jy0JxnRsL7LqYAHY/jXUvK3/KGNk6m2T91dHbtplBAnAoq/cnO0g5YtSWGoVqnLy8q2P6b1uHxSZYR3C+EXXIzqSEG6Ap/L1nVs3AYvOefV4csBOla2MrQ8dvgIGdbZZpbG67EEu1y0xYwY0HXFCqBqejoQd6xTQQChzinyKdR/8EDKRatzGnXdFMjVwBgBQ6K3G34AnalFw4OURWYWH2bxqt5i++clMtUBkhTfc49TWt3t+pqRjqF67c3F5AJfmm9oJlpmEsCrbpJZe4bOZLoLA/f7LtJPNWQUk6qy/pq/2YjeQH9OvMdFHfZfrjsuWzhVgO2Z48G8Arh2I1qyQZfGagaYPmYAmR1YO6PU5XjvoTwbgtcGr17X1BZwlmQasqfk9bZ1dca4dLXgGVeMFuSBYcg81b9eyjhi+D5huIn4pGy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(26005)(6666004)(2906002)(40480700001)(4326008)(54906003)(82310400005)(8676002)(478600001)(7696005)(316002)(36756003)(86362001)(40460700003)(41300700001)(356005)(82740400003)(83380400001)(81166007)(186003)(1076003)(110136005)(336012)(426003)(47076005)(2616005)(70586007)(70206006)(8936002)(16526019)(44832011)(36860700001)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:51:23.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdce385-1cd1-42af-ab61-08da853879fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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
didn't handle HDMI properly.  This was fixed by commit b516ea586d71 ("PCI:
Enable NVIDIA HDA controllers"). So vendors shouldn't be using this
string to modify ASL anymore.

Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/osi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index c2f6b2f553d9..0d635eec87c4 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,14 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
-	 * audio device which is turned off for power-saving in Windows OS.
-	 * This power management feature observed on some Lenovo Thinkpad
-	 * systems which will not be able to output audio via HDMI without
-	 * a BIOS workaround.
-	 */
-	{"Linux-Lenovo-NV-HDMI-Audio", true},
 	/*
 	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
 	 * output video directly to external monitors on HP Inc. mobile
-- 
2.34.1

