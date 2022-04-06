Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1754F6039
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiDFNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiDFNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:45:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7910D59F244
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKw643XV2vyJQtrS/q1i7flNjGPjlxj0NCJUr/GQQsgSGHBcRCJ5UB7qv8d/dyOOMahDGmAd2ZZI14FPyuD62Fq7SXTMNT0/B3P7SH6hFKCPqqB7nyw7ZsjYkc1yd1gqvZl7KUmLXuQgnzeVgKl5RKMzN3ErmfE49rIUEaSiIMOQl501tf+ZEjpXFLl3tChaq+5WVWiJqPU1OT7AgwO05u+er+R8m93Gsfd3SqgXNdgwNoWNJqZ90Nt/OSO7zpnPVLgr7d3GF2027LVPQC08e0OWzwgbfZF4TLivKtck9wbV1HWxsAaCfJmyxyiQAwsL5YdV9hkCG6n3VFFgekPkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDv4F+Wf/Fw6W5AJRy8ilGj37oOOG5zK0eqpMnF/tnc=;
 b=FOHDhsjQ+KapkhJb9z7VQoaW1tOcqVx5OlKTaK8i6VJPZBJyFOwfKyJmOD9+40z+RwtT+an50JacZO+uabTBO6rU4QlTiK+MZkbN821fpbIg3AjTF5PZQvbjHOoa/vLrFPycXC6evUaP3vPiujnHr88TO8WGTTcG525Lgn7Rs0eEqOBcT21Rdf24V7Zdo+NM3i9LWeOQWrPfo84eJ9ipNnw3xah9OIlw9MU3IqlqVPJPPTBVnhLrL4LgVnM6IYzSIqVw/THZGlkpLn9sYjECH8i5XzPr9J9FM9GWQm3B4QJyn+3iwaH8gtlAZU1i9xveXX7vxrUGhM2f4qIueQ+Btw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDv4F+Wf/Fw6W5AJRy8ilGj37oOOG5zK0eqpMnF/tnc=;
 b=qyksWsjzkV9406WRoz3u8ZRRwEcExbaN1+AwGcT+2EQu0yg9o0X7uIqVkhFj75crSByM7ZnJWNm4PlRBwF31IhqLgNBTVxA9IDLmWGY7fgsN15B4/8GFg9e+zzCBpzWw+c3Z5jjfH+BenQM21MkRDL/Dnzqs1XHug+JHbIJJeL4=
Received: from SN4PR0501CA0132.namprd05.prod.outlook.com
 (2603:10b6:803:42::49) by SA1PR02MB8350.namprd02.prod.outlook.com
 (2603:10b6:806:1e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:33 +0000
Received: from SN1NAM02FT0031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::f3) by SN4PR0501CA0132.outlook.office365.com
 (2603:10b6:803:42::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 10:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0031.mail.protection.outlook.com (10.97.4.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Wed, 6 Apr 2022 10:55:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Apr 2022 03:55:33 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Apr 2022 03:55:33 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.243] (port=36060 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nc3K1-0007fI-El; Wed, 06 Apr 2022 03:55:33 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 0/4] Add feature check support in ZU+
Date:   Wed, 6 Apr 2022 03:55:22 -0700
Message-ID: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce29a49-8c52-4770-5ee0-08da17bbf97d
X-MS-TrafficTypeDiagnostic: SA1PR02MB8350:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB8350B50E268656FF7F5A8F10A4E79@SA1PR02MB8350.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXgGtahMYMXkgleKbFT8ANlGptFxxZwAOLcAUSqFirA+psJ88AfMPsBfmRaWK8EqWJl7unoJ7bMqagss+w4OL0CpsnwE6T2ZSvr5J7nazj+djkWYVuLXNyZEd6b6kHd7XnPmDwYAT9i0zOrGXbis1TNFY7QNRnTtNBtH9716NDF5uGFRPzEidK7j2QW+/+/TeLMuQIKI6vlxvlWpCtlDIM/KGyGMCxQD9hzGYMPCTS2Tv9iIWleFUsEwPJnND0E+zLFDbNl9duQfL5R2ZWTGVGDE3LH9PNtVjHRtRWj5bS211tXKouabGua7Di1KMGqzrNSvzDWYsG82QV+WJ/BUnfMgWcHrCoTK9uC2xRsbt9e7ZTpLVFBFSRHlF4LC7kB9zQ4GIqXUHKndVM6cqVL205DS0M4vBlgRUBOWxFVhQuW8R7kahdmLSDjs/l2Va3C8X/WvaY0ho+3X/hmJNyNiZlSdT4sQrOV9HsEXYXeZsK8Y8il28y5OqMbFrn0vFEmeZ4ARQQxvqIzx75zvq28wkXsvRzC/RyCOg0/1sqKf/rcxMbT1KbGlchLvPXeQQgEJ5W/95YEF66VRlJo3itTSLM0KL3FvxSFF0Ygeu0cGQhE33gYohIET0/LNDp1o6o06OJxDZmf/8Xlzc1GHuLzAxnV/tyGucOzPykzW07ts7IkjIypmK+zCa3hVAimItVxDfKdBsIrkeXHFb241sAr5HQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(316002)(7696005)(356005)(6666004)(110136005)(36860700001)(36756003)(47076005)(4326008)(70586007)(8676002)(70206006)(83380400001)(5660300002)(40460700003)(82310400005)(44832011)(54906003)(107886003)(2616005)(4744005)(7636003)(186003)(508600001)(336012)(26005)(8936002)(426003)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 10:55:33.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce29a49-8c52-4770-5ee0-08da17bbf97d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8350
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add feature check PM API support for QUERY/IOCTL IDs to get individual
ids version from the firmware/TF-A if supported and return an error
code if the PM API or the QUERY/IOCTL IDs are not supported.

Enable feature check for each PM APIs before executing the
functionality. 

Ronak Jain (4):
  firmware: xilinx: add support for IOCTL and QUERY ID feature check
  firmware: xilinx: add new function for do_feature_check_call
  firmware: xilinx: always check API version for IOCTL/QUERY
  firmware: xilinx: enable feature check for ZynqMP

 drivers/firmware/xilinx/zynqmp.c     | 131 +++++++++++++++++++++++++++++------
 include/linux/firmware/xlnx-zynqmp.h |  11 +++
 2 files changed, 119 insertions(+), 23 deletions(-)

-- 
2.7.4

