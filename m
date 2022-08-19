Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B9599D75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349276AbiHSOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349383AbiHSOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:25:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10612741;
        Fri, 19 Aug 2022 07:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAIwJXNm8FbJBXZlJFthJKxvH9Dy4QDb8Dksq3LbyewCvRb+9/uyEeVkzPe79wiebNpwcCn+r8Jegek/uF3R0Mc7Febtjm+F0GXlfGrVKvDi6mHudj4z1w8VqhzOFqs4KXo/iJwKd6Sj5+umFUDeYWDqxcOk/6BVDfDQG/Nv3LCd3fyB4XMB1f1mJ1vQyjF704Fn7XhPIkrxWnm590Mgefxm2yhRVStEHhkllivfT+gV8cM1AbuHYCLN98T7h352r2kU9HVy3+ERgR9H7r/EABhIrmlXRz5zQR7Z8EXt76JC+7t6eF/CGMLG2P2pJnKMteBTZOXMciPHzf7gCFIQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL9xp/u1j+1Oa1cvAjmNrTWD33AIe6wH7O8RzyczIdg=;
 b=KWE/DALgeJOVKdTOdr2kxrkJ36IaCcJc5VMWEQwmUss1iumZbvsCqd+4HhAlfvtyp2ulT9UXp5UCAsABsSjYiJJc9VzQOBWXB8kuC/yFbudLXg0yzqB523PzAkU+iwgXrhBSFN4EqlR45XoEFQDHFHcbJYuQrpoMZ1QH5fBjhw6O/0lembe4EIPCgeahbGh07EAO6Zd7/rX2QvcC5I3npmDzdWV7lCUtnU5yk0FJkl+nbVT3L89KGdI9npxB93aHfjVknrq32/g5TVHej7ZFazFhsmPe3ik9xSEbzPn462fmRCsrdvvi+ruGmuuLjflbCm8eD/LHxAIhyHA6lh/o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL9xp/u1j+1Oa1cvAjmNrTWD33AIe6wH7O8RzyczIdg=;
 b=ylaNbLznK1iIIbu86FmRVPrxAXws6c8dJBio6rxvn3uvZX+7SeBluXSJXwizYcedivGA01XiW3MLn4WTf/iGNVfY5BCX6cdzGx1TjF8sPvKDkaEdmIHbJzR+afZt7JZ4G6gzB9SqgjVy62XVAssQD3tw5+NactiGO9oTeOssvP4=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 14:25:24 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::3f) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Fri, 19 Aug 2022 14:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 19 Aug 2022 14:25:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 19 Aug
 2022 09:25:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <kherbst@redhat.com>, <nouveau@lists.freedesktop.org>,
        <hdegoede@redhat.com>, <ddadap@nvidia.com>,
        <kai.heng.feng@canonical.com>, <Dell.Client.Kernel@dell.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 1/2] ACPI: OSI: Remove Linux-Dell-Video _OSI string
Date:   Fri, 19 Aug 2022 09:25:18 -0500
Message-ID: <20220819142519.5684-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819142519.5684-1-mario.limonciello@amd.com>
References: <20220819142519.5684-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d5e61f-8b7a-439d-ff28-08da81eea802
X-MS-TrafficTypeDiagnostic: BY5PR12MB4855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvxX2Mt945Sb+79Paa4Y39tOpnT1lH5ECpi22B2IVipv2AnX/XkotHuJeaZBCRz9F4kVOmIbN9XOXB5Z9biMROyFjlqbTZoJxvVwEin7+IthrkCa3uPjbZWpZl2kMdrUISFb+tYxetvmq8PSSO4uk/Q8JlT7TLZNhzlQ6TShXQgDmO0RnqLnhg1AL0CFd9Dzfuk6/DcsU9bXYl8j6XB6WWKsYzCh56dOqXdFLnnODPYu130Vr2U66dfI3HowPTK3lZKTzzP3CUP7khCs0xHUXBXIAvtP7T599hjNbd7kNPEK194HZ5cMhkr5kplzcsHCQsA0oS2a/E5BZ/k6eCrgYG7NcvF4EIhOBuL4d3OCDhVGaUIk1srR2HaV/WNi3N+zqjGq0Pr3bWJVFIwKRpsKHs4XcXBk/DYLcfWBSPdyyY35ZWAt83RQIHtidgVttx+0I6MTq62K+fysilcuMdoHJhJ78+Fx2EyyEPvVjQvL4PaRUn57/opIc545uRBoqf17PoadLeMMBU7r2K4qLGcpkm6iP4+aAaXrEbs9yHRM/BSmW37yAwWlalUZMuB00FqtYiIfsUR3yF5upV1ccAM8B3I6nNY7ClvU0x4ROFK2N3C5SEufLESPY1oQYi6e4peZf+u5vLBrflDLGJ6E10WnvNZKBPY+WtsagqUgAMrRnTADU5u7nn/ohJgMJS5mB47rRdQZH/847vPvc48SdnFiKkeLlrZED/MV3LyTrbmvWww4kGy47d05pCH46mdG2V5P0SfT8PD5MdmMv6rFjqNbcbLSv2jOIG9Acv/4kRQX9AnBRYkN6ibHhjqiFWizWzQ4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(40470700004)(7416002)(36756003)(5660300002)(8936002)(82740400003)(82310400005)(41300700001)(6666004)(44832011)(4326008)(70586007)(110136005)(316002)(8676002)(70206006)(478600001)(54906003)(26005)(1076003)(47076005)(426003)(186003)(336012)(16526019)(2906002)(83380400001)(2616005)(7696005)(40480700001)(81166007)(356005)(40460700003)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 14:25:24.6533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d5e61f-8b7a-439d-ff28-08da81eea802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855
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
didn't support RTD3 in the past.  This is no longer the case, and
so vendors shouldn't be using this string to modify ASL anymore.

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

