Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497451FEB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiEINug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiEINuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F11611D0;
        Mon,  9 May 2022 06:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6V/fkp3/LkesJ/dmAshbrTwH/3m8D2DYAmO/5lYVxj8+NDp+vFuSNeurs9n3jGVMjk1/X5bdjfhKZ1UlFAQdZF+hvpDiCMuIhWt1HL43c5z2BcZ5PnIXRprsleBr3i8xsCIjz/pIZw8/iT0itQJJ1vMIXL3j2/iGZ4omKrZeTo42d7oeBOxxDQ5OcOgIQecZQWRvW+J5cQetRXMD+pEsRAW9COwJdG3pdaGCiiPjunQfVgRk5nAAsqY9UCGB0FBsGHg88WMwvdFfbspBgXpEYSpWzlnSoOueQDRcSA+AbX8ym5UsRErz3rllWxeeqhOiLfzGZIj8zSyOgqbPAYClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyerRPnmJDXI/SbMbiagp7xop6V39yvT/Sy8BMPlCDY=;
 b=WuMlvFnyolAST3eTgrQyDak7fHWSAVKMXCv8cU+1moAxzu/8DlGaAO3ECI7vyVgvHgIDGSLvtp02qSuhfsnBOSZEC44MuNCwNreD8r8Y6cZFcoo8IiZd9dv4oXLKFOK25oPrU+x1/fvVMI0KaK3wTPcOf93Tipt2ClLgWXmgACqT5STJB/twA9w8FSJcvlxLcAXxqZ8tvSXsgmfg89qCWANaT0CEMCYtz+4j9wm6Q/ne8oDFzhZR6pLUsQcjeXEfWsbVYbmu2RcN4VGtw81S48DoQNLc6QSQV2NNNCtcK/5VR+l1TZRDx8zwXgn1Nm18qVLvsrJIng/s0pn06zp4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyerRPnmJDXI/SbMbiagp7xop6V39yvT/Sy8BMPlCDY=;
 b=T8hiKwvlU9jR4VDmfDCx3T2J/eRlp/K2+SEUhuukhaq3yZ3b97ELn9IMQQHmhsDZ+oeAmJ9Dls8wP3JSNJdHcsJ8dCu2+98+XDIKcz5Fd3YKPXKXkGPot3gPEHbkOMQ2DMUShHKdCwZphEC167BeVsove9GkEv/4H9+At5jZ4w8=
Received: from AS9PR04CA0076.eurprd04.prod.outlook.com (2603:10a6:20b:48b::18)
 by AM6PR06MB5094.eurprd06.prod.outlook.com (2603:10a6:20b:67::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 13:46:33 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::98) by AS9PR04CA0076.outlook.office365.com
 (2603:10a6:20b:48b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:32 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 0/5] iio: accel: bmi088: support BMI085 BMI090L
Date:   Mon,  9 May 2022 13:46:24 +0000
Message-Id: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7c79084b-5946-42a9-1997-08da31c25409
X-MS-TrafficTypeDiagnostic: AM6PR06MB5094:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5094C3D60A46BA911996CF56D7C69@AM6PR06MB5094.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjIpDThEmkhaoQHWldtbqP8l/Xo9MQa66/Ua9WZEli+qfg+xktxNKfzbPS71T2AgVvMmcfdjf5dfMCHvTTQsoI01xZtfCzJ6241PDts9Q0d1UeLO+wiglRnukGkyLDRZmI8zm3MLLaI9JIXyjfI5TKk05sCpwg/mWeoPNduUQXjw/+Tgx6GibhHgTfrncgNHtb/wezaxsQswOs/pfiuOQQPpa1hLMHX1viGsqaPqKCgZBSgET/E8Hpkpu2ZMAmTyM9s1Wd2TirTgLTLqamgzEznFYCD6tVW4yDaWyS5VSOOff0YSuQJw+ox2n3Jq+28jExM/3atAuQiu/4bMwopdSkgo4c3JOBACXQ3ODvdKxBpcCuWy9nWLhk1rapF5JditL8il4flzx8F6UGKf5P7X4jiZTOByR+Shid2G4AvO5bcyvLH0CVFJedOsJm+lXlSC9hQqSNsJK0WJYiDlVPS6tM3q4lQwS2YgBDHe3kNibX6hohwSp8tfU7HdOQdyIg+clKqE0hkWJRuy7+/bRuZ6EYv8/V88rVwvO9x+3TpUiV2bJ2hEmyyu+jKQujB4oVnUAiIBobOmKLkbBOBwnO4ra90j1yT6XCrO0xhtMdwEddPDnehZsaupial/B18iOotqJ3c037m04Rxq3YZdkR8Rfwao2ljXWoHgSkvu6skgf6p2fmjXPuac/mFdr5Mpbyfx
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(6512007)(956004)(2616005)(40460700003)(508600001)(26005)(118246002)(1076003)(36756003)(8676002)(36736006)(82310400005)(186003)(47076005)(336012)(316002)(70586007)(70206006)(5660300002)(6506007)(86362001)(6666004)(8936002)(6486002)(2906002)(81166007)(83380400001)(356005)(4744005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:32.7926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c79084b-5946-42a9-1997-08da31c25409
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the unit after application of scale from 100*m/s^2 to m/s^2,
since the units in the ABI documents are m/s^2.
Add supports for BMI085 accelerometer.
Add supports for BMI090L accelerometer.
Make it possible to config scales.

LI Qingwu (5):
  iio: accel: bmi088: Modified the scale calculate
  iio: accel: bmi088: Add support for bmi085 accel.
  iio: accel: bmi088: Add support for bmi090l accel
  iio: accel: bmi088: Make it possible to config scales.
  iio: accel: bmi088: modifed the device name.

 drivers/iio/accel/bmi088-accel-core.c | 62 ++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

-- 
2.25.1

