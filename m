Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BED5843B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiG1P5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiG1P5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:57:10 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1752DC0;
        Thu, 28 Jul 2022 08:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+rUz0kQfkRBnWs3aBYklu0rjuIQTk0f/yl+LM/BwGyhTpQIeKEF0OqwfFijfWR/sXeL45ZW4meC72myK54SECmDt52JsDpPBfQ6/NqOCER02FDpfCds7D6qnBEHzF7STvZE3+uamWTL5I5epHAGmSOPXP9Rtil7P5B1zl3P30TgWp+nQ+1ZEOkYnMFruAhQHa7TjmPyqlhInMeFPO2JisiWrACJXczFQPoHsuwDG6e4dalyYSa00rCug/8UoAUD/rji1/sS4oNcxmqP0OQthLewtYmFT6dVOR9I9dpLQSB8m546j10TllJFen9XU3yd63ChghwTHdvJnrPDsOTmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzJLW1sJJ9F+C0yoiu1TH4xOnwzLpgWma64U8WXrRm0=;
 b=dRPfrq+I4jgTgDcif+OmFVj9Utf0DgfjQond08Du7DaP1QWA9nd6koVdGU/JRbhrCKi0DDv00Ewtuz/X49EcZKh2UwhWb1dWEtM0zfG1cZIQll2qx5avx8pba/0f6ZJs7K7XFe8nwaQRdBO9B8Ddq8KqHuHhrWP42a0kCB0TyiOaa1ViCjpYzEq0U8OoYFiOVZPoBnEyWVPvP4OqGETf2/t8z6UE6ns5xK/OD4UOMj+clgpntFE8oNkB0ZIP7n+RCaBrAZR7yKDbNlXR7wZyki7qornq5aTQxZ9HE0XRFfRxvtpufZ8Z6acz7/iKg/c+7AR5vBTkggmePMpfH8IWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzJLW1sJJ9F+C0yoiu1TH4xOnwzLpgWma64U8WXrRm0=;
 b=nhxHxjvtmZKr9tkGIo3KQXquR1a/vu1ScvBPneg+J0HMgwzoiTL2FZGX61QC95tmMXDlKaE4bsPKR6NJ7gR8EHKDYVKRYnXBOOdrBBtjNzh3IaPuTWAJgqNjEkPrQz4Uxn+DbotsSaI9xF3w6unfBUVQXlUpNXXaiY7DDbJt/XyK1GKQlD9Xv+jkbj1j4HZvBYIwsPa+C8S+Ngzuy/+aJsgZmmBk+PALJuvZyhANoRmf3TeJmXXPjOJbX0XAya4YR6ObxFkp+gQlpaDl/LoYdm0+ydbGP5C2GkUZkzh8lxpmW2KZ4uczm1D/8uKPbeDoRGK1ZI102X5p1kYO6rMaFQ==
Received: from DB6PR0301CA0004.eurprd03.prod.outlook.com (2603:10a6:4:3e::14)
 by AM9PR10MB4596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 15:57:03 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::9) by DB6PR0301CA0004.outlook.office365.com
 (2603:10a6:4:3e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Thu, 28 Jul 2022 15:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 15:57:02 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.242) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/4] add support for another simatic board
Date:   Thu, 28 Jul 2022 17:56:48 +0200
Message-ID: <20220728155652.29516-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.242]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719ab18b-69ed-413e-ae3e-08da70b1d00f
X-MS-TrafficTypeDiagnostic: AM9PR10MB4596:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 010HPBnFF35oRidGvagLX39DPHqMDj429vPb6HnFkbF/eADr1qtDJIgRiFgphAhJIlzpLvhw0N1av7MJvKjhNwVnb1UDhbhhep7xvTNC5DUrvfRVOTeoGDrdpor207RaEgVrD1pa9Rokfo63sQ6G4qVZhEtfUTEBy9OsBVBADqPaspJC+gKWjyQls18nZc2soPFk5qJA4h662DeFw2IBjEbnVw+XTzmwA4uWaxftk3/la5oqOSz5VF/DHFHQLjFnRaedtK3cGRdR6Cl1GsPXbeYfdEKpYJJ4vb6ASZajPqb++Q+5CnpnGw5DCfx3YRgm8lEZKcGg54HfJeu3jwOLk44GSU1gsrEaIQzT48POy3HE51LaWWJiebeWBQbuAUWCDc+nVHxvz/yNLFNdB2RI1Kz/VqH7P9r4kTHT96kvplmFGMXnkxSENM4g99bwU4VWvNqy1wKOJpkmZdBsuisRIPW4+y1M2JaERo1F/2JyTr0+yOUFosAcZ9QtOTF7kHRpvxIBdm4qq1fDxLNa4m5LFlNO449pU+VQ3VX5seiFUWZ0Dwn2AOqyPfUlNs/sHd6csL458nDY9C+4isrY7C9gwDlvTcUCi1XL+pkGoIYzzcm5+py1rDNna9JWw2eat8VQXlJ5K6B9peMxGFA95TAPtSSZ5OiFggFFGZy8oqt8Km0j/JlNYIzROGfdt/JSOaDbyXj6LWacXebOqTHI/RBp1Oqn3iTiARfwLX/81bHccmq34OWjSSzXPg1NH0n/sX9KzL1H5+xpnl5kO65Dsu9omD2Z8wK/d+oqY26+xpwXawLZdYBEC/LHKyDlqW58kFJTMA5gvv1WoJNe/08ynIMg6Q==
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(336012)(47076005)(36756003)(186003)(1076003)(16526019)(83380400001)(107886003)(36860700001)(956004)(2616005)(40460700003)(26005)(110136005)(41300700001)(6666004)(478600001)(2906002)(44832011)(5660300002)(81166007)(82960400001)(82740400003)(54906003)(356005)(82310400005)(8936002)(40480700001)(86362001)(316002)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:57:02.7833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ab18b-69ed-413e-ae3e-08da70b1d00f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 drivers/gpio/gpio-f7188x.c                    | 192 +++++++++++-------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   1 +
 5 files changed, 158 insertions(+), 85 deletions(-)

-- 
2.35.1

