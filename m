Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7F539A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiEaXnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiEaXns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:43:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32F6D976;
        Tue, 31 May 2022 16:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ3DUAgjhLOjhjKRdAJCv5u5pEHuADdgwuiA23KU9mHvUl3zziOp8z1lJzzcDCYHwjhJ//W/teEeH0SOzgjcqQQkZ1dLIBtphiaSebemfIlOMNn8UYc+3YU3AgEK+fVcg2IENsUtvWAavMg2bJC661ynGwfnV/k2si9GVJPO6RdcivShvgfjX+tLEGGsIJ8R3f8pVg7UVDHnGFysUmTtSIdauU3rYqQtcaiePLE4Gx5eQs/+u8dzEJD/9QlzlTVxFcWHfFWaQZy+o5VgOgHuasOb4C6U267udmfLoKdQI474AFgkMyvWrz1V+Xhtn0kT0cuOZVbuFa1u26BtCGQ+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yiWMsQfn5YskgktoEFC6118HhVQF4TxV5MaSat+mXU=;
 b=oXQEimIzAaeGPAUzZvhN2bdYFeytwFqWLxDRIoXbRGA4X0F14x/7tdrbjIJIzfqRJdlhQ0oANU4Dp5iOAWkPoqXDK+Q2Zu4NrXlsMxgGJBegGioEG/Ns28xFWfVz5m0eKJswqFlmCHCACpk/ztS2k3Jc0f25NJa8EyXDtNtRwvA5uQHjov3rsHGfYXrGnCRT4C4PzWCXLRvw28vCAOIqM4Xwj+5qwDHPr8rwdqyfoWttSXBVJ50YHSDUBOjOFaWWalZ294e76AmSxe6b+FT8BjmvcyH03q56PYmHVygbijb1wYpYDdE4MBV8DtyBvjz9luvS7lyHE+8LlyUzTdFStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yiWMsQfn5YskgktoEFC6118HhVQF4TxV5MaSat+mXU=;
 b=DBlnJWoldiJyPbUv8ewesLLlqoLE2dtv4L+Q3QCKWUqySH8KFcOrggdDZdp6mIuDArlFkiEj4TacL+yl9Cq5/ZFHKPQ4NpFarzdgpI/bhCHsnkeTAvzX4r+6Roy06u6eYjlbkhB1aCG6P70OvH2/+xspA2sMG/dSvV+GsrOys4U=
Received: from BN6PR22CA0067.namprd22.prod.outlook.com (2603:10b6:404:ca::29)
 by BL0PR02MB6497.namprd02.prod.outlook.com (2603:10b6:208:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 23:43:45 +0000
Received: from BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::64) by BN6PR22CA0067.outlook.office365.com
 (2603:10b6:404:ca::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15 via Frontend
 Transport; Tue, 31 May 2022 23:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT012.mail.protection.outlook.com (10.13.2.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:43:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 May 2022 16:43:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 May 2022 16:43:44 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48904 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwBWa-0006jm-1P; Tue, 31 May 2022 16:43:44 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 0/6] Add Xilinx RPU subsystem support
Date:   Tue, 31 May 2022 16:43:03 -0700
Message-ID: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b529542-20a9-4f5e-ba90-08da435f66db
X-MS-TrafficTypeDiagnostic: BL0PR02MB6497:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB6497F968B9839A34CFEBE2D5CADC9@BL0PR02MB6497.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJutpr66u7dAsdv4uCqZSjv+4P3uUtBM878KdoFPYizOCxzmdxL8NrQXtED0IaBGxJmcBgHaEQ8HH7yljKjT7d3lbDg1+WVvj+Tde18+10JLtW6lbzXNxYAJzAaIqoWv4iELa9AKy7pRd3ltBy7m0GT64rNgQEUNfF731mpMTarDiwY5XYKE4EBP3nBX+ockxpj/F+NAHCHqIHHlwmAuAGZ7fkKgdPobCP/ok6bhC7RYG2tjc6/iJj5wqX8OkUTppoQ2fStJDHeFUxZIhCPNlmlMi7rygxDN4QB1t6QXl1wa2iJctByFx87TtR3dp9zOCrU4p4DJ5Csfmq84XeQRd2YSU3xuw9scmmEEZEuQPqh/3J5zRpARNkCA5Q6Uds/KEtGonxUOi+v0Dhn5cmFc612cg+5LebVCB9JShM/mMR5PsFwxs7+iYHNAWu8SlyuWrQU/JpplpG9OUAgiUCjf0D4WgTsL6sagjdsJsb1SMMmDU/yZg/ZLL9B+rRi4tcxro2++SelLtkWlh/ysG0Ttd+8m6AtPpTdNl1s0M4lIZY8yhL+ViPelysQkJxFK8ywunLFy3BGXMsJdtJd5ADFZ4ZWO1JsdXtkI1M0egRR3B02yGzuvs/HWtMb9T3Pxg63S5N78W4kmsSMg9i8+1HUGOikP4yr+xVdVCcHnFaJB7deU63YPz9qr1AockwIWP/sZ144bqFgd2pk1lF2wgG6FmQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(4326008)(6666004)(83380400001)(70586007)(70206006)(1076003)(508600001)(7696005)(8936002)(7049001)(5660300002)(9786002)(40460700003)(44832011)(36860700001)(2616005)(7636003)(110136005)(54906003)(36756003)(26005)(47076005)(82310400005)(426003)(336012)(186003)(316002)(356005)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:43:45.1570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b529542-20a9-4f5e-ba90-08da435f66db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6497
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  129 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   12 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1045 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: 01a1a0c8d456b11f2f6b9b822414481beaa44d6f
-- 
2.25.1

