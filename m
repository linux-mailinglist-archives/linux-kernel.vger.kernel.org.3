Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1052BE90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiERPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiERPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:04:33 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30117.outbound.protection.outlook.com [40.107.3.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35305047F;
        Wed, 18 May 2022 08:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCMrXzxp+kwtmpOQ/p2QtKifaJx8rnSGIPjUpGUslMZnssyyUWyku1Hs5y86lRYJjOfCNPk7pWCAU/Kt0Y59r7IeHq7QGmMsXAcJ2rPskTvb4xOQM9mIaectPKQY8XiFnNOFY62f9A4JI2Jzpu5yE+EzT/5tfFQM9YBnB0hJbABGk+PDOYKSccrZ8qTlDlfvAXv+I7PbYB6xRiyS5Ip4sj1+w4qgdgtGfj43GtMchy416pPiaZatod4lJRzGxm1cfVjmZ1AduRdDOH+fiNImVTLo/Y/VdKysus5Xg+TDtkEoLVHAmxPrD36I6ksYyaIVMnPO7L9so9nypXEUg9xlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaJ4PO7LNkAp+E2Y7VFlxT27frZ8yCb3+u/s7KTKLIk=;
 b=MH+5aMua1DbEDDqypCeG5oLjik2oHrCKzx980dDhenihrhGedxlECNJVn47e+ZRh2w92h8PnJxKDpbAnwC5UayQPPjtrldGuAVnDLWVpBEPOg+ypgWvgMyBan4g8J++g7ncVCa1/JDQOiAHe5Tr5rZeeRLBaAaC8PUdWGDryeSlqtELAH9Eb3suCHiQbunRS0085vLGut6HfEKYewiL0Rxrcc25F0bfhNV28vS4FNcj9ZfkYDKuoRHJ7HIq0cK7xco3XUI3nx1+cuxGA5QKPeAt/jPhLi/LlMHL+FdLia0+IuLzkIYxKhTrdQeqXamFN5lFJVeMcmY9jglGDZNy1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaJ4PO7LNkAp+E2Y7VFlxT27frZ8yCb3+u/s7KTKLIk=;
 b=NWx7d4aBBwDV9sUnicAqlr4oKCdstBt3LG90mlVfWfb/TvsI4g+XDlEFg8L67rTSOTM+ZMNVue2GknKDlwRibudo37oPUe6uxSErR48DC4QOU1u7h00FVgo3sBcCK/23hdK6pWMxNkEpX8pR96XgxcRFpvYJYGmqjsQHXNsrOMw=
Received: from AS8PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:20b:311::32)
 by AM6PR06MB5880.eurprd06.prod.outlook.com (2603:10a6:20b:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:04:28 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::3a) by AS8PR05CA0027.outlook.office365.com
 (2603:10a6:20b:311::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 15:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:28 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 0/6] iio: accel: bmi088: support BMI085 BMI090L
Date:   Wed, 18 May 2022 15:04:19 +0000
Message-Id: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8aad18ba-82d9-4e3f-4378-08da38dfb4b1
X-MS-TrafficTypeDiagnostic: AM6PR06MB5880:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5880C711F5F7C97BFDB6C524D7D19@AM6PR06MB5880.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmi5zFfmlh/RMUBysuzxy15iAvkLPDyCaBEgBZq76CrhhQcXBK/1S7vAPci7T1QsGCclsPW/Bu5vIYOSyasuRJhRG7AjPI5e9wFP5dVSP+iWWWhovjIZnF2vUCsVv+SSPiY/Sgk+dRAhW9I08TQHxsMO0mHc8itKno0Rr4fe+Cye5d0Qc6mO6pGB2fMRLyUwW08WYhlMfN4Ev0unG4VBr+disMRrp8QNqdoCg89iPYi7AN8AB+ISPF00lzXVkt77xknl/DFhxnURq0jYuYRms9BzaFY66hVdIGmpGXtLzQrIIMide5KJShQw6vNjds82Cp9MJPTlMNY39CBxph2eaBNvkgCWj28eKv6lgH49m0WL/zu8rql7Jjm65Qr3Jz1QsxUWuF2uQmuNOYDAs0t3o06R2TGRNo16kJDAE5Sc9FeJLKUcgWzNnd07Apn1EPLq2QuZDe/xB/wX2Q/dZwSW9uM3aU21buqMqwYzy4T87FZRiJ7K6tXw5T5SdaHPuAOPmft8a1LbU1sSal73Elp67J5h8M2sddBdkWQ7p6V6YziqQ5Sky5TE1FKElFVn5BtXp469z3eiOK9MV5MBnpEArCIBBAfx5rdW25VhrIcDGX8ISKfhDNNRPNvx0TI8QDoUvMFT9+ZIuWumxYfu6DRPebVfQCLHYDKWjDQEPJzOkQi6u0O04wiLj+pBGB9yt0gKMv0pI8AlNJ2GUEonXLWWlg==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6486002)(1076003)(40460700003)(186003)(2616005)(47076005)(5660300002)(8936002)(956004)(921005)(36860700001)(70206006)(70586007)(8676002)(118246002)(36756003)(6666004)(26005)(316002)(81166007)(356005)(508600001)(6506007)(6512007)(83380400001)(2906002)(336012)(86362001)(82310400005)(36736006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:28.3912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aad18ba-82d9-4e3f-4378-08da38dfb4b1
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the units after application of scale from 100*m/s^2 to m/s^2,
since the units in the ABI documents are m/s^2.
Add supports for the BMI085 accelerometer.
Add supports for the BMI090L accelerometer.
Make it possible to config scales.

Change in V3: 

Use FIELD_GET for checking register range. Reorder the chip info and 
dt-bindings alphabetical. Add of_id_table. Modify the logic of loading
sensor chip info. If the device was found in the table but the device 
tree binding is different, the driver will carry on with the detected
chip with a warning. If no matching device was found, the driver load
the binding chip.


LI Qingwu (6):
  iio: accel: bmi088: Modified the scale calculate
  iio: accel: bmi088: Make it possible to config scales
  iio: accel: bmi088: modified the device name
  iio: accel: bmi088: Add support for bmi085 accel
  iio: accel: bmi088: Add support for bmi090l accel
  dt-bindings: iio: accel: Add bmi085 and bmi090l bindings

 .../bindings/iio/accel/bosch,bmi088.yaml      |  2 +
 drivers/iio/accel/bmi088-accel-core.c         | 96 +++++++++++++++----
 drivers/iio/accel/bmi088-accel-spi.c          | 17 +++-
 drivers/iio/accel/bmi088-accel.h              |  9 +-
 4 files changed, 100 insertions(+), 24 deletions(-)

-- 
2.25.1

