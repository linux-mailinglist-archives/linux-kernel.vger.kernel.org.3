Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8A4673D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbhLCJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:22:05 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:54497
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351293AbhLCJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgRMUqIlBGPagzNs5xYPXhNQ3pvXncAgT2huEFrIo/o7TcQGElRxlBYI+0m3LHND0a+hBkvUWyV45M9hmSN8wL+2qI2JpO8D5P9ovW/C2IYJKsEVF8ENbRx/J2sN7g6lrnrUGqOUdHW063SsGefJ8I9hMHOj+Z5P/BVoRoZTejyvE7h39oXxAfIr2BL06CQ1jQ3+eH6P+f+JD9lTOQHzxbuZyGr5+8Zq43bsITIlP7UbU2uojerOUtbsl2JmPMQCZdpYPDViIRvozK+Ko8cY1r6pcWL4DEKt5s4M/cfQAlfxSTBMaSlW0HP5sMmXeE4fZXuHsax/wwPTuuz1ElSVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTLocuuqaIKovP43EaLbaj0c6hBw6iKFPenzpcD3zu4=;
 b=Irsxtff8Mu188uabGBzdRWolUUXQdZ0qjE++xI2vqLOmcX4bVxSuMz3nfMjp7taI97MbL4X2eYwYdXL98ST+rv60CFx0W6IKLCLDYlaCMHpU+WZWRGUatapLw36W05HDRxOgXSObCXZp7yMD+S242taZvcYUzzZz4WZLJ6wvhj6T+nPV0CrvEdGPmq5Pu9YeaqnHOupYkjb/LQ2sSRwqD60qsFWidxV4wnkA7WRIg+jZSiK6nd3c3GzwI7oJHdRaF4W6g5pBDhnHY6Q+O5JolXg72qpnb318mlDP6IBInEGjuY/NtwsoOeX7wg91A/TXWbGvHADTuSxFE2qW6lkpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTLocuuqaIKovP43EaLbaj0c6hBw6iKFPenzpcD3zu4=;
 b=HY6uCVw55LWjJewI24pwlLmZbxXStuyELzuvI+NPx8pC2e9+pOxRL4bRvgSwf1YDvAmo1+s9Th3A92SJ4rMunPs0zMSl+WglFR6MBb4+iZb0CCNYwnXpH5AT7IOdw8XLPdFFWglyGWcGWysY+C1sf9riwA6NO4eBeca45ygOLnI=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by DM8PR02MB7864.namprd02.prod.outlook.com (2603:10b6:8:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 09:18:26 +0000
Received: from BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::66) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 09:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT004.mail.protection.outlook.com (10.13.2.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 09:18:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 01:18:25 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 01:18:25 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=37656 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mt4i0-0007wj-Vf; Fri, 03 Dec 2021 01:18:25 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v3 0/3] Add support for runtime features
Date:   Fri, 3 Dec 2021 01:18:11 -0800
Message-ID: <20211203091814.15582-1-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e788022e-e4a3-4564-574f-08d9b63ddc8b
X-MS-TrafficTypeDiagnostic: DM8PR02MB7864:
X-Microsoft-Antispam-PRVS: <DM8PR02MB7864C0CF5218FEEDA496B870A46A9@DM8PR02MB7864.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OooJ/OsJp9arAK/edhjKTy4YkkfdRBKRcpkNdyWCc5hFeK64q93l8z2KLskol9nGIAaRs+i7LX+TEvrwDZh2rzRGi47jbj0wGnRmaAdnar+3JKYAqEQJO27mic5PZQOdJDD0ygE0Kvhier3RnRHEKkcWQeoaMYDKR51tWXgi1cy4d9jq5o/uXZzwKP1BJSjMAXGRHLnQE9gLAKIbOp1xo72jKn78Cd50OnLRoq4EpfXYYpaoL+Ivj3falbUX7xsNXD3743Dn6tfBpC1sDjMqnZfoHsUDDtnwJMrWRCAaVzd8bO43qu7X8aET+mKqxueD7QmUo84IiuqsDqRMPD88M63fel+pzQ+y7Rx6Qh9AQp3ADyQdnGUkK69374zUgD9OKLdSeNztmFdRzms+4ulI/Ryx3YhljoDQ8K9tig4l8OIfnvvkea8otgc6NOZ0aEKnma4dnC7WCF0ILqKwvS3Zc6nvtrQtRgHW9VqIFA5vrs8N/a6gs4tcLogIm9fvCFvk0zKiOTjC6l/eGZ/apYQCj9rgo1JwdAwAOQy/MHxx4/sIjsRYhaxz62CzB0lGE1Q/qBvHXeZCRqQkrEgpMd33dbdp+UHYcJmEQwnE0D93OyTl6r0kqHntmjpbMkm2nrDSjV/hdLWUTeBTXqfBmCA6E+pXesJcdqEKJveGMzrmyt3q6rsyncgaso0heLCEKi7HjoMuhTKQb/c1SHnqEz3AoqxjNmSHaq1uQwvjbC/AC7Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(7636003)(110136005)(36756003)(356005)(426003)(8676002)(82310400004)(26005)(6666004)(54906003)(1076003)(44832011)(36860700001)(47076005)(7696005)(107886003)(83380400001)(8936002)(336012)(5660300002)(186003)(508600001)(2906002)(4326008)(2616005)(70586007)(316002)(70206006)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:18:25.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e788022e-e4a3-4564-574f-08d9b63ddc8b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime feature configuration by using the IOCTL
 calls. The user can enable or disable as well as can configure the
 runtime features. The support is added for the over temperature and
 external watchdog. The user can configure the over temperature limit
 and external watchdog timer interval at runtime by using PM_IOCTL
 calls.
 
Also, added support for sysfs interface for runtime feature
configuration for the over temperature and external watchdog features.

Added zynqmp_devinfo structure to handle muliple driver instances
 when accessed by multiple devices.

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
  firmware: zynqmp: Add sysfs entry for runtime features
  firmware: xilinx: Add sysfs support for feature config

 .../ABI/stable/sysfs-driver-firmware-zynqmp   |  84 ++++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 120 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  25 ++++
 3 files changed, 229 insertions(+)

-- 
2.32.0.93.g670b81a

