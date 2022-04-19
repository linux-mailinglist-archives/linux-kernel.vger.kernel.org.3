Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DC507B63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357845AbiDSU6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiDSU6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:58:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335341320;
        Tue, 19 Apr 2022 13:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SezqDAs1FgGkGiM6BOBPDLw/qaMj/AdQJq18Q1Gl73lRg01RhJ/t+Nm/6sr5JxmkCE2nve8nseJrEXqRI2zNRw/9z50N+gV6jO5FKcZCAKG46sWK6BcqoEKZgm6Rb7PYbcDfALMxIVZchyrlgJOEtH3yOa9joZ+f5BEoN4dnM7njGpQdlkxhn5yxYMKAv2dDCB8HUJI0ukVMvIsO9Zeun54iDHgBkPUeB4EXtyQOGSYLBzHotabOApqBm2rdlJ1+GStTWcwsye4Ux4vObbkvtK0KT3HejBwBfjAgPdvKRMykUvLhjnVcgtRdDSVCoKC1Zha5xCEf3MK31f4mCt8kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tC31V6YYHw2Gi+T1KBXPBcvPGweJX8pP1qbk3t6X0w=;
 b=ey2i3VFyvucxxcyVJ4RpWmcU1HVtyztIpSjkpINGAJ5pMPp8xjQFNxpqpTHOxdhMzITFIsHcuNxFHiPgjBU5jDm3utQxA+0Bx6d7pCYcmFNjT8uk2LPkZ3/cUrZMu2CygwTAZv327UyCPTkWEv7RJauy61Se9DmIlm9SFD2qY5WQA4XtwAK+zPBINcvzKbywxTkXpEUoC9+xmiwoUC99zU46iwTWQYiXV+WlrATUzFD3otSmgpP4RizUBcLLz4Hn9YSmxRCHDcLXXuXJbCsMKVo8DhPvRoPlMGp1vOWNqvgId9rHPdzpM9ixygXpb31pJ4FAyznfqlxgajs8DBrfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tC31V6YYHw2Gi+T1KBXPBcvPGweJX8pP1qbk3t6X0w=;
 b=HBPAPY0ftnucoVBPzCWXzsLRgimIuS3NmK4G3dmv6McsdboxP4YSxnZGYkYnWyycfGG3v0sKA0ooY6JvL1MHSd1uZk4ccvUvPVGxpwlJhDLBNe0h+ROWxznlzRb30cbq5Bb8KZIGH2tebLU/EYzbXYU9O7r6HT206J0PnCkgDQksjk8/3sc2vF564AXgC8QFs5Q5/fCblTwrKKg7r5Frh9YyPHK4IIIz6hd72DxM/h63kXQ6Pyiy1+sYvlZLllYhE2Nq65piXsOIDm97KzVTlAcdrDCmdkQSB7KxXAYR6UY0XBhzXmx6pWnpmqkoX5zvFwNtObouyHgs7MIgo3R9aA==
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 20:56:05 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::9b) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 19 Apr 2022 20:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 20:56:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 19 Apr
 2022 20:55:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 13:55:25 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 19 Apr 2022 13:55:24 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 0/2] ACPI: ARM CoreSight Performance Monitoring Unit
Date:   Tue, 19 Apr 2022 15:54:30 -0500
Message-ID: <20220419205432.46021-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a864497b-bced-42ba-1351-08da2247055f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB496560B2A360584A0A3FC684A0F29@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vfr37aQrjEBmb7lPdoV87i/HXQsUEicVtnMm6/knUIQ54qyS2AQWeB4RyhEnns2w7xaJBipd++XHb2uiLVkl7uh+LJXXfE34LtEpCZqHgYWf8pRJ0anixsJSfEcau9kbV2/1Lv+hV1hE8CxGeh0aWwKg4weJ780aq8XJpDnBMAXHKOKFPSeGK+O5N+/+4tc6sacSkqd6lZmfHGpLatiKX9K7EHUleZnhqJ29zu3++nETjl0vQYtLidbOtpubRHib9IQjc2pUnqffyQ/Uur68ip0+uTpecsTqwQOZuFubQXU219zaMThTAcZQdz3Leg9du4ByjsRhaQpgIDQEf14Hye0OJ+3J67S2u21YVn42KwoQwyHIq0sJm1cuAVQ51o02ia3uwcVxZp2jKyDvQGDWHRdDy6CiW7sbaaU9LKDXldJKsfjbm0fBvADjM0V1ETLwhWPeRfHJTXytBquE3vHhKC5QGqfUghNQMuAvuNYrYJZmSrXsG0aEEpU8VXZ7wI9N/WNdTNKA7V3c7YY/UTfaTMIN8B7q+4DfL+hwGtbldC09UhDLU4qaKbNkmMXlOyuUUzDr2uVDUDhI+amsGcRa3gPx8rjsYxun2cWreZrV/Aq6gzOsj7eYKnmTZ573Whl56DCR1habGpJ0RSdZldZFy39VoJs8dgHNBdWYiLoR7WNihKG4j9HXlbsQIrdgGvHevUFuLBsd/wpDPQXBT52cB3RMj3fGgicoRLqp4GSilLi11fryNUYrWJbL05lW9WwB40bKnuIbBBNw7Ldfv9IqemYlWtwQRBL1ZPwbN+vMBaVjBAArsf5IqJoPdfrCUpAIhzHuxL5dJap8Gfd3ueVQbQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(6666004)(36860700001)(70586007)(508600001)(1076003)(47076005)(36756003)(82310400005)(40460700003)(110136005)(54906003)(86362001)(7696005)(336012)(356005)(107886003)(426003)(4326008)(4744005)(70206006)(2616005)(5660300002)(2906002)(316002)(966005)(81166007)(8936002)(186003)(7416002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:56:05.2610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a864497b-bced-42ba-1351-08da2247055f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ARM CoreSight PMU device.
Specifications for ARM Performance Monitoring Unit table (APMT) and
ARM CoreSight PMU:
 * APMT: https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Besar Wicaksono (2):
  ACPICA: Add support for ARM Performance Monitoring Unit Table.
  ACPI: ARM Performance Monitoring Unit Table (APMT) initial support

 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/acpi/actbl2.h       |  81 +++++++++++++++++
 include/linux/acpi_apmt.h   |  19 ++++
 7 files changed, 283 insertions(+)
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 include/linux/acpi_apmt.h

-- 
2.17.1

