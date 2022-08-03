Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18349588C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiHCM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiHCM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:27:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E9FD0D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA32NHuw5ObMY5N3xTqggkm0qXQ2fv0XpIQPz5BXl4g4BHiY0FgRiD2Smt5sPsxim0uV2+HOa1ZjnEZZvJnrPUc8c+GsWB71HwmE1mChXI80HAfcEH5KYdQNwcxcm4v0rej9Ghu+2B+2NNHn1Etto9WNql6kVHFaiOBj4ZuL4LPVpqagyGl0SB0i3WkRxy1xq5s85z45NHp0wU0zyYnAE8ho/2HU3cgp12E96/EE07SjfYIupC/jY162ocE0oc+yDc76NVV+1lWCu1aVFJFRwdW733x9YgJD07ij2VyPH0/jyJJn5u9R8kMS1VDDejWLmfec+72gH+Zxk9nwGRm1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htug0rtpnWLWOJQv57jjjDzjxtGFT6cXkrbGbe0KKjY=;
 b=egM8ykR+N9RtV6cWE/6/dBqCp6ayJtk90XOJqaxqfAnynOFdA56YEfe8lE5qj2OJ+XbbeJKRsumZPXrE5aY9VSyePQvC/G5HREOt0wiPU3fkQCUApmeaPOHbu6RzHJZaaEYJtcYR37d8p4HdiwGWh1yZlRjXvvM/0elA2+I4H5kr/t/kFLDVXpCgB5KBqJuv9Q5UibEsm0sTQApvuKj01H8MrXA2aNXXPRxMCFLMs+DGe4K98SCMs3DWIWLFL/sG1l7lhuHGasD7IBS66NihSuE9UI5Q6t4QuddhfxvL1cgncVGOz9jnptskRpzaLI5qf5zAAdepj6vRpqopzykX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htug0rtpnWLWOJQv57jjjDzjxtGFT6cXkrbGbe0KKjY=;
 b=grVXz5Vxna2hprWErJGAk5tWKpbJNkziAUlYabXJ70cC3j6AztDajn2uW0Q3t1pNFir1VATkfw3he+iRHRjd4hjmSGi/E9a+Q7TIS6y6r02+wmdY49CCZhDFxE0r80tqqqkvARNgyu/TNDQsQiqMxptdnryqMSJ56+iXA3JTAbE=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Wed, 3 Aug
 2022 12:27:05 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9b) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Wed, 3 Aug 2022 12:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 12:27:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:03 -0500
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 3 Aug 2022 07:27:00 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <maz@kernel.org>, <tglx@linutronix.de>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <michal.simek@amd.com>, <nikhil.agarwal@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [RFC PATCH 0/2] add support for CDX bus MSI domain
Date:   Wed, 3 Aug 2022 17:56:53 +0530
Message-ID: <20220803122655.100254-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9e7582-e024-4bbd-9f01-08da754b79db
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YGsvaxdjubkV/YAH91vSGcR1r99cStPkdF1SdutLqFBJ6c2HK8LTaHkKsUwr/Y2v++VlGEYfyxNxTIOgtlqRc9t9PUigOpkxtkzStHfHrjoQtI5PF8yRa64Z/tSr9WvTZWWlGX/IIBrvPYUjLPGhXET/y/axSM3kztosCLLlcu93VViRdpDPMWvaFrAw8usBZdUNXEgFXKN+Q/j3Ms2upeXRSN6lcw8pBPuLu2LybcjySGIaAGUn8+DFEkMkV+4FG4HkRuCJ3nHLEDjRNg1p3NOTkLb/E+za2DoVqiuWVEPNfneNWZNfbRce2krHEgtklBNMJFsC911zjB8OP/ZWdrc7MJsc396dIaepRxkoWhP+KDLY9Uz9X2ekcQRWVQKZ0loVZbhNlw0OTWyNkfODANcJqVh0zORWov/nmSvkJKqYhzFMGsrs8dURoXM72ki8rbONlR4v7BhXQDqM/CBzK3X5fBxP3dwiDDZJTdJJjAxgTx415XZAAqHHvfFj7bEjpiER1BeEGR/tD5Zs2f7GOw3VqjZDjbSs37clQtseuXfvkGGKtSJPT2HkWAu9IzeulXNl7iQJDMczm8Pfq8Gi0W9uKUb2EK9XFes9qjilQqaMgxjbC9v8o+S2hWZ39MaKuFPhQ1J9FbZ/NPnginEVHz/Ynffvw3uLRGSgMoIiL4ej6UDgSDQ247FCmOk7nJRJe6RUSNHjmvj4D8CS7lmrJbiJCJ48EWLVitF9Ij8kMp8U6A9tK2GcbvRgLh9X5K1dY5lDb+X2OIMJ47+3EHYPIisOTzvzDEey0Iok6P8O82cWUvnswcoTMWg4ZiSGHiBD5VUBhzhM0Pbryh6dggLMdYvosA0fW38nxQaSccqqXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(36860700001)(81166007)(41300700001)(26005)(82740400003)(82310400005)(356005)(186003)(36756003)(40460700003)(44832011)(47076005)(426003)(336012)(478600001)(1076003)(54906003)(40480700001)(316002)(8936002)(4326008)(8676002)(70586007)(86362001)(70206006)(2616005)(5660300002)(2906002)(6666004)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:27:05.2061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9e7582-e024-4bbd-9f01-08da754b79db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices in FPGA can be added/modified dynamically on run-time.
These devices are exposed on system bus to embedded CPUs.

CDX is an upcoming bus, that caters to the requirement for 
dynamically discovered FPGA devices. These devices are added
as platform devices where fwnode is created using 'software
nodes' in Linux framework.

This RFC targets to solves 2 issues when adding devices
dynamically using platform_device_register API.

1. It creates a MSI domain for CDX bus devices, which can 
   discover device ID used by GIC ITS without depending
   on of_node.
2. Since these devices are not present in device tree, it
   creates a sysfs entry to expose the compatible string.

Nipun Gupta (2):
  irqchip: cdx-bus: add cdx-MSI domain with gic-its domain as parent
  driver core: add compatible string in sysfs for platform devices

 drivers/base/platform.c                  |  15 +++
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-gic-v3-its-cdx-msi.c | 114 +++++++++++++++++++++++
 include/linux/cdx/cdx.h                  |  15 +++
 4 files changed, 145 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-cdx-msi.c
 create mode 100644 include/linux/cdx/cdx.h

-- 
2.25.1

