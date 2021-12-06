Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D994694E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhLFLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:24:46 -0500
Received: from mail-sn1anam02on2079.outbound.protection.outlook.com ([40.107.96.79]:53830
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234845AbhLFLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWxiJufaIze+QwLeqy6fgCVNuMjIkdHjRDBXjAupmZGa/dUHsWnN10EF7C7U0ZkdJkQbhUPaGxh0P5WrVUAV2rdZsygH/kesKUyus9NFON7PWY0Y2o2Sjp0DgSXo0FJZXfCk4TIAcuksYyszPyU5ad01pRHEgB7jf8tf2epPh67GSLIabu/4d2YrRtvb+BrXOoET+GaFbwrp1vk60HnruYZvb4MFIe9PWdfk/E8I8XXOLjbBz6fFLdNShDya/c7rpculm9IOvLahoBGG77fyyxcYlr6xaPXx++4SWTObiZvuDo4SvbsTQ1I795gKIN4rkZuMj9wIZChhMeYZQgx8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObzNk6jbqIQhcKN+3YKfE4LAfEXzhOb+eQWP3y2sdis=;
 b=fIUREH60pjR3+W13dYa1M+EGovIePjHlpXY0uVbC4iypTtOkMb+7pLccbn7EpIJjjRajBI1yA/+5xlyUVmAmrJbCst3HnoXnKEJTPpIwLDETctXE+0BxX7BELtgOFQVZg+Jq+LkFvnF9nKJw7KjOS6cfkP0FUvarTGM/b40u75rOb9NGyROGjhK7RFah4PvEE6BK78OQ/Or3Q+00rCosBVd6Pc2iSqwb8Nha0IrRMRzKyYCp68p09jfiybhUqEtTcJmynNM46H++x8d/e5WJORAgrzd9n8u6limJ6ZhFQ0VHkcG5I0rtFd66Rb0HWvElAQ8mGxMT1l8qVe3tgT5GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObzNk6jbqIQhcKN+3YKfE4LAfEXzhOb+eQWP3y2sdis=;
 b=NWDkfv8TAa8nzyateJ031MduxTXGSsDlTDI/uItDoXmMgmEkQidrboQcvqLTr5A8aHDObW9wYeQTAOuivSa1E/21niAFMmazTNhqmr+Kbp+MaS79lJgmy/CGFFE5t1auEMRp/4i0uLVOquoUXbPPN1HvmkbgQKgiU4LviVFxpWI=
Received: from SN7PR04CA0239.namprd04.prod.outlook.com (2603:10b6:806:127::34)
 by BN7PR02MB5058.namprd02.prod.outlook.com (2603:10b6:408:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 11:21:15 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::19) by SN7PR04CA0239.outlook.office365.com
 (2603:10b6:806:127::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Mon, 6 Dec 2021 11:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:21:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Dec 2021 03:21:13 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Dec 2021 03:21:13 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=40272 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1muC3V-00050V-HL; Mon, 06 Dec 2021 03:21:13 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v4 0/3] Add support for runtime features
Date:   Mon, 6 Dec 2021 03:20:58 -0800
Message-ID: <20211206112101.24955-1-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ca1b5f-1210-4439-dc28-08d9b8aa842c
X-MS-TrafficTypeDiagnostic: BN7PR02MB5058:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB50580E9ACB570934D24D6589A46D9@BN7PR02MB5058.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwz4jh77g4wnLfGu+Hb26Si8jOreMAMOYEhiXeWbRnI/YJxLVH0rA40y21JWzprEumvGIm6APKKTrHQOY/4ZXXczlZz1c7DH4kjDzXHy0RdvXD/5Cjb/2E3Iyy3zAZwijc/VJd15klZvLvdwo+B8LQ16Ap+L/KpxJufcMWNh6cEHd7YOqXN+zniH+Z/7NXewxA4AHBFRVKT78Fy97K7ByhV+cs+OqjYDWJZNum984Dt3VlnEoU4JaWrjcrUjCh9nwfETW6pOtypox3DKQGclNJekms6Eaab+Nyt4T29Piy+spt4DUOqHCZ8gBzxGkVExPJ/L6el4iob7L8PHoj8GWq5dBw1AoXnQ2CBJ+YSdrG+q7IqEqv9SCMW7RSIRk9pYg2pnJVQAYP928OFfoA5NFiBgWRz07ST5HnRS2NDh4wdJrOWFPBX8DIyFjuJPFr/T+P3u7yNLq47XkG0arH1pRTeUp+Xmb3e52N206uP1tHTCIgeZsq2Hw2q3lqGBCkGI08JgdHnCb40Ctl9y/K3HMgFz8h08HMW/oRSomIy1ZrxSMLB+zqGvgkUYVrkTdMMtU8niynHXtr+CinWsRgQKHgWCqPgwvSGIkg6B7Aay9h0KSn/WO/kjbc6TQt09C+TMoYhDD0KgNCCML2Qx7LPWxv9AK2XmckPWthxGb3bKFSvnQbPIOsTfD4UA5KHTRa0uVcxwri0VaxdWM7e8D42lM2zBmIlDr60iv+4SqVSVPfs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(82310400004)(36756003)(2906002)(70206006)(70586007)(9786002)(6666004)(508600001)(8936002)(8676002)(54906003)(1076003)(110136005)(4744005)(316002)(5660300002)(44832011)(186003)(2616005)(83380400001)(336012)(426003)(356005)(47076005)(4326008)(7696005)(107886003)(26005)(7636003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:21:15.0338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca1b5f-1210-4439-dc28-08d9b8aa842c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- Update documentation for sysfs entries in #2 patch
- Add separate entries for sysfs files

Changes in v3:
- Added zynqmp_devinfo structure to store device instances
- Modified feature_conf_id from atomic variable to u32
- Update commit message
- Resolved merge conflict

Changes in v2:
- Remove default footer from email
- Update commit message
- Resolved merged conflict

Ronak Jain (3):
  firmware: xilinx: Add support for runtime features
  firmware: zynqmp: Add documentation for runtime feature config
  firmware: xilinx: Add sysfs support for feature config

 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 141 ++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 120 +++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  25 ++++
 3 files changed, 286 insertions(+)

-- 
2.32.0.93.g670b81a

