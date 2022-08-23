Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0C59E433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiHWNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiHWNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:24:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EB14CC8E;
        Tue, 23 Aug 2022 03:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW2+F2CG8xtb60hPwPGZAJSAwHMW5OhdUaZ//DzmmEq0CkMaYYqeN1vfu/+reBzvBDaC11hCEfFkdiGXL/ADeo7ldlLwFKENaErdsYvoSTxSu/Emzq4wt9yHisw5pTGHKWN/pEGFk832rPhvaIgTD6z9RnfiqFijkFR+o/Yn8272IFB3WwwfjHpLcCc/6s7xGev7YzCP2ww8+Fr9agLyXToRR8XCziIWMsofbZ//w5R3gIYgfJXdkHqb9QixMfvVAVHlz1cPSkQUlN3QJlPB7In2N/FBKV+CFsZZunLBpD1hmx+54+IuUzO1bfp2/SeLkxOLtDV/kl1spgVn81V+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUxd4LIlSiTfTs00Gmo01pSj1lIPGR4vWCPB6u2GTWA=;
 b=nLzT8F5Z0TI790AxisfDfwOPmYVmgOmxbB+AnF9+H9o1M3c4DyeRAVNJ+tuefsOlbW3xNCKHcl513yBJHccjUrwFHXew2MTN5um271bneYJajjienvluwKoCfzD+aHLaHagTAa1moM02Qw26EoBW3OGd2Dx5pKtgDb1qz2nUl5d+7a+tAjhjnhT2dWKpknKLahgRo3Q/20v+OiHGxhVmqU51zJNsEerjM7Knje2F36lEKc5i4YsSCeXuYFxjePaZs+oBWd7qKwE8pVgLIpfOjwBlq+BbmddrL0ZvEYiuCqm7u4nWE8Bkon1J1DAiOn4ojh1cbSA9fNEJMsX+x7NFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUxd4LIlSiTfTs00Gmo01pSj1lIPGR4vWCPB6u2GTWA=;
 b=lfbQtbYrnGsjPtoFot2TUxx07NFmiyKJtThvfcS7301QDo8kMrfKycH+yXj7j0e4vDJZjppoN7R2whrybCSvbMWoyoo8fgGRsoXZe9VleUpn+DJkEQtwapgghxN8U/wVbrleelUbjY650ZybTNzn6yQABCic2rekf3QU8jBGptdqE4Kuf27UqKuvz7Pse1rXpsPnVbFJFDR6aelIKaM69B23iUef4MKTXlJTBYVkvTLNhxnLDZDG9EG9/YPyEsRnSPhffzUqFNYClvSOhAAMd8qszKTSsknP3+V4iQWKiCnmVa6JGWvnYzpIBwYSC3ceDrpkY4ipdouCsdOlvJNvyw==
Received: from DU2PR04CA0175.eurprd04.prod.outlook.com (2603:10a6:10:2b0::30)
 by AM0PR10MB3090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 10:23:54 +0000
Received: from DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::10) by DU2PR04CA0175.outlook.office365.com
 (2603:10a6:10:2b0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24 via Frontend
 Transport; Tue, 23 Aug 2022 10:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT075.mail.protection.outlook.com (10.152.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:23:54 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:23:54 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:23:53 +0200
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
Subject: [PATCH v4 0/5] add support for another simatic board
Date:   Tue, 23 Aug 2022 12:23:39 +0200
Message-ID: <20220823102344.17624-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af70b20-eb12-4ea3-0988-08da84f194cc
X-MS-TrafficTypeDiagnostic: AM0PR10MB3090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmCXc+dJHj/pMvSl/Zy9w51OmokDtKuEqQrz6SJgfNX2JiH+jgxGldAs7WmxQDvgew3to0LoEfvhxi2dRK0SeLs8JTrHwq70FhmOeYXkDITFUZCGVm/R6ch5yhhLd20c9gWy7wYVghYNq7QXIHna0FmHQv/HogvKBCsJNgF16Sc7r38KBzfMKAIQN/eAsUa6+e7zOxV0Lsj698rGdwx11W+dOlS6xJDguPy/HAgM/WrNL/U6d5lZVOLwj/0pfkjj6wBZu9Lv2qbWb1rWhxihZX5i7Iz/AwTMDd2+oSTTzq2mxKxbApM5FkQpJM1Ef1Gs87rMXWr2cd2HgZT+K5Sx6E6ytMp9JLm7nbZNO4bLfVsVTmIcFO7meQZ6/x2jwE1moTSKgmJD1C/96mAaPInU2wml0e93j/vuGcWXth6Y6sgpBwMKwSXjr1x7ACUfmwFVuekBxX++Ursly2qo/zUSn3k8ue4ovBScHQzCT3b1M6DiwWUNvithWI9VIQfEK6ywCUp1YKr8u5ax9J9uxT/o7ee3lR7KODDiESGRtbXGfE9R0GAdi9XTZ5fe3VWrrIVHpa0/OelpcDtd4L/4XH3ZamuaKfT2F1THD6G3s8cfOyt/6uuQkYv78UEU8L3+QinL4ja4D55e3jz9J6BK51jE1NdTORQudQqN2qk7uaavD3eFbjk9V0vmrG/Nzvwqdhtyn0lSIEOWWg9uTl2WPhLNl3TnwJh0+XrbRIP6q7YLXk19B5EsINISMD/AdVzdcP6YzDBHy31gecVOQIKgaYE0kK3KXPiCm/9GG9KZ3gUmoSIBhfgqh8py5GcWbJx3RVrDgrZLLSGDD0bu4rv+3NJ0iqMmryKD66Kq6OGz9WKIm7sNdMZ4MO+u0shjxW7DT8RAT05ehohPC79L7BgtHYxJ8A==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(34020700004)(316002)(40460700003)(478600001)(36860700001)(47076005)(70586007)(36756003)(8676002)(4326008)(70206006)(7416002)(110136005)(41300700001)(44832011)(5660300002)(8936002)(54906003)(956004)(6666004)(82740400003)(2906002)(86362001)(2616005)(82310400005)(107886003)(1076003)(82960400001)(921005)(356005)(83380400001)(16526019)(186003)(336012)(40480700001)(26005)(81166007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:23:54.4002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af70b20-eb12-4ea3-0988-08da84f194cc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3090
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
  - update Kconfig as well
  - drop chip names from comment in driver header
  - add manufacturer check for Fintek again, Nuvoton not possible
  - drop revision printing for Nuvoton
  - restructure defines again
  - add new model 427G

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

Henning Schild (5):
  gpio-f7188x: Add GPIO support for Nuvoton NCT6116
  gpio-f7188x: use unique labels for banks/chips
  leds: simatic-ipc-leds-gpio: add new model 227G
  platform/x86: simatic-ipc: enable watchdog for 227G
  platform/x86: simatic-ipc: add new model 427G

 drivers/gpio/Kconfig                          |   3 +-
 drivers/gpio/gpio-f7188x.c                    | 229 +++++++++++-------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
 drivers/platform/x86/simatic-ipc.c            |  10 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   2 +
 6 files changed, 194 insertions(+), 93 deletions(-)

-- 
2.35.1

