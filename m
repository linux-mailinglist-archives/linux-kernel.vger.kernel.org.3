Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4F49C35A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiAZFsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:48:17 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:48225
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229768AbiAZFsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:48:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PopCP9mxPyo5La3wr9X2sRrXcj9PKNrBQkYUg05ZRURh9IqG1TeAFmsAQOd1ZWugAcXn0XtnupATwN0Ml9JOsYwZrL7sNFPqrIpxiBwAbh5gh/Vpvd/SZUfglYRSTccOy9OeguJ7v+KYnuH11FN2EoQua8CcfpHwfwRiT/oc+8wsZS6K45ZraDo4vzELs1KHw2RLpbtgMCf8ThHaxMMhZtkLCTxfH3AKrVASH7QTwFtNRkfJR9rUxl6Ch3Hk3sFujMWgbQXzzcA+a45R/1JQSSejbyj/vdIlsXe8oh1JPJy8lXSs6x9kS158E870XO9gVp4eejLN5wF8eAfGNHAUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STyt43snmMTD/rp6zCMGN8j16MXXD9FRieJ7gQX6pwY=;
 b=jWW3rW/a9JOOFItFa9ZXgwNt8yIlTdd6sIUst+M9NkuWyrxWD+oGhsIzFUYRX1flLbTPLj6hWYTEbiDZpn53ZTEoJUsBW5v8jDk7+qiypL9OaiA54FI05yQpTZZtPS/w8HeEGAbQnZoZpEhE6SxcGjgq/YDf27v9TWoREoLXHbcntaKU0kL8eOhB6Gr782RPU8U8VemxmbGR0ehtWRhyfoTO0B6uHgYIRYw/G1TfIhB6iG3y7/wStcSxFrZNlgAhPTiu0jO7+LIQl9x0jv0ueRNLixwo95RCHhEhg9MkpHWgBHWPOfYe4ar5r7rCp15mYVS1Fud0afTmKn83W+3CiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STyt43snmMTD/rp6zCMGN8j16MXXD9FRieJ7gQX6pwY=;
 b=IgkJ0D7ooznFWyVP0m1i9ekycapxfJPRvwjrqSNWWWFUyXd3v1GM2C/lV7WoPMecplQRiy/OF++hZvcWXntvMqLD3ACLdQGZRwKLKc+cOXXjEGqp58q4/EPNqzBunJyP8gCfc6pogsdVE3R1XCEQUH3gOlkYd8o2pxp4INtqqv4=
Received: from BN6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:404:65::34)
 by DM6PR02MB5561.namprd02.prod.outlook.com (2603:10b6:5:7e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 05:48:12 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::f4) by BN6PR17CA0024.outlook.office365.com
 (2603:10b6:404:65::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Wed, 26 Jan 2022 05:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 05:48:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 25 Jan 2022 21:48:10 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 25 Jan 2022 21:48:10 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=40716 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nCbAA-000Gro-RZ; Tue, 25 Jan 2022 21:48:10 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 85B55600196; Tue, 25 Jan 2022 21:48:10 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <devicetree@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <yilun.xu@intel.com>, <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>
Subject: [PATCH V1 Create empty OF root 0/1] XRT Alveo driver infrastructure overview
Date:   Tue, 25 Jan 2022 21:48:06 -0800
Message-ID: <20220126054807.492651-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72480f15-10fd-49ed-a4ea-08d9e08f708a
X-MS-TrafficTypeDiagnostic: DM6PR02MB5561:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB5561D216CE4D64D1F8C34E97A1209@DM6PR02MB5561.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2JpLV8F40Su1F6k+tCfEQ4ezhwD1P1EiX5LMLCqPt8kscMXj2ci0MeeTZtICIeU33rGOev7Uo+O4X8dp9gNeXbgLRfR/bOCtAWRtbs2tcAi1E9juXUwlCjdd7LHy0b33gVW8Lx+sANNMrPCXFJAb5w9mTevoqCTaEYwOyT5pV7r55BHfMY18aCdQhKYUy0qsNzaJGoXxMF/L6EaasTO+ifARMYNvkFv1krPv6+ObgtEE1ClEqtypCWnMKOlKRyo11HkuxEQFsnS85Dq1wADaUnf73gwHjrj4swqUO/Np55LLJrLilfcF0DSRczNa/jasE/ind31xQIQn6TU1Oq2TXCc61qQNlxjq1L+5X33Zi2iT4SKTxZbWwN53royTx7XS0JHG3yEcy3xU8hOyxZpuqZuTVdYng/z/xOEXh3IG5mtySkZtaZDfVHrsXgJyr/O25Lm5GeOaqh8m0Qd4NL1u6EnXA1HCRu7Comk2Y2YnPGnIOJqax0KnxP+3kov44nc0vxwpUXuPRd/KTQVCa8Uqh1L1wUGM7zZEd313ZI7ILPEmJxtlbtKre6FBnp4VazahKI4BXq7parS+SoXrG3UCu3jo7Ku2NNSaov8MYOaaROvlkPgxYoHReSHGwamX+N9vEYflOW6tzNpOgbisvmhrbYB4ez3YilAKXSR+NiHSYt0rNLcxPaozd7i+roxCWLqoN4S1m2bSR+Yy1Un135ayEKC6in2tcXkd9PSYyIx/sZ1zvS4SMpGr9BKvHm7gX0P94SN7hGU+Q+jgfXRI8C+BEcH60SuzKLiOC/yXIgurSXuneqGBJBs/gQVPf/lxZWxgvq6OrP7qgRSguRNnM3LJc+dbu/AdWgaZbj0BF6MMB6uTrWDVtecgmshYFYNEz78quf0DaaDOappSPTyu/89LA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700004)(36860700001)(4326008)(47076005)(336012)(6266002)(82310400004)(186003)(54906003)(2906002)(966005)(7636003)(42186006)(26005)(70206006)(8936002)(316002)(1076003)(6666004)(356005)(70586007)(5660300002)(426003)(110136005)(8676002)(2616005)(36756003)(44832011)(508600001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 05:48:12.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72480f15-10fd-49ed-a4ea-08d9e08f708a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5561
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Xilinx Alveo PCIe accelerator cards use flattened device tree to describe
HW subsystems or endpoints. Each device tree node represents a hardware
endpoint and each endpoint is an hardware unit which requires a driver.
The product detail: 
    https://www.xilinx.com/products/boards-and-kits/alveo.html

The feedback from the previous patches was to create a base tree if there
is not one and apply the unflattened device nodes by existing Linux
platform device and OF infrastructure. Please refer to previous discussion
with device tree and fpga maintainers.
    https://lore.kernel.org/lkml/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/
    https://lore.kernel.org/lkml/20220105225013.1567871-1-lizhi.hou@xilinx.com/

This patch adds OF_EMPTY_ROOT config. When it is selected and there is not
a device tree, create an empty device tree root node.

Lizhi Hou (1):
  of: create empty of root

 drivers/of/Kconfig         |  3 +++
 drivers/of/Makefile        |  1 +
 drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/of/of_empty_root.c

-- 
2.27.0

