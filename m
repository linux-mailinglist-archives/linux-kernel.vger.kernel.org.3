Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1753016C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiEVHEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiEVHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:28 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00132.outbound.protection.outlook.com [40.107.0.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D842E0BE;
        Sun, 22 May 2022 00:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcOjuuHWKlFqugi+9ZSgMXovlWWkoPxecG22eRjeo8RVdEeDnsZQo+gLNheQlMUdqXlLAis5xSJGwZUPLufXOh4nDLcIqSRIBpCVGXDBqMJkJp39jzcr7jf2lfSLTLpobwPHlbX3UTr2A/TGlBLjexIH56TTSszrdAikf8JFlct/tRP8cJD/e/6U1QDaSQ7gsmcP81lSKXULeW43B00x1SxS70ByAzstgUTSR1Fh/mju6vqGaHp5daYPnb5FbYb/AKAds/s2TTK0A9pKiQpmSMZ/+9dcfa1YbKMg37xnZR8IdteImUmLUwt1I12QXq2jPgzxI0pWzXTcp3gpEGQEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y6qHCdnPPHrNn51qWjmdQSTTIaKZdRXb1ZaNLAbxBQ=;
 b=LajIhABhB/4gO4pRrSWZqsaPH8LafPtubeQn7urQzwyx2LBBqIspbxp2e6Al0U7Qw4njqgOGAbgPHDZkFeDkorED3UDlfVTlzCjtMDSHSY7yuJc0FAzr+hacYeSIVwBpVligFXypQrCeqCTKoaP0UAqlLUiZw/D9w359Opwdg1pp/XtQ72nDCDjwtX9ScYiKtnzDGy7z9Qq7iPCwhd7g3hSmKyrKG7/3wpXzNJqd4kWgtDzdBnbMFtN6gqp8oUfrafoZc6nq4vumfOzPC8xEmSMAZx6E4CplXldmFiTVbLHutOxnchFN7Vgsy3Oukz1MFUHDP/60cDZ/+Dj5gommLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y6qHCdnPPHrNn51qWjmdQSTTIaKZdRXb1ZaNLAbxBQ=;
 b=kTvdQfNGhpRgC2+CqpiS+F08EqiMgZQCN/5LbXuxwq6iCUKfJUCVo5g6vO2HtxFtztNIKORTdSqNgVu+dWNRqjyqPCy78rtXvksN0hagpc/F9UU95Hc9qdBa59ryF76IIHxCvad3qD0ptBiCsv2oWYVGSxciLHXxCVFxY5WskzU=
Received: from AM0PR10CA0119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::36)
 by DB7PR06MB5321.eurprd06.prod.outlook.com (2603:10a6:10:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Sun, 22 May
 2022 07:04:23 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::39) by AM0PR10CA0119.outlook.office365.com
 (2603:10a6:208:e6::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Sun, 22 May 2022 07:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:21 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V7 0/5] iio: accel: sca3300: add compatible for scl3300
Date:   Sun, 22 May 2022 07:04:14 +0000
Message-Id: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1799c782-1112-4999-e8c9-08da3bc14c13
X-MS-TrafficTypeDiagnostic: DB7PR06MB5321:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB53212465DAA2C1BA4699DD4ED7D59@DB7PR06MB5321.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDMQI6UAsZW56i0+zk3thhZRYygb+2ObVVqsYOlWErPCP0pSdFFJ7uLBx1cvcSZ6z/n1tcjecuJxNbCg5KmeRZk41k/EJsCzml+PdjC1chDH+iaXKVVh/tyQw4OLGQS/hQdTyxP7keafMSP+uG0HWMPNCd9EYfADHusjKCMGfnyCdvU464XDL0K/yHkbQeLR9fqu5RLPZO9rHYMwV+VlDiPL5UXkFyKmm6spc5sIJY4+k+D+E5oIDguptftMBZrspO5iZ1GNe5YQezK6PGeUrudz+5kgdmm3V7bCnFfsN/oviK+rSdlELA5Aw6T8enIKvIlasx6wC4L9m04O2x55aG8xnfTh/IVhX3ENW15E2qal+vXoabUzD3zz6uufr0fO04mTjJ8Y5ylQlYisYNMSO6Fc1Km80960Zxkui+Rr0HWurDT3ikyeZcMvEYMAncu07fv+tmcus45rM94rnnzcuONYNXjJb3+QbCHnhiyzDrEmh6/AIMM2HhvrKcoFOWMyFEorCKKS2AYuf6QyJVNOQIM143hTUOJpXPpM5s4jJkIdlRW9PETQTOBgomi8sAaEkqma2BovkavtkLZ30mlZHXZgrkz2jHFewvMuSHPVDRz4e1+pIHnRWxh0E0VB+H11yv2fwJFG8LJ/g0juQhwU4zgAC/rXv7NNLOSyEAXMze5b+Z1XUpP1UJwW6wYBRUOD
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(8936002)(70206006)(186003)(47076005)(70586007)(8676002)(4326008)(2616005)(956004)(336012)(1076003)(508600001)(83380400001)(356005)(118246002)(82310400005)(316002)(6506007)(36756003)(36736006)(4744005)(6666004)(6486002)(40460700003)(36860700001)(26005)(86362001)(5660300002)(6512007)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:21.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1799c782-1112-4999-e8c9-08da3bc14c13
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only, modified to support SCL3300.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output, 
the change adds the support of scl3300 and inclination data output.


Changes in v7: 
  - Add comments inline for non-obvious code.
  - Documentation for sca3300_data change.
  - Small refactor function sca3300_set_frequency.


LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 323 +++++++++++++++---
 2 files changed, 269 insertions(+), 55 deletions(-)

-- 
2.25.1

