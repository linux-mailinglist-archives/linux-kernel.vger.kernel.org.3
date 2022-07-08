Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5467C56AFF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiGHBkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiGHBke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B572EFC;
        Thu,  7 Jul 2022 18:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqeFX4QwzFylv5yPMsB4nSJHXEylozxUxUn2RRC0wgS5I9B+0hmys/JS00Uvm4loPSRV8tEZ0UDFTib/af4DV5tTdD08RSsv3enR1wWLdhAjhH58M5NeEaMIlpe9jihTzXvt110kuAyz9NDIDo9cH5Ej/ERIt9qGEn3hd59bpZlCuX7W6b8hHQR3hGawxhJGLWKHKiHi8NfuQh5ytCw87h1YuTUpLEeLIb3bZ+0kb9l+hm28T+H7hPMBY29TWZBGIGpzlEJdQLOyK0RiXYtd4sMZ+F0AFboRO43wOHYQDH/iTmyEAYRi1hI3KJmX7b17RnBFEc2M1OU1Tn5lQF+Hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQQfQBIDgLG5VRK50406i2NGXqc197WnW7SvmfBOQ6s=;
 b=Ux4eCarOQMvFm1qNF91qiyxW3iUfHG0P3WbD197GZ5mnVpoy/AkQswiVTg8RmtbCc37w46Dz++xPS1jVPvRfgg4DWzhK8M08k/cngRdsL4HwLDojHyTd0JT2yfiBfP9bEHj4oyZHqWD3GJtMCjN9QhNV+Eeetw0cbaKSnlgajSavuIXfsBigr+3j48U6HLwmzkaNEHCGGCuUtmrRqWaulCrKXFHRnhNs9ylSbBfpz7BddWIJxYAl/i2l9cZl2dFQira2m4/MEvOPx9VueqzvgZTz3w0nmlG/d1w0vnb4UaEmXdke5s1RaL/ax8fVCOE9oThvq/1SD7rcZ6JBKQgA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQQfQBIDgLG5VRK50406i2NGXqc197WnW7SvmfBOQ6s=;
 b=uTRWnwpxudZ4VStLgwu4fDn3VIT2JSYIeHCvJZGFybR6wQjV+rH2KxZDMrjfPLxRhbz7ESLbmTjmhWreiyMc2qG4omAYiJcQoVu8s2s9ZC9+JBXQUMqrzYlEOhc8PXlA+rLQJ+e1gG2P3Gcl+4fJC1x+3HpsCR5K5Aol+Ew1bKU=
Received: from MWHPR10CA0021.namprd10.prod.outlook.com (2603:10b6:301::31) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 8 Jul 2022 01:40:30 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::e1) by MWHPR10CA0021.outlook.office365.com
 (2603:10b6:301::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 18:40:28 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:27 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 0/6] Add Xilinx RPU subsystem support
Date:   Thu, 7 Jul 2022 18:39:49 -0700
Message-ID: <20220708013955.2340449-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40012a73-cb91-4003-67ce-08da6082d76f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfWOHSsAuEeGsQ//htYdC6EWADYHLDlhA1JJ9ylB4Bw5lM51TNL6vdM+itOnmxzgOL0RmdZK9ewMXIHK+2xQIGwRfDKowF/2NdNr7XOZFyi6BQvhJKkHulabH+niD0cM/QV9f9PdjBzHCrk6wn3M3UuYG1tQZblwHVt4GjdcBvzsnS2KqTFrNN3HsJG/26n+8GDY/W52flM8qD3gl4OzqugoZiEA/IAGaSbaJSptAARIfTS0z3SJcQNXNvnZyvSEMDikiwH5akTqBYWMZF6hjHcPhiTPfJPnN/vgaBJywuplzOnjTqHgDe0tXfTUpyG818K5BGo82H492cYr7qydmVU6EvuSMg55rbc3wWwSJH9+n+s5IOipiMrccW1urk9MxIgTWRXqc4jU0OmzxbqgmWwFmv7jhBf4a2RRzQ9mjJMacW7o4FQ0wWULR2L/je/+8jjxzHFCJguUnKvx7hI17xPvF5cZchi+ByNc+VDVJ2AzjipkujZa093K9JTzNzBlucHDVrWoS5w2szGJHj6VLGVMASgwO8l+Mm9D+Vnj8FA5x+XFUmTewHFmUNSdy+B//ixwGp59HHCjKZSa9hsnlrgEmvLZ+U/1oopO4ZGi8lsi8NfgMVFCuxoqvAdOxUolDHCMgWG0Kd5SwS8n3xZEpLwiKYcKo4Ay6XmmBTr/l5nMTR2ZsYKTS88yRbemu++jAoIiA4BbwpCBMsxq727yT4P0jgEFbe4ZxFiYeG8nRTkQXM9OAUma12r96424guTna7QHJD2mDZDMBQ1GdiBno5MrmkxE3HGZxti8Q1bx4yrWdBnjvalCDIFxmb3Xz/GBmiSxpcMHn5wN/rqO0eCuI1cPqqYWm9sWlDSfsN9RsAoNMmFO6hejvGcnCk46yYIo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(1076003)(316002)(26005)(41300700001)(110136005)(6666004)(82740400003)(8676002)(86362001)(70586007)(44832011)(8936002)(5660300002)(478600001)(54906003)(81166007)(356005)(4326008)(70206006)(40480700001)(2616005)(40460700003)(36860700001)(83380400001)(82310400005)(426003)(36756003)(47076005)(6636002)(2906002)(336012)(186003)(34020700004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:30.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40012a73-cb91-4003-67ce-08da6082d76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds bindings document for RPU subsystem found on Xilinx
ZynqMP platforms. It also adds device nodes and driver to enable RPU
subsystem in split mode and lockstep mode.

Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
contains two arm cortex r5f cores. RPU subsystem can be configured in
split mode, lockstep mode and single-cpu mode.

RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
In lockstep mode, all 4 banks are combined and total of 256KB memory is
made available to r5 core0. In split mode, both cores can access two
TCM banks i.e. 128 KB.

RPU can also fetch data and execute instructions from DDR memory along with
TCM memory.
---

Changes in v9:
  - bindings: remove power-domains property description
  - bindings: fix nitpicks in description of properties
  - dts: remove unused labels
  - replace devm_rproc_alloc with rproc_alloc
  - %s/until/while/r
  - %s/i > -1/i >=0/r
  - fix type of tcm_mode from int to enum rpu_tcm_comb
  - release &child_pdev->dev references
  - remove zynqmp_r5_core_exit()
  - undefined memory-region property isn't failure
  - remove tcm bank count check from ops
  - fix tcm bank turn-off sequence
  - fix parse_fw function documentation
  - do not use rproc_mem_entry_init on vdev0buffers
  - check tcm banks shouldn't be 0
  - declare variabls in reverse xmas tree order
  - remove extra line

Changes in v8:
  - add 'items:' for sram property

Changes in v7:
  - Add minItems in sram property

Changes in v6:
  - Add maxItems to sram and memory-region property

Changes in v5:
  - Add constraints of the possible values of xlnx,cluster-mode property
  - fix description of power-domains property for r5 core
  - Remove reg, address-cells and size-cells properties as it is not required
  - Fix description of mboxes property
  - Add description of each memory-region and remove old .txt binding link
    reference in the description
  - Remove optional reg property from r5fss node
  - Move r5fss node out of axi node

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in dt-bindings example
  - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
  - Remove redundant header files
  - use dev_err_probe() to report errors during probe
  - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
  - Fix memory leaks all over the driver when resource allocation fails for any core
  - make cluster mode check only at one place
  - remove redundant initialization of variable
  - remove redundant use of of_node_put() 
  - Fix Comment format problem
  - Assign offset of zynqmp_tcm_banks instead of duplicating it
  - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
  - Remove rproc_mem_entry object from r5_core
  - Use put_device() and rproc_del() APIs to fix memory leaks
  - Replace pr_* with dev_*. This was missed in v3, fix now.
  - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.

Changes in v3:
  - Fix checkpatch script indentation warning
  - Remove unused variable from xilinx remoteproc driver
  - use C style comments, i.e /*...*/
  - Remove redundant debug information which can be derived using /proc/device-tree
  - Fix multiline comment format
  - s/"final fot TCM"/"final for TCM"
  - Function devm_kzalloc() does not return an code on error, just NULL.
    Remove redundant error check for this function throughout the driver.
  - Fix RPU mode configuration and add documentation accordingly
  - Get rid of the indentations to match function documentation style with rest of the driver
  - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
  - Use 'i' for the outer loop and 'j' for the inner one as per convention
  - Remove redundant error and NULL checks throughout the driver
  - Use devm_kcalloc() when more than one element is required
  - Add memory-regions carveouts during driver probe instead of parse_fw call
    This removes redundant copy of reserved_mem object in r5_core structure.
  - Fix memory leak by using of_node_put()
  - Fix indentation of tcm_mem_map function args
  - Remove redundant init of variables
  - Initialize tcm bank size variable for lockstep mode
  - Replace u32 with phys_addr_t for variable stroing memory bank address
  - Add documentation of TCM behavior in lockstep mode
  - Use dev_get_drvdata instead of platform driver API
  - Remove info level messages
  - Fix checkpatch.pl warnings
  - Add documentation for the Xilinx r5f platform to understand driver design

Changes in v2:
  - Remove proprietary copyright footer from cover letter


Ben Levinsky (3):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs

Tanmay Shah (3):
  dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
  arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
  drivers: remoteproc: Add Xilinx r5 remoteproc driver

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  135 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   12 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1055 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: c6a669485125145afd22230df6e0e6c37f19ad41
-- 
2.25.1

