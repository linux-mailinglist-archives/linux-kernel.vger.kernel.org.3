Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F450DA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiDYHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiDYHyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:54:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133D25C5F;
        Mon, 25 Apr 2022 00:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C45K3Qaju3SnJwhvdiy05t5u35QoK5QYI2m5jTIOXoVvVUYoaD/YV4ds6y8AU4YpQDnTtqc/cSuP+5z+AErUAxdi0PO18OUg5Np/J4nosqimvJN6QUsag2MGzEF67FI+aILM1xwdpgRyBYIeDtkvSYyWkGW3HdmClhzHD38GubdkxkSms01deNnO5GgdCWDu/TR6Dd5grUpM6uaOQR4xZiJwSzAp9KMDofvcEXKviODwTbNGvF8GzrRPJcc+NE1C/gG6QqKRmOP7siQeD4oXf7T5sLppCCy7tATjDgKudkQwsm+EOW4eEu3f9Qk9Fuak0eqcMuGNj3+bzLJvC13lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2Oc58YS2bntBt7DCXUQ7MuAdw+B3FRabD0LESnq4hU=;
 b=oa9tDILm1I2HVXWNIao5dtdYz6NfxSLyaV6SrDcmR++X9kaaG9qJgSww4tJnkV/6vihnvXNfHoWnKMT5E2pmvUsRV8J0+fA5+B67300yIMkX+6n9F3tXAtd8/6p3/naZLmVC9C5jDtagGuzUHTTBdD5rGl5g1tw3iGUvb7rMotzmnWU2r7wlNJik8FmU6TBirCpzMNGaxcKtsR2V9a04PDdxSnKxviOmZOhYmcCDOYT3Jz1IelxQjm3l+U4YMnu/XJFKxW4ipnevQ6MDA4cQG1S8dnhdEocmMR1+DB9QKI5Ok+5884+mXa2qWXfC5jffrOPrs5b4235jTqHjWX+i4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2Oc58YS2bntBt7DCXUQ7MuAdw+B3FRabD0LESnq4hU=;
 b=Fec9u8mzYQ1VsfsirVWIj8Ge8cjZzgPmb6+KneXNqQCDc0R4QP/qVAwv6l4hL8q4peUmCblSVmLy5lWkIRVYCzuGU/8+V69zxXPikFegQLjPZCCZ46FjCoaXMg/c9G4mrbSrHmoVvnDJ1zXGbTptKXOGjI4O5S9QdObE4S4Ey2VaRAyH6Jq1lykMvONj8wNW/oQjZlccXODG2S/HsCHwylregOtpz9gZDHjwoTci31/t6TS9C/70K4Ocw040mYULtdG9RqPMN/0diMXq85auKHnaz1sRGB4yYMijaBW8A73m0kACuxPoh63A5dZaBczakHiLT52AEtj6IVOFUL9tAw==
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by DM5PR1201MB0171.namprd12.prod.outlook.com (2603:10b6:4:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 07:50:53 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d8) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 07:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 07:50:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 25 Apr
 2022 07:50:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 00:50:52 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 25 Apr 2022 00:50:48 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v8 0/4] memory: tegra: Add MC channels and error logging
Date:   Mon, 25 Apr 2022 13:20:32 +0530
Message-ID: <20220425075036.30098-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974327e0-9f5c-42e3-0219-08da269052ed
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0171:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB017115EF0588E7AECFA9B12CCAF89@DM5PR1201MB0171.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +D3IM/B3PIq9gW4llDfAFabu0KQ/xPaBo9fbKqKhdiw7nO8ArGiv0mTMUJmdQm0Zie282BfWf9VPWSe9gCtRwYBKB/hqJYUIHRfaHvAHj6iwC9ArV4xSn4RkUUrO+fp35FC65tQxS2G9KUeAIrFIRVdSYOjprJ/g54Pj0bqW2Ai2dEnxHd1BEdpNtuRyZDJLC4E4bMaPo+GosaPieHEDXkMp+g+Gn8e1k9VdnOENQk98pHlp1GYKES5oXEFvF1EsXTx08iLR+9L9/G0dCFBQxXn7Rdm3t2IKsgB2QP6paBQspfd3S0LI+qz4YjVNdL7YbYEDbNvQEd8hAoUY4z2xM/A2FUfxPGwD/uNjqJBm6FJNDHXFK3F3pO1+YiUa32Em9ZjaE+ScWyO5a+a06zdccPy3Us9LN7QFHbuYhYUFiWZpqHoNbK7Mfun+G+/9Si9F4Dlt75gcUhyYBA2YwNEoP/vr9Xub91QqMTanEB6kg9zRF06DjDmvA97QtUUZN5wk2UIHB6rg2NFHhhj/aJwpSjllXazrJcEr86P9FbzaL2p5jYKFUoGK29LISnINDQhxo2pTLuZ5H6VtOgciyviWzP7SuIzAov2zBATDAkjmY3rMK0ZEyuALVuiEbncVXvo7HiF06nV2Rsae2b2T5S6d3EBaRav7H9Esqk6AMrAnlQokUkvm+Bb+ThG3kC/EoRARE7lXECGTTiUSrsB3sZxKXqV0FCbfuLPLGbhIj0LB7Z8=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(336012)(4326008)(70586007)(70206006)(8676002)(186003)(82310400005)(36756003)(6666004)(26005)(316002)(7696005)(81166007)(921005)(356005)(2616005)(1076003)(47076005)(54906003)(86362001)(110136005)(5660300002)(107886003)(2906002)(36860700001)(83380400001)(40460700003)(508600001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 07:50:53.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974327e0-9f5c-42e3-0219-08da269052ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0171
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onward, memory controllers support multiple channels.
Add memory controller channels in device tree and add support to map
address spaces of these channels in tegra MC driver.
When memory controller interrupt occurs, registers from these channels
are required to be read in order to get error information.
Add error logging support from tegra186 onward for memory controller
interrupts.

Ashish Mhetre (4):
  memory: tegra: Add memory controller channels support
  memory: tegra: Add MC error logging on tegra186 onward
  dt-bindings: memory: tegra: Update validation for reg and reg-names
  arm64: tegra: Add memory controller channels

---
Changes in v8:
- Updated the bindings patch commit message to reflect the ABI change
  and added "tegra" in subject
- Updated function name with "mc_" prefix
- Used snprintf instead of sprintf
- Set mc->bcast_ch_regs to NULL in case of old bindings and checking for
  NULL before accessing it

Changes in v7:
- Updated reg-names as per comments on v6
- Removed use of of_property_count_elems_of_size() and used broadcast
  reg for checking whether old or new DTS is getting used
- Updated variable names as per comments on v6
- Added helper function for getting global_intstatus bit from channel
- Used to_platform_device() instead of passing pdev pointer to
  map_regs()
- Allocated ch_regs at runtime
- Updated DT binding documentation to add validation for reg-names

Changes in v6:
- Added reg-names for each reg item of memory controller node
- Added logging for interrupts on multiple memory controller channels
- Added clearing interrupt support for global intstatus
- Updated DT binding documentation to work with existing DTS as well
- Updated function to get MC channels
- Updated variable names

Changes in v5:
- Updated patch sequence such that driver patches are before DT patches
- Fixed DT ABI break from v4
- Fixed smatch bug
- Updated description in DT binding documentation
- Updated variable names

Changes in v4:
- Added memory controller channels support
- Added newlines after every break statement of all switch cases
- Fixed compile error with W=1 build
- Fixed the interrupt mask bit logic

Changes in v3:
- Removed unnecessary ifdefs
- Grouped newly added MC registers with existing MC registers
- Removed unnecessary initialization of variables
- Updated code to use newly added field 'has_addr_hi_reg' instead of ifdefs

Changes in v2:
- Updated patch subject and commit message
- Removed separate irq handlers
- Updated tegra30_mc_handle_irq to be used for tegra186 onwards as well

 .../nvidia,tegra186-mc.yaml                   |  80 +++++++++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   8 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  24 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  24 ++-
 drivers/memory/tegra/mc.c                     | 140 ++++++++++++++++--
 drivers/memory/tegra/mc.h                     |  43 +++++-
 drivers/memory/tegra/tegra186.c               |  43 ++++++
 drivers/memory/tegra/tegra194.c               |   9 ++
 drivers/memory/tegra/tegra234.c               |   8 +
 include/soc/tegra/mc.h                        |   7 +
 10 files changed, 356 insertions(+), 30 deletions(-)

-- 
2.17.1

