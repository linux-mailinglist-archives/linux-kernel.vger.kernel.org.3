Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1453BFF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiFBUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFBUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:38:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B9B00;
        Thu,  2 Jun 2022 13:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfAVAwGm85LeJhPARcIv3OqLJFG+ZlLjgMArqMiJe+MeVGfvqI/k+a5jo98MTg23Ii/u5dQRZYhOzuEq7sARpNXD1xoao/LpumwBaRFvcX9x/OQRe9Y+GMb9nROH4Ik0hN0KkzO87nuwyvbWbCFt2qjA/ua87B7eLWe19KEvmlBMVB5e/Yx68F74/1qVouS6pofiG4bhU1sDirBejYut80x/M/12bYK5GOWtNSEEYULzlQ1WLPfRgqOzrksINn7UK0+b19zl3cxNDnFNkmQJVCEiXP/JK/yzOmaIHMaqdcX2DQOsX+bYOpjTLfDy+JQiMN78mQkodjmLAaPBpQ+BgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3wz878uOBmxqbb4QpKWSuMv1qZVhQ9QtdmEEe+rEqU=;
 b=C76EMFywGNEiIbiQae2uj0dlHXG4BmdF00+kP3prWxUdJ+nnekIRbWQ1XzovdufSpoz2twQtKWIaenNS4TAn/FwfN7R8/4dVNSHPBpYCE8UMyLnU55bmp8Vo49IE0krUbDCveBHEwEsHLlx5P9/dte1V3xfIrgRQ7KTagQLsikN+tEKIZWAOXp5t85q1EMcSIzMpbNruSj5NFCq1FkhSLX2Nnoxl1RKGoRgXQF4UJ1u+qhJJ8GNRH1ZeHJo4jl8x/Wqbx7nw50b0GifFdeV57MMLwAdLwOabdf4Cx2kprtQfukiBJwZrCf0qOXhdE2oWBVCh+YYL24qVtkNT9hoRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3wz878uOBmxqbb4QpKWSuMv1qZVhQ9QtdmEEe+rEqU=;
 b=cn4AoggZt306kiMx2wKKTY8ZOc7FzmBMTB4oDLiQP/eDR6m9stx67Xkn7SGY+qGl7lcR3gDWJZ4thOaGch09S0VfQCz8/bRd8ZphQAqKRbH48oi6asEcovxfHWUfWZ6G75TQWLPnoKVBTz4I5aHM0bhuRL+HBraC73J8XChRMGc=
Received: from BN8PR15CA0049.namprd15.prod.outlook.com (2603:10b6:408:80::26)
 by MN2PR02MB5840.namprd02.prod.outlook.com (2603:10b6:208:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 20:38:49 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::80) by BN8PR15CA0049.outlook.office365.com
 (2603:10b6:408:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:38:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Jun 2022 13:38:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Jun 2022 13:38:46 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [172.19.3.14] (port=53866 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwrag-0007MG-T1; Thu, 02 Jun 2022 13:38:46 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: [PATCH v8 0/6] Add Xilinx RPU subsystem support
Date:   Thu, 2 Jun 2022 13:38:28 -0700
Message-ID: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a09d83a-0587-47f1-936d-08da44d7e5e8
X-MS-TrafficTypeDiagnostic: MN2PR02MB5840:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB58400E0352524209A2F43A13CADE9@MN2PR02MB5840.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFUXVcGHK3iMlMYsAZbvZQsSy/L0C3BuMsJETbDjmx2Gmnhgw8lgjD25/vIIEZMI5Xe7n1bRzcxCMazyoNA4TO+Hpkccs4Wto97Mr7Rw8gmHbwgon2ALwM+mKK0aueEnUvR1xlflLApZM04mUr4vDgGZoR5kyv0bYKX1hPvdMt5lhjZAXBCBhMJRmFEIxDoHRCBRohwSRqLmZ4zsX2PKc0P0eQJWugnMqha0Y1nCPI0AQxl/NP3EL3xNcK9W7Vn2BCm2CVAgoQ7s7s3TbApgWNl0qlb7TbGmbaIBBBVVM0NiNLDJwsuDy5qDRHTPvajutKwthT+eixv4tKt+Qj2IhM0n7KnyjHVHfNABvULC/TGQbnmnFU9WTf5Z8n8b/YU50H1DEotY9kRA0TBbquDOPRfs7OFmeXGSrcqHbIbvcK4i9cafo0zpBeVZFMKt5t19sBpw19g8hBPb9koryOliKpwD38Cp4OHlr2K7dOHSQ/RcQSvBhEuZuwGiZIQIi0ZlvdoTZI9do8hgFKBSmS+EG2rKoqi55Uuu9AznqDEYbm3WAG6Z2gXhnnVYWEhTpp7a6Sl8K6TTEuWs1Noht5q+5g4Lw2gacZnQu+AuVAMAF4KZZ1AVRf9yUBQ/+qtuQAqpzsEywftl+9OQy7CRxT2ceIC1A6hSxTiodW5yyDuNjy1YP+DUs++OVcmCOfgaAdqFM9w9TxzQh5PF4dM9yb4NIw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(7696005)(6666004)(70206006)(26005)(70586007)(8676002)(110136005)(508600001)(316002)(36860700001)(7636003)(40460700003)(82310400005)(186003)(1076003)(47076005)(426003)(2616005)(83380400001)(336012)(7049001)(8936002)(44832011)(5660300002)(9786002)(36756003)(2906002)(4326008)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:38:49.0822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a09d83a-0587-47f1-936d-08da44d7e5e8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5840
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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  132 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   12 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1045 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: 01a1a0c8d456b11f2f6b9b822414481beaa44d6f
-- 
2.25.1

