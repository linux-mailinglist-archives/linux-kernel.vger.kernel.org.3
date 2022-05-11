Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58452377F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbiEKPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiEKPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:39:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488C8FD66;
        Wed, 11 May 2022 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR3M2gECcM11mTv73QSr25XZ8ESc6OOuwjL0HpZm0kVhc0ZRMqLIlM6XnI4Ztw4+hSjL7AJiXOpbGym6cXSj8VRwo64rqtTLz+JWpROePZHdwKgWsrwDquJfkw3OoP0m8u9BgrQjwR+HN2ZIWn5lYPDXgndB+zDZ97HmRTEjMCP5hVJ9wvFhW4FOAm1lbU5kE0JbQ4pDhIPSHAUx3+18eECpwrUaiegjhwlfjNMxwZvDOWeka14snxFSNPsC4AqkKZOHz/wrhbs6MeowWuLT1jdHpZn0TDm2lJdaJe6xRxfoByNyLFcK8nxnNNZHbahudP+YvjgVfZAR4V6OPuoyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq2ASt8jXxqqPovsrRg/KLC8tinJyTV/ATHmAXTV1rw=;
 b=iiWWzzci5b999z3V5KnLmgKM6CsBioTuKBn09S4EbLRqCatSbcTgnguOF/LTluuKl8jGdV6MU8R/uJOBYBFUUiWheYHFrpIxSKjfrjyfeoIWD42dB/EiFvoqPdIPyY96S71/pZDA1UN1B5yqTt8WXxSQfdM/qgc+XTtuZ0C/3UD/7WSesnTcMq+PrnAua7g6vFiRV1plWoRqCIicLK45kTf8TIlZ08A2/lbIVD4A1xXLuMWJM+7BIYMgjM/N+c8/ysV3ZKlkp+jOH43ZxwtCRHZKk3NFXH0hgwejvVaC+71e5m/V1S9GjmTKZPuUvXU+sQZsidE9RBue/oIG4TXTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq2ASt8jXxqqPovsrRg/KLC8tinJyTV/ATHmAXTV1rw=;
 b=ha4sM40ogOx+Jh1BIEk3Iczfxs7hE8Hb/1d50E90MNuwIw7clk5aqtPU9FdSoM8KRq18NXdwbZ10Qwu3kGOBVcnQZhW87HzaYweeYIMw6ER4636GF1LI8PP1OZnV1c8yyLmatdfSa2jr6y+Kksy6SyhAvzdgA1RfGxflNVJxTKoNNc+snUwJMOJGSMTvl+412H1VZiSpnh1iGmNGwWBABH+nX/1Hr60vE4BXylc72DIIhOUlJWeQdWK+8WkQLIg4fmLswv8yCbjSn3zc6l9xWciEPxB79yupTmE7xpkhDpi4S7AfA42zaGdGZW31Bnu4OtvIXNXT322THYXjgXNp7A==
Received: from AM6P192CA0028.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::41)
 by AS8PR10MB5041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:340::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 15:39:17 +0000
Received: from VE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:83:cafe::4c) by AM6P192CA0028.outlook.office365.com
 (2603:10a6:209:83::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT098.mail.protection.outlook.com (10.152.2.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 15:39:16 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:16 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:15 +0200
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
Subject: [PATCH v2 0/4] simatic-ipc additions to p2sb apl lake gpio
Date:   Wed, 11 May 2022 17:39:01 +0200
Message-ID: <20220511153905.13980-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8fa3038-c370-4344-0d4c-08da33646880
X-MS-TrafficTypeDiagnostic: AS8PR10MB5041:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB50418F4CB3E1087E3213793185C89@AS8PR10MB5041.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IKnUyhbd8PHUOOaMhPhx4OQDJbJXHL0GS9J7ry+oZt9DYVisTyLjtt+NHyTIddR7OmZ1KpmfjHVpNAzpiLOXXlEnmb/97QTKyzqRcsA04loBhKiXiFuT6QCxWeV39Y0bvaDHI0iqeUS29sMG6/CJ2rK5IPZUJYGBk26awShqfcw1aQsjf3gX8OS+3F+4JmtpeODixLuB9eJB0tFKkO7J+W9O2bkCvCyUTkbmhXox3iUhqqb2rR4p0iC0cUm3xrTnMYUgLgoVzcqQTBbdmtcShjjq2ILDpZNIUSBQMgaizgouNNA2UJY6f2Fe4NRa3q922z6/DMlmpd78n5kON+MRK9tcT9ZaDkjIq32aCc4ImgjJnGJS3ocu714pLScB/YLTkdB1DppPAvarVh/OcomrzAyEUouNsDhUzuc8zp3UaU2ApL9Wr8+QvMdfrMqipIFTSaSWfhOMDJ6EAjLNVYWPqR/oSTEjgP6KC4pQUTUzlURiJunqi/3cD9SXHUZIWPX+Yy/kHD/uQTMyRkjC+TXjWPi6e8KYDDpq4Cx8MYjMOk+xVkMU0ljelFW+9E1xHsExpOOUJlh63OK3KEcogYOYRnhyawRqGobHjnQ9q7XbjNFHyA8JMvDlOBzDOBJuh9frE32bojklHlHNGMJmZ2j3i5j1IgY4je+6TQtu1zqIc3WDFFKQGM8VZDKmGMH1NWC
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(508600001)(6916009)(5660300002)(8936002)(316002)(1076003)(107886003)(7636003)(7596003)(54906003)(336012)(47076005)(16526019)(70586007)(186003)(36756003)(70206006)(82310400005)(36860700001)(2616005)(82960400001)(26005)(956004)(86362001)(8676002)(4326008)(2906002)(6666004)(356005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:39:16.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fa3038-c370-4344-0d4c-08da33646880
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed since v1:
 - rebased
 - split p1 into p1-3

This switches the simatic-ipc modules to using the p2sb interface
introduced by Andy with "platform/x86: introduce p2sb_bar() helper".

It also switches to one apollo lake device to using gpio leds.

I am kind of hoping Andy will take this on top and propose it in his
series.

Henning Schild (4):
  leds: simatic-ipc-leds: convert to use P2SB accessor
  watchdog: simatic-ipc-wdt: convert to use P2SB accessor
  platform/x86: simatic-ipc: drop custom P2SB bar code
  leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver

 drivers/leds/simple/Kconfig                   |  11 ++
 drivers/leds/simple/Makefile                  |   3 +-
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108 ++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds.c        |  80 +------------
 drivers/platform/x86/simatic-ipc.c            |  43 +------
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
 .../platform_data/x86/simatic-ipc-base.h      |   2 -
 8 files changed, 138 insertions(+), 125 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c

-- 
2.35.1

