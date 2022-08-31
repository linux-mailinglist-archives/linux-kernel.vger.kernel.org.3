Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF15A78B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiHaIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiHaIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:16:52 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B5C651A;
        Wed, 31 Aug 2022 01:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnQJiX7sIOvksQ0E8ZJlW5IgsQ0GejSMkhOGIFbvukCatS5lyDXPJFwQuvfI/iWnQUVBu05XcaShk5HpOut6vsmr9F93kW3NMJ4P5YEaVLpFv/3pj7l6Lq9RBZA7inrShMVWiFrwPP0ogspqQ/I9pT38gYd4mS3aZQcN/pSCuyHvaXu+L4QxAwT/puML9ZjLseytp0xk0Ftxe+7jO6zYXqmQolhYnUlMmZUPGHdK6FaAKXR3nBsRYdpLb0tymVY2agUi50G72xIhQ6dj+yiFCZuabfGkYrnEUUxPKojqpANkcWbt/DZxPx0p9aaqCnld2x9F0reXWzRn/Z4rXoW3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePtg2yg265Ys5IP7I/Y1ac/VXQeLMqm11rUj9BCck/w=;
 b=CfSBg5k94O91wybP0MYbh5pVgSjSjCQRt2IdHxorhl693LEua5mdqGm8nJOpyS3SxjanU0u/vdTmvokN8811e1dde7cDpvt6HgsZnggglIN/FUPVjXhXn9yDW9SjNdDwAfwvkJzhe7rXRbhwVhhUcsRF8y2PiuEt+LT5QHCPLlDlNAjm0WLlLacIRzsC3CfZDNAO6Qhagc4IlYtVsYSlr+p5N6SoN0jOo1xr/n5ijlxaU2XDE/c4ZrH9tePFGebceu95zdd3MKRpYdqqDTbiiXFTa1FCaWraJ0At6elG8Zm+NQx07e4GNxXnWQjPAxZ5Cf6NY7/mD6hKVE1C1uxEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePtg2yg265Ys5IP7I/Y1ac/VXQeLMqm11rUj9BCck/w=;
 b=SG7lRpMDrtEgfa+RGBnYEnOW0iSrveev0a21SVn8c3vi5VguMqzsxY2/Zf8EAvCsmLYFUx60kOeu9526B3WbjsGWR6C5r9N6e8g23U5DuOtIIj+4xr/uaK6UJp4p5wAg1XYABVVtl+uUuGdQ7sCWwxL4FdOJYIiwvPuGYQRE3fM=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 08:16:43 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::bc) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:35 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD mode) 
Date:   Wed, 31 Aug 2022 10:15:48 +0200
Message-ID: <20220831081603.3415-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3310d5f-1cdf-498e-ff73-08da8b292357
X-MS-TrafficTypeDiagnostic: IA1PR12MB6187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYXMlh9p/Ou3HO53jBlSjXpekVT4NosegcYO3czxdCQPSRzsDVUobZk361By+QT8mGxUmFwiWedxE/L0ErXLzbCsIQqZJIeydIEpS3XBi72A/oVWSXU1zoHONPsNa0xik5TutxOCF4yWuGP/3TYogchLPDsi/WJYcPNKDNzkEkJVqQacMH7VdNSR1OKS52heSsKrOLGgNJ/J51vVcN6dxaEw7WQnMAV4lB/yUfqyFeqas2YU2YN+yIrPet/RVsgpUQYzp3E8S5LrUgyOcLnDcVbJjaI1SfAM7fhAsEl1mZ/0rxaNEbNlLWA/s/V4bxG5oGxTqPTpbMoYOesSrXWtIFkrxtA12Co68aCYaQ5gyTeY5t2NCH3jbWXcXv6nPu9GyG0w0xNIgn8ExnKbFy4+jQHRBqK5EiywVT+/sOFr/Ja8rghMNjqxYG/BysqXWHyzWxAGSXWrnmGqKUvKitTeaLieG/wt36uZTKIgAa0dFFql4UGj0hADeLCK7nceNkzsqy+AhTl2S5G7d99pPRD8RIQc9hHdD0IzYGH2lwiIo8kPsispFh1iRqtSrTh0S32flFRckWBh6T0/iVxkyJAVBNRxlw9ljiJqmCHMGwrARir8SfM90nAJpo66TkdrI6K2vHk/n3eqsXRMZA3RkDKzzygybdzun+UcUtn5TTChADQOImSFChJ5JCln91S5s9qUt9bV8+pwZtRwF1P3QKyP+S6KYTi2L5mJiBJawhkQbh5xj3Bwrx3s9H4SUKO6EHGlmqiO1Soc3EPMLB3nuzjlFXefnBWlngV5IDH9GK+4IzoracWXNSy23VtAIXPedXmrhGRviudWryw+PIlj5H+bJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(40470700004)(110136005)(8936002)(70206006)(8676002)(2906002)(4326008)(5660300002)(47076005)(36860700001)(70586007)(7416002)(54906003)(36756003)(2616005)(316002)(478600001)(6666004)(966005)(41300700001)(26005)(40480700001)(4743002)(426003)(82740400003)(82310400005)(81166007)(356005)(186003)(1076003)(16526019)(83380400001)(336012)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:42.7361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3310d5f-1cdf-498e-ff73-08da8b292357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
the PCIe enumeration hierarchy is different from CXL VH Enumeration
(formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
and 9.12, [1]). This series adds support for RCD mode. It implements
the detection of Restricted CXL Hosts (RCHs) and its corresponding
Restricted CXL Devices (RCDs). It does the necessary enumeration of
ports and connects the endpoints. With all the plumbing an RCH/RCD
pair is registered at the Linux CXL bus and becomes visible in sysfs
in the same way as CXL VH hosts and devices do already. RCDs are
brought up as CXL endpoints and bound to subsequent drivers such as
cxl_mem.

For CXL VH the host driver (cxl_acpi) starts host bridge discovery
once the ACPI0017 CXL root device is detected and then searches for
ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
might not necessarily exist and the host bridge can have a standard
PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
the PCIe hierarchy visible. As such the RCD mode enumeration and host
discovery is very different from CXL VH. See patch #5 for
implementation details.

This implementation expects the host's downstream and upstream port
RCRBs base address being reported by firmware using the optional CEDT
CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).

RCD mode does not support hot-plug, so host discovery is at boot time
only.

Patches #1 to #4 are prerequisites of the series with fixes needed and
a rework of debug messages for port enumeration. Those are general
patches and could be applied earlier and independently from the rest
assuming there are no objections with them. Patches #5 to #15 contain
the actual implementation of RCD mode support.

[1] https://www.computeexpresslink.org/spec-landing

Robert Richter (15):
  cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
  cxl/core: Check physical address before mapping it in
    devm_cxl_iomap_block()
  cxl: Unify debug messages when calling devm_cxl_add_port()
  cxl: Unify debug messages when calling devm_cxl_add_dport()
  cxl/acpi: Add probe function to detect restricted CXL hosts in RCD
    mode
  PCI/ACPI: Link host bridge to its ACPI fw node
  cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
  cxl/acpi: Check RCH's CXL DVSEC capabilities
  cxl/acpi: Determine PCI host bridge's ACPI UID
  cxl/acpi: Extract the RCH's RCRB base address from CEDT
  cxl/acpi: Extract the host's component register base address from RCRB
  cxl/acpi: Skip devm_cxl_port_enumerate_dports() when in RCD mode
  cxl/acpi: Rework devm_cxl_enumerate_ports() to support RCD mode
  cxl/acpi: Enumerate ports in RCD mode to enable RCHs and RCDs
  cxl/acpi: Specify module load order dependency for the cxl_acpi module

 drivers/acpi/pci_root.c      |   1 +
 drivers/cxl/acpi.c           | 311 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/pci.c       |  22 ++-
 drivers/cxl/core/port.c      | 103 ++++++++----
 drivers/cxl/core/regs.c      |   3 +
 drivers/cxl/cxl.h            |   2 -
 drivers/cxl/mem.c            |   1 +
 tools/testing/cxl/test/cxl.c |   8 +-
 8 files changed, 400 insertions(+), 51 deletions(-)

-- 
2.30.2

