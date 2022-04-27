Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B85112D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbiD0Hvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359053AbiD0Hv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:51:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD511C980
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk5JbBgCzboLlDUhmw5HiONvYDs+UmptmceuMqUAH9x4tQ8TL19pGVCZitUYUM2DxCVYa30H5YWLnBhjtBbN+iqDiUaOtbWV2aa00BllRXrY0dF2FP+2QaGfUqqscor5dLBsLiTg8sXeEAtlU3tXl1LF9lGW9yEJI7S6W3N5IIzsq/mrShIzy7uE2BBkHuCHaGp7+KZwPL4VSEFgY5gzRPXC/zcgc6FW9DBAdprfD0o0rzHxuLm6v5CD/VZIpkSzuxqfcFQ7pH+2n+rL5BkSucDuQN2NeRpAfzz36nK6GFSAnF2W+hPgLjat2b3qz0QWdAkR6SNCNExtnQS5nmzmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJil1CfYjKTjpwHeplxm507Szzux+xUOIWIKikHl/a4=;
 b=B3L0piC1M7A4xBJUlWZ9EJ4ALsZUkyl9ZdZ7wHtNdcbwNzfz5i71LK1wOiV2kTpe60Jfzcww3rYUVWhJxrySWMLXuGfiUXWw1qE65OU7k6cxNbjlGrY5DhjBPT8ZKlIiWNZ8ZxSwyN/ZQqyU37rMYmRp/kay2LyArly8UiKePSWPq4VZxasoHg/jaEW8EiCGGaBNSko5+0FZvgWVvUsc0A/1x7h+Ga5ianl5vKkDR8MCJdfZeXffyDZJdxghaMidGRmR1j/NHsUYq1cTWGZury69g10vHKfh4WtBwJb9hn/h9PTTVytyuLNYmXQTbK+GEEVkq0K1MZqyNkiW0focZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJil1CfYjKTjpwHeplxm507Szzux+xUOIWIKikHl/a4=;
 b=X6/X3dAFyStVobQD7PrGukLrSuw6cp9MeHJ/z588nfKAkxqpa5rXJFU/7dwTC0IsoXnleNM6aB4hrJ5/nOII/b/XnhOLjxg/wP0hCUh53fPjF6gRTn+LbZ3nDZhfnRBVS+xdV4TvV2b0O5ms2VVAmRwL+oBpKp+vVV09oLKoiaA=
Received: from DM6PR01CA0007.prod.exchangelabs.com (2603:10b6:5:296::12) by
 PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Wed, 27 Apr 2022 07:48:14 +0000
Received: from DM3NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::5) by DM6PR01CA0007.outlook.office365.com
 (2603:10b6:5:296::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 07:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT005.mail.protection.outlook.com (10.13.5.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 07:48:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Apr 2022 00:48:04 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 27 Apr 2022 00:48:04 -0700
Envelope-to: gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=54884 helo=xsjpmteam52.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1njcP6-0002bP-Jd; Wed, 27 Apr 2022 00:48:04 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] Add multiple callbacks support for same event
Date:   Wed, 27 Apr 2022 00:48:01 -0700
Message-ID: <20220427074803.19009-1-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0c6610-58f5-453b-1c69-08da282248f5
X-MS-TrafficTypeDiagnostic: PH0PR02MB7542:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB75421E4C5D3CBE2CDCB5821AA1FA9@PH0PR02MB7542.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1miq+t+ifQOn0xlE7+QTHZVxNqkh37UxyrCFKzH8LnDVKYZIZfbvmk1e1YEGBzsu6dAOa08LUo5Hn0iVlpttd3ialkLpC1FlujCQA8oPgbkNa8oAOfU2+HwwTgrL3JSk5Ye8ShyYC5vJyhPT9BDhgOiLGAK01ckTPoD/vZmJQe4Q8qwg41ISBNJPfAlz+bDDOwTTQtmcKDcDBKb1I6TJerqUM2Gx2GNmOVkNG6IgCGRmI25wHjkxpvhXlRD5heyjmJi6fTK42LEWHq2Cck9v8ti7hhCY81ziVQQEmWgEoYYsCCUhdAtJ+TLrbAZnMSX+q2EXQj3i/cdF7fsts8A/kLQHxY6XLOmNDVWNu0C87k64bBRbuUeX64lP1M44zomxA1U+bWgmTHsitQ7t3lnLAOko6KC0wB6Ceh1cqgK+cctwnLfOPaCzClNsaKMUJ4C6Lk1/h4KLdAcFHkvxMKd6ENWxfd6qC0DvwWhg3IoQBFxJVbZKoc43dv9CXv/YWfU8DG3g8bGTL06UjV4yc3+hjsCWfDFVyQkKvm6l6lThBqqrkj8E43qX8k3bpvgcOUMIVdYUhHA2rXFYCuQT2+5XdOobIqyGh7YI4MQdchHW49OlwJZYs7Tkp9lj0AxEqH9SS8NPQCCOesHNaVJdOD6QeYf6G1nwmd8M+3V2sEoY5itEEaMBC9BCYBn8B5It7D9EBfL62IgGlsR7PYBmSJ3VNA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(4744005)(316002)(9786002)(356005)(70206006)(8676002)(6666004)(83380400001)(2906002)(47076005)(336012)(426003)(2616005)(40460700003)(4326008)(8936002)(44832011)(7636003)(70586007)(1076003)(26005)(186003)(7696005)(6916009)(54906003)(508600001)(36860700001)(36756003)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 07:48:14.3431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0c6610-58f5-453b-1c69-08da282248f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contain the changes for adding multiple callbacks support
for same event in xilinx event management driver.
As part of adding this support included changes in prototype of exported
function  xlnx_unregister_event().

Also modify the usage of xlnx_unregister_event() in below listed drivers as
per new implementation.
- drivers/soc/xilinx/zynqmp_power.c

Abhyuday Godhasara (2):
  driver: soc: xilinx: Add support of multiple callbacks for same event
    in event management driver
  driver: soc: xilinx: Update function prototype for
    xlnx_unregister_event

 drivers/soc/xilinx/xlnx_event_manager.c     | 203 +++++++++++++++-----
 drivers/soc/xilinx/zynqmp_power.c           |   7 +-
 include/linux/firmware/xlnx-event-manager.h |   4 +-
 3 files changed, 159 insertions(+), 55 deletions(-)

-- 
2.32.0.93.g670b81a

