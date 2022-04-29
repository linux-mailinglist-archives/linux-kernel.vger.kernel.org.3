Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808485140C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiD2DIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiD2DI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:08:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C184EDC;
        Thu, 28 Apr 2022 20:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIQjjjQzRRi7A4jkq+AEzTUzQ8XT34tgxNSXMgVDdg9iQZru17ylMaKqnUVcIdk939EAEjvFRbVqbunuZat9v9EJubxWcnU8bew1P96pTxALvE0YolJAoTn+D/UhQf6WNNinVTqfIYIuHQDOEazAlOLOqc01nyhpFUNfCV4YBRcgsUMTyNmiCdG13D6n2tuAyu80bhKe2wGF/gSVkyITDzWO+TVYEK85D/wOkFkEb26JKyeXM0DuIAy4Gkdrqe2rOgc6js8cISY3Rx7xfvSrX3mqV6NXS45ss7lhl74eP24eeJPP8v1COmZMCrLBm8jaoF6MKjWJR2bDhEjSI+J+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo3tyQtXZYtv/PpFSbe6NXsCaCp+bcvMgUSr12sG1sw=;
 b=Jaa0FqQBoyRQgtmzIomFS3uGrwnWTmmswRRQkV908yOjUg3iavy1U+zg8CQ0/0ZoXVqMBoQnrHCX5xUQ13wblE/9EllypsCCeWImtvdyImOshAxUo13RkfCtUJ3XW/1h91K0NornRzO9afOLqJeWx3Tyvvluz6+3BWd1POuX1okXzed229SaBGGF/xsQ8o1uS+t2VzDEHTbjU6yLJYaUhjXQZyziX1iYy/X9RFczH7o9q8rsYgic7cKJioyGRHZWg2xkZRWAybBR69c5ExRyyLem0C4Jb1lVN+rRjYHcFLFd1mMpE0jiF6VrotPyUMp/MymfHVMneqgkHcoug2p74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo3tyQtXZYtv/PpFSbe6NXsCaCp+bcvMgUSr12sG1sw=;
 b=dgfhytXUN2lXHx9vxFnZcHJiQoMMbKks2+TrZ0RiB8tVZCZqkxZGqZvanpEhcheuUmjuQudzftg49Eby/l0mjCHJ7gao3yUt8PYZNpG2yntc9QwAuYmjG+biumU3btUIakI1WcyykTaVXkTFNRIvM/ACGeMAc4EWbW1ltAV7EYw=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 03:05:11 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::27) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 03:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 03:05:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 22:05:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Add a workaround for s2idle resume on Lenovo laptops
Date:   Thu, 28 Apr 2022 22:04:59 -0500
Message-ID: <20220429030501.1909-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d4dcc9-53e6-44f6-a229-08da298d12f8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5962:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5962473C20A5365247E1AF9BE2FC9@DM4PR12MB5962.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1jWWuZwf+5JX3y0HTil13lRAh782N+jFP9V10GjJGS1ZOMswZrpzs4UhfwsWaOHtyATXR9geMojr8NzjYVSGaoEXMoOK0glkRG3gjqOp40dU1M4GrSqvRtTzovhjXlL/pzd9+srDnJC9NCRcL51exxSsPTDl/G49USb2d0Ownwxc6xOKAFUqrpTT5xlsHjWW8wgBMP5EscTn6V20W68bEBtTM73fnsAX4X4rIrmapAUafBXOnoO8o5bCkbtXPLT8RQeHzdIamt5CrJ3P3gsmNsZRncuBCVbZ/L+gANi8zts2/cR2H/uyimsZpCX9aSRmkeCRDal2jrc2itJhZEZaDWJFM/NJh5oU7ab5J2NkhZms6MHgiSeiW+HO7RQrxQ5Y8APxxgGmvI+p/eylFYlHoCbIjvAhweZyj4Z317es2KhRpAmwtBA2Kj+X4YUDKND7GYCNfHvtmleHtVRVmpbFWFLelBSVa++w85yq0M01RXfSj+uEQGMQBFOGm9PiNtFtDmB8Cp3q/hF+I1v1FVyEg5DJso2RgCFUdBW036LuCuCnVQdg9ov1weDKHQ+L54qn6kUdKbZAoGc2EXJ7RO+CclCPqBZuRu2is5O1jjpT9I1xj47hmakO2n1pLQfRI2sPe9mQxdWEMn4KUy1AD690xcszTrnPJBRSYAoYI312vPSDU6hT4swvgxiyIXvlI/8+KCF2mNIm1EM1+QttFc8IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(356005)(83380400001)(4326008)(82310400005)(8676002)(70586007)(5660300002)(44832011)(40460700003)(186003)(4744005)(6666004)(316002)(336012)(16526019)(86362001)(8936002)(7696005)(36756003)(70206006)(47076005)(426003)(36860700001)(110136005)(54906003)(508600001)(2906002)(2616005)(26005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 03:05:11.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d4dcc9-53e6-44f6-a229-08da298d12f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Thinkpads have a SMI handler during the D0 transition for NVME
devices specifically during resume from s2idle.  When the IOMMU
translation layer is enabled for NVME devices (which is the default
behavior per the IVRS table), then this SMI handler causes a very long
resume time (10+ seconds).

For the common s2idle circumstance on Linux this SMI handler is
unnecessary and just significantly inflates resume time. To avoid it,
add a new s2idle resume handler to thinkpad_acpi that will prevent it
from running on known problematic systems.  If the SMI handler is fixed on
these systems the DMI data can be modified to exclude them or only match
problematic BIOS versions.

Mario Limonciello (2):
  platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
  platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of
    laptops

 drivers/platform/x86/thinkpad_acpi.c | 134 ++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 3 deletions(-)

-- 
2.34.1

