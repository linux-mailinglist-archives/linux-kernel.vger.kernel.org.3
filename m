Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2455C30E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiF0Gkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiF0Gkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:40:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EFB2BFE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGL0zgQrFLr+Z+1jFgm5yhh0iFFfzPa1mHydAm0SSwtmYhu7N7a9eYuz3JKcQ//D7gVwsXtLxtgQyY3eLAa8x8EgXr88MpGbzHx/zy4vqLZYP4gj1isIMy94oYKaQf+n4Q4hBTobzCSxgkpAQ3LpJZwKr6sfcZWJRKrr6bVzuExSiAL4aWDsd9TcxAP/Ybrhnq5KF0k64ybDpRIPS7aI9S4KiNrOnkSoGMH9/CeXNP4Sc9m7qf0WwAV6pf7MuRUIrmig6p5YlC6p0203K36FxVNRurYDCNmROmIj3Oo2wABlXBxchZS3/cH1NiT4gWwnBHm6QQ8dERmBvdIYI/uVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBi8kkmp3h5AaS4co5lPYL1+k03FcMbR9k9RmHDNaqU=;
 b=hLS491T6oe48dZvNV2D77mSn/8hLF9RocLvUnb+mPCaYNoQM+ydN0Vp5+RFVsIJgLKFUiti+ioMeFR3/w5YC4nos/DYPOAWGOHYkSXFqRvV1qldaX2R3L+Yn2upI45AdYx8Vl+gZbsiA67RML8v9EoqTBm5ZXnIpmXJ7aTycwps1rzicpWXCaOi3Yk4v22jO7MT2+iXsPmGHv+4o67H2N8IhweeORrMMKVD7domeEF1G41qGn9c/1tsC8Dn+MjybE6qz3pkmCu1I9RNdl6W8akDkNzLy5HjHUnoC4gc+oeHUAQex7aglOWyjOErvPBIXzwK1fbDJdl02SS3707QH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=monstr.eu smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBi8kkmp3h5AaS4co5lPYL1+k03FcMbR9k9RmHDNaqU=;
 b=LX1GGNpMMZVAOrrfQPaAYnPL+HMsn7fULw8o5vH9pg5+puMSV4cEMGkcjMN0SLoB6H0TVf8oKOZ/RxOkoEk/1a/xnVJMl57ZDUdIByaBG+ew8PtehrPNgBm/ev29+ZQYCbYmAHiw01QeM4jzeK57SX+5Z8qw+OBjUR3pUlrzr08=
Received: from SN4PR0501CA0153.namprd05.prod.outlook.com
 (2603:10b6:803:2c::31) by SJ0PR02MB7199.namprd02.prod.outlook.com
 (2603:10b6:a03:294::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 06:40:42 +0000
Received: from SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::31) by SN4PR0501CA0153.outlook.office365.com
 (2603:10b6:803:2c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Mon, 27 Jun 2022 06:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0035.mail.protection.outlook.com (10.97.4.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 06:40:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 23:40:29 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 23:40:29 -0700
Envelope-to: monstr@monstr.eu,
 arnd@arndb.de,
 shorne@gmail.com,
 ebiederm@xmission.com,
 appanad@amd.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sam@ravnborg.org
Received: from [10.140.6.6] (port=50182 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o5iQ9-000Bsc-4X; Sun, 26 Jun 2022 23:40:29 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <monstr@monstr.eu>, <arnd@arndb.de>, <shorne@gmail.com>,
        <ebiederm@xmission.com>, <appanad@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sam@ravnborg.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 0/3] microblaze: Add support for TMR Subsystem 
Date:   Mon, 27 Jun 2022 12:10:21 +0530
Message-ID: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7095ffd3-79bc-4f0e-ba2a-08da5807f506
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7199:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QldNql9qrIAPLcwJTb8HACij4ZQx0QpO9gZh+JY5hU5HUBlWd6V3giRDiAE6/Qk0IlDLU/LzbEC9eNkd+apJt9mNbm96EeP5gIrRK8SagdMVT06dBtVe6295y/zoZ1pDG62OkuUhygxOo/XON5gz5L96WpWV/V2oy4dQdy4BzpKKXKjswGJvk6saW5WLjZ8IaOs2CopY0CnENOYhWvXoBaKuJTA0haEV3EhQ8zU3pZQU/npK44V2uSKCQ2r3/moN928nNaP1x8g2HYY8dOThLGA6e+B48xsz3t9FTVvrlS3KFpeeoBfNqhqjXR4SzJkafUJ93OnYc5FNTUAVY1VrP7VVRdLnWHWk9SDiJLEZjsY/AaADqyetdaeANuNuc3Uy6njQa1iCxMBGE8goHXzEVPGadfCWU4EoytwsnbbpCu/QFjSw58Cza56K7kZxawIqCW8W4ofvsMVWfHkMi7eiLhP7A9a4gmKTvZllhDBTsfO57nx5996pGWjPWPNV+eNtnIqsmV6KHSXc95ypl1yP38l1mjO8mSsy0+7X771h5O/ciTmmcyfxJc8lJaOC5Nwos8wDuWDrb2Is1yolPfJN5PU9WH4TGYjnwl0KLP60BCUYcHu42XmLMRHhlq5Xc9iwE0nKFYZQnL/9HNF+QfRvPz0vUomA9QbGZOd3bQZrvIDHQ8BMzZW92lv8mq345D2+xFJyhwG5HMoDTUI/b6Y1cgxHbA/V3blod3PRrMN94EMdEyYJr32pi7nYOIVb8utGEOyXf2/Bv/aWW0bb9az9dDqu2a3/l6ubjPogf0OkQTUy9ys0YzIkm0533YkkiTeWjm1inFI4AckfNLhuEcWQWxJvxrFH5ht4i4cV2CCAlyQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(110136005)(40480700001)(316002)(426003)(70206006)(47076005)(54906003)(107886003)(2906002)(2616005)(1076003)(336012)(103116003)(186003)(41300700001)(26005)(4743002)(82740400003)(7696005)(6666004)(356005)(966005)(8676002)(9786002)(82310400005)(5660300002)(36860700001)(4326008)(83380400001)(40460700003)(7636003)(478600001)(36756003)(70586007)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 06:40:42.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7095ffd3-79bc-4f0e-ba2a-08da5807f506
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7199
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Triple Modular Redundancy Subsystem,
Triple Modular Redundancy (TMR) Microblaze solution provides soft error
detection, correction and recovery for Microblaze cores in the system.
The Xilinx/AMD Triple Modular Redundancy (TMR) solution in Vivado provides
all the necessary building blocks to implement a redundant triplicated
MicroBlaze subsystem. This processing subsystem is fault-tolerant and
continues to operate nominally after encountering an error. Together
with the capability to detect and recover from errors, the implementation
ensures the reliability of the entire subsystem, for more details about
IP please refer PG268[1].

[1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268

Appana Durga Kedareswara rao (3):
  microblaze: Add xmb_manager_register function
  microblaze: Add custom break vector handler for mb manager
  microblaze: Add support for error injection

 arch/microblaze/Kconfig                       |  10 +
 .../include/asm/xilinx_mb_manager.h           |  29 ++
 arch/microblaze/kernel/asm-offsets.c          |   7 +
 arch/microblaze/kernel/entry.S                | 302 +++++++++++++++++-
 4 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 arch/microblaze/include/asm/xilinx_mb_manager.h

-- 
2.25.1

