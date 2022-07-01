Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851A562912
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiGACaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGACai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:30:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2114.outbound.protection.outlook.com [40.107.22.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E9761D6D;
        Thu, 30 Jun 2022 19:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bns6fYNKRmWg35Wh8M/R0lF1NBdeEsoNddRaD+jDdo2Rr3+NDnMjWGZkZyQM0eBZSetTgoAgWju7SCIRuPAhBxHaYJIqqB1Wd2ETYvKpLWnCI9hKjZz4hQU7rnMQUTmBzNgXSX9R98MfMnYOuu0bdWWOl1mXm5g09pJ83gyyXeasWNxuHppLDmBH8lYrAgei07RxIW9+TjCqTTClH9PmoMapnb0rM8hgXvKse/CV/Eltb33ZdEHoFof+ua9DAE0MTsXL1QobsNX48NkcgSCZfY7YNLl9FpPEwwu+ojLfoDjiAUITsuhRT7mRu8ZidRISjzCgMebQ5ccHLEM+ajKjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUVJbKBDRrCXwiNrMQDld76OTHblS82ZGV4jLVnnsD0=;
 b=aBgVWGqOdBu4+LwCaXU4SfF0Lfc2x6DcYI3p3H7QFVnFrsGLW5/xvZ5bRjfphBeEkImTKTb0HJ7ZnoxxW2O4fMh5SX+PRhWPQ4wdcwJ6D3vFapyJKneAoWyWJJQki9RCvYnHAAAMh4i16iBLdmMHKEsB93slf9K9obtmQXTb93ThH7PMReuVzn4QmegQ6WKyVt+oHPSdh9EzAlN1Ssa62nNscWA7g0TMnT9UB20YJCtZXhYO2uS2HCE34msq4BbqxCDzorbYlpSAZX6DrRhjhLQlIuMdq57Ph0/keJV0ojZmzWCuelYO9DnqlrbnJ6+ACBNsRcLukZSQAslL3+wfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUVJbKBDRrCXwiNrMQDld76OTHblS82ZGV4jLVnnsD0=;
 b=Z3RT2Or/IjOl2/U0SwkIESWAxQCrGSUZTpjAzwWodADI6w2neRTBSLcyU05ghybO5wmFH/eGr5tscrMpyqA5xqCB3UBeGCJCJrM6E7jcEo/UXAcrIF62uuUevsSgMv36jV4nJvMj0JVldHB3D8deaRd2WavdG9KbQxXhQIokzuQ=
Received: from OL1P279CA0009.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::14)
 by DB9PR06MB7979.eurprd06.prod.outlook.com (2603:10a6:10:292::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 02:30:34 +0000
Received: from HE1EUR02FT104.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::46) by OL1P279CA0009.outlook.office365.com
 (2603:10a6:e10:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT104.mail.protection.outlook.com (10.152.11.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:30:33 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, tomas.melin@vaisala.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Cc:     bsp-development.geo@leica-geosystems.com
Subject: [PATCH V1 0/1] iio: accel: sca3300:  Extend the trigger buffer
Date:   Fri,  1 Jul 2022 02:30:29 +0000
Message-Id: <20220701023030.2527019-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bb12370-9aef-4dfa-9e3a-08da5b09acf2
X-MS-TrafficTypeDiagnostic: DB9PR06MB7979:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvbRbctIEmm5IEa+lvZJmiAJhOTPo+DXisdCv9yf7oK0lUwQ4zKoKs34TNlCpOCf3hXlTRYsBX5zlBOud6tZ1SmrOAMTZmksiEO2/KHshwLcEd7suFxMtYLZ+W8whnK2pBkQbdxCwZAFdrjvJzUqlKWSZa1vs/qQlD70fFcyP9axv90MrJcRa9tj3prjvpIjGgDJ2AOqDo95tZJzsdknbk0PlylS4ZHZos+bod+ZdRNGISggi1OMBFjzgMeEU08DVMQoBZM8LAw792T3L7F8s7wYAIMUajf/ZPI0GeVEoFP37Y81BoxLtq8Hmq3Q6zBA6TpsQLfzQro8MkQ8oe6znJTVxKji+o5x9HQhJnZtPndtuO5Zeb9RwEUVdHDPushv1D37VZV9LxvqWjGJ4KffIcJIxq2hzXTcXW6DEhl+oUU5wCCk81oWeu6IaxtmDgmo5xZo5iWAikK3aCH8OfaZtKdAMA01niTjpRDtCgqLQMqGZnfglvrYpATWz/rAmMdLqOQCyBJK07HndcYfF7KK70Q9yxlWih0Zrj4V0mveLvIZ00+tduuHNC2b1Y+3px1I1vaiWZB6ejh+bxhT5GpU5vd5EymD98wLxGiIKUNDVP4/hlmMbHL69PUc8cp5OUzRhYpHBI4GZsrCnhyNfeCqCLC0AfkqMHkeIG4aqtqV5GN/yY1A6zH2001KZK5CEvPQUMP9Qjv8RyYncftMgjbiPKmrBTYUsGpzwrEqE2OMGUZCn6Dumi4Uwo76s3mbsyvhotlTjTFnp/dUyIG3s6tB35bJUl8SDXuSevOuLvQrSuTgKrZ5aYgVJTB4ExB/bUV4
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(6666004)(47076005)(107886003)(356005)(6506007)(336012)(82740400003)(86362001)(40480700001)(316002)(36736006)(36756003)(82310400005)(81166007)(4744005)(5660300002)(478600001)(186003)(118246002)(40460700003)(83380400001)(6486002)(1076003)(4326008)(8936002)(956004)(36860700001)(8676002)(2616005)(70586007)(70206006)(26005)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:30:33.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb12370-9aef-4dfa-9e3a-08da5b09acf2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT104.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the buffer reading issue for SCA3300:
  - Extend the buffer size from 16 to 32 bytes.
  - Change the buffer struct to a u8 array to adapt different sensors.
  - Readjustment the scan index to make it consistent with the buffer data.
  - Change sca3300_channels to indio_dev->channels.

LI Qingwu (1):
  iio: accel: sca3300: Extend the trigger buffer from 16 to 32 bytes

 drivers/iio/accel/sca3300.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
2.25.1

