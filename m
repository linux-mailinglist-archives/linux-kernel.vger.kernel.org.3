Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD804AEC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiBII1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbiBII1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:27:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1DC05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:27:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJHyBVsJyaoSU/nwRtoOmBWjFtVEcuSjsMqjr58V4xrXE95xfIKrdFkbqweJ8r1mFPpEV/8MtgOdJFi8JAXQ4MM3fnG4+K7Z9sOml0y3lxHXSfIiYBwH/x4WK5ceu9KYo/AwmEa/aFzJ6PqDjqrXuwy/Vdsce5IexKZdW9JG8RFlR5o3HycheS3+e5CFRPZWI3TXzO0CtU3wrFwhCGYhh+0VWx9ExCXQisDGvv84ijDt+tkZN0qX2kdrdvSfUhAjT1GCMZ5v7Ck7865R0qq0+K7i6fNpngx2IQO1bkBy9UCeXr/uCaEqTcvtVhXywIn7myTapmWCuvA4U66zIAJQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdhtCrm9VLQb9pRaRJ2rVcxXNxI178yyQtJUfTPSBrA=;
 b=BMn7flWhsyz1WxdS4PwRaPgDVJONVsTYORKj7WiRFLDylm5Wp3J0wGUsn/L3aIgmJPIT2uwwgFwPAu3ORTr+RH97sQeedzWCK0qqf60jpbV4Z7DPgzMtHAfda59QwWRJ50SvgsMCaydSXDz7qExU0qIt2RbjODsVcpRaoVnqfziqLAOB9iy+LTZNvGvPl/5xHZRwn26OfvMxamMH0ggIfsCI/TbPVqBVNdO4Qj0CSfE18csJUzwUllqjkGN02nWQYYoXZCy3Laqpe8g+6U9mgwZ5alpt3X+ENsxEdsbMOx/hoQ0h8VFk8NY3LqYHVn8swdTHkhTpUpeSpg0AIGI9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdhtCrm9VLQb9pRaRJ2rVcxXNxI178yyQtJUfTPSBrA=;
 b=YMmx0eVZtnC7UPZFVsTNsRh0OuPdVIyuy6Spl3/fXMvnnJyAJGK9XQ1TFZEU5obePQNTxwEWNWRLDD7Lfop+8XbV+/H5a1EhRoCfdFX6PihbAoos0mDv5fA6lGVS/tYHD6sHGHM+2YT5Dif0imzgks8XRiwKBEDdilCzgkgp9nE=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by DM6PR02MB6601.namprd02.prod.outlook.com (2603:10b6:5:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Wed, 9 Feb
 2022 08:27:15 +0000
Received: from BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::5) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 08:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT023.mail.protection.outlook.com (10.13.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:27:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 00:27:12 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 00:27:12 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=40310 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nHiJk-0003T0-BU; Wed, 09 Feb 2022 00:27:12 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v5 0/3] Add support for runtime features
Date:   Wed, 9 Feb 2022 00:27:06 -0800
Message-ID: <20220209082709.32378-1-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26bce116-08d1-4cc5-46a5-08d9eba5fa05
X-MS-TrafficTypeDiagnostic: DM6PR02MB6601:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6601DC18645A5C56442DA695A42E9@DM6PR02MB6601.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nr6YJ3DqMf6B+NcpyQp0Jx9+XnEcL/I3VbfIrXuyACxs18Rfu2tN82xoa4ciMataLTEoi/uYjK2VB5iDHSDcdXNpOPqX1XNraA0woBc4zK0OUrztRiDmqq4Qa1BcjnrFWpY2QBqDUGxIbUs6JCA2OLHB3tzgCE/h006B2blxBy7DvNCA5k9hlKb0pC0iGWpTQbTguXu9LTAs2aFkUhIl59V6KAhnX3OhIltINWUEx/Qizit5jatBNsEGThpPy8RZwWqCkUFaCfJqTQl9s5Uy+9nkS+5wJylIFZDnq5f10Gt2gTOR0gtzQiMPTc4px+grYp3Ws3Dq5UZjByXIiOjnzJjTAAhwph3myEW5d79kNU9T4tcbqeZOvmkoiBRRAIuqeuez+l01mcAsiOSu64Mpp7mooY3dyB0OqDLT9cwTiy2fgny8JbHuToE08ltUQyq76hFI+6IRiD0ngXIHvfQqY6TE0mrQfwlzok1MUM5EnleCNyKMPEC7wd3ksCXRRmKNcaAHBPB7w3v0EGRhtOjEkMb0YNRpBEIxw3uppx2Rx/L+A6jekXmVYLlBRiGgFDZ0ifwrt8bPNG1Jj0KJchOIe1yVY5txMVNiGD+8jQiSDjgTqn3/ribo+kGscmEWnzBf/0kfMRXuf3LWHf6+EUJq3s23yPnuqKr+Uy6Rcy/riw4AXvYpx/CMOR1snCnJLr3PowCNbs1IBx/VTzoqkZO1w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(107886003)(2616005)(508600001)(6666004)(7696005)(7636003)(356005)(2906002)(186003)(54906003)(26005)(4326008)(36860700001)(426003)(336012)(1076003)(8676002)(47076005)(83380400001)(36756003)(82310400004)(9786002)(110136005)(70206006)(8936002)(70586007)(44832011)(5660300002)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:27:14.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bce116-08d1-4cc5-46a5-08d9eba5fa05
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6601
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Added zynqmp_devinfo structure to handle multiple driver instances
 when accessed by multiple devices.

Changes in v5:
- Resolved merge conflict
- Update kernel version for sysfs documentation

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

