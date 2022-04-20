Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533855082CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiDTHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376464AbiDTHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76E3BF8D;
        Wed, 20 Apr 2022 00:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6RDRC+4Y1jEXlbdKdTUWL3JNBT1111I31o9QFx2C1iNyBenmD2E3uDrT9E78AuMnV7HrhhtAQWT6G67j4PBUJlZ1fjuOMWfrJGTV1u3hzMerwXijuukQ1pUjsxfheV0uBe2NfRPCicFwhdfP/CMej3UdXQMpre8Z3TvLtlhSdQoNvN1E9ZgsBmlDWaxbOkTOX8n0bakbHzG7GwQ1a9Z1H7aMUSzjTJaK0SrfIvJAEU5YnzpCiBha3wjTyg41npCniwaEE7UKGcfK5teQKvC2TThREhHoTJOqhbHIAHpgGwsVuTlMM3nSP3jXrggrWIDcogZxLGZva5HhNyG1y5wTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaY3IiXFwLlG8lawMJD5MBXZ9M1fVQ0beEx2aWi9r+c=;
 b=FkmQkFEQbBunT8bvHb5yYoJ6pRsqJ34I072v532J7zfIj3ATK7dzB3nIj5V9jKfagzHIrWx9J8EswovuJDRXmUQyQuyov0Lppscn9gL9OyGB7hH3L9A2jG2V+Q0O827PXJVtP0IhwzIOcSnrWl+wGKj3s9k42cBdlxtakcHlb+Y+HW40X9Hq8Z6vkqI0CWP98oNwM4SFdon7zqgBoqkm7xH54aiB5MDXZQNX62UtrVnPnkTEY/UFVmD7BCcSgUAVNdnA0jcowMA/4kLLUR5LBuPadpo+z/D9peb7+dCv6gnDC2D45UYfZE454JMKunwqyvmjddDnzYtmrQzXtyAY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaY3IiXFwLlG8lawMJD5MBXZ9M1fVQ0beEx2aWi9r+c=;
 b=RZ2bizsoyMKkyUuASXR7aXfHQEzy5R9k3WfCeincmoCsrAyYjXig3suObCaa2opJTZO3WvPWHzABD13Px1btsNcuCFuqYe36KsK+9MVb5SFnqzkcG6a5dzhFR7ooSwSFN4gMCln+8uNqJP4rpmzW2BQSp+jSdw4ZDqxVf2gIRfs=
Received: from SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) by
 SN6PR02MB5102.namprd02.prod.outlook.com (2603:10b6:805:67::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 20 Apr 2022 07:50:40 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::32) by SN2PR01CA0046.outlook.office365.com
 (2603:10b6:800::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 20 Apr 2022 07:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 07:50:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 00:50:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 00:50:12 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=51254 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nh54E-0001h6-79; Wed, 20 Apr 2022 00:48:02 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/6]  Add Xilinx RPU subsystem support
Date:   Wed, 20 Apr 2022 00:44:45 -0700
Message-ID: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e5906a-f059-4016-3884-08da22a27739
X-MS-TrafficTypeDiagnostic: SN6PR02MB5102:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB5102D6D84415AF40BCC525B1CAF59@SN6PR02MB5102.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXk6T0zHrVeihoNNyHaWapxPtlF7L5CGFHeGbyoJahHsiwhwkTpy1755QmyjWEX0Uj81sy9U4iQivFIKavAAC2CEPLdRkRuzerybkoOi2tIx1pLb2x0pxgBiQONnTnXAV+RSkh8Zs5enzmlnLRZGjOPgnrA0qBSEE7zjr4Mg+hzA3Op51nmWB3lA31tIIjRZdUs0ILWHV624HUlr7mgDClrr2PAv+iyIjPUJ91cVHIlcs3qNf/Giza67vy/1mzloPmnWgnvO3m2PC0uLyoDwTlsnOJPRgsrhLrqhlyofJaQ4ufCTjCjdOxbptUpJJ4VuZLYYM+OvAMpC+YUHshNEwSc6i5RvuaCaOAVetPpOVkErqbhZQ8jc/hSdq7LjGst2MQUGoU89OoVrA7Yenom0onaawxQDNmpMDIqlWPFzGy/Pv64qKutZkQxSf8IFbiNBkHQ3wIB+5rsyEypwIL8QLznbro5y7ftj7wHuQCftwzF1jTzJvzDtqBIyLOllveHugZ1So9Wal8AZY4zeMzHr5PJd6xYtCrmGrFf08tRtiQEiAHqKpHwh40XO039eZuF6HjueM4dxYKybGLOFbkOh87AegCulO4hXKuuG/UcOF2LWq9S1nK4FNvaO1tMoWo80qKdvnX8aPBlX4Dpm2VivrXqa5hErmWrgAvA+wuSn4DFf18C0/T9pDMMbsp/twCsLQ16i3LuRRqzgHhu043PfMw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(82310400005)(54906003)(40460700003)(36860700001)(4326008)(8676002)(7636003)(508600001)(8936002)(9786002)(426003)(70586007)(47076005)(6666004)(336012)(44832011)(70206006)(186003)(356005)(83380400001)(26005)(2616005)(7696005)(36756003)(5660300002)(110136005)(1076003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:50:40.5537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e5906a-f059-4016-3884-08da22a27739
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds bindings document for RPU subsystem found on Xilinx
ZynqMP platforms. It also adds device nodes and driver to enable RPU subsystem
in split mode and lockstep mode.

Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
contains two arm cortex r5f cores. RPU subsystem can be configured in
split mode, lockstep mode and single-cpu mode.

RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks. In lockstep
mode, all 4 banks are combined and total of 256KB memory is made available to
r5 core0. In split mode, both cores can access two TCM banks i.e. 128 KB.

RPU can also fetch data and execute instructions from DDR memory along with
TCM memory.
---

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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  145 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   35 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   12 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1042 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: 58b7c856519fe946620ee68dd0c37bd3c695484a
-- 
2.25.1

