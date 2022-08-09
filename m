Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15D558DABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiHIPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbiHIPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:04:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989881CB16;
        Tue,  9 Aug 2022 08:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miSfgTii1EJMpwncZvw2aJuOmEUdLDFFxtq1Nee3B5HtUkpFROcKjeirJnmyfnzdiSxs1gin60Tc0cTRy2RV2c+s68iD0rwJOQ1yFiKeKCQEG2XuqqMkOZZKOQqC4pycK7Bi7D4LU8mpoXEkIKj5BTQe460g5TNjU+rucmbP8eU0Np6pGGJ8ZEPefeTsTWz/5y2iVZdbK3jTCgbrfIBktOsdXjv/5fp9fD9XFk0oAAdK59I3P1hfBSIlwietcyocvPhIJ7tprmaAi+hvWKcuJROq8QwnH6H4MY3xFbygNgfh4vdCteWQoDzKVznY/JpslHpL7SJ5NfOIKm9J/e0HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WJasNUV2L2QtCnbD92q4EoewA1BmXKQSJ+uq+be4uo=;
 b=Crhiu4P5+g4MbdyLVsly0j82pNP0UzwsVpBsTqMjI6ByaM+lgKvbC4yw9P944fbTvHJxNLhkRsVvrS414rTl0915WJIYIctke6G5bQvg4zqRJR+2az0iRPPigwpgqy8l1lZ8rwI5Bx1YclVsV48mxUk4PKFRwT7h+NT30+atHG+HvFF32Oa+QME9QVIQsooUzmSqwx8Cwtrq+QTejvtTG3BWj2WAS4u+guoqw+Pmt7GTxePtydI7HTdu3pfCNXM7GFzohxx1iHj22Rqqu+usBHjOX1Q91jOgzOHxMgsDQbu1kWHzVJ3/Cmk8Covu1KzvFxkScchTuQSaY9AH2/RDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WJasNUV2L2QtCnbD92q4EoewA1BmXKQSJ+uq+be4uo=;
 b=K6WNfb9i9PSCJmyD+ZZtHyyQV0trs6MDgpGsqNDSlpViqZ3hH0snflwr70sqPkuG3ejhTituZq5qq/cNRjaUaPy5DsrNFhg/A9U5EjUHcu+qfdTQpj/qGZXALy6Q8BZu6ljVABqTiRmC5fRJsSO000Gl1SlyXWGwUC3cFhKzgf2kogIJA60BHJPK74td+AoQq5qjHWbGGfRp43nc0lZa1/sDHE3f75nE0laI8R1HzasoSC2OcL7FRFv3m/5UCOY3RPyASxpvPERPbbZ1fg0MwWuZN3Yd/ilJwCvZcoeSdUdnk7dL1wu8/+SyIRPOLiMZJir5JZGK1+mv1y+iqmbZbQ==
Received: from DB8PR09CA0028.eurprd09.prod.outlook.com (2603:10a6:10:a0::41)
 by DB8PR10MB3909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 15:04:53 +0000
Received: from DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::49) by DB8PR09CA0028.outlook.office365.com
 (2603:10a6:10:a0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 15:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT026.mail.protection.outlook.com (10.152.5.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:04:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 9 Aug 2022 17:04:52 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 17:04:52 +0200
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
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/4] add support for another simatic board
Date:   Tue, 9 Aug 2022 17:04:38 +0200
Message-ID: <20220809150442.3525-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.801800-8.000000
X-TMASE-MatchedRID: sTEkyVzuJdiY5cvP7IrCct/XEatydg+PIWERHkBDPUm5kFk6DtF9fy+7
        N1Fn6XdzHWtVZN0asTh42s15z/uIuCWRqpXdALNesgjvvqwSJa6fl1eN3IN3K7dHEv7sR/OwSri
        C59qdEjIm3tlnC/E6VDDHxnr5pBtw1bNT+YxZ+GBF0kv+vQOmAMK8bCqGv6ntkwgo9duuWhem7E
        UWk2jS0UpZP1CipW5jJmV7j1WQqoeqLUinaN4ZqjVq4vGUB5lA+JollBGk0D620BbG4zmyXnhcs
        0GMz0PkWAuSz3ewb23iuX4UcbdWgPXMGxI4gvmggiZ0yHR8kZPbS0m47m6fSgPZZctd3P4BjWP6
        asaL88XtcZYGmyEIb6PFjJEFr+olwXCBO/GKkVqOhzOa6g8KrWyOGF7AbJ5PW13ZtKWiBT2ONK2
        tYsaZbAuDLu8isB83bL64S5X6AkI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.801800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: EA810A98827D0B36A6ECC409DB77399FA9A5B61731BCB687C4BD7C7BBABF1FEF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6635c1c9-d115-46b7-e3c0-08da7a1883cd
X-MS-TrafficTypeDiagnostic: DB8PR10MB3909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOs4L463N1Efo+Ngl7KLEusUsEFff6voGOdB9SM/OskV6MIt+eC+QCyz0qZLV8eS3IjxNHBP2kDXEKxAmh09VM/PlPR+qMlfGDa15iMiqxOU+OOdTTd/HSg1zVJtRrl3bPqkOBhsBpmMV6h9dTyrEZdAZZEphhvbeKfqFskAjtkgMGX3EYNY4wm02r2BuZ8/pWM69zPv+LmOzT+zPKT2FWyB92pnRhYKW4cd2VzRwo3IBB1taMqZeAUQpO9Kk8slGB7Wo7j1CJp53CHyMhprFZyvcnVKI1m7PYKIqvjEdD7fRUPyCLyGSF+JvBXhr7WJmLJYn0nBpGirjLQOpa+lTnF5+c9MIO8yVHppKO70FLIqCQjGHCf/ksrIfBQPPuCoIRVTbOwK5GgKJvI4IymJhlTHQ6ZTaaYml+Ccak5JeI/R5aig+XNMkmWusHmhrjeoQjHYeZdpIEhUxrPddkjitNvHUUgk6ClAu+D50yINxkJoCc7RI3WHXAKK5wjaz4XbBNU6GwZ7CQLX47zwqcy0Rxmm90T4WFkbsYsOl37xc/V77sfsqPUsepBsSJIXYiC7ChJ7jOuFg/uZauOBQ/MfgpQ3Eqn7EmtognYa1gkbctjzxvX/74Zu49AN6wZDOhr2e6VX3mNBRaR/HL5IV+NaLAOnBkj7uzOtsEX572lehsR8iT60jOtwzHEP7hqfG01F2l9Sl6edSrzwq3Kncs9ltZxgzjTWKjDea8BLdBE0tg83PGuTk4TrKYb0fi8UyBAXfr2Gm5Iprv42ijEje400pcWYnj3RrhxAockM8yThCQEPSm+Lw9FuHubktRUrDDZODGWzYMnBQWdmzcKtB8X9Hq0hieefw2SBqbR3wregDA+KWPug+ddvuJVoeCuHytRJEvkxV0uCR+cMRxdR6szDPw==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(1076003)(26005)(336012)(40480700001)(186003)(107886003)(8676002)(4326008)(316002)(956004)(70206006)(82740400003)(70586007)(16526019)(2616005)(36756003)(41300700001)(2906002)(478600001)(82960400001)(86362001)(6666004)(40460700003)(81166007)(82310400005)(356005)(921005)(36860700001)(8936002)(44832011)(5660300002)(110136005)(54906003)(7416002)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:04:53.4833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635c1c9-d115-46b7-e3c0-08da7a1883cd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 drivers/gpio/gpio-f7188x.c                    | 192 ++++++++++--------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   1 +
 5 files changed, 157 insertions(+), 86 deletions(-)

-- 
2.35.1

