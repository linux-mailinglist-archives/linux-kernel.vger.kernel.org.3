Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE314B0C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiBJL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:28:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiBJL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:28:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8BFFA;
        Thu, 10 Feb 2022 03:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhk605ItZv+Qy7HEK9OWQPF02FWpuFCxKoVIl1R+qgp4l/fWrruQhCgzkyapWLf+5mNtHU63x8A7syUkLOUvJzKwZpZ+OQpwZ6o901gt1qKfLkdfGUfEU8W7AHSS3ThQvwviUsdEnFspZ3FFguAecPx43kQmr0VVcztvwOmljop/mt4EuKifmewgKlF9LV9wBuMfr8KdoQAd45QIAaLTelrNCAUYe6YPCM1EkOXygNlup47CeVjB58bb1xStxtoAJRC3DRbdO/aUjbgJ+mIWwkgHCHJOeEP0o/mj/qi79P6F13E4trXTIflUk7BUF9cIRCSOpW/TpbmUjIq3Wsy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzJQ+VD1Cu6QX8NodvFicNn/y5WCKgzuptf7qqSUlUw=;
 b=ddxw8c0JCKxOWVUzaurEX00pZkOSuk3GhCpszn5SVD+vuQgv50OuSZfteoRKmbtnIQzTT1GF8EHGZx8Ipm7JfhqwKzVzLkLR//ra5081oWryb+F/FAjMV1hmPXrG+T87gj9U4tLLaOiAVw3BUyaF7ACP+6qhy0493ULOuX5iW8uDtx5kZxPeY5RZS7R2zRkoHYKSHI3dXzwOVwM3uH26jBU7NYeKAL4558YNvCBxqInaigLzqig8sbGtEmEigvsaABVM7cug0ISkudt/NYdCnV8OdZHvgTvXwBhE+ZP0fv66CsPutknyCeng/UVWSOgxetEtnUYPNO5C7OAcIN7GsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzJQ+VD1Cu6QX8NodvFicNn/y5WCKgzuptf7qqSUlUw=;
 b=bNPyVRnfnbu9SXfXtWNFTirPkxijspIv8e5D/HRAjBDkEeE2ohN8g4R6TFIgzBT9DDiVKysY8Qw/R37JqRFN4JnclPIx3fwBbXKe/dvQJsl95nZT6fP4ITF8WOQcifyzzljF/knoy7iYEi9Xxac9cuMgTOfI2bAh/0okiEcFw6w=
Received: from DM5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:4:2::13) by
 BYAPR02MB5973.namprd02.prod.outlook.com (2603:10b6:a03:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 11:28:45 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::27) by DM5PR10CA0003.outlook.office365.com
 (2603:10b6:4:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 11:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 11:28:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Feb 2022 03:28:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Feb 2022 03:28:43 -0800
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48874 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nI7cx-0000UP-Sm; Thu, 10 Feb 2022 03:28:43 -0800
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <laurent.pinchart@ideasonboard.com>, <ben.levinsky@xilinx.com>,
        <bill.mills@linaro.org>, <sergei.korneichuk@xilinx.com>,
        <tanmay.shah@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/6] Add Xilinx RPU subsystem support 
Date:   Thu, 10 Feb 2022 03:28:18 -0800
Message-ID: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d5bc7d6-8400-4a56-3b7c-08d9ec887fdc
X-MS-TrafficTypeDiagnostic: BYAPR02MB5973:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB597378CF286E4F00C40730A4CA2F9@BYAPR02MB5973.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/WX42Epsm1KrasgUKGTHfrwfdBsVpISeDJ6LkklIf/ra9/xW2iT2SsyGlsfaRuxkpgJmqJAf60YNgbjItSVxOrBoWC14ZDkVTJhuCxYjgjFrDrDTwoAz13izh4h7UQklRsyudExc3d3+Mak/L3fAIktLNvBLt7ciFTf7IyoMDzgJHvblukHxIQTCoGoSwtv4N/1AfmSp6ytABRsyKwsSkrGREuK0AJL4GlfIOtOSnesQQOEzoE4XCumDm+x0VTyzwShYC5/oayJsyGpO8GvCYBux2/Vp9fchJpaUBUlOua5QHE+G35ikRQs2hMKw2CvRnZT3XVH1bg0okqeaa4rBy2/b8AtiOFN4ScUYU1izfqIC2gX/QzC3mDYgJmrGFDrhGmj0Tw8bIHsRWDFEv+tDtK8fxJ6nErKBP04hQbwuNG1cda+CEr/HDtiKlbY4c0SF6bF44V9tydniPfGWKU0+3F4sAok8T6L3ULZ/yxtjzGz66OhKhfRgF4G9NohiXsKuXd4Rb8Ubki/1Ft1tRwiySw2hkPMVIoPw1ZJ4aUZHL0/YrZuep2crokb+oEml408gf3rVmfJI0D9e6TGg9zeUsc0sWmjXrCTROxqRWEAnVJxdwqGXiw5FMIo4L42wgWEf70riejzNrA26owoCoH8SeJTjh/bZ/EVUV6amNVFnkhF7RjXICYs10TKsyjrS1Pn
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(6666004)(356005)(7636003)(36756003)(508600001)(70206006)(5660300002)(2616005)(8676002)(82310400004)(8936002)(36860700001)(4326008)(1076003)(54906003)(44832011)(83380400001)(6636002)(4743002)(9786002)(47076005)(7696005)(2906002)(426003)(336012)(70586007)(316002)(186003)(110136005)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:28:45.3545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5bc7d6-8400-4a56-3b7c-08d9ec887fdc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5973
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds bindings document for RPU subsystem found on Xilinx
ZynqMP platforms. It also adds device nodes and driver to enable RPU subsytem
in split mode and lockstep mode.

Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
contains two arm cortex r5f cores. RPU subsystem can be configured in
split mode, locsktep mode and single-cpu mode.

RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks. In lockstep
mode, all 4 banks are combined and total of 256KB memory is made available to
r5 core0. In split mode, both cores can access two TCM banks i.e. 128 KB.

RPU can also fetch data and execute instructions from DDR memory along with
TCM memory.
---

Changes in v3:
  - Fix checkpatch script indentation warning
  - Remove unused variable from xilinx remoteproc driver
  - use C style comments, i.e /*...*/
  - Remove redundant debug information which can be derived using /proc/device-tree
  - Fix multilined comment format
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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 139 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  17 +
 drivers/firmware/xilinx/zynqmp.c              |  97 ++
 drivers/remoteproc/Kconfig                    |  12 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 973 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 include/linux/firmware/xlnx-zynqmp.h          |  60 ++
 8 files changed, 1305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: f5d4b6d998d403352d0143e0c158706412384121
-- 
2.25.1

