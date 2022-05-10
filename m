Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6995D521D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiEJO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2119.outbound.protection.outlook.com [40.107.21.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A173579;
        Tue, 10 May 2022 07:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOZqnZsIlBZk526ytQmQ1X6oYzHRExxrB2LjM2hqv9UB5eYXZxFqRcIeVtkv8r8vKr8Cr+bgQJm1zEqhZpSTw3yDJd7YR7eRVS9AhIsns4PrgX7lbZjlThF9M7xqMv+IwMY3y+bQefQK4Bu1lZr0jVDm0c/Uk6pv6SxNx0qpWM7xGR9p0sehYEbh2Y9tH4Rste08I3RMLAz5ZP7NcxkQJ1zB3DL8RuFPCSD7SsGTvMyPyugyLOlZ+RubVqmZHB0O5a5P4q9MbMVyAz1Z9PmovWboXsASh6tjrkzdNAh2xSfeT0CkOKx7itGkgRiNxo+CewjtnZzxreUY0pPOaeE3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+2ULbZ/EXpSKqXs9MOQXRrz1Twfyc3d21qt4sOzYKY=;
 b=RWFc2oICLeDm2kLaQ5St1ijaNcC+bCr2Ww0WG9o/RZsK1KroQUeoFEDzgGMz89rH0y3RdprwzddyUHeTxZhp113d9M7stWB03qwf5WvwLY93zK4qJOsaBwcIdy4vxs9fF7dOJpakCbZAenR2C6M+d5L1h8lsRbOhoDQ4pEl2JjnTS0fsDF4slW5/nqyDPywAqzpS0OfYnb/0b8sdr0cUiz20Xj0d7BPkGHTUOGgDmu1NSbZXaYdWme4mvhiWADCmBuyeIvxsQba9beRVwGiuCZ6V84/ffw/Ykpi7Ois2xkH9LUgXjbhHkMz8gD39OthQ4EKwwD6W4l4NruzZfevpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+2ULbZ/EXpSKqXs9MOQXRrz1Twfyc3d21qt4sOzYKY=;
 b=X+Rd6UOUiQAwRBX/itpBCXAOEIbFAfOuXlbjaD9Irj/VOM3iiVrEfQyI2+8gG/KBut5Ie9q8aqwX4wjC4OgipbsxnWP2HEBNIR71MFJzaCm4MZpXujU7ZQWpwWYDXdMl3N+NWo7xcU64BVs5NzyCwLePvJPo/OPZLd3bZWdb2tI=
Received: from AS9PR06CA0358.eurprd06.prod.outlook.com (2603:10a6:20b:466::20)
 by AM6PR0602MB3624.eurprd06.prod.outlook.com (2603:10a6:209:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 14:17:56 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::77) by AS9PR06CA0358.outlook.office365.com
 (2603:10a6:20b:466::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 14:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:55 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 0/6] iio: accel: bmi088: support BMI085 BMI090L
Date:   Tue, 10 May 2022 14:17:47 +0000
Message-Id: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6af6ba0-05a2-4d53-8c7a-08da328fe0c7
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3624:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0602MB362407874E0B2314D6A55AD5D7C99@AM6PR0602MB3624.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9ECuxIBfv9dw2mgXMjp/tof4Ln00Prz4Zw4He3rm1Ko//D2Plh0Di1ZWfRV6QZ2L7Rl7BI9LkhCAOslrcOVp8obyTLcfFvkPHs0sVZo+eZrZWPPTIfhpIyeN3dG4Vq7AEVbbDFrFhz0ji4pSK8UnQgGfIi4Kg4sQAcvj13N3NWx7oZE0pcJiLTzBPvt626bXkibNk95YXLA6oYM7TleroPEp9nkm+nhsVcOUVjVf6nwcKQLXxfsa6Edv/TUMrPrq9q+vJfhwrXeMCt31AbQ06walgLOJuuFvdXilG12HTm347zag/kNmNqhEAeoTom8drnY9qAyxtJlNnwkFU2vbNIyZUAhEwxF9MdyFYDl839AL+34dSt8dOpDPstLt5cSxtUopbbc7lPdfGbQSU3R4KR6tAn4CRUi1BufiwqEZKVAu7hsw960HHyG5axKfZQXodcvKjSLTdEa6mnUMUZ0WIRSND+wjyt+4Qjqea/PozXqji9NbOFH2+aJQLH+9CpH+Oc0VQeHxPwZwwy9fLInhLJnH2E9mxkcEzJZC3yq9x0BgEmI6Qdk8Ph5fX6+Xm82x90DFHCviRaGDF6e8sbgLFflx2392xHZX67X2OxewuD6XML19Z7oRfTfUeC2SfyeCtwBGLBgmLPa3onbl9/7bwcmQJOrZ85gjrcUt/vR51F9smqH2/SFiGCK0jZgtEUjRdVQJ8ZoQp/1O3k5Y1FE+w==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(118246002)(186003)(83380400001)(36860700001)(2616005)(26005)(2906002)(1076003)(6512007)(956004)(36756003)(336012)(47076005)(40460700003)(82310400005)(6486002)(8936002)(508600001)(921005)(86362001)(5660300002)(70206006)(70586007)(8676002)(81166007)(6506007)(316002)(36736006)(356005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:55.6889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af6ba0-05a2-4d53-8c7a-08da328fe0c7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Change in V2:

Use the correct bits only for `reg` to make sure it is in the correct range.
Remove the unused 'name' parameter.
Modified the compatible string for bmi088 and bmi090l in and binding document.
Reorder the commits.


LI Qingwu (6):
  iio: accel: bmi088: Modified the scale calculate
  iio: accel: bmi088: Make it possible to config scales
  iio: accel: bmi088: modified the device name
  iio: accel: bmi088: Add support for bmi085 accel
  iio: accel: bmi088: Add support for bmi090l accel
  dt-bindings: iio: accel: Add bmi085 and bmi090l bindings

 .../bindings/iio/accel/bosch,bmi088.yaml      |  2 +
 drivers/iio/accel/bmi088-accel-core.c         | 64 ++++++++++++++++---
 drivers/iio/accel/bmi088-accel-spi.c          |  6 +-
 drivers/iio/accel/bmi088-accel.h              |  2 +-
 4 files changed, 61 insertions(+), 13 deletions(-)

-- 
2.25.1

