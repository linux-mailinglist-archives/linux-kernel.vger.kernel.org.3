Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0252C3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiERTqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiERTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:46:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEEF286EC;
        Wed, 18 May 2022 12:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/q5QXVWffLXR3pK+NXHPql07jv1XkRSf0OAH+2jMFIwrZZxkYbsx8+eTCcwFh3l0ZQJ2RCOVrOLMl8emaLWZb11sfFX5vlbYWw6aB3Jc/o9RwIOuq6CkhZgTxbpQP5hk5Q4wiTfbQB5fySXU4lbnvyySJcjryrS9Cs8rqQPvztInIOH5u5IaQxYejfQTnoJfnX0rANsEhD6FUWcYLwn6pjZZ8HeN6xoiC3A+BhGASpPkPEqZLHxzUZXtmPyGHbGxBReC4MqnECGGR5as170JaNiXpxPCefCejrnwtzUMy9KBYW24lQ2IrPgcdxOLjLGKG6HJHdYINiO9BphPJ0yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gCZx7QyuGVnalB22sSTvvWZFX7WaRXkBUyTRClvQgw=;
 b=P3WULk4HFrpYzpoVc0XqPxORlMozLs6pitHI4WaQDBsUXbKaLgNub1kIR3lPRgngMDO0mGl3tii/wci7nvaL+1kvDO9+jM9dSpq8j6rCS1lUlARAjKJZetClG2FEwaHAYZIEXp5wtO8hl74InMRSMoAbEAET9ajU7/FHzmu5JzXl1Rl6nnCN4uppyg4YL/qzUDKAYLamBqOa2X5XeHuk9i8rxUV8wq6TulFaG1NgvaLFg3WUabx2XQ4jcNzH7dSFXKx7C0jUnBr5dkkCmSEHNAZBGowmEdzPwKlcgS3T/RUBRUDqGJBEtGuR8Ci1xi+srrWi9NqCCr/dVfE7e8jtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gCZx7QyuGVnalB22sSTvvWZFX7WaRXkBUyTRClvQgw=;
 b=QhbJGoUlojW/fhPmjrC7uOqsLyTx30L4ZoMDf5DIWM8LgWmcr1QkIxP+JXUwte1VtrgOke4hJgOVp07Hxkqkv1xDP76HUBEnwmIpzG+xJ0TdVct8F+cFc2HupMF+R/K5Cg7pxLGVfRr+jl7e5XY5CRbP9zvTEzBFb8ItfCQTgAg=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by CH2PR02MB6491.namprd02.prod.outlook.com (2603:10b6:610:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 19:45:58 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::e9) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 19:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:45:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 May 2022 12:45:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 May 2022 12:45:57 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=40706 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nrPcL-0004Ew-Ft; Wed, 18 May 2022 12:45:57 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH v5 0/6]  Add Xilinx RPU subsystem support
Date:   Wed, 18 May 2022 12:44:21 -0700
Message-ID: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3232df86-1a98-4bf6-ca5c-08da390707bf
X-MS-TrafficTypeDiagnostic: CH2PR02MB6491:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6491E6790685494732B07AE8CAD19@CH2PR02MB6491.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuqetUcq+32shTtOUnnAJ2C7Pa7WDkCPxhSQ/An/Zb0vgvegzBD/rNsD68bKblZIzhaBqkKw30kQ2Y0BdiQk/TS0DWIg6NRjvaeCRLY0r3G1EZ9TyskNDnxKEuehGjCvFdO4Jd2L7ePS8Z0UjOpMSlAUYpp+hv34Kd7sMXne/erjCUS1GrDS9eO9tAJu9FfS4boVgB1DrFuu/gdAUOsxj4lgY8ohOUNJviz7xvNtZhhLFfcryunXHT84myhdQZ4L0rw0emZA5obySe4LOcF6qOvYmw1ob+3glqIMwxn7Vo+e2ZGbk7EtfAPIFIul8MJ2DmpIhbLpC0BEr2iqlUQ3usgLD+G5CYzUpvwyCmniSfVqdlAE0ssZo0RsCVJNd/yjxDGNB+IsayZrs1pJZelbLDU3k7BGRhTzCmOJXfGoKB1vz9Vy2l6iAqSUKz0uTU/lcSpYzAHUBnSS5DyrpEYaFvt4LWxhXvD6zY2i9kBaOJcM8VTsO7bh643EP6mhiS7uUVO5wBIw6NnjM8ccgBRcwdhDkrtWoUJst6rk6rQ50rVerrJu1ES1exHoNsUK1YYoc6XAtxBJswH/x+vvlCp3NjGI7DNroqHMYp93GXYaf2L0QRgq4slrtih8NNE4ErloYkN2F1wuJfyezYaegQ5Jlzd9ffws3dKbaAZDyjSvuEvpjx7FqwaCLAss1TfAIQ11km1JYmLltCRNwWX/HBlYrw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(426003)(7636003)(110136005)(44832011)(316002)(26005)(1076003)(54906003)(47076005)(107886003)(2616005)(8676002)(9786002)(7696005)(508600001)(6636002)(36860700001)(8936002)(356005)(2906002)(36756003)(40460700003)(82310400005)(70586007)(6666004)(70206006)(5660300002)(83380400001)(336012)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:45:58.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3232df86-1a98-4bf6-ca5c-08da390707bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6491
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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  128 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   12 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1045 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: 01a1a0c8d456b11f2f6b9b822414481beaa44d6f
-- 
2.25.1

