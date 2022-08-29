Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7035C5A4E15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiH2N3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiH2N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:29:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E69E0BA;
        Mon, 29 Aug 2022 06:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBE+6qg+b5ORhl3FNpIhDQpNLCNvFG9j3xpZ8OTWC3dGokOVi667r7mHTexNPpMEeTbSqSIXYFljIyKuoUo0anPBZEekh1qLPc+9RYUQnpsWqKZF9cBOrAMrR1b1WKXU/H5AxNYGutPxLJQ71oP6oQNJuzopPrc7ftEL9bvS31zSuHIe04tdjJrOuRs2NyNBQ5sa+3jEInVSMHdvMQPnWb+6BtlzmFf6EB2EYtLXDSUJByEW4l4m8KUlIQ0XbCcdHOSzDzCX/Mhvlf7AurQta5BKM5ooaRGDz0jXaCtbaEho7NVH4S8gLuiQCX0XteXT4tWic0DpQha9pAsKEDanjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqEycSAnlKZox9yQ+YPSwKPbApaJVA79NUbKp9znjXw=;
 b=F6a4uRwzfIdWEs4GeAEOE8+SFWxmN3ItwPHwQdDVBihs8Vry/BK/D1Ma0nVR94OOavECm7gAMYLVBzxHlkRXR2LD8FcPKQxQQ2YZXpZ6qGZHh03hrq7gZ5yE4t0MS4ovvFX2JZ2dF3gq2wypEWF6d1PTf2D/OAhUS8Ud3s/JcpPrZGV430+8AW7nMSGYHRBq92GF1az4GkUOym+A9pyh9X4RDCXbIfeFMogUJKHMrgfWTKZTawnL9CZsFGKct3uhmpt0xNiJQVz1gjqBgQjlBlM8L0/mmPf4oeEn7ugna15xiKbqJI1NkGs6Cx1N6m83y6YN0bY22TRSzHsvNzHeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqEycSAnlKZox9yQ+YPSwKPbApaJVA79NUbKp9znjXw=;
 b=hVw4Y5x08mDxJt3Yvcya7bLmfNrIAxHtW+8dYzSHQh5kbxRFVYRjz+hc7cSHtqks/fW3KiJqz0g2fuV0KYDHOC0rf7VuYyk4rZPc9BaDVYaxnnnbQr90OB7H3K9IIMw8XyGFoBLhB6UP183ojq2t9cGpU6NgFkVqAmCBTzVAR+c=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 13:29:11 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::56) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 13:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 13:29:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 08:29:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Add some extra debugging mechanisms for s0i3
Date:   Mon, 29 Aug 2022 08:29:03 -0500
Message-ID: <20220829132908.5254-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac9eb08-f528-426f-db91-08da89c27580
X-MS-TrafficTypeDiagnostic: CY8PR12MB7291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QhTIJKChx7qx39ZfLgK+kQOzFns3VB3oxNgM3IITeFaVFzE3UlVel+IDpRDbGBqMgpImD1czM0d4CFj8sYV4SMJFxQ6xQ2iI7bHFJpOWTYHdI5gZiON98j2DbhgKJG8r3eFT7k3CNBOUuf3Wu6zdn451hA0AEIlmLvB7PpMm5tcLdTpzOGbMy2pUlYMygFA8JSNPVhoXSM3udk7NbPNG/vOofuK2sQdDUuI+iEPEFXxiwIFSxFqXzP8eo9AtcQMaDkX7y/77yoR3TwVP4B2MH4gO/jSvhSMsgbJCmp9woP794vDaS/5780MVMWGptEIvyHP4U6Y8PEQcGAp+K/P00byJYf2k95IWfN5H/0seLoqAoZcYpv7PDyCtAUZSjP5smjqU4VJub636fRmPGuO/wh638H4kAX7epX7+goyCdWhdheGv/TOZAFyx5F/h4nWLZpKSsC/5XM6g9mJ26TjepLByJz5jtHaJlajNbrCSGMEKuvXmLUVN1Ua9VBDkJ1TpuRDH1dq/M9bMzvJ0F9SAP4EH6e5HpwkOpnoHozDJz7Y+IOA81SLvuSPAdysl6DYBYp8CUPC5OdjTpi38OoqAhbJXugVcS8QqnMnOzlu4k70eaPv2/tmZOlr7I4Y/st/gAlxKLEDLh97S2JXEdMPpSY4VVnQLPEPaGwpNUZA3Z4rY/Rb1yYgekmIbEy9cvBQKVMB7e7V5yuDTm5yzxgBFDDF+SOPJIddZgeoG0p8q1qnprg/79pLYKhFKiAnyeLNZAyTi4uDzUmKXy6aalh4Fs4DGx/1xOot+VkIru3fKSeKMsBzQssm+wGBzmhe6LOFsplnY21mxdsx6Szp+lxgLZLTNGv80e3mQS8Ic9pzmQw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(2906002)(26005)(44832011)(82740400003)(6666004)(2616005)(82310400005)(7696005)(40460700003)(40480700001)(47076005)(83380400001)(336012)(186003)(1076003)(16526019)(426003)(36860700001)(316002)(8676002)(54906003)(110136005)(4326008)(70206006)(70586007)(41300700001)(81166007)(356005)(86362001)(5660300002)(8936002)(36756003)(478600001)(138113003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:29:11.2511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac9eb08-f528-426f-db91-08da89c27580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there have been reports of problems where the system consumes
too much power after certain interrupts occur that would notify the
kernel of some event but those events aren't marked for wakeup.

These problems have been root caused to the timing of the kernel moving
the cores into ACPI C3 relative to other events from the previous wakeup
not being settled.  Linux will more aggressively move the cores into C3
for s2idle than Windows does for Modern Standby.

To aide with debugging this class of problems in the future add a new
set of optional debugging infrastructure.

Mario Limonciello (4):
  ACPI: s2idle: Add a new ->enter() callback for platform_s2idle_ops
  platform/x86/amd: pmc: Add defines for STB events
  platform/x86/amd: pmc: Always write to the STB
  platform/x86/amd: pmc: Add an extra STB message for entering s2idle

 drivers/acpi/sleep.h           |  1 +
 drivers/acpi/x86/s2idle.c      | 14 ++++++++++++++
 drivers/platform/x86/amd/pmc.c | 32 ++++++++++++++++++++------------
 include/linux/acpi.h           |  1 +
 include/linux/suspend.h        |  1 +
 kernel/power/suspend.c         |  3 +++
 6 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.34.1

