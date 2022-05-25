Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DE533D52
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiEYNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244094AbiEYNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:09:01 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140094.outbound.protection.outlook.com [40.107.14.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582DFA500D;
        Wed, 25 May 2022 06:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvUpT6/XjIczMNx7tmGSRaE4Sn2naEDwn6sc9gDNV5MFmbgnAX1ZpGD2zDHkY62tlco/oGtvoIw2IIYwnm9aD9ZIlka2uRC4yKMA4nijKXUaH94b0PjLkiIZUZhKgkMvGE2V9bNUfwtJ1f8f/iRp/GvGAfWZGTasl6X70OC1ymJDHceMpQcttZTeTNuOW0hEj2lB8do8Cn7yJTEc5LiXpmu+vhAkQbg5Uq7K2vlgHQvNEnqN/otrB1AR0+SPVlT7ROsdVoYQ0NP1Msq7BjfSrPQ3UKWdcigN6HoEyvAVV1eX0Gc96pyquRxWEGmmWVQsrO+KuuxJWXPrug0ngj96eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LWZCIYKiuK0oM7NaMAAplLRAxeCQg2bbuhU/fu43/E=;
 b=G0Wmcl89pQIU0Qi8zZcTwxiyYfEMJIoGQzRvNLCGb1fPNFXHn8ANaQAE3JldKumd0tZyBwen9PifSnEuZ698HjgezpGgIZs/L2Kngyzel4MVL6VN5QuvnGI3JmMbJmKxU6H44evFepa6qeE+o8c69IpcquAfBPsETwEmRkWBj9vK9MAxPUiCmAVoxpUfevg8EW1Io8fNgHGrPA2vFjCnXzyucfoJFYKSPb3zQife6kHwA345MovtdPGCqkhCXVNjTm0ouogia9UggPa2lESrBMmp15UxtNoYWDfOrzVybHT8tv2HHUWqqD3mQ9Tdawhz0UdxJGceqCQTju7ejedftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LWZCIYKiuK0oM7NaMAAplLRAxeCQg2bbuhU/fu43/E=;
 b=EHjy2pyJI/U2azM61sKm9Wwa+e23vS1BjlEfjmQBGIfAZUYu/1p5cPDXLbEs3Oy4pSDrkC5d/HMqPd4uSNquISF6046UsaRX7BJN+GpzGIqxBLOfmDIRAVWUizBG2JXanUKaqKaJucs9GUvpChphCvi0Oz44SBKhrR3Hr5sFzUc=
Received: from AS9PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:20b:46c::24)
 by AM6PR06MB5157.eurprd06.prod.outlook.com (2603:10a6:20b:64::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Wed, 25 May
 2022 13:08:31 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::86) by AS9PR07CA0018.outlook.office365.com
 (2603:10a6:20b:46c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 13:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:30 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 0/6] iio: accel: bmi088: support BMI085 BMI090L
Date:   Wed, 25 May 2022 13:08:22 +0000
Message-Id: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3258c16c-2e04-4e37-263e-08da3e4faa62
X-MS-TrafficTypeDiagnostic: AM6PR06MB5157:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB51579B5C589D06F1124375D6D7D69@AM6PR06MB5157.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RmR+UEg/6m46vVqu93LMA+e6XExMHY4xBqh7oJfCERYMF1d7jS9GByWiKj29TOYgvgBHNfPKRKXg/5CPChhCqg9G5L/bU9oxO1drraKzD8gyB+RHTSOUh+zOFaEO2VbyZXnMCZZbFtWmRKDCA6FN/ordvrsj+snlrQ1nfj80g4wieGsyji6hyzF3XjmTOBrBo3+tyPpik6gZQ0EuOQrtHzegFK6/yK4U/TnaNzt/USWRxCCOiCKkG4rRUrjGtdsLAQHh4HW/FU0TalCfSgrbujZr+rYG1oWSrWgi2ncs0IXyPH8/fzTXkjzATmyTTcXq/P+r0xPs7Bh9OwzoyIemMmPOcIN+5Q9mgtmkTnYdjUpeX00UNMb+bPj7pcTYHEVcJOp194BhQrG67GqCpwAs6ARQo1sUylJtckEkOl1C24RSeFBK+/gw4jC7kfKIhhw8f4iYoyMiWyXVcmeK2xhZvmn7SGHYPUvlRkDesyF4F8nEOMlzQcokfmcN/SHCQ58vPifrgGyUyw+TAvj+lkeW1IHLAhy/TCFG3tHfDJPYZEPwfD38iXNWWGlt7gLSaQNfHVCvtbwwtOIeX0q7uFrGB9ZUd0rziWC+7bGGL87FwMy1dC2CI1pk63guQI22xCksfAZP37hwLvHnJqnmXBfQSTzameg7P75RL49s3vKLS+Kf2GLUX46xV9bttH880+9wicJNMYygjNWz3SGkDpTAg==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(82310400005)(81166007)(36860700001)(70586007)(47076005)(336012)(70206006)(40460700003)(316002)(36736006)(5660300002)(8676002)(107886003)(6512007)(956004)(2616005)(6506007)(8936002)(36756003)(118246002)(356005)(508600001)(1076003)(921005)(186003)(6666004)(86362001)(83380400001)(26005)(2906002)(6486002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:30.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3258c16c-2e04-4e37-263e-08da3e4faa62
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5157
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

Change in v4: 
- Rebase to the latest version to fix the conflict issue.
- Modify the bm088 and bmi090 scale list,
  from {0, 897}, {0, 1795}, {0, 3590}, {0, 7179}
    to {0, 897}, {0, 1794}, {0, 3589}, {0, 7178}
  since old one are caculated as 1/sensitivity*9.8, the new one are
  caculated as 9.8/32768*pow(2,reg41+1)*1.5, the values should be same,
  but due to the decimal digits issue, there are 0.000001 differece,
  takethe new scales, since they are more accurate.


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

