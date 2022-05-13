Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F34525D95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378402AbiEMIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357443AbiEMIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:37:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD8F26272A;
        Fri, 13 May 2022 01:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXW739Bh8i3dtNieaVy4uLMrVgizznx9cT0X4Eo6cysejPemuk9uFEHlX1zoQalTz5frPE+Aj9q/2gJloZGN4vSo+fGg8JCZnQK1FIfjvX+meFyGbETSmRnXtx+SV4EfHS8uPFdwSZWbu0OmUeL2Omx5zOLhuYnubioDxkngfK2DqhwiWtH+kgaIvSdz8aZowCNpKb4yrHKEorJuAlhou/0E10wgSzD5BXsFCrdT+O0JAdH6tE7wCA23d1MH7d2tP60ViQARboLrkhuCTglExyGWkeuqNiP6lwdI15cza1xeDYck/J42kspIMXgqjkkT0TBnCGW6R/Uq8lBFWFsQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCMBtJbMyV/cjCfQO+Fr9l/MGok0Uze7XYprSk3Xbiw=;
 b=OcWPTh0SPLHqhiMQCTNyiauPuhO1iqheud8Z1VN0iB721r5Ciy0KCyaV/dPaLxuRxAKFqOJFprEVCBoRVZj425Xkp91to2dg5HNO1gUXJfy+pPlnw6zQF2c57rW3fSWSlu+yK/kfWEZ1yq1jojjRtoMFLAWhcOJPWfn9C6Dt2kha6Rqsem1Y2sCnNOcQH9ky2cQSmYs0OisBEZdTjDnnj/efgSP0Akf3FmahsPryRFxtbYwEg64SwB6ygv99vist0YhMuForPvKC1+oOt+Q3yghyWgja9S68y3P04RLU0R7SRDV4VIPgOVcCj4I/EBKdGRouW5+UdKJ7IiN2sn5q+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCMBtJbMyV/cjCfQO+Fr9l/MGok0Uze7XYprSk3Xbiw=;
 b=WIq07T09k3xq8BNamWQkVXKfNefCCEF2DdGYp21s3TkKpI7wPlYDeGTc8+g676fAEq4y5722zUT9+z7cp4Rg4JrRtd1kiafeQwh29ZMfF0BOQPErta/DWqQVG44J/ZgkCvqqU3KwcXndIf2Xftn2BzDJ3ppbUa4z5TzP3TM1sKi0dU8k+2sZMzz1FHqUwyVWp+A23MyO/6jfxO0dtHWZRwsJ12cmdE1UBATh4Eq8Oo0rmUq5JiHaFJDDGnzbpmJz6tFP6nPbsTxXUlnp6zPNcB3IBYyYDPo4jJmCaOBwsq8zk4qG6InSfHBIKWc31JzYuS3zdtJ3sT/sH9H2VhXxvQ==
Received: from AS9PR06CA0780.eurprd06.prod.outlook.com (2603:10a6:20b:484::35)
 by AM7PR10MB3624.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:37:03 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:484:cafe::f8) by AS9PR06CA0780.outlook.office365.com
 (2603:10a6:20b:484::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 08:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:37:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 0/4] simatic-ipc additions to p2sb apl lake gpio
Date:   Fri, 13 May 2022 10:36:48 +0200
Message-ID: <20220513083652.974-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f26962-4374-494f-f443-08da34bbc12b
X-MS-TrafficTypeDiagnostic: AM7PR10MB3624:EE_
X-Microsoft-Antispam-PRVS: <AM7PR10MB36240FB8A3AAA2E511A3BE6985CA9@AM7PR10MB3624.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZl7k87cQH3CWIC6pVJ8QUH2+wH7tMYuQDQLIGCcQmjc1NEs+h0//tFcTT7phBtchd3cqq23/F0qxpja7IDbd/neGFY4exB/JcTkzEa4bBEmSxVN61cnY15wykn5WpodcfxGJ45jVMo2Q+bX6yFENpZ6xOF/FBOnMzBXJqpuiA9xPKBlrwEgqDydrlYOzlVVRUepvLiW0fwIWZovw37HmkQb7txuuAfSIRmxM/xET1UhUXRbog0xhLZEguTOrZjRsgTu5X5UJe1YXYCy8ohIlR79zYfumoHZcM9BWcVrHZj3Sr9LUeUqRAYbaFBdHTFf9FEo4wwXb4PoQpO/p/n81+pkJzfj1Lc+f6kmt3tcL3V8WyOxtQ/7JnLrSwbaQVQFwe+Zd9pMuREB7kuGc6qs/bfRXfEBv6zMQ76XELA2fShDDvcYJucqaR2uJokg9MGRhyS3BX/1fv+b0R419w1olrSIJUqi7pjUI7bUTBh21Felw8j1JcZRkCGn7kJi1fj6v3nLbEUIwMT8xIb6WVMqP51oDQKPhXv7I8WseC9lQHVkrXiU5yzVWzlZc6tffGQ9/MQ4cJDF73WcSEmTE2LH5XJTq/C1nvcOAsIv522qGisM+jAOZwE4a+p9jEvcNDOgQV8wpT6+k5pSvo+lYDM3i6F+H61pmHl99l2FEuB245w5aDSEuz4/h6utkU5OBDml
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(186003)(16526019)(36860700001)(82310400005)(356005)(107886003)(2616005)(956004)(40460700003)(26005)(508600001)(1076003)(336012)(316002)(47076005)(6916009)(2906002)(54906003)(70206006)(70586007)(5660300002)(86362001)(6666004)(7636003)(83380400001)(7596003)(82960400001)(4326008)(8676002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:37:03.0289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f26962-4374-494f-f443-08da34bbc12b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3624
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed since v2:
 - put GPIO led module under same config switch
 - some style changes from review
 - init gpios with gpiod_get_index and drop gpiod_set_value
 - drop bogus "if" from watchdog Kconfig

changed since v1:
 - rebased
 - split p1 into p1-3

This switches the simatic-ipc modules to using the upcoming p2sb 
interface introduced by Andy with 
"platform/x86: introduce p2sb_bar() helper".
The series relies on these p2sb changes already applied and Andy will
likely take them into his series at some point.

It also switches to one apollo lake device to using gpio leds.

Henning Schild (4):
  leds: simatic-ipc-leds: convert to use P2SB accessor
  watchdog: simatic-ipc-wdt: convert to use P2SB accessor
  platform/x86: simatic-ipc: drop custom P2SB bar code
  leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver

 drivers/leds/simple/Kconfig                   |   6 +-
 drivers/leds/simple/Makefile                  |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 105 ++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds.c        |  80 +------------
 drivers/platform/x86/simatic-ipc.c            |  43 +------
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
 .../platform_data/x86/simatic-ipc-base.h      |   2 -
 8 files changed, 126 insertions(+), 127 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c

-- 
2.35.1

