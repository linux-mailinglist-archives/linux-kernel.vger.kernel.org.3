Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515564C1060
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiBWKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:36:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1D811BC;
        Wed, 23 Feb 2022 02:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3f8N4qw179W0wpVTjoTSDFVdHg9YaTv/oEDoHA7bNBxQZd1oKAF9VZ4DP6Qiu9K1Zkae44/sdZ/fCCxdHdThn40tVNjSNY0bHpUtT8992O9/uZaSoJcIjx7MQ0ICpz5i0l7Hndrt6vYwPUXLwe9otC2hbRlXaaE0f7x0LjK9kZJCtxcN2ivjqyIZIbqcv8HA2Iri8nzJbk3H+nAP5ApgPjmF0x8HwwPxnd289X8c7ndESVCP+zqx4rDsmCM/zBHM3XYPjJoG6eFdUgsOzihgXTrfn3u/i6qkXcBIjMazOR3velb+UfpDxTJYYbN25QP9wEnDro1+GZOQj6LKDKy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrGOnXtXBlvWLaMm7MXuvAaOYVagRvkUVY2AUziV7K4=;
 b=Kd9uw+8cth3/ECUvXwCmosqp89lNktf7E3pKwaiTlcnZ1CYPqyY4/QAtj7OXcqSKlLu6sutrV2W+wOi9e9cWFnUVwgjUkjd2d1oojQbmw9vy57Qg082zayJeTvYYP3u9eyML4FIw9RsN8OrodY7NcnPqr+Dj2iDmhl4yqgTf8lnxNblmePop2C2PJTp91FGfmuRp9DUxLjaXK01gCwwn4Mtkar+lARyK6yaB7heUa6O6V7LtiSyIrGIwILbEpYOBTJdvATS2HcbQMmouQcXQmt73PrrKL4/Ca/9H4VFlO7u6+uXuF4dL01vp7rrEa3N+eOHdpq2kTd1mMCjHh2FQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrGOnXtXBlvWLaMm7MXuvAaOYVagRvkUVY2AUziV7K4=;
 b=jLbGaWkHvY9WB9BPHt4Sr8A3PRBbiGCWXeW1BLHdTjoTMV6IB/GNCxv7TFcM8zcekKM3lUPzNgBqJDFdEBF9bM6CXOmAmDap5X4dQ1O6xzNIYVmMXXEmMCM2Bob0HeoTWvfMW6lV/+R2/B/wuCcsO25S15eyOe5rDQPtdIgo5/s=
Received: from BN0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:e7::32)
 by BL0PR02MB4355.namprd02.prod.outlook.com (2603:10b6:208:26::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 10:36:06 +0000
Received: from BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::34) by BN0PR03CA0057.outlook.office365.com
 (2603:10b6:408:e7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Wed, 23 Feb 2022 10:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT058.mail.protection.outlook.com (10.13.2.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:36:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 23 Feb 2022 02:36:03 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 23 Feb 2022 02:36:03 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=60324 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nMp06-0000KH-U9; Wed, 23 Feb 2022 02:36:03 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V3 0/4] crypto: Add Xilinx ZynqMP SHA3 driver support
Date:   Wed, 23 Feb 2022 16:05:00 +0530
Message-ID: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5053a683-9cde-4775-7edb-08d9f6b84bf6
X-MS-TrafficTypeDiagnostic: BL0PR02MB4355:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB4355EABEFD51697CB15099D6DE3C9@BL0PR02MB4355.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+LBPcE2Pe7k4T4y+xiOCJQeDUCR38or/8zdjdIoYWiFSrJLYLhAwxjvLLXKfETc1Yrc6vxhcUy3gSF6KCf2vLq5MCqxE1zv7Nb+F3mGzma0UaAhv72ZyJWc2N8QDw2AiKotlcs2fya4LGfeypGxb/Y0RdBWLfSI4yReU3BPpo1AtpbfWUo2M05bx+GGclzNzaD14uRw3VqTFEYGxQCEdaZpAXg/PZ47LkX0NPySON0EqXH6icy3sZJJQXI2pOAs0qNhrNYlAXJhiwRzHWKfzk6cGFtolSCTHe0g9UZ4S+ElerY33z2RWx33fK+vMKJImSI7r0bgHrltGSEdWO+XtMr0kq4Y8LYHS9p2+J3aUMSXl+7/ysmBJpJQWYVif84Mhx4mmf1jXE1aKPJjDi6RWAhImZC/BirNjEBJ+0VkkKVmik7c/ujsP7pE7oqz28B2MxTpoya2Yy7/Y8L+j5hy22MJwT3NMx4DbP6JS+LY+LELUxQY1CzFQw8ooY8W/Lo2xKFfhs0IeMj688Y9phDymwNp+iVud0NSBNcbxc6+nKc8/GR/VKFDX3D4XIqPBhw87icYwESPK/wzaduvJHmoKXAoIcfOyWJR2lBT0gdO2LR78OVbeRbDUNj1GhqCv5otmox01ConG25DHRYo5wRA76XjF8WV5ylOhVqWneb8zI9ow5nOlnH9Nu+L86v/l4SJMeLtaGEBjw0mIYO4SPtZwDBFbpQ4l/9tQtShmz9CHKo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(36756003)(47076005)(336012)(83380400001)(426003)(5660300002)(2906002)(9786002)(40460700003)(8936002)(26005)(82310400004)(36860700001)(186003)(70206006)(70586007)(356005)(7636003)(8676002)(107886003)(7696005)(508600001)(54906003)(2616005)(316002)(6636002)(110136005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:36:05.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5053a683-9cde-4775-7edb-08d9f6b84bf6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Updates the Makefile for xilinx subdirectory
  - Adds communication layer support for sha_hash in zynqmp.c
  - Adds Xilinx ZynqMP driver for SHA3 Algorithm
  - Updates the list of MAINTAINERS

Following tests have been done for the driver:
 - Enabled kernel self tests and extra run-time crypto self tests
 - Tested SHA hash computation for different sizes of data using
   userspace application
 - Tested SHA hash computation using multiple updates of data using
   userspace application
 - Tested parallel hash computation
 - Tested using the tcrypt module

V3 changes:
Added details of tests in cover letter
Added SOB for previous poster of RFC patch
Removed module_platform_driver in 3/4
Used memzero_explicit instead of memset in 3/4

V2 changes:
- Removed dependency on COMPILE_TEST in 3/4
- Rebased this patchset on latest Cryptodev-2.6 tree which fixed
below kernel robot warning
   In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
                    from drivers/crypto/xilinx/zynqmp-sha.c:6:
include/asm-generic/cacheflush.h:53:46: warning: 'struct folio' declared
inside parameter list will not be visible outside of this definition
or declaration
      53 | static inline void flush_dcache_folio(struct folio *folio) { }
         |
- Included linux/cacheflush.h instead of asm/cacheflush.h in 3/4
 
V1 changes:
- Converted RFC patch to PATCH
- Updated zynqmp-sha driver so that it can be self discovered 
- Removed patch 3/6 and 4/6 as they added support for device tree
- Substituted hw with hardware in drivers/crypto/Kconfig


Harsha (4):
  drivers: crypto: Updated Makefile for xilinx subdirectory
  firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
  crypto: xilinx: Add Xilinx SHA3 driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver

 MAINTAINERS                          |   5 +
 drivers/crypto/Kconfig               |  10 ++
 drivers/crypto/Makefile              |   2 +-
 drivers/crypto/xilinx/Makefile       |   1 +
 drivers/crypto/xilinx/zynqmp-sha.c   | 283 +++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c     |  26 ++++
 include/linux/firmware/xlnx-zynqmp.h |   8 +
 7 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

-- 
1.8.2.1

