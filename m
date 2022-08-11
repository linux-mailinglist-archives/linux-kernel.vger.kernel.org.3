Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2A5900A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiHKPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHKPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:45:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA3A831B;
        Thu, 11 Aug 2022 08:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5eVh3pUrx+dlvW6PJxCmIVfpKMm5rc+WPKly98Juayy4ABdApymllNJaB0bC6tFsL33ZLK5K7zY3HG46YZhqXahEKgQt5f+Dmik35+UyaRESB/fwGqRqSBTv76MuE70QmZ4k/XytoO0DB1oxQ8TKEP91Kn06QahwGQdgeaev3NKIIu5WOeRQbLall2xdvJR8aPeEKYFvDug8wD61/MhDUQmWhl6NnwpXO4PFc+DQ2gkrM0H4Lu0PT+neELhBaiCQqU7bsIAYCV8OXEW63n08PI6DBOJ/SlrS8GcBRsPH4f7pdYBwmu0NESMttN03FiKDBPS/uAMfhrfxCMx153TiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83O0HKPJhYiYxwyREpKfYBcjxhqcCa8edXa7cpkNGxY=;
 b=c1jDPEeFStQmKHuoNTQ7D0E1YRvV0g9z7DV+VGjbWRRDRQukU3H3PdI7lyxg+jCnOzNx+SebPGNzrow7PvT5CMQfFcHOgn8lwV9uhHzgx9+Cx1Deq/OjK7Vram/iDPXwwWL1yQzarVdR/M4wG9Bc6tY+6YD9NvciVix7BRf9ywhasy0MrnKN065YQwgYeXiE3BoIFmKROdfzmfrMsKlKDVwKcofWjjxrX90FJd3m1eJlCYybpd8bR/mvVvJrMjUMMZi4hQvwq9W89PVQsfV48OsfUJqz1687UH/McYmbFmjsGBU/hihMYAlkpOPPZ8hbv39IqsE+3TnFuQezumre4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83O0HKPJhYiYxwyREpKfYBcjxhqcCa8edXa7cpkNGxY=;
 b=SrTHAmwvxZU1sab332HrgN47RIBgmqLxOHqpM08X/15U1XLBk2beumEtMMlv2WaAz8iiy2yhRceaP6rHlJt7V3bTms/eD9ndWtG/Nh2SqsoZwe2gstFTspoZl7GaDD4v2krl1lrdcxupADM1xSjt26mpY+eeO2x34ryFCPnzQWI5eq+yAfKv9pM0/L7ZiYdEJ6/2k71XxHQeqMjeCYee6KzdIk5gduPKC0SFHQOaSI2Ib28RvDpGQuOuSXV1ywKm89IfGw7r2/pbe4nAKm9iGvW2jhgZiBA/bZEzBJtyoDA80OFkxzZWkmSYhowYRPTcxorWr20iIY8pBVvo9GIPzw==
Received: from AS9PR06CA0411.eurprd06.prod.outlook.com (2603:10a6:20b:461::25)
 by AM9PR10MB4021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 15:39:19 +0000
Received: from VE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:461:cafe::8e) by AS9PR06CA0411.outlook.office365.com
 (2603:10a6:20b:461::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Thu, 11 Aug 2022 15:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT098.mail.protection.outlook.com (10.152.2.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:39:19 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:18 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:18 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 0/4] add support for another simatic board
Date:   Thu, 11 Aug 2022 17:39:04 +0200
Message-ID: <20220811153908.31283-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb19cc5-3bd0-4845-7cce-08da7bafa7e2
X-MS-TrafficTypeDiagnostic: AM9PR10MB4021:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpJ71DGwr+KhbEnkWKD6/dV62PxjeE443dgfDIm303Pi+Swi5I2TbjeYWHzkc+mxzMH/Hn8j5d+cVAIMlOuIeyk0chReWFVPZMtvlhYKLHnS4g3Cl8jNNU5KgcYsFUx17mQ3lvhHti4FUeRuidToiHNTLMon0Bx8sa8uTEep41iBK130R9R/KTLUKC9zn9PmJP3xWaJ4TSYyvSed6o2dCXrBnykD3C3GdfyMoEoTywZXO6w9YgC1FwB8rqnsyr9s+FUObehXKgmhbjMHX00THj/0M7P6Zq0zy19R/q/YbQ0brLmYRTvWGt0mB8OXooq4lf2mT4UX9cs4FSE597XkU8gO1OTq1f6d4GmZZIZ7Tr86LHh1TZqvBW1Z8OhXqfwwHoY7w8/MLsxVvB0hMvvmahrFcGDqYSdaVqVOjS/1k4BYLjmZlSY4K1udEOjqrXte5mahViVVQJi/AOn2+ai/3pCUl2JW+wBOqJi7z78vP3XMQNjoSwu+JKpaDSx/k/61Pl51CfW6IhrGw25JVw2jNH44taHp3iUhDaeEcM2FnIKubzsoliMCzolp0WQ2zB8VKca0YfRvxRCndTdRzL17FpEaCgTXVVo1PgTF3uNGg7dW1A8xlsJgMxE2nYc9poyYjurEkIztdv+HzsiS6jVl4lTTP70KtSHZVX61hRrF6xtl1S5dcTBsnd45KHNIUs8HXbJyLVTAjefK63s1w3GjApEmIDKOWkdVbsMXmlCi+iVVF21ukX2DiGmddPFuRb0m9XlkxCWJgpsZgUQ1priIt59pKHL+Y6LWrb/h1dbKe1cAvHN6rKSR7EFM7pgqqOVs+su5iJWKq3003wsvar3/kmv1OWJyQHw9U4YEmrcrQnFd/ompWEkMsmNvMWF2FqT+sJr6w/HQQw8eW5KVrY6e7A==
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(86362001)(2616005)(2906002)(40460700003)(82310400005)(956004)(82960400001)(36860700001)(356005)(5660300002)(478600001)(81166007)(8936002)(7416002)(36756003)(41300700001)(44832011)(40480700001)(8676002)(316002)(6666004)(83380400001)(70586007)(921005)(110136005)(26005)(336012)(107886003)(47076005)(54906003)(82740400003)(1076003)(16526019)(4326008)(70206006)(186003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:39:19.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb19cc5-3bd0-4845-7cce-08da7bafa7e2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4021
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v2: (p1 only)
  - rename macros that change behavior
  - use chip type not device id in the macros
  - reorder defines a bit

changes since v1:
  - remove unused define
  - fix bug where (base + 2) was used as second data bit
  - add macros for "inverted" and "single data bit"

This series first enables a SuperIO GPIO driver to support a chip from
the vendor Nuvoton, the driver is for Fintek devices but those just are
very similar. And in watchdog and hwmon subsystems these SuperIO drivers
also share code and are sometimes called a family.

In another step the individual banks receive a label to tell them apart,
a step which potentially changes an interface to legacy users that might
rely on all banks having the same label, or an exact label. But since a
later patch wants to use GPIO_LOOKUP unique labels are needed and i
decided to assign them for all supported chips.

In a following patch the Simatic GPIO LED driver is extended to provide
LEDs in case that SuperIO GPIO driver can be loaded.

Last but not least the watchdog module of that same SuperIO gets loaded
on a best effort basis.

Note similar patches have appreared before as
  "[PATCH v3 0/1] add device driver for Nuvoton SIO gpio function"
The main difference here is that i added chip support to an existing
driver instead of creating a new one. And that i actually propose all
patches and do not just have the LED patch for Simatic as an example.
Also note that the patches are based on
  "[PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper"

Henning Schild (4):
  gpio-f7188x: Add GPIO support for Nuvoton NCT6116
  gpio-f7188x: use unique labels for banks/chips
  leds: simatic-ipc-leds-gpio: add new model 227G
  platform/x86: simatic-ipc: enable watchdog for 227G

 drivers/gpio/gpio-f7188x.c                    | 193 ++++++++++--------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   1 +
 5 files changed, 157 insertions(+), 87 deletions(-)

-- 
2.35.1

