Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7A4FB8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiDKKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiDKKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C8DFC4;
        Mon, 11 Apr 2022 03:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmqEoHMwpyrbBWaTysXyvNzi7LNIpJaCjwA/P8dOPpXBj7a72K5Ws4zk79u3eGSVOhmBx2DjrhYAsMqe9bYre+r76Re4W49SSZ+tZ1xDI9rtSoAfB09myiJwrdqpzsHKGZa8c95ceIaT13SlCAX3B2mWwPmt0JxlY6Daju0gGV6OBXKYVHYtDJbbIuNOWGSryNao8UmHZFx2i+aFMfOnKOZZFNv2eOS+ZTaM/XGpU0Gz5YgLevorrG9MI5w/z+zefBsyt8JSsCJoz3sjb14lhwjq/spoY+jrZ0qfWUW6Q9PbqXNIjPCmRwtyNkJleKMtxABqmUb6Bl8sFlBiRLMuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZH9EjQZ5GN6hbPZmjp5OChiVOBI3X8HcD7j/Ct7i8c=;
 b=iAkAH00nhl9dOrnsR8cdjyq4knTtM9X0HPB7tw0CusqC39xsGHmEY8wW4Pg9zRG+2WhreZDPIVRbuXQL8XHC4SX9+qfkDMZR9v8juPsWyIahlKFjmjT9Eg51YMwdPeD5kfnM/k3WCd2zpLQ4d3M1BUbUV308EaZD44qYFZ4e2UVfJHM5X4z3EDxw5mYEiDjYO+lpQOVAb/d/8VYLjcG75t14H6wm8AvHcZUHUCSdO1KuUy9L4dVoKHsMZ13BqK7bLgtLz7MSKNOmYCSLCbP9ebipLvKj0RJ1tR2rC2UKGFTlpUYBvvonFIgv4xLQaV/6FbqG6d2eGzUxfPmKxJv/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZH9EjQZ5GN6hbPZmjp5OChiVOBI3X8HcD7j/Ct7i8c=;
 b=NlFAAePYgBfz1x/r5ci2mKDY37Fkp3ucSlWgxhDpt3kcDxZW1URV02Hgfo/Tn+/pMOs5feclQXvkhZMt7o7KATL6lY8auUWzUS7vPnZhqhGK3MOexwbaZnUx5b+TJ0Aa2qARyEcLLxAHlqC6yglhFKnwQwGYwU7Qgjy6g0t80G0=
Received: from BN9PR03CA0550.namprd03.prod.outlook.com (2603:10b6:408:138::15)
 by DM6PR02MB6698.namprd02.prod.outlook.com (2603:10b6:5:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:04:50 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::49) by BN9PR03CA0550.outlook.office365.com
 (2603:10b6:408:138::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 10:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:04:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:04:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:04:47 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndquc-0003Jf-NX; Mon, 11 Apr 2022 03:04:47 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 0/5] clk: clocking-wizard: Driver updates
Date:   Mon, 11 Apr 2022 15:34:38 +0530
Message-ID: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c39987-c149-4068-c782-08da1ba2b795
X-MS-TrafficTypeDiagnostic: DM6PR02MB6698:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB669855A6364780F6E4D626F5AAEA9@DM6PR02MB6698.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvAVYZmXjpMNiIPbBtAfAbLYPhTupUJKhzgM4Kj7rV7nRf0QlxKG5mPivjRcacmPgIVyZPi6kEglFaX4mr+vonfJjtVDEZIt6S+KGpeA4SOG/Jyh7QEvGfQskVSb+ma0DlvDY2WBh+adGaYn2TX9t6Gv6dJddXn0JPVCKgfHR5dqzwlMi356oT6v1XRiNKtfmv7XoDCWVhTvHu2l8Qz7Bda2JI/gLbHXZkiG7SEXXmLQFE9fgRxcCZ65tUr/f7etc48Fqps40O9/+cCJgeKY0Svsqb8ZE7NZOlLl0AkuGdjXublCv20lOf0vxribDvT9nc72p4E7prL/Py3wZ+r5IOesxeOkCf7cogYSNyqHnOyCaQO2JcCfVa71XEQ5o6ea+/RsHrtevi4B9EInzz3F29lgOhgynIxGxK2wz2BxrX7LpsxdEaVNjYkC2K4g+r+jmskVUyrTKlcbX3sUn6407x1QVhHifDqGeg13JfXTUkY9CBfd0cZy+HsHU+tWmgMtADbkw8/+8JQF1Mt1Ckax566/gx3Vh/xl036ilPs7QF96V/tpCIEfe7ehUxSTmxjbHqkw1gHPTX4VaNhu4L7ghlD6JknLt47gRIc1cOPz8skEbfpYhYwx7dnq0SuYKBJ4uQVqjIASBMnddo9Iwwxh2Z4ex5KcMzVE40hoFYWqLKWNzzxMfaZl9bL49j/wy5Abbt2aKMc2Du/6Xf5hjAYU9g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(8676002)(107886003)(2616005)(4326008)(6916009)(54906003)(9786002)(508600001)(70206006)(316002)(70586007)(426003)(44832011)(6666004)(356005)(7636003)(7696005)(83380400001)(8936002)(15650500001)(2906002)(40460700003)(36756003)(36860700001)(186003)(82310400005)(26005)(47076005)(5660300002)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:04:50.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c39987-c149-4068-c782-08da1ba2b795
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6698
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch does the following
Update the versions of the clocking wizard ip.
Move from staging to clk directory.
Update the bindings.

v12: 
No change. 
Rebased
v13:
Update the clocking compatible
Add the change removing the driver from staging
v14:
Moved to the xilinx folder

Shubhrajyoti Datta (5):
  dt-bindings: add documentation of xilinx clocking wizard
  clk: clocking-wizard: Add the clockwizard to clk directory
  clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
  clk: clocking-wizard: Fix the reconfig for 5.2
  clk: clocking-wizard: Update the compatible

 .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
 drivers/clk/xilinx/Kconfig                    | 11 +++
 drivers/clk/xilinx/Makefile                   |  1 +
 .../xilinx}/clk-xlnx-clock-wizard.c           | 19 +++--
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 drivers/staging/clocking-wizard/Kconfig       | 10 ---
 drivers/staging/clocking-wizard/Makefile      |  2 -
 drivers/staging/clocking-wizard/TODO          | 13 ----
 .../staging/clocking-wizard/dt-binding.txt    | 30 --------
 10 files changed, 103 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
 rename drivers/{staging/clocking-wizard => clk/xilinx}/clk-xlnx-clock-wizard.c (96%)
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

-- 
2.17.1

