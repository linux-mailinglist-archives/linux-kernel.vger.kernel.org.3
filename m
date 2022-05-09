Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201651F526
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiEIHG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20117.outbound.protection.outlook.com [40.107.2.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E09219CEE3;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXhaIVYyg7tB8aaWIIQUNdWI+C8tog7n4OlX7sTBD2zHh8A/gFnJRJ2XFN0AQIbHGJG+3tqv8twrB3bx3uGZQ909VD6fvVjmZjfIqoagBIzQgvgLOjGU6Nieq5hLUNnTPAZtQov4BrOASMXEopvxk5DjT+40vhS1JR6QJIFHj1PyjfNhKxJQmC+y83iOlQtyxz2NCr4di6UKoZ4AYs0F9tadijnlg8OX/Ui7sez7l6AqPHb7TE1/sq32K/gj58DmZ3j4M5+2c5v2cMHdRxXiHLcI57AH8MVbm5lWWxD3dWtGOkcnZJHpE5f/7VhL2zydZYQTc11KOjvkC31pg2mLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agyhtMiz6pGgVSs+DDIfCYIezH5jZ4VfydVtEofOyfY=;
 b=nNmtXxPvc0SIA+iOI2bZnKuR6Hr2zR6oWqO9SBjsb0+nvqi8dfnVxs7oSjXOb2Yfk+dQ3fV9FL4hjoYPKCcbdylVRE62guwO57bxs0Kdd3eb3RJH5XjaVDLBBeK35KrL+CdgreIF1otxwBLk4nqg41f/GvbCis5uxO4dmwvue/IOAJ9jVMZhKE4Xgrf7XTjF5uaOEeu2u4/r6ifbh+BO8yg9cyV2+nKui8LmGIlNpbERh5DRdmlmDnzQPyKgfTPIM95ex6CpBMkB++5WQXXUHAx7USPy3+JvULjtbJTKsQ5cEdo8/M/2I6+0986iVuaCBY2jBzwzgnYFsSlY7gJADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agyhtMiz6pGgVSs+DDIfCYIezH5jZ4VfydVtEofOyfY=;
 b=wUbOa58dV2gq5aoCuoH5zTzOjrwp9PP4dZtV4iXWi9LxFstqurJpUeILFMhw9Azn3Xgzs2ZE5RIWsDsX6hwS+hTw66p1jmfahSLwXwwxxYlLHZvs93uD2yOiP9yg2BIBUrDchdDwTo5KCaqA5mwT1rFDSrJJ5yhgyBupWTUMtCw=
Received: from BE0P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::28) by
 DB7PR06MB5052.eurprd06.prod.outlook.com (2603:10a6:10:6d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Mon, 9 May 2022 06:49:32 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::a3) by BE0P281CA0018.outlook.office365.com
 (2603:10a6:b10:a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:31 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH V4 0/5] iio: accel: sca3300: add compatible for scl3300 
Date:   Mon,  9 May 2022 06:49:23 +0000
Message-Id: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 851b3df4-414e-4f43-22fb-08da3188122a
X-MS-TrafficTypeDiagnostic: DB7PR06MB5052:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB505285BC7762F7C462813FF4D7C69@DB7PR06MB5052.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bcu9koBrN+3rUXzAWfX/PUZ4ejOui9BKi4st2RLDz3vP2itplYxJCh4Dx11lpz4l/eFtuAKOeaZdJ8y2SThIwFF/w1kkyElDlmd6C7MK5RQqiZiAnacPeyaHPybk+gnROF6HtTL992ejmKlB9cpSNHMRYPQStaY2K4EoTQkyFqEkFbRUfmmUGUWRbUyVeAmF7N05UBWTgG9zK5w5v5+/mG2AmYd01Yr9nvh2jW7Btnq5KWnhG6WWLiOaJp0WLqfV0P936oauXx8RkSdNF6q5SdbIdm+EvvJotNpQ2NSdtrXiXw4hHu8689eRyqQ5B3KPKDNYUQ4r5qDVBhtVKXLYt6NlN6B0K2efXnwqnvHgCpCOG2X4MThv/0XrGZpPELK05coNhHqPSC5UjCKscHgu1ZN1GfP0a6UF2vZY7BQdv2KhbLOGPgPgV+m2mbDk+z6PDzNINB1p/cCVhcFZo29P0LWI0iQZT4YP/wdHi50183mgZNwrKrYZ5oFhgDptGfIpNIBH93wbYoBb5D3PweMMaj4VR2aYEoc7JHCUYa1Y1Y0L/86kRBWjW+Sd8uGVpheoha+gA77fruhM31dSHdn5ANP6LP8XGokH+7ScunGxNMb0szozzTxlI3y11OBDBf6pqO6JN8PzxbVzjvvycLsGR2A+HWooAiFxcnFNjwAycK1tl/TjG5f6ij6sqT1AVMlr
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(118246002)(508600001)(6486002)(5660300002)(4744005)(186003)(36756003)(36860700001)(336012)(82310400005)(40460700003)(47076005)(83380400001)(316002)(8936002)(70586007)(36736006)(4326008)(70206006)(2616005)(86362001)(1076003)(8676002)(81166007)(26005)(4743002)(6666004)(956004)(6512007)(356005)(6506007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:31.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b3df4-414e-4f43-22fb-08da3188122a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only.
Modified for support SCL3300 as well.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output.
The change adds the support of scl3300 and inclination data output.

Change in V4:
Remove Reviewed-by tags, that were not explicitly given.
Fix all the review comments from V3.
Sort variables logically instead of length in the struct
sca3300_chip_info declaration and assignment.
Fixed the warning "unused variable scl3300_scan_masks".
Reported-by: kernel test robot <lkp@intel.com>.

LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 307 +++++++++++++++---
 2 files changed, 255 insertions(+), 53 deletions(-)

-- 
2.25.1

